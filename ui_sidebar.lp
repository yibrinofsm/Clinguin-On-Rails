%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% REPLACE EXISTING FILE: ui_sidebar.lp
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Sidebar header
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

elem(sidebar_header,container,sidebar_panel).
attr(sidebar_header,order,1).
attr(sidebar_header,child_layout,flex).
attr(sidebar_header,flex_direction,column).
attr(sidebar_header,class,("d-flex";"flex-column";"gap-1";"p-3";"border";"text-white")).
attr(sidebar_header,"border-radius","14px").
attr(sidebar_header,"background","linear-gradient(135deg,#1d4ed8,#6d28d9)").
attr(sidebar_header,"box-shadow","0 12px 28px rgba(37,99,235,.20)").

elem(sidebar_title,label,sidebar_header).
attr(sidebar_title,order,1).
attr(sidebar_title,label,"Object Studio").
attr(sidebar_title,class,("fw-bold";"fs-4";"text-white")).

elem(sidebar_subtitle,label,sidebar_header).
attr(sidebar_subtitle,order,2).
attr(sidebar_subtitle,label,"Create, select, inspect and edit reusable ASP objects without domain-specific UI logic.").
attr(sidebar_subtitle,class,("small";"text-white";"opacity-75")).

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Summary cards
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

elem(summary_cards,container,sidebar_panel).
attr(summary_cards,order,2).
attr(summary_cards,child_layout,flex).
attr(summary_cards,flex_direction,row).
attr(summary_cards,class,("d-flex";"flex-row";"flex-wrap";"gap-2";"align-items-stretch")).

summary_card(summary_objects,1,"Objects",objects,N) :- total_object_count(N).
summary_card(summary_properties,2,"Properties",properties,N) :- total_property_count(N).
summary_card(summary_positions,3,"Positions",positions,N) :- total_position_count(N).
summary_card(summary_edits,4,"Edits",edits,N) :- interactive_edit_count(N).

summary_icon(objects,"fa-cubes").
summary_icon(properties,"fa-list-check").
summary_icon(positions,"fa-location-dot").
summary_icon(edits,"fa-wand-magic-sparkles").

elem(Card,container,summary_cards) :- summary_card(Card,_,_,_,_).
attr(Card,order,Order) :- summary_card(Card,Order,_,_,_).
attr(Card,child_layout,flex) :- summary_card(Card,_,_,_,_).
attr(Card,flex_direction,column) :- summary_card(Card,_,_,_,_).
attr(Card,class,("d-flex";"flex-column";"align-items-center";"justify-content-center";"gap-1";"flex-fill";"bg-light";"border";"rounded-3";"p-2";"text-center")) :- summary_card(Card,_,_,_,_).
attr(Card,"transition","transform 140ms ease,box-shadow 140ms ease") :- summary_card(Card,_,_,_,_).
when(Card,mouseenter,update,(Card,"transform","translateY(-3px)")) :- summary_card(Card,_,_,_,_).
when(Card,mouseenter,update,(Card,"box-shadow","0 9px 20px rgba(37,99,235,.14)")) :- summary_card(Card,_,_,_,_).
when(Card,mouseleave,update,(Card,"transform","translateY(0)")) :- summary_card(Card,_,_,_,_).
when(Card,mouseleave,update,(Card,"box-shadow","none")) :- summary_card(Card,_,_,_,_).

elem(summary_value(Card),label,Card) :- summary_card(Card,_,_,_,_).
attr(summary_value(Card),order,1) :- summary_card(Card,_,_,_,_).
attr(summary_value(Card),label,@concat("",N)) :- summary_card(Card,_,_,_,N).
attr(summary_value(Card),class,("fw-bold";"fs-5";"text-primary")) :- summary_card(Card,_,_,_,_).

elem(summary_caption(Card),label,Card) :- summary_card(Card,_,_,_,_).
attr(summary_caption(Card),order,2) :- summary_card(Card,_,_,_,_).
attr(summary_caption(Card),label,@concat("",Caption)) :- summary_card(Card,_,Caption,_,_).
attr(summary_caption(Card),class,("small";"text-muted")) :- summary_card(Card,_,_,_,_).

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Object browser
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

elem(objects_section,container,sidebar_panel).
attr(objects_section,order,3).
attr(objects_section,child_layout,flex).
attr(objects_section,flex_direction,column).
attr(objects_section,class,("d-flex";"flex-column";"gap-2")).

% Header

elem(objects_header,container,objects_section).
attr(objects_header,order,1).
attr(objects_header,child_layout,flex).
attr(objects_header,flex_direction,row).
attr(objects_header,class,("d-flex";"flex-row";"align-items-center";"justify-content-between";"gap-2")).

elem(objects_header_text,container,objects_header).
attr(objects_header_text,order,1).
attr(objects_header_text,child_layout,flex).
attr(objects_header_text,flex_direction,column).
attr(objects_header_text,class,("d-flex";"flex-column";"gap-0")).

elem(objects_title,label,objects_header_text).
attr(objects_title,order,1).
attr(objects_title,label,"Objects").
attr(objects_title,class,("fw-bold";"fs-6";"text-dark")).

elem(objects_hint,label,objects_header_text).
attr(objects_hint,order,2).
attr(objects_hint,label,"Select any object to inspect or place it.").
attr(objects_hint,class,("small";"text-muted")).

elem(objects_add,button,objects_header).
attr(objects_add,order,2).
attr(objects_add,label,"Add").
attr(objects_add,icon,"fa-plus").
attr(objects_add,class,("btn-primary";"btn-sm";"fw-bold")).
when(objects_add,click,update,(object_create_modal,visibility,shown)).

% Empty state

elem(objects_empty,label,objects_section) :- not has_objects.
attr(objects_empty,order,2) :- not has_objects.
attr(objects_empty,label,"No object/2 facts are currently available.") :- not has_objects.
attr(objects_empty,class,("small";"text-muted";"border";"rounded-3";"p-3";"text-center")) :- not has_objects.

% Scrollable list

elem(objects_list,container,objects_section) :- has_objects.
attr(objects_list,order,2) :- has_objects.
attr(objects_list,child_layout,flex) :- has_objects.
attr(objects_list,flex_direction,column) :- has_objects.
attr(objects_list,class,("d-flex";"flex-column";"gap-2";"overflow-auto";"pe-1")) :- has_objects.
attr(objects_list,"max-height","285px") :- has_objects.

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Generic object card
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

elem(object_card(O),container,objects_list) :- object(O,_).
attr(object_card(O),order,N) :- object_rank(O,N).
attr(object_card(O),child_layout,flex) :- object(O,_).
attr(object_card(O),flex_direction,row) :- object(O,_).

attr(object_card(O),class,("d-flex";"flex-row";"align-items-center";"gap-2";"bg-white";"border";"rounded-3";"p-2";"shadow-sm")) :-
    object(O,_),
    not selected_object(O).

attr(object_card(O),class,("d-flex";"flex-row";"align-items-center";"gap-2";"bg-white";"border";"border-primary";"rounded-3";"p-2";"shadow-sm")) :-
    selected_object(O).

attr(object_card(O),"background","linear-gradient(135deg,rgba(37,99,235,.12),rgba(124,58,237,.075))") :-
    selected_object(O).
attr(object_card(O),"border-left","5px solid #2563eb") :- selected_object(O).
attr(object_card(O),"box-shadow","0 12px 28px rgba(37,99,235,.20)") :- selected_object(O).
attr(object_card(O),"transform","translateX(-2px) scale(1.015)") :- selected_object(O).
attr(object_card(O),"transition","transform 150ms ease,box-shadow 150ms ease,border-color 150ms ease") :- object(O,_).
when(object_card(O),mouseenter,update,(object_card(O),"transform","translateY(-2px)")) :- object(O,_), not selected_object(O).
when(object_card(O),mouseenter,update,(object_card(O),"box-shadow","0 10px 22px rgba(15,23,42,.12)")) :- object(O,_).
when(object_card(O),mouseleave,update,(object_card(O),"transform","translateY(0)")) :- object(O,_), not selected_object(O).
when(object_card(O),mouseleave,update,(object_card(O),"box-shadow","0 .125rem .25rem rgba(0,0,0,.075)")) :- object(O,_).

% Clean generic avatar: one primary image, or a neutral fallback.

elem(object_media(O),container,object_card(O)) :- object(O,_).
attr(object_media(O),order,1) :- object(O,_).
attr(object_media(O),child_layout,absstatic) :- object(O,_).
attr(object_media(O),width,42) :- object(O,_).
attr(object_media(O),height,42) :- object(O,_).
attr(object_media(O),class,("p-0";"m-0";"border";"bg-light";"flex-shrink-0")) :- object(O,_).
attr(object_media(O),"border-radius","12px") :- object(O,_).
attr(object_media(O),"overflow","hidden") :- object(O,_).

elem(object_thumb(O,Role,I),canvas,object_media(O)) :- primary_image(O,Role,I).
attr(object_thumb(O,Role,I),image,I) :- primary_image(O,Role,I).
attr(object_thumb(O,Role,I),width,42) :- primary_image(O,Role,I).
attr(object_thumb(O,Role,I),height,42) :- primary_image(O,Role,I).
attr(object_thumb(O,Role,I),pos_x,0) :- primary_image(O,Role,I).
attr(object_thumb(O,Role,I),pos_y,0) :- primary_image(O,Role,I).
attr(object_thumb(O,Role,I),class,("p-0";"m-0";"border-0";"d-block")) :- primary_image(O,Role,I).
attr(object_thumb(O,Role,I),"object-fit","contain") :- primary_image(O,Role,I).

