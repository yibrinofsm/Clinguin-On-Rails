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

%  Objects 

elem(summary_tile(0),container,summary).
attr(summary_tile(0),grid_column,1).
attr(summary_tile(0),class,("bg-light";"border";"rounded-2";"px-2";"py-2")).

% Summary Objects

elem(summary_objects,label,summary_tile(0)).
attr(summary_objects,order,1).
attr(summary_objects,label,@concat("Objects · ",N)) :- N=#count{O:object(O,_)}.
attr(summary_objects,class,("small";"fw-bold";"text-secondary")).

%  Properties 

elem(summary_tile(1),container,summary).
attr(summary_tile(1),grid_column,2).
attr(summary_tile(1),class,("bg-light";"border";"rounded-2";"px-2";"py-2")).

% Summary Properties

elem(summary_properties,label,summary_tile(1)).
attr(summary_properties,order,1).
attr(summary_properties,label,@concat("Properties · ",N)) :- N=#count{O,K,V:object(O,_),property(O,K,V)}.
attr(summary_properties,class,("small";"fw-bold";"text-secondary")).

% Summary Positions Tile

elem(summary_tile(2),container,summary).
attr(summary_tile(2),grid_column,1).
attr(summary_tile(2),class,("bg-light";"border";"rounded-2";"px-2";"py-2")).

% Summary Positions

elem(summary_positions,label,summary_tile(2)).
attr(summary_positions,order,1).
aattr(summary_positions,class,("small";"fw-bold";"text-secondary")).
attr(summary_positions,label,@concat("Positions · ",N)) :- N=#count{Node,R,O:elem(placement(Node,R,O),container,_)}.

% Summary Edits Tile

elem(summary_tile(3),container,summary).
attr(summary_tile(3),grid_column,2).
attr(summary_tile(3),class,("bg-light";"border";"rounded-2";"px-2";"py-2")).

% Summary Edits

elem(summary_edits,label,summary_tile(3)).
attr(summary_edits,order,1).
attr(summary_edits,label,@concat("Edits · ",N)) :- A=#count{X:_clinguin_atom(X)},B=#count{M,O,T:_clinguin_atom(request(M,O,T))},N=A-B.
attr(summary_edits,class,("small";"fw-bold";"text-secondary")).

elem(summary_tile(4),container,summary).
attr(summary_tile(4),grid_column,1).
attr(summary_tile(4),class,("bg-light";"border";"rounded-2";"px-2";"py-2")).

% Nodes
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
when(add_object,click,context,(dialog,form(object_create))).
when(add_object,click,update,(dialog(form(object_create)),visibility,shown)).
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
attr(type_title(T),label,@concat(T," · ",N," objects")) :- object(_,T),N=#count{O:object(O,T)}.
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
attr(object_card(O,T),background_color,"white") :- object(O,T),not _clinguin_context(selected_object,O).
attr(object_card(O,T),background_color,"#e9ecef") :- object(O,T),_clinguin_context(selected_object,O).
attr(object_card(O,T),background_color,"#fff3cd") :- object(O,T),_clinguin_context(inspected_object,O),_clinguin_context(inspect_open,true).
attr(object_card(O,T),class,("border-warning";"border-2";"shadow-sm")) :- object(O,T),_clinguin_context(inspected_object,O),_clinguin_context(inspect_open,true).
attr(object_card(O,T),class,("border-primary";"border-2";"shadow-sm")) :- object(O,T),_clinguin_context(selected_object,O),not issue(O,error,_,_).
attr(object_card(O,T),class,"border-danger") :- object(O,T),issue(O,error,_,_).
attr(object_card(O,T),on_hover,true) :- object(O,T),not _clinguin_context(selected_object,O).
attr(object_card(O,T),on_hover_background_color,"#e9ecef") :- object(O,T),not _clinguin_context(selected_object,O).

% Object Preview 

elem(object_preview(O,T),container,object_card(O,T)) :- elem(object_media(O,T),canvas,_).
attr(object_preview(O,T),order,1) :- elem(object_preview(O,T),container,_).
attr(object_preview(O,T),width,40) :- elem(object_media(O,T),canvas,_).
attr(object_preview(O,T),height,40) :- elem(object_media(O,T),canvas,_).
attr(object_preview(O,T),class,("d-flex";"align-items-center";"justify-content-center";"flex-shrink-0";"p-0";"m-0";"overflow-hidden")) :- elem(object_preview(O,T),container,_).

% Object Preview

elem(object_media(O,T),canvas,object_preview(O,T)) :- object(O,T),image(O,R,I).
attr(object_media(O,T),order,1) :- elem(object_media(O,T),canvas,_).
attr(object_media(O,T),image,I) :- object(O,T),image(O,R,I).
attr(object_media(O,T),width,40) :- elem(object_media(O,T),canvas,_).
attr(object_media(O,T),class,"flex-shrink-0") :- elem(object_media(O,T),canvas,_).

% Object Information 

elem(object_info(O,T),container,object_card(O,T)) :- object(O,T).
attr(object_info(O,T),order,2) :- object(O,T).
attr(object_info(O,T),class,("d-flex";"flex-column";"gap-1";"flex-grow-1";"mw-100")) :- object(O,T).

% Object Identifier

elem(object_body(O,T),label,object_info(O,T)) :- object(O,T).
attr(object_body(O,T),order,1) :- object(O,T).
attr(object_body(O,T),label,@concat("",O)) :- object(O,T).
attr(object_body(O,T),class,("small";"fw-bold";"text-dark")) :- object(O,T).

% Object Status

elem(object_state(O,T),label,object_info(O,T)) :- object(O,T).
attr(object_state(O,T),order,2) :- object(O,T).
attr(object_state(O,T),label,"Needs correction") :- object(O,T),issue(O,error,_,_).
attr(object_state(O,T),label,"Incomplete") :- object(O,T),not issue(O,error,_,_),issue(O,warning,_,_).
attr(object_state(O,T),label,"Ready") :- object(O,T),not issue(O,error,_,_),not issue(O,warning,_,_).
attr(object_state(O,T),class,("small";"fw-bold")) :- object(O,T).
attr(object_state(O,T),class,"text-danger") :- object(O,T),issue(O,error,_,_).
attr(object_state(O,T),class,"text-warning") :- object(O,T),not issue(O,error,_,_),issue(O,warning,_,_).
attr(object_state(O,T),class,"text-success") :- object(O,T),not issue(O,error,_,_),not issue(O,warning,_,_).

% Object Action Buttons

elem(object_actions(O,T),container,object_card(O,T)) :- object(O,T).
attr(object_actions(O,T),order,3) :- object(O,T).
attr(object_actions(O,T),flex_direction,row) :- object(O,T).
attr(object_actions(O,T),class,("d-flex";"flex-row";"flex-wrap";"align-items-center";"gap-1")) :- object(O,T).

% Select Object Button

elem(object_select(O,T),button,object_actions(O,T)) :- object(O,T).
attr(object_select(O,T),order,1) :- object(O,T).
attr(object_select(O,T),label,"Select") :- object(O,T),not _clinguin_context(selected_object,O).
attr(object_select(O,T),label,"Selected") :- object(O,T),_clinguin_context(selected_object,O).
attr(object_select(O,T),class,"btn-outline-primary") :- object(O,T),not _clinguin_context(selected_object,O).
attr(object_select(O,T),class,"btn-primary") :- object(O,T),_clinguin_context(selected_object,O).

% Object Selection Events
when(object_select(O,T),click,context,(selected_object,O)) :- object(O,T),not issue(O,error,_,_),not issue(O,warning,property(_),_).% when(object_select(O,T),click,context,(inspector_open,false)) :- object(O,T),not issue(O,error,_,_),not issue(O,warning,property(_),_).% when(object_select(O,T),click,context,(dialog,none)) :- object(O,T),not issue(O,error,_,_),not issue(O,warning,property(_),_).
when(object_select(O,T),click,call,()) :- object(O,T),not issue(O,error,_,_),not issue(O,warning,property(_),_).

when(object_select(O,T),click,context,(placement_role,R)) :- object(O,T),not issue(O,error,_,_),not issue(O,warning,property(_),_),role(O,R).

% Select opens the inspector when configuration is required before placement.

when(object_select(O,T),click,context,(selected_object,O)) :- object(O,T),issue(O,warning,property(_),_).
when(object_select(O,T),click,context,(inspector_open,true)) :- when(object_select(O,T),click,context,(selected_object,O)),object(O,T),issue(O,error,_,_).
when(object_select(O,T),click,context,(inspector_open,true)) :- when(object_select(O,T),click,context,(selected_object,O)),object(O,T),issue(O,warning,property(_),_).
% when(object_select(O,T),click,context,(dialog,none)) :-object(O,T), when(variables,click,context,(inspector_open,true)).
when(object_select(O,T),click,call,()) :-object(O,T), when(object_select(O,T),click,context,(inspector_open,true)).

% Inspect Object Button

elem(object_inspect(O,T),button,object_actions(O,T)) :- object(O,T).
attr(object_inspect(O,T),order,2) :- object(O,T).
attr(object_inspect(O,T),label,"Inspect") :- object(O,T),not _clinguin_context(inspected_object,O),not _clinguin_context(inspect_open,true).
attr(object_inspect(O,T),class,"btn-outline-primary") :- object(O,T),not _clinguin_context(inspected_object,O),not _clinguin_context(inspect_open,true).

attr(object_inspect(O,T),label,"Under Inspection"):-object(O,T),_clinguin_context(inspected_object,O),_clinguin_context(inspect_open,true).
attr(object_inspect(O,T),class,"btn-primary"):-object(O,T),_clinguin_context(inspected_object,O),_clinguin_context(inspect_open,true).
when(object_inspect(O,T),click,context,(inspected_object,O)) :- object(O,T).
when(object_inspect(O,T),click,context,(inspect_open,true)):-object(O,T).
when(object_inspect(O,T),click,call,()) :- object(O,T).

% Delete Object Button

elem(object_delete(O,T),button,object_actions(O,T)) :- object(O,T),_clinguin_atom(object(O,T)).
attr(object_delete(O,T),order,3) :- elem(object_delete(O,T),button,_).
attr(object_delete(O,T),label,"Delete") :- elem(object_delete(O,T),button,_).
attr(object_delete(O,T),class,"btn-outline-danger") :- elem(object_delete(O,T),button,_).
when(object_delete(O,T),click,context,(delete_object,O)) :- elem(object_delete(O,T),button,_).

% Catalogue Footer

elem(footer_catalogue,label,sidebar_panel).
attr(footer_catalogue,order,4).
attr(footer_catalogue,label,"Inspect opens object details. Selection stays active while placing.").
attr(footer_catalogue,class,("small";"text-secondary";"bg-light";"border-top";"px-3";"py-2")).

% Inspector Dialog

elem(dialog(inspector),modal,w) :- object(O,_),_clinguin_context(inspected_object,O),_clinguin_context(inspect_open,true).
attr(dialog(inspector),visibility,shown) :- object(O,_),_clinguin_context(inspected_object,O),_clinguin_context(inspect_open,true),not elem(commit(_,_,_),container,w).
attr(dialog(inspector),title,@concat("Object inspector · ",O)) :- object(O,_),_clinguin_context(inspected_object,O),_clinguin_context(inspect_open,true).

% Content

elem(inspector_content,container,dialog_sheet(inspector)) :- object(O,_),_clinguin_context(inspected_object,O),_clinguin_context(inspect_open,true).
attr(inspector_content,class,("d-flex";"flex-column";"gap-3";"p-4";"overflow-auto")) :- object(O,_),_clinguin_context(inspected_object,O),_clinguin_context(inspect_open,true).
attr(inspector_content,class,"overflow-auto") :- elem(inspector_content,container,_).

% Inspector Object Identity

elem(inspector_identity,label,inspector_content) :- object(O,_),_clinguin_context(inspected_object,O),_clinguin_context(inspect_open,true).
attr(inspector_identity,order,1) :- elem(inspector_identity,label,_).
attr(inspector_identity,label,@concat("object(",O,", ",T,")")) :- object(O,T),_clinguin_context(inspector_open,true).
attr(inspector_identity,class,("font-monospace";"fw-bold";"text-primary")) :-object(O,T),_clinguin_context(inspector_open,true).

% Inspector Object Status

