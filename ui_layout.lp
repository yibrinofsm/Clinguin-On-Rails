%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% REPLACE EXISTING FILE: ui_layout.lp
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Responsive workspace
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

elem(workspace,container,w).
attr(workspace,order,2).
attr(workspace,child_layout,flex).
attr(workspace,flex_direction,row).
attr(workspace,class,("d-flex";"flex-row";"flex-wrap";"gap-3";"p-3";"align-items-start";"w-100")).
attr(workspace,"background","transparent").
attr(workspace,"min-height","calc(100vh - 64px)").

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Main workspace panel
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

elem(main_panel,container,workspace).
attr(main_panel,order,1).
attr(main_panel,child_layout,flex).
attr(main_panel,flex_direction,column).
attr(main_panel,class,("d-flex";"flex-column";"flex-grow-1";"bg-white";"border";"p-3";"overflow-hidden")).
attr(main_panel,"min-width","660px").
attr(main_panel,"border-radius","18px").
attr(main_panel,"box-shadow","0 22px 60px rgba(15,23,42,.10)").
attr(main_panel,"transition","box-shadow 180ms ease,border-color 180ms ease").
attr(main_panel,"background","linear-gradient(180deg,rgba(255,255,255,.99),rgba(248,250,252,.98))").

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Header and statistics
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

elem(main_header,container,main_panel).
attr(main_header,order,1).
attr(main_header,child_layout,flex).
attr(main_header,flex_direction,row).
attr(main_header,class,("d-flex";"flex-row";"align-items-center";"justify-content-between";"gap-3";"pb-3";"border-bottom";"flex-wrap")).

elem(main_title_block,container,main_header).
attr(main_title_block,order,1).
attr(main_title_block,child_layout,flex).
attr(main_title_block,flex_direction,column).
attr(main_title_block,class,("d-flex";"flex-column";"gap-1")).

elem(main_title,label,main_title_block).
attr(main_title,order,1).
attr(main_title,label,"Interactive workspace").
attr(main_title,class,("fw-bold";"fs-4";"text-dark")).

elem(main_subtitle,label,main_title_block).
attr(main_subtitle,order,2).
attr(main_subtitle,label,"Create, inspect, enrich and position arbitrary ASP objects.").
attr(main_subtitle,class,("small";"text-muted")).

elem(main_badges,container,main_header).
attr(main_badges,order,2).
attr(main_badges,child_layout,flex).
attr(main_badges,flex_direction,row).
attr(main_badges,class,("d-flex";"flex-row";"gap-2";"align-items-center";"flex-wrap")).

elem(object_count_badge,label,main_badges).
attr(object_count_badge,order,1).
attr(object_count_badge,label,@concat(N," objects")) :- total_object_count(N).
attr(object_count_badge,class,("badge";"bg-primary";"text-white";"rounded-pill";"px-3";"py-2")).

elem(property_count_badge,label,main_badges).
attr(property_count_badge,order,2).
attr(property_count_badge,label,@concat(N," properties")) :- total_property_count(N).
attr(property_count_badge,class,("badge";"bg-light";"text-dark";"border";"rounded-pill";"px-3";"py-2")).

elem(edit_count_badge,label,main_badges).
attr(edit_count_badge,order,3).
attr(edit_count_badge,label,@concat(N," session edits")) :- interactive_edit_count(N).
attr(edit_count_badge,class,("badge";"bg-warning";"text-dark";"rounded-pill";"px-3";"py-2")) :- interactive_edit_count(N), N > 0.
attr(edit_count_badge,class,("badge";"bg-light";"text-muted";"border";"rounded-pill";"px-3";"py-2")) :- interactive_edit_count(0).

elem(grid_size_badge,label,main_badges) :- grid_dimensions(_,_).
attr(grid_size_badge,order,4) :- grid_dimensions(_,_).
attr(grid_size_badge,label,@concat(H," × ",W)) :- grid_dimensions(H,W).
attr(grid_size_badge,class,("badge";"bg-dark";"text-white";"rounded-pill";"px-3";"py-2")) :- grid_dimensions(_,_).

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Placement and display controls
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

elem(placement_panel,container,main_panel) :- has_grid.
attr(placement_panel,order,3) :- has_grid.
attr(placement_panel,child_layout,flex) :- has_grid.
attr(placement_panel,flex_direction,column) :- has_grid.
attr(placement_panel,class,("d-flex";"flex-column";"gap-3";"my-3";"p-3";"border")) :- has_grid.
attr(placement_panel,"border-radius","14px") :- has_grid.
attr(placement_panel,"background","linear-gradient(135deg,rgba(37,99,235,.055),rgba(124,58,237,.045))") :- has_grid.
attr(placement_panel,"box-shadow","0 12px 30px rgba(37,99,235,.08)") :- has_grid.

% Empty selection state.
elem(placement_empty,container,placement_panel) :- has_grid, not selected_object(_).
attr(placement_empty,order,1) :- has_grid, not selected_object(_).
attr(placement_empty,child_layout,flex) :- has_grid, not selected_object(_).
attr(placement_empty,flex_direction,row) :- has_grid, not selected_object(_).
attr(placement_empty,class,("d-flex";"flex-row";"align-items-center";"justify-content-center";"gap-2";"p-2")) :- has_grid, not selected_object(_).

elem(placement_empty_icon,label,placement_empty) :- has_grid, not selected_object(_).
attr(placement_empty_icon,order,1) :- has_grid, not selected_object(_).
attr(placement_empty_icon,label,"→") :- has_grid, not selected_object(_).
attr(placement_empty_icon,class,("fw-bold";"text-primary";"fs-5")) :- has_grid, not selected_object(_).

elem(placement_empty_text,label,placement_empty) :- has_grid, not selected_object(_).
attr(placement_empty_text,order,2) :- has_grid, not selected_object(_).
attr(placement_empty_text,label,"Select an object from the catalogue before placing it on a node.") :- has_grid, not selected_object(_).
attr(placement_empty_text,class,("small";"fw-bold";"text-muted")) :- has_grid, not selected_object(_).

% Selected object and role.
elem(placement_selected,container,placement_panel) :- has_grid, selected_object(_).
attr(placement_selected,order,1) :- has_grid, selected_object(_).
attr(placement_selected,child_layout,flex) :- has_grid, selected_object(_).
attr(placement_selected,flex_direction,row) :- has_grid, selected_object(_).
attr(placement_selected,class,("d-flex";"flex-row";"align-items-center";"justify-content-between";"gap-3";"flex-wrap")) :- has_grid, selected_object(_).

% Selected-object preview.
elem(placement_media(O),container,placement_selected) :- has_grid, selected_object(O).
attr(placement_media(O),order,1) :- has_grid, selected_object(O).
attr(placement_media(O),child_layout,absstatic) :- has_grid, selected_object(O).
attr(placement_media(O),width,54) :- has_grid, selected_object(O).
attr(placement_media(O),height,54) :- has_grid, selected_object(O).
attr(placement_media(O),class,("p-0";"m-0";"border";"bg-white";"flex-shrink-0")) :- has_grid, selected_object(O).
attr(placement_media(O),"border-radius","16px") :- has_grid, selected_object(O).
attr(placement_media(O),"overflow","hidden") :- has_grid, selected_object(O).
attr(placement_media(O),"box-shadow","0 9px 22px rgba(37,99,235,.16)") :- has_grid, selected_object(O).


