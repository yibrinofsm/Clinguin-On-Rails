import base64
import json
import re
from pathlib import Path

from clinguin.server.application.backends import ClingoBackend


class GenericUIBackend(ClingoBackend):

    IMAGE_DIR = Path("img/")

    ALLOWED_EXTENSIONS = {
        ".png",
        ".jpg",
        ".jpeg",
        ".webp",
    }

    MAX_IMAGE_SIZE = 5 * 1024 * 1024  # 5 MB

    def upload_object_image(self, obj, role):
        """
        Store an uploaded image and associate it with an object/role.

        The Angular file_input automatically stores:
          filename
          filecontent

        in the Clinguin context.

        The resulting ASP fact has the form:

            image(track100,cell,"assets/uploads/track100_cell.png")

        """

        # -----------------------------------------------------
        # Read uploaded file from Clinguin context
        # -----------------------------------------------------

        filename = next(
            (
                c.value
                for c in self._context
                if c.key == "filename"
            ),
            None,
        )

        content = next(
            (
                c.value
                for c in self._context
                if c.key == "filecontent"
            ),
            None,
        )

        if not filename:
            raise RuntimeError("No image file was selected.")

        if not content:
            raise RuntimeError(
                "No uploaded image content was found."
            )

        # -----------------------------------------------------
        # Normalize values
        # -----------------------------------------------------

        filename = str(filename).strip('"')
        object_term = str(obj).strip('"')
        role_term = str(role).strip('"')

        # -----------------------------------------------------
        # Validate extension
        # -----------------------------------------------------

        extension = Path(filename).suffix.lower()

        if extension not in self.ALLOWED_EXTENSIONS:
            raise RuntimeError(
                "Unsupported image format. "
                "Use PNG, JPG, JPEG, or WEBP."
            )

        # -----------------------------------------------------
        # Decode binary content
        # -----------------------------------------------------

        try:
            image_bytes = base64.b64decode(
                content,
                validate=True,
            )
        except Exception as exc:
            raise RuntimeError(
                "The uploaded image could not be decoded."
            ) from exc

        # -----------------------------------------------------
        # Validate image size
        # -----------------------------------------------------

        if len(image_bytes) > self.MAX_IMAGE_SIZE:
            raise RuntimeError(
                "The uploaded image exceeds the 5 MB limit."
            )

        # -----------------------------------------------------
        # Basic binary signature validation
        # -----------------------------------------------------

        if extension == ".png":

            if not image_bytes.startswith(
                b"\x89PNG\r\n\x1a\n"
            ):
                raise RuntimeError(
                    "The uploaded file is not a valid PNG."
                )

        elif extension in {".jpg", ".jpeg"}:

            if not image_bytes.startswith(
                b"\xff\xd8\xff"
            ):
                raise RuntimeError(
                    "The uploaded file is not a valid JPEG."
                )

        elif extension == ".webp":

            if (
                len(image_bytes) < 12
                or image_bytes[0:4] != b"RIFF"
                or image_bytes[8:12] != b"WEBP"
            ):
                raise RuntimeError(
                    "The uploaded file is not a valid WEBP."
                )

        # -----------------------------------------------------
        # Build safe server filename
        # -----------------------------------------------------

        self.IMAGE_DIR.mkdir(
            parents=True,
            exist_ok=True,
        )

        safe_object = re.sub(
            r"[^A-Za-z0-9_-]+",
            "_",
            object_term,
        ).strip("_")

        safe_role = re.sub(
            r"[^A-Za-z0-9_-]+",
            "_",
            role_term,
        ).strip("_")

        stored_name = (
            f"{safe_object}_{safe_role}{extension}"
        )

        stored_path = self.IMAGE_DIR / stored_name

        # -----------------------------------------------------
        # Save image bytes
        # -----------------------------------------------------

        stored_path.write_bytes(image_bytes)

        # -----------------------------------------------------
        # Create image(O,R,I)
       
    
        #
        #   image(track100,cell,
        #         "assets/uploads/track100_cell.png")
        # -----------------------------------------------------

        path_term = json.dumps(
            stored_path.as_posix()
        )

        image_atom = (
            f"image("
            f"{object_term},"
            f"{role_term},"
            f"{path_term}"
            f")"
        )

        # -----------------------------------------------------
        # Add the ASP atom
        # -----------------------------------------------------

        self.add_atom(image_atom)

        # -----------------------------------------------------
        # Notify the frontend
        # -----------------------------------------------------

        self._messages.append(
            (
                "Image uploaded",
                f"Added visual for {object_term} "
                f"with role {role_term}.",
                "success",
            )
        )