elem(object_thumb_fallback(O),label,object_media(O)) :- object(O,T), not primary_image(O,_,_).
attr(object_thumb_fallback(O),label,"◇") :- object(O,_), not primary_image(O,_,_).
attr(object_thumb_fallback(O),width,42) :- object(O,_), not primary_image(O,_,_).
attr(object_thumb_fallback(O),height,42) :- object(O,_), not primary_image(O,_,_).
attr(object_thumb_fallback(O),pos_x,0) :- object(O,_), not primary_image(O,_,_).
attr(object_thumb_fallback(O),pos_y,0) :- object(O,_), not primary_image(O,_,_).
attr(object_thumb_fallback(O),class,("fw-bold";"fs-4";"text-primary";"text-center";"p-0";"m-0")) :- object(O,_), not primary_image(O,_,_).
attr(object_thumb_fallback(O),"line-height","42px") :- object(O,_), not primary_image(O,_,_).

% Text body.

elem(object_body(O),container,object_card(O)) :- object(O,_).
attr(object_body(O),order,2) :- object(O,_).
attr(object_body(O),child_layout,flex) :- object(O,_).
attr(object_body(O),flex_direction,column) :- object(O,_).
attr(object_body(O),class,("d-flex";"flex-column";"gap-0";"flex-grow-1";"overflow-hidden")) :- object(O,_).

elem(object_name(O),label,object_body(O)) :- object(O,_).
attr(object_name(O),order,1) :- object(O,_).
attr(object_name(O),label,@concat("",L)) :- object_label(O,L).
attr(object_name(O),class,("fw-bold";"font-monospace";"text-truncate")) :- object(O,_).

elem(object_type_name(O),label,object_body(O)) :- object(O,T).
attr(object_type_name(O),order,2) :- object(O,_).
attr(object_type_name(O),label,@concat("Type: ",T)) :- object(O,T).
attr(object_type_name(O),class,("small";"text-muted";"font-monospace")) :- object(O,_).

elem(object_counts(O),label,object_body(O)) :- object(O,_).
attr(object_counts(O),order,3) :- object(O,_).
attr(object_counts(O),label,@concat(P," properties · ",Q," positions")) :-
    object_property_count(O,P),
    object_position_count(O,Q).
attr(object_counts(O),class,("small";"text-muted")) :- object(O,_).


elem(object_origin(O),label,object_body(O)) :- object(O,_).
attr(object_origin(O),order,4) :- object(O,_).
attr(object_origin(O),label,"Session") :- user_object(O,_).
attr(object_origin(O),label,"Source") :- object(O,_), not user_object(O,_).
attr(object_origin(O),class,("badge";"rounded-pill";"align-self-start";"mt-1";"bg-success";"text-white")) :- user_object(O,_).
attr(object_origin(O),class,("badge";"rounded-pill";"align-self-start";"mt-1";"bg-light";"text-muted";"border")) :- object(O,_), not user_object(O,_).

% Select action.

elem(object_select(O),button,object_card(O)) :- object(O,_).
attr(object_select(O),order,3) :- object(O,_).
attr(object_select(O),icon,"fa-chevron-right") :- object(O,_).
attr(object_select(O),label,"Select") :- object(O,_), not selected_object(O).
attr(object_select(O),label,"Selected") :- selected_object(O).
attr(object_select(O),class,("btn-sm";"btn-outline-primary";"border-0";"flex-shrink-0")) :- object(O,_), not selected_object(O).
attr(object_select(O),class,("btn-sm";"btn-primary";"border-0";"flex-shrink-0")) :- selected_object(O).


elem(object_selected_mark(O),label,object_media(O)) :- selected_object(O).
attr(object_selected_mark(O),label,"✓") :- selected_object(O).
attr(object_selected_mark(O),width,18) :- selected_object(O).
attr(object_selected_mark(O),height,18) :- selected_object(O).
attr(object_selected_mark(O),pos_x,22) :- selected_object(O).
attr(object_selected_mark(O),pos_y,2) :- selected_object(O).
attr(object_selected_mark(O),class,("p-0";"m-0";"text-white";"fw-bold";"text-center")) :- selected_object(O).
attr(object_selected_mark(O),"border-radius","50%") :- selected_object(O).
attr(object_selected_mark(O),"line-height","18px") :- selected_object(O).
attr(object_selected_mark(O),"font-size","10px") :- selected_object(O).
attr(object_selected_mark(O),"background","linear-gradient(135deg,#16a34a,#059669)") :- selected_object(O).
attr(object_selected_mark(O),"box-shadow","0 3px 8px rgba(5,150,105,.32)") :- selected_object(O).
when(object_select(O),click,context,(selected_object,O)) :- object(O,_).
when(object_select(O),click,context,(placement_role,Role)) :- object_default_role(O,Role).
when(object_select(O),click,call,update) :- object(O,_).

% Session-created objects expose a compact delete action. It never deletes
% immediately; the existing confirmation modal is opened first.
elem(object_quick_delete(O),button,object_card(O)) :- user_object(O,T).
attr(object_quick_delete(O),order,4) :- user_object(O,_).
attr(object_quick_delete(O),icon,"fa-trash") :- user_object(O,_).
attr(object_quick_delete(O),class,("btn-sm";"btn-outline-danger";"border-0";"flex-shrink-0")) :- user_object(O,_).
when(object_quick_delete(O),click,update,(object_delete_modal(O,T),visibility,shown)) :- user_object(O,T).

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Selected-object inspector
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

elem(inspector,container,sidebar_panel) :- selected_object(_).
attr(inspector,order,4) :- selected_object(_).
attr(inspector,child_layout,flex) :- selected_object(_).
attr(inspector,flex_direction,column) :- selected_object(_).
attr(inspector,class,("d-flex";"flex-column";"gap-3";"border";"border-primary";"p-3")) :- selected_object(_).
attr(inspector,"border-radius","14px") :- selected_object(_).
attr(inspector,"background","linear-gradient(180deg,rgba(37,99,235,.11),rgba(255,255,255,1) 32%)") :- selected_object(_).
attr(inspector,"box-shadow","0 18px 42px rgba(37,99,235,.16)") :- selected_object(_).
attr(inspector,"transition","transform 220ms ease,box-shadow 220ms ease") :- selected_object(_).
attr(inspector,"transform","translateX(0)") :- selected_object(_).

% Inspector header.

elem(inspector_header,container,inspector) :- selected_object(_).
attr(inspector_header,order,1) :- selected_object(_).
attr(inspector_header,child_layout,flex) :- selected_object(_).
attr(inspector_header,flex_direction,row) :- selected_object(_).
attr(inspector_header,class,("d-flex";"flex-row";"align-items-start";"justify-content-between";"gap-2";"pb-2";"border-bottom")) :- selected_object(_).


elem(inspector_avatar(O),container,inspector_header) :- selected_object(O).
attr(inspector_avatar(O),order,0) :- selected_object(O).
attr(inspector_avatar(O),child_layout,absstatic) :- selected_object(O).
attr(inspector_avatar(O),width,52) :- selected_object(O).
attr(inspector_avatar(O),height,52) :- selected_object(O).
attr(inspector_avatar(O),class,("p-0";"m-0";"border";"bg-white";"flex-shrink-0")) :- selected_object(O).
attr(inspector_avatar(O),"border-radius","14px") :- selected_object(O).
attr(inspector_avatar(O),"overflow","hidden") :- selected_object(O).

elem(inspector_avatar_img(O,Role,I),canvas,inspector_avatar(O)) :- selected_object(O), primary_image(O,Role,I).
attr(inspector_avatar_img(O,Role,I),image,I) :- selected_object(O), primary_image(O,Role,I).
attr(inspector_avatar_img(O,Role,I),width,52) :- selected_object(O), primary_image(O,Role,I).
attr(inspector_avatar_img(O,Role,I),height,52) :- selected_object(O), primary_image(O,Role,I).
attr(inspector_avatar_img(O,Role,I),pos_x,0) :- selected_object(O), primary_image(O,Role,I).
attr(inspector_avatar_img(O,Role,I),pos_y,0) :- selected_object(O), primary_image(O,Role,I).
attr(inspector_avatar_img(O,Role,I),class,("p-0";"m-0";"border-0";"d-block")) :- selected_object(O), primary_image(O,Role,I).
attr(inspector_avatar_img(O,Role,I),"object-fit","contain") :- selected_object(O), primary_image(O,Role,I).

elem(inspector_avatar_fallback(O),label,inspector_avatar(O)) :- selected_object(O), not primary_image(O,_,_).
attr(inspector_avatar_fallback(O),label,"◇") :- selected_object(O), not primary_image(O,_,_).
attr(inspector_avatar_fallback(O),width,52) :- selected_object(O), not primary_image(O,_,_).
attr(inspector_avatar_fallback(O),height,52) :- selected_object(O), not primary_image(O,_,_).
attr(inspector_avatar_fallback(O),pos_x,0) :- selected_object(O), not primary_image(O,_,_).
attr(inspector_avatar_fallback(O),pos_y,0) :- selected_object(O), not primary_image(O,_,_).
attr(inspector_avatar_fallback(O),class,("fw-bold";"fs-3";"text-primary";"text-center";"p-0";"m-0")) :- selected_object(O), not primary_image(O,_,_).
attr(inspector_avatar_fallback(O),"line-height","52px") :- selected_object(O), not primary_image(O,_,_).

elem(inspector_identity,container,inspector_header) :- selected_object(_).
attr(inspector_identity,order,1) :- selected_object(_).
attr(inspector_identity,child_layout,flex) :- selected_object(_).
attr(inspector_identity,flex_direction,column) :- selected_object(_).
attr(inspector_identity,class,("d-flex";"flex-column";"gap-1";"overflow-hidden")) :- selected_object(_).

