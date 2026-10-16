# Generic ASP-Driven User Interface with Clinguin

This project provides a generic, ASP-driven interface for creating, inspecting, and visualizing domain instances with [Clinguin](https://clinguin.readthedocs.io/). The same UI can be launched **without a domain-specific instance** or **with an existing domain instance**, such as Flatland.

The interface works with generic ASP predicates for objects, properties, nodes, images, and positions. Domain-specific facts may be loaded from files; additional instance facts can be supplied through UI interactions.

## 1. Running without a domain-specific file

Start the Clinguin client–server application using only the generic validation file:

```bash
clinguin client-server \
  --domain-files domain-files/generic/generic_validation.lp \
  --ui-files ui-files/ui_presentation.lp \
  --custom-classes domain-files/generic_ui_backend.py \
  --backend GenericUIBackend
```

In this mode, **no Flatland or other domain-specific instance is loaded**. The UI can be used to create objects interactively, rather than relying on predefined `object/2` facts.

### Example: create two robots

Use the object-creation interface to add:

```prolog
object(robot1,robot).
object(robot2,robot).
```

Then:

1. Find `robot1` in the object list and open its **Inspect** view.
2. Open the `img/robot/` folder and choose an image for `robot1`. In the image-upload area, enter the **role** associated with the image (for example, 'body'), select that image file, and upload it.
3. Inspect `robot2`, choose another image from `img/robot/`, enter its role, and upload it. The second robot can use the same role name but a different image.

Conceptually, the resulting image associations have the form:

```prolog
image(robot1,start,"path/to/robot1-image.png").
image(robot2,start,"path/to/robot2-image.png").
```

The robot image files used in this example can be found in **`img/robot/`**.  The image role is supplied manually because no domain-specific `type_role/2` declarations are loaded.


## 2. Running with a Flatland domain instance

Start the same UI while loading the Flatland program as an additional domain file:

```bash
clinguin client-server \
  --domain-files domain-files/generic/generic_validation.lp domain-files/flatland/flatland.lp \
  --ui-files ui-files/ui_presentation.lp \
  --custom-classes domain-files/generic_ui_backend.py \
  --backend GenericUIBackend
```

Here, `domain-files/flatland/flatland.lp` supplies the Flatland-specific information to the UI. The generic interface can inspect and visualize relevant facts from the loaded instance, while the generic validation rules continue to operate on the shared representation.



## 3. Generic representation

The key instance predicates are:

| Predicate | Purpose | Example |
|---|---|---|
| `object(O,T)` | Declares object `O` of type `T` | `object(robot1,robot).` |
| `property(O,P,V)` | Associates property `P` and value `V` with `O` | `property(robot1,speed,1).` |
| `node(N)` | Declares a node (often a grid coordinate) | `node((0,0)).` |
| `image(O,R,Path)` | Associates an image with object `O` in role `R` | `image(robot1,body,"robot.png").` |
| `position(N,R,O)` | Places object `O` at node `N` under role `R` | `position((0,0),body,robot1).` |




### `domain-files/generic/generic_validation.lp`

This file contains generic validation, counting, and completeness rules based on instance and schema facts, rather than on the currently selected UI object. Its  include:

- Checking the existence of objects and nodes.
- Counting objects, types, images, and positions.
- Identifying missing required properties declared through `type_property/4`.
- Identifying missing images for roles declared through `type_role/2` **when the corresponding missing-image rule is included**.
- Deriving object completion status, such as `complete(O,T)` and `incomplete(O,T)`.


### `generic_ui_context_validation.lp`

This file contain rules that depend on the **current Clinguin UI context**, such as the object or role selected for an operation. It should be distinguished from the general instance validation in `generic_validation.lp`.


## References

- [ASP-driven User-interaction with Clinguin (paper)](https://arxiv.org/abs/2502.09222)
- [Clinguin documentation](https://clinguin.readthedocs.io/)