elem(placement_thumb(O,Role,I),canvas,placement_media(O)) :- has_grid, selected_object(O), primary_image(O,Role,I).
attr(placement_thumb(O,Role,I),image,I) :- has_grid, selected_object(O), primary_image(O,Role,I).
attr(placement_thumb(O,Role,I),width,54) :- has_grid, selected_object(O), primary_image(O,Role,I).
attr(placement_thumb(O,Role,I),height,54) :- has_grid, selected_object(O), primary_image(O,Role,I).
attr(placement_thumb(O,Role,I),pos_x,0) :- has_grid, selected_object(O), primary_image(O,Role,I).
attr(placement_thumb(O,Role,I),pos_y,0) :- has_grid, selected_object(O), primary_image(O,Role,I).
attr(placement_thumb(O,Role,I),class,("p-0";"m-0";"border-0";"d-block")) :- has_grid, selected_object(O), primary_image(O,Role,I).
attr(placement_thumb(O,Role,I),"object-fit","contain") :- has_grid, selected_object(O), primary_image(O,Role,I).


elem(placement_thumb_fallback(O),label,placement_media(O)) :- has_grid, selected_object(O), not primary_image(O,_,_).
attr(placement_thumb_fallback(O),label,"◇") :- has_grid, selected_object(O), not primary_image(O,_,_).
attr(placement_thumb_fallback(O),width,54) :- has_grid, selected_object(O), not primary_image(O,_,_).
attr(placement_thumb_fallback(O),height,54) :- has_grid, selected_object(O), not primary_image(O,_,_).
attr(placement_thumb_fallback(O),pos_x,0) :- has_grid, selected_object(O), not primary_image(O,_,_).
attr(placement_thumb_fallback(O),pos_y,0) :- has_grid, selected_object(O), not primary_image(O,_,_).
attr(placement_thumb_fallback(O),class,("fw-bold";"text-primary";"text-center";"p-0";"m-0")) :- has_grid, selected_object(O), not primary_image(O,_,_).
attr(placement_thumb_fallback(O),"font-size","28px") :- has_grid, selected_object(O), not primary_image(O,_,_).
attr(placement_thumb_fallback(O),"line-height","54px") :- has_grid, selected_object(O), not primary_image(O,_,_).


elem(placement_check(O),label,placement_media(O)) :- has_grid, selected_object(O).
attr(placement_check(O),label,"✓") :- has_grid, selected_object(O).
attr(placement_check(O),width,18) :- has_grid, selected_object(O).
attr(placement_check(O),height,18) :- has_grid, selected_object(O).
attr(placement_check(O),pos_x,34) :- has_grid, selected_object(O).
attr(placement_check(O),pos_y,2) :- has_grid, selected_object(O).
attr(placement_check(O),class,("p-0";"m-0";"text-white";"fw-bold";"text-center")) :- has_grid, selected_object(O).
attr(placement_check(O),"border-radius","50%") :- has_grid, selected_object(O).
attr(placement_check(O),"line-height","18px") :- has_grid, selected_object(O).
attr(placement_check(O),"font-size","10px") :- has_grid, selected_object(O).
attr(placement_check(O),"background","linear-gradient(135deg,#16a34a,#059669)") :- has_grid, selected_object(O).
attr(placement_check(O),"box-shadow","0 3px 8px rgba(5,150,105,.30)") :- has_grid, selected_object(O).

elem(placement_identity,container,placement_selected) :- has_grid, selected_object(_).
attr(placement_identity,order,2) :- has_grid, selected_object(_).
attr(placement_identity,child_layout,flex) :- has_grid, selected_object(_).
attr(placement_identity,flex_direction,column) :- has_grid, selected_object(_).
attr(placement_identity,class,("d-flex";"flex-column";"gap-1";"overflow-hidden")) :- has_grid, selected_object(_).

elem(placement_caption,label,placement_identity) :- has_grid, selected_object(_).
attr(placement_caption,order,1) :- has_grid, selected_object(_).
attr(placement_caption,label,"Selected object") :- has_grid, selected_object(_).
attr(placement_caption,class,("small";"text-uppercase";"text-muted";"fw-bold")) :- has_grid, selected_object(_).

elem(placement_value,label,placement_identity) :- has_grid, selected_object(_).
attr(placement_value,order,2) :- has_grid, selected_object(_).
attr(placement_value,label,@concat("",L)) :- has_grid, selected_object(O), object_label(O,L).
attr(placement_value,class,("fw-bold";"font-monospace";"text-primary";"text-truncate")) :- has_grid, selected_object(_).


elem(placement_meta,container,placement_identity) :- has_grid, selected_object(_).
attr(placement_meta,order,3) :- has_grid, selected_object(_).
attr(placement_meta,child_layout,flex) :- has_grid, selected_object(_).
attr(placement_meta,flex_direction,row) :- has_grid, selected_object(_).
attr(placement_meta,class,("d-flex";"flex-row";"align-items-center";"gap-2";"flex-wrap")) :- has_grid, selected_object(_).


elem(placement_selected_badge,label,placement_meta) :- has_grid, selected_object(_).
attr(placement_selected_badge,label,"✓ SELECTED") :- has_grid, selected_object(_).
attr(placement_selected_badge,class,("badge";"rounded-pill";"text-white";"px-2";"py-1")) :- has_grid, selected_object(_).
attr(placement_selected_badge,"background","linear-gradient(135deg,#2563eb,#7c3aed)") :- has_grid, selected_object(_).


elem(placement_type,label,placement_meta) :- has_grid, selected_object(O), object(O,T).
attr(placement_type,label,@concat("Type · ",T)) :- has_grid, selected_object(O), object(O,T).
attr(placement_type,class,("small";"text-muted";"font-monospace")) :- has_grid, selected_object(_).

elem(role_controls,container,placement_selected) :- has_grid, selected_object(_).
attr(role_controls,order,3) :- has_grid, selected_object(_).
attr(role_controls,child_layout,flex) :- has_grid, selected_object(_).
attr(role_controls,flex_direction,row) :- has_grid, selected_object(_).
attr(role_controls,class,("d-flex";"flex-row";"align-items-center";"gap-2";"flex-wrap")) :- has_grid, selected_object(_).

elem(role_caption,label,role_controls) :- has_grid, selected_object(_).
attr(role_caption,order,1) :- has_grid, selected_object(_).
attr(role_caption,label,"Role") :- has_grid, selected_object(_).
attr(role_caption,class,("small";"text-muted";"fw-bold")) :- has_grid, selected_object(_).

elem(role_menu,dropdown_menu,role_controls) :- has_grid, selected_object(_), position_role(_).
attr(role_menu,order,2) :- has_grid, selected_object(_), position_role(_).
attr(role_menu,selected,@concat("",Role)) :- has_grid, selected_object(_), effective_role(Role).
attr(role_menu,class,("btn-sm";"btn-outline-primary")) :- has_grid, selected_object(_), position_role(_).

elem(role_item(Role),dropdown_menu_item,role_menu) :- has_grid, selected_object(_), position_role(Role).
attr(role_item(Role),order,N) :- has_grid, selected_object(_), role_rank(Role,N).
attr(role_item(Role),label,@concat("",Role)) :- has_grid, selected_object(_), position_role(Role).
when(role_item(Role),click,context,(placement_role,Role)) :- has_grid, selected_object(_), position_role(Role).
when(role_item(Role),click,update,(role_menu,selected,@concat("",Role))) :- has_grid, selected_object(_), position_role(Role).
when(role_item(Role),click,update,(active_role_label,label,@concat("",Role))) :- has_grid, selected_object(_), position_role(Role).
when(role_item(Role),click,call,update) :- has_grid, selected_object(_), position_role(Role).
feedback_on(role_item(Role),click,info,"Role selected",M) :- position_role(Role), M = @concat("The active placement role is ",Role,".").

