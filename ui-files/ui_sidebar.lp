% Sidebar Header
elem(sidebar_header,container,sidebar_panel).
attr(sidebar_header,order,1).
attr(sidebar_header,class,("d-flex";"flex-column";"gap-1";"p-3";"bg-dark";"text-white")).

% Sidebar Title
elem(sidebar_title,label,sidebar_header).
attr(sidebar_title,order,1).
attr(sidebar_title,label,"Object Catalogue").
attr(sidebar_title,class,("fw-bold";"fs-5";"text-white")).

% Sidebar Subtitle

elem(sidebar_subtitle,label,sidebar_header).
attr(sidebar_subtitle,order,2).
attr(sidebar_subtitle,label,"Select an object to place it on the grid.").
attr(sidebar_subtitle,class,("small";"text-light")).

% Summary
elem(summary,container,sidebar_panel).
attr(summary,order,2).
attr(summary,child_layout,grid).
attr(summary,class,("d-grid";"gap-2";"p-3";"bg-white")).

% Summary Tile

attr(summary_tile(I),order,I) :- elem(summary_tile(I),container,summary).
attr(summary_tile(I),grid_row,I/2+1) :- elem(summary_tile(I),container,summary).

 
% Summary Objects
elem(summary_tile(0),container,summary).
attr(summary_tile(0),grid_column,1).
attr(summary_tile(0),class,("bg-light";"border";"rounded-2";"px-2";"py-2")).


elem(summary_objects,label,summary_tile(0)).
attr(summary_objects,order,1).
attr(summary_objects,label,@concat("Objects · ",N)) :- N=#count{O:object(O,_)}.
attr(summary_objects,class,("small";"fw-bold";"text-secondary")).

%  % Summary Properties
elem(summary_tile(1),container,summary).
attr(summary_tile(1),grid_column,2).
attr(summary_tile(1),class,("bg-light";"border";"rounded-2";"px-2";"py-2")).


elem(summary_properties,label,summary_tile(1)).
attr(summary_properties,order,1).
attr(summary_properties,label,@concat("Properties · ",N)) :- N=#count{O,K,V:property(O,K,V)}.
attr(summary_properties,class,("small";"fw-bold";"text-secondary")).


% Summary Positions 
elem(summary_tile(2),container,summary).
attr(summary_tile(2),grid_column,1).
attr(summary_tile(2),class,("bg-light";"border";"rounded-2";"px-2";"py-2")).


elem(summary_positions,label,summary_tile(2)).
attr(summary_positions,order,1).
aattr(summary_positions,class,("small";"fw-bold";"text-secondary")).
attr(summary_positions,label,@concat("Positions · ",N)) :- N=#count{Node,R,O:elem(placement(Node,R,O),container,_)}.

% Summary Edits
elem(summary_tile(3),container,summary).
attr(summary_tile(3),grid_column,2).
attr(summary_tile(3),class,("bg-light";"border";"rounded-2";"px-2";"py-2")).

elem(summary_edits,label,summary_tile(3)).
attr(summary_edits,order,1).
attr(summary_edits,label,@concat("Edits · ",N)) :- A=#count{X:_clinguin_atom(X)},B=#count{M,O,T:_clinguin_atom(request(M,O,T))},N=A-B.
attr(summary_edits,class,("small";"fw-bold";"text-secondary")).


% Nodes
elem(summary_tile(4),container,summary).
attr(summary_tile(4),grid_column,1).
attr(summary_tile(4),class,("bg-light";"border";"rounded-2";"px-2";"py-2")).

elem(summary_nodes,label,summary_tile(4)).
attr(summary_nodes,order,1).
attr(summary_nodes,label,@concat("Nodes · ",N)) :- N=#count{X:node(X)}.
attr(summary_nodes,class,("small";"fw-bold";"text-secondary")).

% Object Catalogue
elem(object_catalogue,container,sidebar_panel).
attr(object_catalogue,order,3).
attr(object_catalogue,class,("d-flex";"flex-column";"border-top";"mw-100")).


% Toolbar
elem(toolbar_catalogue,container,object_catalogue).
attr(toolbar_catalogue,order,1).
attr(toolbar_catalogue,flex_direction,row).
attr(toolbar_catalogue,class,("d-flex";"flex-row";"align-items-center";"justify-content-between";"gap-3";"px-3";"py-2")).

%  Heading
elem(heading_catalogue,label,toolbar_catalogue).
attr(heading_catalogue,order,1).
attr(heading_catalogue,label,"AVAILABLE OBJECTS").
attr(heading_catalogue,class,("small";"fw-bold";"text-secondary";"text-uppercase")).

% Add Object Button
elem(add_object,button,toolbar_catalogue).
attr(add_object,order,2).
attr(add_object,icon,"fa-plus").
attr(add_object,label,"Add object").
attr(add_object,class,"btn-primary").
when(add_object,click,context,(dialog,form(add_object))).
when(add_object,click,update,(dialog(form(add_object)),visibility,shown)).
when(add_object,click,update,(local_feedback,visibility,hidden)).

% Empty Catalogue Message
elem(catalogue_empty,label,object_catalogue) :- not object(_,_).
attr(catalogue_empty,order,2) :- not object(_,_).
attr(catalogue_empty,label,"No objects available. Create an object to begin.") :- not object(_,_).
attr(catalogue_empty,class,("p-4";"text-muted";"text-center")) :- not object(_,_).

% Catalogue List
elem(catalogue_list,container,object_catalogue) :- object(_,_).
attr(catalogue_list,order,2) :- object(_,_).
attr(catalogue_list,height,500) :- elem(catalogue_list,container,_).
attr(catalogue_list,class,("d-flex";"flex-column";"gap-2";"overflow-auto";"px-2";"pb-3";"mw-100")) :- object(_,_).

% Object Type Group
elem(type_group(T),container,catalogue_list) :- object(_,T).
attr(type_group(T),order,N) :- object(_,T),N=#count{T2:object(_,T2),T2<T}.
attr(type_group(T),class,("d-flex";"flex-column";"gap-2";"mw-100")) :- object(_,T).

% Type Heading
elem(type_heading(T),container,type_group(T)) :- object(_,T).
attr(type_heading(T),order,1) :- object(_,T).
attr(type_heading(T),flex_direction,row) :- object(_,T).
attr(type_heading(T),class,("d-flex";"flex-row";"align-items-center";"justify-content-between";"px-1";"pt-1")) :- object(_,T).

% Type Title
elem(type_title(T),label,type_heading(T)) :- object(_,T).
attr(type_title(T),order,1) :- object(_,T).
attr(type_title(T),label,@concat("Type(",T,")"," · ",N,"objects")) :- object(_,T),N=#count{O:object(O,T)}.
attr(type_title(T),class,("small";"fw-bold";"text-secondary";"text-capitalize")) :- object(_,T).

% Objects Within Each Type
elem(type_items(T),container,type_group(T)) :- object(_,T).
attr(type_items(T),order,2) :- object(_,T).
attr(type_items(T),class,("d-flex";"flex-column";"gap-2";"mw-100")) :- object(_,T).

% Object Card
elem(object_card(O,T),container,type_items(T)) :- object(O,T).
attr(object_card(O,T),order,N+10) :- object(O,T),N=#count{Other:object(Other,T),Other<O}.
attr(object_card(O,T),flex_direction,row) :- object(O,T).
attr(object_card(O,T),class,("d-flex";"flex-row";"flex-wrap";"align-items-center";"gap-2";"p-2";"border";"rounded-3";"mw-100")) :- object(O,T).
attr(object_card(O,T),background_color,"white") :- object(O,T),not _clinguin_context(selected_object_for_placement,O).
attr(object_card(O,T),background_color,"#e9ecef") :- object(O,T),_clinguin_context(selected_object_for_placement,O).
attr(object_card(O,T),background_color,"#fff3cd") :- object(O,T),_clinguin_context(selected_for_inspection,O),_clinguin_context(inspect_modal_open,true).
attr(object_card(O,T),class,("border-warning";"border-2";"shadow-sm")) :- object(O,T),_clinguin_context(selected_for_inspection,O),_clinguin_context(inspect_modal_open,true).
attr(object_card(O,T),class,("border-primary";"border-2";"shadow-sm")) :- object(O,T),_clinguin_context(selected_object_for_placement,O),not issue(O,error,_,_).
attr(object_card(O,T),class,"border-danger") :- object(O,T),issue(O,error,_,_).
attr(object_card(O,T),on_hover,true) :- object(O,T),not _clinguin_context(selected_object_for_placement,O).
attr(object_card(O,T),on_hover_background_color,"#e9ecef") :- object(O,T),not _clinguin_context(selected_object_for_placement,O).

