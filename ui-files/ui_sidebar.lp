% ============================================================
% ui_sidebar.lp 
% ============================================================

% Sidebar Header 
elem(sidebar_header,container,sidebar_panel).
attr(sidebar_header,order,1).
attr(sidebar_header,class,("d-flex";"flex-column";"gap-1";"p-3";"bg-dark";"text-white")).

% Sidebar Title
elem(sidebar_title,label,sidebar_header).
attr(sidebar_title,order,1).
attr(sidebar_title,label,"Object Catalogue").
attr(sidebar_title,class,("fw-bold";"fs-5";"text-white")).

% Subtitle
elem(sidebar_subtitle,label,sidebar_header).
attr(sidebar_subtitle,order,2).
attr(sidebar_subtitle,label,"Objects available in the current instance.").
attr(sidebar_subtitle,class,("small";"text-light")).


% Object Catalogue
% ------------------------------------------------------------
elem(object_catalogue,container,sidebar_panel).
attr(object_catalogue,order,3).
attr(object_catalogue,flex_direction,column).
attr(object_catalogue,class,("d-flex";"flex-column";"w-100";"mw-100";"border-top";"overflow-hidden")).


% Catalogue heading, Add object Button
% ------------------------------------------------------------

elem(object_toolbar_catalogue,container,object_catalogue).
attr(object_toolbar_catalogue,order,2).
attr(object_toolbar_catalogue,flex_direction,column).
attr(object_toolbar_catalogue,class,("d-flex";"flex-column";"gap-2";"px-3";"pb-3")).
attr(object_toolbar_catalogue,"min-width","0").

elem(object_header_catalogue,label,object_toolbar_catalogue).
attr(object_header_catalogue,order,1).
attr(object_header_catalogue,label,"Object catalogue").
attr(object_header_catalogue,class,("fw-bold";"m-0")).
attr(object_header_catalogue,foreground_color,"#0F172A").
attr(object_header_catalogue,"font-size","16px").
attr(object_header_catalogue,"letter-spacing","-0.02em").

elem(object_catalogue_subtitle,label,object_toolbar_catalogue).
attr(object_catalogue_subtitle,order,2).
attr(object_catalogue_subtitle,label,"Available objects, grouped by type.").
attr(object_catalogue_subtitle,class,("m-0";"text-wrap")).
attr(object_catalogue_subtitle,foreground_color,"#64748B").
attr(object_catalogue_subtitle,"font-size","12px").
attr(object_catalogue_subtitle,"line-height","1.5").

elem(catalogue_counts,container,object_toolbar_catalogue).
attr(catalogue_counts,order,3).
attr(catalogue_counts,flex_direction,row).
attr(catalogue_counts,class,("d-flex";"flex-row";"flex-wrap";"gap-2";"pt-1";"pb-1")).

% Count objects

elem(object_catalogue_count,label,catalogue_counts).
attr(object_catalogue_count,order,1).
attr(object_catalogue_count,label,"1 object") :- object_count(N),N=1.
attr(object_catalogue_count,label,@concat(N," objects")) :- object_count(N), N != 1.
attr(object_catalogue_count,class,("rounded-pill";"px-2";"py-1";"m-0";"fw-bold")).
attr(object_catalogue_count,background_color,"#EFF6FF").
attr(object_catalogue_count,foreground_color,"#1D4ED8").
attr(object_catalogue_count,"font-size","11px").

elem(catalogue_type_count,label,catalogue_counts).
attr(catalogue_type_count,order,2).
attr(catalogue_type_count,label,"1 type") :- type_count(N),N=1.
attr(catalogue_type_count,label,@concat(N," types")) :- type_count(N),N != 1.
attr(catalogue_type_count,class,("rounded-pill";"px-2";"py-1";"m-0";"fw-bold")).
attr(catalogue_type_count,background_color,"#F1F5F9").
attr(catalogue_type_count,foreground_color,"#475569").
attr(catalogue_type_count,"font-size","11px").


% Add Object

elem(add_object,button,object_toolbar_catalogue).
attr(add_object,order,4).
attr(add_object,icon,"fa-plus").
attr(add_object,label,"Add object").
attr(add_object,class,("btn-outline-primary";"rounded-3";"fw-bold";"w-100";"py-2";"px-3")).
attr(add_object,"font-size","13px").
when(add_object,click,context,(dialog,form(add_object))).
when(add_object,click,update,(dialog(form(add_object)),visibility,shown)).

% Empty catalogue
% ------------------------------------------------------------
elem(catalogue_empty,container,object_catalogue) :- not has_objects.
attr(catalogue_empty,order,3) :- not has_objects.
attr(catalogue_empty,flex_direction,column) :- not has_objects.
attr(catalogue_empty,class,("d-flex";"flex-column";"align-items-center";"gap-2";"mx-3";"mb-3";"px-3";"py-4";"text-center")) :- not has_objects.
attr(catalogue_empty,background_color,"#F8FAFC") :- not has_objects.
attr(catalogue_empty,"border","1px dashed #CBD5E1") :- not has_objects.
attr(catalogue_empty,"border-radius","12px") :- not has_objects.

elem(catalogue_empty_mark,label,catalogue_empty) :- not has_objects.
attr(catalogue_empty_mark,order,1) :- not has_objects.
attr(catalogue_empty_mark,label,"{ }") :- not has_objects.
attr(catalogue_empty_mark,class,("font-monospace";"fw-bold";"m-0";"mb-1")) :- not has_objects.
attr(catalogue_empty_mark,foreground_color,"#94A3B8") :- not has_objects.
attr(catalogue_empty_mark,"font-size","26px") :- not has_objects.

elem(catalogue_empty_title,label,catalogue_empty) :- not has_objects.
attr(catalogue_empty_title,order,2) :- not has_objects.
attr(catalogue_empty_title,label,"Your catalogue is empty") :- not has_objects.
attr(catalogue_empty_title,class,("fw-bold";"m-0")) :- not has_objects.
attr(catalogue_empty_title,foreground_color,"#334155") :- not has_objects.
attr(catalogue_empty_title,"font-size","13px") :- not has_objects.

elem(catalogue_empty_hint,label,catalogue_empty) :- not has_objects.
attr(catalogue_empty_hint,order,3) :- not has_objects.
attr(catalogue_empty_hint,label,"Use the Button above to create your first object.") :- not has_objects.
attr(catalogue_empty_hint,class,("m-0";"text-wrap")) :- not has_objects.
attr(catalogue_empty_hint,foreground_color,"#64748B") :- not has_objects.
attr(catalogue_empty_hint,"font-size","12px") :- not has_objects.
attr(catalogue_empty_hint,"line-height","1.6") :- not has_objects.

% Scrollable catalogue
% ------------------------------------------------------------
elem(catalogue_list,container,object_catalogue) :- has_objects.
attr(catalogue_list,order,3) :- has_objects.
attr(catalogue_list,flex_direction,column) :- has_objects.
attr(catalogue_list,class,("d-flex";"flex-column";"gap-3";"px-3";"pb-3";"mw-100")) :- has_objects.
attr(catalogue_list,"min-width","0") :- has_objects.
attr(catalogue_list,"max-height","min(500px, 55vh)") :- has_objects.
attr(catalogue_list,"overflow-y","auto") :- has_objects.
attr(catalogue_list,"overflow-x","hidden") :- has_objects.
attr(catalogue_list,"scrollbar-width","thin") :- has_objects.

% Type groups
% ------------------------------------------------------------ 
elem(type_group(T),container,catalogue_list) :-object(_,T).
attr(type_group(T),order,N) :- object(_,T), N = #count { T2 : object(_,T2), T2 < T }.
attr(type_group(T),flex_direction,column) :- object(_,T).
attr(type_group(T),class,("d-flex";"flex-column";"gap-2";"mw-100";"flex-shrink-0")) :- object(_,T).
attr(type_group(T),"min-width","0") :- object(_,T).

elem(type_heading(T),container,type_group(T)) :- object(_,T).
attr(type_heading(T),order,1) :- object(_,T).
attr(type_heading(T),flex_direction,row) :- object(_,T).
attr(type_heading(T),class,("d-flex";"flex-row";"align-items-center";"justify-content-between";"gap-2";"px-1";"pt-2";"pb-1")) :- object(_,T).
attr(type_heading(T),"min-width","0") :- object(_,T).

elem(type_title(T),label,type_heading(T)) :- object(_,T).
attr(type_title(T),order,1) :- object(_,T).
attr(type_title(T),label,@concat("",T)) :- object(_,T).
attr(type_title(T),class,("fw-bold";"m-0";"text-break")) :- object(_,T).
attr(type_title(T),foreground_color,"#475569") :- object(_,T).
attr(type_title(T),"font-size","12px") :- object(_,T).
attr(type_title(T),"min-width","0") :- object(_,T).

elem(catalogue_group_count(T),label,type_heading(T)) :- object(_,T).
attr(catalogue_group_count(T),order,2) :- object(_,T).
attr(catalogue_group_count(T),label,@concat("",N)) :- object(_,T), N = #count { O : object(O,T) }.
attr(catalogue_group_count(T),class,("rounded-pill";"px-2";"py-1";"m-0";"fw-bold";"flex-shrink-0")) :- object(_,T).
attr(catalogue_group_count(T),background_color,"#F1F5F9") :- object(_,T).
attr(catalogue_group_count(T),foreground_color,"#64748B") :- object(_,T).
attr(catalogue_group_count(T),"font-size","10px") :- object(_,T).

elem(type_items(T),container,type_group(T)) :- object(_,T).
attr(type_items(T),order,2) :- object(_,T).
attr(type_items(T),flex_direction,column) :- object(_,T).
attr(type_items(T),class,("d-flex";"flex-column";"gap-2";"mw-100")) :- object(_,T).
attr(type_items(T),"min-width","0") :- object(_,T).

% ============================================================
% OBJECT CARD
% ============================================================

elem(object_card(O,T),container,type_items(T)) :- object(O,T).
attr(object_card(O,T),order,N+10) :-object(O,T),N=#count{Other:object(Other,T),Other<O}.
attr(object_card(O,T),child_layout,flex) :- object(O,T).
attr(object_card(O,T),flex_direction,column) :- object(O,T).
attr(object_card(O,T),class,("d-flex";"flex-column";"align-items-stretch";"gap-0";"p-0";"border";"border-2";"rounded-3";"w-100";"mw-100";"overflow-hidden")) :- object(O,T).
attr(object_card(O,T),"min-width","0") :- object(O,T).
attr(object_card(O,T),"transition","background-color 160ms ease, border-color 160ms ease, box-shadow 160ms ease") :- object(O,T).

% backgrounds

attr(object_card(O,T),background_color,"#ffffff") :-object(O,T),not _clinguin_context(object_selected,O),not object_selected_for_inspection(O,T).
attr(object_card(O,T),background_color,"#e9ecef") :-object(O,T),_clinguin_context(object_selected,O).
attr(object_card(O,T),background_color,"#fff3cd") :-object(O,T),object_selected_for_inspection(O,T),not _clinguin_context(object_selected,O).
attr(object_card(O,T),class,("border-primary";"shadow-sm")) :-object(O,T),_clinguin_context(object_selected,O).
attr(object_card(O,T),class,("border-warning";"shadow-sm")) :-object(O,T),object_selected_for_inspection(O,T),not _clinguin_context(object_selected,O).
attr(object_card(O,T),on_hover,true) :-object(O,T),not _clinguin_context(object_selected,O).
attr(object_card(O,T),on_hover_background_color,"#e9ecef") :-object(O,T), not _clinguin_context(object_selected,O).


% ============================================================
% CARD MAIN CONTENT
% ============================================================
elem(object_card_main(O,T),container,object_card(O,T)) :- object(O,T).
attr(object_card_main(O,T),order,1) :- object(O,T).
attr(object_card_main(O,T),flex_direction,row) :- object(O,T).
attr(object_card_main(O,T),class,("d-flex";"flex-row";"flex-wrap";"align-items-start";"gap-3";"p-3";"w-100";"bg-transparent")) :- object(O,T).
attr(object_card_main(O,T),background_color,"transparent") :-object(O,T).
attr(object_card_main(O,T),"min-width","0") :- object(O,T).


