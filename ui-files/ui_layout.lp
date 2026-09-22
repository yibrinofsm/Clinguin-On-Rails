% ============================================================
% WORKSPACE
% ============================================================
elem(workspace,container,w).
attr(workspace,child_layout,flex).
attr(workspace,flex_direction,row).
attr(workspace,class,("d-flex";"flex-row";"flex-wrap";"align-items-start";"p-2";"bg-light")).

% ============================================================
% MAIN PANEL
% ============================================================

elem(main_panel,container,workspace).
attr(main_panel,order,1).
attr(main_panel,class,("col-12";"col-lg-9";"pe-lg-3";"d-flex";"gap-2")).

% ============================================================
% SIDEBAR PANEL
% ============================================================

elem(sidebar_panel,container,workspace).
attr(sidebar_panel,order,2).
attr(sidebar_panel,class,("col-12";"col-lg-3";"d-flex";"flex-column";"bg-white";"border";"rounded-3";"shadow-sm";"overflow-hidden")).

% ============================================================
% PLACEMENT PANEL
% ============================================================

elem(placement_panel,container,main_panel).
attr(placement_panel,order,1).
attr(placement_panel,class,("d-flex";"flex-column";"gap-1";"px-2";"py-1";"bg-white";"border";"rounded-3";"shadow-sm")).

% ============================================================
% PLACEMENT HEADER
% ============================================================

elem(placement_header,container,placement_panel).
attr(placement_header,order,1).
attr(placement_header,flex_direction,row).
attr(placement_header,class,("d-flex";"flex-row";"align-items-center";"justify-content-between";"gap-2";"py-0")).

elem(placement_title,label,placement_header).
attr(placement_title,order,1).
attr(placement_title,label,"Placement").
attr(placement_title,class,("fw-semibold";"text-dark";"small";"m-0")).

elem(placement_step,label,placement_header).
attr(placement_step,order,2).
attr(placement_step,label,"1 Select  ·  2 Role  ·  3 Place").
attr(placement_step,class,("small";"text-secondary";"m-0")).

% ============================================================
% EMPTY STATE
% ============================================================

elem(selection_empty,label,placement_panel) :- object(O,T), not _clinguin_context(selected_object,O).
attr(selection_empty,order,2).
attr(selection_empty,label,"Select an object to start.").
attr(selection_empty,class,("small";"text-secondary";"py-1";"m-0")) :- elem(selection_empty,label,_).

% ============================================================
% SELECTION TOOLBAR
% ============================================================

elem(selection,container,placement_panel) :- object(O,T), _clinguin_context(selected_object,O).
attr(selection,order,2) :- object(O,T), _clinguin_context(selected_object,O).
attr(selection,flex_direction,row) :- object(O,T), _clinguin_context(selected_object,O).
attr(selection,class,("d-flex";"flex-row";"align-items-center";"gap-2";"w-100";"py-1")) :- object(O,T), _clinguin_context(selected_object,O).

% ============================================================
% SELECTED OBJECT
% ============================================================

elem(selection_identity,container,selection) :- object(O,T), _clinguin_context(selected_object,O).
attr(selection_identity,order,1) :- object(O,T), _clinguin_context(selected_object,O).
attr(selection_identity,class,("d-flex";"align-items-center";"gap-1";"flex-grow-1";"min-w-0")) :- elem(selection_identity,container,_).

elem(selection_name,label,selection_identity) :- object(O,T), _clinguin_context(selected_object,O).
attr(selection_name,order,1) :- object(O,T), _clinguin_context(selected_object,O).
attr(selection_name,label,@concat("",O)) :- object(O,T), _clinguin_context(selected_object,O).
attr(selection_name,class,("fw-semibold";"text-primary";"text-truncate";"small";"m-0")) :- object(O,T), _clinguin_context(selected_object,O).

% ============================================================
% ROLE SELECTOR
% ============================================================

elem(role_control,container,selection) :- object(O,T), _clinguin_context(selected_object,O).
attr(role_control,order,2) :- object(O,T), _clinguin_context(selected_object,O).
attr(role_control,class,("d-flex";"align-items-center";"gap-1";"flex-shrink-0")) :- elem(role_control,container,_).

elem(role_menu,dropdown_menu,role_control) :- object(O,T), _clinguin_context(selected_object,O).
attr(role_menu,order,1) :- object(O,T), _clinguin_context(selected_object,O).
attr(role_menu,class,("btn-outline-primary";"btn-sm";"rounded-2";"px-2";"py-1")) :- object(O,T), _clinguin_context(selected_object,O).
attr(role_menu,selected,@concat("",R)) :- object(O,T), _clinguin_context(selected_object,O), _clinguin_context(placement_role,R), role(O,R).
attr(role_menu,selected,"Role") :- object(O,T), _clinguin_context(selected_object,O), not _clinguin_context(placement_role,R): role(O,R).

% ============================================================
% ROLE MENU ITEMS
% ============================================================

elem(role_item(R),dropdown_menu_item,role_menu) :- object(O,T), _clinguin_context(selected_object,O), role(O,R).
attr(role_item(R),label,@concat("",R)) :- object(O,T), _clinguin_context(selected_object,O), role(O,R).
attr(role_item(R),order,N) :- elem(role_item(R),dropdown_menu_item,_), N=#count{Other:elem(role_item(Other),dropdown_menu_item,_),Other<R}.
when(role_item(R),click,context,(placement_role,R)) :- object(O,T), _clinguin_context(selected_object,O), role(O,R).
when(role_item(R),click,call,()) :- object(O,T), _clinguin_context(selected_object,O), role(O,R).

