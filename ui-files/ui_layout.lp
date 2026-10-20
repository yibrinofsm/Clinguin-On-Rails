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
attr(node_box(Row,Col),"gridTemplateColumns","minmax(0,1fr)") :-node((Row,Col)).
attr(node_box(Row,Col),"gridTemplateRows","minmax(0,1fr)") :-node((Row,Col)).
attr(node_box(Row,Col),"isolation","isolate") :-node((Row,Col)).
% ============================================================
% PLACE OBJECT
% ============================================================
when(node_box(Row,Col),click,call,add_atom(position((Row,Col),R,O))) :-valid_object_placement(Row,Col,O,T,R).
% ============================================================
% SUCCESS NOTIFICATION
% ============================================================
notification_event( node_box(Row,Col),click,success,"Object Placed",@concat("Object ",O," of type ",T," was placed at node (",Row,",",Col,") in the grid." )) :-valid_object_placement(Row,Col,O,T,R).
% ============================================================
% REJECTED PLACEMENT NOTIFICATION
% ============================================================
notification_event(node_box(Row,Col),click,error,"Placement Rejected",@concat("Cannot place object ",O," of type ",T," at node (",Row,",",Col,"). The placement violates a declared constraint.")) :-node((Row,Col)),object_selected_for_placement(O,T,R),object_placement_rejected((Row,Col),O,T,R).
    
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

% Each grid cell has its own stacking context.
attr(node_box(Row,Col),"isolation","isolate") :-node((Row,Col)).

% Create one container for each placed object.
elem(grid_placement(Row,Col,R,O),container,node_box(Row,Col)) :-node((Row,Col)),position((Row,Col),R,O),object(O,_).


% Objects in the same cell overlap.
attr(grid_placement(Row,Col,R,O),grid_row,0) :-elem(grid_placement(Row,Col,R,O),container,_).
attr(grid_placement(Row,Col,R,O),grid_column,0) :-elem(grid_placement(Row,Col,R,O),container,_).


% Read the object's type and use its declared drawing drawing_layer.
% An undeclared type uses level 0.
attr(grid_placement(Row,Col,R,O),"z-index",Level) :-elem(grid_placement(Row,Col,R,O),container,_),Level = #max {0;L,T : object(O,T), drawing_layer(T,L)}.


% Keep object labels above every object image in the cell.
attr(grid_labels(Row,Col),"z-index",Highest+1) :-elem(grid_labels(Row,Col),container,_),Highest = #max {0;Level,R,O :attr(grid_placement(Row,Col,R,O),"z-index",Level)}.

% Let each placement fit within its cell.
attr(grid_placement(Row,Col,R,O),"min-width","0") :-elem(grid_placement(Row,Col,R,O),container,_).
attr(grid_placement(Row,Col,R,O),"min-height","0") :-elem(grid_placement(Row,Col,R,O),container,_).
attr(grid_placement(Row,Col,R,O),class,"overflow-hidden") :-elem(grid_placement(Row,Col,R,O),container,_).

% Generic background styling for any object.
attr(grid_placement(Row,Col,R,O),background_color,Color) :-elem(grid_placement(Row,Col,R,O),container,_),property(O,background_color,Color).
elem(grid_placement_image(Row,Col,R,O),canvas,grid_placement(Row,Col,R,O)) :-elem(grid_placement(Row,Col,R,O),container,_),not property(O,render_mode,fill),image(O,R,I).

% Role-specific image.

elem(grid_placement_image(Row,Col,R,O),canvas,grid_placement(Row,Col,R,O)) :- elem(grid_placement(Row,Col,R,O),container,_),image(O,R,I).
attr(grid_placement_image(Row,Col,R,O),image,I) :- elem(grid_placement_image(Row,Col,R,O),canvas,_),image(O,R,I).
attr(grid_placement_image(Row,Col,R,O),width,30) :- elem(grid_placement_image(Row,Col,R,O),canvas,_).
attr(grid_placement_image(Row,Col,R,O),height,30) :- elem(grid_placement_image(Row,Col,R,O),canvas,_).
attr(grid_placement_image(Row,Col,R,O),class,("w-100";"h-100";"pe-none")) :- elem(grid_placement_image(Row,Col,R,O),canvas,_).


% Shared label drawing_layer above the images in each occupied cell.
elem(grid_labels(Row,Col),container,node_box(Row,Col)) :-elem(grid_placement(Row,Col,_,_),container,_).
attr(grid_labels(Row,Col),grid_row,0) :-elem(grid_labels(Row,Col),container,_).
attr(grid_labels(Row,Col),grid_column,0) :-elem(grid_labels(Row,Col),container,_).
attr(grid_labels(Row,Col),child_layout,flex) :-elem(grid_labels(Row,Col),container,_).
attr(grid_labels(Row,Col),flex_direction,column) :-elem(grid_labels(Row,Col),container,_).
attr(grid_labels(Row,Col),class,("d-flex";"flex-column";"justify-content-end";"w-100";"h-100";"p-0";"m-0";"pe-none";"overflow-hidden")) :-elem(grid_labels(Row,Col),container,_).
attr(grid_labels(Row,Col),"z-index","2") :-elem(grid_labels(Row,Col),container,_).
attr(grid_labels(Row,Col),"min-width","0") :-elem(grid_labels(Row,Col),container,_).
attr(grid_labels(Row,Col),"min-height","0") :-elem(grid_labels(Row,Col),container,_).

% One label per object per cell, even if it has multiple roles there.
elem(grid_object_label(Row,Col,O),label,grid_labels(Row,Col)) :-elem(grid_placement(Row,Col,_,O),container,_).
attr(grid_object_label(Row,Col,O),label,@concat("",ID)) :-elem(grid_object_label(Row,Col,O),label,_),object_display_ID(O,ID).

% Stable ordering when multiple objects share a cell.
attr(grid_object_label(Row,Col,O),order,N) :-elem(grid_object_label(Row,Col,O),label,_),N = #count {Other :elem(grid_object_label(Row,Col,Other),label,_),Other < O}.

attr(grid_object_label(Row,Col,O),class,("d-block";"w-100";"text-center";"fw-bold";"text-dark";"text-truncate";"flex-shrink-0";"pe-none";"p-0";"m-0")) :-elem(grid_object_label(Row,Col,O),label,_).
attr(grid_object_label(Row,Col,O),"font-size","8px") :-elem(grid_object_label(Row,Col,O),label,_).
attr(grid_object_label(Row,Col,O),"line-height","9px") :-elem(grid_object_label(Row,Col,O),label,_).
attr(grid_object_label(Row,Col,O),background_color,"rgba(255,255,255,0.85)") :-elem(grid_object_label(Row,Col,O),label,_).