% Object Preview 
elem(object_preview(O,T),container,object_card(O,T)) :- elem(object_media(O,T),canvas,_).
attr(object_preview(O,T),order,1) :- elem(object_preview(O,T),container,_).
attr(object_preview(O,T),width,40) :- elem(object_media(O,T),canvas,_).
attr(object_preview(O,T),height,40) :- elem(object_media(O,T),canvas,_).
attr(object_preview(O,T),class,("d-flex";"align-items-center";"justify-content-center";"flex-shrink-0";"p-0";"m-0";"overflow-hidden")) :- elem(object_preview(O,T),container,_).

% Object Media
elem(object_media(O,T),canvas,object_preview(O,T)) :- object(O,T),image(O,R,I).
attr(object_media(O,T),order,1) :- elem(object_media(O,T),canvas,_).
attr(object_media(O,T),image,I) :- object(O,T),image(O,R,I).
attr(object_media(O,T),width,40) :- elem(object_media(O,T),canvas,_).
attr(object_media(O,T),class,"flex-shrink-0") :- elem(object_media(O,T),canvas,_).

% Object Information 
elem(object_info(O,T),container,object_card(O,T)) :- object(O,T).
attr(object_info(O,T),order,2) :- object(O,T).
attr(object_info(O,T),class,("d-flex";"flex-column";"gap-1";"flex-grow-1";"mw-100")) :- object(O,T).

% Object Identifiers
elem(object_body(O,T),label,object_info(O,T)) :- object(O,T).
attr(object_body(O,T),order,1) :- object(O,T).
attr(object_body(O,T), label,@concat("object(", O, ", ", T, ")")) :-object(O,T).
attr(object_body(O,T),class,("small";"fw-bold";"text-dark")) :- object(O,T).


% Object Action Buttons
elem(object_actions(O,T),container,object_card(O,T)) :- object(O,T).
attr(object_actions(O,T),order,3) :- object(O,T).
attr(object_actions(O,T),flex_direction,row) :- object(O,T).
attr(object_actions(O,T),class,("d-flex";"flex-row";"flex-wrap";"align-items-center";"gap-1")) :- object(O,T).

% Select Object Button
elem(object_select(O,T),button,object_actions(O,T)) :- object(O,T).
attr(object_select(O,T),order,1) :- object(O,T).
attr(object_select(O,T),label,"Select") :- object(O,T),not _clinguin_context(selected_object_for_placement,O).
attr(object_select(O,T),label,"Selected") :- object(O,T),_clinguin_context(selected_object_for_placement,O).
attr(object_select(O,T),class,"btn-outline-primary") :- object(O,T),not _clinguin_context(selected_object_for_placement,O).
attr(object_select(O,T),class,"btn-primary") :- object(O,T),_clinguin_context(selected_object_for_placement,O).
when(object_select(O,T),click,context,(selected_object_for_placement,O)) :- object(O,T).
when(object_select(O,T),click,context,(selected_role_for_placement,R)) :- object(O,T),role(O,R).
when(object_select(O,T),click,call,()) :- object(O,T).

% Inspect Object Button

elem(object_inspect(O,T),button,object_actions(O,T)) :- object(O,T).
attr(object_inspect(O,T),order,2) :- object(O,T).
attr(object_inspect(O,T),label,"Inspect") :- object(O,T),not _clinguin_context(selected_for_inspection,O).
attr(object_inspect(O,T),class,"btn-outline-primary") :- object(O,T),not _clinguin_context(selected_for_inspection,O).
attr(object_inspect(O,T),label,"Inspecting"):-object(O,T),_clinguin_context(selected_for_inspection,O),_clinguin_context(inspect_modal_open,true).
attr(object_inspect(O,T),class,"btn-primary"):-object(O,T),_clinguin_context(selected_for_inspection,O),_clinguin_context(inspect_modal_open,true).
when(object_inspect(O,T),click,context,(selected_for_inspection,O)) :- object(O,T).
when(object_inspect(O,T),click,context,(inspect_modal_open,true)):-object(O,T).
when(object_inspect(O,T),click,update,(dialog(inspector),visibility,shown)):-object(O,T).
when(object_inspect(O,T),click,call,()) :- object(O,T).

% Delete Object Button

elem(object_delete(O,T),button,object_actions(O,T)) :- object(O,T),_clinguin_atom(object(O,T)).
attr(object_delete(O,T),order,3) :- elem(object_delete(O,T),button,_).
attr(object_delete(O,T),label,"Delete") :- elem(object_delete(O,T),button,_).
attr(object_delete(O,T),class,"btn-outline-danger") :- elem(object_delete(O,T),button,_).
when(object_delete(O,T),click,context,(delete_object,O)) :- elem(object_delete(O,T),button,_).


% Catalogue Footer

elem(footer_sidebar_panel,label,sidebar_panel).
attr(footer_sidebar_panel,order,4).
attr(footer_sidebar_panel,label,"Inspect opens object details").
attr(footer_sidebar_panel,class,("small";"text-secondary";"bg-light";"border-top";"px-3";"py-2")).

% Inspector Dialog
elem(dialog(inspector),modal,w) :- object(O,_),_clinguin_context(selected_for_inspection,O),_clinguin_context(inspect_modal_open,true).
attr(dialog(inspector),visibility,shown) :- object(O,_),_clinguin_context(selected_for_inspection,O),_clinguin_context(inspect_modal_open,true),not elem(commit(_,_,_),container,w).
attr(dialog(inspector),title,@concat("Object inspector · ",O)) :- object(O,_),_clinguin_context(selected_for_inspection,O),_clinguin_context(inspect_modal_open,true).

% Content
elem(inspector_content,container,dialog_sheet(inspector)) :- object(O,_),_clinguin_context(selected_for_inspection,O),_clinguin_context(inspect_modal_open,true).
attr(inspector_content,class,("d-flex";"flex-column";"gap-3";"p-4";"overflow-auto")) :- object(O,_),_clinguin_context(selected_for_inspection,O),_clinguin_context(inspect_modal_open,true).
attr(inspector_content,class,"overflow-auto") :- elem(inspector_content,container,_).

% Inspector Object Identity

elem(inspector_identity,label,inspector_content) :- object(O,_),_clinguin_context(selected_for_inspection,O),_clinguin_context(inspect_modal_open,true).
attr(inspector_identity,order,1) :- elem(inspector_identity,label,_).
attr(inspector_identity,label,@concat("object(",O,", ",T,")")) :- object(O,T),_clinguin_context(selected_for_inspection,O),_clinguin_context(inspect_modal_open,true).
attr(inspector_identity,class,("font-monospace";"fw-bold";"text-primary")) :-object(O,T),_clinguin_context(selected_for_inspection,O),_clinguin_context(inspect_modal_open,true).


% Inspector Images Section
elem(images_section,container,inspector_content) :- object(O,_),_clinguin_context(selected_for_inspection,O),_clinguin_context(inspect_modal_open,true).
attr(images_section,order,2):-object(O,_),_clinguin_context(selected_for_inspection,O),_clinguin_context(inspect_modal_open,true).
attr(images_section,class,("d-flex";"flex-column";"gap-2";"border";"rounded-3";"p-2")) :- object(O,_),_clinguin_context(selected_for_inspection,O),_clinguin_context(inspect_modal_open,true).

% Images Section Title
elem(images_title,label,images_section) :- object(O,_),_clinguin_context(selected_for_inspection,O),_clinguin_context(inspect_modal_open,true).
attr(images_title,order,0) :- elem(images_title,label,_).
attr(images_title,label,"Images") :- object(O,_),_clinguin_context(selected_for_inspection,O),_clinguin_context(inspect_modal_open,true).
attr(images_title,class,"fw-bold") :- object(O,_),_clinguin_context(selected_for_inspection,O),_clinguin_context(inspect_modal_open,true).

% Add Image Button
elem(add_image,button,images_section) :- object(O,_),_clinguin_context(selected_for_inspection,O),_clinguin_context(inspect_modal_open,true),0=#count{I:image(O,R,I)}.
attr(add_image,order,1) :- elem(add_image,button,_).
attr(add_image,label,"Add Image") :- object(O,_),_clinguin_context(selected_for_inspection,O),_clinguin_context(inspect_modal_open,true),0=#count{I:image(O,R,I)}.
attr(add_image,class,("btn-primary";"align-self-end")) :- object(O,_),_clinguin_context(selected_for_inspection,O),_clinguin_context(inspect_modal_open,true),0=#count{I:image(O,R,I)}.
when(add_image,click,context,(dialog,form(add_image))) :- object(O,_),_clinguin_context(selected_for_inspection,O),_clinguin_context(inspect_modal_open,true),0=#count{I:image(O,R,I)}.
when(add_image,click,update,(dialog(form(add_image)),visibility,shown)) :- object(O,_),_clinguin_context(selected_for_inspection,O),_clinguin_context(inspect_modal_open,true),0=#count{I:image(O,R,I)}.
when(add_image,click,update,(local_feedback,visibility,hidden)) :- object(O,_),_clinguin_context(selected_for_inspection,O),_clinguin_context(inspect_modal_open,true),0=#count{I:image(O,R,I)}.