elem(inspector_selected_badge,label,inspector_identity) :- selected_object(_).
attr(inspector_selected_badge,order,0) :- selected_object(_).
attr(inspector_selected_badge,label,"✓ SELECTED OBJECT") :- selected_object(_).
attr(inspector_selected_badge,class,("badge";"rounded-pill";"text-white";"align-self-start";"px-2";"py-1")) :- selected_object(_).
attr(inspector_selected_badge,"background","linear-gradient(135deg,#2563eb,#7c3aed)") :- selected_object(_).

elem(inspector_name,label,inspector_identity) :- selected_object(_).
attr(inspector_name,order,1) :- selected_object(_).
attr(inspector_name,label,@concat("",L)) :- selected_object(O), object_label(O,L).
attr(inspector_name,class,("fw-bold";"fs-5";"text-primary";"font-monospace";"text-truncate")) :- selected_object(_).

elem(inspector_type,label,inspector_identity) :- selected_object(_).
attr(inspector_type,order,2) :- selected_object(_).
attr(inspector_type,label,@concat("object(",O,", ",T,")")) :- selected_object(O), object(O,T).
attr(inspector_type,class,("small";"text-muted";"font-monospace")) :- selected_object(_).

% Inspector object actions.

elem(inspector_actions,container,inspector_header) :- selected_object(_).
attr(inspector_actions,order,2) :- selected_object(_).
attr(inspector_actions,child_layout,flex) :- selected_object(_).
attr(inspector_actions,flex_direction,row) :- selected_object(_).
attr(inspector_actions,class,("d-flex";"flex-row";"gap-1";"flex-shrink-0")) :- selected_object(_).

elem(object_edit_type(O),button,inspector_actions) :- selected_object(O), user_object(O,_).
attr(object_edit_type(O),order,1) :- selected_object(O), user_object(O,_).
attr(object_edit_type(O),icon,"fa-pen") :- selected_object(O), user_object(O,_).
attr(object_edit_type(O),label,"Type") :- selected_object(O), user_object(O,_).
attr(object_edit_type(O),class,("btn-sm";"btn-outline-primary")) :- selected_object(O), user_object(O,_).
when(object_edit_type(O),click,context,(new_object_type(O),T)) :- selected_object(O), user_object(O,T).
when(object_edit_type(O),click,update,(object_type_modal(O,T),visibility,shown)) :- selected_object(O), user_object(O,T).

elem(object_delete(O),button,inspector_actions) :- selected_object(O), user_object(O,_).
attr(object_delete(O),order,2) :- selected_object(O), user_object(O,_).
attr(object_delete(O),icon,"fa-trash") :- selected_object(O), user_object(O,_).
attr(object_delete(O),class,("btn-sm";"btn-outline-danger")) :- selected_object(O), user_object(O,_).
when(object_delete(O),click,update,(object_delete_modal(O,T),visibility,shown)) :- selected_object(O), user_object(O,T).

% Read-only note for facts loaded from domain files.

elem(static_object_note,label,inspector) :- selected_object(O), not user_object(O,_).
attr(static_object_note,order,2) :- selected_object(O), not user_object(O,_).
attr(static_object_note,label,"The object identity and type come from a domain file. They are read-only with the default backend; properties and positions can still be added.") :- selected_object(O), not user_object(O,_).
attr(static_object_note,class,("small";"text-muted";"bg-light";"border";"rounded-2";"p-2")) :- selected_object(O), not user_object(O,_).

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Properties section
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

elem(properties_section,container,inspector) :- selected_object(_).
attr(properties_section,order,3) :- selected_object(_).
attr(properties_section,child_layout,flex) :- selected_object(_).
attr(properties_section,flex_direction,column) :- selected_object(_).
attr(properties_section,class,("d-flex";"flex-column";"gap-2")) :- selected_object(_).

elem(properties_header,container,properties_section) :- selected_object(_).
attr(properties_header,order,1) :- selected_object(_).
attr(properties_header,child_layout,flex) :- selected_object(_).
attr(properties_header,flex_direction,row) :- selected_object(_).
attr(properties_header,class,("d-flex";"flex-row";"align-items-center";"justify-content-between";"gap-2")) :- selected_object(_).

elem(properties_title,label,properties_header) :- selected_object(_).
attr(properties_title,order,1) :- selected_object(_).
attr(properties_title,label,"Properties") :- selected_object(_).
attr(properties_title,class,("fw-bold";"text-dark")) :- selected_object(_).

elem(property_add,button,properties_header) :- selected_object(_).
attr(property_add,order,2) :- selected_object(_).
attr(property_add,label,"Add") :- selected_object(_).
attr(property_add,icon,"fa-plus") :- selected_object(_).
attr(property_add,class,("btn-primary";"btn-sm")) :- selected_object(_).
when(property_add,click,update,(property_add_modal,visibility,shown)) :- selected_object(_).

elem(properties_empty,label,properties_section) :- selected_object(_), not selected_has_properties.
attr(properties_empty,order,2) :- selected_object(_), not selected_has_properties.
attr(properties_empty,label,"No property/3 facts for this object.") :- selected_object(_), not selected_has_properties.
attr(properties_empty,class,("small";"text-muted";"border";"rounded-2";"p-2";"text-center")) :- selected_object(_), not selected_has_properties.

% Property rows.

elem(property_row(O,K,V),container,properties_section) :- selected_object(O), property(O,K,V).
attr(property_row(O,K,V),order,N2) :- property_rank(O,K,V,N), N2 = N + 10.
attr(property_row(O,K,V),child_layout,flex) :- selected_object(O), property(O,K,V).
attr(property_row(O,K,V),flex_direction,row) :- selected_object(O), property(O,K,V).
attr(property_row(O,K,V),class,("d-flex";"flex-row";"align-items-center";"justify-content-between";"gap-2";"bg-white";"border";"rounded-2";"px-2";"py-2")) :- selected_object(O), property(O,K,V).

elem(property_text(O,K,V),container,property_row(O,K,V)) :- selected_object(O), property(O,K,V).
attr(property_text(O,K,V),order,1) :- selected_object(O), property(O,K,V).
attr(property_text(O,K,V),child_layout,flex) :- selected_object(O), property(O,K,V).
attr(property_text(O,K,V),flex_direction,column) :- selected_object(O), property(O,K,V).
attr(property_text(O,K,V),class,("d-flex";"flex-column";"gap-0";"flex-grow-1";"overflow-hidden")) :- selected_object(O), property(O,K,V).

elem(property_key(O,K,V),label,property_text(O,K,V)) :- selected_object(O), property(O,K,V).
attr(property_key(O,K,V),order,1) :- selected_object(O), property(O,K,V).
attr(property_key(O,K,V),label,@concat("",K)) :- selected_object(O), property(O,K,V).
attr(property_key(O,K,V),class,("small";"fw-bold";"text-primary";"font-monospace";"text-truncate")) :- selected_object(O), property(O,K,V).

elem(property_value(O,K,V),label,property_text(O,K,V)) :- selected_object(O), property(O,K,V).
attr(property_value(O,K,V),order,2) :- selected_object(O), property(O,K,V).
attr(property_value(O,K,V),label,@concat("",V)) :- selected_object(O), property(O,K,V).
attr(property_value(O,K,V),class,("small";"text-muted";"font-monospace";"text-truncate")) :- selected_object(O), property(O,K,V).

% Property action controls are available only for atoms added interactively.

elem(property_actions(O,K,V),container,property_row(O,K,V)) :- selected_object(O), user_property(O,K,V).
attr(property_actions(O,K,V),order,2) :- selected_object(O), user_property(O,K,V).
attr(property_actions(O,K,V),child_layout,flex) :- selected_object(O), user_property(O,K,V).
attr(property_actions(O,K,V),flex_direction,row) :- selected_object(O), user_property(O,K,V).
attr(property_actions(O,K,V),class,("d-flex";"flex-row";"gap-1";"flex-shrink-0")) :- selected_object(O), user_property(O,K,V).

elem(property_edit(O,K,V),button,property_actions(O,K,V)) :- selected_object(O), user_property(O,K,V).
attr(property_edit(O,K,V),order,1) :- selected_object(O), user_property(O,K,V).
attr(property_edit(O,K,V),icon,"fa-pen") :- selected_object(O), user_property(O,K,V).
attr(property_edit(O,K,V),class,("btn-sm";"btn-outline-primary";"border-0")) :- selected_object(O), user_property(O,K,V).
when(property_edit(O,K,V),click,context,(edit_property_object,O)) :- selected_object(O), user_property(O,K,V).
when(property_edit(O,K,V),click,context,(edit_property_key,K)) :- selected_object(O), user_property(O,K,V).
when(property_edit(O,K,V),click,context,(edit_property_value,V)) :- selected_object(O), user_property(O,K,V).
when(property_edit(O,K,V),click,context,(edit_property_new_key,K)) :- selected_object(O), user_property(O,K,V).
when(property_edit(O,K,V),click,context,(edit_property_new_value,V)) :- selected_object(O), user_property(O,K,V).
when(property_edit(O,K,V),click,update,(property_edit_current,label,@concat(K," = ",V))) :- selected_object(O), user_property(O,K,V).
when(property_edit(O,K,V),click,update,(property_edit_modal,visibility,shown)) :- selected_object(O), user_property(O,K,V).

