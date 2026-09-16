elem(workspace,container,w).
attr(workspace,flex_direction,row).
elem(main_panel,container,workspace).
attr(main_panel,order,1).
elem(sidebar_panel,container,workspace).
attr(sidebar_panel,order,2).
elem(placement_panel,container,main_panel).
attr(placement_panel,order,1).
attr(placement_panel,class,("d-flex";"flex-column";"gap-2";"px-3";"py-2";"bg-white";"border";"rounded-3";"shadow-sm")).
elem(placement_header,container,placement_panel).
attr(placement_header,order,1).
attr(placement_header,flex_direction,row).
attr(placement_header,class,("d-flex";"flex-row";"align-items-center";"justify-content-between";"gap-3")).
elem(placement_title,label,placement_header).
attr(placement_title,order,1).
attr(placement_title,label,"Placement").
attr(placement_title,class,("fw-bold";"text-dark";"small")).
elem(placement_step,label,placement_header).
attr(placement_step,order,2).
attr(placement_step,label,"01 Select  /  02 Choose role  /  03 Place").
attr(placement_step,class,("small";"text-secondary";"text-end")).
elem(selection_empty,label,placement_panel) :- not _clinguin_context(selected_object,O):object(O,_).
attr(selection_empty,label,"Choose an object in the catalogue. Its placement controls will appear here.") :- elem(selection_empty,label,_).
elem(selection,container,placement_panel) :- _clinguin_context(selected_object,O),object(O,_).
elem(selection_name,label,selection_identity) :- _clinguin_context(selected_object,O),object(O,_).
attr(selection_name,label,@concat("",O)) :- _clinguin_context(selected_object,O),object(O,_).
elem(role_menu,dropdown_menu,role_control) :- _clinguin_context(selected_object,O),object(O,_).
attr(role_menu,selected,@concat("",R)) :- _clinguin_context(selected_object,O),object(O,_),_clinguin_context(placement_role,R),role(O,R,_,_,_).
attr(role_menu,selected,"Select a role") :- _clinguin_context(selected_object,O),object(O,_),not _clinguin_context(placement_role,R):role(O,R,_,_,_).
elem(role_item(R),dropdown_menu_item,role_menu) :- _clinguin_context(selected_object,O),object(O,_),role(O,R,_,_,_).
attr(role_item(R),label,@concat("",R)) :- _clinguin_context(selected_object,O),object(O,_),role(O,R,_,_,_).
when(role_item(R),click,context,(placement_role,R)) :- _clinguin_context(selected_object,O),object(O,_),role(O,R,_,_,_).
when(role_item(R),click,call,()) :- _clinguin_context(selected_object,O),object(O,_),role(O,R,_,_,_).
elem(unselect,button,selection) :- _clinguin_context(selected_object,O),object(O,_).
attr(unselect,label,"Unselect") :- _clinguin_context(selected_object,O),object(O,_).
when(unselect,click,context,(selected_object,none)) :- _clinguin_context(selected_object,O),object(O,_).
when(unselect,click,context,(placement_role,none)) :- _clinguin_context(selected_object,O),object(O,_).
when(unselect,click,context,(inspector_open,false)) :- _clinguin_context(selected_object,O),object(O,_).
when(unselect,click,context,(dialog,none)) :- _clinguin_context(selected_object,O),object(O,_).
when(unselect,click,call,()) :- _clinguin_context(selected_object,O),object(O,_).
elem(role_notice,label,role_notice_box) :- _clinguin_context(selected_object,O),object(O,_),not _clinguin_context(placement_role,R):role(O,R,_,_,_).
attr(role_notice,label,"Choose a placement role before clicking the grid.") :- elem(role_notice,label,_).
attr(selection,order,2) :- _clinguin_context(selected_object,O),object(O,_).
attr(selection,flex_direction,row) :- _clinguin_context(selected_object,O),object(O,_).
attr(selection,class,("d-flex";"flex-row";"flex-wrap";"align-items-center";"gap-2";"mw-100")) :- _clinguin_context(selected_object,O),object(O,_).
elem(selection_identity,container,selection) :- _clinguin_context(selected_object,O),object(O,_).
attr(selection_identity,order,1) :- _clinguin_context(selected_object,O),object(O,_).
elem(selection_caption,label,selection_identity) :- _clinguin_context(selected_object,O),object(O,_).
attr(selection_caption,label,"SELECTED OBJECT") :- _clinguin_context(selected_object,O),object(O,_).
attr(selection_caption,class,("small";"fw-bold";"text-secondary";"text-uppercase")) :- _clinguin_context(selected_object,O),object(O,_).
attr(selection_caption,order,1) :- _clinguin_context(selected_object,O),object(O,_).
attr(selection_name,order,2) :- _clinguin_context(selected_object,O),object(O,_).
attr(selection_name,class,("fw-bold";"text-primary")) :- _clinguin_context(selected_object,O),object(O,_).
elem(role_control,container,selection) :- _clinguin_context(selected_object,O),object(O,_).
attr(role_control,order,2) :- _clinguin_context(selected_object,O),object(O,_).
elem(role_caption,label,role_control) :- _clinguin_context(selected_object,O),object(O,_).
attr(role_caption,label,"PLACEMENT ROLE") :- _clinguin_context(selected_object,O),object(O,_).
attr(role_caption,class,("small";"fw-bold";"text-secondary";"text-uppercase")) :- _clinguin_context(selected_object,O),object(O,_).
attr(role_caption,order,1) :- _clinguin_context(selected_object,O),object(O,_).
attr(role_menu,order,2) :- _clinguin_context(selected_object,O),object(O,_).
attr(role_menu,class,("btn-outline-primary";"rounded-3")) :- _clinguin_context(selected_object,O),object(O,_).
attr(unselect,order,3) :- _clinguin_context(selected_object,O),object(O,_).
attr(unselect,class,"btn-outline-secondary") :- _clinguin_context(selected_object,O),object(O,_).
attr(selection_empty,order,2) :- elem(selection_empty,label,_).
attr(selection_empty,class,("small";"text-secondary";"py-1")) :- elem(selection_empty,label,_).
attr(role_notice_box,order,3) :- elem(role_notice,label,_).
elem(placement_hint,label,placement_panel).
attr(placement_hint,label,"Click a grid cell to place. Your object stays selected until you click Unselect.").
attr(placement_hint,order,4).
attr(placement_hint,class,("small";"text-secondary")).
elem(grid_panel,container,main_panel) :- node((_,_)).
attr(grid_panel,order,2) :- node((_,_)).
attr(grid_panel,class,("d-flex";"flex-column";"bg-white";"border";"rounded-3";"shadow-sm";"overflow-hidden";"mw-100")) :- node((_,_)).
elem(grid_header,container,grid_panel) :- node((_,_)).
attr(grid_header,order,1) :- node((_,_)).
attr(grid_header,flex_direction,row) :- node((_,_)).
attr(grid_header,class,("d-flex";"flex-row";"flex-wrap";"align-items-center";"justify-content-between";"gap-2";"px-3";"py-2")) :- node((_,_)).
elem(grid_title,label,grid_header) :- node((_,_)).
attr(grid_title,label,"Grid workspace") :- node((_,_)).
attr(grid_title,class,("fw-bold";"text-dark")) :- node((_,_)).
attr(grid_title,order,1) :- node((_,_)).
elem(grid_dimensions,label,grid_header) :- node((_,_)).
attr(grid_dimensions,class,("small";"text-secondary")) :- node((_,_)).
attr(grid_dimensions,order,2) :- node((_,_)).
attr(grid_dimensions,label,@concat(Rows," rows × ",Cols," columns · ",N," cells")) :- node((_,_)),Rows=#count{R:node((R,_))},Cols=#count{C:node((_,C))},N=#count{P:node(P)}.
attr(grid_viewport,order,3) :- node((_,_)).
elem(grid_footer,container,grid_panel) :- node((_,_)).
attr(grid_footer,order,4) :- node((_,_)).
attr(grid_footer,flex_direction,row) :- node((_,_)).
attr(grid_footer,class,("d-flex";"flex-row";"flex-wrap";"justify-content-between";"gap-3";"px-3";"py-2";"border-top";"bg-white")) :- node((_,_)).
elem(grid_help,label,grid_footer) :- node((_,_)).
attr(grid_help,class,("small";"text-secondary")) :- node((_,_)).
attr(grid_help,label,"Click to place · Click the same placement or right-click to delete") :- node((_,_)).
attr(grid_help,order,1) :- node((_,_)).
elem(grid_count,label,grid_footer) :- node((_,_)).
attr(grid_count,class,("small";"fw-bold";"text-secondary")) :- node((_,_)).
attr(grid_count,order,2) :- node((_,_)).
attr(grid_count,label,@concat(N," visible placements")) :- node((_,_)),N=#count{P,R,O:elem(placement(P,R,O),container,_),not placeholder(O)}.
elem(display_controls,container,grid_panel) :- node((_,_)).
elem(scale_caption,label,scale_controls) :- node((_,_)).
elem(scale_compact,button,scale_controls) :- node((_,_)).
when(scale_compact,click,context,(grid_scale,compact)) :- node((_,_)).
elem(scale_normal,button,scale_controls) :- node((_,_)).
when(scale_normal,click,context,(grid_scale,normal)) :- node((_,_)).
elem(scale_large,button,scale_controls) :- node((_,_)).
when(scale_large,click,context,(grid_scale,large)) :- node((_,_)).
elem(labels_explicit,button,label_controls) :- node((_,_)).
when(labels_explicit,click,context,(label_mode,explicit)) :- node((_,_)).
elem(labels_all,button,label_controls) :- node((_,_)).
when(labels_all,click,context,(label_mode,all)) :- node((_,_)).
elem(labels_off,button,label_controls) :- node((_,_)).
when(labels_off,click,context,(label_mode,off)) :- node((_,_)).
attr(display_controls,order,2) :- node((_,_)).
attr(display_controls,flex_direction,row) :- node((_,_)).
elem(scale_controls,container,display_controls) :- node((_,_)).
attr(scale_controls,order,1) :- node((_,_)).
attr(scale_controls,flex_direction,row) :- node((_,_)).
elem(label_controls,container,display_controls) :- node((_,_)).
attr(label_controls,order,2) :- node((_,_)).
attr(label_controls,flex_direction,row) :- node((_,_)).
attr(scale_caption,label,"Zoom") :- node((_,_)).
attr(scale_caption,order,0) :- node((_,_)).
elem(label_caption,label,label_controls) :- node((_,_)).
attr(label_caption,label,"Labels") :- node((_,_)).
attr(label_caption,order,0) :- node((_,_)).
attr(scale_compact,label,"28 px") :- node((_,_)).
attr(scale_compact,order,1) :- node((_,_)).
attr(scale_compact,class,("btn-light";"border";"text-dark";"px-2")) :- node((_,_)).
attr(scale_normal,label,"36 px") :- node((_,_)).
attr(scale_normal,order,2) :- node((_,_)).
attr(scale_normal,class,("btn-light";"border";"text-dark";"px-2")) :- node((_,_)).
attr(scale_large,label,"48 px") :- node((_,_)).
attr(scale_large,order,3) :- node((_,_)).
attr(scale_large,class,("btn-light";"border";"text-dark";"px-2")) :- node((_,_)).
attr(labels_explicit,label,"Object IDs") :- node((_,_)).
attr(labels_explicit,order,1) :- node((_,_)).
attr(labels_explicit,class,("btn-outline-secondary";"px-2")) :- node((_,_)).
attr(labels_all,label,"All") :- node((_,_)).
attr(labels_all,order,2) :- node((_,_)).
attr(labels_all,class,("btn-outline-secondary";"px-2")) :- node((_,_)).
attr(labels_off,label,"Off") :- node((_,_)).
attr(labels_off,order,3) :- node((_,_)).
attr(labels_off,class,("btn-outline-secondary";"px-2")) :- node((_,_)).
elem(grid_viewport,container,grid_panel) :- node((_,_)).
elem(grid_surface,container,grid_viewport) :- node((_,_)).
attr(grid_surface,child_layout,absstatic) :- node((_,_)).
elem(node_box(Row,Col),container,grid_surface) :- node((Row,Col)).
elem(placement(N,R,O),container,node_box(Row,Col)) :- node((Row,Col)),N=(Row,Col),position(N,R,O),object(O,_),role(O,R,S,_,_),_clinguin_atom(position(N,R,O)),(R,O)=#max{(R2,O2):_clinguin_atom(position(N,R2,O2)),position(N,R2,O2),object(O2,_),role(O2,R2,S,_,_)}.
elem(placement(N,R,O),container,node_box(Row,Col)) :- node((Row,Col)),N=(Row,Col),position(N,R,O),object(O,_),role(O,R,S,_,_),0=#count{R2,O2:_clinguin_atom(position(N,R2,O2)),position(N,R2,O2),object(O2,_),role(O2,R2,S,_,_)}.
attr(placement(N,R,O),visibility,hidden) :- elem(placement(N,R,O),container,_),placeholder(O).
elem(node_image(N,R,O,I),canvas,placement(N,R,O)) :- elem(placement(N,R,O),container,_),not placeholder(O),image(O,R,I),I!="",I!=" ".
attr(node_image(N,R,O,I),image,I) :- elem(node_image(N,R,O,I),canvas,_).
elem(node_text(N,R,O),label,placement(N,R,O)) :- elem(placement(N,R,O),container,_),not placeholder(O),0=#count{I:image(O,R,I),I!="",I!=" "}.
attr(node_text(N,R,O),label,@concat("",L)) :- elem(node_text(N,R,O),label,_),label(O,L,_).
attr(node_text(N,R,O),label,@concat("",O)) :- elem(node_text(N,R,O),label,_),not label(O,_,_).
elem(node_badge(N,R,O),label,badge_box(N,R,O)) :- elem(placement(N,R,O),container,_),not placeholder(O),visual(O,R,Z,_,_,_,_),Z=#max{Z2:elem(placement(N,R2,O2),container,_),visual(O2,R2,Z2,_,_,_,_)},image(O,R,I),I!="",I!=" ",label(O,_,_),not _clinguin_context(label_mode,off).
elem(node_badge(N,R,O),label,badge_box(N,R,O)) :- elem(placement(N,R,O),container,_),not placeholder(O),visual(O,R,Z,_,_,_,_),Z=#max{Z2:elem(placement(N,R2,O2),container,_),visual(O2,R2,Z2,_,_,_,_)},image(O,R,I),I!="",I!=" ",not label(O,_,_),_clinguin_context(label_mode,all).
attr(node_badge(N,R,O),label,@concat("",L)) :- elem(node_badge(N,R,O),label,_),label(O,L,_).
attr(node_badge(N,R,O),label,@concat("",O)) :- elem(node_badge(N,R,O),label,_),not label(O,_,_).
elem(no_grid,label,main_panel) :- not node((_,_)).
attr(no_grid,label,"No grid is loaded. Open a scenario containing grid nodes to begin.") :- not node((_,_)).
attr(no_grid,class,("p-5";"text-center";"text-muted")) :- not node((_,_)).
attr(no_grid,order,2) :- not node((_,_)).
elem(badge_box(N,R,O),container,placement(N,R,O)) :- elem(node_badge(N,R,O),label,_).
attr(role_item(R),order,N) :- elem(role_item(R),dropdown_menu_item,_),N=#count{Other:elem(role_item(Other),dropdown_menu_item,_),Other<R}.
elem(role_notice_box,container,placement_panel) :- elem(role_notice,label,_).
attr(role_notice,order,1) :- elem(role_notice,label,_).
when(node_box(Row,Col),click,call,add_atom(position(N,R,O))) :- _clinguin_context(selected_object,O),object(O,_),_clinguin_context(placement_role,R),role(O,R,S,_,Max),not issue(O,error,_,_),not issue(O,warning,property(_),_),node((Row,Col)),N=(Row,Col),A=#count{Needed:support(O,R,Needed)},A=#count{Needed:support(O,R,Needed),elem(placement(N,Rd,Dep),container,_),role(Dep,Rd,Needed,_,_),not placeholder(Dep)},0=#count{OldRole,OldO:elem(placement(N,OldRole,OldO),container,_),role(OldO,OldRole,S,_,_),not placeholder(OldO)},not elem(placement(N,R,O),container,_),Max<0,not _clinguin_unsat.
when(node_box(Row,Col),click,call,add_atom(position(N,R,O))) :- _clinguin_context(selected_object,O),object(O,_),_clinguin_context(placement_role,R),role(O,R,S,_,Max),not issue(O,error,_,_),not issue(O,warning,property(_),_),node((Row,Col)),N=(Row,Col),A=#count{Needed:support(O,R,Needed)},A=#count{Needed:support(O,R,Needed),elem(placement(N,Rd,Dep),container,_),role(Dep,Rd,Needed,_,_),not placeholder(Dep)},0=#count{OldRole,OldO:elem(placement(N,OldRole,OldO),container,_),role(OldO,OldRole,S,_,_),not placeholder(OldO)},not elem(placement(N,R,O),container,_),Max>=0,Max>#count{Other:position(Other,R,O)},not _clinguin_unsat.
when(node_box(Row,Col),click,call,add_atom(position(N,R,O))) :- _clinguin_context(selected_object,O),object(O,_),_clinguin_context(placement_role,R),role(O,R,S,_,Max),not issue(O,error,_,_),not issue(O,warning,property(_),_),node((Row,Col)),N=(Row,Col),A=#count{Needed:support(O,R,Needed)},A=#count{Needed:support(O,R,Needed),elem(placement(N,Rd,Dep),container,_),role(Dep,Rd,Needed,_,_),not placeholder(Dep)},elem(placement(N,OldRole,OldO),container,_),role(OldO,OldRole,S,_,_),not _clinguin_atom(position(N,OldRole,OldO)),not placeholder(OldO),replaceable(OldO),(OldRole,OldO)!=(R,O),Max<0,not _clinguin_unsat.
when(node_box(Row,Col),click,call,add_atom(position(N,R,O))) :- _clinguin_context(selected_object,O),object(O,_),_clinguin_context(placement_role,R),role(O,R,S,_,Max),not issue(O,error,_,_),not issue(O,warning,property(_),_),node((Row,Col)),N=(Row,Col),A=#count{Needed:support(O,R,Needed)},A=#count{Needed:support(O,R,Needed),elem(placement(N,Rd,Dep),container,_),role(Dep,Rd,Needed,_,_),not placeholder(Dep)},elem(placement(N,OldRole,OldO),container,_),role(OldO,OldRole,S,_,_),not _clinguin_atom(position(N,OldRole,OldO)),not placeholder(OldO),replaceable(OldO),(OldRole,OldO)!=(R,O),Max>=0,Max>#count{Other:position(Other,R,O)},not _clinguin_unsat.
when(node_box(Row,Col),click,context,(selected_object,O)) :- when(node_box(Row,Col),click,call,add_atom(position(N,R,O))).
when(node_box(Row,Col),click,context,(placement_role,R)) :- when(node_box(Row,Col),click,call,add_atom(position(N,R,O))).
when(node_box(Row,Col),click,context,(inspector_open,false)) :- when(node_box(Row,Col),click,call,add_atom(position(N,R,O))).
when(node_box(Row,Col),click,context,(dialog,none)) :- when(node_box(Row,Col),click,call,add_atom(position(N,R,O))).
when(node_box(Row,Col),click,update,(local_feedback,visibility,hidden)) :- when(node_box(Row,Col),click,call,add_atom(position(N,R,O))).
when(node_box(Row,Col),click,update,(operation_status,label,"Placing…")) :- when(node_box(Row,Col),click,call,add_atom(position(N,R,O))).
elem(placement_preview(Row,Col),container,node_box(Row,Col)) :- _clinguin_context(selected_object,O),object(O,_),_clinguin_context(placement_role,R),role(O,R,S,_,Max),not issue(O,error,_,_),not issue(O,warning,property(_),_),node((Row,Col)).
attr(placement_preview(Row,Col),visibility,hidden) :- elem(placement_preview(Row,Col),container,_).
elem(placement_preview_image(Row,Col),canvas,placement_preview(Row,Col)) :- _clinguin_context(selected_object,O),object(O,_),_clinguin_context(placement_role,R),role(O,R,S,_,Max),not issue(O,error,_,_),not issue(O,warning,property(_),_),node((Row,Col)),image(O,R,I),I!="",I!=" ",I=#min{Path:image(O,R,Path),Path!="",Path!=" "}.
attr(placement_preview_image(Row,Col),image,I) :- _clinguin_context(selected_object,O),object(O,_),_clinguin_context(placement_role,R),role(O,R,S,_,Max),not issue(O,error,_,_),not issue(O,warning,property(_),_),node((Row,Col)),image(O,R,I),I!="",I!=" ",I=#min{Path:image(O,R,Path),Path!="",Path!=" "}.
elem(placement_preview_id_box(Row,Col),container,placement_preview(Row,Col)) :- _clinguin_context(selected_object,O),object(O,_),_clinguin_context(placement_role,R),role(O,R,S,_,Max),not issue(O,error,_,_),not issue(O,warning,property(_),_),node((Row,Col)),label(O,L,_),0<#count{I:image(O,R,I),I!="",I!=" "},not _clinguin_context(label_mode,off).
elem(placement_preview_id(Row,Col),label,placement_preview_id_box(Row,Col)) :- _clinguin_context(selected_object,O),object(O,_),_clinguin_context(placement_role,R),role(O,R,S,_,Max),not issue(O,error,_,_),not issue(O,warning,property(_),_),node((Row,Col)),label(O,L,_),0<#count{I:image(O,R,I),I!="",I!=" "},not _clinguin_context(label_mode,off).
attr(placement_preview_id(Row,Col),label,@concat("",L)) :- _clinguin_context(selected_object,O),object(O,_),_clinguin_context(placement_role,R),role(O,R,S,_,Max),not issue(O,error,_,_),not issue(O,warning,property(_),_),node((Row,Col)),label(O,L,_),0<#count{I:image(O,R,I),I!="",I!=" "},not _clinguin_context(label_mode,off).
elem(placement_preview_text(Row,Col),label,placement_preview(Row,Col)) :- _clinguin_context(selected_object,O),object(O,_),_clinguin_context(placement_role,R),role(O,R,S,_,Max),not issue(O,error,_,_),not issue(O,warning,property(_),_),node((Row,Col)),0=#count{I:image(O,R,I),I!="",I!=" "}.
attr(placement_preview_text(Row,Col),label,@concat("",O)) :- not label(O,_,_), _clinguin_context(selected_object,O),object(O,_),_clinguin_context(placement_role,R),role(O,R,S,_,Max),not issue(O,error,_,_),not issue(O,warning,property(_),_),node((Row,Col)),0=#count{I:image(O,R,I),I!="",I!=" "}.
when(node_box(Row,Col),click,update,(placement_preview(Row,Col),visibility,shown)) :- when(node_box(Row,Col),click,call,add_atom(position(N,R,O))).
when(node_box(Row,Col),right_click,context,(delete_position,position(N,R,O))) :- node((Row,Col)),N=(Row,Col),elem(placement(N,R,O),container,_),_clinguin_atom(position(N,R,O)),attr(placement(N,R,O),order,K),(K,R,O)=#max{(K2,R2,O2):elem(placement(N,R2,O2),container,_),attr(placement(N,R2,O2),order,K2),_clinguin_atom(position(N,R2,O2))}.
when(node_box(Row,Col),click,context,(delete_position,position(N,R,O))) :- node((Row,Col)),N=(Row,Col),elem(placement(N,R,O),container,_),_clinguin_atom(position(N,R,O)),attr(placement(N,R,O),order,K),(K,R,O)=#max{(K2,R2,O2):elem(placement(N,R2,O2),container,_),attr(placement(N,R2,O2),order,K2),_clinguin_atom(position(N,R2,O2))},not _clinguin_context(selected_object,Chosen):object(Chosen,_).
when(node_box(Row,Col),click,context,(delete_position,position(N,R,O))) :- node((Row,Col)),N=(Row,Col),_clinguin_context(selected_object,O),_clinguin_context(placement_role,R),elem(placement(N,R,O),container,_),_clinguin_atom(position(N,R,O)),not when(node_box(Row,Col),click,call,add_atom(_)).
when(node_box(Row,Col),click,update,(local_feedback,visibility,shown)) :- _clinguin_context(selected_object,O),object(O,_),_clinguin_context(placement_role,R),role(O,R,S,_,Max),not issue(O,error,_,_),not issue(O,warning,property(_),_),node((Row,Col)),N=(Row,Col),not when(node_box(Row,Col),click,context,(delete_position,_)),support(O,R,Needed),0=#count{Dep,Rd:elem(placement(N,Rd,Dep),container,_),role(Dep,Rd,Needed,_,_),not placeholder(Dep)},not _clinguin_unsat.
when(node_box(Row,Col),click,update,(local_feedback,title,"Placement blocked")) :- _clinguin_context(selected_object,O),object(O,_),_clinguin_context(placement_role,R),role(O,R,S,_,Max),not issue(O,error,_,_),not issue(O,warning,property(_),_),node((Row,Col)),N=(Row,Col),not when(node_box(Row,Col),click,context,(delete_position,_)),support(O,R,Needed),0=#count{Dep,Rd:elem(placement(N,Rd,Dep),container,_),role(Dep,Rd,Needed,_,_),not placeholder(Dep)},not _clinguin_unsat.
when(node_box(Row,Col),click,update,(local_feedback,message,"A required supporting object is missing at this node.")) :- _clinguin_context(selected_object,O),object(O,_),_clinguin_context(placement_role,R),role(O,R,S,_,Max),not issue(O,error,_,_),not issue(O,warning,property(_),_),node((Row,Col)),N=(Row,Col),not when(node_box(Row,Col),click,context,(delete_position,_)),support(O,R,Needed),0=#count{Dep,Rd:elem(placement(N,Rd,Dep),container,_),role(Dep,Rd,Needed,_,_),not placeholder(Dep)},not _clinguin_unsat.
when(node_box(Row,Col),click,update,(local_feedback,visibility,shown)) :- _clinguin_context(selected_object,O),object(O,_),_clinguin_context(placement_role,R),role(O,R,S,_,Max),not issue(O,error,_,_),not issue(O,warning,property(_),_),node((Row,Col)),N=(Row,Col),A=#count{Needed:support(O,R,Needed)},A=#count{Needed:support(O,R,Needed),elem(placement(N,Rd,Dep),container,_),role(Dep,Rd,Needed,_,_),not placeholder(Dep)},not when(node_box(Row,Col),click,context,(delete_position,_)),Max>=0,Max<=#count{Other:position(Other,R,O)},not elem(placement(N,R,O),container,_),not _clinguin_unsat.
when(node_box(Row,Col),click,update,(local_feedback,title,"Position limit reached")) :- _clinguin_context(selected_object,O),object(O,_),_clinguin_context(placement_role,R),role(O,R,S,_,Max),not issue(O,error,_,_),not issue(O,warning,property(_),_),node((Row,Col)),N=(Row,Col),A=#count{Needed:support(O,R,Needed)},A=#count{Needed:support(O,R,Needed),elem(placement(N,Rd,Dep),container,_),role(Dep,Rd,Needed,_,_),not placeholder(Dep)},not when(node_box(Row,Col),click,context,(delete_position,_)),Max>=0,Max<=#count{Other:position(Other,R,O)},not elem(placement(N,R,O),container,_),not _clinguin_unsat.
when(node_box(Row,Col),click,update,(local_feedback,message,"This role already has its maximum positions. Choose another role or move an existing position.")) :- _clinguin_context(selected_object,O),object(O,_),_clinguin_context(placement_role,R),role(O,R,S,_,Max),not issue(O,error,_,_),not issue(O,warning,property(_),_),node((Row,Col)),N=(Row,Col),A=#count{Needed:support(O,R,Needed)},A=#count{Needed:support(O,R,Needed),elem(placement(N,Rd,Dep),container,_),role(Dep,Rd,Needed,_,_),not placeholder(Dep)},not when(node_box(Row,Col),click,context,(delete_position,_)),Max>=0,Max<=#count{Other:position(Other,R,O)},not elem(placement(N,R,O),container,_),not _clinguin_unsat.
when(node_box(Row,Col),click,update,(local_feedback,visibility,shown)) :- _clinguin_context(selected_object,O),object(O,_),_clinguin_context(placement_role,R),role(O,R,S,_,Max),not issue(O,error,_,_),not issue(O,warning,property(_),_),node((Row,Col)),N=(Row,Col),A=#count{Needed:support(O,R,Needed)},A=#count{Needed:support(O,R,Needed),elem(placement(N,Rd,Dep),container,_),role(Dep,Rd,Needed,_,_),not placeholder(Dep)},not when(node_box(Row,Col),click,context,(delete_position,_)),elem(placement(N,OldRole,OldO),container,_),role(OldO,OldRole,S,_,_),not placeholder(OldO),(OldRole,OldO)!=(R,O),not when(node_box(Row,Col),click,call,add_atom(_)),Max<0,not _clinguin_unsat.
when(node_box(Row,Col),click,update,(local_feedback,visibility,shown)) :- _clinguin_context(selected_object,O),object(O,_),_clinguin_context(placement_role,R),role(O,R,S,_,Max),not issue(O,error,_,_),not issue(O,warning,property(_),_),node((Row,Col)),N=(Row,Col),A=#count{Needed:support(O,R,Needed)},A=#count{Needed:support(O,R,Needed),elem(placement(N,Rd,Dep),container,_),role(Dep,Rd,Needed,_,_),not placeholder(Dep)},not when(node_box(Row,Col),click,context,(delete_position,_)),elem(placement(N,OldRole,OldO),container,_),role(OldO,OldRole,S,_,_),not placeholder(OldO),(OldRole,OldO)!=(R,O),not when(node_box(Row,Col),click,call,add_atom(_)),Max>=0,Max>#count{Other:position(Other,R,O)},not _clinguin_unsat.
when(node_box(Row,Col),click,update,(local_feedback,title,"Slot occupied")) :- _clinguin_context(selected_object,O),object(O,_),_clinguin_context(placement_role,R),role(O,R,S,_,Max),not issue(O,error,_,_),not issue(O,warning,property(_),_),node((Row,Col)),N=(Row,Col),A=#count{Needed:support(O,R,Needed)},A=#count{Needed:support(O,R,Needed),elem(placement(N,Rd,Dep),container,_),role(Dep,Rd,Needed,_,_),not placeholder(Dep)},not when(node_box(Row,Col),click,context,(delete_position,_)),elem(placement(N,OldRole,OldO),container,_),role(OldO,OldRole,S,_,_),not placeholder(OldO),(OldRole,OldO)!=(R,O),not when(node_box(Row,Col),click,call,add_atom(_)),Max<0,not _clinguin_unsat.
when(node_box(Row,Col),click,update,(local_feedback,title,"Slot occupied")) :- _clinguin_context(selected_object,O),object(O,_),_clinguin_context(placement_role,R),role(O,R,S,_,Max),not issue(O,error,_,_),not issue(O,warning,property(_),_),node((Row,Col)),N=(Row,Col),A=#count{Needed:support(O,R,Needed)},A=#count{Needed:support(O,R,Needed),elem(placement(N,Rd,Dep),container,_),role(Dep,Rd,Needed,_,_),not placeholder(Dep)},not when(node_box(Row,Col),click,context,(delete_position,_)),elem(placement(N,OldRole,OldO),container,_),role(OldO,OldRole,S,_,_),not placeholder(OldO),(OldRole,OldO)!=(R,O),not when(node_box(Row,Col),click,call,add_atom(_)),Max>=0,Max>#count{Other:position(Other,R,O)},not _clinguin_unsat.
when(node_box(Row,Col),click,update,(local_feedback,message,"Right-click the existing session placement to remove it, then place your selected object.")) :- _clinguin_context(selected_object,O),object(O,_),_clinguin_context(placement_role,R),role(O,R,S,_,Max),not issue(O,error,_,_),not issue(O,warning,property(_),_),node((Row,Col)),N=(Row,Col),A=#count{Needed:support(O,R,Needed)},A=#count{Needed:support(O,R,Needed),elem(placement(N,Rd,Dep),container,_),role(Dep,Rd,Needed,_,_),not placeholder(Dep)},not when(node_box(Row,Col),click,context,(delete_position,_)),elem(placement(N,OldRole,OldO),container,_),role(OldO,OldRole,S,_,_),not placeholder(OldO),(OldRole,OldO)!=(R,O),not when(node_box(Row,Col),click,call,add_atom(_)),Max<0,not _clinguin_unsat.
when(node_box(Row,Col),click,update,(local_feedback,message,"Right-click the existing session placement to remove it, then place your selected object.")) :- _clinguin_context(selected_object,O),object(O,_),_clinguin_context(placement_role,R),role(O,R,S,_,Max),not issue(O,error,_,_),not issue(O,warning,property(_),_),node((Row,Col)),N=(Row,Col),A=#count{Needed:support(O,R,Needed)},A=#count{Needed:support(O,R,Needed),elem(placement(N,Rd,Dep),container,_),role(Dep,Rd,Needed,_,_),not placeholder(Dep)},not when(node_box(Row,Col),click,context,(delete_position,_)),elem(placement(N,OldRole,OldO),container,_),role(OldO,OldRole,S,_,_),not placeholder(OldO),(OldRole,OldO)!=(R,O),not when(node_box(Row,Col),click,call,add_atom(_)),Max>=0,Max>#count{Other:position(Other,R,O)},not _clinguin_unsat.
when(node_box(Row,Col),click,update,(local_feedback,visibility,shown)) :- _clinguin_context(selected_object,O),object(O,_),node((Row,Col)),0=#count{R:_clinguin_context(placement_role,R),role(O,R,_,_,_)},not when(node_box(Row,Col),click,context,(delete_position,_)),not _clinguin_unsat.
when(node_box(Row,Col),click,update,(local_feedback,title,"Choose a role")) :- _clinguin_context(selected_object,O),object(O,_),node((Row,Col)),0=#count{R:_clinguin_context(placement_role,R),role(O,R,_,_,_)},not when(node_box(Row,Col),click,context,(delete_position,_)),not _clinguin_unsat.
when(node_box(Row,Col),click,update,(local_feedback,message,"Select a placement role first.")) :- _clinguin_context(selected_object,O),object(O,_),node((Row,Col)),0=#count{R:_clinguin_context(placement_role,R),role(O,R,_,_,_)},not when(node_box(Row,Col),click,context,(delete_position,_)),not _clinguin_unsat.
when(node_box(Row,Col),click,update,(local_feedback,visibility,shown)) :- _clinguin_context(selected_object,O),object(O,_),node((Row,Col)),issue(O,error,object_term,_),not when(node_box(Row,Col),click,context,(delete_position,_)),not _clinguin_unsat.
when(node_box(Row,Col),click,update,(local_feedback,title,"Invalid object")) :- _clinguin_context(selected_object,O),object(O,_),node((Row,Col)),issue(O,error,object_term,_),not when(node_box(Row,Col),click,context,(delete_position,_)),not _clinguin_unsat.
when(node_box(Row,Col),click,update,(local_feedback,message,"Correct the object identifier or type before placing it.")) :- _clinguin_context(selected_object,O),object(O,_),node((Row,Col)),issue(O,error,object_term,_),not when(node_box(Row,Col),click,context,(delete_position,_)),not _clinguin_unsat.
when(node_box(Row,Col),click,update,(local_feedback,visibility,shown)) :- _clinguin_context(selected_object,O),object(O,_),node((Row,Col)),issue(O,error,type_term,_),not when(node_box(Row,Col),click,context,(delete_position,_)),not _clinguin_unsat.
when(node_box(Row,Col),click,update,(local_feedback,title,"Invalid object")) :- _clinguin_context(selected_object,O),object(O,_),node((Row,Col)),issue(O,error,type_term,_),not when(node_box(Row,Col),click,context,(delete_position,_)),not _clinguin_unsat.
when(node_box(Row,Col),click,update,(local_feedback,message,"Correct the object identifier or type before placing it.")) :- _clinguin_context(selected_object,O),object(O,_),node((Row,Col)),issue(O,error,type_term,_),not when(node_box(Row,Col),click,context,(delete_position,_)),not _clinguin_unsat.
when(node_box(Row,Col),click,update,(local_feedback,visibility,shown)) :- node((Row,Col)),_clinguin_unsat,not when(node_box(Row,Col),click,context,(delete_position,_)).
when(node_box(Row,Col),click,update,(local_feedback,title,"Resolve the constraint error")) :- node((Row,Col)),_clinguin_unsat,not when(node_box(Row,Col),click,context,(delete_position,_)).
when(node_box(Row,Col),click,update,(local_feedback,message,"Use Undo last change before adding another placement.")) :- node((Row,Col)),_clinguin_unsat,not when(node_box(Row,Col),click,context,(delete_position,_)).
attr(placement_preview_text(Row,Col),label,@concat("",L)) :- elem(placement_preview_text(Row,Col),label,_),_clinguin_context(selected_object,O),label(O,L,_).