% Empty Images Message
elem(images_empty,label,images_section) :- object(O,_),_clinguin_context(selected_for_inspection,O),_clinguin_context(inspect_modal_open,true),0=#count{R,I:image(O,R,I),I!="",I!=" "}.
attr(images_empty,order,2) :- elem(images_empty,label,_).
attr(images_empty,label,"Empty image paths.") :- elem(images_empty,label,_).

% Image Row

elem(image_row(O,R,I),container,images_section) :- object(O,_),_clinguin_context(selected_for_inspection,O),_clinguin_context(inspect_modal_open,true),image(O,R,I),I!="",I!=" ".
attr(image_row(O,R,I),order,N+10) :- elem(image_row(O,R,I),container,images_section),N=#count{R2,I2:elem(image_row(O,R2,I2),container,images_section),(R2,I2)<(R,I)}.
attr(image_row(O,R,I),class,("d-flex";"gap-2";"align-items-center";"border";"rounded-2";"flex-wrap";"p-2")) :- object(O,_),_clinguin_context(selected_for_inspection,O),_clinguin_context(inspect_modal_open,true),image(O,R,I),I!="",I!=" ".
attr(image_row(O,R,I),flex_direction,row) :- elem(image_row(O,R,I),container,_).

% Inspector Image Preview Frame

elem(image_preview_frame(O,R,I),container,image_row(O,R,I)) :- elem(image_preview(O,R,I),canvas,_).
attr(image_preview_frame(O,R,I),order,0) :- elem(image_preview_frame(O,R,I),container,_).
attr(image_preview_frame(O,R,I),width,38) :- object(O,_),_clinguin_context(selected_for_inspection,O),_clinguin_context(inspect_modal_open,true),image(O,R,I),I!="",I!=" ".
attr(image_preview_frame(O,R,I),height,38) :- object(O,_),_clinguin_context(selected_for_inspection,O),_clinguin_context(inspect_modal_open,true),image(O,R,I),I!="",I!=" ".
attr(image_preview_frame(O,R,I),class,("d-flex";"align-items-center";"justify-content-center";"flex-shrink-0";"p-0";"m-0";"overflow-hidden")) :- elem(image_preview_frame(O,R,I),container,_).

% Inspector Image Preview
elem(image_preview(O,R,I),canvas,image_preview_frame(O,R,I)) :- object(O,_),_clinguin_context(selected_for_inspection,O),_clinguin_context(inspect_modal_open,true),image(O,R,I),I!="",I!=" ".
attr(image_preview(O,R,I),order,0) :- elem(image_preview(O,R,I),canvas,_).
attr(image_preview(O,R,I),image,I) :- object(O,_),_clinguin_context(selected_for_inspection,O),_clinguin_context(inspect_modal_open,true),image(O,R,I),I!="",I!=" ".
attr(image_preview(O,R,I),class,("d-block";"w-100";"h-100";"p-0";"m-0")) :- elem(image_preview(O,R,I),canvas,_).
attr(image_preview(O,R,I),width,38) :- elem(image_preview(O,R,I),canvas,_).
attr(image_preview(O,R,I),height,38) :- elem(image_preview(O,R,I),canvas,_).

% Image Details
elem(image_text(O,R,I),label,image_row(O,R,I)) :- object(O,_),_clinguin_context(selected_for_inspection,O),_clinguin_context(inspect_modal_open,true),image(O,R,I),I!="",I!=" ".
attr(image_text(O,R,I),order,1) :- elem(image_text(O,R,I),label,_).
attr(image_text(O,R,I),label,@concat(R," · ",I)) :- object(O,_),_clinguin_context(selected_for_inspection,O),_clinguin_context(inspect_modal_open,true),image(O,R,I),I!="",I!=" ".
attr(image_text(O,R,I),class,("font-monospace";"small";"flex-grow-1")) :- object(O,_),_clinguin_context(selected_for_inspection,O),_clinguin_context(inspect_modal_open,true),image(O,R,I),I!="",I!=" ".




% Edit Image Button
% Open the form and store the original and replacement values in context.

elem(edit_image(O,R,I),button,image_row(O,R,I)) :- object(O,_),_clinguin_context(selected_for_inspection,O),_clinguin_context(inspect_modal_open,true),image(O,R,I),I!="",I!=" ",_clinguin_atom(image(O,R,I)).
attr(edit_image(O,R,I),order,2) :- elem(edit_image(O,R,I),button,_).
attr(edit_image(O,R,I),label,"Edit") :- object(O,_),_clinguin_context(selected_for_inspection,O),_clinguin_context(inspect_modal_open,true),image(O,R,I),I!="",I!=" ",_clinguin_atom(image(O,R,I)).
attr(edit_image(O,R,I),class,"btn-outline-primary") :- object(O,_),_clinguin_context(selected_for_inspection,O),_clinguin_context(inspect_modal_open,true),image(O,R,I),I!="",I!=" ",_clinguin_atom(image(O,R,I)).
when(edit_image(O,R,I),click,context,(dialog,form(edit_image))) :- object(O,_),_clinguin_context(selected_for_inspection,O),_clinguin_context(inspect_modal_open,true),image(O,R,I),I!="",I!=" ",_clinguin_atom(image(O,R,I)).
when(edit_image(O,R,I),click,update,(dialog(form(edit_image)),visibility,shown)) :- object(O,_),_clinguin_context(selected_for_inspection,O),_clinguin_context(inspect_modal_open,true),image(O,R,I),I!="",I!=" ",_clinguin_atom(image(O,R,I)).
when(edit_image(O,R,I),click,update,(local_feedback,visibility,hidden)) :- object(O,_),_clinguin_context(selected_for_inspection,O),_clinguin_context(inspect_modal_open,true),image(O,R,I),I!="",I!=" ",_clinguin_atom(image(O,R,I)).
when(edit_image(O,R,I),click,context,(edit_image_object,O)) :- object(O,_),_clinguin_context(selected_for_inspection,O),_clinguin_context(inspect_modal_open,true),image(O,R,I),I!="",I!=" ",_clinguin_atom(image(O,R,I)).
when(edit_image(O,R,I),click,context,(edit_image_role,R)) :- object(O,_),_clinguin_context(selected_for_inspection,O),_clinguin_context(inspect_modal_open,true),image(O,R,I),I!="",I!=" ",_clinguin_atom(image(O,R,I)).
when(edit_image(O,R,I),click,context,(edit_image_path,I)) :- object(O,_),_clinguin_context(selected_for_inspection,O),_clinguin_context(inspect_modal_open,true),image(O,R,I),I!="",I!=" ",_clinguin_atom(image(O,R,I)).

% Delete Image Button
elem(image_remove(O,R,I),button,image_row(O,R,I)) :- object(O,_),_clinguin_context(selected_for_inspection,O),_clinguin_context(inspect_modal_open,true),image(O,R,I),I!="",I!=" ",_clinguin_atom(image(O,R,I)).
attr(image_remove(O,R,I),order,3) :- elem(image_remove(O,R,I),button,_).
attr(image_remove(O,R,I),label,"Delete") :- object(O,_),_clinguin_context(selected_for_inspection,O),_clinguin_context(inspect_modal_open,true),image(O,R,I),I!="",I!=" ",_clinguin_atom(image(O,R,I)).
attr(image_remove(O,R,I),class,"btn-outline-danger") :- object(O,_),_clinguin_context(selected_for_inspection,O),_clinguin_context(inspect_modal_open,true),image(O,R,I),I!="",I!=" ",_clinguin_atom(image(O,R,I)).
when(image_remove(O,R,I),click,call,remove_atom(image(O,R,I))) :- object(O,_),_clinguin_context(selected_for_inspection,O),_clinguin_context(inspect_modal_open,true),image(O,R,I),I!="",I!=" ",_clinguin_atom(image(O,R,I)).




% Required Property Count

elem(required_properties,label,inspector_content) :- object(O,_),_clinguin_context(selected_for_inspection,O),_clinguin_context(inspect_modal_open,true),property_schema(O,_,_,true).
attr(required_properties,order,2) :- elem(required_properties,label,_).
attr(required_properties,label,@concat("Required properties · ",Have,"/",Total)) :- object(O,_),_clinguin_context(selected_for_inspection,O),_clinguin_context(inspect_modal_open,true),property_schema(O,_,_,true),Total=#count{K:property_schema(O,K,_,true)},Have=#count{K:property_schema(O,K,_,true),property(O,K,_)}.

% Required Positions Per Role