elem(property_remove(O,K,V),button,property_actions(O,K,V)) :- selected_object(O), user_property(O,K,V).
attr(property_remove(O,K,V),order,2) :- selected_object(O), user_property(O,K,V).
attr(property_remove(O,K,V),icon,"fa-trash") :- selected_object(O), user_property(O,K,V).
attr(property_remove(O,K,V),class,("btn-sm";"btn-outline-danger";"border-0")) :- selected_object(O), user_property(O,K,V).
when(property_remove(O,K,V),click,call,remove_atom(property(O,K,V))) :- selected_object(O), user_property(O,K,V).


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Positions section
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

elem(positions_section,container,inspector) :- selected_object(_).
attr(positions_section,order,4) :- selected_object(_).
attr(positions_section,child_layout,flex) :- selected_object(_).
attr(positions_section,flex_direction,column) :- selected_object(_).
attr(positions_section,class,("d-flex";"flex-column";"gap-2";"pt-2";"border-top")) :- selected_object(_).

elem(positions_header,container,positions_section) :- selected_object(_).
attr(positions_header,order,1) :- selected_object(_).
attr(positions_header,child_layout,flex) :- selected_object(_).
attr(positions_header,flex_direction,row) :- selected_object(_).
attr(positions_header,class,("d-flex";"flex-row";"align-items-center";"justify-content-between";"gap-2")) :- selected_object(_).

elem(positions_title,label,positions_header) :- selected_object(_).
attr(positions_title,order,1) :- selected_object(_).
attr(positions_title,label,"Positions") :- selected_object(_).
attr(positions_title,class,("fw-bold";"text-dark")) :- selected_object(_).

elem(position_add,button,positions_header) :- selected_object(_).
attr(position_add,order,2) :- selected_object(_).
attr(position_add,label,"Add") :- selected_object(_).
attr(position_add,icon,"fa-plus") :- selected_object(_).
attr(position_add,class,("btn-primary";"btn-sm")) :- selected_object(_).
when(position_add,click,context,(new_position_role,Role)) :- selected_object(_), effective_role(Role).
when(position_add,click,update,(position_add_modal,visibility,shown)) :- selected_object(_).

elem(positions_empty,label,positions_section) :- selected_object(_), not selected_has_positions.
attr(positions_empty,order,2) :- selected_object(_), not selected_has_positions.
attr(positions_empty,label,"No position/3 facts for this object.") :- selected_object(_), not selected_has_positions.
attr(positions_empty,class,("small";"text-muted";"border";"rounded-2";"p-2";"text-center")) :- selected_object(_), not selected_has_positions.

elem(position_row(O,(R,C),Role),container,positions_section) :- selected_object(O), visible_position((R,C),Role,O).
attr(position_row(O,(R,C),Role),order,N2) :- position_rank(O,(R,C),Role,N), N2 = N + 10.
attr(position_row(O,(R,C),Role),child_layout,flex) :- selected_object(O), visible_position((R,C),Role,O).
attr(position_row(O,(R,C),Role),flex_direction,row) :- selected_object(O), visible_position((R,C),Role,O).
attr(position_row(O,(R,C),Role),class,("d-flex";"flex-row";"align-items-center";"justify-content-between";"gap-2";"bg-white";"border";"rounded-2";"px-2";"py-2")) :- selected_object(O), visible_position((R,C),Role,O).

elem(position_text(O,(R,C),Role),label,position_row(O,(R,C),Role)) :- selected_object(O), visible_position((R,C),Role,O).
attr(position_text(O,(R,C),Role),order,1) :- selected_object(O), visible_position((R,C),Role,O).
attr(position_text(O,(R,C),Role),label,@concat("(",R,",",C,") · ",Role)) :- selected_object(O), visible_position((R,C),Role,O).
attr(position_text(O,(R,C),Role),class,("small";"font-monospace";"text-truncate")) :- selected_object(O), visible_position((R,C),Role,O).

elem(position_actions(O,(R,C),Role),container,position_row(O,(R,C),Role)) :- selected_object(O), user_position((R,C),Role,O).
attr(position_actions(O,(R,C),Role),order,2) :- selected_object(O), user_position((R,C),Role,O).
attr(position_actions(O,(R,C),Role),child_layout,flex) :- selected_object(O), user_position((R,C),Role,O).
attr(position_actions(O,(R,C),Role),flex_direction,row) :- selected_object(O), user_position((R,C),Role,O).
attr(position_actions(O,(R,C),Role),class,("d-flex";"flex-row";"gap-1";"flex-shrink-0")) :- selected_object(O), user_position((R,C),Role,O).

elem(position_edit(O,(R,C),Role),button,position_actions(O,(R,C),Role)) :- selected_object(O), user_position((R,C),Role,O).
attr(position_edit(O,(R,C),Role),order,1) :- selected_object(O), user_position((R,C),Role,O).
attr(position_edit(O,(R,C),Role),icon,"fa-pen") :- selected_object(O), user_position((R,C),Role,O).
attr(position_edit(O,(R,C),Role),class,("btn-sm";"btn-outline-primary";"border-0")) :- selected_object(O), user_position((R,C),Role,O).
when(position_edit(O,(R,C),Role),click,context,(edit_position_object,O)) :- selected_object(O), user_position((R,C),Role,O).
when(position_edit(O,(R,C),Role),click,context,(edit_position_row,R)) :- selected_object(O), user_position((R,C),Role,O).
when(position_edit(O,(R,C),Role),click,context,(edit_position_col,C)) :- selected_object(O), user_position((R,C),Role,O).
when(position_edit(O,(R,C),Role),click,context,(edit_position_role,Role)) :- selected_object(O), user_position((R,C),Role,O).
when(position_edit(O,(R,C),Role),click,context,(edit_position_new_row,R)) :- selected_object(O), user_position((R,C),Role,O).
when(position_edit(O,(R,C),Role),click,context,(edit_position_new_col,C)) :- selected_object(O), user_position((R,C),Role,O).
when(position_edit(O,(R,C),Role),click,context,(edit_position_new_role,Role)) :- selected_object(O), user_position((R,C),Role,O).
when(position_edit(O,(R,C),Role),click,update,(position_edit_current,label,@concat("Current: (",R,",",C,") · ",Role))) :- selected_object(O), user_position((R,C),Role,O).
when(position_edit(O,(R,C),Role),click,update,(position_edit_modal,visibility,shown)) :- selected_object(O), user_position((R,C),Role,O).

elem(position_remove(O,(R,C),Role),button,position_actions(O,(R,C),Role)) :- selected_object(O), user_position((R,C),Role,O).
attr(position_remove(O,(R,C),Role),order,2) :- selected_object(O), user_position((R,C),Role,O).
attr(position_remove(O,(R,C),Role),icon,"fa-trash") :- selected_object(O), user_position((R,C),Role,O).
attr(position_remove(O,(R,C),Role),class,("btn-sm";"btn-outline-danger";"border-0")) :- selected_object(O), user_position((R,C),Role,O).
when(position_remove(O,(R,C),Role),click,update,(position_remove_modal(R,C,Role,O),visibility,shown)) :- selected_object(O), active_user_position((R,C),Role,O).

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Optional image metadata section
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

elem(images_section,container,inspector) :- selected_object(_).
attr(images_section,order,5) :- selected_object(_).
attr(images_section,child_layout,flex) :- selected_object(_).
attr(images_section,flex_direction,column) :- selected_object(_).
attr(images_section,class,("d-flex";"flex-column";"gap-2";"pt-2";"border-top")) :- selected_object(_).

elem(images_header,container,images_section) :- selected_object(_).
attr(images_header,order,1) :- selected_object(_).
attr(images_header,child_layout,flex) :- selected_object(_).
attr(images_header,flex_direction,row) :- selected_object(_).
attr(images_header,class,("d-flex";"flex-row";"align-items-center";"justify-content-between";"gap-2")) :- selected_object(_).

elem(images_title,label,images_header) :- selected_object(_).
attr(images_title,order,1) :- selected_object(_).
attr(images_title,label,"Presentation images") :- selected_object(_).
attr(images_title,class,("fw-bold";"text-dark")) :- selected_object(_).

elem(image_add,button,images_header) :- selected_object(_).
attr(image_add,order,2) :- selected_object(_).
attr(image_add,label,"Add") :- selected_object(_).
attr(image_add,icon,"fa-image") :- selected_object(_).
attr(image_add,class,("btn-outline-primary";"btn-sm")) :- selected_object(_).
when(image_add,click,context,(new_image_role,Role)) :- selected_object(_), effective_role(Role).
when(image_add,click,update,(image_add_modal,visibility,shown)) :- selected_object(_).

elem(images_empty,label,images_section) :- selected_object(_), not selected_has_images.
attr(images_empty,order,2) :- selected_object(_), not selected_has_images.
attr(images_empty,label,"No image/3 metadata for this object. Text fallback remains active.") :- selected_object(_), not selected_has_images.
attr(images_empty,class,("small";"text-muted";"border";"rounded-2";"p-2";"text-center")) :- selected_object(_), not selected_has_images.

elem(image_row(O,Role,I),container,images_section) :- selected_object(O), object_image(O,Role,I).
attr(image_row(O,Role,I),order,N2) :- image_rank(O,Role,I,N), N2 = N + 10.
attr(image_row(O,Role,I),child_layout,flex) :- selected_object(O), object_image(O,Role,I).
attr(image_row(O,Role,I),flex_direction,row) :- selected_object(O), object_image(O,Role,I).
attr(image_row(O,Role,I),class,("d-flex";"flex-row";"align-items-center";"gap-2";"bg-white";"border";"rounded-2";"p-2")) :- selected_object(O), object_image(O,Role,I).