elem(inspector_status,label,inspector_content) :- object(O,_),_clinguin_context(inspected_object,O),_clinguin_context(inspect_open,true).
attr(inspector_status,order,3) :- elem(inspector_status,label,_).
attr(inspector_status,label,"Needs correction") :- object(O,_),_clinguin_context(inspected_object,O),_clinguin_context(inspect_open,true),issue(O,error,_,_).
attr(inspector_status,class,("fw-bold";"text-danger")) :- object(O,_),_clinguin_context(inspected_object,O),_clinguin_context(inspect_open,true),issue(O,error,_,_).
attr(inspector_status,label,"Incomplete — review the warnings below") :- object(O,_),_clinguin_context(inspected_object,O),_clinguin_context(inspect_open,true),not issue(O,error,_,_),issue(O,warning,_,_).
attr(inspector_status,class,("fw-bold";"text-warning")) :- object(O,_),_clinguin_context(inspected_object,O),_clinguin_context(inspect_open,true),not issue(O,error,_,_),issue(O,warning,_,_).
attr(inspector_status,label,"Complete") :- object(O,_),_clinguin_context(inspected_object,O),_clinguin_context(inspect_open,true),not issue(O,_,_,_),0<#count{property,K:property_schema(O,K,_,true);position,R:role(O,R,_,Min,_),Min>0}.
attr(inspector_status,label,"Ready — no declared requirements") :- object(O,_),_clinguin_context(inspected_object,O),_clinguin_context(inspect_open,true),not issue(O,_,_,_),0=#count{property,K:property_schema(O,K,_,true);position,R:role(O,R,_,Min,_),Min>0}.

% Required Property Count

elem(required_properties,label,inspector_content) :- object(O,_),_clinguin_context(inspected_object,O),_clinguin_context(inspect_open,true),property_schema(O,_,_,true).
attr(required_properties,label,@concat("Required properties · ",Have,"/",Total)) :- object(O,_),_clinguin_context(inspected_object,O),_clinguin_context(inspect_open,true),property_schema(O,_,_,true),Total=#count{K:property_schema(O,K,_,true)},Have=#count{K:property_schema(O,K,_,true),property(O,K,_)}.
attr(required_properties,order,4) :- elem(required_properties,label,_).

% Required Positions Per Role

elem(role_requirement(O,R),label,inspector_content) :- object(O,_),_clinguin_context(inspected_object,O),_clinguin_context(inspect_open,true),role(O,R,_,Min,_),Min>0.
attr(role_requirement(O,R),order,N+10) :- elem(role_requirement(O,R),label,inspector_content),N=#count{R2:elem(role_requirement(O,R2),label,inspector_content),R2<R}.
attr(role_requirement(O,R),label,@concat("Required ",R," positions · ",N,"/",Min)) :- object(O,_),_clinguin_context(inspected_object,O),_clinguin_context(inspect_open,true),role(O,R,_,Min,_),Min>0,N=#count{Node:elem(placement(Node,R,O),container,_)}.

% Inspector Validation Messages

elem(inspector_issue(O,Severity,F,M),label,inspector_content) :- object(O,_),_clinguin_context(inspected_object,O),_clinguin_context(inspect_open,true),issue(O,Severity,F,M).
attr(inspector_issue(O,S,F,M),order,N+Count+10) :- elem(inspector_issue(O,S,F,M),label,inspector_content),Count=#count{Obj,R:elem(role_requirement(Obj,R),label,inspector_content)},N=#count{O2,S2,F2,M2:elem(inspector_issue(O2,S2,F2,M2),label,inspector_content),(O2,S2,F2,M2)<(O,S,F,M)}.
attr(inspector_issue(O,Severity,F,M),label,@concat(Severity," · ",F," · ",M)) :- object(O,_),_clinguin_context(inspected_object,O),_clinguin_context(inspect_open,true),issue(O,Severity,F,M).
attr(inspector_issue(O,error,F,M),class,("small";"text-danger";"bg-light";"p-2";"rounded-3")) :- object(O,_),_clinguin_context(inspected_object,O),_clinguin_context(inspect_open,true),issue(O,error,F,M).
attr(inspector_issue(O,warning,F,M),class,("small";"text-warning";"bg-light";"p-2";"rounded-3")) :- object(O,_),_clinguin_context(inspected_object,O),_clinguin_context(inspect_open,true),issue(O,warning,F,M).

% Inspector Properties Section

elem(properties_section,container,inspector_content) :- object(O,_),_clinguin_context(inspected_object,O),_clinguin_context(inspect_open,true).
attr(properties_section,order,Count+11) :- elem(properties_section,container,inspector_content),Count=#count{Obj,R:elem(role_requirement(Obj,R),label,inspector_content);Obj,S,F,M:elem(inspector_issue(Obj,S,F,M),label,inspector_content)}.
attr(properties_section,class,("d-flex";"flex-column";"gap-2";"border";"rounded-3";"p-2")) :- object(O,_),_clinguin_context(inspected_object,O),_clinguin_context(inspect_open,true).

% Properties Section Title

elem(properties_title,label,properties_section) :- object(O,_),_clinguin_context(inspected_object,O),_clinguin_context(inspect_open,true).
attr(properties_title,order,0) :- elem(properties_title,label,_).
attr(properties_title,label,"Properties") :- object(O,_),_clinguin_context(inspected_object,O),_clinguin_context(inspect_open,true).
attr(properties_title,class,"fw-bold") :- object(O,_),_clinguin_context(inspected_object,O),_clinguin_context(inspect_open,true).

% Add Property Button

elem(property_add,button,properties_section) :- object(O,_),_clinguin_context(inspected_object,O),_clinguin_context(inspect_open,true).
attr(property_add,order,1) :- elem(property_add,button,_).
attr(property_add,label,"Add Property") :- object(O,_),_clinguin_context(inspected_object,O),_clinguin_context(inspect_open,true).
attr(property_add,class,("btn-primary";"align-self-end")) :- object(O,_),_clinguin_context(inspected_object,O),_clinguin_context(inspect_open,true).
when(property_add,click,context,(dialog,form(property_add))) :- object(O,_),_clinguin_context(inspected_object,O),_clinguin_context(inspect_open,true).
when(property_add,click,update,(dialog(form(property_add)),visibility,shown)) :- object(O,_),_clinguin_context(inspected_object,O),_clinguin_context(inspect_open,true).
when(property_add,click,update,(local_feedback,visibility,hidden)) :- object(O,_),_clinguin_context(inspected_object,O),_clinguin_context(inspect_open,true).

% Empty Properties Message

elem(properties_empty,label,properties_section) :- object(O,_),_clinguin_context(inspected_object,O),_clinguin_context(inspect_open,true),not property(O,_,_).
attr(properties_empty,order,2) :- elem(properties_empty,label,_).
attr(properties_empty,label,"No properties.") :- elem(properties_empty,label,_).

% Property Row

elem(property_row(O,K,V),container,properties_section) :- object(O,_),_clinguin_context(inspected_object,O),_clinguin_context(inspect_open,true),property(O,K,V).
attr(property_row(O,K,V),class,("d-flex";"gap-2";"align-items-center";"border";"rounded-2";"p-2")) :- object(O,_),_clinguin_context(inspected_object,O),_clinguin_context(inspect_open,true),property(O,K,V).
attr(property_row(O,K,V),order,N+10) :- object(O,_),_clinguin_context(inspected_object,O),_clinguin_context(inspect_open,true),property(O,K,V),N=#count{K2,V2:property(O,K2,V2),(K2,V2)<(K,V)}.
attr(property_row(O,K,V),flex_direction,row) :- elem(property_row(O,K,V),container,_).
attr(property_row(O,K,V),class,"flex-wrap") :- elem(property_row(O,K,V),container,_).

% Property Details

elem(property_text(O,K,V),label,property_row(O,K,V)) :- object(O,_),_clinguin_context(inspected_object,O),_clinguin_context(inspect_open,true),property(O,K,V).
attr(property_text(O,K,V),label,@concat(K," = ",V)) :- object(O,_),_clinguin_context(inspected_object,O),_clinguin_context(inspect_open,true),property(O,K,V).
attr(property_text(O,K,V),class,("font-monospace";"small";"flex-grow-1")) :- object(O,_),_clinguin_context(inspected_object,O),_clinguin_context(inspect_open,true),property(O,K,V).
attr(property_text(O,K,V),order,0) :- elem(property_text(O,K,V),label,_).

% Edit Property Button

elem(property_edit(O,K,V),button,property_row(O,K,V)) :- object(O,_),_clinguin_context(inspected_object,O),_clinguin_context(inspect_open,true),property(O,K,V),_clinguin_atom(property(O,K,V)).
attr(property_edit(O,K,V),order,1) :- elem(property_edit(O,K,V),button,_).
attr(property_edit(O,K,V),label,"Edit") :- object(O,_),_clinguin_context(inspected_object,O),_clinguin_context(inspect_open,true),property(O,K,V),_clinguin_atom(property(O,K,V)).
attr(property_edit(O,K,V),class,"btn-outline-primary") :- object(O,_),_clinguin_context(inspected_object,O),_clinguin_context(inspect_open,true),property(O,K,V),_clinguin_atom(property(O,K,V)).
when(property_edit(O,K,V),click,context,(dialog,form(property_edit))) :- object(O,_),_clinguin_context(inspected_object,O),_clinguin_context(inspect_open,true),property(O,K,V),_clinguin_atom(property(O,K,V)).
when(property_edit(O,K,V),click,update,(dialog(form(property_edit)),visibility,shown)) :- object(O,_),_clinguin_context(inspected_object,O),_clinguin_context(inspect_open,true),property(O,K,V),_clinguin_atom(property(O,K,V)).
when(property_edit(O,K,V),click,update,(local_feedback,visibility,hidden)) :- object(O,_),_clinguin_context(inspected_object,O),_clinguin_context(inspect_open,true),property(O,K,V),_clinguin_atom(property(O,K,V)).
when(property_edit(O,K,V),click,context,(edit_property_object,O)) :- object(O,_),_clinguin_context(inspected_object,O),_clinguin_context(inspect_open,true),property(O,K,V),_clinguin_atom(property(O,K,V)).
when(property_edit(O,K,V),click,context,(edit_property_key,K)) :- object(O,_),_clinguin_context(inspected_object,O),_clinguin_context(inspect_open,true),property(O,K,V),_clinguin_atom(property(O,K,V)).
when(property_edit(O,K,V),click,context,(edit_property_value,V)) :- object(O,_),_clinguin_context(inspected_object,O),_clinguin_context(inspect_open,true),property(O,K,V),_clinguin_atom(property(O,K,V)).
when(property_edit(O,K,V),click,context,(changed_property_key,K)) :- object(O,_),_clinguin_context(inspected_object,O),_clinguin_context(inspect_open,true),property(O,K,V),_clinguin_atom(property(O,K,V)).
when(property_edit(O,K,V),click,context,(changed_property_value,V)) :- object(O,_),_clinguin_context(inspected_object,O),_clinguin_context(inspect_open,true),property(O,K,V),_clinguin_atom(property(O,K,V)).

% Delete Property Button

elem(property_remove(O,K,V),button,property_row(O,K,V)) :- object(O,_),_clinguin_context(inspected_object,O),_clinguin_context(inspect_open,true),property(O,K,V),_clinguin_atom(property(O,K,V)).
attr(property_remove(O,K,V),label,"Delete") :- object(O,_),_clinguin_context(inspected_object,O),_clinguin_context(inspect_open,true),property(O,K,V),_clinguin_atom(property(O,K,V)).
attr(property_remove(O,K,V),class,"btn-outline-danger") :- object(O,_),_clinguin_context(inspected_object,O),_clinguin_context(inspect_open,true),property(O,K,V),_clinguin_atom(property(O,K,V)).
attr(property_remove(O,K,V),order,2) :- elem(property_remove(O,K,V),button,_).
when(property_remove(O,K,V),click,call,remove_atom(property(O,K,V))) :- object(O,_),_clinguin_context(inspected_object,O),_clinguin_context(inspect_open,true),property(O,K,V),_clinguin_atom(property(O,K,V)).

% Add Role Section

elem(role_section,container,inspector_content) :- object(O,_),_clinguin_context(inspected_object,O),_clinguin_context(inspect_open,true),0=#count{R:role(O,R)}.
% attr(role_section,order,Count+12) :- elem(role_section,container,inspector_content),Count=#count{Obj,R:elem(role_requirement(Obj,R),label,inspector_content);Obj,S,F,M:elem(inspector_issue(Obj,S,F,M),label,inspector_content)}.
attr(role_section,class,("d-flex";"flex-column";"gap-2";"border";"rounded-3";"p-2")) :- object(O,_),_clinguin_context(inspected_object,O),_clinguin_context(inspect_open,true),0=#count{R:role(O,R)}.