% ============================================================
% OBJECT VISUAL AREA
% ============================================================
elem(object_visuals(O,T),container,object_card_main(O,T)) :-object(O,T),image(O,_,_).
attr(object_visuals(O,T),order,1) :-object(O,T),image(O,_,_).
attr(object_visuals(O,T),flex_direction,row) :-object(O,T),image(O,_,_).
attr(object_visuals(O,T),class,("d-flex";"flex-row";"flex-wrap"; "gap-2";"align-items-start";"flex-shrink-0";"mw-100";"bg-transparent")) :-object(O,T),image(O,_,_).
attr(object_visuals(O,T),background_color,"transparent") :-object(O,T),image(O,_,_).

% ------------------------------------------------------------
% ROLE-SPECIFIC IMAGE BLOCK
% ------------------------------------------------------------
elem(object_image_block(O,R,I),container,object_visuals(O,T)) :-object(O,T),image(O,R,I).
attr(object_image_block(O,R,I),order,N) :-object(O,T),image(O,R,I),N=#count{R2,I2:image(O,R2,I2),(R2,I2)<(R,I)}.
attr(object_image_block(O,R,I),flex_direction,column) :-object(O,T),image(O,R,I).
attr(object_image_block(O,R,I),class,("d-flex";"flex-column";"align-items-center";"gap-1";"p-1";"rounded-3";"bg-transparent")) :-object(O,T),image(O,R,I).
attr(object_image_block(O,R,I),background_color,"transparent") :-object(O,T),image(O,R,I).
attr(object_image_block(O,R,I),"border","1px solid #E2E8F0") :-object(O,T),image(O,R,I).
% ------------------------------------------------------------
% ACTUAL IMAGE
% ------------------------------------------------------------

elem(object_image(O,R,I),canvas,object_image_block(O,R,I)) :-object(O,T),image(O,R,I).
attr(object_image(O,R,I),order,1) :-object(O,T),image(O,R,I).
attr(object_image(O,R,I),image,I) :-object(O,T),image(O,R,I).
attr(object_image(O,R,I),width,30) :-object(O,T),image(O,R,I).
attr(object_image(O,R,I),height,30) :-object(O,T),image(O,R,I).
attr(object_image(O,R,I),class,( "rounded-2";"bg-white";"flex-shrink-0")) :-object(O,T),image(O,R,I).
% ------------------------------------------------------------
% ROLE BADGE
% ------------------------------------------------------------
elem(object_image_role(O,R,I),label,object_image_block(O,R,I)) :-object(O,T), image(O,R,I).
attr(object_image_role(O,R,I),order,2) :-object(O,T),image(O,R,I).
attr(object_image_role(O,R,I),label,@concat("",R)) :-object(O,T),image(O,R,I).
attr(object_image_role(O,R,I),class,("fw-semibold";"text-secondary";"text-center";"text-nowrap";"m-0")) :-object(O,T),image(O,R,I).
attr(object_image_role(O,R,I),"font-size","9px") :-object(O,T),image(O,R,I).
% ============================================================
% FALLBACK VISUAL
% ============================================================
elem(catalogue_object_mark(O,T),label,object_card_main(O,T)) :-object(O,T),not image(O,_,_).
attr(catalogue_object_mark(O,T),order,1) :-object(O,T),not image(O,_,_).
attr(catalogue_object_mark(O,T),label,"{}") :-object(O,T),not image(O,_,_).
attr(catalogue_object_mark(O,T),width,30) :-object(O,T),not image(O,_,_).
attr(catalogue_object_mark(O,T),height,30) :-object(O,T),not image(O,_,_).
attr(catalogue_object_mark(O,T),class,("d-flex";"align-items-center";"justify-content-center";"font-monospace";"fw-bold";"rounded-3";"flex-shrink-0";"m-0")) :-object(O,T),not image(O,_,_).
attr(catalogue_object_mark(O,T),background_color,"#EFF6FF") :-object(O,T),not image(O,_,_).
attr(catalogue_object_mark(O,T),foreground_color,"#2563EB") :-object(O,T),not image(O,_,_).
attr(catalogue_object_mark(O,T),"font-size","17px") :-object(O,T),not image(O,_,_).
% ============================================================
% OBJECT INFORMATION
% ============================================================
elem(object_info(O,T),container,object_card_main(O,T)) :-object(O,T).
attr(object_info(O,T),order,2) :- object(O,T).
attr(object_info(O,T),flex_direction,column) :- object(O,T).
attr(object_info(O,T),class,("d-flex";"flex-column";"align-items-start";"gap-1";"flex-grow-1";"mw-100"; "pt-1";"bg-transparent")) :- object(O,T).
attr(object_info(O,T),background_color,"transparent") :-object(O,T).
attr(object_info(O,T),"min-width","0") :- object(O,T).
% ------------------------------------------------------------
% OBJECT ASP REPRESENTATION
% ------------------------------------------------------------
elem(object_body(O,T),label,object_info(O,T)) :- object(O,T).
attr(object_body(O,T),order,1) :- object(O,T).
attr(object_body(O,T),label,@concat("object(",O,", ",T,")")) :-object(O,T).
attr(object_body(O,T),class,("font-monospace";"text-secondary";"text-wrap";"m-0";"mt-1")) :- object(O,T).
attr(object_body(O,T),"font-size","10px") :- object(O,T).
attr(object_body(O,T),"line-height","1.4") :- object(O,T).
attr(object_body(O,T),"overflow-wrap","anywhere") :- object(O,T).


% ------------------------------------------------------------
% OBJECT COMPLETENESS
% ------------------------------------------------------------
elem(object_completeness(O,T),label,object_info(O,T)) :-object(O,T).
attr(object_completeness(O,T),order,2) :- object(O,T).
attr(object_completeness(O,T),label,"Ready") :-complete(O,T).
attr(object_completeness(O,T),label,"Incomplete") :-incomplete(O,T).
attr(object_completeness(O,T),class,("rounded-pill";"px-2";"py-1";"m-0")) :- object(O,T).
attr(object_completeness(O,T),class,("badge";"bg-success";"text-white")) :- complete(O,T).
attr(object_completeness(O,T),class,("badge";"bg-warning";"text-dark")) :- incomplete(O,T).
attr(object_completeness(O,T),"font-size","10px") :- object(O,T).

% ============================================================
% ACTION FOOTER
% ============================================================

elem(object_actions(O,T),container,object_card(O,T)) :-object(O,T).
attr(object_actions(O,T),order,2) :- object(O,T).
attr(object_actions(O,T),flex_direction,row) :- object(O,T).
attr(object_actions(O,T),class,( "d-flex";"flex-row";"flex-wrap";"align-items-center";"gap-2";"w-100"; "px-3";"py-2"; "border-top"; "bg-transparent")) :- object(O,T).
attr(object_actions(O,T),background_color,"transparent") :-object(O,T).
attr(object_actions(O,T),"min-width","0") :- object(O,T).
% ============================================================
% SELECT / PLACE
% ============================================================

elem(object_select(O,T),button,object_actions(O,T)) :-object(O,T).
attr(object_select(O,T),order,1) :- object(O,T).
attr(object_select(O,T),icon,"fa-arrow-pointer") :- object(O,T).
attr(object_select(O,T),disabled,true) :-object(O,T),not complete(O,T).
attr(object_select(O,T),label,"Placing") :-object(O,T),_clinguin_context(object_selected,O).
attr(object_select(O,T),label,"Place") :-object(O,T),not _clinguin_context(object_selected,O).
attr(object_select(O,T),class,("btn-outline-primary";"btn-sm";"rounded-2";"px-2";"py-1";"fw-semibold";"text-nowrap")) :-object(O,T),not _clinguin_context(object_selected,O).
attr(object_select(O,T),class,("btn-primary"; "btn-sm";"rounded-2";"px-2";"py-1";"fw-semibold";"text-nowrap")) :-object(O,T),_clinguin_context(object_selected,O).
attr(object_select(O,T),"font-size","10px") :- object(O,T).
when(object_select(O,T),click,context,(object_selected,O)) :-complete(O,T).
when(object_select(O,T),click,context,(selected_role_for_placement,none)) :-complete(O,T),not object_single_role_image(O,_).
when(object_select(O,T),click,context,(selected_role_for_placement,R)) :- complete(O,T),object_single_role_image(O,R).
when(object_select(O,T),click,call,()) :-complete(O,T).


% ============================================================
% INSPECT
% ============================================================
elem(object_inspect(O,T),button,object_actions(O,T)) :-object(O,T).
attr(object_inspect(O,T),order,2) :- object(O,T).
attr(object_inspect(O,T),icon,"fa-magnifying-glass") :- object(O,T).
attr(object_inspect(O,T),label,"Inspect") :-object(O,T),not _clinguin_context(selected_for_inspection,O).
attr(object_inspect(O,T),label,"Inspecting") :- object(O,T),_clinguin_context(selected_for_inspection,O).
attr(object_inspect(O,T),class,("btn-outline-secondary";"btn-sm";"rounded-2";"px-2";"py-1"; "text-nowrap")) :-object(O,T),not _clinguin_context(selected_for_inspection,O).
attr(object_inspect(O,T),class,("btn-secondary"; "btn-sm"; "rounded-2";"px-2";"py-1";"text-nowrap")) :-object(O,T),_clinguin_context(selected_for_inspection,O).
attr(object_inspect(O,T),"font-size","10px") :- object(O,T).
when(object_inspect(O,T),click,context,(selected_for_inspection,O)) :-object(O,T).
when(object_inspect(O,T),click,context,(inspector_open,true)) :-object(O,T).
when(object_inspect(O,T),click,update,(dialog(inspector),visibility,shown)) :-object(O,T).
when(object_inspect(O,T),click,call,()) :-object(O,T).


% ============================================================
% DELETE
% ============================================================
elem(object_delete(O,T),button,object_actions(O,T)) :-object(O,T),_clinguin_atom(object(O,T)).
attr(object_delete(O,T),order,3) :-elem(object_delete(O,T),button,_).
attr(object_delete(O,T),icon,"fa-trash") :-elem(object_delete(O,T),button,_).
attr(object_delete(O,T),label,"Delete") :- elem(object_delete(O,T),button,_).
attr(object_delete(O,T),class,("btn-outline-danger";"btn-sm";"rounded-2";"px-2";"py-1"; "ms-auto";"text-nowrap")) :-elem(object_delete(O,T),button,_).
attr(object_delete(O,T),"font-size","10px") :-elem(object_delete(O,T),button,_).
when(object_delete(O,T),click,context,(delete_object,O)) :- elem(object_delete(O,T),button,_).
when(object_delete(O,T),click,context,(notice_level,warning)) :-object(O,T),_clinguin_atom(object(O,T)).
when(object_delete(O,T),click,context,(notice_title,"Object deleted")) :-object(O,T),_clinguin_atom(object(O,T)).
when(object_delete(O,T),click,context,(notice_message,@concat("Object ",O," (type: ",T,") was deleted."))) :-object(O,T), _clinguin_atom(object(O,T)).
when(object_delete(O,T),click,call,remove_atom(object(O,T))) :-elem(object_delete(O,T),button,_).


