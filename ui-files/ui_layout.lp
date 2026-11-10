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

elem(grid_setup_modal,modal,w).
attr(grid_setup_modal,title,"Create a new grid").
attr(grid_setup_modal,size,"m").
attr(grid_setup_modal,visibility,shown) :- grid_setup_required.
attr(grid_setup_modal,visibility,hidden) :- not grid_setup_required.

elem(grid_setup_body,container,grid_setup_modal).
attr(grid_setup_body,child_layout,flex).
attr(grid_setup_body,flex_direction,column).
attr(grid_setup_body,class,("gap-3";"p-2")).

% Introduction

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

% Dimension Cards.
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

% HEIGHT
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

% CREATE GRID

elem(grid_setup_generate,button,grid_setup_body).
attr(grid_setup_generate,order,4).
attr(grid_setup_generate,label,"Create grid").
attr(grid_setup_generate,icon,"fa-border-all").
attr(grid_setup_generate,class,("btn-primary";"w-100";"py-3";"fw-semibold";"rounded-3";"shadow-sm")).
when(grid_setup_generate,click,call,add_atom(nodes(_context_value(width,int,1),_context_value(height,int,1)))) :- grid_setup_required.

% ============================================================
% SIDEBAR PANEL
% ============================================================

elem(sidebar_panel,container,workspace).
attr(sidebar_panel,order,2).
attr(sidebar_panel,class,("col-12";"col-lg-3";"d-flex";"flex-column";"bg-white";"border";"rounded-3";"shadow-sm";"overflow-hidden")).

% ============================================================
% GRID PANEL
% ============================================================

elem(grid_panel,container,main_panel) :- node((_,_)).
attr(grid_panel,order,2) :- elem(grid_panel,container,main_panel).
attr(grid_panel,class,("d-flex";"flex-column";"bg-white";"border";"rounded-3";"shadow-sm";"overflow-hidden";"mw-100")) :- elem(grid_panel,container,main_panel).

% ============================================================
% GRID HEADER
% ============================================================

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
attr(grid_dimensions,label,@concat(Rows," rows × ",Cols," columns · ",N," cells")) :- elem(grid_dimensions,label,grid_header), Rows=#count{R:node((R,_))}, Cols=#count{C:node((_,C))}, N=#count{R,C:node((R,C))}.

% ============================================================
% GRID VIEWPORT
% ============================================================

elem(grid_viewport,container,grid_panel) :- elem(grid_panel,container,main_panel).
attr(grid_viewport,order,3) :- elem(grid_viewport,container,grid_panel).
attr(grid_viewport,child_layout,flex) :- elem(grid_viewport,container,grid_panel).
attr(grid_viewport,class,("w-100";"overflow-auto";"p-2";"bg-light")) :- elem(grid_viewport,container,grid_panel).

% ============================================================
% GRID SURFACE
% ============================================================

elem(grid_surface,container,grid_viewport) :- elem(grid_viewport,container,grid_panel).
attr(grid_surface,order,1) :- elem(grid_surface,container,grid_viewport).
attr(grid_surface,child_layout,grid) :- elem(grid_surface,container,grid_viewport).
attr(grid_surface,class,("d-grid";"align-self-start";"flex-shrink-0";"p-0";"m-0";"bg-white")) :- elem(grid_surface,container,grid_viewport).
attr(grid_surface,"gridTemplateColumns","max-content") :- elem(grid_surface,container,grid_viewport).
attr(grid_surface,"gridAutoRows","30px") :- elem(grid_surface,container,grid_viewport).

% ============================================================
% GRID ROW
% ============================================================

elem(grid_row(Row),container,grid_surface) :- node((Row,_)).
attr(grid_row(Row),order,Row) :- node((Row,_)).
attr(grid_row(Row),child_layout,grid) :- node((Row,_)).
attr(grid_row(Row),class,("d-grid";"p-0";"m-0")) :- node((Row,_)).
attr(grid_row(Row),grid_row,Row-R0) :- node((Row,_)), R0=#min{R:node((R,_))}.
attr(grid_row(Row),grid_column,0) :- node((Row,_)).
attr(grid_row(Row),"gridAutoColumns","30px") :- node((Row,_)).
attr(grid_row(Row),"gridTemplateRows","30px") :- node((Row,_)).

% ============================================================
% GRID NODE BOX
% ============================================================