% Role Section Title

elem(role_title,label,role_section) :- object(O,_),_clinguin_context(inspected_object,O),_clinguin_context(inspect_open,true),0=#count{R:role(O,R)}.
attr(role_title,order,0) :- elem(role_title,label,_).
attr(role_title,label,"Role") :- object(O,_),_clinguin_context(inspected_object,O),_clinguin_context(inspect_open,true),0=#count{R:role(O,R)}.
attr(role_title,class,"fw-bold") :- object(O,_),_clinguin_context(inspected_object,O),_clinguin_context(inspect_open,true),0=#count{R:role(O,R)}.

% Add Role Button

elem(add_role,button,role_section) :- object(O,_),_clinguin_context(inspected_object,O),_clinguin_context(inspect_open,true),0=#count{R:role(O,R)}.
attr(add_role,order,1) :- elem(add_role,button,_).
attr(add_role,label,"Add Role") :- object(O,_),_clinguin_context(inspected_object,O),_clinguin_context(inspect_open,true),0=#count{R:role(O,R)}.
attr(add_role,class,("btn-primary";"align-self-end")) :- object(O,_),_clinguin_context(inspected_object,O),_clinguin_context(inspect_open,true),0=#count{R:role(O,R)}.

when(add_role,click,context,(dialog,form(add_role))) :- object(O,_),_clinguin_context(inspected_object,O),_clinguin_context(inspect_open,true),0=#count{R:role(O,R)}.
when(add_role,click,update,(dialog(form(add_role)),visibility,shown)) :- object(O,_),_clinguin_context(inspected_object,O),_clinguin_context(inspect_open,true),0=#count{R:role(O,R)}.
when(add_role,click,update,(local_feedback,visibility,hidden)) :-  object(O,_),_clinguin_context(inspected_object,O),_clinguin_context(inspect_open,true),0=#count{R:role(O,R)}.

% Inspector Positions Section

elem(positions_section,container,inspector_content) :- object(O,_),_clinguin_context(inspected_object,O),_clinguin_context(inspect_open,true).
attr(positions_section,order,Count+12) :- elem(positions_section,container,inspector_content),Count=#count{Obj,R:elem(role_requirement(Obj,R),label,inspector_content);Obj,S,F,M:elem(inspector_issue(Obj,S,F,M),label,inspector_content)}.
attr(positions_section,class,("d-flex";"flex-column";"gap-2";"border";"rounded-3";"p-2")) :- object(O,_),_clinguin_context(inspected_object,O),_clinguin_context(inspect_open,true).

% Positions Section Title

elem(positions_title,label,positions_section) :- object(O,_),_clinguin_context(inspected_object,O),_clinguin_context(inspect_open,true).
attr(positions_title,order,0) :- elem(positions_title,label,_).
attr(positions_title,label,"Positions") :- object(O,_),_clinguin_context(inspected_object,O),_clinguin_context(inspect_open,true).
attr(positions_title,class,"fw-bold") :- object(O,_),_clinguin_context(inspected_object,O),_clinguin_context(inspect_open,true).

% Add Position Button

elem(position_add,button,positions_section) :- object(O,_),_clinguin_context(inspected_object,O),_clinguin_context(inspect_open,true),_clinguin_context(placement_role,R),role(O,R,_,_,_),not issue(O,error,_,_),not issue(O,warning,property(_),_).
attr(position_add,order,1) :- elem(position_add,button,_).
attr(position_add,label,"Add Position") :- object(O,_),_clinguin_context(inspected_object,O),_clinguin_context(inspect_open,true),_clinguin_context(placement_role,R),role(O,R,_,_,_),not issue(O,error,_,_),not issue(O,warning,property(_),_).
attr(position_add,class,("btn-primary";"align-self-end")) :- object(O,_),_clinguin_context(inspected_object,O),_clinguin_context(inspect_open,true),_clinguin_context(placement_role,R),role(O,R,_,_,_),not issue(O,error,_,_),not issue(O,warning,property(_),_).
when(position_add,click,context,(dialog,form(position_add))) :- object(O,_),_clinguin_context(inspected_object,O),_clinguin_context(inspect_open,true),_clinguin_context(placement_role,R),role(O,R,_,_,_),not issue(O,error,_,_),not issue(O,warning,property(_),_).
when(position_add,click,update,(dialog(form(position_add)),visibility,shown)) :- object(O,_),_clinguin_context(inspected_object,O),_clinguin_context(inspect_open,true),_clinguin_context(placement_role,R),role(O,R,_,_,_),not issue(O,error,_,_),not issue(O,warning,property(_),_).
when(position_add,click,update,(local_feedback,visibility,hidden)) :- object(O,_),_clinguin_context(inspected_object,O),_clinguin_context(inspect_open,true),_clinguin_context(placement_role,R),role(O,R,_,_,_),not issue(O,error,_,_),not issue(O,warning,property(_),_).

% Empty Positions Message

elem(positions_empty,label,positions_section) :- object(O,_),_clinguin_context(inspected_object,O),_clinguin_context(inspect_open,true),not elem(placement(_,_,O),container,_).
attr(positions_empty,label,"No visible positions.") :- elem(positions_empty,label,_).
attr(positions_empty,order,2) :- elem(positions_empty,label,_).

% Position Row

elem(position_row(O,N,R),container,positions_section) :- object(O,_),_clinguin_context(inspected_object,O),_clinguin_context(inspect_open,true),elem(placement(N,R,O),container,_).
attr(position_row(O,N,R),order,Count+10) :- object(O,_),_clinguin_context(inspected_object,O),_clinguin_context(inspect_open,true),elem(placement(N,R,O),container,_),Count=#count{N2,R2:elem(placement(N2,R2,O),container,_),(N2,R2)<(N,R)}.
attr(position_row(O,N,R),class,("d-flex";"gap-2";"align-items-center";"border";"rounded-2";"p-2")) :- object(O,_),_clinguin_context(inspected_object,O),_clinguin_context(inspect_open,true),elem(placement(N,R,O),container,_).
attr(position_row(O,N,R),flex_direction,row) :- elem(position_row(O,N,R),container,_).
attr(position_row(O,N,R),class,"flex-wrap") :- elem(position_row(O,N,R),container,_).

% Position Details

elem(position_text(O,N,R),label,position_row(O,N,R)) :- object(O,_),_clinguin_context(inspected_object,O),_clinguin_context(inspect_open,true),elem(placement(N,R,O),container,_).
attr(position_text(O,N,R),order,0) :- elem(position_text(O,N,R),label,_).
attr(position_text(O,N,R),label,@concat(N," · ",R)) :- object(O,_),_clinguin_context(inspected_object,O),_clinguin_context(inspect_open,true),elem(placement(N,R,O),container,_).
attr(position_text(O,N,R),class,("font-monospace";"small";"flex-grow-1")) :- object(O,_),_clinguin_context(inspected_object,O),_clinguin_context(inspect_open,true),elem(placement(N,R,O),container,_).

% Move Position Button

elem(position_edit(O,N,R),button,position_row(O,N,R)) :- object(O,_),_clinguin_context(inspected_object,O),_clinguin_context(inspect_open,true),elem(placement(N,R,O),container,_),_clinguin_atom(position(N,R,O)).
attr(position_edit(O,N,R),order,1) :- elem(position_edit(O,N,R),button,_).
attr(position_edit(O,N,R),label,"Move") :- object(O,_),_clinguin_context(inspected_object,O),_clinguin_context(inspect_open,true),elem(placement(N,R,O),container,_),_clinguin_atom(position(N,R,O)).
attr(position_edit(O,N,R),class,"btn-outline-primary") :- object(O,_),_clinguin_context(inspected_object,O),_clinguin_context(inspect_open,true),elem(placement(N,R,O),container,_),_clinguin_atom(position(N,R,O)).
when(position_edit(O,N,R),click,context,(dialog,form(position_edit))) :- object(O,_),_clinguin_context(inspected_object,O),_clinguin_context(inspect_open,true),elem(placement(N,R,O),container,_),_clinguin_atom(position(N,R,O)).
when(position_edit(O,N,R),click,update,(dialog(form(position_edit)),visibility,shown)) :- object(O,_),_clinguin_context(inspected_object,O),_clinguin_context(inspect_open,true),elem(placement(N,R,O),container,_),_clinguin_atom(position(N,R,O)).
when(position_edit(O,N,R),click,update,(local_feedback,visibility,hidden)) :- object(O,_),_clinguin_context(inspected_object,O),_clinguin_context(inspect_open,true),elem(placement(N,R,O),container,_),_clinguin_atom(position(N,R,O)).
when(position_edit(O,N,R),click,context,(edit_position_object,O)) :- object(O,_),_clinguin_context(inspected_object,O),_clinguin_context(inspect_open,true),elem(placement(N,R,O),container,_),_clinguin_atom(position(N,R,O)),N=(Row,Col).
when(position_edit(O,N,R),click,context,(edit_position_row,Row)) :- object(O,_),_clinguin_context(inspected_object,O),_clinguin_context(inspect_open,true),elem(placement(N,R,O),container,_),_clinguin_atom(position(N,R,O)),N=(Row,Col).
when(position_edit(O,N,R),click,context,(edit_position_col,Col)) :- object(O,_),_clinguin_context(inspected_object,O),_clinguin_context(inspect_open,true),elem(placement(N,R,O),container,_),_clinguin_atom(position(N,R,O)),N=(Row,Col).
when(position_edit(O,N,R),click,context,(edit_position_role,R)) :- object(O,_),_clinguin_context(inspected_object,O),_clinguin_context(inspect_open,true),elem(placement(N,R,O),container,_),_clinguin_atom(position(N,R,O)),N=(Row,Col).
when(position_edit(O,N,R),click,context,(changed_row,Row)) :- object(O,_),_clinguin_context(inspected_object,O),_clinguin_context(inspect_open,true),elem(placement(N,R,O),container,_),_clinguin_atom(position(N,R,O)),N=(Row,Col).
when(position_edit(O,N,R),click,context,(changed_column,Col)) :- object(O,_),_clinguin_context(inspected_object,O),_clinguin_context(inspect_open,true),elem(placement(N,R,O),container,_),_clinguin_atom(position(N,R,O)),N=(Row,Col).

% Delete Position Button

elem(position_remove(O,N,R),button,position_row(O,N,R)) :- object(O,_),_clinguin_context(inspected_object,O),_clinguin_context(inspect_open,true),elem(placement(N,R,O),container,_),_clinguin_atom(position(N,R,O)).
attr(position_remove(O,N,R),label,"Delete") :- object(O,_),_clinguin_context(inspected_object,O),_clinguin_context(inspect_open,true),elem(placement(N,R,O),container,_),_clinguin_atom(position(N,R,O)).
attr(position_remove(O,N,R),class,"btn-outline-danger") :- object(O,_),_clinguin_context(inspected_object,O),_clinguin_context(inspect_open,true),elem(placement(N,R,O),container,_),_clinguin_atom(position(N,R,O)).
attr(position_remove(O,N,R),order,2) :- elem(position_remove(O,N,R),button,_).
when(position_remove(O,N,R),click,context,(delete_position,position(N,R,O))) :- elem(position_remove(O,N,R),button,_).

% Inspector Images Section


elem(images_section,container,inspector_content) :- object(O,_),_clinguin_context(inspected_object,O),_clinguin_context(inspect_open,true).
% attr(images_section,order,Count+13) :- elem(images_section,container,inspector_content),Count=#count{Obj,R:elem(role_requirement(Obj,R),label,inspector_content);Obj,S,F,M:elem(inspector_issue(Obj,S,F,M),label,inspector_content)}.
attr(images_section,class,("d-flex";"flex-column";"gap-2";"border";"rounded-3";"p-2")) :- object(O,_),_clinguin_context(inspected_object,O),_clinguin_context(inspect_open,true).

% Images Section Title

elem(images_title,label,images_section) :- object(O,_),_clinguin_context(inspected_object,O),_clinguin_context(inspect_open,true).
attr(images_title,order,0) :- elem(images_title,label,_).
attr(images_title,label,"Images") :- object(O,_),_clinguin_context(inspected_object,O),_clinguin_context(inspect_open,true).
attr(images_title,class,"fw-bold") :- object(O,_),_clinguin_context(inspected_object,O),_clinguin_context(inspect_open,true).

% Add Image Button