attr(workspace,class,("d-flex";"flex-row";"flex-wrap";"align-items-start";"p-2";"bg-light")).
attr(main_panel,class,("col-12";"col-lg-9";"pe-lg-3";"d-flex";"flex-column";"gap-2")).
attr(sidebar_panel,class,("col-12";"col-lg-3";"d-flex";"flex-column";"bg-white";"border";"rounded-3";"shadow-sm";"overflow-hidden")).
attr(grid_viewport,class,("w-100";"overflow-auto";"p-2";"bg-light")) :- node((_,_)).
attr(grid_viewport,height,600) :- node((_,_)).
attr(grid_viewport,child_layout,flex) :- node((_,_)).
attr(grid_surface,class,("position-relative";"flex-shrink-0";"p-0";"m-0";"bg-white")) :- node((_,_)).
attr(grid_surface,order,1) :- node((_,_)).
attr(grid_surface,width,(C-C0+1)*S) :- ui_cell_size(S),C=#max{X:node((_,X))},C0=#min{X:node((_,X))}.
attr(grid_surface,height,(R-R0+1)*S) :- ui_cell_size(S),R=#max{X:node((X,_))},R0=#min{X:node((X,_))}.
attr(node_box(Row,Col),pos_x,(Col-C0)*S) :- node((Row,Col)),ui_cell_size(S),C0=#min{X:node((_,X))}.
attr(node_box(Row,Col),pos_y,(Row-R0)*S) :- node((Row,Col)),ui_cell_size(S),R0=#min{X:node((X,_))}.
attr(node_box(Row,Col),child_layout,grid) :- node((Row,Col)).
attr(node_box(Row,Col),order,K) :- node((Row,Col)),K=#count{R,C:node((R,C)),(R,C)<(Row,Col)}.
attr(node_box(Row,Col),class,("position-absolute";"p-0";"m-0";"border-0";"overflow-hidden";"user-select-none")) :- node((Row,Col)).
attr(node_box(Row,Col),background_color,"white") :- node((Row,Col)).
attr(node_box(Row,Col),on_hover,true) :- node((Row,Col)),when(node_box(Row,Col),click,call,add_atom(_)).
attr(node_box(Row,Col),on_hover_background_color,"#e9ecef") :- node((Row,Col)),when(node_box(Row,Col),click,call,add_atom(_)).
attr(placement(N,R,O),child_layout,grid) :- elem(placement(N,R,O),container,_).
attr(placement(N,R,O),class,("p-0";"m-0";"pe-none")) :- elem(placement(N,R,O),container,_).
attr(placement(N,R,O),order,K) :- elem(placement(N,R,O),container,_),visual(O,R,Z,_,_,_,_),K=#count{R2,O2,Z2:elem(placement(N,R2,O2),container,_),visual(O2,R2,Z2,_,_,_,_),(Z2,R2,O2)<(Z,R,O);R2,O2,0:elem(placement(N,R2,O2),container,_),not visual(O2,R2,_,_,_,_,_),(0,R2,O2)<(Z,R,O)}.
attr(placement(N,R,O),order,K) :- elem(placement(N,R,O),container,_),not visual(O,R,_,_,_,_,_),K=#count{R2,O2,Z2:elem(placement(N,R2,O2),container,_),visual(O2,R2,Z2,_,_,_,_),(Z2,R2,O2)<(0,R,O);R2,O2,0:elem(placement(N,R2,O2),container,_),not visual(O2,R2,_,_,_,_,_),(0,R2,O2)<(0,R,O)}.
attr(node_image(N,R,O,I),class,("d-block";"p-0";"m-0";"pe-none")) :- elem(node_image(N,R,O,I),canvas,_).
attr(node_image(N,R,O,I),order,K) :- elem(node_image(N,R,O,I),canvas,_),K=#count{I2:elem(node_image(N,R,O,I2),canvas,_),I2<I}.
attr(node_text(N,R,O),order,0) :- elem(node_text(N,R,O),label,_).
attr(node_text(N,R,O),class,("d-flex";"align-items-center";"justify-content-center";"text-center";"small";"fw-bold";"font-monospace";"text-primary";"m-0";"pe-none";"overflow-hidden")) :- elem(node_text(N,R,O),label,_).
attr(badge_box(N,R,O),order,K+1) :- elem(badge_box(N,R,O),container,_),K=#count{I:elem(node_image(N,R,O,I),canvas,_)}.
attr(badge_box(N,R,O),class,("p-0";"m-0";"pe-none";"d-flex";"align-items-center";"justify-content-center")) :- elem(badge_box(N,R,O),container,_).
attr(badge_box(N,R,O),width,14) :- elem(badge_box(N,R,O),container,_).
attr(badge_box(N,R,O),height,14) :- elem(badge_box(N,R,O),container,_).
attr(node_badge(N,R,O),order,1) :- elem(node_badge(N,R,O),label,_).
attr(node_badge(N,R,O),class,("small";"fw-bold";"lh-1";"text-dark";"text-center";"m-0";"pe-none")) :- elem(node_badge(N,R,O),label,_).
attr(placement_preview(Row,Col),child_layout,grid) :- elem(placement_preview(Row,Col),container,_).
attr(placement_preview(Row,Col),class,("p-0";"m-0";"pe-none")) :- elem(placement_preview(Row,Col),container,_).
attr(placement_preview(Row,Col),order,K+1) :- elem(placement_preview(Row,Col),container,_),K=#count{R,O:elem(placement((Row,Col),R,O),container,_)}.
attr(placement_preview_image(Row,Col),order,0) :- elem(placement_preview_image(Row,Col),canvas,_).
attr(placement_preview_image(Row,Col),class,("d-block";"p-0";"m-0";"pe-none")) :- elem(placement_preview_image(Row,Col),canvas,_).
attr(placement_preview_text(Row,Col),order,0) :- elem(placement_preview_text(Row,Col),label,_).
attr(placement_preview_text(Row,Col),class,("d-flex";"align-items-center";"justify-content-center";"small";"fw-bold";"text-primary";"text-center";"m-0";"pe-none";"overflow-hidden")) :- elem(placement_preview_text(Row,Col),label,_).
attr(placement_preview_id_box(Row,Col),order,1) :- elem(placement_preview_id_box(Row,Col),container,_).
attr(placement_preview_id_box(Row,Col),width,14) :- elem(placement_preview_id_box(Row,Col),container,_).
attr(placement_preview_id_box(Row,Col),height,14) :- elem(placement_preview_id_box(Row,Col),container,_).
attr(placement_preview_id_box(Row,Col),class,("p-0";"m-0";"pe-none";"d-flex";"align-items-center";"justify-content-center")) :- elem(placement_preview_id_box(Row,Col),container,_).
attr(placement_preview_id(Row,Col),order,1) :- elem(placement_preview_id(Row,Col),label,_).
attr(placement_preview_id(Row,Col),class,("small";"fw-bold";"lh-1";"text-dark";"text-center";"m-0";"pe-none")) :- elem(placement_preview_id(Row,Col),label,_).
elem(node_frame(Row,Col),container,node_box(Row,Col)) :- node((Row,Col)).
attr(node_frame(Row,Col),class,("border";"border-secondary";"p-0";"m-0";"pe-none")) :- node((Row,Col)).
attr(node_frame(Row,Col),order,K+2) :- node((Row,Col)),K=#count{R,O:elem(placement((Row,Col),R,O),container,_)}.
attr(selection_identity,class,("d-flex";"flex-column";"gap-1";"flex-grow-1")) :- elem(selection_identity,container,_).
attr(selection_name,class,"text-break") :- elem(selection_name,label,_).
attr(role_control,class,("d-flex";"flex-column";"gap-1")) :- elem(role_control,container,_).
attr(role_notice_box,class,("border";"border-warning";"rounded";"p-2";"bg-light")) :- elem(role_notice_box,container,_).
attr(role_notice,class,("small";"text-dark")) :- elem(role_notice,label,_).
attr(display_controls,class,("d-flex";"flex-row";"flex-wrap";"align-items-center";"gap-3";"px-3";"py-2";"border-top";"border-bottom";"bg-light")) :- node((_,_)).
attr(E,class,("d-flex";"flex-row";"flex-wrap";"align-items-center";"gap-1")) :- elem(E,container,display_controls).
attr(E,class,("small";"fw-bold";"text-secondary";"me-1")) :- elem(E,label,P),P=(scale_controls;label_controls).
attr(node_box(Row,Col),width,S) :- elem(node_box(Row,Col),container,_),ui_cell_size(S).
attr(node_box(Row,Col),height,S) :- elem(node_box(Row,Col),container,_),ui_cell_size(S).
attr(placement(N,R,O),width,S) :- elem(placement(N,R,O),container,_),ui_cell_size(S).
attr(placement(N,R,O),height,S) :- elem(placement(N,R,O),container,_),ui_cell_size(S).
attr(node_text(N,R,O),width,S) :- elem(node_text(N,R,O),label,_),ui_cell_size(S).
attr(node_text(N,R,O),height,S) :- elem(node_text(N,R,O),label,_),ui_cell_size(S).
attr(placement_preview(Row,Col),width,S) :- elem(placement_preview(Row,Col),container,_),ui_cell_size(S).
attr(placement_preview(Row,Col),height,S) :- elem(placement_preview(Row,Col),container,_),ui_cell_size(S).
attr(placement_preview_text(Row,Col),width,S) :- elem(placement_preview_text(Row,Col),label,_),ui_cell_size(S).
attr(placement_preview_text(Row,Col),height,S) :- elem(placement_preview_text(Row,Col),label,_),ui_cell_size(S).
attr(node_frame(Row,Col),width,S) :- elem(node_frame(Row,Col),container,_),ui_cell_size(S).
attr(node_frame(Row,Col),height,S) :- elem(node_frame(Row,Col),container,_),ui_cell_size(S).
attr(scale_compact,background_color,"#e9ecef") :- node((_,_)),not _clinguin_context(grid_scale,normal),not _clinguin_context(grid_scale,large).
attr(scale_normal,background_color,"#e9ecef") :- node((_,_)),_clinguin_context(grid_scale,normal).
attr(scale_large,background_color,"#e9ecef") :- node((_,_)),_clinguin_context(grid_scale,large),not _clinguin_context(grid_scale,normal).
when(labels_explicit,click,call,()) :- node((_,_)).
when(labels_all,click,call,()) :- node((_,_)).
when(labels_off,click,call,()) :- node((_,_)).
attr(node_image(N,R,O,I),class,("w-100";"h-100")) :- elem(node_image(N,R,O,I),canvas,_).
attr(placement_preview_image(Row,Col),class,("w-100";"h-100")) :- elem(placement_preview_image(Row,Col),canvas,_).
% Canvas dimensions must size the image itself; host utility classes do not.
attr(node_image(N,R,O,I),width,S) :- elem(node_image(N,R,O,I),canvas,_),ui_cell_size(S).
attr(node_image(N,R,O,I),height,S) :- elem(node_image(N,R,O,I),canvas,_),ui_cell_size(S).
attr(placement_preview_image(Row,Col),width,S) :- elem(placement_preview_image(Row,Col),canvas,_),ui_cell_size(S).
attr(placement_preview_image(Row,Col),height,S) :- elem(placement_preview_image(Row,Col),canvas,_),ui_cell_size(S).
% Angular applies absolute coordinates and canvas sizes during construction.
% Redraw once after a scale change so every cell and image uses the same size.
when(scale_compact,click,call,()) :- node((_,_)).
when(scale_normal,click,call,()) :- node((_,_)).
when(scale_large,click,call,()) :- node((_,_)).
% Shared grid cells preserve visual order for overlapping layers in Angular.
attr(E,grid_row,0) :- elem(E,_,node_box(Row,Col)).
attr(E,grid_column,0) :- elem(E,_,node_box(Row,Col)).
attr(E,grid_row,0) :- elem(E,_,placement(N,R,O)).
attr(E,grid_column,0) :- elem(E,_,placement(N,R,O)).
attr(E,grid_row,0) :- elem(E,_,placement_preview(Row,Col)).
attr(E,grid_column,0) :- elem(E,_,placement_preview(Row,Col)).
attr(badge_box(N,R,O),class,("align-self-center";"mx-auto")) :- elem(badge_box(N,R,O),container,_),label(O,_,center).
attr(badge_box(N,R,O),class,("align-self-start";"ms-auto")) :- elem(badge_box(N,R,O),container,_),not label(O,_,center).
attr(placement_preview_id_box(Row,Col),class,("align-self-center";"mx-auto")) :- elem(placement_preview_id_box(Row,Col),container,_),_clinguin_context(selected_object,O),label(O,_,center).
attr(placement_preview_id_box(Row,Col),class,("align-self-start";"ms-auto")) :- elem(placement_preview_id_box(Row,Col),container,_),_clinguin_context(selected_object,O),not label(O,_,center).