elem(role_requirement(O,R),label,inspector_content) :- object(O,_),_clinguin_context(selected_for_inspection,O),_clinguin_context(inspect_modal_open,true),role(O,R,_,Min,_),Min>0.
attr(role_requirement(O,R),order,10) :- elem(role_requirement(O,R),label,inspector_content).
attr(role_requirement(O,R),label,@concat("Required ",R," positions · ",N,"/",Min)) :- object(O,_),_clinguin_context(selected_for_inspection,O),_clinguin_context(inspect_modal_open,true),role(O,R,_,Min,_),Min>0,N=#count{Node:elem(placement(Node,R,O),container,_)}.

% Inspector Properties Section

elem(properties_section,container,inspector_content) :- object(O,_),_clinguin_context(selected_for_inspection,O),_clinguin_context(inspect_modal_open,true).
attr(properties_section,order,3):-object(O,_),_clinguin_context(selected_for_inspection,O),_clinguin_context(inspect_modal_open,true).
% attr(properties_section,order,Count+11) :- elem(properties_section,container,inspector_content),Count=#count{Obj,R:elem(role_requirement(Obj,R),label,inspector_content);Obj,S,F,M:elem(inspector_issue(Obj,S,F,M),label,inspector_content)}.
attr(properties_section,class,("d-flex";"flex-column";"gap-2";"border";"rounded-3";"p-2")) :- object(O,_),_clinguin_context(selected_for_inspection,O),_clinguin_context(inspect_modal_open,true).


% Properties Section Title

elem(properties_title,label,properties_section) :- object(O,_),_clinguin_context(selected_for_inspection,O),_clinguin_context(inspect_modal_open,true).
attr(properties_title,order,0) :- elem(properties_title,label,_).
attr(properties_title,label,"Properties") :- object(O,_),_clinguin_context(selected_for_inspection,O),_clinguin_context(inspect_modal_open,true).
attr(properties_title,class,"fw-bold") :- object(O,_),_clinguin_context(selected_for_inspection,O),_clinguin_context(inspect_modal_open,true).

% Add Property Button

elem(add_property,button,properties_section) :- object(O,_),_clinguin_context(selected_for_inspection,O),_clinguin_context(inspect_modal_open,true).
attr(add_property,order,1) :- elem(add_property,button,_).
attr(add_property,label,"Add Property") :- object(O,_),_clinguin_context(selected_for_inspection,O),_clinguin_context(inspect_modal_open,true).
attr(add_property,class,("btn-primary";"align-self-end")) :- object(O,_),_clinguin_context(selected_for_inspection,O),_clinguin_context(inspect_modal_open,true).
when(add_property,click,context,(dialog,form(add_property))) :- object(O,_),_clinguin_context(selected_for_inspection,O),_clinguin_context(inspect_modal_open,true).
when(add_property,click,update,(dialog(form(add_property)),visibility,shown)) :- object(O,_),_clinguin_context(selected_for_inspection,O),_clinguin_context(inspect_modal_open,true).
when(add_property,click,update,(local_feedback,visibility,hidden)) :- object(O,_),_clinguin_context(selected_for_inspection,O),_clinguin_context(inspect_modal_open,true).

% Empty Properties Message

elem(properties_empty,label,properties_section) :- object(O,_),_clinguin_context(selected_for_inspection,O),_clinguin_context(inspect_modal_open,true),not property(O,_,_).
attr(properties_empty,order,2) :- elem(properties_empty,label,_).
attr(properties_empty,label,"No properties.") :- elem(properties_empty,label,_).

% Property Row

elem(property_row(O,K,V),container,properties_section) :- object(O,_),_clinguin_context(selected_for_inspection,O),_clinguin_context(inspect_modal_open,true),property(O,K,V).
attr(property_row(O,K,V),order,N+10) :- object(O,_),_clinguin_context(selected_for_inspection,O),_clinguin_context(inspect_modal_open,true),property(O,K,V),N=#count{K2,V2:property(O,K2,V2),(K2,V2)<(K,V)}.
attr(property_row(O,K,V),flex_direction,row) :- elem(property_row(O,K,V),container,_).
attr(property_row(O,K,V),class,("d-flex";"gap-2";"align-items-center";"border";"rounded-2";"p-2")) :- object(O,_),_clinguin_context(selected_for_inspection,O),_clinguin_context(inspect_modal_open,true),property(O,K,V).
attr(property_row(O,K,V),class,"flex-wrap") :- elem(property_row(O,K,V),container,_).

% Property Details

elem(property_text(O,K,V),label,property_row(O,K,V)) :- object(O,_),_clinguin_context(selected_for_inspection,O),_clinguin_context(inspect_modal_open,true),property(O,K,V).
attr(property_text(O,K,V),order,0) :- elem(property_text(O,K,V),label,_).
attr(property_text(O,K,V),label,@concat(K," = ",V)) :- object(O,_),_clinguin_context(selected_for_inspection,O),_clinguin_context(inspect_modal_open,true),property(O,K,V).
attr(property_text(O,K,V),class,("font-monospace";"small";"flex-grow-1")) :- object(O,_),_clinguin_context(selected_for_inspection,O),_clinguin_context(inspect_modal_open,true),property(O,K,V).

% Edit Property Button

elem(property_edit(O,K,V),button,property_row(O,K,V)) :- object(O,_),_clinguin_context(selected_for_inspection,O),_clinguin_context(inspect_modal_open,true),property(O,K,V),_clinguin_atom(property(O,K,V)).
attr(property_edit(O,K,V),order,1) :- elem(property_edit(O,K,V),button,_).
attr(property_edit(O,K,V),label,"Edit") :- object(O,_),_clinguin_context(selected_for_inspection,O),_clinguin_context(inspect_modal_open,true),property(O,K,V),_clinguin_atom(property(O,K,V)).
attr(property_edit(O,K,V),class,"btn-outline-primary") :- object(O,_),_clinguin_context(selected_for_inspection,O),_clinguin_context(inspect_modal_open,true),property(O,K,V),_clinguin_atom(property(O,K,V)).
when(property_edit(O,K,V),click,context,(dialog,form(property_edit))) :- object(O,_),_clinguin_context(selected_for_inspection,O),_clinguin_context(inspect_modal_open,true),property(O,K,V),_clinguin_atom(property(O,K,V)).
when(property_edit(O,K,V),click,update,(dialog(form(property_edit)),visibility,shown)) :- object(O,_),_clinguin_context(selected_for_inspection,O),_clinguin_context(inspect_modal_open,true),property(O,K,V),_clinguin_atom(property(O,K,V)).
when(property_edit(O,K,V),click,update,(local_feedback,visibility,hidden)) :- object(O,_),_clinguin_context(selected_for_inspection,O),_clinguin_context(inspect_modal_open,true),property(O,K,V),_clinguin_atom(property(O,K,V)).
when(property_edit(O,K,V),click,context,(edit_property_object,O)) :- object(O,_),_clinguin_context(selected_for_inspection,O),_clinguin_context(inspect_modal_open,true),property(O,K,V),_clinguin_atom(property(O,K,V)).
when(property_edit(O,K,V),click,context,(edit_property_key,K)) :- object(O,_),_clinguin_context(selected_for_inspection,O),_clinguin_context(inspect_modal_open,true),property(O,K,V),_clinguin_atom(property(O,K,V)).
when(property_edit(O,K,V),click,context,(edit_property_value,V)) :- object(O,_),_clinguin_context(selected_for_inspection,O),_clinguin_context(inspect_modal_open,true),property(O,K,V),_clinguin_atom(property(O,K,V)).

% Delete Property Button

elem(property_remove(O,K,V),button,property_row(O,K,V)) :- object(O,_),_clinguin_context(selected_for_inspection,O),_clinguin_context(inspect_modal_open,true),property(O,K,V),_clinguin_atom(property(O,K,V)).
attr(property_remove(O,K,V),order,2) :- elem(property_remove(O,K,V),button,_).
attr(property_remove(O,K,V),label,"Delete") :- object(O,_),_clinguin_context(selected_for_inspection,O),_clinguin_context(inspect_modal_open,true),property(O,K,V),_clinguin_atom(property(O,K,V)).
attr(property_remove(O,K,V),class,"btn-outline-danger") :- object(O,_),_clinguin_context(selected_for_inspection,O),_clinguin_context(inspect_modal_open,true),property(O,K,V),_clinguin_atom(property(O,K,V)).
when(property_remove(O,K,V),click,call,remove_atom(property(O,K,V))) :- object(O,_),_clinguin_context(selected_for_inspection,O),_clinguin_context(inspect_modal_open,true),property(O,K,V),_clinguin_atom(property(O,K,V)).






% Inspector Positions Section