elem(node_box(Row,Col),container,grid_row(Row)) :- node((Row,Col)).
attr(node_box(Row,Col),order,Col) :- node((Row,Col)).
attr(node_box(Row,Col),grid_row,0) :- node((Row,Col)).
attr(node_box(Row,Col),grid_column,Col-C0) :- node((Row,Col)), C0=#min{C:node((_,C))}.
attr(node_box(Row,Col),child_layout,grid) :- node((Row,Col)).
attr(node_box(Row,Col),class,("p-0";"m-0";"w-100";"h-100")) :- node((Row,Col)).
attr(node_box(Row,Col),background_color,"white") :- node((Row,Col)).
attr(node_box(Row,Col),"border-top","1px solid #0f8bf7") :- node((Row,Col)).
attr(node_box(Row,Col),"border-left","1px solid #0f8bf7") :- node((Row,Col)).
attr(node_box(Row,Col),"border-right","1px solid #0f8bf7") :- node((Row,Col)), not node((Row,Col+1)).
attr(node_box(Row,Col),"border-bottom","1px solid #0f8bf7") :- node((Row,Col)), not node((Row+1,Col)).
attr(node_box(Row,Col),"box-sizing","border-box") :- node((Row,Col)).
attr(node_box(Row,Col),"gridTemplateColumns","minmax(0,1fr)") :- node((Row,Col)).
attr(node_box(Row,Col),"gridTemplateRows","minmax(0,1fr)") :- node((Row,Col)).
attr(node_box(Row,Col),"isolation","isolate") :- node((Row,Col)).

% ============================================================
% GENERIC DIRECTED EDGE 
% ============================================================

% edge(A,B) represents a directed edge from A to B.
% The UI creates one LeaderLine per directed edge.
% The line is transparent until the source is hovered.
% The arrowhead always points toward the destination.
% This section is independent of agents, walls and tracks.


% 3. CENTER ANCHORS
elem(edge_anchor(R,C),container,node_box(R,C)) :- edge_endpoint((R,C)).
attr(edge_anchor(R,C),grid_row,0) :- edge_endpoint((R,C)).
attr(edge_anchor(R,C),grid_column,0) :- edge_endpoint((R,C)).
attr(edge_anchor(R,C),class,("p-0";"m-0";"pe-none")) :- edge_endpoint((R,C)).
attr(edge_anchor(R,C),"width","2px") :- edge_endpoint((R,C)).
attr(edge_anchor(R,C),"height","2px") :- edge_endpoint((R,C)).
attr(edge_anchor(R,C),"min-width","0") :- edge_endpoint((R,C)).
attr(edge_anchor(R,C),"min-height","0") :- edge_endpoint((R,C)).
attr(edge_anchor(R,C),"align-self","center") :- edge_endpoint((R,C)).
attr(edge_anchor(R,C),"justify-self","center") :- edge_endpoint((R,C)).
attr(edge_anchor(R,C),"pointer-events","none") :- edge_endpoint((R,C)).

% 4. CREATE DIRECTED LINE ELEMENTS
elem(grid_directed_edge(A,B),line,w) :- directed_edge(A,B).

% 5. LINE ENDPOINTS
attr(grid_directed_edge((R1,C1),(R2,C2)),start,edge_anchor(R1,C1)) :- directed_edge((R1,C1),(R2,C2)).
attr(grid_directed_edge((R1,C1),(R2,C2)),end,edge_anchor(R2,C2)) :- directed_edge((R1,C1),(R2,C2)).

% 6.  LINE STYLING
% Straight connection.
attr(grid_directed_edge(A,B),path,"straight") :- directed_edge(A,B).
% Thin line.
attr(grid_directed_edge(A,B),size,1) :- directed_edge(A,B).
% No arrowhead at the source.
attr(grid_directed_edge(A,B),startPlug,"behind") :- directed_edge(A,B).
% Arrowhead at the destination.
attr(grid_directed_edge(A,B),endPlug,"arrow1") :- directed_edge(A,B).
% Use the integer 1 instead of 0.55 because Clingo does not accept decimal numeric literals.
attr(grid_directed_edge(A,B),endPlugSize,1) :- directed_edge(A,B).
% No additional outline.
attr(grid_directed_edge(A,B),outline,false) :- directed_edge(A,B).
% No drop shadow.
attr(grid_directed_edge(A,B),dropShadow,false) :- directed_edge(A,B).

% 7. INITIAL STATE — TRANSPARENT
% Keep the line elements initialized and make both strokes and arrowheads transparent initially.
% attr(grid_directed_edge(A,B),visibility,shown) :- directed_edge(A,B).
attr(grid_directed_edge(A,B),color,"rgba(37,99,235,0)") :- directed_edge(A,B).
attr(grid_directed_edge(A,B),endPlugColor,"rgba(37,99,235,0)") :- directed_edge(A,B).