elem(image_add,button,images_section) :- object(O,_),_clinguin_context(inspected_object,O),_clinguin_context(inspect_open,true),0=#count{I:image(O,R,I)},not issue(O,error,_,_),not issue(O,warning,property(_),_).
attr(image_add,order,1) :- elem(image_add,button,_).
attr(image_add,label,"Add Image") :- object(O,_),_clinguin_context(inspected_object,O),_clinguin_context(inspect_open,true),0=#count{I:image(O,R,I)},not issue(O,error,_,_),not issue(O,warning,property(_),_).
attr(image_add,class,("btn-primary";"align-self-end")) :- object(O,_),_clinguin_context(inspected_object,O),_clinguin_context(inspect_open,true),0=#count{I:image(O,R,I)},not issue(O,error,_,_),not issue(O,warning,property(_),_).
when(image_add,click,context,(dialog,form(image_add))) :- object(O,_),_clinguin_context(inspected_object,O),_clinguin_context(inspect_open,true),0=#count{I:image(O,R,I)},not issue(O,error,_,_),not issue(O,warning,property(_),_).
when(image_add,click,update,(dialog(form(image_add)),visibility,shown)) :- object(O,_),_clinguin_context(inspected_object,O),_clinguin_context(inspect_open,true),0=#count{I:image(O,R,I)},not issue(O,error,_,_),not issue(O,warning,property(_),_).
when(image_add,click,update,(local_feedback,visibility,hidden)) :- object(O,_),_clinguin_context(inspected_object,O),_clinguin_context(inspect_open,true),0=#count{I:image(O,R,I)},not issue(O,error,_,_),not issue(O,warning,property(_),_).

% Empty Images Message

elem(images_empty,label,images_section) :- object(O,_),_clinguin_context(inspected_object,O),_clinguin_context(inspect_open,true),0=#count{R,I:image(O,R,I),I!="",I!=" "}.
attr(images_empty,label,"Empty image paths.") :- elem(images_empty,label,_).
attr(images_empty,order,2) :- elem(images_empty,label,_).

% Image Row

elem(image_row(O,R,I),container,images_section) :- object(O,_),_clinguin_context(inspected_object,O),_clinguin_context(inspect_open,true),image(O,R,I),I!="",I!=" ".
attr(image_row(O,R,I),order,N+10) :- elem(image_row(O,R,I),container,images_section),N=#count{R2,I2:elem(image_row(O,R2,I2),container,images_section),(R2,I2)<(R,I)}.
attr(image_row(O,R,I),class,("d-flex";"gap-2";"align-items-center";"border";"rounded-2";"p-2")) :- object(O,_),_clinguin_context(inspected_object,O),_clinguin_context(inspect_open,true),image(O,R,I),I!="",I!=" ".
attr(image_row(O,R,I),flex_direction,row) :- elem(image_row(O,R,I),container,_).
attr(image_row(O,R,I),class,"flex-wrap") :- elem(image_row(O,R,I),container,_).

% Inspector Image Preview Frame

elem(image_preview_frame(O,R,I),container,image_row(O,R,I)) :- elem(image_preview(O,R,I),canvas,_).
attr(image_preview_frame(O,R,I),width,38) :- object(O,_),_clinguin_context(inspected_object,O),_clinguin_context(inspect_open,true),image(O,R,I),I!="",I!=" ".
attr(image_preview_frame(O,R,I),height,38) :- object(O,_),_clinguin_context(inspected_object,O),_clinguin_context(inspect_open,true),image(O,R,I),I!="",I!=" ".
attr(image_preview_frame(O,R,I),order,0) :- elem(image_preview_frame(O,R,I),container,_).
attr(image_preview_frame(O,R,I),class,("d-flex";"align-items-center";"justify-content-center";"flex-shrink-0";"p-0";"m-0";"overflow-hidden")) :- elem(image_preview_frame(O,R,I),container,_).

% Inspector Image Preview

elem(image_preview(O,R,I),canvas,image_preview_frame(O,R,I)) :- object(O,_),_clinguin_context(inspected_object,O),_clinguin_context(inspect_open,true),image(O,R,I),I!="",I!=" ".
attr(image_preview(O,R,I),order,0) :- elem(image_preview(O,R,I),canvas,_).
attr(image_preview(O,R,I),image,I) :- object(O,_),_clinguin_context(inspected_object,O),_clinguin_context(inspect_open,true),image(O,R,I),I!="",I!=" ".
attr(image_preview(O,R,I),class,("d-block";"w-100";"h-100";"p-0";"m-0")) :- elem(image_preview(O,R,I),canvas,_).
attr(image_preview(O,R,I),width,38) :- elem(image_preview(O,R,I),canvas,_).
attr(image_preview(O,R,I),height,38) :- elem(image_preview(O,R,I),canvas,_).

% Image Details

elem(image_text(O,R,I),label,image_row(O,R,I)) :- object(O,_),_clinguin_context(inspected_object,O),_clinguin_context(inspect_open,true),image(O,R,I),I!="",I!=" ".
attr(image_text(O,R,I),order,1) :- elem(image_text(O,R,I),label,_).
attr(image_text(O,R,I),label,@concat(R," · ",I)) :- object(O,_),_clinguin_context(inspected_object,O),_clinguin_context(inspect_open,true),image(O,R,I),I!="",I!=" ".
attr(image_text(O,R,I),class,("font-monospace";"small";"flex-grow-1")) :- object(O,_),_clinguin_context(inspected_object,O),_clinguin_context(inspect_open,true),image(O,R,I),I!="",I!=" ".

% Edit Image Button
% Open the form and store the original and replacement values in context.

elem(image_edit(O,R,I),button,image_row(O,R,I)) :- object(O,_),_clinguin_context(inspected_object,O),_clinguin_context(inspect_open,true),image(O,R,I),I!="",I!=" ",_clinguin_atom(image(O,R,I)).
attr(image_edit(O,R,I),order,2) :- elem(image_edit(O,R,I),button,_).
attr(image_edit(O,R,I),label,"Edit") :- object(O,_),_clinguin_context(inspected_object,O),_clinguin_context(inspect_open,true),image(O,R,I),I!="",I!=" ",_clinguin_atom(image(O,R,I)).
attr(image_edit(O,R,I),class,"btn-outline-primary") :- object(O,_),_clinguin_context(inspected_object,O),_clinguin_context(inspect_open,true),image(O,R,I),I!="",I!=" ",_clinguin_atom(image(O,R,I)).
when(image_edit(O,R,I),click,context,(dialog,form(image_edit))) :- object(O,_),_clinguin_context(inspected_object,O),_clinguin_context(inspect_open,true),image(O,R,I),I!="",I!=" ",_clinguin_atom(image(O,R,I)).
when(image_edit(O,R,I),click,update,(dialog(form(image_edit)),visibility,shown)) :- object(O,_),_clinguin_context(inspected_object,O),_clinguin_context(inspect_open,true),image(O,R,I),I!="",I!=" ",_clinguin_atom(image(O,R,I)).
when(image_edit(O,R,I),click,update,(local_feedback,visibility,hidden)) :- object(O,_),_clinguin_context(inspected_object,O),_clinguin_context(inspect_open,true),image(O,R,I),I!="",I!=" ",_clinguin_atom(image(O,R,I)).
when(image_edit(O,R,I),click,context,(edit_image_object,O)) :- object(O,_),_clinguin_context(inspected_object,O),_clinguin_context(inspect_open,true),image(O,R,I),I!="",I!=" ",_clinguin_atom(image(O,R,I)).
when(image_edit(O,R,I),click,context,(edit_image_role,R)) :- object(O,_),_clinguin_context(inspected_object,O),_clinguin_context(inspect_open,true),image(O,R,I),I!="",I!=" ",_clinguin_atom(image(O,R,I)).
when(image_edit(O,R,I),click,context,(edit_image_path,I)) :- object(O,_),_clinguin_context(inspected_object,O),_clinguin_context(inspect_open,true),image(O,R,I),I!="",I!=" ",_clinguin_atom(image(O,R,I)).
when(image_edit(O,R,I),click,context,(changed_image_path,I)) :- object(O,_),_clinguin_context(inspected_object,O),_clinguin_context(inspect_open,true),image(O,R,I),I!="",I!=" ",_clinguin_atom(image(O,R,I)).

% Delete Image Button

elem(image_remove(O,R,I),button,image_row(O,R,I)) :- object(O,_),_clinguin_context(inspected_object,O),_clinguin_context(inspect_open,true),image(O,R,I),I!="",I!=" ",_clinguin_atom(image(O,R,I)).
attr(image_remove(O,R,I),order,3) :- elem(image_remove(O,R,I),button,_).
attr(image_remove(O,R,I),label,"Delete") :- object(O,_),_clinguin_context(inspected_object,O),_clinguin_context(inspect_open,true),image(O,R,I),I!="",I!=" ",_clinguin_atom(image(O,R,I)).
attr(image_remove(O,R,I),class,"btn-outline-danger") :- object(O,_),_clinguin_context(inspected_object,O),_clinguin_context(inspect_open,true),image(O,R,I),I!="",I!=" ",_clinguin_atom(image(O,R,I)).
when(image_remove(O,R,I),click,call,remove_atom(image(O,R,I))) :- object(O,_),_clinguin_context(inspected_object,O),_clinguin_context(inspect_open,true),image(O,R,I),I!="",I!=" ",_clinguin_atom(image(O,R,I)).

% Shared Form Action Layout

attr(form_actions(F),flex_direction,row) :- elem(form_actions(F),container,_).
attr(form_actions(F),class,"flex-wrap") :- elem(form_actions(F),container,_).

% Shared Cancel Button Order

attr(cancel(F),order,0) :- elem(cancel(F),button,_).

% Shared Save Button Order

attr(save(F,Kind),order,N+1) :- elem(save(F,Kind),button,_),N=#count{Other:elem(save(F,Other),button,_),Other<Kind}.

% Create Object Modal

elem(dialog(form(object_create)),modal,w).
attr(dialog(form(object_create)),title,"New object").
attr(dialog(form(object_create)),visibility,shown) :- _clinguin_context(dialog,form(object_create)),not _clinguin_context(submitted,true),not elem(commit(_,_,_),container,w).
attr(dialog(form(object_create)),visibility,shown) :- _clinguin_context(dialog,form(object_create)),_clinguin_unsat,not elem(commit(_,_,_),container,w).
attr(dialog(form(object_create)),visibility,hidden) :- not _clinguin_context(dialog,form(object_create)).
attr(dialog(form(object_create)),visibility,hidden) :- _clinguin_context(submitted,true),not _clinguin_unsat.

% New Object Form Body

elem(form_body(object_create),container,dialog_sheet(form(object_create))).
attr(form_body(object_create),class,("d-flex";"flex-column";"gap-3";"p-3")).

% New Object: Object Identifier Input

elem(input(object_create,new_object_name),textfield,form_body(object_create)).
attr(input(object_create,new_object_name),order,1).
attr(input(object_create,new_object_name),placeholder,"Object identifier").
when(input(object_create,new_object_name),input,context,(new_object_name,_value)).

% New Object: Previous Object Identifier

elem(previous(object_create,new_object_name),label,form_body(object_create)) :- _clinguin_context(new_object_name,V).
attr(previous(object_create,new_object_name),order,11) :- _clinguin_context(new_object_name,V).
attr(previous(object_create,new_object_name),label,@concat("Previous entry: ",V)) :- _clinguin_context(new_object_name,V).
attr(previous(object_create,new_object_name),class,("small";"text-secondary")) :- _clinguin_context(new_object_name,V).

% New Object: Object Type Input

elem(input(object_create,new_object_type),textfield,form_body(object_create)).
attr(input(object_create,new_object_type),order,2).
attr(input(object_create,new_object_type),placeholder,"Object type").
when(input(object_create,new_object_type),input,context,(new_object_type,_value)).

% New Object: Previous Object Type

elem(previous(object_create,new_object_type),label,form_body(object_create)) :- _clinguin_context(new_object_type,V).
attr(previous(object_create,new_object_type),order,12) :- _clinguin_context(new_object_type,V).
attr(previous(object_create,new_object_type),label,@concat("Previous entry: ",V)) :- _clinguin_context(new_object_type,V).
attr(previous(object_create,new_object_type),class,("small";"text-secondary")) :- _clinguin_context(new_object_type,V).

% New Object Form Actions

elem(form_actions(object_create),container,form_body(object_create)).
attr(form_actions(object_create),order,30).
attr(form_actions(object_create),class,("d-flex";"gap-2";"justify-content-end")).