% ============================================================
% PLACEMENT ROLE SECTION
% ============================================================
elem(placement_role_section(O,T),container,object_card(O,T)) :- complete(O,T),_clinguin_context(object_selected,O).
attr(placement_role_section(O,T),order,3) :-elem(placement_role_section(O,T),container,_).
attr(placement_role_section(O,T),child_layout,flex) :-elem(placement_role_section(O,T),container,_).
attr(placement_role_section(O,T),flex_direction,row) :-elem(placement_role_section(O,T),container,_).
attr(placement_role_section(O,T),class,("d-flex";"flex-row";"flex-wrap";"align-items-center"; "gap-2";"px-3";"py-2";"w-100";"border-top";"bg-transparent")) :-elem(placement_role_section(O,T),container,_).
attr(placement_role_section(O,T),background_color,"transparent") :-elem(placement_role_section(O,T),container,_).
% ------------------------------------------------------------
% ROLE HEADING
% ------------------------------------------------------------
elem(placement_role_label(O,T),label,placement_role_section(O,T)) :-elem(placement_role_section(O,T),container,_).
attr(placement_role_label(O,T),order,1) :-elem(placement_role_label(O,T),label,_).
attr(placement_role_label(O,T),label,"Role") :-elem(placement_role_label(O,T),label,_).
attr(placement_role_label(O,T),class,("fw-bold"; "text-secondary"; "text-nowrap"; "m-0"; "me-1")) :- elem(placement_role_label(O,T),label,_).
attr(placement_role_label(O,T),"font-size","0.75rem") :- elem(placement_role_label(O,T),label,_).
% ------------------------------------------------------------
% ROLE BUTTON CONTAINER
% ------------------------------------------------------------
elem(placement_role_buttons(O,T),container,placement_role_section(O,T)) :-elem(placement_role_section(O,T),container,_).
attr(placement_role_buttons(O,T),order,2) :-elem(placement_role_buttons(O,T),container,_).
attr(placement_role_buttons(O,T),child_layout,flex) :-elem(placement_role_buttons(O,T),container,_).
attr(placement_role_buttons(O,T),flex_direction,row) :- elem(placement_role_buttons(O,T),container,_).
attr(placement_role_buttons(O,T),class,("d-flex";"flex-row";"flex-wrap";"align-items-center";"gap-1";"flex-grow-1";"bg-transparent")) :-elem(placement_role_buttons(O,T),container,_).
attr(placement_role_buttons(O,T),background_color,"transparent") :-elem(placement_role_buttons(O,T),container,_).
attr(placement_role_buttons(O,T),"min-width","0") :- elem(placement_role_buttons(O,T),container,_).
% ------------------------------------------------------------
% ROLE BUTTONS
% ------------------------------------------------------------

elem(placement_role_button(O,R),button,placement_role_buttons(O,T)) :-elem(placement_role_buttons(O,T),container,_), type_role(T,R),image(O,R,_).
attr(placement_role_button(O,R),label,@concat("",R)) :-elem(placement_role_button(O,R),button,_).
attr(placement_role_button(O,R),order,N) :-elem(placement_role_button(O,R),button,placement_role_buttons(O,T)),N=#count{R2:elem(placement_role_button(O,R2),button,placement_role_buttons(O,T)),R2<R}.
attr(placement_role_button(O,R),height,26) :-elem(placement_role_button(O,R),button,_).
attr(placement_role_button(O,R),"font-size","0.8125rem") :-elem(placement_role_button(O,R),button,_).
attr(placement_role_button(O,R),class,("btn-sm";"rounded-pill"; "px-2";"py-0";"m-0";"fw-semibold";"text-nowrap")) :-elem(placement_role_button(O,R),button,_).
attr(placement_role_button(O,R),class,"btn-primary") :-elem(placement_role_button(O,R),button,_),_clinguin_context(selected_role_for_placement,R).
attr(placement_role_button(O,R),icon,"fa-check") :-elem(placement_role_button(O,R),button,_),_clinguin_context(selected_role_for_placement,R).
attr(placement_role_button(O,R),class,"btn-outline-secondary") :-elem(placement_role_button(O,R),button,_),not _clinguin_context(selected_role_for_placement,R).
when(placement_role_button(O,R),click,context,(selected_role_for_placement,R)) :-elem(placement_role_button(O,R),button,_).
when(placement_role_button(O,R),click,call,()) :-elem(placement_role_button(O,R),button,_).
% ------------------------------------------------------------
% UNSELECT
% ------------------------------------------------------------

elem(unselect_placement(O,T),button,placement_role_section(O,T)) :-
    elem(placement_role_section(O,T),container,_).

attr(unselect_placement(O,T),order,3) :-
    elem(unselect_placement(O,T),button,_).

attr(unselect_placement(O,T),label,"Unselect") :-
    elem(unselect_placement(O,T),button,_).

attr(unselect_placement(O,T),icon,"fa-xmark") :-
    elem(unselect_placement(O,T),button,_).

attr(unselect_placement(O,T),height,26) :-
    elem(unselect_placement(O,T),button,_).

attr(unselect_placement(O,T),"font-size","0.75rem") :-
    elem(unselect_placement(O,T),button,_).

attr(unselect_placement(O,T),class,(
    "btn-sm";
    "btn-outline-danger";
    "rounded-2";
    "fw-semibold";
    "px-2";
    "py-0";
    "ms-auto";
    "text-nowrap"
)) :-
    elem(unselect_placement(O,T),button,_).

when(unselect_placement(O,T),click,context,(object_selected,none)) :-
    elem(unselect_placement(O,T),button,_).

when(unselect_placement(O,T),click,context,(selected_role_for_placement,none)) :-
    elem(unselect_placement(O,T),button,_).

when(unselect_placement(O,T),click,call,()) :-
    elem(unselect_placement(O,T),button,_).
% ============================================================
% PLACEMENT HINT
% ============================================================

elem(placement_role_hint(O,T),label,placement_role_section(O,T)) :-elem(placement_role_section(O,T),container,_).
attr(placement_role_hint(O,T),order,4) :-elem(placement_role_hint(O,T),label,_).
attr(placement_role_hint(O,T),class,("w-100";"m-0";"lh-sm")) :-elem(placement_role_hint(O,T),label,_).
attr(placement_role_hint(O,T),"flex-basis","100%") :-elem(placement_role_hint(O,T),label,_).
attr(placement_role_hint(O,T),"font-size","0.75rem") :-elem(placement_role_hint(O,T),label,_).
% Roles exist, but none has been selected.
attr(placement_role_hint(O,T),label, "Choose a role, then click a cell.") :- elem(placement_role_hint(O,T),label,_),0 < #count{R:elem(placement_role_button(O,R),button,placement_role_buttons(O,T)) },
    0 = #count{
        R:
        elem(placement_role_button(O,R),button,placement_role_buttons(O,T)),
        _clinguin_context(selected_role_for_placement,R)
    }.

% A valid role is selected.

attr(placement_role_hint(O,T),label,@concat("Click a cell to place as ",R,".")) :-elem(placement_role_hint(O,T),label,_),elem(placement_role_button(O,R),button,placement_role_buttons(O,T)),_clinguin_context(selected_role_for_placement,R).

% No available role buttons.

attr(placement_role_hint(O,T),label,
    "No roles with images available."
) :-
    elem(placement_role_hint(O,T),label,_),
    0 = #count{
        R:
        elem(placement_role_button(O,R),button,placement_role_buttons(O,T))
    }.

attr(placement_role_hint(O,T),class,"text-primary") :-
    elem(placement_role_hint(O,T),label,_),
    elem(placement_role_button(O,R),button,placement_role_buttons(O,T)),
    _clinguin_context(selected_role_for_placement,R).

attr(placement_role_hint(O,T),class,"text-secondary") :-
    elem(placement_role_hint(O,T),label,_),
    0 = #count{
        R:
        elem(placement_role_button(O,R),button,placement_role_buttons(O,T)),
        _clinguin_context(selected_role_for_placement,R)
    }.
% Shared form styles 
attr(form_actions(F),flex_direction,row) :- elem(form_actions(F),container,_).
attr(form_actions(F),class,"flex-wrap") :- elem(form_actions(F),container,_).
attr(cancel(F),order,0) :- elem(cancel(F),button,_).
attr(save(F,Kind),order,N+1) :- elem(save(F,Kind),button,_),N=#count{Other:elem(save(F,Other),button,_),Other<Kind}.


% ============================================================
% ADD OBJECT MODAL
% ============================================================
elem(dialog(form(add_object)),modal,w).
attr(dialog(form(add_object)),title,"Create object").
attr(dialog(form(add_object)),size,"m").
attr(dialog(form(add_object)),visibility,shown) :- _clinguin_context(dialog,form(add_object)).
attr(dialog(form(add_object)),visibility,hidden) :- not _clinguin_context(dialog,form(add_object)).

attr(dialog_close(form(add_object)),visibility,hidden) :- elem(dialog_close(form(add_object)),button,_).
attr(dialog_close(form(add_object)),class,"d-none") :- elem(dialog_close(form(add_object)),button,_).

% Form
elem(form_body(add_object),container,dialog_sheet(form(add_object))).
attr(form_body(add_object),order,1).
attr(form_body(add_object),flex_direction,column).
attr(form_body(add_object),class,("d-flex";"flex-column";"gap-3";"p-3";"bg-white";"w-100")).
attr(form_body(add_object),"min-width","0").

% Intro
elem(add_object_intro,container,form_body(add_object)).
attr(add_object_intro,order,1).
attr(add_object_intro,flex_direction,row).
attr(add_object_intro,class,("d-flex";"flex-row";"align-items-center";"gap-3";"p-3";"rounded-3")).
attr(add_object_intro,background_color,"#F1F5F9").
attr(add_object_intro,"border","1px solid #E2E8F0").

elem(add_object_symbol,label,add_object_intro).
attr(add_object_symbol,order,1).
attr(add_object_symbol,label,"{}").
attr(add_object_symbol,width,40).
attr(add_object_symbol,height,40).
attr(add_object_symbol,class,("d-flex";"align-items-center";"justify-content-center";"font-monospace";"fw-bold";"text-primary";"rounded-3";"flex-shrink-0";"m-0")).
attr(add_object_symbol,background_color,"#DBEAFE").
attr(add_object_symbol,"font-size","20px").

elem(add_object_intro_text,container,add_object_intro).
attr(add_object_intro_text,order,2).
attr(add_object_intro_text,flex_direction,column).
attr(add_object_intro_text,class,("d-flex";"flex-column";"gap-1";"flex-grow-1")).
attr(add_object_intro_text,"min-width","0").

elem(add_object_label,label,add_object_intro_text).
attr(add_object_label,order,1).
attr(add_object_label,label,"OBJECT CATALOGUE").
attr(add_object_label,class,("fw-bold";"text-primary";"m-0")).
attr(add_object_label,"font-size","10px").

elem(add_object_description,label,add_object_intro_text).
attr(add_object_description,order,2).
attr(add_object_description,label,"Enter an object identifier and specify its type.").
attr(add_object_description,class,("text-dark";"text-wrap";"m-0")).
attr(add_object_description,"font-size","12px").

% Identifier
elem(add_object_name_field,container,form_body(add_object)).
attr(add_object_name_field,order,2).
attr(add_object_name_field,flex_direction,column).
attr(add_object_name_field,class,("d-flex";"flex-column";"gap-2";"w-100")).

elem(add_object_name_label,label,add_object_name_field).
attr(add_object_name_label,order,1).
attr(add_object_name_label,label,"Object identifier").
attr(add_object_name_label,class,("fw-bold";"text-dark";"m-0")).
attr(add_object_name_label,"font-size","13px").

elem(input(add_object,new_object_name),textfield,add_object_name_field).
attr(input(add_object,new_object_name),order,2).
attr(input(add_object,new_object_name),placeholder,"e.g. train(01)").
attr(input(add_object,new_object_name),class,("form-control";"rounded-3";"bg-white";"text-dark";"px-3";"py-2";"w-100")).
attr(input(add_object,new_object_name),"border","1px solid #CBD5E1").
attr(input(add_object,new_object_name),"min-height","42px").
attr(input(add_object,new_object_name),"font-size","13px").
when(input(add_object,new_object_name),input,context,(new_object_name,_value)).


% Type section
elem(add_object_type_field,container,form_body(add_object)).
attr(add_object_type_field,order,3).
attr(add_object_type_field,flex_direction,column).
attr(add_object_type_field,class,("d-flex";"flex-column";"gap-2";"w-100")).

elem(add_object_type_header,container,add_object_type_field).
attr(add_object_type_header,order,1).
attr(add_object_type_header,flex_direction,row).
attr(add_object_type_header,class,("d-flex";"flex-row";"align-items-center";"justify-content-between";"gap-2";"w-100")).

elem(add_object_type_label,label,add_object_type_header).
attr(add_object_type_label,order,1).
attr(add_object_type_label,label,"Object type").
attr(add_object_type_label,class,("fw-bold";"text-dark";"m-0")).
attr(add_object_type_label,"font-size","13px").