% 8. SHOW OUTGOING EDGES ON HOVER
% When hovering over source A, show every edge(A,B).
when(node_box(R1,C1),mouseenter,update,(grid_directed_edge((R1,C1),(R2,C2)),color,"#2563eb")) :- directed_edge((R1,C1),(R2,C2)).
% Show destination arrowheads.
when(node_box(R1,C1),mouseenter,update,(grid_directed_edge((R1,C1),(R2,C2)),endPlugColor,"#2563eb")) :- directed_edge((R1,C1),(R2,C2)).

% 9. HIDE OUTGOING EDGES ON MOUSE LEAVE
% Make line strokes transparent again.
when(node_box(R1,C1),mouseleave,update,(grid_directed_edge((R1,C1),(R2,C2)),color,"rgba(37,99,235,0)")) :- directed_edge((R1,C1),(R2,C2)).
% Make arrowheads transparent again.
when(node_box(R1,C1),mouseleave,update,(grid_directed_edge((R1,C1),(R2,C2)),endPlugColor,"rgba(37,99,235,0)")) :- directed_edge((R1,C1),(R2,C2)).

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

notification_event(node_box(Row,Col),click,error,"Placement Rejected",@concat("Cannot place object ",O," of type ",T," at node (",Row,",",Col,"). The placement violates a declared constraint.")) :- node((Row,Col)), object_selected_for_placement(O,T,R), object_placement_rejected((Row,Col),O,T,R).

% ============================================================
% NO GRID
% ============================================================

elem(no_grid,label,main_panel) :- not node((_,_)).
attr(no_grid,order,2) :- elem(no_grid,label,main_panel).
attr(no_grid,label,"No nodes available. Use Create grid to set the width and height.") :- elem(no_grid,label,main_panel), not node(_).
attr(no_grid,label,"No grid coordinates available. Use node((Row,Column)).") :- elem(no_grid,label,main_panel), node(_).
attr(no_grid,class,("p-5";"text-center";"text-muted")) :- elem(no_grid,label,main_panel).

elem(open_grid_setup,button,main_panel) :- grid_setup_required.
attr(open_grid_setup,order,3) :- grid_setup_required.
attr(open_grid_setup,label,"Create grid") :- grid_setup_required.
attr(open_grid_setup,class,("btn-primary";"align-self-center")) :- grid_setup_required.
when(open_grid_setup,click,update,(grid_setup_modal,visibility,shown)) :- grid_setup_required.

% ============================================================
% DISPLAY PLACED OBJECTS
% ============================================================

elem(grid_placement(Row,Col,R,O),container,node_box(Row,Col)) :- node((Row,Col)), position((Row,Col),R,O), object(O,_).

attr(grid_placement(Row,Col,R,O),grid_row,0) :- elem(grid_placement(Row,Col,R,O),container,_).
attr(grid_placement(Row,Col,R,O),grid_column,0) :- elem(grid_placement(Row,Col,R,O),container,_).
attr(grid_placement(Row,Col,R,O),class,("w-100";"h-100";"p-0";"m-0";"pe-none")) :- elem(grid_placement(Row,Col,R,O),container,_).

% Object drawing layers.
attr(grid_placement(Row,Col,R,O),"z-index",Level) :- elem(grid_placement(Row,Col,R,O),container,_), Level=#max{0;L,T:object(O,T),drawing_layer(T,L)}.

% Labels above images.
attr(grid_labels(Row,Col),"z-index",Highest+1) :- elem(grid_labels(Row,Col),container,_), Highest=#max{0;Level,R,O:attr(grid_placement(Row,Col,R,O),"z-index",Level)}.

attr(grid_placement(Row,Col,R,O),"min-width","0") :- elem(grid_placement(Row,Col,R,O),container,_).
attr(grid_placement(Row,Col,R,O),"min-height","0") :- elem(grid_placement(Row,Col,R,O),container,_).
attr(grid_placement(Row,Col,R,O),class,"overflow-hidden") :- elem(grid_placement(Row,Col,R,O),container,_).

% Generic object background.
attr(grid_placement(Row,Col,R,O),background_color,Color) :- elem(grid_placement(Row,Col,R,O),container,_), property(O,background_color,Color).