% New Object: Cancel Button
elem(cancel(object_create),button,form_actions(object_create)).
attr(cancel(object_create),label,"Cancel").
attr(cancel(object_create),class,"btn-outline-secondary").
when(cancel(object_create),click,context,(dialog,none)).
when(cancel(object_create),click,update,(dialog(form(object_create)),visibility,hidden)).

% New Object: Save Button

elem(save(object_create,term),button,form_actions(object_create)).
attr(save(object_create,term),label,"Save").
attr(save(object_create,term),class,"btn-primary").
% request(action,name,type)
when(save(object_create,term),click,call,add_atom(request(create,_context_value(new_object_name,const),_context_value(new_object_type,const)))) :- not request(_,_,_).
when(save(object_create,term),click,call,(remove_atom(request(M,OldO,OldT)),add_atom(request(create,_context_value(new_object_name,const),_context_value(new_object_type,const))))) :- request(M,OldO,OldT).

% Add Property Dialog

elem(dialog(form(property_add)),modal,w) :- object(O,_),_clinguin_context(inspected_object,O),_clinguin_context(inspect_open,true).
attr(dialog(form(property_add)),title,"Add property") :- object(O,_),_clinguin_context(inspected_object,O),_clinguin_context(inspect_open,true).
attr(dialog(form(property_add)),visibility,shown) :- object(O,_),_clinguin_context(inspected_object,O),_clinguin_context(inspect_open,true),_clinguin_context(dialog,form(property_add)),not _clinguin_context(submitted,true),not elem(commit(_,_,_),container,w).
attr(dialog(form(property_add)),visibility,shown) :- object(O,_),_clinguin_context(inspected_object,O),_clinguin_context(inspect_open,true),_clinguin_context(dialog,form(property_add)),_clinguin_unsat,not elem(commit(_,_,_),container,w).
attr(dialog(form(property_add)),visibility,hidden) :- object(O,_),_clinguin_context(inspected_object,O),_clinguin_context(inspect_open,true),not _clinguin_context(dialog,form(property_add)).
attr(dialog(form(property_add)),visibility,hidden) :- object(O,_),_clinguin_context(inspected_object,O),_clinguin_context(inspect_open,true),_clinguin_context(submitted,true),not _clinguin_unsat.

% Add Property Form Body

elem(form_body(property_add),container,dialog_sheet(form(property_add))) :- object(O,_),_clinguin_context(inspected_object,O),_clinguin_context(inspect_open,true).
attr(form_body(property_add),class,("d-flex";"flex-column";"gap-3";"p-3")) :- object(O,_),_clinguin_context(inspected_object,O),_clinguin_context(inspect_open,true).

% Add Property: Property Key Input

elem(input(property_add,new_property_name),textfield,form_body(property_add)) :- object(O,_),_clinguin_context(inspected_object,O),_clinguin_context(inspect_open,true).
attr(input(property_add,new_property_name),order,1) :- object(O,_),_clinguin_context(inspected_object,O),_clinguin_context(inspect_open,true).
attr(input(property_add,new_property_name),placeholder,"Property Name") :- object(O,_),_clinguin_context(inspected_object,O),_clinguin_context(inspect_open,true).
when(input(property_add,new_property_name),input,context,(new_property_name,_value)) :- object(O,_),_clinguin_context(inspected_object,O),_clinguin_context(inspect_open,true).

% Add Property: Previous Property Key

elem(previous(property_add,new_property_name),label,form_body(property_add)) :- object(O,_),_clinguin_context(inspected_object,O),_clinguin_context(inspect_open,true),_clinguin_context(new_property_name,V).
attr(previous(property_add,new_property_name),order,11) :- object(O,_),_clinguin_context(inspected_object,O),_clinguin_context(inspect_open,true),_clinguin_context(new_property_name,V).
attr(previous(property_add,new_property_name),label,@concat("Previous entry: ",V)) :- object(O,_),_clinguin_context(inspected_object,O),_clinguin_context(inspect_open,true),_clinguin_context(new_property_name,V).
attr(previous(property_add,new_property_name),class,("small";"text-secondary")) :- object(O,_),_clinguin_context(inspected_object,O),_clinguin_context(inspect_open,true),_clinguin_context(new_property_name,V).

% Add Property: Property Value Input

elem(input(property_add,new_property_value),textfield,form_body(property_add)) :- object(O,_),_clinguin_context(inspected_object,O),_clinguin_context(inspect_open,true).
attr(input(property_add,new_property_value),order,2) :- object(O,_),_clinguin_context(inspected_object,O),_clinguin_context(inspect_open,true).
attr(input(property_add,new_property_value),placeholder,"Property value") :- object(O,_),_clinguin_context(inspected_object,O),_clinguin_context(inspect_open,true).
when(input(property_add,new_property_value),input,context,(new_property_value,_value)) :- object(O,_),_clinguin_context(inspected_object,O),_clinguin_context(inspect_open,true).

% Add Property: Previous Property Value

elem(previous(property_add,new_property_value),label,form_body(property_add)) :- object(O,_),_clinguin_context(inspected_object,O),_clinguin_context(inspect_open,true),_clinguin_context(new_property_value,V).
attr(previous(property_add,new_property_value),order,12) :- object(O,_),_clinguin_context(inspected_object,O),_clinguin_context(inspect_open,true),_clinguin_context(new_property_value,V).
attr(previous(property_add,new_property_value),label,@concat("Previous entry: ",V)) :- object(O,_),_clinguin_context(inspected_object,O),_clinguin_context(inspect_open,true),_clinguin_context(new_property_value,V).
attr(previous(property_add,new_property_value),class,("small";"text-secondary")) :- object(O,_),_clinguin_context(inspected_object,O),_clinguin_context(inspect_open,true),_clinguin_context(new_property_value,V).

% Add Property Form Actions
elem(form_actions(property_add),container,form_body(property_add)) :- object(O,_),_clinguin_context(inspected_object,O),_clinguin_context(inspect_open,true).
attr(form_actions(property_add),order,30) :- object(O,_),_clinguin_context(inspected_object,O),_clinguin_context(inspect_open,true).
attr(form_actions(property_add),class,("d-flex";"gap-2";"justify-content-end")) :- object(O,_),_clinguin_context(inspected_object,O),_clinguin_context(inspect_open,true).

% Add Property: Cancel Button

elem(cancel(property_add),button,form_actions(property_add)) :- object(O,_),_clinguin_context(inspected_object,O),_clinguin_context(inspect_open,true).
attr(cancel(property_add),label,"Cancel") :- object(O,_),_clinguin_context(inspected_object,O),_clinguin_context(inspect_open,true).
attr(cancel(property_add),class,"btn-outline-secondary") :- object(O,_),_clinguin_context(inspected_object,O),_clinguin_context(inspect_open,true).
when(cancel(property_add),click,context,(dialog,none)) :- object(O,_),_clinguin_context(inspected_object,O),_clinguin_context(inspect_open,true).
when(cancel(property_add),click,update,(dialog(form(property_add)),visibility,hidden)) :- object(O,_),_clinguin_context(inspected_object,O),_clinguin_context(inspect_open,true).

% Add Property: Save Term Button

elem(save(property_add,term),button,form_actions(property_add)) :- object(O,_),_clinguin_context(inspected_object,O),_clinguin_context(inspect_open,true).
attr(save(property_add,term),label,"Save term") :- object(O,_),_clinguin_context(inspected_object,O),_clinguin_context(inspect_open,true).
attr(save(property_add,term),class,"btn-primary") :- object(O,_),_clinguin_context(inspected_object,O),_clinguin_context(inspect_open,true).
when(save(property_add,term),click,context,(submitted,true)) :- object(O,_),_clinguin_context(inspected_object,O),_clinguin_context(inspect_open,true).
when(save(property_add,term),click,call,add_atom(property(O,_context_value(new_property_name,const),_context_value(new_property_value)))) :- object(O,_),_clinguin_context(inspected_object,O),_clinguin_context(inspect_open,true).

% Add Property: Save Number Button

elem(save(property_add,int),button,form_actions(property_add)) :- object(O,_),_clinguin_context(inspected_object,O),_clinguin_context(inspect_open,true).
attr(save(property_add,int),label,"Save number") :- object(O,_),_clinguin_context(inspected_object,O),_clinguin_context(inspect_open,true).
attr(save(property_add,int),class,"btn-primary") :- object(O,_),_clinguin_context(inspected_object,O),_clinguin_context(inspect_open,true).
when(save(property_add,int),click,context,(submitted,true)) :- object(O,_),_clinguin_context(inspected_object,O),_clinguin_context(inspect_open,true).
when(save(property_add,int),click,call,add_atom(property(O,_context_value(new_property_name,const),_context_value(new_property_value,int)))) :- object(O,_),_clinguin_context(inspected_object,O),_clinguin_context(inspect_open,true).

% Add Property: Save Text Button

elem(save(property_add,str),button,form_actions(property_add)) :- object(O,_),_clinguin_context(inspected_object,O),_clinguin_context(inspect_open,true).
attr(save(property_add,str),label,"Save text") :- object(O,_),_clinguin_context(inspected_object,O),_clinguin_context(inspect_open,true).
attr(save(property_add,str),class,"btn-primary") :- object(O,_),_clinguin_context(inspected_object,O),_clinguin_context(inspect_open,true).
when(save(property_add,str),click,context,(submitted,true)) :- object(O,_),_clinguin_context(inspected_object,O),_clinguin_context(inspect_open,true).
when(save(property_add,str),click,call,add_atom(property(O,_context_value(new_property_name,const),_context_value(new_property_value,str)))) :- object(O,_),_clinguin_context(inspected_object,O),_clinguin_context(inspect_open,true).

% Edit Property Dialog

elem(dialog(form(property_edit)),modal,w) :- object(O,_),_clinguin_context(inspected_object,O),_clinguin_context(inspect_open,true).
attr(dialog(form(property_edit)),title,"Edit property") :- object(O,_),_clinguin_context(inspected_object,O),_clinguin_context(inspect_open,true).
attr(dialog(form(property_edit)),visibility,shown) :- object(O,_),_clinguin_context(inspected_object,O),_clinguin_context(inspect_open,true),_clinguin_context(dialog,form(property_edit)),not _clinguin_context(submitted,true),not elem(commit(_,_,_),container,w).
attr(dialog(form(property_edit)),visibility,shown) :- object(O,_),_clinguin_context(inspected_object,O),_clinguin_context(inspect_open,true),_clinguin_context(dialog,form(property_edit)),_clinguin_unsat,not elem(commit(_,_,_),container,w).
attr(dialog(form(property_edit)),visibility,hidden) :- object(O,_),_clinguin_context(inspected_object,O),_clinguin_context(inspect_open,true),not _clinguin_context(dialog,form(property_edit)).
attr(dialog(form(property_edit)),visibility,hidden) :- object(O,_),_clinguin_context(inspected_object,O),_clinguin_context(inspect_open,true),_clinguin_context(submitted,true),not _clinguin_unsat.

% Edit Property Form Body

elem(form_body(property_edit),container,dialog_sheet(form(property_edit))) :- object(O,_),_clinguin_context(inspected_object,O),_clinguin_context(inspect_open,true).
attr(form_body(property_edit),class,("d-flex";"flex-column";"gap-3";"p-3")) :- object(O,_),_clinguin_context(inspected_object,O),_clinguin_context(inspect_open,true).

% Edit Property: Replacement Key Input

elem(input(property_edit,changed_property_key),textfield,form_body(property_edit)) :- object(O,_),_clinguin_context(inspected_object,O),_clinguin_context(inspect_open,true).
attr(input(property_edit,changed_property_key),placeholder,"Replacement key") :- object(O,_),_clinguin_context(inspected_object,O),_clinguin_context(inspect_open,true).
attr(input(property_edit,changed_property_key),order,1) :- object(O,_),_clinguin_context(inspected_object,O),_clinguin_context(inspect_open,true).
when(input(property_edit,changed_property_key),input,context,(changed_property_key,_value)) :- object(O,_),_clinguin_context(inspected_object,O),_clinguin_context(inspect_open,true).

% Edit Property: Previous Replacement Key

elem(previous(property_edit,changed_property_key),label,form_body(property_edit)) :- object(O,_),_clinguin_context(inspected_object,O),_clinguin_context(inspect_open,true),_clinguin_context(changed_property_key,V).
attr(previous(property_edit,changed_property_key),order,11) :- object(O,_),_clinguin_context(inspected_object,O),_clinguin_context(inspect_open,true),_clinguin_context(changed_property_key,V).
attr(previous(property_edit,changed_property_key),label,@concat("Previous entry: ",V)) :- object(O,_),_clinguin_context(inspected_object,O),_clinguin_context(inspect_open,true),_clinguin_context(changed_property_key,V).
attr(previous(property_edit,changed_property_key),class,("small";"text-secondary")) :- object(O,_),_clinguin_context(inspected_object,O),_clinguin_context(inspect_open,true),_clinguin_context(changed_property_key,V).