elem(positions_section,container,inspector_content) :- object(O,_),_clinguin_context(selected_for_inspection,O),_clinguin_context(inspect_modal_open,true).
attr(positions_section,order,5) :- elem(positions_section,container,inspector_content).
attr(positions_section,class,("d-flex";"flex-column";"gap-2";"border";"rounded-3";"p-2")) :- object(O,_),_clinguin_context(selected_for_inspection,O),_clinguin_context(inspect_modal_open,true).

% Positions Section Title

elem(positions_title,label,positions_section) :- object(O,_),_clinguin_context(selected_for_inspection,O),_clinguin_context(inspect_modal_open,true).
attr(positions_title,order,0) :- elem(positions_title,label,_).
attr(positions_title,label,"Positions") :- object(O,_),_clinguin_context(selected_for_inspection,O),_clinguin_context(inspect_modal_open,true).
attr(positions_title,class,"fw-bold") :- object(O,_),_clinguin_context(selected_for_inspection,O),_clinguin_context(inspect_modal_open,true).

% Empty Positions Message

elem(positions_empty,label,positions_section) :- object(O,_),_clinguin_context(selected_for_inspection,O),_clinguin_context(inspect_modal_open,true),not elem(placement(_,_,O),container,_).
attr(positions_empty,label,"No visible positions.") :- elem(positions_empty,label,_).
attr(positions_empty,order,2) :- elem(positions_empty,label,_).

% Position Row

elem(position_row(O,N,R),container,positions_section) :- object(O,_),_clinguin_context(selected_for_inspection,O),_clinguin_context(inspect_modal_open,true),elem(placement(N,R,O),container,_).
attr(position_row(O,N,R),order,Count+10) :- object(O,_),_clinguin_context(selected_for_inspection,O),_clinguin_context(inspect_modal_open,true),elem(placement(N,R,O),container,_),Count=#count{N2,R2:elem(placement(N2,R2,O),container,_),(N2,R2)<(N,R)}.
attr(position_row(O,N,R),class,("d-flex";"gap-2";"align-items-center";"border";"rounded-2";"p-2")) :- object(O,_),_clinguin_context(selected_for_inspection,O),_clinguin_context(inspect_modal_open,true),elem(placement(N,R,O),container,_).
attr(position_row(O,N,R),flex_direction,row) :- elem(position_row(O,N,R),container,_).
attr(position_row(O,N,R),class,"flex-wrap") :- elem(position_row(O,N,R),container,_).

% Position Details

elem(position_text(O,N,R),label,position_row(O,N,R)) :- object(O,_),_clinguin_context(selected_for_inspection,O),_clinguin_context(inspect_modal_open,true),elem(placement(N,R,O),container,_).
attr(position_text(O,N,R),order,0) :- elem(position_text(O,N,R),label,_).
attr(position_text(O,N,R),label,@concat(N," · ",R)) :- object(O,_),_clinguin_context(selected_for_inspection,O),_clinguin_context(inspect_modal_open,true),elem(placement(N,R,O),container,_).
attr(position_text(O,N,R),class,("font-monospace";"small";"flex-grow-1")) :- object(O,_),_clinguin_context(selected_for_inspection,O),_clinguin_context(inspect_modal_open,true),elem(placement(N,R,O),container,_).



% Shared Form Action Layout

attr(form_actions(F),flex_direction,row) :- elem(form_actions(F),container,_).
attr(form_actions(F),class,"flex-wrap") :- elem(form_actions(F),container,_).

% Shared Cancel Button Order

attr(cancel(F),order,0) :- elem(cancel(F),button,_).

% Shared Save Button Order

attr(save(F,Kind),order,N+1) :- elem(save(F,Kind),button,_),N=#count{Other:elem(save(F,Other),button,_),Other<Kind}.


% Create Object Modal

elem(dialog(form(add_object)),modal,w).
attr(dialog(form(add_object)),title,"New object").
attr(dialog(form(add_object)),visibility,shown) :- _clinguin_context(dialog,form(add_object)),not _clinguin_context(submitted,true),not elem(commit(_,_,_),container,w).
attr(dialog(form(add_object)),visibility,shown) :- _clinguin_context(dialog,form(add_object)),_clinguin_unsat,not elem(commit(_,_,_),container,w).
attr(dialog(form(add_object)),visibility,hidden) :- not _clinguin_context(dialog,form(add_object)).
attr(dialog(form(add_object)),visibility,hidden) :- _clinguin_context(submitted,true),not _clinguin_unsat.

% New Object Form Body

elem(form_body(add_object),container,dialog_sheet(form(add_object))).
attr(form_body(add_object),class,("d-flex";"flex-column";"gap-3";"p-3")).

% Object Identifier Input

elem(input(add_object,new_object_name),textfield,form_body(add_object)).
attr(input(add_object,new_object_name),order,1).
attr(input(add_object,new_object_name),placeholder,"Object identifier").
when(input(add_object,new_object_name),input,context,(new_object_name,_value)).

%  Object Type Input

elem(input(add_object,new_object_type),textfield,form_body(add_object)).
attr(input(add_object,new_object_type),order,2).
attr(input(add_object,new_object_type),placeholder,"Object type").
when(input(add_object,new_object_type),input,context,(new_object_type,_value)).

% Object Actions

elem(form_actions(add_object),container,form_body(add_object)).
attr(form_actions(add_object),order,30).
attr(form_actions(add_object),class,("d-flex";"gap-2";"justify-content-end")).

%  Cancel Object
elem(cancel(add_object),button,form_actions(add_object)).
attr(cancel(add_object),label,"Cancel").
attr(cancel(add_object),class,"btn-outline-secondary").
when(cancel(add_object),click,update,(dialog(form(add_object)),visibility,hidden)).

% Save Object

elem(save(add_object,term),button,form_actions(add_object)).
attr(save(add_object,term),label,"Save").
attr(save(add_object,term),class,"btn-primary").
when(save(add_object,term),click,call,add_atom(request(create,_context_value(new_object_name,const),_context_value(new_object_type,const)))) :- not request(_,_,_).
when(save(add_object,term),click,call,(remove_atom(request(M,OldO,OldT)),add_atom(request(create,_context_value(new_object_name,const),_context_value(new_object_type,const))))) :- request(M,OldO,OldT).



% Add Property Dialog

elem(dialog(form(add_property)),modal,w) :- object(O,_),_clinguin_context(selected_for_inspection,O),_clinguin_context(inspect_modal_open,true).
attr(dialog(form(add_property)),title,"Add property") :- object(O,_),_clinguin_context(selected_for_inspection,O),_clinguin_context(inspect_modal_open,true).
attr(dialog(form(add_property)),visibility,shown) :- object(O,_),_clinguin_context(selected_for_inspection,O),_clinguin_context(inspect_modal_open,true),_clinguin_context(dialog,form(add_property)),not _clinguin_context(submitted,true),not elem(commit(_,_,_),container,w).
attr(dialog(form(add_property)),visibility,shown) :- object(O,_),_clinguin_context(selected_for_inspection,O),_clinguin_context(inspect_modal_open,true),_clinguin_context(dialog,form(add_property)),_clinguin_unsat,not elem(commit(_,_,_),container,w).
attr(dialog(form(add_property)),visibility,hidden) :- object(O,_),_clinguin_context(selected_for_inspection,O),_clinguin_context(inspect_modal_open,true),not _clinguin_context(dialog,form(add_property)).
attr(dialog(form(add_property)),visibility,hidden) :- object(O,_),_clinguin_context(selected_for_inspection,O),_clinguin_context(inspect_modal_open,true),_clinguin_context(submitted,true),not _clinguin_unsat.

% Add Property Form Body

elem(form_body(add_property),container,dialog_sheet(form(add_property))) :- object(O,_),_clinguin_context(selected_for_inspection,O),_clinguin_context(inspect_modal_open,true).
attr(form_body(add_property),class,("d-flex";"flex-column";"gap-3";"p-3")) :- object(O,_),_clinguin_context(selected_for_inspection,O),_clinguin_context(inspect_modal_open,true).

% Add Property: Property Key Input

elem(input(add_property,new_property_name),textfield,form_body(add_property)) :- object(O,_),_clinguin_context(selected_for_inspection,O),_clinguin_context(inspect_modal_open,true).
attr(input(add_property,new_property_name),order,1) :- object(O,_),_clinguin_context(selected_for_inspection,O),_clinguin_context(inspect_modal_open,true).
attr(input(add_property,new_property_name),placeholder,"Property Name") :- object(O,_),_clinguin_context(selected_for_inspection,O),_clinguin_context(inspect_modal_open,true).
when(input(add_property,new_property_name),input,context,(new_property_name,_value)) :- object(O,_),_clinguin_context(selected_for_inspection,O),_clinguin_context(inspect_modal_open,true).

% Add Property: Previous Property Key