% ============================================================
% UNSELECT BUTTON
% ============================================================

elem(unselect,button,selection) :- object(O,T), _clinguin_context(selected_object,O).
attr(unselect,order,3) :- object(O,T), _clinguin_context(selected_object,O).
attr(unselect,label,"×") :- object(O,T), _clinguin_context(selected_object,O).
attr(unselect,class,("btn-outline-secondary";"btn-sm";"rounded-2";"px-2";"py-1")) :- object(O,T), _clinguin_context(selected_object,O).
when(unselect,click,context,(selected_object,none)) :- object(O,T), _clinguin_context(selected_object,O).
when(unselect,click,context,(placement_role,none)) :- object(O,T), _clinguin_context(selected_object,O).
when(unselect,click,context,(inspector_open,false)) :- object(O,T), _clinguin_context(selected_object,O).
when(unselect,click,context,(dialog,none)) :- object(O,T), _clinguin_context(selected_object,O).
when(unselect,click,call,()) :- object(O,T), _clinguin_context(selected_object,O).

% ============================================================
% ROLE NOTICE
% ============================================================

elem(role_notice_box,container,placement_panel) :- elem(role_notice,label,_).
attr(role_notice_box,order,3) :- elem(role_notice,label,_).
attr(role_notice_box,class,("d-flex";"align-items-center";"border";"border-warning";"rounded-2";"px-2";"py-1";"bg-warning-subtle")) :- elem(role_notice_box,container,_).

elem(role_notice,label,role_notice_box) :- object(O,T), _clinguin_context(selected_object,O), not _clinguin_context(placement_role,R): role(O,R).
attr(role_notice,label,"Choose a role before placing.").
attr(role_notice,class,("small";"text-warning-emphasis";"m-0")) :- elem(role_notice,label,_).

% ============================================================
% COMPACT PLACEMENT HINT
% ============================================================

elem(placement_hint,label,placement_panel).
attr(placement_hint,label,"Click a cell to place · Click again to remove").
attr(placement_hint,order,4).
attr(placement_hint,class,("small";"text-secondary";"border-top";"pt-1";"mt-0";"m-0")).

% ============================================================
% GRID PANEL
% ============================================================

elem(grid_panel,container,main_panel) :- node((_,_)).
attr(grid_panel,order,2) :- node((_,_)).
attr(grid_panel,class,("d-flex";"flex-column";"bg-white";"border";"rounded-3";"shadow-sm";"overflow-hidden";"mw-100")) :- node((_,_)).

% ============================================================
% GRID HEADER
% ============================================================

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
attr(grid_dimensions,label,@concat(Rows," rows × ",Cols," columns · ",N," cells")) :- node((_,_)), Rows=#count{R:node((R,_))}, Cols=#count{C:node((_,C))}, N=#count{P:node(P)}.

% ============================================================
% GRID VIEWPORT
% ============================================================

elem(grid_viewport,container,grid_panel) :- node((_,_)).
attr(grid_viewport,order,3) :- node((_,_)).
attr(grid_viewport,class,("w-100";"overflow-auto";"p-2";"bg-light")) :- node((_,_)).
attr(grid_viewport,height,600) :- node((_,_)).
attr(grid_viewport,child_layout,flex) :- node((_,_)).

% ============================================================
% GRID SURFACE
% ============================================================

elem(grid_surface,container,grid_viewport) :- node((_,_)).
attr(grid_surface,child_layout,absstatic) :- node((_,_)).
attr(grid_surface,class,("position-relative";"flex-shrink-0";"p-0";"m-0";"bg-white")) :- node((_,_)).
attr(grid_surface,order,1) :- node((_,_)).
attr(grid_surface,width,(C-C0+1)*S) :- ui_cell_size(S), C=#max{X:node((_,X))}, C0=#min{X:node((_,X))}.
attr(grid_surface,height,(R-R0+1)*S) :- ui_cell_size(S), R=#max{X:node((X,_))}, R0=#min{X:node((X,_))}.

% ============================================================
% GRID FOOTER
% ============================================================

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
attr(grid_count,label,@concat(N," visible placements")) :- node((_,_)), N=#count{P,R,O:elem(placement(P,R,O),container,_),not placeholder(O)}.

% ============================================================
% DISPLAY CONTROLS
% ============================================================

elem(display_controls,container,grid_panel) :- node((_,_)).
attr(display_controls,order,2) :- node((_,_)).
attr(display_controls,flex_direction,row) :- node((_,_)).
attr(display_controls,class,("d-flex";"flex-row";"flex-wrap";"align-items-center";"gap-3";"px-3";"py-2";"border-top";"border-bottom";"bg-light")) :- node((_,_)).

elem(scale_controls,container,display_controls) :- node((_,_)).
attr(scale_controls,order,1) :- node((_,_)).
attr(scale_controls,flex_direction,row) :- node((_,_)).
attr(E,class,("d-flex";"flex-row";"flex-wrap";"align-items-center";"gap-1")) :- elem(E,container,display_controls).

elem(scale_caption,label,scale_controls) :- node((_,_)).
attr(scale_caption,label,"Zoom") :- node((_,_)).
attr(scale_caption,order,0) :- node((_,_)).

elem(scale_compact,button,scale_controls) :- node((_,_)).
attr(scale_compact,label,"28 px") :- node((_,_)).
attr(scale_compact,order,1) :- node((_,_)).
attr(scale_compact,class,("btn-light";"border";"text-dark";"px-2")) :- node((_,_)).
attr(scale_compact,background_color,"#e9ecef") :- node((_,_)), not _clinguin_context(grid_scale,normal), not _clinguin_context(grid_scale,large).
when(scale_compact,click,context,(grid_scale,compact)) :- node((_,_)).
when(scale_compact,click,call,()) :- node((_,_)).