elem(image_preview(O,Role,I),canvas,image_row(O,Role,I)) :- selected_object(O), object_image(O,Role,I).
attr(image_preview(O,Role,I),order,1) :- selected_object(O), object_image(O,Role,I).
attr(image_preview(O,Role,I),image,I) :- selected_object(O), object_image(O,Role,I).
attr(image_preview(O,Role,I),width,36) :- selected_object(O), object_image(O,Role,I).
attr(image_preview(O,Role,I),height,36) :- selected_object(O), object_image(O,Role,I).
attr(image_preview(O,Role,I),class,("p-0";"m-0";"border";"rounded-2";"bg-light";"flex-shrink-0")) :- selected_object(O), object_image(O,Role,I).

elem(image_text(O,Role,I),label,image_row(O,Role,I)) :- selected_object(O), object_image(O,Role,I).
attr(image_text(O,Role,I),order,2) :- selected_object(O), object_image(O,Role,I).
attr(image_text(O,Role,I),label,@concat(Role," · ",I)) :- selected_object(O), object_image(O,Role,I).
attr(image_text(O,Role,I),class,("small";"font-monospace";"text-muted";"text-truncate";"flex-grow-1")) :- selected_object(O), object_image(O,Role,I).

elem(image_actions(O,Role,I),container,image_row(O,Role,I)) :- selected_object(O), user_image(O,Role,I).
attr(image_actions(O,Role,I),order,3) :- selected_object(O), user_image(O,Role,I).
attr(image_actions(O,Role,I),child_layout,flex) :- selected_object(O), user_image(O,Role,I).
attr(image_actions(O,Role,I),flex_direction,row) :- selected_object(O), user_image(O,Role,I).
attr(image_actions(O,Role,I),class,("d-flex";"flex-row";"gap-1";"flex-shrink-0")) :- selected_object(O), user_image(O,Role,I).

elem(image_edit(O,Role,I),button,image_actions(O,Role,I)) :- selected_object(O), user_image(O,Role,I).
attr(image_edit(O,Role,I),order,1) :- selected_object(O), user_image(O,Role,I).
attr(image_edit(O,Role,I),icon,"fa-pen") :- selected_object(O), user_image(O,Role,I).
attr(image_edit(O,Role,I),class,("btn-sm";"btn-outline-primary";"border-0")) :- selected_object(O), user_image(O,Role,I).
when(image_edit(O,Role,I),click,context,(edit_image_object,O)) :- selected_object(O), user_image(O,Role,I).
when(image_edit(O,Role,I),click,context,(edit_image_role,Role)) :- selected_object(O), user_image(O,Role,I).
when(image_edit(O,Role,I),click,context,(edit_image_path,I)) :- selected_object(O), user_image(O,Role,I).
when(image_edit(O,Role,I),click,context,(edit_image_new_role,Role)) :- selected_object(O), user_image(O,Role,I).
when(image_edit(O,Role,I),click,context,(edit_image_new_path,I)) :- selected_object(O), user_image(O,Role,I).
when(image_edit(O,Role,I),click,update,(image_edit_current,label,@concat("Current: ",Role," · ",I))) :- selected_object(O), user_image(O,Role,I).
when(image_edit(O,Role,I),click,update,(image_edit_modal,visibility,shown)) :- selected_object(O), user_image(O,Role,I).

elem(image_remove(O,Role,I),button,image_actions(O,Role,I)) :- selected_object(O), user_image(O,Role,I).
attr(image_remove(O,Role,I),order,2) :- selected_object(O), user_image(O,Role,I).
attr(image_remove(O,Role,I),icon,"fa-trash") :- selected_object(O), user_image(O,Role,I).
attr(image_remove(O,Role,I),class,("btn-sm";"btn-outline-danger";"border-0")) :- selected_object(O), user_image(O,Role,I).
when(image_remove(O,Role,I),click,call,remove_atom(image(O,Role,I))) :- selected_object(O), user_image(O,Role,I).

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% CREATE OBJECT MODAL
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

elem(object_create_modal,modal,w).
attr(object_create_modal,title,"Create object").
attr(object_create_modal,size,"lg").
attr(object_create_modal,visibility,hidden).
attr(object_create_modal,class,"fade").

elem(object_create_content,container,object_create_modal).
attr(object_create_content,child_layout,flex).
attr(object_create_content,flex_direction,column).
attr(object_create_content,class,("d-flex";"flex-column";"gap-3";"p-2")).

elem(object_create_intro,label,object_create_content).
attr(object_create_intro,order,1).
attr(object_create_intro,label,"Enter valid ASP terms. Examples: item(1), resource(alpha), device.").
attr(object_create_intro,class,("small";"text-muted";"bg-light";"border";"rounded-2";"p-2")).

elem(new_object_term,textfield,object_create_content).
attr(new_object_term,order,2).
attr(new_object_term,placeholder,"Object term").
attr(new_object_term,class,"font-monospace").
when(new_object_term,input,context,(new_object_term,_value)).

elem(new_object_type,textfield,object_create_content).
attr(new_object_type,order,3).
attr(new_object_type,placeholder,"Type term").
attr(new_object_type,class,"font-monospace").
when(new_object_type,input,context,(new_object_type,_value)).

elem(object_create_actions,container,object_create_content).
attr(object_create_actions,order,4).
attr(object_create_actions,child_layout,flex).
attr(object_create_actions,flex_direction,row).
attr(object_create_actions,class,("d-flex";"flex-row";"justify-content-end";"gap-2")).

elem(object_create_cancel,button,object_create_actions).
attr(object_create_cancel,order,1).
attr(object_create_cancel,label,"Cancel").
attr(object_create_cancel,class,"btn-outline-secondary").
when(object_create_cancel,click,update,(object_create_modal,visibility,hidden)).

elem(object_create_save,button,object_create_actions).
attr(object_create_save,order,2).
attr(object_create_save,label,"Create object").
attr(object_create_save,icon,"fa-plus").
attr(object_create_save,class,("btn-primary";"fw-bold")).
when(object_create_save,click,update,(object_create_modal,visibility,hidden)).
when(object_create_save,click,call,add_atom(object(_context_value(new_object_term,const),_context_value(new_object_type,const)))).

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% EDIT USER-CREATED OBJECT TYPE MODALS
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

elem(object_type_modal(O,T),modal,w) :- user_object(O,T).
attr(object_type_modal(O,T),title,"Edit object type") :- user_object(O,T).
attr(object_type_modal(O,T),size,"m") :- user_object(O,T).
attr(object_type_modal(O,T),visibility,hidden) :- user_object(O,T).
attr(object_type_modal(O,T),class,"fade") :- user_object(O,T).

elem(object_type_content(O,T),container,object_type_modal(O,T)) :- user_object(O,T).
attr(object_type_content(O,T),child_layout,flex) :- user_object(O,T).
attr(object_type_content(O,T),flex_direction,column) :- user_object(O,T).
attr(object_type_content(O,T),class,("d-flex";"flex-column";"gap-3";"p-2")) :- user_object(O,T).

elem(object_type_current(O,T),label,object_type_content(O,T)) :- user_object(O,T).
attr(object_type_current(O,T),order,1) :- user_object(O,T).
attr(object_type_current(O,T),label,@concat("Current: object(",O,", ",T,")")) :- user_object(O,T).
attr(object_type_current(O,T),class,("small";"text-muted";"font-monospace";"bg-light";"border";"rounded-2";"p-2")) :- user_object(O,T).

elem(object_type_input(O,T),textfield,object_type_content(O,T)) :- user_object(O,T).
attr(object_type_input(O,T),order,2) :- user_object(O,T).
attr(object_type_input(O,T),placeholder,"New type term") :- user_object(O,T).
attr(object_type_input(O,T),class,"font-monospace") :- user_object(O,T).
when(object_type_input(O,T),input,context,(new_object_type(O),_value)) :- user_object(O,T).

elem(object_type_actions(O,T),container,object_type_content(O,T)) :- user_object(O,T).
attr(object_type_actions(O,T),order,3) :- user_object(O,T).
attr(object_type_actions(O,T),child_layout,flex) :- user_object(O,T).
attr(object_type_actions(O,T),flex_direction,row) :- user_object(O,T).
attr(object_type_actions(O,T),class,("d-flex";"flex-row";"justify-content-end";"gap-2")) :- user_object(O,T).

elem(object_type_cancel(O,T),button,object_type_actions(O,T)) :- user_object(O,T).
attr(object_type_cancel(O,T),order,1) :- user_object(O,T).
attr(object_type_cancel(O,T),label,"Cancel") :- user_object(O,T).
attr(object_type_cancel(O,T),class,"btn-outline-secondary") :- user_object(O,T).
when(object_type_cancel(O,T),click,update,(object_type_modal(O,T),visibility,hidden)) :- user_object(O,T).

elem(object_type_save(O,T),button,object_type_actions(O,T)) :- user_object(O,T).
attr(object_type_save(O,T),order,2) :- user_object(O,T).
attr(object_type_save(O,T),label,"Save type") :- user_object(O,T).
attr(object_type_save(O,T),icon,"fa-check") :- user_object(O,T).
attr(object_type_save(O,T),class,"btn-primary") :- user_object(O,T).
when(object_type_save(O,T),click,update,(object_type_modal(O,T),visibility,hidden)) :- user_object(O,T).
when(object_type_save(O,T),click,call,(remove_atom(object(O,T)),add_atom(object(O,_context_value(new_object_type(O),const))))) :- user_object(O,T).

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% DELETE USER-CREATED OBJECT MODALS
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

elem(object_delete_modal(O,T),modal,w) :- user_object(O,T).
attr(object_delete_modal(O,T),title,"Delete object") :- user_object(O,T).
attr(object_delete_modal(O,T),size,"m") :- user_object(O,T).
attr(object_delete_modal(O,T),visibility,hidden) :- user_object(O,T).
attr(object_delete_modal(O,T),class,"fade") :- user_object(O,T).