elem(previous(add_property,new_property_name),label,form_body(add_property)) :- object(O,_),_clinguin_context(selected_for_inspection,O),_clinguin_context(inspect_modal_open,true),_clinguin_context(new_property_name,V).
attr(previous(add_property,new_property_name),order,11) :- object(O,_),_clinguin_context(selected_for_inspection,O),_clinguin_context(inspect_modal_open,true),_clinguin_context(new_property_name,V).
attr(previous(add_property,new_property_name),label,@concat("Previous entry: ",V)) :- object(O,_),_clinguin_context(selected_for_inspection,O),_clinguin_context(inspect_modal_open,true),_clinguin_context(new_property_name,V).
attr(previous(add_property,new_property_name),class,("small";"text-secondary")) :- object(O,_),_clinguin_context(selected_for_inspection,O),_clinguin_context(inspect_modal_open,true),_clinguin_context(new_property_name,V).

% Add Property: Property Value Input

elem(input(add_property,new_property_value),textfield,form_body(add_property)) :- object(O,_),_clinguin_context(selected_for_inspection,O),_clinguin_context(inspect_modal_open,true).
attr(input(add_property,new_property_value),order,2) :- object(O,_),_clinguin_context(selected_for_inspection,O),_clinguin_context(inspect_modal_open,true).
attr(input(add_property,new_property_value),placeholder,"Property value") :- object(O,_),_clinguin_context(selected_for_inspection,O),_clinguin_context(inspect_modal_open,true).
when(input(add_property,new_property_value),input,context,(new_property_value,_value)) :- object(O,_),_clinguin_context(selected_for_inspection,O),_clinguin_context(inspect_modal_open,true).

% Add Property: Previous Property Value

elem(previous(add_property,new_property_value),label,form_body(add_property)) :- object(O,_),_clinguin_context(selected_for_inspection,O),_clinguin_context(inspect_modal_open,true),_clinguin_context(new_property_value,V).
attr(previous(add_property,new_property_value),order,12) :- object(O,_),_clinguin_context(selected_for_inspection,O),_clinguin_context(inspect_modal_open,true),_clinguin_context(new_property_value,V).
attr(previous(add_property,new_property_value),label,@concat("Previous entry: ",V)) :- object(O,_),_clinguin_context(selected_for_inspection,O),_clinguin_context(inspect_modal_open,true),_clinguin_context(new_property_value,V).
attr(previous(add_property,new_property_value),class,("small";"text-secondary")) :- object(O,_),_clinguin_context(selected_for_inspection,O),_clinguin_context(inspect_modal_open,true),_clinguin_context(new_property_value,V).

% Add Property Form Actions
elem(form_actions(add_property),container,form_body(add_property)) :- object(O,_),_clinguin_context(selected_for_inspection,O),_clinguin_context(inspect_modal_open,true).
attr(form_actions(add_property),order,30) :- object(O,_),_clinguin_context(selected_for_inspection,O),_clinguin_context(inspect_modal_open,true).
attr(form_actions(add_property),class,("d-flex";"gap-2";"justify-content-end")) :- object(O,_),_clinguin_context(selected_for_inspection,O),_clinguin_context(inspect_modal_open,true).

% Add Property: Cancel Button

elem(cancel(add_property),button,form_actions(add_property)) :- object(O,_),_clinguin_context(selected_for_inspection,O),_clinguin_context(inspect_modal_open,true).
attr(cancel(add_property),label,"Cancel") :- object(O,_),_clinguin_context(selected_for_inspection,O),_clinguin_context(inspect_modal_open,true).
attr(cancel(add_property),class,"btn-outline-secondary") :- object(O,_),_clinguin_context(selected_for_inspection,O),_clinguin_context(inspect_modal_open,true).
when(cancel(add_property),click,context,(dialog,none)) :- object(O,_),_clinguin_context(selected_for_inspection,O),_clinguin_context(inspect_modal_open,true).
when(cancel(add_property),click,update,(dialog(form(add_property)),visibility,hidden)) :- object(O,_),_clinguin_context(selected_for_inspection,O),_clinguin_context(inspect_modal_open,true).

% Add Property: Save Term Button

elem(save(add_property,term),button,form_actions(add_property)) :- object(O,_),_clinguin_context(selected_for_inspection,O),_clinguin_context(inspect_modal_open,true).
attr(save(add_property,term),label,"Save term") :- object(O,_),_clinguin_context(selected_for_inspection,O),_clinguin_context(inspect_modal_open,true).
attr(save(add_property,term),class,"btn-primary") :- object(O,_),_clinguin_context(selected_for_inspection,O),_clinguin_context(inspect_modal_open,true).
when(save(add_property,term),click,context,(submitted,true)) :- object(O,_),_clinguin_context(selected_for_inspection,O),_clinguin_context(inspect_modal_open,true).
when(save(add_property,term),click,call,add_atom(property(O,_context_value(new_property_name,const),_context_value(new_property_value)))) :- object(O,_),_clinguin_context(selected_for_inspection,O),_clinguin_context(inspect_modal_open,true).

% Add Property: Save Number Button

elem(save(add_property,int),button,form_actions(add_property)) :- object(O,_),_clinguin_context(selected_for_inspection,O),_clinguin_context(inspect_modal_open,true).
attr(save(add_property,int),label,"Save number") :- object(O,_),_clinguin_context(selected_for_inspection,O),_clinguin_context(inspect_modal_open,true).
attr(save(add_property,int),class,"btn-primary") :- object(O,_),_clinguin_context(selected_for_inspection,O),_clinguin_context(inspect_modal_open,true).
when(save(add_property,int),click,context,(submitted,true)) :- object(O,_),_clinguin_context(selected_for_inspection,O),_clinguin_context(inspect_modal_open,true).
when(save(add_property,int),click,call,add_atom(property(O,_context_value(new_property_name,const),_context_value(new_property_value,int)))) :- object(O,_),_clinguin_context(selected_for_inspection,O),_clinguin_context(inspect_modal_open,true).

% Add Property: Save Text Button

elem(save(add_property,str),button,form_actions(add_property)) :- object(O,_),_clinguin_context(selected_for_inspection,O),_clinguin_context(inspect_modal_open,true).
attr(save(add_property,str),label,"Save text") :- object(O,_),_clinguin_context(selected_for_inspection,O),_clinguin_context(inspect_modal_open,true).
attr(save(add_property,str),class,"btn-primary") :- object(O,_),_clinguin_context(selected_for_inspection,O),_clinguin_context(inspect_modal_open,true).
when(save(add_property,str),click,context,(submitted,true)) :- object(O,_),_clinguin_context(selected_for_inspection,O),_clinguin_context(inspect_modal_open,true).
when(save(add_property,str),click,call,add_atom(property(O,_context_value(new_property_name,const),_context_value(new_property_value,str)))) :- object(O,_),_clinguin_context(selected_for_inspection,O),_clinguin_context(inspect_modal_open,true).

% Edit Property Dialog

elem(dialog(form(property_edit)),modal,w) :- object(O,_),_clinguin_context(selected_for_inspection,O),_clinguin_context(inspect_modal_open,true).
attr(dialog(form(property_edit)),title,"Edit property") :- object(O,_),_clinguin_context(selected_for_inspection,O),_clinguin_context(inspect_modal_open,true).
attr(dialog(form(property_edit)),visibility,shown) :- object(O,_),_clinguin_context(selected_for_inspection,O),_clinguin_context(inspect_modal_open,true),_clinguin_context(dialog,form(property_edit)),not _clinguin_context(submitted,true),not elem(commit(_,_,_),container,w).
attr(dialog(form(property_edit)),visibility,shown) :- object(O,_),_clinguin_context(selected_for_inspection,O),_clinguin_context(inspect_modal_open,true),_clinguin_context(dialog,form(property_edit)),_clinguin_unsat,not elem(commit(_,_,_),container,w).
attr(dialog(form(property_edit)),visibility,hidden) :- object(O,_),_clinguin_context(selected_for_inspection,O),_clinguin_context(inspect_modal_open,true),not _clinguin_context(dialog,form(property_edit)).
attr(dialog(form(property_edit)),visibility,hidden) :- object(O,_),_clinguin_context(selected_for_inspection,O),_clinguin_context(inspect_modal_open,true),_clinguin_context(submitted,true),not _clinguin_unsat.

% Edit Property Form Body

elem(form_body(property_edit),container,dialog_sheet(form(property_edit))) :- object(O,_),_clinguin_context(selected_for_inspection,O),_clinguin_context(inspect_modal_open,true).
attr(form_body(property_edit),class,("d-flex";"flex-column";"gap-3";"p-3")) :- object(O,_),_clinguin_context(selected_for_inspection,O),_clinguin_context(inspect_modal_open,true).

% Edit Property: Replacement Key Input