elem(add_object_type_count,label,add_object_type_header) :- has_declared_object_type.
attr(add_object_type_count,order,2) :- has_declared_object_type.
attr(add_object_type_count,label,@concat(N," declared")) :- N=#count{T:object_type(T)},N>0.
attr(add_object_type_count,class,("text-secondary";"bg-light";"border";"rounded-pill";"px-2";"py-1";"m-0")) :- has_declared_object_type.
attr(add_object_type_count,"font-size","9px") :- has_declared_object_type.

% Declared mode

elem(declared_type_section,container,add_object_type_field) :- has_declared_object_type.
attr(declared_type_section,order,3) :- has_declared_object_type.
attr(declared_type_section,flex_direction,column) :- has_declared_object_type.
attr(declared_type_section,class,("d-flex";"flex-column";"gap-1";"w-100")) :- has_declared_object_type.
attr(declared_type_section,visibility,shown) :- has_declared_object_type.

elem(input(add_object,declared_object_type),dropdown_menu,declared_type_section) :- has_declared_object_type.
attr(input(add_object,declared_object_type),order,2) :- has_declared_object_type.
attr(input(add_object,declared_object_type),selected,"Select object type") :- has_declared_object_type.
attr(input(add_object,declared_object_type),class,("btn-light";"bg-white";"border";"text-dark";"text-start";"w-100";"rounded-3";"px-3";"py-2")) :- has_declared_object_type.
attr(input(add_object,declared_object_type),"font-size","13px") :- has_declared_object_type.

elem(object_type_option(T),dropdown_menu_item,input(add_object,declared_object_type)) :- object_type(T).
attr(object_type_option(T),order,N) :-object_type(T),N=#count{T2:object_type(D,T2),T2<T}.
attr(object_type_option(T),label,@concat("",T)) :-object_type(T).
attr(object_type_option(T),class,("dropdown-item";"px-3";"py-2")) :-object_type(T).
when(object_type_option(T),click,context,(new_object_type,T)) :-object_type(T).
when(object_type_option(T),click,update,(input(add_object,declared_object_type),selected,@concat("",T))) :-object_type(T).



% Actions

elem(form_actions(add_object),container,form_body(add_object)).
attr(form_actions(add_object),order,30).
attr(form_actions(add_object),flex_direction,row).
attr(form_actions(add_object),class,("d-flex";"flex-row";"justify-content-end";"gap-2";"border-top";"pt-3")).

elem(cancel(add_object),button,form_actions(add_object)).
attr(cancel(add_object),order,1).
attr(cancel(add_object),label,"Cancel").
attr(cancel(add_object),class,("btn-light";"border";"rounded-3";"px-3";"py-2")).
when(cancel(add_object),click,update,(dialog(form(add_object)),visibility,hidden)).
when(cancel(add_object),click,context,(dialog,none)).

elem(save(add_object),button,form_actions(add_object)).
attr(save(add_object),order,2).
attr(save(add_object),label,"Create object").
attr(save(add_object),icon,"fa-plus").
attr(save(add_object),class,("btn-primary";"text-white";"fw-bold";"rounded-3";"px-3";"py-2")).
when(save(add_object),click,context,(dialog,none)).
when(save(add_object),click,update,(dialog(form(add_object)),visibility,hidden)).

when(save(add_object),click,context,(notice_level,success)).
when(save(add_object),click,context,(notice_title,"Object created")).
when(save(add_object),click,context,(notice_message,@concat("Object ",_context_value(new_object_name),", of type ",_context_value(new_object_type),", was created successfully."))).
when(save(add_object),click,call,add_atom(object_type(_context_value(new_object_type)))).
when(save(add_object),click,call,add_atom(object(_context_value(new_object_name),_context_value(new_object_type)))).




% ============================================================
% INSPECTOR MODAL
% ============================================================

elem(dialog(inspector),modal,w).
attr(dialog(inspector),title,"Object Inspector").
attr(dialog(inspector),size,"m").
attr(dialog(inspector),visibility,shown) :- _clinguin_context(inspector_open,true).
attr(dialog(inspector),visibility,hidden) :- not _clinguin_context(inspector_open,true).
attr(dialog_close(inspector),visibility,hidden) :- elem(dialog_close(inspector),button,_).
attr(dialog_close(inspector),class,"d-none") :- elem(dialog_close(inspector),button,_).

% ============================================================
% INSPECTOR BODY
% ============================================================
elem(inspector_body,container,dialog_sheet(inspector)) :- object_selected_for_inspection(O,T).
attr(inspector_body,order,1) :- elem(inspector_body,container,_).
attr(inspector_body,flex_direction,column) :- elem(inspector_body,container,_).
attr(inspector_body,class,("d-flex";"flex-column";"gap-2";"p-2";"w-100")) :- elem(inspector_body,container,_).
attr(inspector_body,background_color,"#F8FAFC") :- elem(inspector_body,container,_).
attr(inspector_body,"min-width","0") :- elem(inspector_body,container,_).

% ============================================================
% OBJECT HEADER
% ============================================================
elem(inspector_header(O,T),container,inspector_body) :- object_selected_for_inspection(O,T).
attr(inspector_header(O,T),order,1) :- elem(inspector_header(O,T),container,_).
attr(inspector_header(O,T),flex_direction,row) :- elem(inspector_header(O,T),container,_).
attr(inspector_header(O,T),class,("d-flex";"flex-row";"align-items-center";"justify-content-between";"gap-2";"px-3";"py-2";"w-100";"bg-white";"border";"rounded-3")) :- elem(inspector_header(O,T),container,_).

% ============================================================
% OBJECT IDENTITY
% ============================================================
elem(inspector_identity(O,T),container,inspector_header(O,T)) :- object_selected_for_inspection(O,T).
attr(inspector_identity(O,T),order,1) :- elem(inspector_identity(O,T),container,_).
attr(inspector_identity(O,T),flex_direction,column) :- elem(inspector_identity(O,T),container,_).
attr(inspector_identity(O,T),class,("d-flex";"flex-column";"gap-0";"flex-grow-1";"mw-100")) :- elem(inspector_identity(O,T),container,_).
attr(inspector_identity(O,T),"min-width","0") :- elem(inspector_identity(O,T),container,_).

elem(inspector_object(O,T),label,inspector_identity(O,T)) :- object_selected_for_inspection(O,T).
attr(inspector_object(O,T),order,2) :- elem(inspector_object(O,T),label,_).
attr(inspector_object(O,T),label,@concat("object(",O,", ",T,")")) :- object_selected_for_inspection(O,T).
attr(inspector_object(O,T),class,("font-monospace";"text-secondary";"text-wrap";"m-0")) :- elem(inspector_object(O,T),label,_).


% ============================================================
% VISUALS
% ============================================================

elem(inspector_visuals(O,T),container,inspector_body) :- object_selected_for_inspection(O,T).
attr(inspector_visuals(O,T),order,10) :- object_selected_for_inspection(O,T).
attr(inspector_visuals(O,T),flex_direction,column) :- object_selected_for_inspection(O,T).
attr(inspector_visuals(O,T),class,("d-flex";"flex-column";"gap-2";"p-2";"bg-white";"border";"rounded-3";"w-100")) :- object_selected_for_inspection(O,T).

% Header
elem(inspector_visuals_header(O,T),container,inspector_visuals(O,T)) :- object_selected_for_inspection(O,T).
attr(inspector_visuals_header(O,T),order,1) :- object_selected_for_inspection(O,T).
attr(inspector_visuals_header(O,T),flex_direction,row) :- object_selected_for_inspection(O,T).
attr(inspector_visuals_header(O,T),class,("d-flex";"flex-row";"align-items-center";"justify-content-between";"gap-2")) :- object_selected_for_inspection(O,T).

elem(inspector_visuals_title(O,T),label,inspector_visuals_header(O,T)) :- object_selected_for_inspection(O,T).
attr(inspector_visuals_title(O,T),order,1) :- object_selected_for_inspection(O,T).
attr(inspector_visuals_title(O,T),label,"Visuals") :- object_selected_for_inspection(O,T).
attr(inspector_visuals_title(O,T),class,("fw-bold";"text-dark";"m-0")) :- object_selected_for_inspection(O,T).
attr(inspector_visuals_title(O,T),"font-size","11px") :- object_selected_for_inspection(O,T).

elem(inspector_visual_count(O,T),label,inspector_visuals_header(O,T)) :- object_selected_for_inspection(O,T),image(O,_,_).
attr(inspector_visual_count(O,T),order,2) :- object_selected_for_inspection(O,T),image(O,_,_).
attr(inspector_visual_count(O,T),label,@concat(N," configured")) :- object_selected_for_inspection(O,T),N=#count{R,I:image(O,R,I)}.
attr(inspector_visual_count(O,T),class,("text-secondary";"m-0")) :- object_selected_for_inspection(O,T),image(O,_,_).
attr(inspector_visual_count(O,T),"font-size","9px") :- object_selected_for_inspection(O,T),image(O,_,_).

% Image list
elem(inspector_visual_list(O,T),container,inspector_visuals(O,T)) :- object_selected_for_inspection(O,T),image(O,_,_).
attr(inspector_visual_list(O,T),order,2) :- object_selected_for_inspection(O,T),image(O,_,_).
attr(inspector_visual_list(O,T),flex_direction,column) :- object_selected_for_inspection(O,T),image(O,_,_).
attr(inspector_visual_list(O,T),class,("d-flex";"flex-column";"gap-2";"w-100")) :- object_selected_for_inspection(O,T),image(O,_,_).

% Image card
elem(inspector_visual(O,T,R,I),container,inspector_visual_list(O,T)) :- object_selected_for_inspection(O,T),image(O,R,I).
attr(inspector_visual(O,T,R,I),order,N) :- object_selected_for_inspection(O,T),image(O,R,I),N=#count{R2,I2:image(O,R2,I2),(R2,I2)<(R,I)}.
attr(inspector_visual(O,T,R,I),flex_direction,row) :- object_selected_for_inspection(O,T),image(O,R,I).
attr(inspector_visual(O,T,R,I),class,("d-flex";"flex-row";"align-items-center";"gap-2";"p-2";"bg-light";"border";"rounded-2";"w-100")) :- object_selected_for_inspection(O,T),image(O,R,I).

% Preview
elem(inspector_visual_image(O,T,R,I),canvas,inspector_visual(O,T,R,I)) :- object_selected_for_inspection(O,T),image(O,R,I).
attr(inspector_visual_image(O,T,R,I),order,1) :- object_selected_for_inspection(O,T),image(O,R,I).
attr(inspector_visual_image(O,T,R,I),image,I) :- object_selected_for_inspection(O,T),image(O,R,I).
attr(inspector_visual_image(O,T,R,I),width,40) :- object_selected_for_inspection(O,T),image(O,R,I).
attr(inspector_visual_image(O,T,R,I),height,40) :- object_selected_for_inspection(O,T),image(O,R,I).
attr(inspector_visual_image(O,T,R,I),class,("rounded-2";"bg-white";"flex-shrink-0")) :- object_selected_for_inspection(O,T),image(O,R,I).

% Image info
elem(inspector_visual_info(O,T,R,I),container,inspector_visual(O,T,R,I)) :- object_selected_for_inspection(O,T),image(O,R,I).
attr(inspector_visual_info(O,T,R,I),order,2) :- object_selected_for_inspection(O,T),image(O,R,I).
attr(inspector_visual_info(O,T,R,I),flex_direction,column) :- object_selected_for_inspection(O,T),image(O,R,I).
attr(inspector_visual_info(O,T,R,I),class,("d-flex";"flex-column";"gap-1";"flex-grow-1")) :- object_selected_for_inspection(O,T),image(O,R,I).

elem(inspector_visual_role(O,T,R,I),label,inspector_visual_info(O,T,R,I)) :- object_selected_for_inspection(O,T),image(O,R,I).
attr(inspector_visual_role(O,T,R,I),order,1) :- object_selected_for_inspection(O,T),image(O,R,I).
attr(inspector_visual_role(O,T,R,I),label,@concat("Role: ",R)) :- object_selected_for_inspection(O,T),image(O,R,I).
attr(inspector_visual_role(O,T,R,I),class,("fw-semibold";"text-dark";"m-0")) :- object_selected_for_inspection(O,T),image(O,R,I).
attr(inspector_visual_role(O,T,R,I),"font-size","9px") :- object_selected_for_inspection(O,T),image(O,R,I).