elem(scale_normal,button,scale_controls) :- node((_,_)).
attr(scale_normal,label,"36 px") :- node((_,_)).
attr(scale_normal,order,2) :- node((_,_)).
attr(scale_normal,class,("btn-light";"border";"text-dark";"px-2")) :- node((_,_)).
attr(scale_normal,background_color,"#e9ecef") :- node((_,_)), _clinguin_context(grid_scale,normal).
when(scale_normal,click,context,(grid_scale,normal)) :- node((_,_)).
when(scale_normal,click,call,()) :- node((_,_)).

elem(scale_large,button,scale_controls) :- node((_,_)).
attr(scale_large,label,"48 px") :- node((_,_)).
attr(scale_large,order,3) :- node((_,_)).
attr(scale_large,class,("btn-light";"border";"text-dark";"px-2")) :- node((_,_)).
attr(scale_large,background_color,"#e9ecef") :- node((_,_)), _clinguin_context(grid_scale,large), not _clinguin_context(grid_scale,normal).
when(scale_large,click,context,(grid_scale,large)) :- node((_,_)).
when(scale_large,click,call,()) :- node((_,_)).

elem(label_controls,container,display_controls) :- node((_,_)).
attr(label_controls,order,2) :- node((_,_)).
attr(label_controls,flex_direction,row) :- node((_,_)).

elem(label_caption,label,label_controls) :- node((_,_)).
attr(label_caption,label,"Labels") :- node((_,_)).
attr(label_caption,order,0) :- node((_,_)).

elem(labels_explicit,button,label_controls) :- node((_,_)).
attr(labels_explicit,label,"Object IDs") :- node((_,_)).
attr(labels_explicit,order,1) :- node((_,_)).
attr(labels_explicit,class,("btn-outline-secondary";"px-2")) :- node((_,_)).
when(labels_explicit,click,context,(label_mode,explicit)) :- node((_,_)).
when(labels_explicit,click,call,()) :- node((_,_)).

elem(labels_all,button,label_controls) :- node((_,_)).
attr(labels_all,label,"All") :- node((_,_)).
attr(labels_all,order,2) :- node((_,_)).
attr(labels_all,class,("btn-outline-secondary";"px-2")) :- node((_,_)).
when(labels_all,click,context,(label_mode,all)) :- node((_,_)).
when(labels_all,click,call,()) :- node((_,_)).

elem(labels_off,button,label_controls) :- node((_,_)).
attr(labels_off,label,"Off") :- node((_,_)).
attr(labels_off,order,3) :- node((_,_)).
attr(labels_off,class,("btn-outline-secondary";"px-2")) :- node((_,_)).
when(labels_off,click,context,(label_mode,off)) :- node((_,_)).
when(labels_off,click,call,()) :- node((_,_)).

% ============================================================
% GRID NODE BOX
% ============================================================

elem(node_box(Row,Col),container,grid_surface) :- node((Row,Col)).
attr(node_box(Row,Col),pos_x,(Col-C0)*S) :- node((Row,Col)), ui_cell_size(S), C0=#min{X:node((_,X))}.
attr(node_box(Row,Col),pos_y,(Row-R0)*S) :- node((Row,Col)), ui_cell_size(S), R0=#min{X:node((X,_))}.
attr(node_box(Row,Col),child_layout,grid) :- node((Row,Col)).
attr(node_box(Row,Col),order,K) :- node((Row,Col)), K=#count{R,C:node((R,C)),(R,C)<(Row,Col)}.
attr(node_box(Row,Col),class,("position-absolute";"p-0";"m-0";"border-0";"overflow-hidden";"user-select-none")) :- node((Row,Col)).
attr(node_box(Row,Col),background_color,"white") :- node((Row,Col)).
attr(node_box(Row,Col),width,S) :- elem(node_box(Row,Col),container,_), ui_cell_size(S).
attr(node_box(Row,Col),height,S) :- elem(node_box(Row,Col),container,_), ui_cell_size(S).
attr(node_box(Row,Col),on_hover,true) :- node((Row,Col)), when(node_box(Row,Col),click,call,add_atom(_)).
attr(node_box(Row,Col),on_hover_background_color,"#e9ecef") :- node((Row,Col)), when(node_box(Row,Col),click,call,add_atom(_)).
attr(E,grid_row,0) :- elem(E,_,node_box(Row,Col)).
attr(E,grid_column,0) :- elem(E,_,node_box(Row,Col)).
when(node_box(Row,Col),click,update,(placement_preview(Row,Col),visibility,shown)) :- when(node_box(Row,Col),click,call,add_atom(position(N,R,O))).

% ============================================================
% PLACEMENTS
% ============================================================

elem(placement(N,R,O),container,node_box(Row,Col)) :-
    node((Row,Col)),
    N=(Row,Col),
    position(N,R,O),
    object(O,_),
    role(O,R),
    _clinguin_atom(position(N,R,O)),
    (R,O)=#max{(R2,O2):_clinguin_atom(position(N,R2,O2)),position(N,R2,O2),object(O2,_),role(O2,R2)}.

elem(placement(N,R,O),container,node_box(Row,Col)) :-
    node((Row,Col)),
    N=(Row,Col),
    position(N,R,O),
    object(O,_),
    role(O,R),
    0=#count{R2,O2:_clinguin_atom(position(N,R2,O2)),position(N,R2,O2),object(O2,_),role(O2,R2)}.

