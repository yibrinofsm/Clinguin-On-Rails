% ============================================================
% ui_layout.lp
% ============================================================

% WORKSPACE
elem(workspace,container,w).
attr(workspace,order,2).
attr(workspace,child_layout,flex).
attr(workspace,flex_direction,row).
attr(workspace,class,("d-flex";"flex-row";"flex-wrap";"align-items-start";"p-2";"bg-light")).

% MAIN PANEL
elem(main_panel,container,workspace).
attr(main_panel,order,1).
attr(main_panel,child_layout,flex).
attr(main_panel,flex_direction,column).
attr(main_panel,class,("col-12";"col-lg-9";"pe-lg-3";"d-flex";"flex-column";"gap-2")).

% SIDEBAR PANEL
elem(sidebar_panel,container,workspace).
attr(sidebar_panel,order,2).
attr(sidebar_panel,class,("col-12";"col-lg-3";"d-flex";"flex-column";"bg-white";"border";"rounded-3";"shadow-sm";"overflow-hidden")).

% GRID PANEL
elem(grid_panel,container,main_panel) :- node((_,_)).
attr(grid_panel,order,2) :- elem(grid_panel,container,main_panel).
attr(grid_panel,class,("d-flex";"flex-column";"bg-white";"border";"rounded-3";"shadow-sm";"overflow-hidden";"mw-100")) :- elem(grid_panel,container,main_panel).

% GRID HEADER
elem(grid_header,container,grid_panel) :- elem(grid_panel,container,main_panel).
attr(grid_header,order,1) :- elem(grid_header,container,grid_panel).
attr(grid_header,flex_direction,row) :- elem(grid_header,container,grid_panel).
attr(grid_header,class,("d-flex";"flex-row";"flex-wrap";"align-items-center";"justify-content-between";"gap-2";"px-3";"py-2")) :- elem(grid_header,container,grid_panel).

elem(grid_title,label,grid_header) :- elem(grid_header,container,grid_panel).
attr(grid_title,order,1) :- elem(grid_title,label,grid_header).
attr(grid_title,label,"Grid workspace") :- elem(grid_title,label,grid_header).
attr(grid_title,class,("fw-bold";"text-dark")) :- elem(grid_title,label,grid_header).

elem(grid_dimensions,label,grid_header) :- elem(grid_header,container,grid_panel).
attr(grid_dimensions,order,2) :- elem(grid_dimensions,label,grid_header).
attr(grid_dimensions,class,("small";"text-secondary")) :- elem(grid_dimensions,label,grid_header).
attr(grid_dimensions,label,@concat(Rows," rows × ",Cols," columns · ",N," cells")) :- elem(grid_dimensions,label,grid_header),Rows=#count{R:node((R,_))},Cols=#count{C:node((_,C))},N=#count{R,C:node((R,C))}.

% GRID VIEWPORT
elem(grid_viewport,container,grid_panel) :- elem(grid_panel,container,main_panel).
attr(grid_viewport,order,3) :- elem(grid_viewport,container,grid_panel).
attr(grid_viewport,child_layout,flex) :- elem(grid_viewport,container,grid_panel).
attr(grid_viewport,class,("w-100";"overflow-auto";"p-2";"bg-light")) :- elem(grid_viewport,container,grid_panel).

% GRID SURFACE
elem(grid_surface,container,grid_viewport) :- elem(grid_viewport,container,grid_panel).
attr(grid_surface,order,1) :- elem(grid_surface,container,grid_viewport).
attr(grid_surface,child_layout,grid) :- elem(grid_surface,container,grid_viewport).
attr(grid_surface,class,("d-grid";"align-self-start";"flex-shrink-0";"p-0";"m-0";"bg-white")) :- elem(grid_surface,container,grid_viewport).
attr(grid_surface,"gridTemplateColumns","max-content") :- elem(grid_surface,container,grid_viewport).
attr(grid_surface,"gridAutoRows","30px") :- elem(grid_surface,container,grid_viewport).

% GRID ROW
elem(grid_row(Row),container,grid_surface) :- node((Row,_)).
attr(grid_row(Row),order,Row) :- node((Row,_)).
attr(grid_row(Row),child_layout,grid) :- node((Row,_)).
attr(grid_row(Row),class,("d-grid";"p-0";"m-0")) :- node((Row,_)).
attr(grid_row(Row),grid_row,Row-R0) :- node((Row,_)),R0=#min{R:node((R,_))}.
attr(grid_row(Row),grid_column,0) :- node((Row,_)).
attr(grid_row(Row),"gridAutoColumns","30px") :- node((Row,_)).
attr(grid_row(Row),"gridTemplateRows","30px") :- node((Row,_)).

% GRID NODE BOX 
elem(node_box(Row,Col),container,grid_row(Row)) :- node((Row,Col)).
attr(node_box(Row,Col),order,Col) :- node((Row,Col)).
attr(node_box(Row,Col),grid_row,0) :- node((Row,Col)).
attr(node_box(Row,Col),grid_column,Col-C0) :- node((Row,Col)),C0=#min{C:node((_,C))}.
attr(node_box(Row,Col),child_layout,grid) :- node((Row,Col)).
% attr(node_box(Row,Col),class,("p-0";"m-0";"pe-none";"w-100";"h-100")) :- node((Row,Col)).
attr(node_box(Row,Col),class,("p-0";"m-0";"w-100";"h-100")) :- node((Row,Col)).
attr(node_box(Row,Col),background_color,"white") :- node((Row,Col)).