% Edit Property: Replacement Value Input

elem(input(property_edit,changed_property_value),textfield,form_body(property_edit)) :- object(O,_),_clinguin_context(inspected_object,O),_clinguin_context(inspect_open,true).
attr(input(property_edit,changed_property_value),order,2) :- object(O,_),_clinguin_context(inspected_object,O),_clinguin_context(inspect_open,true).
attr(input(property_edit,changed_property_value),placeholder,"Replacement value") :- object(O,_),_clinguin_context(inspected_object,O),_clinguin_context(inspect_open,true).
when(input(property_edit,changed_property_value),input,context,(changed_property_value,_value)) :- object(O,_),_clinguin_context(inspected_object,O),_clinguin_context(inspect_open,true).

% Edit Property: Previous Replacement Value

elem(previous(property_edit,changed_property_value),label,form_body(property_edit)) :- object(O,_),_clinguin_context(inspected_object,O),_clinguin_context(inspect_open,true),_clinguin_context(changed_property_value,V).
attr(previous(property_edit,changed_property_value),order,12) :- object(O,_),_clinguin_context(inspected_object,O),_clinguin_context(inspect_open,true),_clinguin_context(changed_property_value,V).
attr(previous(property_edit,changed_property_value),label,@concat("Previous entry: ",V)) :- object(O,_),_clinguin_context(inspected_object,O),_clinguin_context(inspect_open,true),_clinguin_context(changed_property_value,V).
attr(previous(property_edit,changed_property_value),class,("small";"text-secondary")) :- object(O,_),_clinguin_context(inspected_object,O),_clinguin_context(inspect_open,true),_clinguin_context(changed_property_value,V).

% Edit Property Form Actions

elem(form_actions(property_edit),container,form_body(property_edit)) :- object(O,_),_clinguin_context(inspected_object,O),_clinguin_context(inspect_open,true).
attr(form_actions(property_edit),order,30) :- object(O,_),_clinguin_context(inspected_object,O),_clinguin_context(inspect_open,true).
attr(form_actions(property_edit),class,("d-flex";"gap-2";"justify-content-end")) :- object(O,_),_clinguin_context(inspected_object,O),_clinguin_context(inspect_open,true).

% Edit Property: Cancel Button

elem(cancel(property_edit),button,form_actions(property_edit)) :- object(O,_),_clinguin_context(inspected_object,O),_clinguin_context(inspect_open,true).
attr(cancel(property_edit),label,"Cancel") :- object(O,_),_clinguin_context(inspected_object,O),_clinguin_context(inspect_open,true).
attr(cancel(property_edit),class,"btn-outline-secondary") :- object(O,_),_clinguin_context(inspected_object,O),_clinguin_context(inspect_open,true).
when(cancel(property_edit),click,context,(dialog,none)) :- object(O,_),_clinguin_context(inspected_object,O),_clinguin_context(inspect_open,true).
when(cancel(property_edit),click,update,(dialog(form(property_edit)),visibility,hidden)) :- object(O,_),_clinguin_context(inspected_object,O),_clinguin_context(inspect_open,true).

% Edit Property: Save Term Button

elem(save(property_edit,term),button,form_actions(property_edit)) :- object(O,_),_clinguin_context(inspected_object,O),_clinguin_context(inspect_open,true).
attr(save(property_edit,term),label,"Save term") :- object(O,_),_clinguin_context(inspected_object,O),_clinguin_context(inspect_open,true).
attr(save(property_edit,term),class,"btn-primary") :- object(O,_),_clinguin_context(inspected_object,O),_clinguin_context(inspect_open,true).
when(save(property_edit,term),click,context,(submitted,true)) :- object(O,_),_clinguin_context(inspected_object,O),_clinguin_context(inspect_open,true).
when(save(property_edit,term),click,call,(remove_atom(property(_context_value(edit_property_object),_context_value(edit_property_key),_context_value(edit_property_value))),add_atom(property(O,_context_value(changed_property_key,const),_context_value(changed_property_value))))) :- object(O,_),_clinguin_context(inspected_object,O),_clinguin_context(inspect_open,true).

% Edit Property: Save Number Button

elem(save(property_edit,int),button,form_actions(property_edit)) :- object(O,_),_clinguin_context(inspected_object,O),_clinguin_context(inspect_open,true).
attr(save(property_edit,int),label,"Save number") :- object(O,_),_clinguin_context(inspected_object,O),_clinguin_context(inspect_open,true).
attr(save(property_edit,int),class,"btn-primary") :- object(O,_),_clinguin_context(inspected_object,O),_clinguin_context(inspect_open,true).
when(save(property_edit,int),click,context,(submitted,true)) :- object(O,_),_clinguin_context(inspected_object,O),_clinguin_context(inspect_open,true).
when(save(property_edit,int),click,call,(remove_atom(property(_context_value(edit_property_object),_context_value(edit_property_key),_context_value(edit_property_value))),add_atom(property(O,_context_value(changed_property_key,const),_context_value(changed_property_value,int))))) :- object(O,_),_clinguin_context(inspected_object,O),_clinguin_context(inspect_open,true).

% Edit Property: Save Text Button

elem(save(property_edit,str),button,form_actions(property_edit)) :- object(O,_),_clinguin_context(inspected_object,O),_clinguin_context(inspect_open,true).
attr(save(property_edit,str),label,"Save text") :- object(O,_),_clinguin_context(inspected_object,O),_clinguin_context(inspect_open,true).
attr(save(property_edit,str),class,"btn-primary") :- object(O,_),_clinguin_context(inspected_object,O),_clinguin_context(inspect_open,true).
when(save(property_edit,str),click,context,(submitted,true)) :- object(O,_),_clinguin_context(inspected_object,O),_clinguin_context(inspect_open,true).
when(save(property_edit,str),click,call,(remove_atom(property(_context_value(edit_property_object),_context_value(edit_property_key),_context_value(edit_property_value))),add_atom(property(O,_context_value(changed_property_key,const),_context_value(changed_property_value,str))))) :- object(O,_),_clinguin_context(inspected_object,O),_clinguin_context(inspect_open,true).

% Add Position Dialog

elem(dialog(form(position_add)),modal,w) :- object(O,_),_clinguin_context(inspected_object,O),_clinguin_context(inspect_open,true).
attr(dialog(form(position_add)),title,"Add position") :- object(O,_),_clinguin_context(inspected_object,O),_clinguin_context(inspect_open,true).
attr(dialog(form(position_add)),visibility,shown) :- object(O,_),_clinguin_context(inspected_object,O),_clinguin_context(inspect_open,true),_clinguin_context(dialog,form(position_add)),not _clinguin_context(submitted,true),not elem(commit(_,_,_),container,w).
attr(dialog(form(position_add)),visibility,shown) :- object(O,_),_clinguin_context(inspected_object,O),_clinguin_context(inspect_open,true),_clinguin_context(dialog,form(position_add)),_clinguin_unsat,not elem(commit(_,_,_),container,w).
attr(dialog(form(position_add)),visibility,hidden) :- object(O,_),_clinguin_context(inspected_object,O),_clinguin_context(inspect_open,true),not _clinguin_context(dialog,form(position_add)).
attr(dialog(form(position_add)),visibility,hidden) :- object(O,_),_clinguin_context(inspected_object,O),_clinguin_context(inspect_open,true),_clinguin_context(submitted,true),not _clinguin_unsat.

% Add Position Form Body

elem(form_body(position_add),container,dialog_sheet(form(position_add))) :- object(O,_),_clinguin_context(inspected_object,O),_clinguin_context(inspect_open,true).
attr(form_body(position_add),class,("d-flex";"flex-column";"gap-3";"p-3")) :- object(O,_),_clinguin_context(inspected_object,O),_clinguin_context(inspect_open,true).

% Add Position: Row Input

elem(input(position_add,new_row),textfield,form_body(position_add)) :- object(O,_),_clinguin_context(inspected_object,O),_clinguin_context(inspect_open,true).
attr(input(position_add,new_row),placeholder,"Row") :- object(O,_),_clinguin_context(inspected_object,O),_clinguin_context(inspect_open,true).
attr(input(position_add,new_row),order,1) :- object(O,_),_clinguin_context(inspected_object,O),_clinguin_context(inspect_open,true).
when(input(position_add,new_row),input,context,(new_row,_value)) :- object(O,_),_clinguin_context(inspected_object,O),_clinguin_context(inspect_open,true).

% Add Position: Previous Row

elem(previous(position_add,new_row),label,form_body(position_add)) :- object(O,_),_clinguin_context(inspected_object,O),_clinguin_context(inspect_open,true),_clinguin_context(new_row,V).
attr(previous(position_add,new_row),order,11) :- object(O,_),_clinguin_context(inspected_object,O),_clinguin_context(inspect_open,true),_clinguin_context(new_row,V).
attr(previous(position_add,new_row),label,@concat("Previous entry: ",V)) :- object(O,_),_clinguin_context(inspected_object,O),_clinguin_context(inspect_open,true),_clinguin_context(new_row,V).
attr(previous(position_add,new_row),class,("small";"text-secondary")) :- object(O,_),_clinguin_context(inspected_object,O),_clinguin_context(inspect_open,true),_clinguin_context(new_row,V).

% Add Position: Column Input

elem(input(position_add,new_column),textfield,form_body(position_add)) :- object(O,_),_clinguin_context(inspected_object,O),_clinguin_context(inspect_open,true).
attr(input(position_add,new_column),order,2) :- object(O,_),_clinguin_context(inspected_object,O),_clinguin_context(inspect_open,true).
attr(input(position_add,new_column),placeholder,"Column") :- object(O,_),_clinguin_context(inspected_object,O),_clinguin_context(inspect_open,true).
when(input(position_add,new_column),input,context,(new_column,_value)) :- object(O,_),_clinguin_context(inspected_object,O),_clinguin_context(inspect_open,true).

% Add Position: Previous Column

elem(previous(position_add,new_column),label,form_body(position_add)) :- object(O,_),_clinguin_context(inspected_object,O),_clinguin_context(inspect_open,true),_clinguin_context(new_column,V).
attr(previous(position_add,new_column),order,12) :- object(O,_),_clinguin_context(inspected_object,O),_clinguin_context(inspect_open,true),_clinguin_context(new_column,V).
attr(previous(position_add,new_column),label,@concat("Previous entry: ",V)) :- object(O,_),_clinguin_context(inspected_object,O),_clinguin_context(inspect_open,true),_clinguin_context(new_column,V).
attr(previous(position_add,new_column),class,("small";"text-secondary")) :- object(O,_),_clinguin_context(inspected_object,O),_clinguin_context(inspect_open,true),_clinguin_context(new_column,V).

% Add Position Form Actions

elem(form_actions(position_add),container,form_body(position_add)) :- object(O,_),_clinguin_context(inspected_object,O),_clinguin_context(inspect_open,true).
attr(form_actions(position_add),order,30) :- object(O,_),_clinguin_context(inspected_object,O),_clinguin_context(inspect_open,true).
attr(form_actions(position_add),class,("d-flex";"gap-2";"justify-content-end")) :- object(O,_),_clinguin_context(inspected_object,O),_clinguin_context(inspect_open,true).

% Add Position: Cancel Button

elem(cancel(position_add),button,form_actions(position_add)) :- object(O,_),_clinguin_context(inspected_object,O),_clinguin_context(inspect_open,true).
attr(cancel(position_add),label,"Cancel") :- object(O,_),_clinguin_context(inspected_object,O),_clinguin_context(inspect_open,true).
attr(cancel(position_add),class,"btn-outline-secondary") :- object(O,_),_clinguin_context(inspected_object,O),_clinguin_context(inspect_open,true).
when(cancel(position_add),click,context,(dialog,none)) :- object(O,_),_clinguin_context(inspected_object,O),_clinguin_context(inspect_open,true).
when(cancel(position_add),click,update,(dialog(form(position_add)),visibility,hidden)) :- object(O,_),_clinguin_context(inspected_object,O),_clinguin_context(inspect_open,true).

% Add Position: Save Button