attr(placement(N,R,O),visibility,hidden) :- elem(placement(N,R,O),container,_), placeholder(O).
attr(placement(N,R,O),child_layout,grid) :- elem(placement(N,R,O),container,_).
attr(placement(N,R,O),class,("p-0";"m-0";"pe-none")) :- elem(placement(N,R,O),container,_).
attr(placement(N,R,O),width,S) :- elem(placement(N,R,O),container,_), ui_cell_size(S).
attr(placement(N,R,O),height,S) :- elem(placement(N,R,O),container,_), ui_cell_size(S).

attr(placement(N,R,O),order,K) :-
    elem(placement(N,R,O),container,_),
    visual(O,R,Z,_,_,_,_),
    K=#count{R2,O2,Z2:elem(placement(N,R2,O2),container,_),visual(O2,R2,Z2,_,_,_,_),(Z2,R2,O2)<(Z,R,O);
             R2,O2,0:elem(placement(N,R2,O2),container,_),not visual(O2,R2,_,_,_,_,_),(0,R2,O2)<(Z,R,O)}.

attr(placement(N,R,O),order,K) :-
    elem(placement(N,R,O),container,_),
    not visual(O,R,_,_,_,_,_),
    K=#count{R2,O2,Z2:elem(placement(N,R2,O2),container,_),visual(O2,R2,Z2,_,_,_,_),(Z2,R2,O2)<(0,R,O);
             R2,O2,0:elem(placement(N,R2,O2),container,_),not visual(O2,R2,_,_,_,_,_),(0,R2,O2)<(0,R,O)}.

attr(E,grid_row,0) :- elem(E,_,placement(N,R,O)).
attr(E,grid_column,0) :- elem(E,_,placement(N,R,O)).

% ============================================================
% PLACEMENT IMAGE
% ============================================================

elem(node_image(N,R,O,I),canvas,placement(N,R,O)) :- elem(placement(N,R,O),container,_), not placeholder(O), image(O,R,I), I!="", I!=" ".
attr(node_image(N,R,O,I),image,I) :- elem(node_image(N,R,O,I),canvas,_).
attr(node_image(N,R,O,I),order,K) :- elem(node_image(N,R,O,I),canvas,_), K=#count{I2:elem(node_image(N,R,O,I2),canvas,_),I2<I}.
attr(node_image(N,R,O,I),class,("d-block";"p-0";"m-0";"pe-none")) :- elem(node_image(N,R,O,I),canvas,_).
attr(node_image(N,R,O,I),class,("w-100";"h-100")) :- elem(node_image(N,R,O,I),canvas,_).
attr(node_image(N,R,O,I),width,S) :- elem(node_image(N,R,O,I),canvas,_), ui_cell_size(S).
attr(node_image(N,R,O,I),height,S) :- elem(node_image(N,R,O,I),canvas,_), ui_cell_size(S).

% ============================================================
% PLACEMENT TEXT
% ============================================================

elem(node_text(N,R,O),label,placement(N,R,O)) :- elem(placement(N,R,O),container,_), not placeholder(O), 0=#count{I:image(O,R,I),I!="",I!=" "}.
attr(node_text(N,R,O),label,@concat("",L)) :- elem(node_text(N,R,O),label,_), label(O,L,_).
attr(node_text(N,R,O),label,@concat("",O)) :- elem(node_text(N,R,O),label,_), not label(O,_,_).
attr(node_text(N,R,O),order,0) :- elem(node_text(N,R,O),label,_).
attr(node_text(N,R,O),class,("d-flex";"align-items-center";"justify-content-center";"text-center";"small";"fw-bold";"font-monospace";"text-primary";"m-0";"pe-none";"overflow-hidden")) :- elem(node_text(N,R,O),label,_).
attr(node_text(N,R,O),width,S) :- elem(node_text(N,R,O),label,_), ui_cell_size(S).
attr(node_text(N,R,O),height,S) :- elem(node_text(N,R,O),label,_), ui_cell_size(S).

% ============================================================
% PLACEMENT BADGE
% ============================================================

elem(node_badge(N,R,O),label,badge_box(N,R,O)) :-
    elem(placement(N,R,O),container,_), not placeholder(O),
    visual(O,R,Z,_,_,_,_),
    Z=#max{Z2:elem(placement(N,R2,O2),container,_),visual(O2,R2,Z2,_,_,_,_)},
    image(O,R,I), I!="", I!=" ", label(O,_,_), not _clinguin_context(label_mode,off).

elem(node_badge(N,R,O),label,badge_box(N,R,O)) :-
    elem(placement(N,R,O),container,_), not placeholder(O),
    visual(O,R,Z,_,_,_,_),
    Z=#max{Z2:elem(placement(N,R2,O2),container,_),visual(O2,R2,Z2,_,_,_,_)},
    image(O,R,I), I!="", I!=" ", not label(O,_,_), _clinguin_context(label_mode,all).

attr(node_badge(N,R,O),label,@concat("",L)) :- elem(node_badge(N,R,O),label,_), label(O,L,_).
attr(node_badge(N,R,O),label,@concat("",O)) :- elem(node_badge(N,R,O),label,_), not label(O,_,_).
attr(node_badge(N,R,O),order,1) :- elem(node_badge(N,R,O),label,_).
attr(node_badge(N,R,O),class,("small";"fw-bold";"lh-1";"text-dark";"text-center";"m-0";"pe-none")) :- elem(node_badge(N,R,O),label,_).