elem(role_input,textfield,role_controls) :- has_grid, selected_object(_).
attr(role_input,order,3) :- has_grid, selected_object(_).
attr(role_input,width,180) :- has_grid, selected_object(_).
attr(role_input,placeholder,"Arbitrary ASP role") :- has_grid, selected_object(_).
attr(role_input,class,"font-monospace") :- has_grid, selected_object(_).
when(role_input,input,context,(placement_role,_value)) :- has_grid, selected_object(_).
when(role_input,input,update,(active_role_label,label,_value)) :- has_grid, selected_object(_).

elem(role_apply,button,role_controls) :- has_grid, selected_object(_).
attr(role_apply,order,4) :- has_grid, selected_object(_).
attr(role_apply,label,"Use role") :- has_grid, selected_object(_).
attr(role_apply,icon,"fa-check") :- has_grid, selected_object(_).
attr(role_apply,class,("btn-primary";"btn-sm")) :- has_grid, selected_object(_).
when(role_apply,click,call,update) :- has_grid, selected_object(_).
feedback_on(role_apply,click,info,"Role updated","The entered ASP term is now used for placement.") :- has_grid, selected_object(_).

elem(active_role_label,label,role_controls) :- has_grid, selected_object(_).
attr(active_role_label,order,5) :- has_grid, selected_object(_).
attr(active_role_label,label,@concat("",Role)) :- has_grid, selected_object(_), effective_role(Role).
attr(active_role_label,label,"Choose or enter a role") :- has_grid, selected_object(_), not effective_role(_).
attr(active_role_label,class,("badge";"bg-white";"text-dark";"border";"font-monospace";"px-2";"py-2")) :- has_grid, selected_object(_).

elem(placement_deselect,button,role_controls) :- has_grid, selected_object(_).
attr(placement_deselect,order,6) :- has_grid, selected_object(_).
attr(placement_deselect,label,"Deselect") :- has_grid, selected_object(_).
attr(placement_deselect,icon,"fa-xmark") :- has_grid, selected_object(_).
attr(placement_deselect,class,("btn-outline-secondary";"btn-sm";"border-0")) :- has_grid, selected_object(_).
when(placement_deselect,click,context,(selected_object,none)) :- has_grid, selected_object(_).
when(placement_deselect,click,call,update) :- has_grid, selected_object(_).
feedback_on(placement_deselect,click,info,"Selection cleared","No object is currently selected.") :- has_grid, selected_object(_).

% Display preferences.
elem(display_controls,container,placement_panel) :- has_grid.
attr(display_controls,order,2) :- has_grid.
attr(display_controls,child_layout,flex) :- has_grid.
attr(display_controls,flex_direction,row) :- has_grid.
attr(display_controls,class,("d-flex";"flex-row";"align-items-center";"justify-content-between";"gap-3";"flex-wrap";"pt-2";"border-top")) :- has_grid.

elem(scale_controls,container,display_controls) :- has_grid.
attr(scale_controls,order,1) :- has_grid.
attr(scale_controls,child_layout,flex) :- has_grid.
attr(scale_controls,flex_direction,row) :- has_grid.
attr(scale_controls,class,("d-flex";"flex-row";"align-items-center";"gap-1")) :- has_grid.

elem(scale_caption,label,scale_controls) :- has_grid.
attr(scale_caption,order,1) :- has_grid.
attr(scale_caption,label,"Grid size") :- has_grid.
attr(scale_caption,class,("small";"text-muted";"fw-bold";"me-1")) :- has_grid.

elem(scale_compact,button,scale_controls) :- has_grid.
attr(scale_compact,order,2) :- has_grid.
attr(scale_compact,label,"Compact") :- has_grid.
attr(scale_compact,class,("btn-sm";"btn-primary")) :- has_grid, grid_scale(compact).
attr(scale_compact,class,("btn-sm";"btn-outline-secondary")) :- has_grid, not grid_scale(compact).
when(scale_compact,click,context,(grid_scale,compact)) :- has_grid.
when(scale_compact,click,call,update) :- has_grid.
feedback_on(scale_compact,click,info,"Grid resized","Compact node size is active.") :- has_grid.

elem(scale_normal,button,scale_controls) :- has_grid.
attr(scale_normal,order,3) :- has_grid.
attr(scale_normal,label,"Normal") :- has_grid.
attr(scale_normal,class,("btn-sm";"btn-primary")) :- has_grid, grid_scale(normal).
attr(scale_normal,class,("btn-sm";"btn-outline-secondary")) :- has_grid, not grid_scale(normal).
when(scale_normal,click,context,(grid_scale,normal)) :- has_grid.
when(scale_normal,click,call,update) :- has_grid.
feedback_on(scale_normal,click,info,"Grid resized","Normal node size is active.") :- has_grid.

elem(scale_large,button,scale_controls) :- has_grid.
attr(scale_large,order,4) :- has_grid.
attr(scale_large,label,"Large") :- has_grid.
attr(scale_large,class,("btn-sm";"btn-primary")) :- has_grid, grid_scale(large).
attr(scale_large,class,("btn-sm";"btn-outline-secondary")) :- has_grid, not grid_scale(large).
when(scale_large,click,context,(grid_scale,large)) :- has_grid.
when(scale_large,click,call,update) :- has_grid.
feedback_on(scale_large,click,info,"Grid resized","Large node size is active.") :- has_grid.

elem(label_controls,container,display_controls) :- has_grid.
attr(label_controls,order,2) :- has_grid.
attr(label_controls,child_layout,flex) :- has_grid.
attr(label_controls,flex_direction,row) :- has_grid.
attr(label_controls,class,("d-flex";"flex-row";"align-items-center";"gap-1")) :- has_grid.

elem(label_caption,label,label_controls) :- has_grid.
attr(label_caption,order,1) :- has_grid.
attr(label_caption,label,"Labels") :- has_grid.
attr(label_caption,class,("small";"text-muted";"fw-bold";"me-1")) :- has_grid.

elem(labels_selected,button,label_controls) :- has_grid.
attr(labels_selected,order,2) :- has_grid.
attr(labels_selected,label,"Selected") :- has_grid.
attr(labels_selected,class,("btn-sm";"btn-primary")) :- has_grid, label_mode(selected).
attr(labels_selected,class,("btn-sm";"btn-outline-secondary")) :- has_grid, not label_mode(selected).
when(labels_selected,click,context,(label_mode,selected)) :- has_grid.
when(labels_selected,click,call,update) :- has_grid.
feedback_on(labels_selected,click,info,"Label mode changed","Only labels belonging to the selected object are displayed.") :- has_grid.

elem(labels_explicit,button,label_controls) :- has_grid.
attr(labels_explicit,order,3) :- has_grid.
attr(labels_explicit,label,"Named") :- has_grid.
attr(labels_explicit,class,("btn-sm";"btn-primary")) :- has_grid, label_mode(explicit).
attr(labels_explicit,class,("btn-sm";"btn-outline-secondary")) :- has_grid, not label_mode(explicit).
when(labels_explicit,click,context,(label_mode,explicit)) :- has_grid.
when(labels_explicit,click,call,update) :- has_grid.
feedback_on(labels_explicit,click,info,"Label mode changed","Only explicit label properties are displayed.") :- has_grid.

elem(labels_all,button,label_controls) :- has_grid.
attr(labels_all,order,4) :- has_grid.
attr(labels_all,label,"All") :- has_grid.
attr(labels_all,class,("btn-sm";"btn-primary")) :- has_grid, label_mode(all).
attr(labels_all,class,("btn-sm";"btn-outline-secondary")) :- has_grid, not label_mode(all).
when(labels_all,click,context,(label_mode,all)) :- has_grid.
when(labels_all,click,call,update) :- has_grid.
feedback_on(labels_all,click,info,"Label mode changed","Technical object labels are displayed when no explicit label exists.") :- has_grid.