elem(save(position_add,term),button,form_actions(position_add)) :- object(O,_),_clinguin_context(inspected_object,O),_clinguin_context(inspect_open,true).
attr(save(position_add,term),label,"Save") :- object(O,_),_clinguin_context(inspected_object,O),_clinguin_context(inspect_open,true).
attr(save(position_add,term),class,"btn-primary") :- object(O,_),_clinguin_context(inspected_object,O),_clinguin_context(inspect_open,true).
when(save(position_add,term),click,context,(submitted,true)) :- object(O,_),_clinguin_context(inspected_object,O),_clinguin_context(inspect_open,true).
when(save(position_add,term),click,call,add_atom(position((_context_value(new_row,int),_context_value(new_column,int)),R,O))) :- object(O,_),_clinguin_context(inspected_object,O),_clinguin_context(inspect_open,true),_clinguin_context(placement_role,R),role(O,R,_,_,_).

% Move Position Dialog

elem(dialog(form(position_edit)),modal,w) :- object(O,_),_clinguin_context(inspected_object,O),_clinguin_context(inspect_open,true).
attr(dialog(form(position_edit)),title,"Move position") :- object(O,_),_clinguin_context(inspected_object,O),_clinguin_context(inspect_open,true).
attr(dialog(form(position_edit)),visibility,shown) :- object(O,_),_clinguin_context(inspected_object,O),_clinguin_context(inspect_open,true),_clinguin_context(dialog,form(position_edit)),not _clinguin_context(submitted,true),not elem(commit(_,_,_),container,w).
attr(dialog(form(position_edit)),visibility,shown) :- object(O,_),_clinguin_context(inspected_object,O),_clinguin_context(inspect_open,true),_clinguin_context(dialog,form(position_edit)),_clinguin_unsat,not elem(commit(_,_,_),container,w).
attr(dialog(form(position_edit)),visibility,hidden) :- object(O,_),_clinguin_context(inspected_object,O),_clinguin_context(inspect_open,true),not _clinguin_context(dialog,form(position_edit)).
attr(dialog(form(position_edit)),visibility,hidden) :- object(O,_),_clinguin_context(inspected_object,O),_clinguin_context(inspect_open,true),_clinguin_context(submitted,true),not _clinguin_unsat.

% Move Position Form Body

elem(form_body(position_edit),container,dialog_sheet(form(position_edit))) :- object(O,_),_clinguin_context(inspected_object,O),_clinguin_context(inspect_open,true).
attr(form_body(position_edit),class,("d-flex";"flex-column";"gap-3";"p-3")) :- object(O,_),_clinguin_context(inspected_object,O),_clinguin_context(inspect_open,true).

% Move Position: New Row Input

elem(input(position_edit,changed_row),textfield,form_body(position_edit)) :- object(O,_),_clinguin_context(inspected_object,O),_clinguin_context(inspect_open,true).
attr(input(position_edit,changed_row),order,1) :- object(O,_),_clinguin_context(inspected_object,O),_clinguin_context(inspect_open,true).
attr(input(position_edit,changed_row),placeholder,"New row") :- object(O,_),_clinguin_context(inspected_object,O),_clinguin_context(inspect_open,true).
when(input(position_edit,changed_row),input,context,(changed_row,_value)) :- object(O,_),_clinguin_context(inspected_object,O),_clinguin_context(inspect_open,true).

% Move Position: Previous New Row

elem(previous(position_edit,changed_row),label,form_body(position_edit)) :- object(O,_),_clinguin_context(inspected_object,O),_clinguin_context(inspect_open,true),_clinguin_context(changed_row,V).
attr(previous(position_edit,changed_row),order,11) :- object(O,_),_clinguin_context(inspected_object,O),_clinguin_context(inspect_open,true),_clinguin_context(changed_row,V).
attr(previous(position_edit,changed_row),label,@concat("Previous entry: ",V)) :- object(O,_),_clinguin_context(inspected_object,O),_clinguin_context(inspect_open,true),_clinguin_context(changed_row,V).
attr(previous(position_edit,changed_row),class,("small";"text-secondary")) :- object(O,_),_clinguin_context(inspected_object,O),_clinguin_context(inspect_open,true),_clinguin_context(changed_row,V).

% Move Position: New Column Input

elem(input(position_edit,changed_column),textfield,form_body(position_edit)) :- object(O,_),_clinguin_context(inspected_object,O),_clinguin_context(inspect_open,true).
attr(input(position_edit,changed_column),order,2) :- object(O,_),_clinguin_context(inspected_object,O),_clinguin_context(inspect_open,true).
attr(input(position_edit,changed_column),placeholder,"New column") :- object(O,_),_clinguin_context(inspected_object,O),_clinguin_context(inspect_open,true).
when(input(position_edit,changed_column),input,context,(changed_column,_value)) :- object(O,_),_clinguin_context(inspected_object,O),_clinguin_context(inspect_open,true).

% Move Position: Previous New Column

elem(previous(position_edit,changed_column),label,form_body(position_edit)) :- object(O,_),_clinguin_context(inspected_object,O),_clinguin_context(inspect_open,true),_clinguin_context(changed_column,V).
attr(previous(position_edit,changed_column),order,12) :- object(O,_),_clinguin_context(inspected_object,O),_clinguin_context(inspect_open,true),_clinguin_context(changed_column,V).
attr(previous(position_edit,changed_column),label,@concat("Previous entry: ",V)) :- object(O,_),_clinguin_context(inspected_object,O),_clinguin_context(inspect_open,true),_clinguin_context(changed_column,V).
attr(previous(position_edit,changed_column),class,("small";"text-secondary")) :- object(O,_),_clinguin_context(inspected_object,O),_clinguin_context(inspect_open,true),_clinguin_context(changed_column,V).

% Move Position Form Actions

elem(form_actions(position_edit),container,form_body(position_edit)) :- object(O,_),_clinguin_context(inspected_object,O),_clinguin_context(inspect_open,true).
attr(form_actions(position_edit),order,30) :- object(O,_),_clinguin_context(inspected_object,O),_clinguin_context(inspect_open,true).
attr(form_actions(position_edit),class,("d-flex";"gap-2";"justify-content-end")) :- object(O,_),_clinguin_context(inspected_object,O),_clinguin_context(inspect_open,true).

% Move Position: Cancel Button

elem(cancel(position_edit),button,form_actions(position_edit)) :- object(O,_),_clinguin_context(inspected_object,O),_clinguin_context(inspect_open,true).
attr(cancel(position_edit),label,"Cancel") :- object(O,_),_clinguin_context(inspected_object,O),_clinguin_context(inspect_open,true).
attr(cancel(position_edit),class,"btn-outline-secondary") :- object(O,_),_clinguin_context(inspected_object,O),_clinguin_context(inspect_open,true).
when(cancel(position_edit),click,context,(dialog,none)) :- object(O,_),_clinguin_context(inspected_object,O),_clinguin_context(inspect_open,true).
when(cancel(position_edit),click,update,(dialog(form(position_edit)),visibility,hidden)) :- object(O,_),_clinguin_context(inspected_object,O),_clinguin_context(inspect_open,true).

% Move Position: Save Button

elem(save(position_edit,term),button,form_actions(position_edit)) :- object(O,_),_clinguin_context(inspected_object,O),_clinguin_context(inspect_open,true).
attr(save(position_edit,term),label,"Save") :- object(O,_),_clinguin_context(inspected_object,O),_clinguin_context(inspect_open,true).
attr(save(position_edit,term),class,"btn-primary") :- object(O,_),_clinguin_context(inspected_object,O),_clinguin_context(inspect_open,true).
when(save(position_edit,term),click,context,(submitted,true)) :- object(O,_),_clinguin_context(inspected_object,O),_clinguin_context(inspect_open,true).
when(save(position_edit,term),click,call,(remove_atom(position((_context_value(edit_position_row,int),_context_value(edit_position_col,int)),_context_value(edit_position_role),_context_value(edit_position_object))),add_atom(position((_context_value(changed_row,int),_context_value(changed_column,int)),_context_value(edit_position_role),O)))) :- object(O,_),_clinguin_context(inspected_object,O),_clinguin_context(inspect_open,true).

% Add Image Dialog

elem(dialog(form(image_add)),modal,w) :- object(O,_),_clinguin_context(inspected_object,O),_clinguin_context(inspect_open,true).
attr(dialog(form(image_add)),title,"Add image") :- object(O,_),_clinguin_context(inspected_object,O),_clinguin_context(inspect_open,true).
attr(dialog(form(image_add)),visibility,shown) :- object(O,_),_clinguin_context(inspected_object,O),_clinguin_context(inspect_open,true),_clinguin_context(dialog,form(image_add)),not _clinguin_context(submitted,true),not elem(commit(_,_,_),container,w).
attr(dialog(form(image_add)),visibility,shown) :- object(O,_),_clinguin_context(inspected_object,O),_clinguin_context(inspect_open,true),_clinguin_context(dialog,form(image_add)),_clinguin_unsat,not elem(commit(_,_,_),container,w).
attr(dialog(form(image_add)),visibility,hidden) :- object(O,_),_clinguin_context(inspected_object,O),_clinguin_context(inspect_open,true),not _clinguin_context(dialog,form(image_add)).
attr(dialog(form(image_add)),visibility,hidden) :- object(O,_),_clinguin_context(inspected_object,O),_clinguin_context(inspect_open,true),_clinguin_context(submitted,true),not _clinguin_unsat.

% Add Image Form Body

elem(form_body(image_add),container,dialog_sheet(form(image_add))) :- object(O,_),_clinguin_context(inspected_object,O),_clinguin_context(inspect_open,true).
attr(form_body(image_add),class,("d-flex";"flex-column";"gap-3";"p-3")) :- object(O,_),_clinguin_context(inspected_object,O),_clinguin_context(inspect_open,true).

% % Add Image: Role Input

elem(input(add_role,new_role),textfield,form_body(image_add)) :- object(O,_),_clinguin_context(inspected_object,O),_clinguin_context(inspect_open,true),0=#count{R:role(O,R)}.
attr(input(add_role,new_role),order,1) :- object(O,_),_clinguin_context(inspected_object,O),_clinguin_context(inspect_open,true),0=#count{R:role(O,R)}.
attr(input(add_role,new_role),placeholder,"Role") :- object(O,_),_clinguin_context(inspected_object,O),_clinguin_context(inspect_open,true),0=#count{R:role(O,R)}.
when(input(add_role,new_role),input,context,(new_role,_value)) :- object(O,_),_clinguin_context(inspected_object,O),_clinguin_context(inspect_open,true),0=#count{R:role(O,R)}.


% Add Image: Image Path Input

elem(input(image_add,new_image_path),textfield,form_body(image_add)) :- object(O,_),_clinguin_context(inspected_object,O),_clinguin_context(inspect_open,true).
attr(input(image_add,new_image_path),order,1) :- object(O,_),_clinguin_context(inspected_object,O),_clinguin_context(inspect_open,true).
attr(input(image_add,new_image_path),placeholder,"Image path") :- object(O,_),_clinguin_context(inspected_object,O),_clinguin_context(inspect_open,true).
when(input(image_add,new_image_path),input,context,(new_image_path,_value)) :- object(O,_),_clinguin_context(inspected_object,O),_clinguin_context(inspect_open,true).

% Add Image: Previous Image Path

elem(previous(image_add,new_image_path),label,form_body(image_add)) :- object(O,_),_clinguin_context(inspected_object,O),_clinguin_context(inspect_open,true),_clinguin_context(new_image_path,V).
attr(previous(image_add,new_image_path),order,11) :- object(O,_),_clinguin_context(inspected_object,O),_clinguin_context(inspect_open,true),_clinguin_context(new_image_path,V).
attr(previous(image_add,new_image_path),label,@concat("Previous entry: ",V)) :- object(O,_),_clinguin_context(inspected_object,O),_clinguin_context(inspect_open,true),_clinguin_context(new_image_path,V).
attr(previous(image_add,new_image_path),class,("small";"text-secondary")) :- object(O,_),_clinguin_context(inspected_object,O),_clinguin_context(inspect_open,true),_clinguin_context(new_image_path,V).

% Add Image Form Actions

elem(form_actions(image_add),container,form_body(image_add)) :- object(O,_),_clinguin_context(inspected_object,O),_clinguin_context(inspect_open,true).
attr(form_actions(image_add),order,30) :- object(O,_),_clinguin_context(inspected_object,O),_clinguin_context(inspect_open,true).
attr(form_actions(image_add),class,("d-flex";"gap-2";"justify-content-end")) :- object(O,_),_clinguin_context(inspected_object,O),_clinguin_context(inspect_open,true).