elem(badge_box(N,R,O),container,placement(N,R,O)) :- elem(node_badge(N,R,O),label,_).
attr(badge_box(N,R,O),order,K+1) :- elem(badge_box(N,R,O),container,_), K=#count{I:elem(node_image(N,R,O,I),canvas,_)}.
attr(badge_box(N,R,O),class,("p-0";"m-0";"pe-none";"d-flex";"align-items-center";"justify-content-center")) :- elem(badge_box(N,R,O),container,_).
attr(badge_box(N,R,O),class,("align-self-center";"mx-auto")) :- elem(badge_box(N,R,O),container,_), label(O,_,center).
attr(badge_box(N,R,O),class,("align-self-start";"ms-auto")) :- elem(badge_box(N,R,O),container,_), not label(O,_,center).
attr(badge_box(N,R,O),width,14) :- elem(badge_box(N,R,O),container,_).
attr(badge_box(N,R,O),height,14) :- elem(badge_box(N,R,O),container,_).

% ============================================================
% NO GRID MESSAGE
% ============================================================

elem(no_grid,label,main_panel) :- not node((_,_)).
attr(no_grid,label,"No grid is loaded. Open a scenario containing grid nodes to begin.") :- not node((_,_)).
attr(no_grid,class,("p-5";"text-center";"text-muted")) :- not node((_,_)).
attr(no_grid,order,2) :- not node((_,_)).

% ============================================================
% PLACEMENT PREVIEW
% ============================================================

elem(placement_preview(Row,Col),container,node_box(Row,Col)) :-
    object(O,T),
    _clinguin_context(selected_object,O),
    _clinguin_context(placement_role,R),
    role(O,R),
    not issue(O,error,_,_),
    not issue(O,warning,property(_),_),
    node((Row,Col)).

attr(placement_preview(Row,Col),visibility,hidden) :- elem(placement_preview(Row,Col),container,_).
attr(placement_preview(Row,Col),child_layout,grid) :- elem(placement_preview(Row,Col),container,_).
attr(placement_preview(Row,Col),class,("p-0";"m-0";"pe-none")) :- elem(placement_preview(Row,Col),container,_).
attr(placement_preview(Row,Col),order,K+1) :- elem(placement_preview(Row,Col),container,_), K=#count{R,O:elem(placement((Row,Col),R,O),container,_)}.
attr(placement_preview(Row,Col),width,S) :- elem(placement_preview(Row,Col),container,_), ui_cell_size(S).
attr(placement_preview(Row,Col),height,S) :- elem(placement_preview(Row,Col),container,_), ui_cell_size(S).
attr(E,grid_row,0) :- elem(E,_,placement_preview(Row,Col)).
attr(E,grid_column,0) :- elem(E,_,placement_preview(Row,Col)).

% ============================================================
% PLACEMENT PREVIEW IMAGE
% ============================================================

elem(placement_preview_image(Row,Col),canvas,placement_preview(Row,Col)) :-
    object(O,T),
    _clinguin_context(selected_object,O),
    _clinguin_context(placement_role,R),
    role(O,R),
    not issue(O,error,_,_),
    not issue(O,warning,property(_),_),
    node((Row,Col)),
    image(O,R,I), I!="", I!=" ",
    I=#min{Path:image(O,R,Path),Path!="",Path!=" "}.

attr(placement_preview_image(Row,Col),image,I) :-
    object(O,T),
    _clinguin_context(selected_object,O),
    _clinguin_context(placement_role,R),
    role(O,R),
    not issue(O,error,_,_),
    not issue(O,warning,property(_),_),
    node((Row,Col)),
    image(O,R,I), I!="", I!=" ",
    I=#min{Path:image(O,R,Path),Path!="",Path!=" "}.

attr(placement_preview_image(Row,Col),order,0) :- elem(placement_preview_image(Row,Col),canvas,_).
attr(placement_preview_image(Row,Col),class,("d-block";"p-0";"m-0";"pe-none")) :- elem(placement_preview_image(Row,Col),canvas,_).
attr(placement_preview_image(Row,Col),class,("w-100";"h-100")) :- elem(placement_preview_image(Row,Col),canvas,_).
attr(placement_preview_image(Row,Col),width,S) :- elem(placement_preview_image(Row,Col),canvas,_), ui_cell_size(S).
attr(placement_preview_image(Row,Col),height,S) :- elem(placement_preview_image(Row,Col),canvas,_), ui_cell_size(S).

% ============================================================
% PLACEMENT PREVIEW TEXT
% ============================================================

elem(placement_preview_text(Row,Col),label,placement_preview(Row,Col)) :-
    object(O,T),
    _clinguin_context(selected_object,O),
    _clinguin_context(placement_role,R),
    role(O,R),
    not issue(O,error,_,_),
    not issue(O,warning,property(_),_),
    node((Row,Col)),
    0=#count{I:image(O,R,I),I!="",I!=" "}.

attr(placement_preview_text(Row,Col),label,@concat("",L)) :- elem(placement_preview_text(Row,Col),label,_), _clinguin_context(selected_object,O), label(O,L,_).
attr(placement_preview_text(Row,Col),label,@concat("",O)) :-
    not label(O,_,_), object(O,T),
    _clinguin_context(selected_object,O),
    _clinguin_context(placement_role,R),
    role(O,R),
    not issue(O,error,_,_),
    not issue(O,warning,property(_),_),
    node((Row,Col)).
