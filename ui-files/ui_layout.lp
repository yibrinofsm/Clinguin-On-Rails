% ============================================================
% ui_layout.lp
% ============================================================

% ============================================================
% WORKSPACE
% ============================================================

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

% ============================================================
% ui_grid_setup
% ============================================================


% Modal.
elem(grid_setup_modal,modal,w).
attr(grid_setup_modal,title,"Create a new grid").
attr(grid_setup_modal,size,"m").
attr(grid_setup_modal,visibility,shown) :- grid_setup_required.
attr(grid_setup_modal,visibility,hidden) :- not grid_setup_required.

elem(grid_setup_body,container,grid_setup_modal).
attr(grid_setup_body,child_layout,flex).
attr(grid_setup_body,flex_direction,column).
attr(grid_setup_body,class,("gap-3";"p-2")).

% Introduction.
elem(grid_setup_intro,container,grid_setup_body).
attr(grid_setup_intro,order,1).
attr(grid_setup_intro,class,("d-flex";"flex-column";"gap-1";"p-3";"rounded-3")).
attr(grid_setup_intro,background_color,"#eff6ff").
attr(grid_setup_intro,"border","1px solid #dbeafe").

elem(grid_setup_heading,label,grid_setup_intro).
attr(grid_setup_heading,order,1).
attr(grid_setup_heading,label,"Build your workspace").
attr(grid_setup_heading,class,("text-start";"fw-bold";"text-primary")).

elem(grid_setup_description,label,grid_setup_intro).
attr(grid_setup_description,order,2).
attr(grid_setup_description,label,"Choose a positive whole number for each dimension.").
attr(grid_setup_description,class,("text-start";"small";"text-secondary")).

% Dimension cards.
elem(grid_setup_dimensions,container,grid_setup_body).
attr(grid_setup_dimensions,order,2).
attr(grid_setup_dimensions,child_layout,flex).
attr(grid_setup_dimensions,flex_direction,row).
attr(grid_setup_dimensions,class,("flex-wrap";"gap-3")).

% Width
elem(grid_setup_width_group,container,grid_setup_dimensions).
attr(grid_setup_width_group,order,1).
attr(grid_setup_width_group,class,("d-flex";"flex-column";"gap-2";"p-3";"border";"rounded-3";"bg-white")).
attr(grid_setup_width_group,"flex","1 1 170px").

elem(grid_setup_width_label,label,grid_setup_width_group).
attr(grid_setup_width_label,order,1).
attr(grid_setup_width_label,label,"Width").
attr(grid_setup_width_label,class,("text-start";"fw-semibold")).

elem(grid_setup_width_input,textfield,grid_setup_width_group).
attr(grid_setup_width_input,order,2).
attr(grid_setup_width_input,input_type,number).
attr(grid_setup_width_input,positive_integer,true).
attr(grid_setup_width_input,class,("form-control-lg";"rounded-3";"fw-semibold")).
when(grid_setup_width_input,input,context,(width,_value)) :- grid_setup_required.

elem(grid_setup_width_hint,label,grid_setup_width_group).
attr(grid_setup_width_hint,order,3).
attr(grid_setup_width_hint,label,"Columns · horizontal · minimum 1").
attr(grid_setup_width_hint,class,("text-start";"small";"text-secondary")).

% Height.
elem(grid_setup_height_group,container,grid_setup_dimensions).
attr(grid_setup_height_group,order,2).
attr(grid_setup_height_group,class,("d-flex";"flex-column";"gap-2";"p-3";"border";"rounded-3";"bg-white")).
attr(grid_setup_height_group,"flex","1 1 170px").

elem(grid_setup_height_label,label,grid_setup_height_group).
attr(grid_setup_height_label,order,1).
attr(grid_setup_height_label,label,"Height").
attr(grid_setup_height_label,class,("text-start";"fw-semibold")).

elem(grid_setup_height_input,textfield,grid_setup_height_group).
attr(grid_setup_height_input,order,2).
attr(grid_setup_height_input,input_type,number).
attr(grid_setup_height_input,positive_integer,true).
attr(grid_setup_height_input,class,("form-control-lg";"rounded-3";"fw-semibold")).
when(grid_setup_height_input,input,context,(height,_value)) :- grid_setup_required.

elem(grid_setup_height_hint,label,grid_setup_height_group).
attr(grid_setup_height_hint,order,3).
attr(grid_setup_height_hint,label,"Rows · vertical · minimum 1").
attr(grid_setup_height_hint,class,("text-start";"small";"text-secondary")).

elem(grid_setup_origin,label,grid_setup_body).
attr(grid_setup_origin,order,3).
attr(grid_setup_origin,label,"First node: (0, 0)").
attr(grid_setup_origin,class,("text-start";"small";"text-secondary";"px-3";"py-2";"bg-light";"rounded-3")).