elem(labels_none,button,label_controls) :- has_grid.
attr(labels_none,order,5) :- has_grid.
attr(labels_none,label,"Off") :- has_grid.
attr(labels_none,class,("btn-sm";"btn-primary")) :- has_grid, label_mode(none).
attr(labels_none,class,("btn-sm";"btn-outline-secondary")) :- has_grid, not label_mode(none).
when(labels_none,click,context,(label_mode,none)) :- has_grid.
when(labels_none,click,call,update) :- has_grid.
feedback_on(labels_none,click,info,"Label mode changed","Image overlay labels are hidden.") :- has_grid.

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Grid viewport
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

elem(grid_viewport,container,main_panel) :- has_grid.
attr(grid_viewport,order,4) :- has_grid.
attr(grid_viewport,child_layout,flex) :- has_grid.
attr(grid_viewport,flex_direction,column) :- has_grid.
attr(grid_viewport,class,("d-flex";"flex-column";"gap-0";"p-0";"m-0";"border";"overflow-auto";"bg-white")) :- has_grid.
attr(grid_viewport,"border-radius","14px") :- has_grid.
attr(grid_viewport,"max-height","calc(100vh - 355px)") :- has_grid.
attr(grid_viewport,"min-height","300px") :- has_grid.
attr(grid_viewport,"background","linear-gradient(45deg,rgba(148,163,184,.035) 25%,transparent 25%,transparent 75%,rgba(148,163,184,.035) 75%),linear-gradient(45deg,rgba(148,163,184,.035) 25%,transparent 25%,transparent 75%,rgba(148,163,184,.035) 75%)") :- has_grid.
attr(grid_viewport,"box-shadow","inset 0 0 0 1px rgba(15,23,42,.03)") :- has_grid.

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Rows and coordinate slots
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

elem(grid_row(R),container,grid_viewport) :- grid_row_index(R).
attr(grid_row(R),order,R) :- grid_row_index(R).
attr(grid_row(R),child_layout,flex) :- grid_row_index(R).
attr(grid_row(R),flex_direction,row) :- grid_row_index(R).
attr(grid_row(R),class,("d-flex";"flex-row";"flex-nowrap";"gap-0";"p-0";"m-0")) :- grid_row_index(R).

elem(node_box(R,C),container,grid_row(R)) :- grid_slot((R,C)).
attr(node_box(R,C),order,C) :- grid_slot((R,C)).
attr(node_box(R,C),width,S) :- grid_slot((R,C)), grid_node_size(S).
attr(node_box(R,C),height,S) :- grid_slot((R,C)), grid_node_size(S).
attr(node_box(R,C),child_layout,absstatic) :- grid_slot((R,C)).
attr(node_box(R,C),"min-width",Css) :- grid_slot((R,C)), grid_node_css(Css).
attr(node_box(R,C),"max-width",Css) :- grid_slot((R,C)), grid_node_css(Css).
attr(node_box(R,C),"min-height",Css) :- grid_slot((R,C)), grid_node_css(Css).
attr(node_box(R,C),"max-height",Css) :- grid_slot((R,C)), grid_node_css(Css).
attr(node_box(R,C),"box-sizing","border-box") :- grid_slot((R,C)).
attr(node_box(R,C),"overflow","hidden") :- grid_slot((R,C)).

% Active nodes.
attr(node_box(R,C),class,("p-0";"m-0";"border-0";"rounded-0";"bg-white";"flex-shrink-0")) :- node((R,C)).
attr(node_box(R,C),"box-shadow","inset 0 0 0 1px rgba(15,23,42,.065)") :- node((R,C)).
attr(node_box(R,C),"cursor","pointer") :- node((R,C)).
attr(node_box(R,C),"transition","transform 120ms ease,box-shadow 120ms ease,filter 120ms ease") :- node((R,C)).

% Inactive sparse-coordinate slots.
attr(node_box(R,C),class,("p-0";"m-0";"border-0";"rounded-0";"bg-light";"flex-shrink-0")) :- grid_slot((R,C)), not node((R,C)).
attr(node_box(R,C),"background","repeating-linear-gradient(135deg,#f8fafc,#f8fafc 5px,#eef2f7 5px,#eef2f7 10px)") :- grid_slot((R,C)), not node((R,C)).
attr(node_box(R,C),"opacity",".38") :- grid_slot((R,C)), not node((R,C)).
attr(node_box(R,C),"box-shadow","inset 0 0 0 1px rgba(15,23,42,.03)") :- grid_slot((R,C)), not node((R,C)).

% Selected-object positions.
attr(node_box(R,C),"outline","2px solid rgba(37,99,235,.95)") :- node((R,C)), selected_object_at((R,C)).
attr(node_box(R,C),"outline-offset","-2px") :- node((R,C)), selected_object_at((R,C)).

% Animated hover.
when(node_box(R,C),mouseenter,update,(node_box(R,C),"transform","scale(1.045)")) :- node((R,C)).
when(node_box(R,C),mouseenter,update,(node_box(R,C),"box-shadow","0 8px 18px rgba(37,99,235,.28),inset 0 0 0 2px rgba(37,99,235,.45)")) :- node((R,C)).
when(node_box(R,C),mouseleave,update,(node_box(R,C),"transform","scale(1)")) :- node((R,C)).
when(node_box(R,C),mouseleave,update,(node_box(R,C),"box-shadow","inset 0 0 0 1px rgba(15,23,42,.065)")) :- node((R,C)).

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Generic slot-aware placement
%
% The reusable UI never inspects application-specific object types. A role is
% the default visual slot. Domains may optionally map roles to a shared slot via
% property(Object,(ui,slot),Slot) or property(Object,(ui,slot,Role),Slot).
% Different slots may coexist at one node; one effective object is shown in a
% given (Node,Slot). Replacing an occupied slot always requires confirmation.
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Add the selected object when its generic slot is empty.
when(node_box(R,C),click,update,(node_box(R,C),"box-shadow","inset 0 0 0 3px rgba(22,163,74,.72)")) :-
    selected_empty_slot((R,C),Role,O).

when(node_box(R,C),click,call,add_atom(position((R,C),Role,O))) :-
    selected_empty_slot((R,C),Role,O).

feedback_on(node_box(R,C),click,success,"Position added",M) :-
    selected_empty_slot((R,C),Role,O),
    M = @concat("Added ",O," at (",R,",",C,") with role ",Role,".").

% Clicking the exact source position is a harmless no-op with clear feedback.
when(node_box(R,C),click,call,update) :-
    selected_same_visible_position((R,C),Role,O),
    not active_user_position((R,C),Role,O).

feedback_on(node_box(R,C),click,info,"Already positioned",M) :-
    selected_same_visible_position((R,C),Role,O),
    not active_user_position((R,C),Role,O),
    M = @concat(O," is already visible at (",R,",",C,") with role ",Role,".").

% A click or right-click on the selected session-created position asks before
% removing it. Nothing is deleted directly from the grid.
when(node_box(R,C),click,update,(position_remove_modal(R,C,Role,O),visibility,shown)) :-
    selected_effective_user_position((R,C),Role,O).

when(node_box(R,C),right_click,update,(position_remove_modal(R,C,Role,O),visibility,shown)) :-
    selected_effective_user_position((R,C),Role,O).

% A different source object occupies the target slot. Confirming creates a
% session override; removing that override later reveals the source position.
when(node_box(R,C),click,update,(position_replace_source_modal(R,C,OldRole,OldO,NewRole,NewO),visibility,shown)) :-
    selected_source_slot_conflict((R,C),OldRole,OldO,NewRole,NewO).

% A different session-created object occupies the target slot. Confirming uses
% one ordered server call: remove the old position, then add the replacement.
when(node_box(R,C),click,update,(position_replace_user_modal(R,C,OldRole,OldO,NewRole,NewO),visibility,shown)) :-
    selected_user_slot_conflict((R,C),OldRole,OldO,NewRole,NewO).

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Position-removal confirmation modals
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