attr(placement_preview_text(Row,Col),order,0) :- elem(placement_preview_text(Row,Col),label,_).
attr(placement_preview_text(Row,Col),class,("d-flex";"align-items-center";"justify-content-center";"small";"fw-bold";"text-primary";"text-center";"m-0";"pe-none";"overflow-hidden")) :- elem(placement_preview_text(Row,Col),label,_).
attr(placement_preview_text(Row,Col),width,S) :- elem(placement_preview_text(Row,Col),label,_), ui_cell_size(S).
attr(placement_preview_text(Row,Col),height,S) :- elem(placement_preview_text(Row,Col),label,_), ui_cell_size(S).

% ============================================================
% PLACEMENT PREVIEW ID BOX
% ============================================================

elem(placement_preview_id_box(Row,Col),container,placement_preview(Row,Col)) :-
    object(O,T),
    _clinguin_context(selected_object,O),
    _clinguin_context(placement_role,R),
    role(O,R),
    not issue(O,error,_,_),
    not issue(O,warning,property(_),_),
    node((Row,Col)),
    label(O,L,_),
    0<#count{I:image(O,R,I),I!="",I!=" "},
    not _clinguin_context(label_mode,off).

attr(placement_preview_id_box(Row,Col),order,1) :- elem(placement_preview_id_box(Row,Col),container,_).
attr(placement_preview_id_box(Row,Col),width,14) :- elem(placement_preview_id_box(Row,Col),container,_).
attr(placement_preview_id_box(Row,Col),height,14) :- elem(placement_preview_id_box(Row,Col),container,_).
attr(placement_preview_id_box(Row,Col),class,("p-0";"m-0";"pe-none";"d-flex";"align-items-center";"justify-content-center")) :- elem(placement_preview_id_box(Row,Col),container,_).
attr(placement_preview_id_box(Row,Col),class,("align-self-center";"mx-auto")) :- elem(placement_preview_id_box(Row,Col),container,_), _clinguin_context(selected_object,O), label(O,_,center).
attr(placement_preview_id_box(Row,Col),class,("align-self-start";"ms-auto")) :- elem(placement_preview_id_box(Row,Col),container,_), _clinguin_context(selected_object,O), not label(O,_,center).

% ============================================================
% PLACEMENT PREVIEW ID
% ============================================================

elem(placement_preview_id(Row,Col),label,placement_preview_id_box(Row,Col)) :-
    object(O,T),
    _clinguin_context(selected_object,O),
    _clinguin_context(placement_role,R),
    role(O,R),
    not issue(O,error,_,_),
    not issue(O,warning,property(_),_),
    node((Row,Col)),
    label(O,L,_),
    0<#count{I:image(O,R,I),I!="",I!=" "},
    not _clinguin_context(label_mode,off).

attr(placement_preview_id(Row,Col),label,@concat("",L)) :- _clinguin_context(selected_object,O), label(O,L,_), elem(placement_preview_id(Row,Col),label,_).
attr(placement_preview_id(Row,Col),order,1) :- elem(placement_preview_id(Row,Col),label,_).
attr(placement_preview_id(Row,Col),class,("small";"fw-bold";"lh-1";"text-dark";"text-center";"m-0";"pe-none")) :- elem(placement_preview_id(Row,Col),label,_).

% ============================================================
% NODE FRAME
% ============================================================

elem(node_frame(Row,Col),container,node_box(Row,Col)) :- node((Row,Col)).
attr(node_frame(Row,Col),class,("border";"border-secondary";"p-0";"m-0";"pe-none")) :- node((Row,Col)).
attr(node_frame(Row,Col),order,K+2) :- node((Row,Col)), K=#count{R,O:elem(placement((Row,Col),R,O),container,_)}.

% ============================================================
% PLACEMENT ACTIONS
% ============================================================

% ------------------------------------------------------------
% Add placement: empty slot (role has no limit any more)
% ------------------------------------------------------------

when(node_box(Row,Col),click,call,add_atom(position(N,R,O))) :-
    object(O,T),
    _clinguin_context(selected_object,O),
    _clinguin_context(placement_role,R),
    role(O,R),
    not issue(O,error,_,_),
    not issue(O,warning,property(_),_),
    node((Row,Col)),
    N=(Row,Col),
    A=#count{Needed:support(O,R,Needed)},
    A=#count{Needed:support(O,R,Needed),elem(placement(N,Rd,Dep),container,_),role(Dep,Rd),not placeholder(Dep)},
    0=#count{OldRole,OldO:elem(placement(N,OldRole,OldO),container,_),role(OldO,OldRole),not placeholder(OldO)},
    not elem(placement(N,R,O),container,_),
    not _clinguin_unsat.

% ------------------------------------------------------------
% Add placement: replaceable slot
% ------------------------------------------------------------

when(node_box(Row,Col),click,call,add_atom(position(N,R,O))) :-
    object(O,T),
    _clinguin_context(selected_object,O),
    _clinguin_context(placement_role,R),
    role(O,R),
    not issue(O,error,_,_),
    not issue(O,warning,property(_),_),
    node((Row,Col)),
    N=(Row,Col),
    A=#count{Needed:support(O,R,Needed)},
    A=#count{Needed:support(O,R,Needed),elem(placement(N,Rd,Dep),container,_),role(Dep,Rd),not placeholder(Dep)},
    elem(placement(N,OldRole,OldO),container,_),
    role(OldO,OldRole),
    not _clinguin_atom(position(N,OldRole,OldO)),
    not placeholder(OldO),
    replaceable(OldO),
    (OldRole,OldO)!=(R,O),
    not _clinguin_unsat.