elem(object_delete_content(O,T),container,object_delete_modal(O,T)) :- user_object(O,T).
attr(object_delete_content(O,T),child_layout,flex) :- user_object(O,T).
attr(object_delete_content(O,T),flex_direction,column) :- user_object(O,T).
attr(object_delete_content(O,T),class,("d-flex";"flex-column";"gap-3";"p-2")) :- user_object(O,T).

elem(object_delete_warning(O,T),label,object_delete_content(O,T)) :- user_object(O,T).
attr(object_delete_warning(O,T),order,1) :- user_object(O,T).
attr(object_delete_warning(O,T),label,@concat("Delete ",O," and all interactive properties, positions and images attached to it?")) :- user_object(O,T).
attr(object_delete_warning(O,T),class,("small";"text-danger";"fw-bold";"bg-light";"border";"border-danger";"rounded-3";"p-3")) :- user_object(O,T).

elem(object_delete_actions(O,T),container,object_delete_content(O,T)) :- user_object(O,T).
attr(object_delete_actions(O,T),order,2) :- user_object(O,T).
attr(object_delete_actions(O,T),child_layout,flex) :- user_object(O,T).
attr(object_delete_actions(O,T),flex_direction,row) :- user_object(O,T).
attr(object_delete_actions(O,T),class,("d-flex";"flex-row";"justify-content-end";"gap-2")) :- user_object(O,T).

elem(object_delete_cancel(O,T),button,object_delete_actions(O,T)) :- user_object(O,T).
attr(object_delete_cancel(O,T),order,1) :- user_object(O,T).
attr(object_delete_cancel(O,T),label,"Cancel") :- user_object(O,T).
attr(object_delete_cancel(O,T),class,"btn-outline-secondary") :- user_object(O,T).
when(object_delete_cancel(O,T),click,update,(object_delete_modal(O,T),visibility,hidden)) :- user_object(O,T).

elem(object_delete_confirm(O,T),button,object_delete_actions(O,T)) :- user_object(O,T).
attr(object_delete_confirm(O,T),order,2) :- user_object(O,T).
attr(object_delete_confirm(O,T),label,"Delete") :- user_object(O,T).
attr(object_delete_confirm(O,T),icon,"fa-trash") :- user_object(O,T).
attr(object_delete_confirm(O,T),class,"btn-danger") :- user_object(O,T).
when(object_delete_confirm(O,T),click,update,(object_delete_modal(O,T),visibility,hidden)) :- user_object(O,T).
when(object_delete_confirm(O,T),click,context,(selected_object,none)) :- user_object(O,T).
when(object_delete_confirm(O,T),click,call,remove_atom(property(O,K,V))) :- user_object(O,T), user_property(O,K,V).
when(object_delete_confirm(O,T),click,call,remove_atom(position(Node,Role,O))) :- user_object(O,T), user_position(Node,Role,O).
when(object_delete_confirm(O,T),click,call,remove_atom(image(O,Role,I))) :- user_object(O,T), user_image(O,Role,I).
when(object_delete_confirm(O,T),click,call,remove_atom(object(O,T))) :- user_object(O,T).

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% ADD PROPERTY MODAL
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

elem(property_add_modal,modal,w) :- selected_object(_).
attr(property_add_modal,title,"Add property") :- selected_object(_).
attr(property_add_modal,size,"lg") :- selected_object(_).
attr(property_add_modal,visibility,hidden) :- selected_object(_).
attr(property_add_modal,class,"fade") :- selected_object(_).

elem(property_add_content,container,property_add_modal) :- selected_object(_).
attr(property_add_content,child_layout,flex) :- selected_object(_).
attr(property_add_content,flex_direction,column) :- selected_object(_).
attr(property_add_content,class,("d-flex";"flex-column";"gap-3";"p-2")) :- selected_object(_).

elem(property_add_target,label,property_add_content) :- selected_object(_).
attr(property_add_target,order,1) :- selected_object(_).
attr(property_add_target,label,@concat("Target: ",O)) :- selected_object(O).
attr(property_add_target,class,("small";"text-primary";"font-monospace";"fw-bold")) :- selected_object(_).

elem(new_property_key,textfield,property_add_content) :- selected_object(_).
attr(new_property_key,order,2) :- selected_object(_).
attr(new_property_key,placeholder,"Property key (ASP term)") :- selected_object(_).
attr(new_property_key,class,"font-monospace") :- selected_object(_).
when(new_property_key,input,context,(new_property_key,_value)) :- selected_object(_).

elem(new_property_value,textfield,property_add_content) :- selected_object(_).
attr(new_property_value,order,3) :- selected_object(_).
attr(new_property_value,placeholder,"Property value") :- selected_object(_).
attr(new_property_value,class,"font-monospace") :- selected_object(_).
when(new_property_value,input,context,(new_property_value,_value)) :- selected_object(_).

elem(property_add_actions,container,property_add_content) :- selected_object(_).
attr(property_add_actions,order,4) :- selected_object(_).
attr(property_add_actions,child_layout,flex) :- selected_object(_).
attr(property_add_actions,flex_direction,row) :- selected_object(_).
attr(property_add_actions,class,("d-flex";"flex-row";"gap-2";"flex-wrap";"justify-content-end")) :- selected_object(_).

elem(property_add_cancel,button,property_add_actions) :- selected_object(_).
attr(property_add_cancel,order,1) :- selected_object(_).
attr(property_add_cancel,label,"Cancel") :- selected_object(_).
attr(property_add_cancel,class,"btn-outline-secondary") :- selected_object(_).
when(property_add_cancel,click,update,(property_add_modal,visibility,hidden)) :- selected_object(_).

% Add value as ASP term.

elem(property_add_term,button,property_add_actions) :- selected_object(_).
attr(property_add_term,order,2) :- selected_object(_).
attr(property_add_term,label,"As term") :- selected_object(_).
attr(property_add_term,icon,"fa-code") :- selected_object(_).
attr(property_add_term,class,"btn-outline-primary") :- selected_object(_).
when(property_add_term,click,update,(property_add_modal,visibility,hidden)) :- selected_object(_).
when(property_add_term,click,call,add_atom(property(O,_context_value(new_property_key,const),_context_value(new_property_value,const)))) :- selected_object(O).

% Add value as integer.

elem(property_add_int,button,property_add_actions) :- selected_object(_).
attr(property_add_int,order,3) :- selected_object(_).
attr(property_add_int,label,"As integer") :- selected_object(_).
attr(property_add_int,icon,"fa-hashtag") :- selected_object(_).
attr(property_add_int,class,"btn-outline-primary") :- selected_object(_).
when(property_add_int,click,update,(property_add_modal,visibility,hidden)) :- selected_object(_).
when(property_add_int,click,call,add_atom(property(O,_context_value(new_property_key,const),_context_value(new_property_value,int)))) :- selected_object(O).

% Add value as string.

elem(property_add_string,button,property_add_actions) :- selected_object(_).
attr(property_add_string,order,4) :- selected_object(_).
attr(property_add_string,label,"As text") :- selected_object(_).
attr(property_add_string,icon,"fa-font") :- selected_object(_).
attr(property_add_string,class,"btn-primary") :- selected_object(_).
when(property_add_string,click,update,(property_add_modal,visibility,hidden)) :- selected_object(_).
when(property_add_string,click,call,add_atom(property(O,_context_value(new_property_key,const),_context_value(new_property_value,str)))) :- selected_object(O).

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% EDIT PROPERTY MODAL
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

elem(property_edit_modal,modal,w) :- selected_object(_).
attr(property_edit_modal,title,"Edit property") :- selected_object(_).
attr(property_edit_modal,size,"lg") :- selected_object(_).
attr(property_edit_modal,visibility,hidden) :- selected_object(_).
attr(property_edit_modal,class,"fade") :- selected_object(_).

elem(property_edit_content,container,property_edit_modal) :- selected_object(_).
attr(property_edit_content,child_layout,flex) :- selected_object(_).
attr(property_edit_content,flex_direction,column) :- selected_object(_).
attr(property_edit_content,class,("d-flex";"flex-column";"gap-3";"p-2")) :- selected_object(_).

elem(property_edit_current,label,property_edit_content) :- selected_object(_).
attr(property_edit_current,order,1) :- selected_object(_).
attr(property_edit_current,label,"Select an interactive property to edit.") :- selected_object(_).
attr(property_edit_current,class,("small";"text-muted";"font-monospace";"bg-light";"border";"rounded-2";"p-2")) :- selected_object(_).

elem(edit_property_new_key,textfield,property_edit_content) :- selected_object(_).
attr(edit_property_new_key,order,2) :- selected_object(_).
attr(edit_property_new_key,placeholder,"New property key") :- selected_object(_).
attr(edit_property_new_key,class,"font-monospace") :- selected_object(_).
when(edit_property_new_key,input,context,(edit_property_new_key,_value)) :- selected_object(_).

elem(edit_property_new_value,textfield,property_edit_content) :- selected_object(_).
attr(edit_property_new_value,order,3) :- selected_object(_).
attr(edit_property_new_value,placeholder,"New property value") :- selected_object(_).
attr(edit_property_new_value,class,"font-monospace") :- selected_object(_).
when(edit_property_new_value,input,context,(edit_property_new_value,_value)) :- selected_object(_).