% Add Image: Cancel Button

elem(cancel(image_add),button,form_actions(image_add)) :- object(O,_),_clinguin_context(inspected_object,O),_clinguin_context(inspect_open,true).
attr(cancel(image_add),label,"Cancel") :- object(O,_),_clinguin_context(inspected_object,O),_clinguin_context(inspect_open,true).
attr(cancel(image_add),class,"btn-outline-secondary") :- object(O,_),_clinguin_context(inspected_object,O),_clinguin_context(inspect_open,true).
when(cancel(image_add),click,context,(dialog,none)) :- object(O,_),_clinguin_context(inspected_object,O),_clinguin_context(inspect_open,true).
when(cancel(image_add),click,update,(dialog(form(image_add)),visibility,hidden)) :- object(O,_),_clinguin_context(inspected_object,O),_clinguin_context(inspect_open,true).

% Add Image: Save Image Button

elem(save(image_add,str),button,form_actions(image_add)) :- object(O,_),_clinguin_context(inspected_object,O),_clinguin_context(inspect_open,true).
attr(save(image_add,str),label,"Save image") :- object(O,_),_clinguin_context(inspected_object,O),_clinguin_context(inspect_open,true).
attr(save(image_add,str),class,"btn-primary") :- object(O,_),_clinguin_context(inspected_object,O),_clinguin_context(inspect_open,true).
when(save(image_add,str),click,update,(dialog(form(image_add)),visibility,hidden)) :- object(O,_),_clinguin_context(inspected_object,O),_clinguin_context(inspect_open,true).
when(save(image_add,str),click,context,(submitted,true)) :- object(O,_),_clinguin_context(inspected_object,O),_clinguin_context(inspect_open,true).
when(save(image_add,str),click,call,add_atom(image(O,_context_value(new_role,str),_context_value(new_image_path,str)))) :- object(O,_),role(O,R),_clinguin_context(inspected_object,O),_clinguin_context(inspect_open,true).

% Edit Image Dialog

elem(dialog(form(image_edit)),modal,w) :- object(O,_),_clinguin_context(inspected_object,O),_clinguin_context(inspect_open,true).
attr(dialog(form(image_edit)),title,"Edit image") :- object(O,_),_clinguin_context(inspected_object,O),_clinguin_context(inspect_open,true).
attr(dialog(form(image_edit)),visibility,shown) :- object(O,_),_clinguin_context(inspected_object,O),_clinguin_context(inspect_open,true),_clinguin_context(dialog,form(image_edit)),not _clinguin_context(submitted,true),not elem(commit(_,_,_),container,w).
attr(dialog(form(image_edit)),visibility,shown) :- object(O,_),_clinguin_context(inspected_object,O),_clinguin_context(inspect_open,true),_clinguin_context(dialog,form(image_edit)),_clinguin_unsat,not elem(commit(_,_,_),container,w).
attr(dialog(form(image_edit)),visibility,hidden) :- object(O,_),_clinguin_context(inspected_object,O),_clinguin_context(inspect_open,true),not _clinguin_context(dialog,form(image_edit)).
attr(dialog(form(image_edit)),visibility,hidden) :- object(O,_),_clinguin_context(inspected_object,O),_clinguin_context(inspect_open,true),_clinguin_context(submitted,true),not _clinguin_unsat.

% Edit Image Form Body

elem(form_body(image_edit),container,dialog_sheet(form(image_edit))) :- object(O,_),_clinguin_context(inspected_object,O),_clinguin_context(inspect_open,true).
attr(form_body(image_edit),class,("d-flex";"flex-column";"gap-3";"p-3")) :- object(O,_),_clinguin_context(inspected_object,O),_clinguin_context(inspect_open,true).

% Edit Image: Replacement Image Path Input

elem(input(image_edit,changed_image_path),textfield,form_body(image_edit)) :- object(O,_),_clinguin_context(inspected_object,O),_clinguin_context(inspect_open,true).
attr(input(image_edit,changed_image_path),placeholder,"Replacement image path") :- object(O,_),_clinguin_context(inspected_object,O),_clinguin_context(inspect_open,true).
attr(input(image_edit,changed_image_path),order,1) :- object(O,_),_clinguin_context(inspected_object,O),_clinguin_context(inspect_open,true).
when(input(image_edit,changed_image_path),input,context,(changed_image_path,_value)) :- object(O,_),_clinguin_context(inspected_object,O),_clinguin_context(inspect_open,true).

% Edit Image: Previous Replacement Image Path

elem(previous(image_edit,changed_image_path),label,form_body(image_edit)) :- object(O,_),_clinguin_context(inspected_object,O),_clinguin_context(inspect_open,true),_clinguin_context(changed_image_path,V).
attr(previous(image_edit,changed_image_path),order,11) :- object(O,_),_clinguin_context(inspected_object,O),_clinguin_context(inspect_open,true),_clinguin_context(changed_image_path,V).
attr(previous(image_edit,changed_image_path),label,@concat("Previous entry: ",V)) :- object(O,_),_clinguin_context(inspected_object,O),_clinguin_context(inspect_open,true),_clinguin_context(changed_image_path,V).
attr(previous(image_edit,changed_image_path),class,("small";"text-secondary")) :- object(O,_),_clinguin_context(inspected_object,O),_clinguin_context(inspect_open,true),_clinguin_context(changed_image_path,V).

% Edit Image Form Actions

elem(form_actions(image_edit),container,form_body(image_edit)) :- object(O,_),_clinguin_context(inspected_object,O),_clinguin_context(inspect_open,true).
attr(form_actions(image_edit),order,30) :- object(O,_),_clinguin_context(inspected_object,O),_clinguin_context(inspect_open,true).
attr(form_actions(image_edit),class,("d-flex";"gap-2";"justify-content-end")) :- object(O,_),_clinguin_context(inspected_object,O),_clinguin_context(inspect_open,true).

% Edit Image: Cancel Button

elem(cancel(image_edit),button,form_actions(image_edit)) :- object(O,_),_clinguin_context(inspected_object,O),_clinguin_context(inspect_open,true).
attr(cancel(image_edit),label,"Cancel") :- object(O,_),_clinguin_context(inspected_object,O),_clinguin_context(inspect_open,true).
attr(cancel(image_edit),class,"btn-outline-secondary") :- object(O,_),_clinguin_context(inspected_object,O),_clinguin_context(inspect_open,true).
when(cancel(image_edit),click,context,(dialog,none)) :- object(O,_),_clinguin_context(inspected_object,O),_clinguin_context(inspect_open,true).
when(cancel(image_edit),click,update,(dialog(form(image_edit)),visibility,hidden)) :- object(O,_),_clinguin_context(inspected_object,O),_clinguin_context(inspect_open,true).

% Edit Image: Save Image Button

elem(save(image_edit,str),button,form_actions(image_edit)) :- object(O,_),_clinguin_context(inspected_object,O),_clinguin_context(inspect_open,true).
attr(save(image_edit,str),label,"Save image") :- object(O,_),_clinguin_context(inspected_object,O),_clinguin_context(inspect_open,true).
attr(save(image_edit,str),class,"btn-primary") :- object(O,_),_clinguin_context(inspected_object,O),_clinguin_context(inspect_open,true).
when(save(image_edit,str),click,context,(submitted,true)) :- object(O,_),_clinguin_context(inspected_object,O),_clinguin_context(inspect_open,true).
when(save(image_edit,str),click,call,(remove_atom(image(_context_value(edit_image_object),_context_value(edit_image_role),_context_value(edit_image_path))),add_atom(image(O,_context_value(edit_image_role),_context_value(changed_image_path,str))))) :- object(O,_),_clinguin_context(inspected_object,O),_clinguin_context(inspect_open,true).



% Add Role Dialog

elem(dialog(form(add_role)),modal,w) :- object(O,_),_clinguin_context(inspected_object,O),_clinguin_context(inspect_open,true).
attr(dialog(form(add_role)),title,"Add Role") :- object(O,_),_clinguin_context(inspected_object,O),_clinguin_context(inspect_open,true).
attr(dialog(form(add_role)),visibility,shown) :- object(O,_),_clinguin_context(inspected_object,O),_clinguin_context(inspect_open,true),_clinguin_context(dialog,form(add_role)),not _clinguin_context(submitted,true),not elem(commit(_,_,_),container,w).
attr(dialog(form(add_role)),visibility,shown) :- object(O,_),_clinguin_context(inspected_object,O),_clinguin_context(inspect_open,true),_clinguin_context(dialog,form(add_role)),_clinguin_unsat,not elem(commit(_,_,_),container,w).
attr(dialog(form(add_role)),visibility,hidden) :- object(O,_),_clinguin_context(inspected_object,O),_clinguin_context(inspect_open,true),not _clinguin_context(dialog,form(add_role)).
attr(dialog(form(add_role)),visibility,hidden) :- object(O,_),_clinguin_context(inspected_object,O),_clinguin_context(inspect_open,true),_clinguin_context(submitted,true),not _clinguin_unsat.

% Add ROle Form Body

elem(form_body(add_role),container,dialog_sheet(form(add_role))) :- object(O,_),_clinguin_context(inspected_object,O),_clinguin_context(inspect_open,true).
attr(form_body(add_role),class,("d-flex";"flex-column";"gap-3";"p-3")) :- object(O,_),_clinguin_context(inspected_object,O),_clinguin_context(inspect_open,true).

% Role Input

elem(input(add_role,new_role),textfield,form_body(add_role)) :- object(O,_),_clinguin_context(inspected_object,O),_clinguin_context(inspect_open,true),0=#count{R:role(O,R)}.
attr(input(add_role,new_role),order,1) :- object(O,_),_clinguin_context(inspected_object,O),_clinguin_context(inspect_open,true),0=#count{R:role(O,R)}.
attr(input(add_role,new_role),placeholder,"Role") :- object(O,_),_clinguin_context(inspected_object,O),_clinguin_context(inspect_open,true),0=#count{R:role(O,R)}.
when(input(add_role,new_role),input,context,(new_role,_value)) :- object(O,_),_clinguin_context(inspected_object,O),_clinguin_context(inspect_open,true),0=#count{R:role(O,R)}.



% Role Actions

elem(form_actions(add_role),container,form_body(add_role)) :- object(O,_),_clinguin_context(inspected_object,O),_clinguin_context(inspect_open,true).
attr(form_actions(add_role),order,30) :- object(O,_),_clinguin_context(inspected_object,O),_clinguin_context(inspect_open,true).
attr(form_actions(add_role),class,("d-flex";"gap-2";"justify-content-end")) :- object(O,_),_clinguin_context(inspected_object,O),_clinguin_context(inspect_open,true).

% Cancel Role

elem(cancel(add_role),button,form_actions(add_role)) :- object(O,_),_clinguin_context(inspected_object,O),_clinguin_context(inspect_open,true).
attr(cancel(add_role),label,"Cancel") :- object(O,_),_clinguin_context(inspected_object,O),_clinguin_context(inspect_open,true).
attr(cancel(add_role),class,"btn-outline-secondary") :- object(O,_),_clinguin_context(inspected_object,O),_clinguin_context(inspect_open,true).
when(cancel(add_role),click,context,(dialog,none)) :- object(O,_),_clinguin_context(inspected_object,O),_clinguin_context(inspect_open,true).
when(cancel(add_role),click,update,(dialog(form(add_role)),visibility,hidden)) :- object(O,_),_clinguin_context(inspected_object,O),_clinguin_context(inspect_open,true).

% Save  Role

elem(save(add_role,str),button,form_actions(add_role)) :- object(O,_),_clinguin_context(inspected_object,O),_clinguin_context(inspect_open,true).
attr(save(add_role,str),label,"Save Role") :- object(O,_),_clinguin_context(inspected_object,O),_clinguin_context(inspect_open,true).
attr(save(add_role,str),class,"btn-primary") :- object(O,_),_clinguin_context(inspected_object,O),_clinguin_context(inspect_open,true).
when(save(add_role,str),click,context,(submitted,true)) :- object(O,_),_clinguin_context(inspected_object,O),_clinguin_context(inspect_open,true).
when(save(add_role,str),click,update,(dialog(form(add_role)),visibility,hidden)) :- object(O,_),_clinguin_context(inspected_object,O),_clinguin_context(inspect_open,true).
when(save(add_role,str),click,call,add_atom(role(O,_context_value(new_role,str)))) :- object(O,_),_clinguin_context(inspected_object,O),_clinguin_context(inspect_open,true).