elem(position_remove_modal(R,C,Role,O),modal,w) :-
    selected_active_user_position((R,C),Role,O).
attr(position_remove_modal(R,C,Role,O),title,"Remove positioned object?") :-
    selected_active_user_position((R,C),Role,O).
attr(position_remove_modal(R,C,Role,O),size,"m") :-
    selected_active_user_position((R,C),Role,O).
attr(position_remove_modal(R,C,Role,O),visibility,hidden) :-
    selected_active_user_position((R,C),Role,O).
attr(position_remove_modal(R,C,Role,O),class,"fade") :-
    selected_active_user_position((R,C),Role,O).


elem(position_remove_content(R,C,Role,O),container,position_remove_modal(R,C,Role,O)) :-
    selected_active_user_position((R,C),Role,O).
attr(position_remove_content(R,C,Role,O),child_layout,flex) :-
    selected_active_user_position((R,C),Role,O).
attr(position_remove_content(R,C,Role,O),flex_direction,column) :-
    selected_active_user_position((R,C),Role,O).
attr(position_remove_content(R,C,Role,O),class,("d-flex";"flex-column";"gap-3";"p-2")) :-
    selected_active_user_position((R,C),Role,O).


elem(position_remove_warning(R,C,Role,O),label,position_remove_content(R,C,Role,O)) :-
    selected_active_user_position((R,C),Role,O).
attr(position_remove_warning(R,C,Role,O),order,1) :-
    selected_active_user_position((R,C),Role,O).
attr(position_remove_warning(R,C,Role,O),label,@concat("Remove ",O," from (",R,",",C,") under role ",Role,"?")) :-
    selected_active_user_position((R,C),Role,O).
attr(position_remove_warning(R,C,Role,O),class,("small";"text-muted";"border";"rounded-3";"p-3";"bg-light")) :-
    selected_active_user_position((R,C),Role,O).


elem(position_remove_atom(R,C,Role,O),label,position_remove_content(R,C,Role,O)) :-
    selected_active_user_position((R,C),Role,O).
attr(position_remove_atom(R,C,Role,O),order,2) :-
    selected_active_user_position((R,C),Role,O).
attr(position_remove_atom(R,C,Role,O),label,@concat("position((",R,",",C,"),",Role,",",O,")")) :-
    selected_active_user_position((R,C),Role,O).
attr(position_remove_atom(R,C,Role,O),class,("small";"font-monospace";"text-danger";"border";"rounded-2";"p-2")) :-
    selected_active_user_position((R,C),Role,O).


elem(position_remove_actions(R,C,Role,O),container,position_remove_content(R,C,Role,O)) :-
    selected_active_user_position((R,C),Role,O).
attr(position_remove_actions(R,C,Role,O),order,3) :-
    selected_active_user_position((R,C),Role,O).
attr(position_remove_actions(R,C,Role,O),child_layout,flex) :-
    selected_active_user_position((R,C),Role,O).
attr(position_remove_actions(R,C,Role,O),flex_direction,row) :-
    selected_active_user_position((R,C),Role,O).
attr(position_remove_actions(R,C,Role,O),class,("d-flex";"flex-row";"justify-content-end";"gap-2")) :-
    selected_active_user_position((R,C),Role,O).


elem(position_remove_cancel(R,C,Role,O),button,position_remove_actions(R,C,Role,O)) :-
    selected_active_user_position((R,C),Role,O).
attr(position_remove_cancel(R,C,Role,O),order,1) :-
    selected_active_user_position((R,C),Role,O).
attr(position_remove_cancel(R,C,Role,O),label,"Keep position") :-
    selected_active_user_position((R,C),Role,O).
attr(position_remove_cancel(R,C,Role,O),class,"btn-outline-secondary") :-
    selected_active_user_position((R,C),Role,O).
when(position_remove_cancel(R,C,Role,O),click,update,(position_remove_modal(R,C,Role,O),visibility,hidden)) :-
    selected_active_user_position((R,C),Role,O).


elem(position_remove_confirm(R,C,Role,O),button,position_remove_actions(R,C,Role,O)) :-
    selected_active_user_position((R,C),Role,O).
attr(position_remove_confirm(R,C,Role,O),order,2) :-
    selected_active_user_position((R,C),Role,O).
attr(position_remove_confirm(R,C,Role,O),label,"Remove position") :-
    selected_active_user_position((R,C),Role,O).
attr(position_remove_confirm(R,C,Role,O),icon,"fa-trash") :-
    selected_active_user_position((R,C),Role,O).
attr(position_remove_confirm(R,C,Role,O),class,("btn-danger";"fw-bold")) :-
    selected_active_user_position((R,C),Role,O).
when(position_remove_confirm(R,C,Role,O),click,update,(position_remove_modal(R,C,Role,O),visibility,hidden)) :-
    selected_active_user_position((R,C),Role,O).
when(position_remove_confirm(R,C,Role,O),click,call,remove_atom(position((R,C),Role,O))) :-
    selected_active_user_position((R,C),Role,O).
feedback_on(position_remove_confirm(R,C,Role,O),click,success,"Position removed",M) :-
    selected_active_user_position((R,C),Role,O),
    M = @concat("Removed ",O," from (",R,",",C,") under role ",Role,".").

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Source-slot replacement confirmation
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

elem(position_replace_source_modal(R,C,OldRole,OldO,NewRole,NewO),modal,w) :-
    selected_source_slot_conflict((R,C),OldRole,OldO,NewRole,NewO).
attr(position_replace_source_modal(R,C,OldRole,OldO,NewRole,NewO),title,"Replace object in this slot?") :-
    selected_source_slot_conflict((R,C),OldRole,OldO,NewRole,NewO).
attr(position_replace_source_modal(R,C,OldRole,OldO,NewRole,NewO),size,"m") :-
    selected_source_slot_conflict((R,C),OldRole,OldO,NewRole,NewO).
attr(position_replace_source_modal(R,C,OldRole,OldO,NewRole,NewO),visibility,hidden) :-
    selected_source_slot_conflict((R,C),OldRole,OldO,NewRole,NewO).
attr(position_replace_source_modal(R,C,OldRole,OldO,NewRole,NewO),class,"fade") :-
    selected_source_slot_conflict((R,C),OldRole,OldO,NewRole,NewO).


elem(position_replace_source_content(R,C,OldRole,OldO,NewRole,NewO),container,position_replace_source_modal(R,C,OldRole,OldO,NewRole,NewO)) :-
    selected_source_slot_conflict((R,C),OldRole,OldO,NewRole,NewO).
attr(position_replace_source_content(R,C,OldRole,OldO,NewRole,NewO),child_layout,flex) :-
    selected_source_slot_conflict((R,C),OldRole,OldO,NewRole,NewO).
attr(position_replace_source_content(R,C,OldRole,OldO,NewRole,NewO),flex_direction,column) :-
    selected_source_slot_conflict((R,C),OldRole,OldO,NewRole,NewO).
attr(position_replace_source_content(R,C,OldRole,OldO,NewRole,NewO),class,("d-flex";"flex-column";"gap-3";"p-2")) :-
    selected_source_slot_conflict((R,C),OldRole,OldO,NewRole,NewO).


elem(position_replace_source_text(R,C,OldRole,OldO,NewRole,NewO),label,position_replace_source_content(R,C,OldRole,OldO,NewRole,NewO)) :-
    selected_source_slot_conflict((R,C),OldRole,OldO,NewRole,NewO).
attr(position_replace_source_text(R,C,OldRole,OldO,NewRole,NewO),order,1) :-
    selected_source_slot_conflict((R,C),OldRole,OldO,NewRole,NewO).