elem(property_edit_actions,container,property_edit_content) :- selected_object(_).
attr(property_edit_actions,order,4) :- selected_object(_).
attr(property_edit_actions,child_layout,flex) :- selected_object(_).
attr(property_edit_actions,flex_direction,row) :- selected_object(_).
attr(property_edit_actions,class,("d-flex";"flex-row";"gap-2";"flex-wrap";"justify-content-end")) :- selected_object(_).

elem(property_edit_cancel,button,property_edit_actions) :- selected_object(_).
attr(property_edit_cancel,order,1) :- selected_object(_).
attr(property_edit_cancel,label,"Cancel") :- selected_object(_).
attr(property_edit_cancel,class,"btn-outline-secondary") :- selected_object(_).
when(property_edit_cancel,click,update,(property_edit_modal,visibility,hidden)) :- selected_object(_).

% Edit value as ASP term.

elem(property_edit_term,button,property_edit_actions) :- selected_object(_).
attr(property_edit_term,order,2) :- selected_object(_).
attr(property_edit_term,label,"As term") :- selected_object(_).
attr(property_edit_term,icon,"fa-code") :- selected_object(_).
attr(property_edit_term,class,"btn-outline-primary") :- selected_object(_).
when(property_edit_term,click,update,(property_edit_modal,visibility,hidden)) :- selected_object(_).
when(property_edit_term,click,call,(remove_atom(property(_context_value(edit_property_object),_context_value(edit_property_key),_context_value(edit_property_value))),add_atom(property(_context_value(edit_property_object),_context_value(edit_property_new_key,const),_context_value(edit_property_new_value,const))))) :- selected_object(_).

% Edit value as integer.

elem(property_edit_int,button,property_edit_actions) :- selected_object(_).
attr(property_edit_int,order,3) :- selected_object(_).
attr(property_edit_int,label,"As integer") :- selected_object(_).
attr(property_edit_int,icon,"fa-hashtag") :- selected_object(_).
attr(property_edit_int,class,"btn-outline-primary") :- selected_object(_).
when(property_edit_int,click,update,(property_edit_modal,visibility,hidden)) :- selected_object(_).
when(property_edit_int,click,call,(remove_atom(property(_context_value(edit_property_object),_context_value(edit_property_key),_context_value(edit_property_value))),add_atom(property(_context_value(edit_property_object),_context_value(edit_property_new_key,const),_context_value(edit_property_new_value,int))))) :- selected_object(_).

% Edit value as string.

elem(property_edit_string,button,property_edit_actions) :- selected_object(_).
attr(property_edit_string,order,4) :- selected_object(_).
attr(property_edit_string,label,"As text") :- selected_object(_).
attr(property_edit_string,icon,"fa-font") :- selected_object(_).
attr(property_edit_string,class,"btn-primary") :- selected_object(_).
when(property_edit_string,click,update,(property_edit_modal,visibility,hidden)) :- selected_object(_).
when(property_edit_string,click,call,(remove_atom(property(_context_value(edit_property_object),_context_value(edit_property_key),_context_value(edit_property_value))),add_atom(property(_context_value(edit_property_object),_context_value(edit_property_new_key,const),_context_value(edit_property_new_value,str))))) :- selected_object(_).

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% ADD POSITION MODAL
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

elem(position_add_modal,modal,w) :- selected_object(_).
attr(position_add_modal,title,"Add two-dimensional position") :- selected_object(_).
attr(position_add_modal,size,"lg") :- selected_object(_).
attr(position_add_modal,visibility,hidden) :- selected_object(_).
attr(position_add_modal,class,"fade") :- selected_object(_).

elem(position_add_content,container,position_add_modal) :- selected_object(_).
attr(position_add_content,child_layout,flex) :- selected_object(_).
attr(position_add_content,flex_direction,column) :- selected_object(_).
attr(position_add_content,class,("d-flex";"flex-column";"gap-3";"p-2")) :- selected_object(_).

elem(position_add_target,label,position_add_content) :- selected_object(_).
attr(position_add_target,order,1) :- selected_object(_).
attr(position_add_target,label,@concat("Target: ",O)) :- selected_object(O).
attr(position_add_target,class,("small";"text-primary";"font-monospace";"fw-bold")) :- selected_object(_).

elem(new_position_row,textfield,position_add_content) :- selected_object(_).
attr(new_position_row,order,2) :- selected_object(_).
attr(new_position_row,placeholder,"Row integer") :- selected_object(_).
attr(new_position_row,class,"font-monospace") :- selected_object(_).
when(new_position_row,input,context,(new_position_row,_value)) :- selected_object(_).

elem(new_position_col,textfield,position_add_content) :- selected_object(_).
attr(new_position_col,order,3) :- selected_object(_).
attr(new_position_col,placeholder,"Column integer") :- selected_object(_).
attr(new_position_col,class,"font-monospace") :- selected_object(_).
when(new_position_col,input,context,(new_position_col,_value)) :- selected_object(_).

elem(new_position_role,textfield,position_add_content) :- selected_object(_).
attr(new_position_role,order,4) :- selected_object(_).
attr(new_position_role,placeholder,"Role ASP term") :- selected_object(_).
attr(new_position_role,class,"font-monospace") :- selected_object(_).
when(new_position_role,input,context,(new_position_role,_value)) :- selected_object(_).

elem(position_add_actions,container,position_add_content) :- selected_object(_).
attr(position_add_actions,order,5) :- selected_object(_).
attr(position_add_actions,child_layout,flex) :- selected_object(_).
attr(position_add_actions,flex_direction,row) :- selected_object(_).
attr(position_add_actions,class,("d-flex";"flex-row";"justify-content-end";"gap-2")) :- selected_object(_).

elem(position_add_cancel,button,position_add_actions) :- selected_object(_).
attr(position_add_cancel,order,1) :- selected_object(_).
attr(position_add_cancel,label,"Cancel") :- selected_object(_).
attr(position_add_cancel,class,"btn-outline-secondary") :- selected_object(_).
when(position_add_cancel,click,update,(position_add_modal,visibility,hidden)) :- selected_object(_).

elem(position_add_save,button,position_add_actions) :- selected_object(_).
attr(position_add_save,order,2) :- selected_object(_).
attr(position_add_save,label,"Add position") :- selected_object(_).
attr(position_add_save,icon,"fa-location-dot") :- selected_object(_).
attr(position_add_save,class,("btn-primary";"fw-bold")) :- selected_object(_).
when(position_add_save,click,update,(position_add_modal,visibility,hidden)) :- selected_object(_).
when(position_add_save,click,call,add_atom(position((_context_value(new_position_row,int),_context_value(new_position_col,int)),_context_value(new_position_role,const),O))) :- selected_object(O).

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% EDIT POSITION MODAL
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

elem(position_edit_modal,modal,w) :- selected_object(_).
attr(position_edit_modal,title,"Edit interactive position") :- selected_object(_).
attr(position_edit_modal,size,"lg") :- selected_object(_).
attr(position_edit_modal,visibility,hidden) :- selected_object(_).
attr(position_edit_modal,class,"fade") :- selected_object(_).

elem(position_edit_content,container,position_edit_modal) :- selected_object(_).
attr(position_edit_content,child_layout,flex) :- selected_object(_).
attr(position_edit_content,flex_direction,column) :- selected_object(_).
attr(position_edit_content,class,("d-flex";"flex-column";"gap-3";"p-2")) :- selected_object(_).

elem(position_edit_current,label,position_edit_content) :- selected_object(_).
attr(position_edit_current,order,1) :- selected_object(_).
attr(position_edit_current,label,"Select an interactive position to edit.") :- selected_object(_).
attr(position_edit_current,class,("small";"text-muted";"font-monospace";"bg-light";"border";"rounded-2";"p-2")) :- selected_object(_).

elem(edit_position_new_row,textfield,position_edit_content) :- selected_object(_).
attr(edit_position_new_row,order,2) :- selected_object(_).
attr(edit_position_new_row,placeholder,"New row; leave untouched to keep current") :- selected_object(_).
attr(edit_position_new_row,class,"font-monospace") :- selected_object(_).
when(edit_position_new_row,input,context,(edit_position_new_row,_value)) :- selected_object(_).

elem(edit_position_new_col,textfield,position_edit_content) :- selected_object(_).
attr(edit_position_new_col,order,3) :- selected_object(_).
attr(edit_position_new_col,placeholder,"New column; leave untouched to keep current") :- selected_object(_).
attr(edit_position_new_col,class,"font-monospace") :- selected_object(_).
when(edit_position_new_col,input,context,(edit_position_new_col,_value)) :- selected_object(_).

elem(edit_position_new_role,textfield,position_edit_content) :- selected_object(_).
attr(edit_position_new_role,order,4) :- selected_object(_).
attr(edit_position_new_role,placeholder,"New role; leave untouched to keep current") :- selected_object(_).
attr(edit_position_new_role,class,"font-monospace") :- selected_object(_).
when(edit_position_new_role,input,context,(edit_position_new_role,_value)) :- selected_object(_).

elem(position_edit_actions,container,position_edit_content) :- selected_object(_).
attr(position_edit_actions,order,5) :- selected_object(_).
attr(position_edit_actions,child_layout,flex) :- selected_object(_).
attr(position_edit_actions,flex_direction,row) :- selected_object(_).
attr(position_edit_actions,class,("d-flex";"flex-row";"justify-content-end";"gap-2")) :- selected_object(_).

elem(position_edit_cancel,button,position_edit_actions) :- selected_object(_).
attr(position_edit_cancel,order,1) :- selected_object(_).
attr(position_edit_cancel,label,"Cancel") :- selected_object(_).
attr(position_edit_cancel,class,"btn-outline-secondary") :- selected_object(_).
when(position_edit_cancel,click,update,(position_edit_modal,visibility,hidden)) :- selected_object(_).