elem(inspector_visual_path(O,T,R,I),label,inspector_visual_info(O,T,R,I)) :- object_selected_for_inspection(O,T),image(O,R,I).
attr(inspector_visual_path(O,T,R,I),order,2) :- object_selected_for_inspection(O,T),image(O,R,I).
attr(inspector_visual_path(O,T,R,I),label,@concat("",I)) :- object_selected_for_inspection(O,T),image(O,R,I).
attr(inspector_visual_path(O,T,R,I),class,("font-monospace";"text-secondary";"text-break";"m-0")) :- object_selected_for_inspection(O,T),image(O,R,I).
attr(inspector_visual_path(O,T,R,I),"font-size","8px") :- object_selected_for_inspection(O,T),image(O,R,I).% ============================================================% ADD IMAGE% ============================================================elem(inspector_add_role(O,T),container,inspector_body) :- object_selected_for_inspection(O,T).attr(inspector_add_role(O,T),order,11) :- object_selected_for_inspection(O,T).attr(inspector_add_role(O,T),flex_direction,column) :- object_selected_for_inspection(O,T).attr(inspector_add_role(O,T),class,("d-flex";"flex-column";"gap-2";"p-2";"bg-white";"border";"rounded-3";"w-100")) :- object_selected_for_inspection(O,T).% Headerelem(add_visual_header(O,T),container,inspector_add_role(O,T)) :- object_selected_for_inspection(O,T).attr(add_visual_header(O,T),order,1) :- object_selected_for_inspection(O,T).attr(add_visual_header(O,T),flex_direction,row) :- object_selected_for_inspection(O,T).attr(add_visual_header(O,T),class,("d-flex";"flex-row";"align-items-center";"justify-content-between";"gap-2")) :- object_selected_for_inspection(O,T).elem(add_visual_remaining(O,T),label,add_visual_header(O,T)) :- object_selected_for_inspection(O,T),object_missing_image(O,T).attr(add_visual_remaining(O,T),order,2) :- object_selected_for_inspection(O,T),object_missing_image(O,T).attr(add_visual_remaining(O,T),label,@concat(N," roles available")) :- object_selected_for_inspection(O,T),object_missing_image(O,T),N=#count{R:object_missing_image_for_role(O,T,R)}.attr(add_visual_remaining(O,T),class,("text-secondary";"m-0")) :- object_selected_for_inspection(O,T),object_missing_image(O,T).attr(add_visual_remaining(O,T),"font-size","9px") :- object_selected_for_inspection(O,T),object_missing_image(O,T).


% ============================================================
% ALLOWED PROPERTY VALUES
% Keep these facts in your domain configuration if already defined there.
% Both declarations use track, matching the supplied facts.
% ============================================================
type_property_options(track,code,(32800;1025;37408;17411;32872;3089;49186;1097;34864;5633;33825;38433;50211;33897;35889;38505;52275;20994;16458;2136;6672;4608;16386;72;2064;8192;4;128;256)).
type_property_options(track,directions,(0;1;2;3;4)).

% ============================================================
% GENERIC PROPERTY OPTION HELPERS
% ============================================================
inspector_property_has_options(T,P) :- type_property_options(T,P,_).
inspector_required_option_selection(O,T,P,Opt) :- object_selected_for_inspection(O,T),object_missing_required_property(O,T,P,_),type_property_options(T,P,Opt),_clinguin_context(required_property_value(O,T,P),Opt).
inspector_editor_value(O,T,P,V,NV) :- elem(property_editor(O,T,P,V),container,_),_clinguin_context(editing_property_new_value,NV).
inspector_editor_value(O,T,P,V,V) :- elem(property_editor(O,T,P,V),container,_),not _clinguin_context(editing_property_new_value,_).

% Restore the active editor and valid dropdown selections after a server call.
when(w,load,context,(editing_property_key,P)) :- elem(property_editor(O,T,P,V),container,_).
when(w,load,context,(editing_property_old_value,V)) :- elem(property_editor(O,T,P,V),container,_).
when(w,load,context,(editing_property_new_value,NV)) :- inspector_editor_value(O,T,P,V,NV).
when(w,load,context,(required_property_value(O,T,P),Opt)) :- inspector_required_option_selection(O,T,P,Opt).

% ============================================================
% PROPERTY OPTIONS: DOMAIN CONFIGURATION
% Keep these declarations with your domain configuration if preferred.
% The direction rules use whichever spelling your schema declares.
% ============================================================
type_property_options(track,code,(32800;1025;37408;17411;32872;3089;49186;1097;34864;5633;33825;38433;50211;33897;35889;38505;52275;20994;16458;2136;6672;4608;16386;72;2064;8192;4;128;256)).
type_property_options(T,direction,0..4) :- type_property(T,direction,_,_).
type_property_options(T,directions,0..4) :- type_property(T,directions,_,_).

% ============================================================
% GENERIC HELPERS
% This inspector edits one selected object at a time.
% Use a supported unary context key; keep the owner separately.
% ============================================================
inspector_property_has_options(T,P) :- type_property_options(T,P,_).
inspector_integer_type(int;integer).
inspector_string_type(str;string;text).
inspector_property_cast(T,P,int) :- type_property(T,P,VT,_),inspector_integer_type(VT).
inspector_property_cast(T,P,str) :- type_property(T,P,VT,_),inspector_string_type(VT).
inspector_required_submission(O,T,P,_context_value(required_property_value(P),Cast)) :- object_selected_for_inspection(O,T),object_missing_required_property(O,T,P,_),inspector_property_cast(T,P,Cast).
inspector_required_submission(O,T,P,_context_value(required_property_value(P))) :- object_selected_for_inspection(O,T),object_missing_required_property(O,T,P,_),not inspector_property_cast(T,P,_).
inspector_required_draft(O,T,P,V) :- object_selected_for_inspection(O,T),object_missing_required_property(O,T,P,_),_clinguin_context(required_property_owner,(O,T)),_clinguin_context(required_property_value(P),V).
inspector_required_option_selection(O,T,P,Opt) :- inspector_required_draft(O,T,P,Opt),type_property_options(T,P,Opt).
inspector_editor_value(O,T,P,V,NV) :- elem(property_editor(O,T,P,V),container,_),_clinguin_context(editing_property_new_value,NV).
inspector_editor_value(O,T,P,V,V) :- elem(property_editor(O,T,P,V),container,_),not _clinguin_context(editing_property_new_value,_).
inspector_editor_submission(O,T,P,V,_context_value(editing_property_new_value,Cast)) :- elem(property_editor(O,T,P,V),container,_),inspector_property_cast(T,P,Cast).
inspector_editor_submission(O,T,P,V,_context_value(editing_property_new_value)) :- elem(property_editor(O,T,P,V),container,_),not inspector_property_cast(T,P,_).

% Restore pending values after a server call, only for the same object.
when(W,load,context,(required_property_owner,(O,T))) :- elem(W,window,_),inspector_required_draft(O,T,_,_).
when(W,load,context,(required_property_value(P),V)) :- elem(W,window,_),inspector_required_draft(O,T,P,V).
when(W,load,context,(editing_property_new_value,NV)) :- elem(W,window,_),inspector_editor_value(O,T,P,V,NV).

% ============================================================
% PROPERTIES CONTAINER
% ============================================================
elem(inspector_properties(O,T),container,inspector_body) :- object_selected_for_inspection(O,T).
attr(inspector_properties(O,T),order,15) :- elem(inspector_properties(O,T),container,_).
attr(inspector_properties(O,T),flex_direction,column) :- elem(inspector_properties(O,T),container,_).
attr(inspector_properties(O,T),class,("d-flex";"flex-column";"gap-2";"p-2";"bg-white";"border";"rounded-3";"w-100")) :- elem(inspector_properties(O,T),container,_).
attr(inspector_properties(O,T),"min-width","0") :- elem(inspector_properties(O,T),container,_).

% ============================================================
% PROPERTIES HEADER
% ============================================================
elem(inspector_properties_header(O,T),container,inspector_properties(O,T)) :- object_selected_for_inspection(O,T).
attr(inspector_properties_header(O,T),order,1) :- elem(inspector_properties_header(O,T),container,_).
attr(inspector_properties_header(O,T),flex_direction,row) :- elem(inspector_properties_header(O,T),container,_).
attr(inspector_properties_header(O,T),class,("d-flex";"flex-row";"align-items-center";"justify-content-between";"gap-2";"w-100")) :- elem(inspector_properties_header(O,T),container,_).

elem(inspector_properties_title(O,T),label,inspector_properties_header(O,T)) :- object_selected_for_inspection(O,T).
attr(inspector_properties_title(O,T),order,1) :- elem(inspector_properties_title(O,T),label,_).
attr(inspector_properties_title(O,T),label,"Properties") :- elem(inspector_properties_title(O,T),label,_).
attr(inspector_properties_title(O,T),class,("fw-bold";"text-dark";"m-0")) :- elem(inspector_properties_title(O,T),label,_).
attr(inspector_properties_title(O,T),"font-size","11px") :- elem(inspector_properties_title(O,T),label,_).

elem(inspector_properties_count(O,T),label,inspector_properties_header(O,T)) :- object_selected_for_inspection(O,T).
attr(inspector_properties_count(O,T),order,2) :- elem(inspector_properties_count(O,T),label,_).
attr(inspector_properties_count(O,T),label,@concat(N," configured")) :- object_selected_for_inspection(O,T),N=#count{P,V:property(O,P,V)}.
attr(inspector_properties_count(O,T),class,("text-secondary";"m-0")) :- elem(inspector_properties_count(O,T),label,_).
attr(inspector_properties_count(O,T),"font-size","9px") :- elem(inspector_properties_count(O,T),label,_).

% ============================================================
% MISSING REQUIRED PROPERTY WARNING
% ============================================================
elem(inspector_property_warning(O,T),container,inspector_properties(O,T)) :- object_selected_for_inspection(O,T),object_missing_required_property(O,T,_,_).
attr(inspector_property_warning(O,T),order,2) :- elem(inspector_property_warning(O,T),container,_).
attr(inspector_property_warning(O,T),flex_direction,row) :- elem(inspector_property_warning(O,T),container,_).
attr(inspector_property_warning(O,T),class,("d-flex";"flex-row";"align-items-center";"gap-2";"px-2";"py-1";"rounded-2";"w-100")) :- elem(inspector_property_warning(O,T),container,_).
attr(inspector_property_warning(O,T),background_color,"#FFF7ED") :- elem(inspector_property_warning(O,T),container,_).
attr(inspector_property_warning(O,T),"border","1px solid #FED7AA") :- elem(inspector_property_warning(O,T),container,_).

elem(inspector_property_warning_icon(O,T),icon,inspector_property_warning(O,T)) :- object_selected_for_inspection(O,T),object_missing_required_property(O,T,_,_).
attr(inspector_property_warning_icon(O,T),order,1) :- elem(inspector_property_warning_icon(O,T),icon,_).
attr(inspector_property_warning_icon(O,T),icon,"fa-triangle-exclamation") :- elem(inspector_property_warning_icon(O,T),icon,_).
attr(inspector_property_warning_icon(O,T),class,"text-warning") :- elem(inspector_property_warning_icon(O,T),icon,_).

elem(inspector_property_warning_text(O,T),label,inspector_property_warning(O,T)) :- object_selected_for_inspection(O,T),object_missing_required_property(O,T,_,_).
attr(inspector_property_warning_text(O,T),order,2) :- elem(inspector_property_warning_text(O,T),label,_).
attr(inspector_property_warning_text(O,T),label,@concat(N," required properties need configuration.")) :- elem(inspector_property_warning_text(O,T),label,_),N=#count{P:object_missing_required_property(O,T,P,_)}.
attr(inspector_property_warning_text(O,T),class,("fw-semibold";"m-0")) :- elem(inspector_property_warning_text(O,T),label,_).
attr(inspector_property_warning_text(O,T),foreground_color,"#9A3412") :- elem(inspector_property_warning_text(O,T),label,_).
attr(inspector_property_warning_text(O,T),"font-size","9px") :- elem(inspector_property_warning_text(O,T),label,_).