attr(node_box(Row,Col),"border-top","1px solid #0f8bf7") :- node((Row,Col)).
attr(node_box(Row,Col),"border-left","1px solid #0f8bf7") :- node((Row,Col)).
attr(node_box(Row,Col),"border-right","1px solid #0f8bf7") :- node((Row,Col)), not node((Row,Col+1)).
attr(node_box(Row,Col),"border-bottom","1px solid #0f8bf7") :- node((Row,Col)), not node((Row+1,Col)).
attr(node_box(Row,Col),"box-sizing","border-box") :- node((Row,Col)).
% % SUCCESS NOTIFICATION
% % ============================================================
% when(node_box(Row,Col),click,context,(notice_level,success)) :-node((Row,Col)),object_selected_for_placement(O,T,R),not position((Row,Col),R,O),not same_type_placement_conflict((Row,Col),R,O,T),not _clinguin_unsat.
% when(node_box(Row,Col),click,context,(notice_title,"Object Placed")) :-node((Row,Col)),object_selected_for_placement(O,T,R),not position((Row,Col),R,O),not same_type_placement_conflict((Row,Col),R,O,T),not _clinguin_unsat.
% when(node_box(Row,Col),click,context,(notice_message,@concat("Object ",O," of type ",T," was placed at node (",Row,",",Col,") in the grid."))) :-node((Row,Col)),object_selected_for_placement(O,T,R),not position((Row,Col),R,O),not same_type_placement_conflict((Row,Col),R,O,T),not _clinguin_unsat.

 % Place an object when there is no conflict.
% when(node_box(Row,Col),click,call,add_atom(position((Row,Col),R,O))) :-node((Row,Col)),object_selected_for_placement(O,T,R),not position((Row,Col),R,O),not same_type_placement_conflict((Row,Col),R,O,T),not _clinguin_unsat.
% ============================================================
% GENERIC OBJECT PLACEMENT
% ============================================================

%

% ============================================================
% PLACE OBJECT
% ============================================================
when(node_box(Row,Col),click,call,add_atom(position((Row,Col),R,O))) :-valid_object_placement(Row,Col,O,T,R).
% ============================================================
% SUCCESS NOTIFICATION
% ============================================================

notification_event( node_box(Row,Col),click,success,"Object Placed",@concat("Object ",O," of type ",T," was placed at node (",Row,",",Col,") in the grid.")) :-valid_object_placement(Row,Col,O,T,R).

% ============================================================
% REJECTED PLACEMENT NOTIFICATION
% ============================================================

notification_event(node_box(Row,Col),click,error,"Placement Rejected",@concat("Cannot place object ",O," of type ",T," at node (",Row,",",Col,"). The placement violates a declared constraint.")) :-node((Row,Col)),object_selected_for_placement(O,T,R),placement_rejected((Row,Col),O,T,R).

% NO GRID
elem(no_grid,label,main_panel) :- not node((_,_)).
attr(no_grid,order,2) :- elem(no_grid,label,main_panel).
attr(no_grid,label,"No nodes available. Add a node in the sidebar to begin.") :- elem(no_grid,label,main_panel),not node(_).
attr(no_grid,label,"No grid coordinates available. Use node((Row,Column)).") :- elem(no_grid,label,main_panel),node(_).
attr(no_grid,class,("p-5";"text-center";"text-muted")) :- elem(no_grid,label,main_panel).



% ============================================================
% DISPLAY PLACED OBJECTS
% ============================================================

% Container for each placed object.
elem(grid_placement(Row,Col,R,O),container,node_box(Row,Col)) :- node((Row,Col)),position((Row,Col),R,O),object(O,_).
attr(grid_placement(Row,Col,R,O),grid_row,0) :- elem(grid_placement(Row,Col,R,O),container,_).
attr(grid_placement(Row,Col,R,O),grid_column,0) :- elem(grid_placement(Row,Col,R,O),container,_).
attr(grid_placement(Row,Col,R,O),class,("w-100";"h-100";"p-0";"m-0";"pe-none")) :- elem(grid_placement(Row,Col,R,O),container,_).

% Role-specific image.
elem(grid_placement_image(Row,Col,R,O),canvas,grid_placement(Row,Col,R,O)) :- elem(grid_placement(Row,Col,R,O),container,_),image(O,R,I),I=#min{Path:image(O,R,Path)}.
attr(grid_placement_image(Row,Col,R,O),image,I) :- elem(grid_placement_image(Row,Col,R,O),canvas,_),image(O,R,I),I=#min{Path:image(O,R,Path)}.
attr(grid_placement_image(Row,Col,R,O),width,30) :- elem(grid_placement_image(Row,Col,R,O),canvas,_).
attr(grid_placement_image(Row,Col,R,O),height,30) :- elem(grid_placement_image(Row,Col,R,O),canvas,_).
attr(grid_placement_image(Row,Col,R,O),class,("w-100";"h-100";"pe-none")) :- elem(grid_placement_image(Row,Col,R,O),canvas,_).

% Fallback if the image is missing.
elem(grid_placement_fallback(Row,Col,R,O),label,grid_placement(Row,Col,R,O)) :- elem(grid_placement(Row,Col,R,O),container,_),not image(O,R,_).
attr(grid_placement_fallback(Row,Col,R,O),label,@concat("",O)) :- elem(grid_placement_fallback(Row,Col,R,O),label,_).
attr(grid_placement_fallback(Row,Col,R,O),class,("small";"text-danger";"text-center";"pe-none")) :- elem(grid_placement_fallback(Row,Col,R,O),label,_).