% ============================================================
% SUCCESSFUL PLACEMENT — CONTEXT UPDATES
% ============================================================

when(node_box(Row,Col),click,context,(selected_object,O)) :- when(node_box(Row,Col),click,call,add_atom(position(N,R,O))).
when(node_box(Row,Col),click,context,(placement_role,R)) :- when(node_box(Row,Col),click,call,add_atom(position(N,R,O))).
when(node_box(Row,Col),click,context,(inspector_open,false)) :- when(node_box(Row,Col),click,call,add_atom(position(N,R,O))).
when(node_box(Row,Col),click,context,(dialog,none)) :- when(node_box(Row,Col),click,call,add_atom(position(N,R,O))).
when(node_box(Row,Col),click,update,(local_feedback,visibility,hidden)) :- when(node_box(Row,Col),click,call,add_atom(position(N,R,O))).
when(node_box(Row,Col),click,update,(operation_status,label,"Placing…")) :- when(node_box(Row,Col),click,call,add_atom(position(N,R,O))).

% ============================================================
% DELETE PLACEMENT
% ============================================================

when(node_box(Row,Col),right_click,context,(delete_position,position(N,R,O))) :-
    node((Row,Col)), N=(Row,Col),
    elem(placement(N,R,O),container,_),
    _clinguin_atom(position(N,R,O)),
    attr(placement(N,R,O),order,K),
    (K,R,O)=#max{(K2,R2,O2):elem(placement(N,R2,O2),container,_),attr(placement(N,R2,O2),order,K2),_clinguin_atom(position(N,R2,O2))}.

when(node_box(Row,Col),click,context,(delete_position,position(N,R,O))) :-
    node((Row,Col)), N=(Row,Col),
    elem(placement(N,R,O),container,_),
    _clinguin_atom(position(N,R,O)),
    attr(placement(N,R,O),order,K),
    (K,R,O)=#max{(K2,R2,O2):elem(placement(N,R2,O2),container,_),attr(placement(N,R2,O2),order,K2),_clinguin_atom(position(N,R2,O2))},
    not _clinguin_context(selected_object,Chosen):object(Chosen,_).

when(node_box(Row,Col),click,context,(delete_position,position(N,R,O))) :-
    node((Row,Col)), N=(Row,Col),
    _clinguin_context(selected_object,O),
    _clinguin_context(placement_role,R),
    elem(placement(N,R,O),container,_),
    _clinguin_atom(position(N,R,O)),
    not when(node_box(Row,Col),click,call,add_atom(_)).

% ============================================================
% SUPPORT ERROR FEEDBACK
% ============================================================

when(node_box(Row,Col),click,update,(local_feedback,visibility,shown)) :-
    object(O,T), _clinguin_context(selected_object,O), _clinguin_context(placement_role,R),
    role(O,R),
    not issue(O,error,_,_), not issue(O,warning,property(_),_), node((Row,Col)), N=(Row,Col),
    not when(node_box(Row,Col),click,context,(delete_position,_)),
    support(O,R,Needed),
    0=#count{Dep,Rd:elem(placement(N,Rd,Dep),container,_),role(Dep,Rd),not placeholder(Dep)},
    not _clinguin_unsat.

when(node_box(Row,Col),click,update,(local_feedback,title,"Placement blocked")) :-
    object(O,T), _clinguin_context(selected_object,O), _clinguin_context(placement_role,R),
    role(O,R),
    not issue(O,error,_,_), not issue(O,warning,property(_),_), node((Row,Col)), N=(Row,Col),
    not when(node_box(Row,Col),click,context,(delete_position,_)),
    support(O,R,Needed),
    0=#count{Dep,Rd:elem(placement(N,Rd,Dep),container,_),role(Dep,Rd),not placeholder(Dep)},
    not _clinguin_unsat.

when(node_box(Row,Col),click,update,(local_feedback,message,"A required supporting object is missing at this node.")) :-
    object(O,T), _clinguin_context(selected_object,O), _clinguin_context(placement_role,R),
    role(O,R),
    not issue(O,error,_,_), not issue(O,warning,property(_),_), node((Row,Col)), N=(Row,Col),
    not when(node_box(Row,Col),click,context,(delete_position,_)),
    support(O,R,Needed),
    0=#count{Dep,Rd:elem(placement(N,Rd,Dep),container,_),role(Dep,Rd),not placeholder(Dep)},
    not _clinguin_unsat.

% ============================================================
% SLOT OCCUPIED FEEDBACK
% ============================================================

when(node_box(Row,Col),click,update,(local_feedback,visibility,shown)) :-
    object(O,T), _clinguin_context(selected_object,O), _clinguin_context(placement_role,R),
    role(O,R),
    not issue(O,error,_,_), not issue(O,warning,property(_),_), node((Row,Col)), N=(Row,Col),
    not when(node_box(Row,Col),click,context,(delete_position,_)),
    elem(placement(N,OldRole,OldO),container,_),
    role(OldO,OldRole),
    not placeholder(OldO),
    (OldRole,OldO)!=(R,O),
    not when(node_box(Row,Col),click,call,add_atom(_)),
    not _clinguin_unsat.

when(node_box(Row,Col),click,update,(local_feedback,title,"Slot occupied")) :-
    object(O,T), _clinguin_context(selected_object,O), _clinguin_context(placement_role,R),
    role(O,R),
    not issue(O,error,_,_), not issue(O,warning,property(_),_), node((Row,Col)), N=(Row,Col),
    not when(node_box(Row,Col),click,context,(delete_position,_)),
    elem(placement(N,OldRole,OldO),container,_),
    role(OldO,OldRole),
    not placeholder(OldO),
    (OldRole,OldO)!=(R,O),
    not when(node_box(Row,Col),click,call,add_atom(_)),
    not _clinguin_unsat.