% ============================================================
% CONFIGURED PROPERTY LIST
% ============================================================
elem(configured_property_list(O,T),container,inspector_properties(O,T)) :- object_selected_for_inspection(O,T),property(O,_,_).
attr(configured_property_list(O,T),order,3) :- elem(configured_property_list(O,T),container,_).
attr(configured_property_list(O,T),flex_direction,column) :- elem(configured_property_list(O,T),container,_).
attr(configured_property_list(O,T),class,("d-flex";"flex-column";"gap-1";"w-100")) :- elem(configured_property_list(O,T),container,_).

% ============================================================
% CONFIGURED PROPERTY ROW
% ============================================================
elem(configured_property_row(O,T,P,V),container,configured_property_list(O,T)) :- object_selected_for_inspection(O,T),property(O,P,V).
attr(configured_property_row(O,T,P,V),order,N) :- object_selected_for_inspection(O,T),property(O,P,V),N=#count{P2,V2:property(O,P2,V2),(P2,V2)<(P,V)}.
attr(configured_property_row(O,T,P,V),flex_direction,row) :- elem(configured_property_row(O,T,P,V),container,_).
attr(configured_property_row(O,T,P,V),class,("d-flex";"flex-row";"flex-wrap";"align-items-center";"gap-2";"px-2";"py-1";"bg-light";"border";"rounded-2";"w-100")) :- elem(configured_property_row(O,T,P,V),container,_).

% ============================================================
% PROPERTY VALUE
% ============================================================
elem(configured_property_text(O,T,P,V),label,configured_property_row(O,T,P,V)) :- object_selected_for_inspection(O,T),property(O,P,V).
attr(configured_property_text(O,T,P,V),order,1) :- elem(configured_property_text(O,T,P,V),label,_).
attr(configured_property_text(O,T,P,V),label,@concat(P," = ",V)) :- object_selected_for_inspection(O,T),property(O,P,V).
attr(configured_property_text(O,T,P,V),class,("font-monospace";"fw-semibold";"text-dark";"text-break";"flex-grow-1";"m-0")) :- elem(configured_property_text(O,T,P,V),label,_).
attr(configured_property_text(O,T,P,V),"font-size","10px") :- elem(configured_property_text(O,T,P,V),label,_).

% ============================================================
% PROPERTY TYPE BADGE
% ============================================================
elem(configured_property_type(O,T,P,V),label,configured_property_row(O,T,P,V)) :- object_selected_for_inspection(O,T),property(O,P,V),type_property(T,P,VT,_).
attr(configured_property_type(O,T,P,V),order,2) :- elem(configured_property_type(O,T,P,V),label,_).
attr(configured_property_type(O,T,P,V),label,@concat("",VT)) :- object_selected_for_inspection(O,T),property(O,P,V),type_property(T,P,VT,_).
attr(configured_property_type(O,T,P,V),class,("rounded-pill";"px-2";"py-1";"bg-white";"text-secondary";"border";"m-0")) :- elem(configured_property_type(O,T,P,V),label,_).
attr(configured_property_type(O,T,P,V),"font-size","8px") :- elem(configured_property_type(O,T,P,V),label,_).

% ============================================================
% REQUIRED / OPTIONAL BADGE
% ============================================================
elem(configured_property_requirement(O,T,P,V),label,configured_property_row(O,T,P,V)) :- object_selected_for_inspection(O,T),property(O,P,V),type_property(T,P,_,_).
attr(configured_property_requirement(O,T,P,V),order,3) :- elem(configured_property_requirement(O,T,P,V),label,_).
attr(configured_property_requirement(O,T,P,V),label,"Required") :- object_selected_for_inspection(O,T),property(O,P,V),type_property(T,P,_,required).
attr(configured_property_requirement(O,T,P,V),label,"Optional") :- object_selected_for_inspection(O,T),property(O,P,V),type_property(T,P,_,optional).
attr(configured_property_requirement(O,T,P,V),class,("rounded-pill";"px-2";"py-1";"bg-white";"text-secondary";"border";"m-0")) :- elem(configured_property_requirement(O,T,P,V),label,_).
attr(configured_property_requirement(O,T,P,V),"font-size","8px") :- elem(configured_property_requirement(O,T,P,V),label,_).

% ============================================================
% CUSTOM PROPERTY BADGE
% ============================================================
elem(custom_property_badge(O,T,P,V),label,configured_property_row(O,T,P,V)) :- object_selected_for_inspection(O,T),property(O,P,V),not type_property(T,P,_,_).
attr(custom_property_badge(O,T,P,V),order,3) :- elem(custom_property_badge(O,T,P,V),label,_).
attr(custom_property_badge(O,T,P,V),label,"Custom") :- elem(custom_property_badge(O,T,P,V),label,_).
attr(custom_property_badge(O,T,P,V),class,("rounded-pill";"px-2";"py-1";"bg-white";"text-secondary";"border";"m-0")) :- elem(custom_property_badge(O,T,P,V),label,_).
attr(custom_property_badge(O,T,P,V),"font-size","8px") :- elem(custom_property_badge(O,T,P,V),label,_).

% ============================================================
% EDIT PROPERTY BUTTON
% ============================================================
elem(property_edit(O,T,P,V),button,configured_property_row(O,T,P,V)) :- object_selected_for_inspection(O,T),property(O,P,V),_clinguin_atom(property(O,P,V)).
attr(property_edit(O,T,P,V),order,4) :- elem(property_edit(O,T,P,V),button,_).
attr(property_edit(O,T,P,V),label,"Edit") :- elem(property_edit(O,T,P,V),button,_).
attr(property_edit(O,T,P,V),icon,"fa-pen") :- elem(property_edit(O,T,P,V),button,_).
attr(property_edit(O,T,P,V),class,("btn-outline-primary";"btn-sm";"rounded-2";"px-2";"py-1")) :- elem(property_edit(O,T,P,V),button,_).
attr(property_edit(O,T,P,V),"font-size","9px") :- elem(property_edit(O,T,P,V),button,_).
when(property_edit(O,T,P,V),click,context,(editing_property_key,P)) :- object_selected_for_inspection(O,T),property(O,P,V),_clinguin_atom(property(O,P,V)).
when(property_edit(O,T,P,V),click,context,(editing_property_old_value,V)) :- object_selected_for_inspection(O,T),property(O,P,V),_clinguin_atom(property(O,P,V)).
when(property_edit(O,T,P,V),click,context,(editing_property_new_value,V)) :- object_selected_for_inspection(O,T),property(O,P,V),_clinguin_atom(property(O,P,V)).
when(property_edit(O,T,P,V),click,call,()) :- object_selected_for_inspection(O,T),property(O,P,V),_clinguin_atom(property(O,P,V)).

% ============================================================
% DELETE PROPERTY BUTTON
% ============================================================
elem(property_delete(O,T,P,V),button,configured_property_row(O,T,P,V)) :- object_selected_for_inspection(O,T),property(O,P,V),_clinguin_atom(property(O,P,V)).
attr(property_delete(O,T,P,V),order,5) :- elem(property_delete(O,T,P,V),button,_).
attr(property_delete(O,T,P,V),label,"Delete") :- elem(property_delete(O,T,P,V),button,_).
attr(property_delete(O,T,P,V),icon,"fa-trash") :- elem(property_delete(O,T,P,V),button,_).
attr(property_delete(O,T,P,V),class,("btn-outline-danger";"btn-sm";"rounded-2";"px-2";"py-1")) :- elem(property_delete(O,T,P,V),button,_).
attr(property_delete(O,T,P,V),"font-size","9px") :- elem(property_delete(O,T,P,V),button,_).
when(property_delete(O,T,P,V),click,call,remove_atom(property(O,P,V))) :- object_selected_for_inspection(O,T),property(O,P,V),_clinguin_atom(property(O,P,V)).

% ============================================================
% INLINE PROPERTY EDITOR
% ============================================================
elem(property_editor(O,T,P,V),container,inspector_properties(O,T)) :- object_selected_for_inspection(O,T),property(O,P,V),_clinguin_atom(property(O,P,V)),_clinguin_context(editing_property_key,P),_clinguin_context(editing_property_old_value,V).
attr(property_editor(O,T,P,V),order,4) :- elem(property_editor(O,T,P,V),container,_).
attr(property_editor(O,T,P,V),flex_direction,column) :- elem(property_editor(O,T,P,V),container,_).
attr(property_editor(O,T,P,V),class,("d-flex";"flex-column";"gap-2";"p-2";"rounded-2";"w-100")) :- elem(property_editor(O,T,P,V),container,_).
attr(property_editor(O,T,P,V),background_color,"#EFF6FF") :- elem(property_editor(O,T,P,V),container,_).
attr(property_editor(O,T,P,V),"border","1px solid #BFDBFE") :- elem(property_editor(O,T,P,V),container,_).

elem(property_editor_title(O,T,P,V),label,property_editor(O,T,P,V)) :- elem(property_editor(O,T,P,V),container,_).
attr(property_editor_title(O,T,P,V),order,1) :- elem(property_editor_title(O,T,P,V),label,_).
attr(property_editor_title(O,T,P,V),label,@concat("Edit ",P)) :- elem(property_editor_title(O,T,P,V),label,_).
attr(property_editor_title(O,T,P,V),class,("fw-bold";"text-primary";"m-0")) :- elem(property_editor_title(O,T,P,V),label,_).
attr(property_editor_title(O,T,P,V),"font-size","10px") :- elem(property_editor_title(O,T,P,V),label,_).

% Textfield editor for properties without declared options.
elem(property_editor_input(O,T,P,V),textfield,property_editor(O,T,P,V)) :- elem(property_editor(O,T,P,V),container,_),not inspector_property_has_options(T,P).
attr(property_editor_input(O,T,P,V),order,2) :- elem(property_editor_input(O,T,P,V),textfield,_).
attr(property_editor_input(O,T,P,V),placeholder,@concat("Current value: ",V)) :- elem(property_editor_input(O,T,P,V),textfield,_).
attr(property_editor_input(O,T,P,V),class,("form-control";"form-control-sm";"rounded-2";"w-100")) :- elem(property_editor_input(O,T,P,V),textfield,_).
attr(property_editor_input(O,T,P,V),"font-size","10px") :- elem(property_editor_input(O,T,P,V),textfield,_).
when(property_editor_input(O,T,P,V),input,context,(editing_property_new_value,_value)) :- elem(property_editor_input(O,T,P,V),textfield,_).

% Dropdown editor for any property with declared options.
elem(property_editor_input(O,T,P,V),dropdown_menu,property_editor(O,T,P,V)) :- elem(property_editor(O,T,P,V),container,_),inspector_property_has_options(T,P).
attr(property_editor_input(O,T,P,V),order,2) :- elem(property_editor_input(O,T,P,V),dropdown_menu,_).
attr(property_editor_input(O,T,P,V),selected,@concat("",NV)) :- elem(property_editor_input(O,T,P,V),dropdown_menu,_),inspector_editor_value(O,T,P,V,NV).
attr(property_editor_input(O,T,P,V),class,("btn-outline-primary";"btn-sm";"rounded-2";"w-100";"text-start")) :- elem(property_editor_input(O,T,P,V),dropdown_menu,_).
attr(property_editor_input(O,T,P,V),"font-size","10px") :- elem(property_editor_input(O,T,P,V),dropdown_menu,_).
elem(property_editor_option(O,T,P,V,Opt),dropdown_menu_item,property_editor_input(O,T,P,V)) :- elem(property_editor_input(O,T,P,V),dropdown_menu,_),type_property_options(T,P,Opt).
attr(property_editor_option(O,T,P,V,Opt),order,N) :- elem(property_editor_option(O,T,P,V,Opt),dropdown_menu_item,_),N=#count{Other:type_property_options(T,P,Other),Other<Opt}.
attr(property_editor_option(O,T,P,V,Opt),label,@concat("",Opt)) :- elem(property_editor_option(O,T,P,V,Opt),dropdown_menu_item,_).
attr(property_editor_option(O,T,P,V,Opt),class,("font-monospace";"small")) :- elem(property_editor_option(O,T,P,V,Opt),dropdown_menu_item,_).
when(property_editor_option(O,T,P,V,Opt),click,context,(editing_property_new_value,Opt)) :- elem(property_editor_option(O,T,P,V,Opt),dropdown_menu_item,_).
when(property_editor_option(O,T,P,V,Opt),click,update,(property_editor_input(O,T,P,V),selected,@concat("",Opt))) :- elem(property_editor_option(O,T,P,V,Opt),dropdown_menu_item,_).