elem(input(property_edit,changed_property_key),textfield,form_body(property_edit)) :- object(O,_),_clinguin_context(selected_for_inspection,O),_clinguin_context(inspect_modal_open,true).
attr(input(property_edit,changed_property_key),placeholder,"Replacement key") :- object(O,_),_clinguin_context(selected_for_inspection,O),_clinguin_context(inspect_modal_open,true).
attr(input(property_edit,changed_property_key),order,1) :- object(O,_),_clinguin_context(selected_for_inspection,O),_clinguin_context(inspect_modal_open,true).
when(input(property_edit,changed_property_key),input,context,(changed_property_key,_value)) :- object(O,_),_clinguin_context(selected_for_inspection,O),_clinguin_context(inspect_modal_open,true).

% Edit Property: Replacement Value Input

elem(input(property_edit,changed_property_value),textfield,form_body(property_edit)) :- object(O,_),_clinguin_context(selected_for_inspection,O),_clinguin_context(inspect_modal_open,true).
attr(input(property_edit,changed_property_value),order,2) :- object(O,_),_clinguin_context(selected_for_inspection,O),_clinguin_context(inspect_modal_open,true).
attr(input(property_edit,changed_property_value),placeholder,"Replacement value") :- object(O,_),_clinguin_context(selected_for_inspection,O),_clinguin_context(inspect_modal_open,true).
when(input(property_edit,changed_property_value),input,context,(changed_property_value,_value)) :- object(O,_),_clinguin_context(selected_for_inspection,O),_clinguin_context(inspect_modal_open,true).


% Edit Property Form Actions

elem(form_actions(property_edit),container,form_body(property_edit)) :- object(O,_),_clinguin_context(selected_for_inspection,O),_clinguin_context(inspect_modal_open,true).
attr(form_actions(property_edit),order,30) :- object(O,_),_clinguin_context(selected_for_inspection,O),_clinguin_context(inspect_modal_open,true).
attr(form_actions(property_edit),class,("d-flex";"gap-2";"justify-content-end")) :- object(O,_),_clinguin_context(selected_for_inspection,O),_clinguin_context(inspect_modal_open,true).

% Edit Property: Cancel Button

elem(cancel(property_edit),button,form_actions(property_edit)) :- object(O,_),_clinguin_context(selected_for_inspection,O),_clinguin_context(inspect_modal_open,true).
attr(cancel(property_edit),label,"Cancel") :- object(O,_),_clinguin_context(selected_for_inspection,O),_clinguin_context(inspect_modal_open,true).
attr(cancel(property_edit),class,"btn-outline-secondary") :- object(O,_),_clinguin_context(selected_for_inspection,O),_clinguin_context(inspect_modal_open,true).
when(cancel(property_edit),click,context,(dialog,none)) :- object(O,_),_clinguin_context(selected_for_inspection,O),_clinguin_context(inspect_modal_open,true).
when(cancel(property_edit),click,update,(dialog(form(property_edit)),visibility,hidden)) :- object(O,_),_clinguin_context(selected_for_inspection,O),_clinguin_context(inspect_modal_open,true).

% Edit Property: Save Term Button

elem(save(property_edit,term),button,form_actions(property_edit)) :- object(O,_),_clinguin_context(selected_for_inspection,O),_clinguin_context(inspect_modal_open,true).
attr(save(property_edit,term),label,"Save term") :- object(O,_),_clinguin_context(selected_for_inspection,O),_clinguin_context(inspect_modal_open,true).
attr(save(property_edit,term),class,"btn-primary") :- object(O,_),_clinguin_context(selected_for_inspection,O),_clinguin_context(inspect_modal_open,true).
when(save(property_edit,term),click,context,(submitted,true)) :- object(O,_),_clinguin_context(selected_for_inspection,O),_clinguin_context(inspect_modal_open,true).
when(save(property_edit,term),click,call,(remove_atom(property(_context_value(edit_property_object),_context_value(edit_property_key),_context_value(edit_property_value))),add_atom(property(O,_context_value(changed_property_key,const),_context_value(changed_property_value))))) :- object(O,_),_clinguin_context(selected_for_inspection,O),_clinguin_context(inspect_modal_open,true).

% Edit Property: Save Number Button

elem(save(property_edit,int),button,form_actions(property_edit)) :- object(O,_),_clinguin_context(selected_for_inspection,O),_clinguin_context(inspect_modal_open,true).
attr(save(property_edit,int),label,"Save number") :- object(O,_),_clinguin_context(selected_for_inspection,O),_clinguin_context(inspect_modal_open,true).
attr(save(property_edit,int),class,"btn-primary") :- object(O,_),_clinguin_context(selected_for_inspection,O),_clinguin_context(inspect_modal_open,true).
when(save(property_edit,int),click,context,(submitted,true)) :- object(O,_),_clinguin_context(selected_for_inspection,O),_clinguin_context(inspect_modal_open,true).
when(save(property_edit,int),click,call,(remove_atom(property(_context_value(edit_property_object),_context_value(edit_property_key),_context_value(edit_property_value))),add_atom(property(O,_context_value(changed_property_key,const),_context_value(changed_property_value,int))))) :- object(O,_),_clinguin_context(selected_for_inspection,O),_clinguin_context(inspect_modal_open,true).

% Edit Property: Save Text Button

elem(save(property_edit,str),button,form_actions(property_edit)) :- object(O,_),_clinguin_context(selected_for_inspection,O),_clinguin_context(inspect_modal_open,true).
attr(save(property_edit,str),label,"Save text") :- object(O,_),_clinguin_context(selected_for_inspection,O),_clinguin_context(inspect_modal_open,true).
attr(save(property_edit,str),class,"btn-primary") :- object(O,_),_clinguin_context(selected_for_inspection,O),_clinguin_context(inspect_modal_open,true).
when(save(property_edit,str),click,context,(submitted,true)) :- object(O,_),_clinguin_context(selected_for_inspection,O),_clinguin_context(inspect_modal_open,true).
when(save(property_edit,str),click,call,(remove_atom(property(_context_value(edit_property_object),_context_value(edit_property_key),_context_value(edit_property_value))),add_atom(property(O,_context_value(changed_property_key,const),_context_value(changed_property_value,str))))) :- object(O,_),_clinguin_context(selected_for_inspection,O),_clinguin_context(inspect_modal_open,true).





% Add Image Dialog

elem(dialog(form(add_image)),modal,w) :- object(O,_),_clinguin_context(selected_for_inspection,O),_clinguin_context(inspect_modal_open,true).
attr(dialog(form(add_image)),title,"Add image") :- object(O,_),_clinguin_context(selected_for_inspection,O),_clinguin_context(inspect_modal_open,true).
attr(dialog(form(add_image)),visibility,shown) :- object(O,_),_clinguin_context(selected_for_inspection,O),_clinguin_context(inspect_modal_open,true),_clinguin_context(dialog,form(add_image)),not _clinguin_context(submitted,true),not elem(commit(_,_,_),container,w).
attr(dialog(form(add_image)),visibility,shown) :- object(O,_),_clinguin_context(selected_for_inspection,O),_clinguin_context(inspect_modal_open,true),_clinguin_context(dialog,form(add_image)),_clinguin_unsat,not elem(commit(_,_,_),container,w).
attr(dialog(form(add_image)),visibility,hidden) :- object(O,_),_clinguin_context(selected_for_inspection,O),_clinguin_context(inspect_modal_open,true),not _clinguin_context(dialog,form(add_image)).
attr(dialog(form(add_image)),visibility,hidden) :- object(O,_),_clinguin_context(selected_for_inspection,O),_clinguin_context(inspect_modal_open,true),_clinguin_context(submitted,true),not _clinguin_unsat.

% Add Image Form Body

elem(form_body(add_image),container,dialog_sheet(form(add_image))) :- object(O,_),_clinguin_context(selected_for_inspection,O),_clinguin_context(inspect_modal_open,true).
attr(form_body(add_image),class,("d-flex";"flex-column";"gap-3";"p-3")) :- object(O,_),_clinguin_context(selected_for_inspection,O),_clinguin_context(inspect_modal_open,true).

% % Add Image: Role Input

elem(input(add_role,new_role),textfield,form_body(add_image)) :- object(O,_),_clinguin_context(selected_for_inspection,O),_clinguin_context(inspect_modal_open,true),0=#count{R:role(O,R)}.
attr(input(add_role,new_role),order,1) :- object(O,_),_clinguin_context(selected_for_inspection,O),_clinguin_context(inspect_modal_open,true),0=#count{R:role(O,R)}.
attr(input(add_role,new_role),placeholder,"Role") :- object(O,_),_clinguin_context(selected_for_inspection,O),_clinguin_context(inspect_modal_open,true),0=#count{R:role(O,R)}.
when(input(add_role,new_role),input,context,(new_role,_value)) :- object(O,_),_clinguin_context(selected_for_inspection,O),_clinguin_context(inspect_modal_open,true),0=#count{R:role(O,R)}.