attr(position_replace_source_text(R,C,OldRole,OldO,NewRole,NewO),label,@concat("The slot at (",R,",",C,") currently shows ",OldO,". Replace it with ",NewO,"?")) :-
    selected_source_slot_conflict((R,C),OldRole,OldO,NewRole,NewO).
attr(position_replace_source_text(R,C,OldRole,OldO,NewRole,NewO),class,("small";"text-muted";"border";"rounded-3";"p-3";"bg-light")) :-
    selected_source_slot_conflict((R,C),OldRole,OldO,NewRole,NewO).


elem(position_replace_source_actions(R,C,OldRole,OldO,NewRole,NewO),container,position_replace_source_content(R,C,OldRole,OldO,NewRole,NewO)) :-
    selected_source_slot_conflict((R,C),OldRole,OldO,NewRole,NewO).
attr(position_replace_source_actions(R,C,OldRole,OldO,NewRole,NewO),order,2) :-
    selected_source_slot_conflict((R,C),OldRole,OldO,NewRole,NewO).
attr(position_replace_source_actions(R,C,OldRole,OldO,NewRole,NewO),child_layout,flex) :-
    selected_source_slot_conflict((R,C),OldRole,OldO,NewRole,NewO).
attr(position_replace_source_actions(R,C,OldRole,OldO,NewRole,NewO),flex_direction,row) :-
    selected_source_slot_conflict((R,C),OldRole,OldO,NewRole,NewO).
attr(position_replace_source_actions(R,C,OldRole,OldO,NewRole,NewO),class,("d-flex";"flex-row";"justify-content-end";"gap-2")) :-
    selected_source_slot_conflict((R,C),OldRole,OldO,NewRole,NewO).


elem(position_replace_source_cancel(R,C,OldRole,OldO,NewRole,NewO),button,position_replace_source_actions(R,C,OldRole,OldO,NewRole,NewO)) :-
    selected_source_slot_conflict((R,C),OldRole,OldO,NewRole,NewO).
attr(position_replace_source_cancel(R,C,OldRole,OldO,NewRole,NewO),order,1) :-
    selected_source_slot_conflict((R,C),OldRole,OldO,NewRole,NewO).
attr(position_replace_source_cancel(R,C,OldRole,OldO,NewRole,NewO),label,"Cancel") :-
    selected_source_slot_conflict((R,C),OldRole,OldO,NewRole,NewO).
attr(position_replace_source_cancel(R,C,OldRole,OldO,NewRole,NewO),class,"btn-outline-secondary") :-
    selected_source_slot_conflict((R,C),OldRole,OldO,NewRole,NewO).
when(position_replace_source_cancel(R,C,OldRole,OldO,NewRole,NewO),click,update,(position_replace_source_modal(R,C,OldRole,OldO,NewRole,NewO),visibility,hidden)) :-
    selected_source_slot_conflict((R,C),OldRole,OldO,NewRole,NewO).


elem(position_replace_source_confirm(R,C,OldRole,OldO,NewRole,NewO),button,position_replace_source_actions(R,C,OldRole,OldO,NewRole,NewO)) :-
    selected_source_slot_conflict((R,C),OldRole,OldO,NewRole,NewO).
attr(position_replace_source_confirm(R,C,OldRole,OldO,NewRole,NewO),order,2) :-
    selected_source_slot_conflict((R,C),OldRole,OldO,NewRole,NewO).
attr(position_replace_source_confirm(R,C,OldRole,OldO,NewRole,NewO),label,"Replace") :-
    selected_source_slot_conflict((R,C),OldRole,OldO,NewRole,NewO).
attr(position_replace_source_confirm(R,C,OldRole,OldO,NewRole,NewO),icon,"fa-arrows-rotate") :-
    selected_source_slot_conflict((R,C),OldRole,OldO,NewRole,NewO).
attr(position_replace_source_confirm(R,C,OldRole,OldO,NewRole,NewO),class,("btn-primary";"fw-bold")) :-
    selected_source_slot_conflict((R,C),OldRole,OldO,NewRole,NewO).
when(position_replace_source_confirm(R,C,OldRole,OldO,NewRole,NewO),click,update,(position_replace_source_modal(R,C,OldRole,OldO,NewRole,NewO),visibility,hidden)) :-
    selected_source_slot_conflict((R,C),OldRole,OldO,NewRole,NewO).
when(position_replace_source_confirm(R,C,OldRole,OldO,NewRole,NewO),click,call,add_atom(position((R,C),NewRole,NewO))) :-
    selected_source_slot_conflict((R,C),OldRole,OldO,NewRole,NewO).
feedback_on(position_replace_source_confirm(R,C,OldRole,OldO,NewRole,NewO),click,success,"Position replaced",M) :-
    selected_source_slot_conflict((R,C),OldRole,OldO,NewRole,NewO),
    M = @concat("Replaced ",OldO," with ",NewO," at (",R,",",C,").").

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Session-slot replacement confirmation
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

elem(position_replace_user_modal(R,C,OldRole,OldO,NewRole,NewO),modal,w) :-
    selected_user_slot_conflict((R,C),OldRole,OldO,NewRole,NewO).
attr(position_replace_user_modal(R,C,OldRole,OldO,NewRole,NewO),title,"Replace session object?") :-
    selected_user_slot_conflict((R,C),OldRole,OldO,NewRole,NewO).
attr(position_replace_user_modal(R,C,OldRole,OldO,NewRole,NewO),size,"m") :-
    selected_user_slot_conflict((R,C),OldRole,OldO,NewRole,NewO).
attr(position_replace_user_modal(R,C,OldRole,OldO,NewRole,NewO),visibility,hidden) :-
    selected_user_slot_conflict((R,C),OldRole,OldO,NewRole,NewO).
attr(position_replace_user_modal(R,C,OldRole,OldO,NewRole,NewO),class,"fade") :-
    selected_user_slot_conflict((R,C),OldRole,OldO,NewRole,NewO).


elem(position_replace_user_content(R,C,OldRole,OldO,NewRole,NewO),container,position_replace_user_modal(R,C,OldRole,OldO,NewRole,NewO)) :-
    selected_user_slot_conflict((R,C),OldRole,OldO,NewRole,NewO).
attr(position_replace_user_content(R,C,OldRole,OldO,NewRole,NewO),child_layout,flex) :-
    selected_user_slot_conflict((R,C),OldRole,OldO,NewRole,NewO).
attr(position_replace_user_content(R,C,OldRole,OldO,NewRole,NewO),flex_direction,column) :-
    selected_user_slot_conflict((R,C),OldRole,OldO,NewRole,NewO).
attr(position_replace_user_content(R,C,OldRole,OldO,NewRole,NewO),class,("d-flex";"flex-column";"gap-3";"p-2")) :-
    selected_user_slot_conflict((R,C),OldRole,OldO,NewRole,NewO).


elem(position_replace_user_text(R,C,OldRole,OldO,NewRole,NewO),label,position_replace_user_content(R,C,OldRole,OldO,NewRole,NewO)) :-
    selected_user_slot_conflict((R,C),OldRole,OldO,NewRole,NewO).
attr(position_replace_user_text(R,C,OldRole,OldO,NewRole,NewO),order,1) :-
    selected_user_slot_conflict((R,C),OldRole,OldO,NewRole,NewO).
attr(position_replace_user_text(R,C,OldRole,OldO,NewRole,NewO),label,@concat("Replace session object ",OldO," with ",NewO," at (",R,",",C,")?")) :-
    selected_user_slot_conflict((R,C),OldRole,OldO,NewRole,NewO).
attr(position_replace_user_text(R,C,OldRole,OldO,NewRole,NewO),class,("small";"text-muted";"border";"rounded-3";"p-3";"bg-light")) :-
    selected_user_slot_conflict((R,C),OldRole,OldO,NewRole,NewO).