% Editor actions.
elem(property_editor_actions(O,T,P,V),container,property_editor(O,T,P,V)) :- elem(property_editor(O,T,P,V),container,_).
attr(property_editor_actions(O,T,P,V),order,3) :- elem(property_editor_actions(O,T,P,V),container,_).
attr(property_editor_actions(O,T,P,V),flex_direction,row) :- elem(property_editor_actions(O,T,P,V),container,_).
attr(property_editor_actions(O,T,P,V),class,("d-flex";"flex-row";"justify-content-end";"gap-2")) :- elem(property_editor_actions(O,T,P,V),container,_).

elem(property_edit_cancel(O,T,P,V),button,property_editor_actions(O,T,P,V)) :- elem(property_editor(O,T,P,V),container,_).
attr(property_edit_cancel(O,T,P,V),order,1) :- elem(property_edit_cancel(O,T,P,V),button,_).
attr(property_edit_cancel(O,T,P,V),label,"Cancel") :- elem(property_edit_cancel(O,T,P,V),button,_).
attr(property_edit_cancel(O,T,P,V),class,("btn-light";"border";"btn-sm";"rounded-2")) :- elem(property_edit_cancel(O,T,P,V),button,_).
when(property_edit_cancel(O,T,P,V),click,context,(editing_property_key,none)) :- elem(property_editor(O,T,P,V),container,_).
when(property_edit_cancel(O,T,P,V),click,call,()) :- elem(property_editor(O,T,P,V),container,_).

elem(property_edit_save(O,T,P,V),button,property_editor_actions(O,T,P,V)) :- elem(property_editor(O,T,P,V),container,_).
attr(property_edit_save(O,T,P,V),order,2) :- elem(property_edit_save(O,T,P,V),button,_).
attr(property_edit_save(O,T,P,V),label,"Save") :- elem(property_edit_save(O,T,P,V),button,_).
attr(property_edit_save(O,T,P,V),icon,"fa-check") :- elem(property_edit_save(O,T,P,V),button,_).
attr(property_edit_save(O,T,P,V),class,("btn-primary";"btn-sm";"rounded-2")) :- elem(property_edit_save(O,T,P,V),button,_).
when(property_edit_save(O,T,P,V),click,context,(editing_property_key,none)) :- elem(property_editor(O,T,P,V),container,_).
when(property_edit_save(O,T,P,V),click,call,(remove_atom(property(O,P,V)),add_atom(property(O,P,Input)))) :- elem(property_edit_save(O,T,P,V),button,_),inspector_editor_submission(O,T,P,V,Input).

% ============================================================
% MISSING REQUIRED PROPERTIES
% Every missing required property is shown simultaneously.
% Only properties with declared options use dropdowns.
% ============================================================
elem(missing_required_properties(O,T),container,inspector_properties(O,T)) :- object_selected_for_inspection(O,T),object_missing_required_property(O,T,_,_).
attr(missing_required_properties(O,T),order,5) :- elem(missing_required_properties(O,T),container,_).
attr(missing_required_properties(O,T),flex_direction,column) :- elem(missing_required_properties(O,T),container,_).
attr(missing_required_properties(O,T),class,("d-flex";"flex-column";"gap-1";"p-2";"rounded-2";"w-100")) :- elem(missing_required_properties(O,T),container,_).
attr(missing_required_properties(O,T),background_color,"#FFF7ED") :- elem(missing_required_properties(O,T),container,_).
attr(missing_required_properties(O,T),"border","1px solid #FED7AA") :- elem(missing_required_properties(O,T),container,_).
elem(missing_required_properties_title(O,T),label,missing_required_properties(O,T)) :- object_selected_for_inspection(O,T),object_missing_required_property(O,T,_,_).
attr(missing_required_properties_title(O,T),order,1) :- elem(missing_required_properties_title(O,T),label,_).
attr(missing_required_properties_title(O,T),label,"Missing required properties") :- elem(missing_required_properties_title(O,T),label,_).
attr(missing_required_properties_title(O,T),class,("fw-bold";"m-0")) :- elem(missing_required_properties_title(O,T),label,_).
attr(missing_required_properties_title(O,T),foreground_color,"#9A3412") :- elem(missing_required_properties_title(O,T),label,_).
attr(missing_required_properties_title(O,T),"font-size","10px") :- elem(missing_required_properties_title(O,T),label,_).

% ============================================================
% MISSING REQUIRED PROPERTY ROW
% ============================================================
elem(object_missing_required_property_row(O,T,P),container,missing_required_properties(O,T)) :- object_selected_for_inspection(O,T),object_missing_required_property(O,T,P,_).
attr(object_missing_required_property_row(O,T,P),order,N+10) :- object_selected_for_inspection(O,T),object_missing_required_property(O,T,P,VT),N=#count{P2,VT2:object_missing_required_property(O,T,P2,VT2),P2<P}.
attr(object_missing_required_property_row(O,T,P),flex_direction,row) :- elem(object_missing_required_property_row(O,T,P),container,_).
attr(object_missing_required_property_row(O,T,P),class,("d-flex";"flex-row";"flex-wrap";"align-items-center";"gap-2";"px-2";"py-1";"bg-white";"border";"rounded-2";"w-100")) :- elem(object_missing_required_property_row(O,T,P),container,_).

elem(object_missing_required_property_name(O,T,P),label,object_missing_required_property_row(O,T,P)) :- object_selected_for_inspection(O,T),object_missing_required_property(O,T,P,_).
attr(object_missing_required_property_name(O,T,P),order,1) :- elem(object_missing_required_property_name(O,T,P),label,_).
attr(object_missing_required_property_name(O,T,P),label,@concat("",P)) :- elem(object_missing_required_property_name(O,T,P),label,_).
attr(object_missing_required_property_name(O,T,P),class,("fw-bold";"text-dark";"m-0")) :- elem(object_missing_required_property_name(O,T,P),label,_).
attr(object_missing_required_property_name(O,T,P),"font-size","10px") :- elem(object_missing_required_property_name(O,T,P),label,_).

elem(object_missing_required_property_type(O,T,P,VT),label,object_missing_required_property_row(O,T,P)) :- object_selected_for_inspection(O,T),object_missing_required_property(O,T,P,VT).
attr(object_missing_required_property_type(O,T,P,VT),order,2) :- elem(object_missing_required_property_type(O,T,P,VT),label,_).
attr(object_missing_required_property_type(O,T,P,VT),label,@concat("",VT)) :- elem(object_missing_required_property_type(O,T,P,VT),label,_).
attr(object_missing_required_property_type(O,T,P,VT),class,("rounded-pill";"px-2";"bg-light";"border";"text-secondary";"m-0")) :- elem(object_missing_required_property_type(O,T,P,VT),label,_).
attr(object_missing_required_property_type(O,T,P,VT),"font-size","8px") :- elem(object_missing_required_property_type(O,T,P,VT),label,_).

% Textfield input for properties without declared options.
elem(object_missing_required_property_input(O,T,P,VT),textfield,object_missing_required_property_row(O,T,P)) :- object_selected_for_inspection(O,T),object_missing_required_property(O,T,P,VT),not inspector_property_has_options(T,P).
attr(object_missing_required_property_input(O,T,P,VT),order,3) :- elem(object_missing_required_property_input(O,T,P,VT),textfield,_).
attr(object_missing_required_property_input(O,T,P,VT),placeholder,@concat("Enter ",P)) :- elem(object_missing_required_property_input(O,T,P,VT),textfield,_),not inspector_required_draft(O,T,P,_).
attr(object_missing_required_property_input(O,T,P,VT),placeholder,@concat("Entered: ",V)) :- elem(object_missing_required_property_input(O,T,P,VT),textfield,_),inspector_required_draft(O,T,P,V).
attr(object_missing_required_property_input(O,T,P,VT),class,("form-control";"form-control-sm";"rounded-2";"flex-grow-1")) :- elem(object_missing_required_property_input(O,T,P,VT),textfield,_).
attr(object_missing_required_property_input(O,T,P,VT),"font-size","10px") :- elem(object_missing_required_property_input(O,T,P,VT),textfield,_).
when(object_missing_required_property_input(O,T,P,VT),input,context,(required_property_owner,(O,T))) :- elem(object_missing_required_property_input(O,T,P,VT),textfield,_).
when(object_missing_required_property_input(O,T,P,VT),input,context,(required_property_value(P),_value)) :- elem(object_missing_required_property_input(O,T,P,VT),textfield,_).

% Dropdown input for any missing required property with declared options.
elem(object_missing_required_property_input(O,T,P,VT),dropdown_menu,object_missing_required_property_row(O,T,P)) :- object_selected_for_inspection(O,T),object_missing_required_property(O,T,P,VT),inspector_property_has_options(T,P).
attr(object_missing_required_property_input(O,T,P,VT),order,3) :- elem(object_missing_required_property_input(O,T,P,VT),dropdown_menu,_).
attr(object_missing_required_property_input(O,T,P,VT),selected,@concat("Select ",P)) :- elem(object_missing_required_property_input(O,T,P,VT),dropdown_menu,_),not inspector_required_option_selection(O,T,P,_).
attr(object_missing_required_property_input(O,T,P,VT),selected,@concat("",Opt)) :- elem(object_missing_required_property_input(O,T,P,VT),dropdown_menu,_),inspector_required_option_selection(O,T,P,Opt).
attr(object_missing_required_property_input(O,T,P,VT),class,("btn-outline-secondary";"btn-sm";"rounded-2";"flex-grow-1";"text-start")) :- elem(object_missing_required_property_input(O,T,P,VT),dropdown_menu,_).
attr(object_missing_required_property_input(O,T,P,VT),"font-size","10px") :- elem(object_missing_required_property_input(O,T,P,VT),dropdown_menu,_).
elem(object_missing_required_property_option(O,T,P,VT,Opt),dropdown_menu_item,object_missing_required_property_input(O,T,P,VT)) :- elem(object_missing_required_property_input(O,T,P,VT),dropdown_menu,_),type_property_options(T,P,Opt).
attr(object_missing_required_property_option(O,T,P,VT,Opt),order,N) :- elem(object_missing_required_property_option(O,T,P,VT,Opt),dropdown_menu_item,_),N=#count{Other:type_property_options(T,P,Other),Other<Opt}.
attr(object_missing_required_property_option(O,T,P,VT,Opt),label,@concat("",Opt)) :- elem(object_missing_required_property_option(O,T,P,VT,Opt),dropdown_menu_item,_).
attr(object_missing_required_property_option(O,T,P,VT,Opt),class,("font-monospace";"small")) :- elem(object_missing_required_property_option(O,T,P,VT,Opt),dropdown_menu_item,_).
when(object_missing_required_property_option(O,T,P,VT,Opt),click,context,(required_property_owner,(O,T))) :- elem(object_missing_required_property_option(O,T,P,VT,Opt),dropdown_menu_item,_).
when(object_missing_required_property_option(O,T,P,VT,Opt),click,context,(required_property_value(P),Opt)) :- elem(object_missing_required_property_option(O,T,P,VT,Opt),dropdown_menu_item,_).
when(object_missing_required_property_option(O,T,P,VT,Opt),click,update,(object_missing_required_property_input(O,T,P,VT),selected,@concat("",Opt))) :- elem(object_missing_required_property_option(O,T,P,VT,Opt),dropdown_menu_item,_).