when(node_box(Row,Col),click,update,(local_feedback,message,"Right-click the existing session placement to remove it, then place your selected object.")) :-
    object(O,T), _clinguin_context(selected_object,O), _clinguin_context(placement_role,R),
    role(O,R),
    not issue(O,error,_,_), not issue(O,warning,property(_),_), node((Row,Col)), N=(Row,Col),
    not when(node_box(Row,Col),click,context,(delete_position,_)),
    elem(placement(N,OldRole,OldO),container,_),
    role(OldO,OldRole),
    not placeholder(OldO),
    (OldRole,OldO)!=(R,O),
    not when(node_box(Row,Col),click,call,add_atom(_)),
    not _clinguin_unsat.

% ============================================================
% NO VALID ROLE FEEDBACK
% ============================================================

when(node_box(Row,Col),click,update,(local_feedback,visibility,shown)) :-
    object(O,T), _clinguin_context(selected_object,O), node((Row,Col)),
    0=#count{R:_clinguin_context(placement_role,R),role(O,R)},
    not when(node_box(Row,Col),click,context,(delete_position,_)), not _clinguin_unsat.

when(node_box(Row,Col),click,update,(local_feedback,title,"Choose a role")) :-
    object(O,T), _clinguin_context(selected_object,O), node((Row,Col)),
    0=#count{R:_clinguin_context(placement_role,R),role(O,R)},
    not when(node_box(Row,Col),click,context,(delete_position,_)), not _clinguin_unsat.

when(node_box(Row,Col),click,update,(local_feedback,message,"Select a placement role first.")) :-
    object(O,T), _clinguin_context(selected_object,O), node((Row,Col)),
    0=#count{R:_clinguin_context(placement_role,R),role(O,R)},
    not when(node_box(Row,Col),click,context,(delete_position,_)), not _clinguin_unsat.

% ============================================================
% INVALID OBJECT FEEDBACK
% ============================================================

when(node_box(Row,Col),click,update,(local_feedback,visibility,shown)) :-
    object(O,T), _clinguin_context(selected_object,O), node((Row,Col)),
    issue(O,error,object_term,_),
    not when(node_box(Row,Col),click,context,(delete_position,_)), not _clinguin_unsat.

when(node_box(Row,Col),click,update,(local_feedback,title,"Invalid object")) :-
    object(O,T), _clinguin_context(selected_object,O), node((Row,Col)),
    issue(O,error,object_term,_),
    not when(node_box(Row,Col),click,context,(delete_position,_)), not _clinguin_unsat.

when(node_box(Row,Col),click,update,(local_feedback,message,"Correct the object identifier or type before placing it.")) :-
    object(O,T), _clinguin_context(selected_object,O), node((Row,Col)),
    issue(O,error,object_term,_),
    not when(node_box(Row,Col),click,context,(delete_position,_)), not _clinguin_unsat.

when(node_box(Row,Col),click,update,(local_feedback,visibility,shown)) :-
    object(O,T), _clinguin_context(selected_object,O), node((Row,Col)),
    issue(O,error,type_term,_),
    not when(node_box(Row,Col),click,context,(delete_position,_)), not _clinguin_unsat.

when(node_box(Row,Col),click,update,(local_feedback,title,"Invalid object")) :-
    object(O,T), _clinguin_context(selected_object,O), node((Row,Col)),
    issue(O,error,type_term,_),
    not when(node_box(Row,Col),click,context,(delete_position,_)), not _clinguin_unsat.

when(node_box(Row,Col),click,update,(local_feedback,message,"Correct the object identifier or type before placing it.")) :-
    object(O,T), _clinguin_context(selected_object,O), node((Row,Col)),
    issue(O,error,type_term,_),
    not when(node_box(Row,Col),click,context,(delete_position,_)), not _clinguin_unsat.

% ============================================================
% UNSATISFIABLE STATE FEEDBACK
% ============================================================

when(node_box(Row,Col),click,update,(local_feedback,visibility,shown)) :- node((Row,Col)), _clinguin_unsat, not when(node_box(Row,Col),click,context,(delete_position,_)).
when(node_box(Row,Col),click,update,(local_feedback,title,"Resolve the constraint error")) :- node((Row,Col)), _clinguin_unsat, not when(node_box(Row,Col),click,context,(delete_position,_)).
when(node_box(Row,Col),click,update,(local_feedback,message,"Use Undo last change before adding another placement.")) :- node((Row,Col)), _clinguin_unsat, not when(node_box(Row,Col),click,context,(delete_position,_)).

% ============================================================
% ROLE / LABEL POSITIONING
% ============================================================

attr(E,class,("small";"fw-bold";"text-secondary";"me-1")) :- elem(E,label,P), P=(scale_controls;label_controls).

% ============================================================
% GENERAL GRID LAYERING
% ============================================================

attr(E,grid_row,0) :- elem(E,_,node_box(Row,Col)).
attr(E,grid_column,0) :- elem(E,_,node_box(Row,Col)).
attr(E,grid_row,0) :- elem(E,_,placement(N,R,O)).
attr(E,grid_column,0) :- elem(E,_,placement(N,R,O)).
attr(E,grid_row,0) :- elem(E,_,placement_preview(Row,Col)).
attr(E,grid_column,0) :- elem(E,_,placement_preview(Row,Col)).