elem(position_replace_user_actions(R,C,OldRole,OldO,NewRole,NewO),container,position_replace_user_content(R,C,OldRole,OldO,NewRole,NewO)) :-
    selected_user_slot_conflict((R,C),OldRole,OldO,NewRole,NewO).
attr(position_replace_user_actions(R,C,OldRole,OldO,NewRole,NewO),order,2) :-
    selected_user_slot_conflict((R,C),OldRole,OldO,NewRole,NewO).
attr(position_replace_user_actions(R,C,OldRole,OldO,NewRole,NewO),child_layout,flex) :-
    selected_user_slot_conflict((R,C),OldRole,OldO,NewRole,NewO).
attr(position_replace_user_actions(R,C,OldRole,OldO,NewRole,NewO),flex_direction,row) :-
    selected_user_slot_conflict((R,C),OldRole,OldO,NewRole,NewO).
attr(position_replace_user_actions(R,C,OldRole,OldO,NewRole,NewO),class,("d-flex";"flex-row";"justify-content-end";"gap-2")) :-
    selected_user_slot_conflict((R,C),OldRole,OldO,NewRole,NewO).


elem(position_replace_user_cancel(R,C,OldRole,OldO,NewRole,NewO),button,position_replace_user_actions(R,C,OldRole,OldO,NewRole,NewO)) :-
    selected_user_slot_conflict((R,C),OldRole,OldO,NewRole,NewO).
attr(position_replace_user_cancel(R,C,OldRole,OldO,NewRole,NewO),order,1) :-
    selected_user_slot_conflict((R,C),OldRole,OldO,NewRole,NewO).
attr(position_replace_user_cancel(R,C,OldRole,OldO,NewRole,NewO),label,"Cancel") :-
    selected_user_slot_conflict((R,C),OldRole,OldO,NewRole,NewO).
attr(position_replace_user_cancel(R,C,OldRole,OldO,NewRole,NewO),class,"btn-outline-secondary") :-
    selected_user_slot_conflict((R,C),OldRole,OldO,NewRole,NewO).
when(position_replace_user_cancel(R,C,OldRole,OldO,NewRole,NewO),click,update,(position_replace_user_modal(R,C,OldRole,OldO,NewRole,NewO),visibility,hidden)) :-
    selected_user_slot_conflict((R,C),OldRole,OldO,NewRole,NewO).


elem(position_replace_user_confirm(R,C,OldRole,OldO,NewRole,NewO),button,position_replace_user_actions(R,C,OldRole,OldO,NewRole,NewO)) :-
    selected_user_slot_conflict((R,C),OldRole,OldO,NewRole,NewO).
attr(position_replace_user_confirm(R,C,OldRole,OldO,NewRole,NewO),order,2) :-
    selected_user_slot_conflict((R,C),OldRole,OldO,NewRole,NewO).
attr(position_replace_user_confirm(R,C,OldRole,OldO,NewRole,NewO),label,"Replace") :-
    selected_user_slot_conflict((R,C),OldRole,OldO,NewRole,NewO).
attr(position_replace_user_confirm(R,C,OldRole,OldO,NewRole,NewO),icon,"fa-arrows-rotate") :-
    selected_user_slot_conflict((R,C),OldRole,OldO,NewRole,NewO).
attr(position_replace_user_confirm(R,C,OldRole,OldO,NewRole,NewO),class,("btn-primary";"fw-bold")) :-
    selected_user_slot_conflict((R,C),OldRole,OldO,NewRole,NewO).
when(position_replace_user_confirm(R,C,OldRole,OldO,NewRole,NewO),click,update,(position_replace_user_modal(R,C,OldRole,OldO,NewRole,NewO),visibility,hidden)) :-
    selected_user_slot_conflict((R,C),OldRole,OldO,NewRole,NewO).
when(position_replace_user_confirm(R,C,OldRole,OldO,NewRole,NewO),click,call,(remove_atom(position((R,C),OldRole,OldO)),add_atom(position((R,C),NewRole,NewO)))) :-
    selected_user_slot_conflict((R,C),OldRole,OldO,NewRole,NewO).
feedback_on(position_replace_user_confirm(R,C,OldRole,OldO,NewRole,NewO),click,success,"Position replaced",M) :-
    selected_user_slot_conflict((R,C),OldRole,OldO,NewRole,NewO),
    M = @concat("Replaced ",OldO," with ",NewO," at (",R,",",C,").").

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Generic image layers
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

elem(node_img(R,C,Role,O,I),canvas,node_box(R,C)) :- node_image((R,C),Role,O,I).
attr(node_img(R,C,Role,O,I),image,I) :- node_image((R,C),Role,O,I).
attr(node_img(R,C,Role,O,I),width,S) :- node_image((R,C),Role,O,I), grid_node_size(S).
attr(node_img(R,C,Role,O,I),height,S) :- node_image((R,C),Role,O,I), grid_node_size(S).
attr(node_img(R,C,Role,O,I),pos_x,0) :- node_image((R,C),Role,O,I).
attr(node_img(R,C,Role,O,I),pos_y,0) :- node_image((R,C),Role,O,I).
attr(node_img(R,C,Role,O,I),"z-index",Z) :- node_image((R,C),Role,O,I), visual_z_index(O,Role,Z).
attr(node_img(R,C,Role,O,I),"object-fit",@concat("",Fit)) :- node_image((R,C),Role,O,I), visual_fit(O,Role,Fit).
attr(node_img(R,C,Role,O,I),"opacity",@concat("",V)) :- node_image((R,C),Role,O,I), visual_opacity(O,Role,V).
attr(node_img(R,C,Role,O,I),"transform",@concat("",T)) :- node_image((R,C),Role,O,I), visual_transform(O,Role,T).
attr(node_img(R,C,Role,O,I),"transform-origin","center center") :- node_image((R,C),Role,O,I).
attr(node_img(R,C,Role,O,I),class,("p-0";"m-0";"border-0";"rounded-0";"d-block")) :- node_image((R,C),Role,O,I).
attr(node_img(R,C,Role,O,I),"background","transparent") :- node_image((R,C),Role,O,I).
attr(node_img(R,C,Role,O,I),"pointer-events","none") :- node_image((R,C),Role,O,I).

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Text fallback when image/3 is absent
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

elem(node_text_view(R,C,Role,O),label,node_box(R,C)) :- node_text((R,C),Role,O,_).
attr(node_text_view(R,C,Role,O),label,@concat("",L)) :- node_text((R,C),Role,O,L).
attr(node_text_view(R,C,Role,O),width,S) :- node_text((R,C),Role,O,_), grid_node_size(S).
attr(node_text_view(R,C,Role,O),height,S) :- node_text((R,C),Role,O,_), grid_node_size(S).
attr(node_text_view(R,C,Role,O),pos_x,0) :- node_text((R,C),Role,O,_).
attr(node_text_view(R,C,Role,O),pos_y,0) :- node_text((R,C),Role,O,_).
attr(node_text_view(R,C,Role,O),"z-index",Z) :- node_text((R,C),Role,O,_), visual_z_index(O,Role,Z).
attr(node_text_view(R,C,Role,O),class,("p-0";"m-0";"small";"fw-bold";"text-center";"font-monospace";"text-primary")) :- node_text((R,C),Role,O,_).
attr(node_text_view(R,C,Role,O),"font-size",F) :- node_text((R,C),Role,O,_), grid_text_size(F).
attr(node_text_view(R,C,Role,O),"display","flex") :- node_text((R,C),Role,O,_).
attr(node_text_view(R,C,Role,O),"align-items","center") :- node_text((R,C),Role,O,_).
attr(node_text_view(R,C,Role,O),"justify-content","center") :- node_text((R,C),Role,O,_).
attr(node_text_view(R,C,Role,O),"overflow","hidden") :- node_text((R,C),Role,O,_).
attr(node_text_view(R,C,Role,O),"white-space","nowrap") :- node_text((R,C),Role,O,_).
attr(node_text_view(R,C,Role,O),"text-overflow","ellipsis") :- node_text((R,C),Role,O,_).
attr(node_text_view(R,C,Role,O),"pointer-events","none") :- node_text((R,C),Role,O,_).

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Attractive circular labels for the top visual object
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