% Add Image: Image Path Input

elem(input(add_image,new_image_path),textfield,form_body(add_image)) :- object(O,_),_clinguin_context(selected_for_inspection,O),_clinguin_context(inspect_modal_open,true).
attr(input(add_image,new_image_path),order,0) :- object(O,_),_clinguin_context(selected_for_inspection,O),_clinguin_context(inspect_modal_open,true).
attr(input(add_image,new_image_path),placeholder,"Image path") :- object(O,_),_clinguin_context(selected_for_inspection,O),_clinguin_context(inspect_modal_open,true).
when(input(add_image,new_image_path),input,context,(new_image_path,_value)) :- object(O,_),_clinguin_context(selected_for_inspection,O),_clinguin_context(inspect_modal_open,true).


% Add Image Form Actions

elem(form_actions(add_image),container,form_body(add_image)) :- object(O,_),_clinguin_context(selected_for_inspection,O),_clinguin_context(inspect_modal_open,true).
attr(form_actions(add_image),order,30) :- object(O,_),_clinguin_context(selected_for_inspection,O),_clinguin_context(inspect_modal_open,true).
attr(form_actions(add_image),class,("d-flex";"gap-2";"justify-content-end")) :- object(O,_),_clinguin_context(selected_for_inspection,O),_clinguin_context(inspect_modal_open,true).

% Add Image: Cancel Button

elem(cancel(add_image),button,form_actions(add_image)) :- object(O,_),_clinguin_context(selected_for_inspection,O),_clinguin_context(inspect_modal_open,true).
attr(cancel(add_image),label,"Cancel") :- object(O,_),_clinguin_context(selected_for_inspection,O),_clinguin_context(inspect_modal_open,true).
attr(cancel(add_image),class,"btn-outline-secondary") :- object(O,_),_clinguin_context(selected_for_inspection,O),_clinguin_context(inspect_modal_open,true).
when(cancel(add_image),click,context,(dialog,none)) :- object(O,_),_clinguin_context(selected_for_inspection,O),_clinguin_context(inspect_modal_open,true).
when(cancel(add_image),click,update,(dialog(form(add_image)),visibility,hidden)) :- object(O,_),_clinguin_context(selected_for_inspection,O),_clinguin_context(inspect_modal_open,true).

% Add Image: Save Image Button

elem(save(add_image,str),button,form_actions(add_image)) :- object(O,_),_clinguin_context(selected_for_inspection,O),_clinguin_context(inspect_modal_open,true).
attr(save(add_image,str),label,"Save image") :- object(O,_),_clinguin_context(selected_for_inspection,O),_clinguin_context(inspect_modal_open,true).
attr(save(add_image,str),class,"btn-primary") :- object(O,_),_clinguin_context(selected_for_inspection,O),_clinguin_context(inspect_modal_open,true).
when(save(add_image,str),click,update,(dialog(form(add_image)),visibility,hidden)) :- object(O,_),_clinguin_context(selected_for_inspection,O),_clinguin_context(inspect_modal_open,true).
when(save(add_image,str),click,context,(submitted,true)) :- object(O,_),_clinguin_context(selected_for_inspection,O),_clinguin_context(inspect_modal_open,true).
when(save(add_image,str),click,call,add_atom(image(O,_context_value(new_role,str),_context_value(new_image_path,str)))) :- object(O,_),_clinguin_context(selected_for_inspection,O),_clinguin_context(inspect_modal_open,true).


% Edit Image Dialog

elem(dialog(form(edit_image)),modal,w) :- object(O,_),_clinguin_context(selected_for_inspection,O),_clinguin_context(inspect_modal_open,true).
attr(dialog(form(edit_image)),title,"Edit image") :- object(O,_),_clinguin_context(selected_for_inspection,O),_clinguin_context(inspect_modal_open,true).
attr(dialog(form(edit_image)),visibility,shown) :- object(O,_),_clinguin_context(selected_for_inspection,O),_clinguin_context(inspect_modal_open,true),_clinguin_context(dialog,form(edit_image)),not _clinguin_context(submitted,true),not elem(commit(_,_,_),container,w).
attr(dialog(form(edit_image)),visibility,shown) :- object(O,_),_clinguin_context(selected_for_inspection,O),_clinguin_context(inspect_modal_open,true),_clinguin_context(dialog,form(edit_image)),_clinguin_unsat,not elem(commit(_,_,_),container,w).
attr(dialog(form(edit_image)),visibility,hidden) :- object(O,_),_clinguin_context(selected_for_inspection,O),_clinguin_context(inspect_modal_open,true),not _clinguin_context(dialog,form(edit_image)).
attr(dialog(form(edit_image)),visibility,hidden) :- object(O,_),_clinguin_context(selected_for_inspection,O),_clinguin_context(inspect_modal_open,true),_clinguin_context(submitted,true),not _clinguin_unsat.

% Edit Image Form Body

elem(form_body(edit_image),container,dialog_sheet(form(edit_image))) :- object(O,_),_clinguin_context(selected_for_inspection,O),_clinguin_context(inspect_modal_open,true).
attr(form_body(edit_image),class,("d-flex";"flex-column";"gap-3";"p-3")) :- object(O,_),_clinguin_context(selected_for_inspection,O),_clinguin_context(inspect_modal_open,true).

% Edit Image: Replacement Image Path Input

elem(input(edit_image,changed_image_path),textfield,form_body(edit_image)) :- object(O,_),_clinguin_context(selected_for_inspection,O),_clinguin_context(inspect_modal_open,true).
attr(input(edit_image,changed_image_path),placeholder,"Replacement image path") :- object(O,_),_clinguin_context(selected_for_inspection,O),_clinguin_context(inspect_modal_open,true).
attr(input(edit_image,changed_image_path),order,1) :- object(O,_),_clinguin_context(selected_for_inspection,O),_clinguin_context(inspect_modal_open,true).
when(input(edit_image,changed_image_path),input,context,(changed_image_path,_value)) :- object(O,_),_clinguin_context(selected_for_inspection,O),_clinguin_context(inspect_modal_open,true).


% Edit Image Form Actions

elem(form_actions(edit_image),container,form_body(edit_image)) :- object(O,_),_clinguin_context(selected_for_inspection,O),_clinguin_context(inspect_modal_open,true).
attr(form_actions(edit_image),order,30) :- object(O,_),_clinguin_context(selected_for_inspection,O),_clinguin_context(inspect_modal_open,true).
attr(form_actions(edit_image),class,("d-flex";"gap-2";"justify-content-end")) :- object(O,_),_clinguin_context(selected_for_inspection,O),_clinguin_context(inspect_modal_open,true).

% Edit Image: Cancel Button

elem(cancel(edit_image),button,form_actions(edit_image)) :- object(O,_),_clinguin_context(selected_for_inspection,O),_clinguin_context(inspect_modal_open,true).
attr(cancel(edit_image),label,"Cancel") :- object(O,_),_clinguin_context(selected_for_inspection,O),_clinguin_context(inspect_modal_open,true).
attr(cancel(edit_image),class,"btn-outline-secondary") :- object(O,_),_clinguin_context(selected_for_inspection,O),_clinguin_context(inspect_modal_open,true).
when(cancel(edit_image),click,context,(dialog,none)) :- object(O,_),_clinguin_context(selected_for_inspection,O),_clinguin_context(inspect_modal_open,true).
when(cancel(edit_image),click,update,(dialog(form(edit_image)),visibility,hidden)) :- object(O,_),_clinguin_context(selected_for_inspection,O),_clinguin_context(inspect_modal_open,true).

% Edit Image: Save Image Button

elem(save(edit_image,str),button,form_actions(edit_image)) :- object(O,_),_clinguin_context(selected_for_inspection,O),_clinguin_context(inspect_modal_open,true).
attr(save(edit_image,str),label,"Save image") :- object(O,_),_clinguin_context(selected_for_inspection,O),_clinguin_context(inspect_modal_open,true).
attr(save(edit_image,str),class,"btn-primary") :- object(O,_),_clinguin_context(selected_for_inspection,O),_clinguin_context(inspect_modal_open,true).
when(save(edit_image,str),click,context,(submitted,true)) :- object(O,_),_clinguin_context(selected_for_inspection,O),_clinguin_context(inspect_modal_open,true).
when(save(edit_image,str),click,call,(remove_atom(image(_context_value(edit_image_object),_context_value(edit_image_role),_context_value(edit_image_path))),add_atom(image(O,_context_value(edit_image_role),_context_value(changed_image_path,str))))) :- object(O,_),_clinguin_context(selected_for_inspection,O),_clinguin_context(inspect_modal_open,true).