% Save .
elem(grid_setup_generate,button,grid_setup_body).
attr(grid_setup_generate,order,4).
attr(grid_setup_generate,label,"Create grid").
attr(grid_setup_generate,icon,"fa-border-all").
attr(grid_setup_generate,class,("btn-primary";"w-100";"py-3";"fw-semibold";"rounded-3";"shadow-sm")).
when(grid_setup_generate,click,call,add_atom(nodes(_context_value(width,int,1),_context_value(height,int,1)))) :- grid_setup_required.


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
attr(node_box(Row,Col),"border-right","1px solid #0f8bf7") :- node((Row,Col)),not node((Row,Col+1)).
attr(node_box(Row,Col),"border-bottom","1px solid #0f8bf7") :- node((Row,Col)),not node((Row+1,Col)).
attr(node_box(Row,Col),"box-sizing","border-box") :- node((Row,Col)).
attr(node_box(Row,Col),"gridTemplateColumns","minmax(0,1fr)") :- node((Row,Col)).
attr(node_box(Row,Col),"gridTemplateRows","minmax(0,1fr)") :- node((Row,Col)).
attr(node_box(Row,Col),"isolation","isolate") :- node((Row,Col)).

% ============================================================
% PLACE OBJECT
% ============================================================

when(node_box(Row,Col),click,call,add_atom(position((Row,Col),R,O))) :- valid_object_placement(Row,Col,O,T,R).

% ============================================================
% SUCCESS NOTIFICATION
% ============================================================

notification_event(node_box(Row,Col),click,success,"Object Placed",@concat("Object ",O," of type ",T," was placed at node (",Row,",",Col,") in the grid.")) :- valid_object_placement(Row,Col,O,T,R).

% ============================================================
% REJECTED PLACEMENT NOTIFICATION
% ============================================================

notification_event(node_box(Row,Col),click,error,"Placement Rejected",@concat("Cannot place object ",O," of type ",T," at node (",Row,",",Col,"). The placement violates a declared constraint.")) :- node((Row,Col)),object_selected_for_placement(O,T,R),object_placement_rejected((Row,Col),O,T,R).

% NO GRID
elem(no_grid,label,main_panel) :- not node((_,_)).
attr(no_grid,order,2) :- elem(no_grid,label,main_panel).
attr(no_grid,label,"No nodes available. Use Create grid to set the width and height.") :- elem(no_grid,label,main_panel),not node(_).
attr(no_grid,label,"No grid coordinates available. Use node((Row,Column)).") :- elem(no_grid,label,main_panel),node(_).
attr(no_grid,class,("p-5";"text-center";"text-muted")) :- elem(no_grid,label,main_panel).

% Reopen the setup modal if it was dismissed before generating nodes.
elem(open_grid_setup,button,main_panel) :- grid_setup_required.
attr(open_grid_setup,order,3) :- grid_setup_required.
attr(open_grid_setup,label,"Create grid") :- grid_setup_required.
attr(open_grid_setup,class,("btn-primary";"align-self-center")) :- grid_setup_required.
when(open_grid_setup,click,update,(grid_setup_modal,visibility,shown)) :- grid_setup_required.

% ============================================================
% DISPLAY PLACED OBJECTS
% ============================================================

% Container for each placed object.
elem(grid_placement(Row,Col,R,O),container,node_box(Row,Col)) :- node((Row,Col)),position((Row,Col),R,O),object(O,_).
attr(grid_placement(Row,Col,R,O),grid_row,0) :- elem(grid_placement(Row,Col,R,O),container,_).
attr(grid_placement(Row,Col,R,O),grid_column,0) :- elem(grid_placement(Row,Col,R,O),container,_).
attr(grid_placement(Row,Col,R,O),class,("w-100";"h-100";"p-0";"m-0";"pe-none")) :- elem(grid_placement(Row,Col,R,O),container,_).

% Each grid cell has its own stacking context.
attr(node_box(Row,Col),"isolation","isolate") :- node((Row,Col)).

% Create one container for each placed object.
elem(grid_placement(Row,Col,R,O),container,node_box(Row,Col)) :- node((Row,Col)),position((Row,Col),R,O),object(O,_).

% Objects in the same cell overlap.
attr(grid_placement(Row,Col,R,O),grid_row,0) :- elem(grid_placement(Row,Col,R,O),container,_).
attr(grid_placement(Row,Col,R,O),grid_column,0) :- elem(grid_placement(Row,Col,R,O),container,_).