elem(node_label(R,C,Role,O),label,node_box(R,C)) :-
    node_overlay_label((R,C),Role,O,_).
attr(node_label(R,C,Role,O),label,@concat("",L)) :-
    node_overlay_label((R,C),Role,O,L).
attr(node_label(R,C,Role,O),width,S) :-
    node_overlay_label((R,C),Role,O,_), grid_badge_size(S).
attr(node_label(R,C,Role,O),height,S) :-
    node_overlay_label((R,C),Role,O,_), grid_badge_size(S).
attr(node_label(R,C,Role,O),pos_x,X) :-
    node_overlay_label((R,C),Role,O,_), grid_badge_x(X).
attr(node_label(R,C,Role,O),pos_y,Y) :-
    node_overlay_label((R,C),Role,O,_), grid_badge_y(Y).
attr(node_label(R,C,Role,O),"z-index",Z) :-
    node_overlay_label((R,C),Role,O,_), overlay_z_index((R,C),Z).
attr(node_label(R,C,Role,O),class,("p-0";"m-0";"fw-bold";"text-white";"text-center")) :-
    node_overlay_label((R,C),Role,O,_).
attr(node_label(R,C,Role,O),"display","flex") :- node_overlay_label((R,C),Role,O,_).
attr(node_label(R,C,Role,O),"align-items","center") :- node_overlay_label((R,C),Role,O,_).
attr(node_label(R,C,Role,O),"justify-content","center") :- node_overlay_label((R,C),Role,O,_).
attr(node_label(R,C,Role,O),"border-radius","50%") :- node_overlay_label((R,C),Role,O,_).
attr(node_label(R,C,Role,O),"font-size",F) :-
    node_overlay_label((R,C),Role,O,_), grid_badge_font(F).
attr(node_label(R,C,Role,O),"background","linear-gradient(135deg,#2563eb,#7c3aed)") :-
    node_overlay_label((R,C),Role,O,_), not selected_object(O).
attr(node_label(R,C,Role,O),"background","linear-gradient(135deg,#16a34a,#059669)") :-
    node_overlay_label((R,C),Role,O,_), selected_object(O).
attr(node_label(R,C,Role,O),"border","2px solid rgba(255,255,255,.96)") :-
    node_overlay_label((R,C),Role,O,_).
attr(node_label(R,C,Role,O),"box-shadow","0 4px 12px rgba(15,23,42,.30)") :-
    node_overlay_label((R,C),Role,O,_).
attr(node_label(R,C,Role,O),"text-shadow","0 1px 2px rgba(0,0,0,.42)") :-
    node_overlay_label((R,C),Role,O,_).
attr(node_label(R,C,Role,O),"overflow","hidden") :- node_overlay_label((R,C),Role,O,_).
attr(node_label(R,C,Role,O),"white-space","nowrap") :- node_overlay_label((R,C),Role,O,_).
attr(node_label(R,C,Role,O),"pointer-events","none") :- node_overlay_label((R,C),Role,O,_).

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Selected session-position removal marker
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

elem(node_remove_mark(R,C,Role,O),label,node_box(R,C)) :-
    selected_effective_user_position((R,C),Role,O).
attr(node_remove_mark(R,C,Role,O),label,"×") :-
    selected_effective_user_position((R,C),Role,O).
attr(node_remove_mark(R,C,Role,O),width,16) :-
    selected_effective_user_position((R,C),Role,O).
attr(node_remove_mark(R,C,Role,O),height,16) :-
    selected_effective_user_position((R,C),Role,O).
attr(node_remove_mark(R,C,Role,O),pos_x,2) :-
    selected_effective_user_position((R,C),Role,O).
attr(node_remove_mark(R,C,Role,O),pos_y,2) :-
    selected_effective_user_position((R,C),Role,O).
attr(node_remove_mark(R,C,Role,O),"z-index",99999999) :-
    selected_effective_user_position((R,C),Role,O).
attr(node_remove_mark(R,C,Role,O),class,("p-0";"m-0";"fw-bold";"text-white";"text-center")) :-
    selected_effective_user_position((R,C),Role,O).
attr(node_remove_mark(R,C,Role,O),"border-radius","50%") :-
    selected_effective_user_position((R,C),Role,O).
attr(node_remove_mark(R,C,Role,O),"line-height","15px") :-
    selected_effective_user_position((R,C),Role,O).
attr(node_remove_mark(R,C,Role,O),"font-size","11px") :-
    selected_effective_user_position((R,C),Role,O).
attr(node_remove_mark(R,C,Role,O),"background","linear-gradient(135deg,#ef4444,#b91c1c)") :-
    selected_effective_user_position((R,C),Role,O).
attr(node_remove_mark(R,C,Role,O),"box-shadow","0 3px 9px rgba(185,28,28,.35)") :-
    selected_effective_user_position((R,C),Role,O).
attr(node_remove_mark(R,C,Role,O),"pointer-events","none") :-
    selected_effective_user_position((R,C),Role,O).

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% No-grid fallback
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

elem(no_grid_panel,container,main_panel) :- not has_grid.
attr(no_grid_panel,order,4) :- not has_grid.
attr(no_grid_panel,child_layout,flex) :- not has_grid.
attr(no_grid_panel,flex_direction,column) :- not has_grid.
attr(no_grid_panel,class,("d-flex";"flex-column";"align-items-center";"justify-content-center";"gap-2";"border";"p-5";"bg-light")) :- not has_grid.
attr(no_grid_panel,"border-radius","16px") :- not has_grid.
attr(no_grid_panel,"min-height","320px") :- not has_grid.

elem(no_grid_title,label,no_grid_panel) :- not has_grid.
attr(no_grid_title,order,1) :- not has_grid.
attr(no_grid_title,label,"No two-dimensional nodes") :- not has_grid.
attr(no_grid_title,class,("fw-bold";"fs-4";"text-dark")) :- not has_grid.

elem(no_grid_text,label,no_grid_panel) :- not has_grid.
attr(no_grid_text,order,2) :- not has_grid.
attr(no_grid_text,label,"Add node((Row,Column)) facts to enable placement. Object, property and presentation editing remain available.") :- not has_grid.
attr(no_grid_text,class,("small";"text-muted";"text-center")) :- not has_grid.

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Inspector host
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

elem(sidebar_panel,container,workspace).
attr(sidebar_panel,order,2).
attr(sidebar_panel,width,430).
attr(sidebar_panel,child_layout,flex).
attr(sidebar_panel,flex_direction,column).
attr(sidebar_panel,class,("d-flex";"flex-column";"gap-3";"bg-white";"border";"p-3";"overflow-auto";"flex-shrink-0")).
attr(sidebar_panel,"border-radius","18px").
attr(sidebar_panel,"max-height","calc(100vh - 88px)").
attr(sidebar_panel,"position","sticky").
attr(sidebar_panel,"top","74px").
attr(sidebar_panel,"box-shadow","0 22px 60px rgba(15,23,42,.12)").
attr(sidebar_panel,"background","linear-gradient(180deg,#ffffff 0%,#f8faff 58%,#f4f7ff 100%)").
attr(sidebar_panel,"transition","transform 220ms ease,box-shadow 220ms ease,border-color 220ms ease").