% Role-specific images.
elem(grid_placement_image(Row,Col,R,O),canvas,grid_placement(Row,Col,R,O)) :- elem(grid_placement(Row,Col,R,O),container,_), image(O,R,I).
attr(grid_placement_image(Row,Col,R,O),image,I) :- elem(grid_placement_image(Row,Col,R,O),canvas,_), image(O,R,I).
attr(grid_placement_image(Row,Col,R,O),width,30) :- elem(grid_placement_image(Row,Col,R,O),canvas,_).
attr(grid_placement_image(Row,Col,R,O),height,30) :- elem(grid_placement_image(Row,Col,R,O),canvas,_).
attr(grid_placement_image(Row,Col,R,O),class,("w-100";"h-100";"pe-none")) :- elem(grid_placement_image(Row,Col,R,O),canvas,_).

% ============================================================
% SHARED OBJECT LABELS
% ============================================================

elem(grid_labels(Row,Col),container,node_box(Row,Col)) :- elem(grid_placement(Row,Col,_,_),container,_).
attr(grid_labels(Row,Col),grid_row,0) :- elem(grid_labels(Row,Col),container,_).
attr(grid_labels(Row,Col),grid_column,0) :- elem(grid_labels(Row,Col),container,_).
attr(grid_labels(Row,Col),child_layout,flex) :- elem(grid_labels(Row,Col),container,_).
attr(grid_labels(Row,Col),flex_direction,column) :- elem(grid_labels(Row,Col),container,_).
attr(grid_labels(Row,Col),class,("d-flex";"flex-column";"justify-content-end";"w-100";"h-100";"p-0";"m-0";"pe-none";"overflow-hidden")) :- elem(grid_labels(Row,Col),container,_).
attr(grid_labels(Row,Col),"min-width","0") :- elem(grid_labels(Row,Col),container,_).
attr(grid_labels(Row,Col),"min-height","0") :- elem(grid_labels(Row,Col),container,_).

% One label per object per cell.
elem(grid_object_label(Row,Col,O),label,grid_labels(Row,Col)) :- elem(grid_placement(Row,Col,_,O),container,_).
attr(grid_object_label(Row,Col,O),label,@concat("",ID)) :- elem(grid_object_label(Row,Col,O),label,_), object_display_ID(O,ID).

% Stable label ordering.
attr(grid_object_label(Row,Col,O),order,N) :- elem(grid_object_label(Row,Col,O),label,_), N=#count{Other:elem(grid_object_label(Row,Col,Other),label,_), Other<O}.

attr(grid_object_label(Row,Col,O),class,("d-block";"w-100";"text-center";"fw-bold";"text-dark";"text-truncate";"flex-shrink-0";"pe-none";"p-0";"m-0")) :- elem(grid_object_label(Row,Col,O),label,_).
attr(grid_object_label(Row,Col,O),"font-size","8px") :- elem(grid_object_label(Row,Col,O),label,_).
attr(grid_object_label(Row,Col,O),"line-height","9px") :- elem(grid_object_label(Row,Col,O),label,_).
attr(grid_object_label(Row,Col,O),background_color,"rgba(255,255,255,0.85)") :- elem(grid_object_label(Row,Col,O),label,_), not grid_selected_object(O).

% ============================================================
% HIGHLIGHT ALL PLACEMENTS OF THE SELECTED OBJECT
% ============================================================

elem(grid_selection(Row,Col),container,node_box(Row,Col)) :- grid_selected_node(Row,Col).
attr(grid_selection(Row,Col),grid_row,0) :- grid_selected_node(Row,Col).
attr(grid_selection(Row,Col),grid_column,0) :- grid_selected_node(Row,Col).
attr(grid_selection(Row,Col),class,("w-100";"h-100";"p-0";"m-0";"pe-none")) :- grid_selected_node(Row,Col).
attr(grid_selection(Row,Col),"min-width","0") :- grid_selected_node(Row,Col).
attr(grid_selection(Row,Col),"min-height","0") :- grid_selected_node(Row,Col).
attr(grid_selection(Row,Col),"pointer-events","none") :- grid_selected_node(Row,Col).

% Amber selection ring.
attr(grid_selection(Row,Col),"box-shadow","inset 0 0 0 3px #f59e0b") :- grid_selected_node(Row,Col).

% Selected-object overlay above images.
attr(grid_selection(Row,Col),"z-index",Highest+2) :- grid_selected_node(Row,Col), Highest=#max{0;Level,Role,Obj:attr(grid_placement(Row,Col,Role,Obj),"z-index",Level)}.

% Selected object labels.
attr(grid_object_label(Row,Col,O),background_color,"#f59e0b") :- elem(grid_object_label(Row,Col,O),label,_), grid_selected_object(O).