elem(position_edit_save,button,position_edit_actions) :- selected_object(_).
attr(position_edit_save,order,2) :- selected_object(_).
attr(position_edit_save,label,"Save position") :- selected_object(_).
attr(position_edit_save,icon,"fa-check") :- selected_object(_).
attr(position_edit_save,class,"btn-primary") :- selected_object(_).
when(position_edit_save,click,update,(position_edit_modal,visibility,hidden)) :- selected_object(_).
when(position_edit_save,click,call,(remove_atom(position((_context_value(edit_position_row),_context_value(edit_position_col)),_context_value(edit_position_role),_context_value(edit_position_object))),add_atom(position((_context_value(edit_position_new_row,int),_context_value(edit_position_new_col,int)),_context_value(edit_position_new_role,const),_context_value(edit_position_object))))) :- selected_object(_).

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% ADD IMAGE METADATA MODAL
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

elem(image_add_modal,modal,w) :- selected_object(_).
attr(image_add_modal,title,"Add image presentation metadata") :- selected_object(_).
attr(image_add_modal,size,"lg") :- selected_object(_).
attr(image_add_modal,visibility,hidden) :- selected_object(_).
attr(image_add_modal,class,"fade") :- selected_object(_).

elem(image_add_content,container,image_add_modal) :- selected_object(_).
attr(image_add_content,child_layout,flex) :- selected_object(_).
attr(image_add_content,flex_direction,column) :- selected_object(_).
attr(image_add_content,class,("d-flex";"flex-column";"gap-3";"p-2")) :- selected_object(_).

elem(image_add_intro,label,image_add_content) :- selected_object(_).
attr(image_add_intro,order,1) :- selected_object(_).
attr(image_add_intro,label,"The path must point to an image served by the Angular frontend.") :- selected_object(_).
attr(image_add_intro,class,("small";"text-muted";"bg-light";"border";"rounded-2";"p-2")) :- selected_object(_).

elem(new_image_role,textfield,image_add_content) :- selected_object(_).
attr(new_image_role,order,2) :- selected_object(_).
attr(new_image_role,placeholder,"Role ASP term") :- selected_object(_).
attr(new_image_role,class,"font-monospace") :- selected_object(_).
when(new_image_role,input,context,(new_image_role,_value)) :- selected_object(_).

elem(new_image_path,textfield,image_add_content) :- selected_object(_).
attr(new_image_path,order,3) :- selected_object(_).
attr(new_image_path,placeholder,"Local image path, for example img/item.png") :- selected_object(_).
attr(new_image_path,class,"font-monospace") :- selected_object(_).
when(new_image_path,input,context,(new_image_path,_value)) :- selected_object(_).

elem(image_add_actions,container,image_add_content) :- selected_object(_).
attr(image_add_actions,order,4) :- selected_object(_).
attr(image_add_actions,child_layout,flex) :- selected_object(_).
attr(image_add_actions,flex_direction,row) :- selected_object(_).
attr(image_add_actions,class,("d-flex";"flex-row";"justify-content-end";"gap-2")) :- selected_object(_).

elem(image_add_cancel,button,image_add_actions) :- selected_object(_).
attr(image_add_cancel,order,1) :- selected_object(_).
attr(image_add_cancel,label,"Cancel") :- selected_object(_).
attr(image_add_cancel,class,"btn-outline-secondary") :- selected_object(_).
when(image_add_cancel,click,update,(image_add_modal,visibility,hidden)) :- selected_object(_).

elem(image_add_save,button,image_add_actions) :- selected_object(_).
attr(image_add_save,order,2) :- selected_object(_).
attr(image_add_save,label,"Add image") :- selected_object(_).
attr(image_add_save,icon,"fa-image") :- selected_object(_).
attr(image_add_save,class,"btn-primary") :- selected_object(_).
when(image_add_save,click,update,(image_add_modal,visibility,hidden)) :- selected_object(_).
when(image_add_save,click,call,add_atom(image(O,_context_value(new_image_role,const),_context_value(new_image_path,str)))) :- selected_object(O).

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% EDIT IMAGE METADATA MODAL
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

elem(image_edit_modal,modal,w) :- selected_object(_).
attr(image_edit_modal,title,"Edit interactive image metadata") :- selected_object(_).
attr(image_edit_modal,size,"lg") :- selected_object(_).
attr(image_edit_modal,visibility,hidden) :- selected_object(_).
attr(image_edit_modal,class,"fade") :- selected_object(_).

elem(image_edit_content,container,image_edit_modal) :- selected_object(_).
attr(image_edit_content,child_layout,flex) :- selected_object(_).
attr(image_edit_content,flex_direction,column) :- selected_object(_).
attr(image_edit_content,class,("d-flex";"flex-column";"gap-3";"p-2")) :- selected_object(_).

elem(image_edit_current,label,image_edit_content) :- selected_object(_).
attr(image_edit_current,order,1) :- selected_object(_).
attr(image_edit_current,label,"Select interactive image metadata to edit.") :- selected_object(_).
attr(image_edit_current,class,("small";"text-muted";"font-monospace";"bg-light";"border";"rounded-2";"p-2")) :- selected_object(_).

elem(edit_image_new_role,textfield,image_edit_content) :- selected_object(_).
attr(edit_image_new_role,order,2) :- selected_object(_).
attr(edit_image_new_role,placeholder,"New role; leave untouched to keep current") :- selected_object(_).
attr(edit_image_new_role,class,"font-monospace") :- selected_object(_).
when(edit_image_new_role,input,context,(edit_image_new_role,_value)) :- selected_object(_).

elem(edit_image_new_path,textfield,image_edit_content) :- selected_object(_).
attr(edit_image_new_path,order,3) :- selected_object(_).
attr(edit_image_new_path,placeholder,"New local image path") :- selected_object(_).
attr(edit_image_new_path,class,"font-monospace") :- selected_object(_).
when(edit_image_new_path,input,context,(edit_image_new_path,_value)) :- selected_object(_).

elem(image_edit_actions,container,image_edit_content) :- selected_object(_).
attr(image_edit_actions,order,4) :- selected_object(_).
attr(image_edit_actions,child_layout,flex) :- selected_object(_).
attr(image_edit_actions,flex_direction,row) :- selected_object(_).
attr(image_edit_actions,class,("d-flex";"flex-row";"justify-content-end";"gap-2")) :- selected_object(_).

elem(image_edit_cancel,button,image_edit_actions) :- selected_object(_).
attr(image_edit_cancel,order,1) :- selected_object(_).
attr(image_edit_cancel,label,"Cancel") :- selected_object(_).
attr(image_edit_cancel,class,"btn-outline-secondary") :- selected_object(_).
when(image_edit_cancel,click,update,(image_edit_modal,visibility,hidden)) :- selected_object(_).

elem(image_edit_save,button,image_edit_actions) :- selected_object(_).
attr(image_edit_save,order,2) :- selected_object(_).
attr(image_edit_save,label,"Save image") :- selected_object(_).
attr(image_edit_save,icon,"fa-check") :- selected_object(_).
attr(image_edit_save,class,"btn-primary") :- selected_object(_).
when(image_edit_save,click,update,(image_edit_modal,visibility,hidden)) :- selected_object(_).
when(image_edit_save,click,call,(remove_atom(image(_context_value(edit_image_object),_context_value(edit_image_role),_context_value(edit_image_path))),add_atom(image(_context_value(edit_image_object),_context_value(edit_image_new_role,const),_context_value(edit_image_new_path,str))))) :- selected_object(_).



%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Operation-completion feedback declarations
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

feedback_on(object_select(O),click,info,"Object selected",M) :-
    object(O,_), M = @concat("Selected ",O," for inspection and placement.").

feedback_on(object_create_save,click,success,"Object created","The new object was added to the current session.").

feedback_on(object_type_save(O,T),click,success,"Object updated",M) :-
    user_object(O,T), M = @concat("Updated the type of ",O,".").

feedback_on(object_delete_confirm(O,T),click,success,"Object removed",M) :-
    user_object(O,T), M = @concat("Removed ",O," and its session-added metadata.").

feedback_on(property_add_term,click,success,"Property added","Added a property whose value is parsed as an ASP term.") :- selected_object(_).
feedback_on(property_add_int,click,success,"Property added","Added a property whose value is parsed as an integer.") :- selected_object(_).
feedback_on(property_add_string,click,success,"Property added","Added a property whose value is stored as text.") :- selected_object(_).

feedback_on(property_edit_term,click,success,"Property updated","The property was replaced using an ASP-term value.") :- selected_object(_).
feedback_on(property_edit_int,click,success,"Property updated","The property was replaced using an integer value.") :- selected_object(_).
feedback_on(property_edit_string,click,success,"Property updated","The property was replaced using a text value.") :- selected_object(_).

feedback_on(property_remove(O,K,V),click,success,"Property removed",M) :-
    selected_object(O), user_property(O,K,V), M = @concat("Removed property ",K," from ",O,".").

feedback_on(position_add_save,click,success,"Position added","The selected object was placed at the entered coordinate and role.") :- selected_object(_).
feedback_on(position_edit_save,click,success,"Position updated","The session-added position was replaced.") :- selected_object(_).

feedback_on(image_add_save,click,success,"Image metadata added","The role-specific image path was added.") :- selected_object(_).
feedback_on(image_edit_save,click,success,"Image metadata updated","The session-added image metadata was replaced.") :- selected_object(_).

feedback_on(image_remove(O,Role,I),click,success,"Image metadata removed",M) :-
    selected_object(O), user_image(O,Role,I), M = @concat("Removed image metadata for role ",Role," from ",O,".").