% Read the object's type and use its declared drawing_layer.
% An undeclared type uses level 0.
attr(grid_placement(Row,Col,R,O),"z-index",Level) :- elem(grid_placement(Row,Col,R,O),container,_),Level=#max{0;L,T:object(O,T),drawing_layer(T,L)}.

% Keep object labels above every object image in the cell.
attr(grid_labels(Row,Col),"z-index",Highest+1) :- elem(grid_labels(Row,Col),container,_),Highest=#max{0;Level,R,O:attr(grid_placement(Row,Col,R,O),"z-index",Level)}.

% Let each placement fit within its cell.
attr(grid_placement(Row,Col,R,O),"min-width","0") :- elem(grid_placement(Row,Col,R,O),container,_).
attr(grid_placement(Row,Col,R,O),"min-height","0") :- elem(grid_placement(Row,Col,R,O),container,_).
attr(grid_placement(Row,Col,R,O),class,"overflow-hidden") :- elem(grid_placement(Row,Col,R,O),container,_).

% Generic background styling for any object.
attr(grid_placement(Row,Col,R,O),background_color,Color) :- elem(grid_placement(Row,Col,R,O),container,_),property(O,background_color,Color).
elem(grid_placement_image(Row,Col,R,O),canvas,grid_placement(Row,Col,R,O)) :- elem(grid_placement(Row,Col,R,O),container,_),not property(O,render_mode,fill),image(O,R,I).

% Role-specific image.
elem(grid_placement_image(Row,Col,R,O),canvas,grid_placement(Row,Col,R,O)) :- elem(grid_placement(Row,Col,R,O),container,_),image(O,R,I).
attr(grid_placement_image(Row,Col,R,O),image,I) :- elem(grid_placement_image(Row,Col,R,O),canvas,_),image(O,R,I).
attr(grid_placement_image(Row,Col,R,O),width,30) :- elem(grid_placement_image(Row,Col,R,O),canvas,_).
attr(grid_placement_image(Row,Col,R,O),height,30) :- elem(grid_placement_image(Row,Col,R,O),canvas,_).
attr(grid_placement_image(Row,Col,R,O),class,("w-100";"h-100";"pe-none")) :- elem(grid_placement_image(Row,Col,R,O),canvas,_).

% Shared label drawing_layer above the images in each occupied cell.
elem(grid_labels(Row,Col),container,node_box(Row,Col)) :- elem(grid_placement(Row,Col,_,_),container,_).
attr(grid_labels(Row,Col),grid_row,0) :- elem(grid_labels(Row,Col),container,_).
attr(grid_labels(Row,Col),grid_column,0) :- elem(grid_labels(Row,Col),container,_).
attr(grid_labels(Row,Col),child_layout,flex) :- elem(grid_labels(Row,Col),container,_).
attr(grid_labels(Row,Col),flex_direction,column) :- elem(grid_labels(Row,Col),container,_).
attr(grid_labels(Row,Col),class,("d-flex";"flex-column";"justify-content-end";"w-100";"h-100";"p-0";"m-0";"pe-none";"overflow-hidden")) :- elem(grid_labels(Row,Col),container,_).
attr(grid_labels(Row,Col),"z-index","2") :- elem(grid_labels(Row,Col),container,_).
attr(grid_labels(Row,Col),"min-width","0") :- elem(grid_labels(Row,Col),container,_).
attr(grid_labels(Row,Col),"min-height","0") :- elem(grid_labels(Row,Col),container,_).

% One label per object per cell, even if it has multiple roles there.
elem(grid_object_label(Row,Col,O),label,grid_labels(Row,Col)) :- elem(grid_placement(Row,Col,_,O),container,_).
attr(grid_object_label(Row,Col,O),label,@concat("",ID)) :- elem(grid_object_label(Row,Col,O),label,_),object_display_ID(O,ID).

% Stable ordering when multiple objects share a cell.
attr(grid_object_label(Row,Col,O),order,N) :- elem(grid_object_label(Row,Col,O),label,_),N=#count{Other:elem(grid_object_label(Row,Col,Other),label,_),Other<O}.

attr(grid_object_label(Row,Col,O),class,("d-block";"w-100";"text-center";"fw-bold";"text-dark";"text-truncate";"flex-shrink-0";"pe-none";"p-0";"m-0")) :- elem(grid_object_label(Row,Col,O),label,_).
attr(grid_object_label(Row,Col,O),"font-size","8px") :- elem(grid_object_label(Row,Col,O),label,_).
attr(grid_object_label(Row,Col,O),"line-height","9px") :- elem(grid_object_label(Row,Col,O),label,_).
attr(grid_object_label(Row,Col,O),background_color,"rgba(255,255,255,0.85)") :- elem(grid_object_label(Row,Col,O),label,_).