% ============================================================
% ADD ONE REQUIRED PROPERTY
% This adds the selected row even when other required fields are empty.
% ============================================================
elem(add_required_property(O,T,P),button,object_missing_required_property_row(O,T,P)) :- elem(object_missing_required_property_row(O,T,P),container,_).
attr(add_required_property(O,T,P),order,4) :- elem(add_required_property(O,T,P),button,_).
attr(add_required_property(O,T,P),label,"Add") :- elem(add_required_property(O,T,P),button,_).
attr(add_required_property(O,T,P),icon,"fa-plus") :- elem(add_required_property(O,T,P),button,_).
attr(add_required_property(O,T,P),class,("btn-primary";"btn-sm";"rounded-2";"px-2";"py-1")) :- elem(add_required_property(O,T,P),button,_).
attr(add_required_property(O,T,P),"font-size","9px") :- elem(add_required_property(O,T,P),button,_).
when(add_required_property(O,T,P),click,call,add_atom(property(O,P,Input))) :- elem(add_required_property(O,T,P),button,_),inspector_required_submission(O,T,P,Input).

% ============================================================
% ADD ALL MISSING REQUIRED PROPERTIES
% Select or enter every required value before clicking.
% ============================================================
elem(add_all_required_properties(O,T),button,missing_required_properties(O,T)) :- object_selected_for_inspection(O,T),object_missing_required_property(O,T,_,_).
attr(add_all_required_properties(O,T),order,100) :- elem(add_all_required_properties(O,T),button,_).
attr(add_all_required_properties(O,T),label,"Add all properties") :- elem(add_all_required_properties(O,T),button,_).
attr(add_all_required_properties(O,T),icon,"fa-plus") :- elem(add_all_required_properties(O,T),button,_).
attr(add_all_required_properties(O,T),class,("btn-primary";"btn-sm";"rounded-2";"align-self-end";"px-3";"py-1")) :- elem(add_all_required_properties(O,T),button,_).
attr(add_all_required_properties(O,T),"font-size","9px") :- elem(add_all_required_properties(O,T),button,_).
when(add_all_required_properties(O,T),click,call,add_atom(property(O,P,Input))) :- elem(add_all_required_properties(O,T),button,_),inspector_required_submission(O,T,P,Input).

elem(required_properties_hint(O,T),label,missing_required_properties(O,T)) :- elem(missing_required_properties(O,T),container,_).
attr(required_properties_hint(O,T),order,99) :- elem(required_properties_hint(O,T),label,_).
attr(required_properties_hint(O,T),label,"Use Add for one property, or fill every required field and choose Add all properties.") :- elem(required_properties_hint(O,T),label,_).
attr(required_properties_hint(O,T),class,("text-secondary";"m-0")) :- elem(required_properties_hint(O,T),label,_).
attr(required_properties_hint(O,T),"font-size","9px") :- elem(required_properties_hint(O,T),label,_).

% ============================================================
% MISSING OPTIONAL PROPERTIES
% ============================================================
elem(missing_optional_properties(O,T),container,inspector_properties(O,T)) :- object_selected_for_inspection(O,T),missing_optional_property(O,T,_,_).
attr(missing_optional_properties(O,T),order,6) :- elem(missing_optional_properties(O,T),container,_).
attr(missing_optional_properties(O,T),flex_direction,column) :- elem(missing_optional_properties(O,T),container,_).
attr(missing_optional_properties(O,T),class,("d-flex";"flex-column";"gap-1";"w-100")) :- elem(missing_optional_properties(O,T),container,_).
elem(missing_optional_properties_title(O,T),label,missing_optional_properties(O,T)) :- object_selected_for_inspection(O,T),missing_optional_property(O,T,_,_).
attr(missing_optional_properties_title(O,T),order,1) :- elem(missing_optional_properties_title(O,T),label,_).
attr(missing_optional_properties_title(O,T),label,"Optional properties") :- elem(missing_optional_properties_title(O,T),label,_).
attr(missing_optional_properties_title(O,T),class,("fw-bold";"text-secondary";"m-0")) :- elem(missing_optional_properties_title(O,T),label,_).
attr(missing_optional_properties_title(O,T),"font-size","9px") :- elem(missing_optional_properties_title(O,T),label,_).
elem(missing_optional_property_row(O,T,P,VT),container,missing_optional_properties(O,T)) :- object_selected_for_inspection(O,T),missing_optional_property(O,T,P,VT).
attr(missing_optional_property_row(O,T,P,VT),order,N+10) :- object_selected_for_inspection(O,T),missing_optional_property(O,T,P,VT),N=#count{P2,VT2:missing_optional_property(O,T,P2,VT2),P2<P}.
attr(missing_optional_property_row(O,T,P,VT),flex_direction,row) :- elem(missing_optional_property_row(O,T,P,VT),container,_).
attr(missing_optional_property_row(O,T,P,VT),class,("d-flex";"flex-row";"align-items-center";"gap-2";"px-2";"py-1";"bg-light";"border";"rounded-2")) :- elem(missing_optional_property_row(O,T,P,VT),container,_).
elem(missing_optional_property_name(O,T,P,VT),label,missing_optional_property_row(O,T,P,VT)) :- object_selected_for_inspection(O,T),missing_optional_property(O,T,P,VT).
attr(missing_optional_property_name(O,T,P,VT),order,1) :- elem(missing_optional_property_name(O,T,P,VT),label,_).
attr(missing_optional_property_name(O,T,P,VT),label,@concat(P," · ",VT)) :- elem(missing_optional_property_name(O,T,P,VT),label,_).
attr(missing_optional_property_name(O,T,P,VT),class,("font-monospace";"text-secondary";"flex-grow-1";"m-0")) :- elem(missing_optional_property_name(O,T,P,VT),label,_).
attr(missing_optional_property_name(O,T,P,VT),"font-size","9px") :- elem(missing_optional_property_name(O,T,P,VT),label,_).
elem(missing_optional_property_status(O,T,P,VT),label,missing_optional_property_row(O,T,P,VT)) :- object_selected_for_inspection(O,T),missing_optional_property(O,T,P,VT).
attr(missing_optional_property_status(O,T,P,VT),order,2) :- elem(missing_optional_property_status(O,T,P,VT),label,_).
attr(missing_optional_property_status(O,T,P,VT),label,"Not configured") :- elem(missing_optional_property_status(O,T,P,VT),label,_).
attr(missing_optional_property_status(O,T,P,VT),class,("fst-italic";"text-secondary";"m-0")) :- elem(missing_optional_property_status(O,T,P,VT),label,_).
attr(missing_optional_property_status(O,T,P,VT),"font-size","8px") :- elem(missing_optional_property_status(O,T,P,VT),label,_).

% PLACEMENTS
% ============================================================
elem(inspector_positions(O,T),container,inspector_body) :- object_selected_for_inspection(O,T), position(_,_,O).
attr(inspector_positions(O,T),order,20) :- elem(inspector_positions(O,T),container,_).
attr(inspector_positions(O,T),flex_direction,column) :- elem(inspector_positions(O,T),container,_).
attr(inspector_positions(O,T),class,("d-flex";"flex-column";"gap-1";"p-2";"bg-white";"border";"rounded-3";"w-100")) :- elem(inspector_positions(O,T),container,_).

% ============================================================
% PLACEMENTS HEADER
% ============================================================
elem(inspector_positions_header(O,T),container,inspector_positions(O,T)) :- object_selected_for_inspection(O,T), elem(inspector_positions(O,T),container,_).
attr(inspector_positions_header(O,T),order,1) :- elem(inspector_positions_header(O,T),container,_).
attr(inspector_positions_header(O,T),flex_direction,row) :- elem(inspector_positions_header(O,T),container,_).
attr(inspector_positions_header(O,T),class,("d-flex";"flex-row";"align-items-center";"justify-content-between")) :- elem(inspector_positions_header(O,T),container,_).

elem(inspector_positions_title(O,T),label,inspector_positions_header(O,T)) :- object_selected_for_inspection(O,T), elem(inspector_positions_header(O,T),container,_).
attr(inspector_positions_title(O,T),order,1) :- elem(inspector_positions_title(O,T),label,_).
attr(inspector_positions_title(O,T),label,"Placements") :- elem(inspector_positions_title(O,T),label,_).
attr(inspector_positions_title(O,T),class,("fw-bold";"text-dark";"m-0")) :- elem(inspector_positions_title(O,T),label,_).
attr(inspector_positions_title(O,T),"font-size","11px") :- elem(inspector_positions_title(O,T),label,_).

elem(inspector_positions_count(O,T),label,inspector_positions_header(O,T)) :- object_selected_for_inspection(O,T), elem(inspector_positions_header(O,T),container,_).
attr(inspector_positions_count(O,T),order,2) :- elem(inspector_positions_count(O,T),label,_).
attr(inspector_positions_count(O,T),label,@concat(N," total")) :- object_selected_for_inspection(O,T), N = #count { N1,R : position(N1,R,O) }.
attr(inspector_positions_count(O,T),class,("text-secondary";"m-0")) :- elem(inspector_positions_count(O,T),label,_).
attr(inspector_positions_count(O,T),"font-size","9px") :- elem(inspector_positions_count(O,T),label,_).

% ============================================================
% PLACEMENT LIST
% ============================================================
elem(inspector_position_list(O,T),container,inspector_positions(O,T)) :- object_selected_for_inspection(O,T), position(_,_,O).
attr(inspector_position_list(O,T),order,2) :- elem(inspector_position_list(O,T),container,_).
attr(inspector_position_list(O,T),flex_direction,column) :- elem(inspector_position_list(O,T),container,_).
attr(inspector_position_list(O,T),class,("d-flex";"flex-column";"gap-1")) :- elem(inspector_position_list(O,T),container,_).

% ============================================================
% INDIVIDUAL PLACEMENT
% ============================================================
elem(inspector_position(O,T,N,R),container,inspector_position_list(O,T)) :- object_selected_for_inspection(O,T), position(N,R,O).
attr(inspector_position(O,T,N,R),order,K) :- object_selected_for_inspection(O,T), position(N,R,O), K = #count { N2,R2 : position(N2,R2,O), (N2,R2) < (N,R) }.
attr(inspector_position(O,T,N,R),flex_direction,row) :- elem(inspector_position(O,T,N,R),container,_).
attr(inspector_position(O,T,N,R),class,("d-flex";"flex-row";"align-items-center";"justify-content-between";"gap-2";"px-2";"py-1";"bg-light";"rounded-2")) :- elem(inspector_position(O,T,N,R),container,_).

elem(inspector_position_node(O,T,N,R),label,inspector_position(O,T,N,R)) :- object_selected_for_inspection(O,T), position(N,R,O).
attr(inspector_position_node(O,T,N,R),order,1) :- elem(inspector_position_node(O,T,N,R),label,_).
attr(inspector_position_node(O,T,N,R),label,@concat("Node ",N)) :- object_selected_for_inspection(O,T), position(N,R,O).
attr(inspector_position_node(O,T,N,R),class,("font-monospace";"fw-semibold";"text-dark";"m-0")) :- elem(inspector_position_node(O,T,N,R),label,_).
attr(inspector_position_node(O,T,N,R),"font-size","9px") :- elem(inspector_position_node(O,T,N,R),label,_).

elem(inspector_position_role(O,T,N,R),label,inspector_position(O,T,N,R)) :- object_selected_for_inspection(O,T), position(N,R,O).
attr(inspector_position_role(O,T,N,R),order,2) :- elem(inspector_position_role(O,T,N,R),label,_).
attr(inspector_position_role(O,T,N,R),label,R) :- object_selected_for_inspection(O,T), position(N,R,O).
attr(inspector_position_role(O,T,N,R),class,("rounded-pill";"px-2";"fw-semibold";"text-secondary";"m-0")) :- elem(inspector_position_role(O,T,N,R),label,_).
attr(inspector_position_role(O,T,N,R),"font-size","8px") :- elem(inspector_position_role(O,T,N,R),label,_).





% ============================================================
% OBJECT PLACEMENT: ROLE SELECTION
% ============================================================

% Preserve placement selection.
when(w,load,context,(object_selected,O)) :- _clinguin_context(object_selected,O),complete(O,_).
when(w,load,context,(selected_role_for_placement,R)) :- _clinguin_context(object_selected,O),_clinguin_context(selected_role_for_placement,R),complete(O,T),type_role(T,R),image(O,R,_).
elem(b1, button, w). elem(b2, button, w). elem(l, line, w). attr(l, start, b1). attr(l, end, b2). elem(b1, color, @color(blue)).

