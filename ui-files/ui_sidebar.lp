
% Catalogue header and summary cards.

elem(sidebar_header,container,sidebar_panel).
attr(sidebar_header,order,1).

elem(sidebar_title,label,sidebar_header).
attr(sidebar_title,label,"Object catalogue").
elem(sidebar_subtitle,label,sidebar_header).
attr(sidebar_subtitle,label,"Select an object to place it on the grid.").

elem(summary,container,sidebar_panel).
attr(summary,order,2).
elem(summary_objects,label,summary_tile(0)).
elem(summary_tile(0),container,summary).
attr(summary_objects,label,@concat("Objects · ",N)) :- N=#count{O:object(O,_)}.
elem(summary_properties,label,summary_tile(1)).
elem(summary_tile(1),container,summary).
attr(summary_properties,label,@concat("Properties · ",N)) :- N=#count{O,K,V:object(O,_),property(O,K,V)}.
elem(summary_positions,label,summary_tile(2)).
elem(summary_tile(2),container,summary).
attr(summary_positions,label,@concat("Positions · ",N)) :- N=#count{Node,R,O:elem(placement(Node,R,O),container,_)}.
elem(summary_edits,label,summary_tile(3)).
elem(summary_tile(3),container,summary).
attr(summary_edits,label,@concat("Edits · ",N)) :- A=#count{X:_clinguin_atom(X)},B=#count{M,O,T:_clinguin_atom(request(M,O,T))},N=A-B.
elem(catalogue,container,sidebar_panel).
attr(catalogue,order,3).

elem(catalogue_add,button,catalogue_toolbar).
attr(catalogue_add,label,"Add object").
when(catalogue_add,click,context,(dialog,form(object_create))).
when(catalogue_add,click,update,(dialog(form(object_create)),visibility,shown)).
when(catalogue_add,click,update,(local_feedback,visibility,hidden)).

elem(catalogue_empty,label,catalogue) :- not object(_,_).
attr(catalogue_empty,label,"No objects available. Create an object to begin.") :- not object(_,_).
attr(catalogue_empty,class,("p-4";"text-muted";"text-center")) :- not object(_,_).

elem(catalogue_list,container,catalogue) :- object(_,_).
elem(type_group(T),container,catalogue_list) :- object(_,T).
attr(type_group(T),order,N) :- object(_,T),N=#count{T2:object(_,T2),T2<T}.
elem(type_title(T),label,type_heading(T)) :- object(_,T).
attr(type_title(T),label,@concat(T," · ",N," objects")) :- object(_,T),N=#count{O:object(O,T)}.
elem(object_card(O,T),container,type_items(T)) :- object(O,T).
attr(object_card(O,T),order,N+10) :- object(O,T),N=#count{Other:object(Other,T),Other<O}.
elem(object_media(O,T),canvas,object_card(O,T)) :- object(O,T),image(O,R,I),I!="",I!=" ",visual(O,R,_,_,_,_,true),(R,I)=#min{(R2,I2):image(O,R2,I2),I2!="",I2!=" ",visual(O,R2,_,_,_,_,true)}.
attr(object_media(O,T),image,I) :- object(O,T),image(O,R,I),I!="",I!=" ",visual(O,R,_,_,_,_,true),(R,I)=#min{(R2,I2):image(O,R2,I2),I2!="",I2!=" ",visual(O,R2,_,_,_,_,true)}.
elem(object_media(O,T),canvas,object_card(O,T)) :- object(O,T),image(O,R,I),I!="",I!=" ",0=#count{R2,I2:image(O,R2,I2),I2!="",I2!=" ",visual(O,R2,_,_,_,_,true)},(R,I)=#min{(R3,I3):image(O,R3,I3),I3!="",I3!=" "}.
attr(object_media(O,T),image,I) :- object(O,T),image(O,R,I),I!="",I!=" ",0=#count{R2,I2:image(O,R2,I2),I2!="",I2!=" ",visual(O,R2,_,_,_,_,true)},(R,I)=#min{(R3,I3):image(O,R3,I3),I3!="",I3!=" "}.
attr(object_media(O,T),width,40) :- elem(object_media(O,T),canvas,_).
attr(object_media(O,T),height,40) :- elem(object_media(O,T),canvas,_).
elem(object_body(O,T),label,object_info(O,T)) :- object(O,T).
attr(object_body(O,T),label,@concat("",O)) :- object(O,T).

elem(object_select(O,T),button,object_actions(O,T)) :- object(O,T).
attr(object_select(O,T),label,"Select") :- object(O,T),not _clinguin_context(selected_object,O).
attr(object_select(O,T),label,"Selected") :- object(O,T),_clinguin_context(selected_object,O).
attr(object_select(O,T),class,"btn-outline-primary") :- object(O,T),not _clinguin_context(selected_object,O).
attr(object_select(O,T),class,"btn-primary") :- object(O,T),_clinguin_context(selected_object,O).

elem(object_delete(O,T),button,object_actions(O,T)) :- object(O,T),_clinguin_atom(object(O,T)).
attr(object_delete(O,T),label,"Delete") :- elem(object_delete(O,T),button,_).
attr(object_delete(O,T),class,"btn-outline-danger") :- elem(object_delete(O,T),button,_).

% Inspector reads generic properties, roles, positions, images and issues.

elem(dialog(inspector),container,w) :- _clinguin_context(selected_object,O),object(O,_),_clinguin_context(inspector_open,true).
attr(dialog(inspector),visibility,shown) :- _clinguin_context(selected_object,O),object(O,_),_clinguin_context(inspector_open,true).
attr(dialog_title(inspector),label,@concat("Object inspector · ",O)) :- _clinguin_context(selected_object,O),object(O,_),_clinguin_context(inspector_open,true).

elem(inspector_content,container,dialog_sheet(inspector)) :- _clinguin_context(selected_object,O),object(O,_),_clinguin_context(inspector_open,true).
attr(inspector_content,"display","flex") :- _clinguin_context(selected_object,O),object(O,_),_clinguin_context(inspector_open,true).
attr(inspector_content,"flex-direction","column") :- _clinguin_context(selected_object,O),object(O,_),_clinguin_context(inspector_open,true).
attr(inspector_content,"gap","12px") :- _clinguin_context(selected_object,O),object(O,_),_clinguin_context(inspector_open,true).
attr(inspector_content,"padding","20px") :- _clinguin_context(selected_object,O),object(O,_),_clinguin_context(inspector_open,true).
attr(inspector_content,"max-height","78vh") :- _clinguin_context(selected_object,O),object(O,_),_clinguin_context(inspector_open,true).
attr(inspector_content,"overflow","auto") :- _clinguin_context(selected_object,O),object(O,_),_clinguin_context(inspector_open,true).

elem(inspector_identity,label,inspector_content) :- _clinguin_context(selected_object,O),object(O,_),_clinguin_context(inspector_open,true).
attr(inspector_identity,label,@concat("object(",O,", ",T,")")) :- _clinguin_context(selected_object,O),object(O,_),_clinguin_context(inspector_open,true),object(O,T).
attr(inspector_identity,class,("font-monospace";"fw-bold";"text-primary")) :- _clinguin_context(selected_object,O),object(O,_),_clinguin_context(inspector_open,true).

elem(inspector_type_edit,button,inspector_content) :- _clinguin_context(selected_object,O),object(O,_),_clinguin_context(inspector_open,true),_clinguin_atom(object(O,T)).
attr(inspector_type_edit,label,"Edit type") :- elem(inspector_type_edit,button,_).
attr(inspector_type_edit,class,("btn-outline-primary";"align-self-start")) :- elem(inspector_type_edit,button,_).
when(inspector_type_edit,click,context,(dialog,form(object_edit))) :- elem(inspector_type_edit,button,_).
when(inspector_type_edit,click,update,(dialog(form(object_edit)),visibility,shown)) :- elem(inspector_type_edit,button,_).
when(inspector_type_edit,click,update,(local_feedback,visibility,hidden)) :- elem(inspector_type_edit,button,_).
when(inspector_type_edit,click,context,(new_type,T)) :- _clinguin_context(selected_object,O),object(O,_),_clinguin_context(inspector_open,true),object(O,T),_clinguin_atom(object(O,T)).

elem(inspector_status,label,inspector_content) :- _clinguin_context(selected_object,O),object(O,_),_clinguin_context(inspector_open,true).
attr(inspector_status,label,"Needs correction") :- _clinguin_context(selected_object,O),object(O,_),_clinguin_context(inspector_open,true),issue(O,error,_,_).
attr(inspector_status,class,("fw-bold";"text-danger")) :- _clinguin_context(selected_object,O),object(O,_),_clinguin_context(inspector_open,true),issue(O,error,_,_).
attr(inspector_status,label,"Incomplete — review the warnings below") :- _clinguin_context(selected_object,O),object(O,_),_clinguin_context(inspector_open,true),not issue(O,error,_,_),issue(O,warning,_,_).
attr(inspector_status,class,("fw-bold";"text-warning")) :- _clinguin_context(selected_object,O),object(O,_),_clinguin_context(inspector_open,true),not issue(O,error,_,_),issue(O,warning,_,_).
attr(inspector_status,label,"Complete") :- _clinguin_context(selected_object,O),object(O,_),_clinguin_context(inspector_open,true),not issue(O,_,_,_),0<#count{property,K:property_schema(O,K,_,true);position,R:role(O,R,_,Min,_),Min>0}.
attr(inspector_status,label,"Ready — no declared requirements") :- _clinguin_context(selected_object,O),object(O,_),_clinguin_context(inspector_open,true),not issue(O,_,_,_),0=#count{property,K:property_schema(O,K,_,true);position,R:role(O,R,_,Min,_),Min>0}.
elem(required_properties,label,inspector_content) :- _clinguin_context(selected_object,O),object(O,_),_clinguin_context(inspector_open,true),property_schema(O,_,_,true).
attr(required_properties,label,@concat("Required properties · ",Have,"/",Total)) :- _clinguin_context(selected_object,O),object(O,_),_clinguin_context(inspector_open,true),property_schema(O,_,_,true),Total=#count{K:property_schema(O,K,_,true)},Have=#count{K:property_schema(O,K,_,true),property(O,K,_)}.
elem(role_requirement(O,R),label,inspector_content) :- _clinguin_context(selected_object,O),object(O,_),_clinguin_context(inspector_open,true),role(O,R,_,Min,_),Min>0.
attr(role_requirement(O,R),label,@concat("Required ",R," positions · ",N,"/",Min)) :- _clinguin_context(selected_object,O),object(O,_),_clinguin_context(inspector_open,true),role(O,R,_,Min,_),Min>0,N=#count{Node:elem(placement(Node,R,O),container,_)}.
elem(inspector_issue(O,Severity,F,M),label,inspector_content) :- _clinguin_context(selected_object,O),object(O,_),_clinguin_context(inspector_open,true),issue(O,Severity,F,M).
attr(inspector_issue(O,Severity,F,M),label,@concat(Severity," · ",F," · ",M)) :- _clinguin_context(selected_object,O),object(O,_),_clinguin_context(inspector_open,true),issue(O,Severity,F,M).
attr(inspector_issue(O,error,F,M),class,("small";"text-danger";"bg-light";"p-2";"rounded-3")) :- _clinguin_context(selected_object,O),object(O,_),_clinguin_context(inspector_open,true),issue(O,error,F,M).
attr(inspector_issue(O,warning,F,M),class,("small";"text-warning";"bg-light";"p-2";"rounded-3")) :- _clinguin_context(selected_object,O),object(O,_),_clinguin_context(inspector_open,true),issue(O,warning,F,M).
elem(properties_section,container,inspector_content) :- _clinguin_context(selected_object,O),object(O,_),_clinguin_context(inspector_open,true).
attr(properties_section,class,("d-flex";"flex-column";"gap-2";"border";"rounded-3";"p-2")) :- _clinguin_context(selected_object,O),object(O,_),_clinguin_context(inspector_open,true).
elem(properties_title,label,properties_section) :- _clinguin_context(selected_object,O),object(O,_),_clinguin_context(inspector_open,true).
attr(properties_title,label,"Properties") :- _clinguin_context(selected_object,O),object(O,_),_clinguin_context(inspector_open,true).
attr(properties_title,class,"fw-bold") :- _clinguin_context(selected_object,O),object(O,_),_clinguin_context(inspector_open,true).
elem(property_add,button,properties_section) :- _clinguin_context(selected_object,O),object(O,_),_clinguin_context(inspector_open,true).
attr(property_add,label,"Add") :- _clinguin_context(selected_object,O),object(O,_),_clinguin_context(inspector_open,true).
attr(property_add,class,("btn-primary";"align-self-end")) :- _clinguin_context(selected_object,O),object(O,_),_clinguin_context(inspector_open,true).
when(property_add,click,context,(dialog,form(property_add))) :- _clinguin_context(selected_object,O),object(O,_),_clinguin_context(inspector_open,true).
when(property_add,click,update,(dialog(form(property_add)),visibility,shown)) :- _clinguin_context(selected_object,O),object(O,_),_clinguin_context(inspector_open,true).
when(property_add,click,update,(local_feedback,visibility,hidden)) :- _clinguin_context(selected_object,O),object(O,_),_clinguin_context(inspector_open,true).
elem(positions_section,container,inspector_content) :- _clinguin_context(selected_object,O),object(O,_),_clinguin_context(inspector_open,true).
attr(positions_section,class,("d-flex";"flex-column";"gap-2";"border";"rounded-3";"p-2")) :- _clinguin_context(selected_object,O),object(O,_),_clinguin_context(inspector_open,true).
elem(positions_title,label,positions_section) :- _clinguin_context(selected_object,O),object(O,_),_clinguin_context(inspector_open,true).
attr(positions_title,label,"Positions") :- _clinguin_context(selected_object,O),object(O,_),_clinguin_context(inspector_open,true).
attr(positions_title,class,"fw-bold") :- _clinguin_context(selected_object,O),object(O,_),_clinguin_context(inspector_open,true).

elem(position_add,button,positions_section) :- _clinguin_context(selected_object,O),object(O,_),_clinguin_context(inspector_open,true),_clinguin_context(placement_role,R),role(O,R,_,_,_),not issue(O,error,_,_),not issue(O,warning,property(_),_).
attr(position_add,label,"Add") :- _clinguin_context(selected_object,O),object(O,_),_clinguin_context(inspector_open,true),_clinguin_context(placement_role,R),role(O,R,_,_,_),not issue(O,error,_,_),not issue(O,warning,property(_),_).
attr(position_add,class,("btn-primary";"align-self-end")) :- _clinguin_context(selected_object,O),object(O,_),_clinguin_context(inspector_open,true),_clinguin_context(placement_role,R),role(O,R,_,_,_),not issue(O,error,_,_),not issue(O,warning,property(_),_).
when(position_add,click,context,(dialog,form(position_add))) :- _clinguin_context(selected_object,O),object(O,_),_clinguin_context(inspector_open,true),_clinguin_context(placement_role,R),role(O,R,_,_,_),not issue(O,error,_,_),not issue(O,warning,property(_),_).
when(position_add,click,update,(dialog(form(position_add)),visibility,shown)) :- _clinguin_context(selected_object,O),object(O,_),_clinguin_context(inspector_open,true),_clinguin_context(placement_role,R),role(O,R,_,_,_),not issue(O,error,_,_),not issue(O,warning,property(_),_).
when(position_add,click,update,(local_feedback,visibility,hidden)) :- _clinguin_context(selected_object,O),object(O,_),_clinguin_context(inspector_open,true),_clinguin_context(placement_role,R),role(O,R,_,_,_),not issue(O,error,_,_),not issue(O,warning,property(_),_).
elem(images_section,container,inspector_content) :- _clinguin_context(selected_object,O),object(O,_),_clinguin_context(inspector_open,true).
attr(images_section,class,("d-flex";"flex-column";"gap-2";"border";"rounded-3";"p-2")) :- _clinguin_context(selected_object,O),object(O,_),_clinguin_context(inspector_open,true).
elem(images_title,label,images_section) :- _clinguin_context(selected_object,O),object(O,_),_clinguin_context(inspector_open,true).
attr(images_title,label,"Images") :- _clinguin_context(selected_object,O),object(O,_),_clinguin_context(inspector_open,true).
attr(images_title,class,"fw-bold") :- _clinguin_context(selected_object,O),object(O,_),_clinguin_context(inspector_open,true).
elem(image_add,button,images_section) :- _clinguin_context(selected_object,O),object(O,_),_clinguin_context(inspector_open,true),_clinguin_context(placement_role,R),role(O,R,_,_,_),not issue(O,error,_,_),not issue(O,warning,property(_),_).
attr(image_add,label,"Add") :- _clinguin_context(selected_object,O),object(O,_),_clinguin_context(inspector_open,true),_clinguin_context(placement_role,R),role(O,R,_,_,_),not issue(O,error,_,_),not issue(O,warning,property(_),_).
attr(image_add,class,("btn-primary";"align-self-end")) :- _clinguin_context(selected_object,O),object(O,_),_clinguin_context(inspector_open,true),_clinguin_context(placement_role,R),role(O,R,_,_,_),not issue(O,error,_,_),not issue(O,warning,property(_),_).
when(image_add,click,context,(dialog,form(image_add))) :- _clinguin_context(selected_object,O),object(O,_),_clinguin_context(inspector_open,true),_clinguin_context(placement_role,R),role(O,R,_,_,_),not issue(O,error,_,_),not issue(O,warning,property(_),_).
when(image_add,click,update,(dialog(form(image_add)),visibility,shown)) :- _clinguin_context(selected_object,O),object(O,_),_clinguin_context(inspector_open,true),_clinguin_context(placement_role,R),role(O,R,_,_,_),not issue(O,error,_,_),not issue(O,warning,property(_),_).
when(image_add,click,update,(local_feedback,visibility,hidden)) :- _clinguin_context(selected_object,O),object(O,_),_clinguin_context(inspector_open,true),_clinguin_context(placement_role,R),role(O,R,_,_,_),not issue(O,error,_,_),not issue(O,warning,property(_),_).
elem(properties_empty,label,properties_section) :- _clinguin_context(selected_object,O),object(O,_),_clinguin_context(inspector_open,true),not property(O,_,_).
attr(properties_empty,label,"No properties.") :- elem(properties_empty,label,_).
elem(property_row(O,K,V),container,properties_section) :- _clinguin_context(selected_object,O),object(O,_),_clinguin_context(inspector_open,true),property(O,K,V).
attr(property_row(O,K,V),class,("d-flex";"gap-2";"align-items-center";"border";"rounded-2";"p-2")) :- _clinguin_context(selected_object,O),object(O,_),_clinguin_context(inspector_open,true),property(O,K,V).
attr(property_row(O,K,V),order,N+10) :- _clinguin_context(selected_object,O),object(O,_),_clinguin_context(inspector_open,true),property(O,K,V),N=#count{K2,V2:property(O,K2,V2),(K2,V2)<(K,V)}.
elem(property_text(O,K,V),label,property_row(O,K,V)) :- _clinguin_context(selected_object,O),object(O,_),_clinguin_context(inspector_open,true),property(O,K,V).
attr(property_text(O,K,V),label,@concat(K," = ",V)) :- _clinguin_context(selected_object,O),object(O,_),_clinguin_context(inspector_open,true),property(O,K,V).
attr(property_text(O,K,V),class,("font-monospace";"small";"flex-grow-1")) :- _clinguin_context(selected_object,O),object(O,_),_clinguin_context(inspector_open,true),property(O,K,V).
elem(property_edit(O,K,V),button,property_row(O,K,V)) :- _clinguin_context(selected_object,O),object(O,_),_clinguin_context(inspector_open,true),property(O,K,V),_clinguin_atom(property(O,K,V)).
attr(property_edit(O,K,V),label,"Edit") :- _clinguin_context(selected_object,O),object(O,_),_clinguin_context(inspector_open,true),property(O,K,V),_clinguin_atom(property(O,K,V)).
attr(property_edit(O,K,V),class,"btn-outline-primary") :- _clinguin_context(selected_object,O),object(O,_),_clinguin_context(inspector_open,true),property(O,K,V),_clinguin_atom(property(O,K,V)).
when(property_edit(O,K,V),click,context,(dialog,form(property_edit))) :- _clinguin_context(selected_object,O),object(O,_),_clinguin_context(inspector_open,true),property(O,K,V),_clinguin_atom(property(O,K,V)).
when(property_edit(O,K,V),click,update,(dialog(form(property_edit)),visibility,shown)) :- _clinguin_context(selected_object,O),object(O,_),_clinguin_context(inspector_open,true),property(O,K,V),_clinguin_atom(property(O,K,V)).
when(property_edit(O,K,V),click,update,(local_feedback,visibility,hidden)) :- _clinguin_context(selected_object,O),object(O,_),_clinguin_context(inspector_open,true),property(O,K,V),_clinguin_atom(property(O,K,V)).
when(property_edit(O,K,V),click,context,(edit_property_object,O)) :- _clinguin_context(selected_object,O),object(O,_),_clinguin_context(inspector_open,true),property(O,K,V),_clinguin_atom(property(O,K,V)).
when(property_edit(O,K,V),click,context,(edit_property_key,K)) :- _clinguin_context(selected_object,O),object(O,_),_clinguin_context(inspector_open,true),property(O,K,V),_clinguin_atom(property(O,K,V)).
when(property_edit(O,K,V),click,context,(edit_property_value,V)) :- _clinguin_context(selected_object,O),object(O,_),_clinguin_context(inspector_open,true),property(O,K,V),_clinguin_atom(property(O,K,V)).
when(property_edit(O,K,V),click,context,(changed_property_key,K)) :- _clinguin_context(selected_object,O),object(O,_),_clinguin_context(inspector_open,true),property(O,K,V),_clinguin_atom(property(O,K,V)).
when(property_edit(O,K,V),click,context,(changed_property_value,V)) :- _clinguin_context(selected_object,O),object(O,_),_clinguin_context(inspector_open,true),property(O,K,V),_clinguin_atom(property(O,K,V)).
elem(property_remove(O,K,V),button,property_row(O,K,V)) :- _clinguin_context(selected_object,O),object(O,_),_clinguin_context(inspector_open,true),property(O,K,V),_clinguin_atom(property(O,K,V)).
attr(property_remove(O,K,V),label,"Delete") :- _clinguin_context(selected_object,O),object(O,_),_clinguin_context(inspector_open,true),property(O,K,V),_clinguin_atom(property(O,K,V)).
attr(property_remove(O,K,V),class,"btn-outline-danger") :- _clinguin_context(selected_object,O),object(O,_),_clinguin_context(inspector_open,true),property(O,K,V),_clinguin_atom(property(O,K,V)).
when(property_remove(O,K,V),click,call,remove_atom(property(O,K,V))) :- _clinguin_context(selected_object,O),object(O,_),_clinguin_context(inspector_open,true),property(O,K,V),_clinguin_atom(property(O,K,V)).
elem(positions_empty,label,positions_section) :- _clinguin_context(selected_object,O),object(O,_),_clinguin_context(inspector_open,true),not elem(placement(_,_,O),container,_).
attr(positions_empty,label,"No visible positions.") :- elem(positions_empty,label,_).
elem(position_row(O,N,R),container,positions_section) :- _clinguin_context(selected_object,O),object(O,_),_clinguin_context(inspector_open,true),elem(placement(N,R,O),container,_).
attr(position_row(O,N,R),class,("d-flex";"gap-2";"align-items-center";"border";"rounded-2";"p-2")) :- _clinguin_context(selected_object,O),object(O,_),_clinguin_context(inspector_open,true),elem(placement(N,R,O),container,_).
attr(position_row(O,N,R),order,Count+10) :- _clinguin_context(selected_object,O),object(O,_),_clinguin_context(inspector_open,true),elem(placement(N,R,O),container,_),Count=#count{N2,R2:elem(placement(N2,R2,O),container,_),(N2,R2)<(N,R)}.
elem(position_text(O,N,R),label,position_row(O,N,R)) :- _clinguin_context(selected_object,O),object(O,_),_clinguin_context(inspector_open,true),elem(placement(N,R,O),container,_).
attr(position_text(O,N,R),label,@concat(N," · ",R)) :- _clinguin_context(selected_object,O),object(O,_),_clinguin_context(inspector_open,true),elem(placement(N,R,O),container,_).
attr(position_text(O,N,R),class,("font-monospace";"small";"flex-grow-1")) :- _clinguin_context(selected_object,O),object(O,_),_clinguin_context(inspector_open,true),elem(placement(N,R,O),container,_).
elem(position_edit(O,N,R),button,position_row(O,N,R)) :- _clinguin_context(selected_object,O),object(O,_),_clinguin_context(inspector_open,true),elem(placement(N,R,O),container,_),_clinguin_atom(position(N,R,O)).
attr(position_edit(O,N,R),label,"Move") :- _clinguin_context(selected_object,O),object(O,_),_clinguin_context(inspector_open,true),elem(placement(N,R,O),container,_),_clinguin_atom(position(N,R,O)).
attr(position_edit(O,N,R),class,"btn-outline-primary") :- _clinguin_context(selected_object,O),object(O,_),_clinguin_context(inspector_open,true),elem(placement(N,R,O),container,_),_clinguin_atom(position(N,R,O)).
when(position_edit(O,N,R),click,context,(dialog,form(position_edit))) :- _clinguin_context(selected_object,O),object(O,_),_clinguin_context(inspector_open,true),elem(placement(N,R,O),container,_),_clinguin_atom(position(N,R,O)).
when(position_edit(O,N,R),click,update,(dialog(form(position_edit)),visibility,shown)) :- _clinguin_context(selected_object,O),object(O,_),_clinguin_context(inspector_open,true),elem(placement(N,R,O),container,_),_clinguin_atom(position(N,R,O)).
when(position_edit(O,N,R),click,update,(local_feedback,visibility,hidden)) :- _clinguin_context(selected_object,O),object(O,_),_clinguin_context(inspector_open,true),elem(placement(N,R,O),container,_),_clinguin_atom(position(N,R,O)).
when(position_edit(O,N,R),click,context,(edit_position_object,O)) :- _clinguin_context(selected_object,O),object(O,_),_clinguin_context(inspector_open,true),elem(placement(N,R,O),container,_),_clinguin_atom(position(N,R,O)),N=(Row,Col).
when(position_edit(O,N,R),click,context,(edit_position_row,Row)) :- _clinguin_context(selected_object,O),object(O,_),_clinguin_context(inspector_open,true),elem(placement(N,R,O),container,_),_clinguin_atom(position(N,R,O)),N=(Row,Col).
when(position_edit(O,N,R),click,context,(edit_position_col,Col)) :- _clinguin_context(selected_object,O),object(O,_),_clinguin_context(inspector_open,true),elem(placement(N,R,O),container,_),_clinguin_atom(position(N,R,O)),N=(Row,Col).
when(position_edit(O,N,R),click,context,(edit_position_role,R)) :- _clinguin_context(selected_object,O),object(O,_),_clinguin_context(inspector_open,true),elem(placement(N,R,O),container,_),_clinguin_atom(position(N,R,O)),N=(Row,Col).
when(position_edit(O,N,R),click,context,(changed_row,Row)) :- _clinguin_context(selected_object,O),object(O,_),_clinguin_context(inspector_open,true),elem(placement(N,R,O),container,_),_clinguin_atom(position(N,R,O)),N=(Row,Col).
when(position_edit(O,N,R),click,context,(changed_column,Col)) :- _clinguin_context(selected_object,O),object(O,_),_clinguin_context(inspector_open,true),elem(placement(N,R,O),container,_),_clinguin_atom(position(N,R,O)),N=(Row,Col).
elem(position_remove(O,N,R),button,position_row(O,N,R)) :- _clinguin_context(selected_object,O),object(O,_),_clinguin_context(inspector_open,true),elem(placement(N,R,O),container,_),_clinguin_atom(position(N,R,O)).
attr(position_remove(O,N,R),label,"Delete") :- _clinguin_context(selected_object,O),object(O,_),_clinguin_context(inspector_open,true),elem(placement(N,R,O),container,_),_clinguin_atom(position(N,R,O)).
attr(position_remove(O,N,R),class,"btn-outline-danger") :- _clinguin_context(selected_object,O),object(O,_),_clinguin_context(inspector_open,true),elem(placement(N,R,O),container,_),_clinguin_atom(position(N,R,O)).
elem(images_empty,label,images_section) :- _clinguin_context(selected_object,O),object(O,_),_clinguin_context(inspector_open,true),0=#count{R,I:image(O,R,I),I!="",I!=" "}.
attr(images_empty,label,"No nonempty image paths.") :- elem(images_empty,label,_).
elem(image_row(O,R,I),container,images_section) :- _clinguin_context(selected_object,O),object(O,_),_clinguin_context(inspector_open,true),image(O,R,I),I!="",I!=" ".
attr(image_row(O,R,I),class,("d-flex";"gap-2";"align-items-center";"border";"rounded-2";"p-2")) :- _clinguin_context(selected_object,O),object(O,_),_clinguin_context(inspector_open,true),image(O,R,I),I!="",I!=" ".
elem(image_preview(O,R,I),canvas,image_row(O,R,I)) :- _clinguin_context(selected_object,O),object(O,_),_clinguin_context(inspector_open,true),image(O,R,I),I!="",I!=" ".
attr(image_preview(O,R,I),image,I) :- _clinguin_context(selected_object,O),object(O,_),_clinguin_context(inspector_open,true),image(O,R,I),I!="",I!=" ".
attr(image_preview(O,R,I),width,38) :- _clinguin_context(selected_object,O),object(O,_),_clinguin_context(inspector_open,true),image(O,R,I),I!="",I!=" ".
attr(image_preview(O,R,I),height,38) :- _clinguin_context(selected_object,O),object(O,_),_clinguin_context(inspector_open,true),image(O,R,I),I!="",I!=" ".
elem(image_text(O,R,I),label,image_row(O,R,I)) :- _clinguin_context(selected_object,O),object(O,_),_clinguin_context(inspector_open,true),image(O,R,I),I!="",I!=" ".
attr(image_text(O,R,I),label,@concat(R," · ",I)) :- _clinguin_context(selected_object,O),object(O,_),_clinguin_context(inspector_open,true),image(O,R,I),I!="",I!=" ".
attr(image_text(O,R,I),class,("font-monospace";"small";"flex-grow-1")) :- _clinguin_context(selected_object,O),object(O,_),_clinguin_context(inspector_open,true),image(O,R,I),I!="",I!=" ".
elem(image_edit(O,R,I),button,image_row(O,R,I)) :- _clinguin_context(selected_object,O),object(O,_),_clinguin_context(inspector_open,true),image(O,R,I),I!="",I!=" ",_clinguin_atom(image(O,R,I)).
attr(image_edit(O,R,I),label,"Edit") :- _clinguin_context(selected_object,O),object(O,_),_clinguin_context(inspector_open,true),image(O,R,I),I!="",I!=" ",_clinguin_atom(image(O,R,I)).
attr(image_edit(O,R,I),class,"btn-outline-primary") :- _clinguin_context(selected_object,O),object(O,_),_clinguin_context(inspector_open,true),image(O,R,I),I!="",I!=" ",_clinguin_atom(image(O,R,I)).
when(image_edit(O,R,I),click,context,(dialog,form(image_edit))) :- _clinguin_context(selected_object,O),object(O,_),_clinguin_context(inspector_open,true),image(O,R,I),I!="",I!=" ",_clinguin_atom(image(O,R,I)).
when(image_edit(O,R,I),click,update,(dialog(form(image_edit)),visibility,shown)) :- _clinguin_context(selected_object,O),object(O,_),_clinguin_context(inspector_open,true),image(O,R,I),I!="",I!=" ",_clinguin_atom(image(O,R,I)).
when(image_edit(O,R,I),click,update,(local_feedback,visibility,hidden)) :- _clinguin_context(selected_object,O),object(O,_),_clinguin_context(inspector_open,true),image(O,R,I),I!="",I!=" ",_clinguin_atom(image(O,R,I)).
when(image_edit(O,R,I),click,context,(edit_image_object,O)) :- _clinguin_context(selected_object,O),object(O,_),_clinguin_context(inspector_open,true),image(O,R,I),I!="",I!=" ",_clinguin_atom(image(O,R,I)).
when(image_edit(O,R,I),click,context,(edit_image_role,R)) :- _clinguin_context(selected_object,O),object(O,_),_clinguin_context(inspector_open,true),image(O,R,I),I!="",I!=" ",_clinguin_atom(image(O,R,I)).
when(image_edit(O,R,I),click,context,(edit_image_path,I)) :- _clinguin_context(selected_object,O),object(O,_),_clinguin_context(inspector_open,true),image(O,R,I),I!="",I!=" ",_clinguin_atom(image(O,R,I)).
when(image_edit(O,R,I),click,context,(changed_image_path,I)) :- _clinguin_context(selected_object,O),object(O,_),_clinguin_context(inspector_open,true),image(O,R,I),I!="",I!=" ",_clinguin_atom(image(O,R,I)).
elem(image_remove(O,R,I),button,image_row(O,R,I)) :- _clinguin_context(selected_object,O),object(O,_),_clinguin_context(inspector_open,true),image(O,R,I),I!="",I!=" ",_clinguin_atom(image(O,R,I)).
attr(image_remove(O,R,I),label,"Delete") :- _clinguin_context(selected_object,O),object(O,_),_clinguin_context(inspector_open,true),image(O,R,I),I!="",I!=" ",_clinguin_atom(image(O,R,I)).
attr(image_remove(O,R,I),class,"btn-outline-danger") :- _clinguin_context(selected_object,O),object(O,_),_clinguin_context(inspector_open,true),image(O,R,I),I!="",I!=" ",_clinguin_atom(image(O,R,I)).
when(image_remove(O,R,I),click,call,remove_atom(image(O,R,I))) :- _clinguin_context(selected_object,O),object(O,_),_clinguin_context(inspector_open,true),image(O,R,I),I!="",I!=" ",_clinguin_atom(image(O,R,I)).

% Forms: concrete native elements, not form_field/form_submit helper facts.

elem(dialog(form(object_create)),container,w).
attr(dialog_title(form(object_create)),label,"New object").
attr(dialog(form(object_create)),visibility,shown) :- _clinguin_context(dialog,form(object_create)),not _clinguin_context(submitted,true).
attr(dialog(form(object_create)),visibility,shown) :- _clinguin_context(dialog,form(object_create)),_clinguin_unsat.
attr(dialog(form(object_create)),visibility,hidden) :- not _clinguin_context(dialog,form(object_create)).
attr(dialog(form(object_create)),visibility,hidden) :- _clinguin_context(submitted,true),not _clinguin_unsat.
elem(form_body(object_create),container,dialog_sheet(form(object_create))).
attr(form_body(object_create),class,("d-flex";"flex-column";"gap-3";"p-3")).
elem(input(object_create,new_object_term),textfield,form_body(object_create)).
attr(input(object_create,new_object_term),placeholder,"Object identifier").
attr(input(object_create,new_object_term),order,1).
when(input(object_create,new_object_term),input,context,(new_object_term,_value)).
elem(previous(object_create,new_object_term),label,form_body(object_create)) :- _clinguin_context(new_object_term,V).
attr(previous(object_create,new_object_term),label,@concat("Previous entry: ",V)) :- _clinguin_context(new_object_term,V).
attr(previous(object_create,new_object_term),class,("small";"text-secondary")) :- _clinguin_context(new_object_term,V).
attr(previous(object_create,new_object_term),order,11) :- _clinguin_context(new_object_term,V).
elem(input(object_create,new_object_type),textfield,form_body(object_create)).
attr(input(object_create,new_object_type),placeholder,"Object type").
attr(input(object_create,new_object_type),order,2).
when(input(object_create,new_object_type),input,context,(new_object_type,_value)).
elem(previous(object_create,new_object_type),label,form_body(object_create)) :- _clinguin_context(new_object_type,V).
attr(previous(object_create,new_object_type),label,@concat("Previous entry: ",V)) :- _clinguin_context(new_object_type,V).
attr(previous(object_create,new_object_type),class,("small";"text-secondary")) :- _clinguin_context(new_object_type,V).
attr(previous(object_create,new_object_type),order,12) :- _clinguin_context(new_object_type,V).
elem(form_actions(object_create),container,form_body(object_create)).
attr(form_actions(object_create),order,30).
attr(form_actions(object_create),class,("d-flex";"gap-2";"justify-content-end")).
elem(cancel(object_create),button,form_actions(object_create)).
attr(cancel(object_create),label,"Cancel").
attr(cancel(object_create),class,"btn-outline-secondary").
when(cancel(object_create),click,context,(dialog,none)).
when(cancel(object_create),click,update,(dialog(form(object_create)),visibility,hidden)).
elem(save(object_create,term),button,form_actions(object_create)).
attr(save(object_create,term),label,"Save").
attr(save(object_create,term),class,"btn-primary").
elem(dialog(form(object_edit)),container,w) :- _clinguin_context(selected_object,O),object(O,_),_clinguin_context(inspector_open,true).
attr(dialog_title(form(object_edit)),label,"Edit object type") :- _clinguin_context(selected_object,O),object(O,_),_clinguin_context(inspector_open,true).
attr(dialog(form(object_edit)),visibility,shown) :- _clinguin_context(selected_object,O),object(O,_),_clinguin_context(inspector_open,true),_clinguin_context(dialog,form(object_edit)),not _clinguin_context(submitted,true).
attr(dialog(form(object_edit)),visibility,shown) :- _clinguin_context(selected_object,O),object(O,_),_clinguin_context(inspector_open,true),_clinguin_context(dialog,form(object_edit)),_clinguin_unsat.
attr(dialog(form(object_edit)),visibility,hidden) :- _clinguin_context(selected_object,O),object(O,_),_clinguin_context(inspector_open,true),not _clinguin_context(dialog,form(object_edit)).
attr(dialog(form(object_edit)),visibility,hidden) :- _clinguin_context(selected_object,O),object(O,_),_clinguin_context(inspector_open,true),_clinguin_context(submitted,true),not _clinguin_unsat.
elem(form_body(object_edit),container,dialog_sheet(form(object_edit))) :- _clinguin_context(selected_object,O),object(O,_),_clinguin_context(inspector_open,true).
attr(form_body(object_edit),class,("d-flex";"flex-column";"gap-3";"p-3")) :- _clinguin_context(selected_object,O),object(O,_),_clinguin_context(inspector_open,true).
elem(input(object_edit,new_type),textfield,form_body(object_edit)) :- _clinguin_context(selected_object,O),object(O,_),_clinguin_context(inspector_open,true).
attr(input(object_edit,new_type),placeholder,"Replacement type") :- _clinguin_context(selected_object,O),object(O,_),_clinguin_context(inspector_open,true).
attr(input(object_edit,new_type),order,1) :- _clinguin_context(selected_object,O),object(O,_),_clinguin_context(inspector_open,true).
when(input(object_edit,new_type),input,context,(new_type,_value)) :- _clinguin_context(selected_object,O),object(O,_),_clinguin_context(inspector_open,true).
elem(previous(object_edit,new_type),label,form_body(object_edit)) :- _clinguin_context(selected_object,O),object(O,_),_clinguin_context(inspector_open,true),_clinguin_context(new_type,V).
attr(previous(object_edit,new_type),label,@concat("Previous entry: ",V)) :- _clinguin_context(selected_object,O),object(O,_),_clinguin_context(inspector_open,true),_clinguin_context(new_type,V).
attr(previous(object_edit,new_type),class,("small";"text-secondary")) :- _clinguin_context(selected_object,O),object(O,_),_clinguin_context(inspector_open,true),_clinguin_context(new_type,V).
attr(previous(object_edit,new_type),order,11) :- _clinguin_context(selected_object,O),object(O,_),_clinguin_context(inspector_open,true),_clinguin_context(new_type,V).
elem(form_actions(object_edit),container,form_body(object_edit)) :- _clinguin_context(selected_object,O),object(O,_),_clinguin_context(inspector_open,true).
attr(form_actions(object_edit),order,30) :- _clinguin_context(selected_object,O),object(O,_),_clinguin_context(inspector_open,true).
attr(form_actions(object_edit),class,("d-flex";"gap-2";"justify-content-end")) :- _clinguin_context(selected_object,O),object(O,_),_clinguin_context(inspector_open,true).
elem(cancel(object_edit),button,form_actions(object_edit)) :- _clinguin_context(selected_object,O),object(O,_),_clinguin_context(inspector_open,true).
attr(cancel(object_edit),label,"Cancel") :- _clinguin_context(selected_object,O),object(O,_),_clinguin_context(inspector_open,true).
attr(cancel(object_edit),class,"btn-outline-secondary") :- _clinguin_context(selected_object,O),object(O,_),_clinguin_context(inspector_open,true).
when(cancel(object_edit),click,context,(dialog,none)) :- _clinguin_context(selected_object,O),object(O,_),_clinguin_context(inspector_open,true).
when(cancel(object_edit),click,update,(dialog(form(object_edit)),visibility,hidden)) :- _clinguin_context(selected_object,O),object(O,_),_clinguin_context(inspector_open,true).
elem(save(object_edit,term),button,form_actions(object_edit)) :- _clinguin_context(selected_object,O),object(O,_),_clinguin_context(inspector_open,true).
attr(save(object_edit,term),label,"Save") :- _clinguin_context(selected_object,O),object(O,_),_clinguin_context(inspector_open,true).
attr(save(object_edit,term),class,"btn-primary") :- _clinguin_context(selected_object,O),object(O,_),_clinguin_context(inspector_open,true).
elem(dialog(form(property_add)),container,w) :- _clinguin_context(selected_object,O),object(O,_),_clinguin_context(inspector_open,true).
attr(dialog_title(form(property_add)),label,"Add property") :- _clinguin_context(selected_object,O),object(O,_),_clinguin_context(inspector_open,true).
attr(dialog(form(property_add)),visibility,shown) :- _clinguin_context(selected_object,O),object(O,_),_clinguin_context(inspector_open,true),_clinguin_context(dialog,form(property_add)),not _clinguin_context(submitted,true).
attr(dialog(form(property_add)),visibility,shown) :- _clinguin_context(selected_object,O),object(O,_),_clinguin_context(inspector_open,true),_clinguin_context(dialog,form(property_add)),_clinguin_unsat.
attr(dialog(form(property_add)),visibility,hidden) :- _clinguin_context(selected_object,O),object(O,_),_clinguin_context(inspector_open,true),not _clinguin_context(dialog,form(property_add)).
attr(dialog(form(property_add)),visibility,hidden) :- _clinguin_context(selected_object,O),object(O,_),_clinguin_context(inspector_open,true),_clinguin_context(submitted,true),not _clinguin_unsat.
elem(form_body(property_add),container,dialog_sheet(form(property_add))) :- _clinguin_context(selected_object,O),object(O,_),_clinguin_context(inspector_open,true).
attr(form_body(property_add),class,("d-flex";"flex-column";"gap-3";"p-3")) :- _clinguin_context(selected_object,O),object(O,_),_clinguin_context(inspector_open,true).
elem(input(property_add,new_property_key),textfield,form_body(property_add)) :- _clinguin_context(selected_object,O),object(O,_),_clinguin_context(inspector_open,true).
attr(input(property_add,new_property_key),placeholder,"Property key") :- _clinguin_context(selected_object,O),object(O,_),_clinguin_context(inspector_open,true).
attr(input(property_add,new_property_key),order,1) :- _clinguin_context(selected_object,O),object(O,_),_clinguin_context(inspector_open,true).
when(input(property_add,new_property_key),input,context,(new_property_key,_value)) :- _clinguin_context(selected_object,O),object(O,_),_clinguin_context(inspector_open,true).
elem(previous(property_add,new_property_key),label,form_body(property_add)) :- _clinguin_context(selected_object,O),object(O,_),_clinguin_context(inspector_open,true),_clinguin_context(new_property_key,V).
attr(previous(property_add,new_property_key),label,@concat("Previous entry: ",V)) :- _clinguin_context(selected_object,O),object(O,_),_clinguin_context(inspector_open,true),_clinguin_context(new_property_key,V).
attr(previous(property_add,new_property_key),class,("small";"text-secondary")) :- _clinguin_context(selected_object,O),object(O,_),_clinguin_context(inspector_open,true),_clinguin_context(new_property_key,V).
attr(previous(property_add,new_property_key),order,11) :- _clinguin_context(selected_object,O),object(O,_),_clinguin_context(inspector_open,true),_clinguin_context(new_property_key,V).
elem(input(property_add,new_property_value),textfield,form_body(property_add)) :- _clinguin_context(selected_object,O),object(O,_),_clinguin_context(inspector_open,true).
attr(input(property_add,new_property_value),placeholder,"Property value") :- _clinguin_context(selected_object,O),object(O,_),_clinguin_context(inspector_open,true).
attr(input(property_add,new_property_value),order,2) :- _clinguin_context(selected_object,O),object(O,_),_clinguin_context(inspector_open,true).
when(input(property_add,new_property_value),input,context,(new_property_value,_value)) :- _clinguin_context(selected_object,O),object(O,_),_clinguin_context(inspector_open,true).
elem(previous(property_add,new_property_value),label,form_body(property_add)) :- _clinguin_context(selected_object,O),object(O,_),_clinguin_context(inspector_open,true),_clinguin_context(new_property_value,V).
attr(previous(property_add,new_property_value),label,@concat("Previous entry: ",V)) :- _clinguin_context(selected_object,O),object(O,_),_clinguin_context(inspector_open,true),_clinguin_context(new_property_value,V).
attr(previous(property_add,new_property_value),class,("small";"text-secondary")) :- _clinguin_context(selected_object,O),object(O,_),_clinguin_context(inspector_open,true),_clinguin_context(new_property_value,V).
attr(previous(property_add,new_property_value),order,12) :- _clinguin_context(selected_object,O),object(O,_),_clinguin_context(inspector_open,true),_clinguin_context(new_property_value,V).
elem(form_actions(property_add),container,form_body(property_add)) :- _clinguin_context(selected_object,O),object(O,_),_clinguin_context(inspector_open,true).
attr(form_actions(property_add),order,30) :- _clinguin_context(selected_object,O),object(O,_),_clinguin_context(inspector_open,true).
attr(form_actions(property_add),class,("d-flex";"gap-2";"justify-content-end")) :- _clinguin_context(selected_object,O),object(O,_),_clinguin_context(inspector_open,true).
elem(cancel(property_add),button,form_actions(property_add)) :- _clinguin_context(selected_object,O),object(O,_),_clinguin_context(inspector_open,true).
attr(cancel(property_add),label,"Cancel") :- _clinguin_context(selected_object,O),object(O,_),_clinguin_context(inspector_open,true).
attr(cancel(property_add),class,"btn-outline-secondary") :- _clinguin_context(selected_object,O),object(O,_),_clinguin_context(inspector_open,true).
when(cancel(property_add),click,context,(dialog,none)) :- _clinguin_context(selected_object,O),object(O,_),_clinguin_context(inspector_open,true).
when(cancel(property_add),click,update,(dialog(form(property_add)),visibility,hidden)) :- _clinguin_context(selected_object,O),object(O,_),_clinguin_context(inspector_open,true).
elem(save(property_add,term),button,form_actions(property_add)) :- _clinguin_context(selected_object,O),object(O,_),_clinguin_context(inspector_open,true).
attr(save(property_add,term),label,"Save term") :- _clinguin_context(selected_object,O),object(O,_),_clinguin_context(inspector_open,true).
attr(save(property_add,term),class,"btn-primary") :- _clinguin_context(selected_object,O),object(O,_),_clinguin_context(inspector_open,true).
when(save(property_add,term),click,context,(submitted,true)) :- _clinguin_context(selected_object,O),object(O,_),_clinguin_context(inspector_open,true).
elem(save(property_add,int),button,form_actions(property_add)) :- _clinguin_context(selected_object,O),object(O,_),_clinguin_context(inspector_open,true).
attr(save(property_add,int),label,"Save number") :- _clinguin_context(selected_object,O),object(O,_),_clinguin_context(inspector_open,true).
attr(save(property_add,int),class,"btn-primary") :- _clinguin_context(selected_object,O),object(O,_),_clinguin_context(inspector_open,true).
when(save(property_add,int),click,context,(submitted,true)) :- _clinguin_context(selected_object,O),object(O,_),_clinguin_context(inspector_open,true).
elem(save(property_add,str),button,form_actions(property_add)) :- _clinguin_context(selected_object,O),object(O,_),_clinguin_context(inspector_open,true).
attr(save(property_add,str),label,"Save text") :- _clinguin_context(selected_object,O),object(O,_),_clinguin_context(inspector_open,true).
attr(save(property_add,str),class,"btn-primary") :- _clinguin_context(selected_object,O),object(O,_),_clinguin_context(inspector_open,true).
when(save(property_add,str),click,context,(submitted,true)) :- _clinguin_context(selected_object,O),object(O,_),_clinguin_context(inspector_open,true).

elem(dialog(form(property_edit)),container,w) :- _clinguin_context(selected_object,O),object(O,_),_clinguin_context(inspector_open,true).
attr(dialog_title(form(property_edit)),label,"Edit property") :- _clinguin_context(selected_object,O),object(O,_),_clinguin_context(inspector_open,true).
attr(dialog(form(property_edit)),visibility,shown) :- _clinguin_context(selected_object,O),object(O,_),_clinguin_context(inspector_open,true),_clinguin_context(dialog,form(property_edit)),not _clinguin_context(submitted,true).
attr(dialog(form(property_edit)),visibility,shown) :- _clinguin_context(selected_object,O),object(O,_),_clinguin_context(inspector_open,true),_clinguin_context(dialog,form(property_edit)),_clinguin_unsat.
attr(dialog(form(property_edit)),visibility,hidden) :- _clinguin_context(selected_object,O),object(O,_),_clinguin_context(inspector_open,true),not _clinguin_context(dialog,form(property_edit)).
attr(dialog(form(property_edit)),visibility,hidden) :- _clinguin_context(selected_object,O),object(O,_),_clinguin_context(inspector_open,true),_clinguin_context(submitted,true),not _clinguin_unsat.

elem(form_body(property_edit),container,dialog_sheet(form(property_edit))) :- _clinguin_context(selected_object,O),object(O,_),_clinguin_context(inspector_open,true).
attr(form_body(property_edit),class,("d-flex";"flex-column";"gap-3";"p-3")) :- _clinguin_context(selected_object,O),object(O,_),_clinguin_context(inspector_open,true).

elem(input(property_edit,changed_property_key),textfield,form_body(property_edit)) :- _clinguin_context(selected_object,O),object(O,_),_clinguin_context(inspector_open,true).
attr(input(property_edit,changed_property_key),placeholder,"Replacement key") :- _clinguin_context(selected_object,O),object(O,_),_clinguin_context(inspector_open,true).
attr(input(property_edit,changed_property_key),order,1) :- _clinguin_context(selected_object,O),object(O,_),_clinguin_context(inspector_open,true).
when(input(property_edit,changed_property_key),input,context,(changed_property_key,_value)) :- _clinguin_context(selected_object,O),object(O,_),_clinguin_context(inspector_open,true).

elem(previous(property_edit,changed_property_key),label,form_body(property_edit)) :- _clinguin_context(selected_object,O),object(O,_),_clinguin_context(inspector_open,true),_clinguin_context(changed_property_key,V).
attr(previous(property_edit,changed_property_key),label,@concat("Previous entry: ",V)) :- _clinguin_context(selected_object,O),object(O,_),_clinguin_context(inspector_open,true),_clinguin_context(changed_property_key,V).
attr(previous(property_edit,changed_property_key),class,("small";"text-secondary")) :- _clinguin_context(selected_object,O),object(O,_),_clinguin_context(inspector_open,true),_clinguin_context(changed_property_key,V).
attr(previous(property_edit,changed_property_key),order,11) :- _clinguin_context(selected_object,O),object(O,_),_clinguin_context(inspector_open,true),_clinguin_context(changed_property_key,V).

elem(input(property_edit,changed_property_value),textfield,form_body(property_edit)) :- _clinguin_context(selected_object,O),object(O,_),_clinguin_context(inspector_open,true).
attr(input(property_edit,changed_property_value),placeholder,"Replacement value") :- _clinguin_context(selected_object,O),object(O,_),_clinguin_context(inspector_open,true).
attr(input(property_edit,changed_property_value),order,2) :- _clinguin_context(selected_object,O),object(O,_),_clinguin_context(inspector_open,true).
when(input(property_edit,changed_property_value),input,context,(changed_property_value,_value)) :- _clinguin_context(selected_object,O),object(O,_),_clinguin_context(inspector_open,true).

elem(previous(property_edit,changed_property_value),label,form_body(property_edit)) :- _clinguin_context(selected_object,O),object(O,_),_clinguin_context(inspector_open,true),_clinguin_context(changed_property_value,V).
attr(previous(property_edit,changed_property_value),label,@concat("Previous entry: ",V)) :- _clinguin_context(selected_object,O),object(O,_),_clinguin_context(inspector_open,true),_clinguin_context(changed_property_value,V).
attr(previous(property_edit,changed_property_value),class,("small";"text-secondary")) :- _clinguin_context(selected_object,O),object(O,_),_clinguin_context(inspector_open,true),_clinguin_context(changed_property_value,V).
attr(previous(property_edit,changed_property_value),order,12) :- _clinguin_context(selected_object,O),object(O,_),_clinguin_context(inspector_open,true),_clinguin_context(changed_property_value,V).

elem(form_actions(property_edit),container,form_body(property_edit)) :- _clinguin_context(selected_object,O),object(O,_),_clinguin_context(inspector_open,true).
attr(form_actions(property_edit),order,30) :- _clinguin_context(selected_object,O),object(O,_),_clinguin_context(inspector_open,true).
attr(form_actions(property_edit),class,("d-flex";"gap-2";"justify-content-end")) :- _clinguin_context(selected_object,O),object(O,_),_clinguin_context(inspector_open,true).

elem(cancel(property_edit),button,form_actions(property_edit)) :- _clinguin_context(selected_object,O),object(O,_),_clinguin_context(inspector_open,true).
attr(cancel(property_edit),label,"Cancel") :- _clinguin_context(selected_object,O),object(O,_),_clinguin_context(inspector_open,true).
attr(cancel(property_edit),class,"btn-outline-secondary") :- _clinguin_context(selected_object,O),object(O,_),_clinguin_context(inspector_open,true).
when(cancel(property_edit),click,context,(dialog,none)) :- _clinguin_context(selected_object,O),object(O,_),_clinguin_context(inspector_open,true).
when(cancel(property_edit),click,update,(dialog(form(property_edit)),visibility,hidden)) :- _clinguin_context(selected_object,O),object(O,_),_clinguin_context(inspector_open,true).

elem(save(property_edit,term),button,form_actions(property_edit)) :- _clinguin_context(selected_object,O),object(O,_),_clinguin_context(inspector_open,true).
attr(save(property_edit,term),label,"Save term") :- _clinguin_context(selected_object,O),object(O,_),_clinguin_context(inspector_open,true).
attr(save(property_edit,term),class,"btn-primary") :- _clinguin_context(selected_object,O),object(O,_),_clinguin_context(inspector_open,true).
when(save(property_edit,term),click,context,(submitted,true)) :- _clinguin_context(selected_object,O),object(O,_),_clinguin_context(inspector_open,true).

elem(save(property_edit,int),button,form_actions(property_edit)) :- _clinguin_context(selected_object,O),object(O,_),_clinguin_context(inspector_open,true).
attr(save(property_edit,int),label,"Save number") :- _clinguin_context(selected_object,O),object(O,_),_clinguin_context(inspector_open,true).
attr(save(property_edit,int),class,"btn-primary") :- _clinguin_context(selected_object,O),object(O,_),_clinguin_context(inspector_open,true).
when(save(property_edit,int),click,context,(submitted,true)) :- _clinguin_context(selected_object,O),object(O,_),_clinguin_context(inspector_open,true).

elem(save(property_edit,str),button,form_actions(property_edit)) :- _clinguin_context(selected_object,O),object(O,_),_clinguin_context(inspector_open,true).
attr(save(property_edit,str),label,"Save text") :- _clinguin_context(selected_object,O),object(O,_),_clinguin_context(inspector_open,true).
attr(save(property_edit,str),class,"btn-primary") :- _clinguin_context(selected_object,O),object(O,_),_clinguin_context(inspector_open,true).
when(save(property_edit,str),click,context,(submitted,true)) :- _clinguin_context(selected_object,O),object(O,_),_clinguin_context(inspector_open,true).

elem(dialog(form(position_add)),container,w) :- _clinguin_context(selected_object,O),object(O,_),_clinguin_context(inspector_open,true).
attr(dialog_title(form(position_add)),label,"Add position") :- _clinguin_context(selected_object,O),object(O,_),_clinguin_context(inspector_open,true).
attr(dialog(form(position_add)),visibility,shown) :- _clinguin_context(selected_object,O),object(O,_),_clinguin_context(inspector_open,true),_clinguin_context(dialog,form(position_add)),not _clinguin_context(submitted,true).
attr(dialog(form(position_add)),visibility,shown) :- _clinguin_context(selected_object,O),object(O,_),_clinguin_context(inspector_open,true),_clinguin_context(dialog,form(position_add)),_clinguin_unsat.
attr(dialog(form(position_add)),visibility,hidden) :- _clinguin_context(selected_object,O),object(O,_),_clinguin_context(inspector_open,true),not _clinguin_context(dialog,form(position_add)).
attr(dialog(form(position_add)),visibility,hidden) :- _clinguin_context(selected_object,O),object(O,_),_clinguin_context(inspector_open,true),_clinguin_context(submitted,true),not _clinguin_unsat.

elem(form_body(position_add),container,dialog_sheet(form(position_add))) :- _clinguin_context(selected_object,O),object(O,_),_clinguin_context(inspector_open,true).
attr(form_body(position_add),class,("d-flex";"flex-column";"gap-3";"p-3")) :- _clinguin_context(selected_object,O),object(O,_),_clinguin_context(inspector_open,true).

elem(input(position_add,new_row),textfield,form_body(position_add)) :- _clinguin_context(selected_object,O),object(O,_),_clinguin_context(inspector_open,true).
attr(input(position_add,new_row),placeholder,"Row") :- _clinguin_context(selected_object,O),object(O,_),_clinguin_context(inspector_open,true).
attr(input(position_add,new_row),order,1) :- _clinguin_context(selected_object,O),object(O,_),_clinguin_context(inspector_open,true).
when(input(position_add,new_row),input,context,(new_row,_value)) :- _clinguin_context(selected_object,O),object(O,_),_clinguin_context(inspector_open,true).

elem(previous(position_add,new_row),label,form_body(position_add)) :- _clinguin_context(selected_object,O),object(O,_),_clinguin_context(inspector_open,true),_clinguin_context(new_row,V).
attr(previous(position_add,new_row),label,@concat("Previous entry: ",V)) :- _clinguin_context(selected_object,O),object(O,_),_clinguin_context(inspector_open,true),_clinguin_context(new_row,V).
attr(previous(position_add,new_row),class,("small";"text-secondary")) :- _clinguin_context(selected_object,O),object(O,_),_clinguin_context(inspector_open,true),_clinguin_context(new_row,V).
attr(previous(position_add,new_row),order,11) :- _clinguin_context(selected_object,O),object(O,_),_clinguin_context(inspector_open,true),_clinguin_context(new_row,V).

elem(input(position_add,new_column),textfield,form_body(position_add)) :- _clinguin_context(selected_object,O),object(O,_),_clinguin_context(inspector_open,true).
attr(input(position_add,new_column),placeholder,"Column") :- _clinguin_context(selected_object,O),object(O,_),_clinguin_context(inspector_open,true).
attr(input(position_add,new_column),order,2) :- _clinguin_context(selected_object,O),object(O,_),_clinguin_context(inspector_open,true).
when(input(position_add,new_column),input,context,(new_column,_value)) :- _clinguin_context(selected_object,O),object(O,_),_clinguin_context(inspector_open,true).

elem(previous(position_add,new_column),label,form_body(position_add)) :- _clinguin_context(selected_object,O),object(O,_),_clinguin_context(inspector_open,true),_clinguin_context(new_column,V).
attr(previous(position_add,new_column),label,@concat("Previous entry: ",V)) :- _clinguin_context(selected_object,O),object(O,_),_clinguin_context(inspector_open,true),_clinguin_context(new_column,V).
attr(previous(position_add,new_column),class,("small";"text-secondary")) :- _clinguin_context(selected_object,O),object(O,_),_clinguin_context(inspector_open,true),_clinguin_context(new_column,V).
attr(previous(position_add,new_column),order,12) :- _clinguin_context(selected_object,O),object(O,_),_clinguin_context(inspector_open,true),_clinguin_context(new_column,V).

elem(form_actions(position_add),container,form_body(position_add)) :- _clinguin_context(selected_object,O),object(O,_),_clinguin_context(inspector_open,true).
attr(form_actions(position_add),order,30) :- _clinguin_context(selected_object,O),object(O,_),_clinguin_context(inspector_open,true).
attr(form_actions(position_add),class,("d-flex";"gap-2";"justify-content-end")) :- _clinguin_context(selected_object,O),object(O,_),_clinguin_context(inspector_open,true).

elem(cancel(position_add),button,form_actions(position_add)) :- _clinguin_context(selected_object,O),object(O,_),_clinguin_context(inspector_open,true).
attr(cancel(position_add),label,"Cancel") :- _clinguin_context(selected_object,O),object(O,_),_clinguin_context(inspector_open,true).
attr(cancel(position_add),class,"btn-outline-secondary") :- _clinguin_context(selected_object,O),object(O,_),_clinguin_context(inspector_open,true).
when(cancel(position_add),click,context,(dialog,none)) :- _clinguin_context(selected_object,O),object(O,_),_clinguin_context(inspector_open,true).
when(cancel(position_add),click,update,(dialog(form(position_add)),visibility,hidden)) :- _clinguin_context(selected_object,O),object(O,_),_clinguin_context(inspector_open,true).

elem(save(position_add,term),button,form_actions(position_add)) :- _clinguin_context(selected_object,O),object(O,_),_clinguin_context(inspector_open,true).
attr(save(position_add,term),label,"Save") :- _clinguin_context(selected_object,O),object(O,_),_clinguin_context(inspector_open,true).
attr(save(position_add,term),class,"btn-primary") :- _clinguin_context(selected_object,O),object(O,_),_clinguin_context(inspector_open,true).
when(save(position_add,term),click,context,(submitted,true)) :- _clinguin_context(selected_object,O),object(O,_),_clinguin_context(inspector_open,true).
elem(dialog(form(position_edit)),container,w) :- _clinguin_context(selected_object,O),object(O,_),_clinguin_context(inspector_open,true).
attr(dialog_title(form(position_edit)),label,"Move position") :- _clinguin_context(selected_object,O),object(O,_),_clinguin_context(inspector_open,true).
attr(dialog(form(position_edit)),visibility,shown) :- _clinguin_context(selected_object,O),object(O,_),_clinguin_context(inspector_open,true),_clinguin_context(dialog,form(position_edit)),not _clinguin_context(submitted,true).
attr(dialog(form(position_edit)),visibility,shown) :- _clinguin_context(selected_object,O),object(O,_),_clinguin_context(inspector_open,true),_clinguin_context(dialog,form(position_edit)),_clinguin_unsat.
attr(dialog(form(position_edit)),visibility,hidden) :- _clinguin_context(selected_object,O),object(O,_),_clinguin_context(inspector_open,true),not _clinguin_context(dialog,form(position_edit)).
attr(dialog(form(position_edit)),visibility,hidden) :- _clinguin_context(selected_object,O),object(O,_),_clinguin_context(inspector_open,true),_clinguin_context(submitted,true),not _clinguin_unsat.
elem(form_body(position_edit),container,dialog_sheet(form(position_edit))) :- _clinguin_context(selected_object,O),object(O,_),_clinguin_context(inspector_open,true).
attr(form_body(position_edit),class,("d-flex";"flex-column";"gap-3";"p-3")) :- _clinguin_context(selected_object,O),object(O,_),_clinguin_context(inspector_open,true).
elem(input(position_edit,changed_row),textfield,form_body(position_edit)) :- _clinguin_context(selected_object,O),object(O,_),_clinguin_context(inspector_open,true).
attr(input(position_edit,changed_row),placeholder,"New row") :- _clinguin_context(selected_object,O),object(O,_),_clinguin_context(inspector_open,true).
attr(input(position_edit,changed_row),order,1) :- _clinguin_context(selected_object,O),object(O,_),_clinguin_context(inspector_open,true).
when(input(position_edit,changed_row),input,context,(changed_row,_value)) :- _clinguin_context(selected_object,O),object(O,_),_clinguin_context(inspector_open,true).
elem(previous(position_edit,changed_row),label,form_body(position_edit)) :- _clinguin_context(selected_object,O),object(O,_),_clinguin_context(inspector_open,true),_clinguin_context(changed_row,V).
attr(previous(position_edit,changed_row),label,@concat("Previous entry: ",V)) :- _clinguin_context(selected_object,O),object(O,_),_clinguin_context(inspector_open,true),_clinguin_context(changed_row,V).
attr(previous(position_edit,changed_row),class,("small";"text-secondary")) :- _clinguin_context(selected_object,O),object(O,_),_clinguin_context(inspector_open,true),_clinguin_context(changed_row,V).
attr(previous(position_edit,changed_row),order,11) :- _clinguin_context(selected_object,O),object(O,_),_clinguin_context(inspector_open,true),_clinguin_context(changed_row,V).
elem(input(position_edit,changed_column),textfield,form_body(position_edit)) :- _clinguin_context(selected_object,O),object(O,_),_clinguin_context(inspector_open,true).
attr(input(position_edit,changed_column),placeholder,"New column") :- _clinguin_context(selected_object,O),object(O,_),_clinguin_context(inspector_open,true).
attr(input(position_edit,changed_column),order,2) :- _clinguin_context(selected_object,O),object(O,_),_clinguin_context(inspector_open,true).
when(input(position_edit,changed_column),input,context,(changed_column,_value)) :- _clinguin_context(selected_object,O),object(O,_),_clinguin_context(inspector_open,true).
elem(previous(position_edit,changed_column),label,form_body(position_edit)) :- _clinguin_context(selected_object,O),object(O,_),_clinguin_context(inspector_open,true),_clinguin_context(changed_column,V).
attr(previous(position_edit,changed_column),label,@concat("Previous entry: ",V)) :- _clinguin_context(selected_object,O),object(O,_),_clinguin_context(inspector_open,true),_clinguin_context(changed_column,V).
attr(previous(position_edit,changed_column),class,("small";"text-secondary")) :- _clinguin_context(selected_object,O),object(O,_),_clinguin_context(inspector_open,true),_clinguin_context(changed_column,V).
attr(previous(position_edit,changed_column),order,12) :- _clinguin_context(selected_object,O),object(O,_),_clinguin_context(inspector_open,true),_clinguin_context(changed_column,V).
elem(form_actions(position_edit),container,form_body(position_edit)) :- _clinguin_context(selected_object,O),object(O,_),_clinguin_context(inspector_open,true).
attr(form_actions(position_edit),order,30) :- _clinguin_context(selected_object,O),object(O,_),_clinguin_context(inspector_open,true).
attr(form_actions(position_edit),class,("d-flex";"gap-2";"justify-content-end")) :- _clinguin_context(selected_object,O),object(O,_),_clinguin_context(inspector_open,true).
elem(cancel(position_edit),button,form_actions(position_edit)) :- _clinguin_context(selected_object,O),object(O,_),_clinguin_context(inspector_open,true).
attr(cancel(position_edit),label,"Cancel") :- _clinguin_context(selected_object,O),object(O,_),_clinguin_context(inspector_open,true).
attr(cancel(position_edit),class,"btn-outline-secondary") :- _clinguin_context(selected_object,O),object(O,_),_clinguin_context(inspector_open,true).
when(cancel(position_edit),click,context,(dialog,none)) :- _clinguin_context(selected_object,O),object(O,_),_clinguin_context(inspector_open,true).
when(cancel(position_edit),click,update,(dialog(form(position_edit)),visibility,hidden)) :- _clinguin_context(selected_object,O),object(O,_),_clinguin_context(inspector_open,true).
elem(save(position_edit,term),button,form_actions(position_edit)) :- _clinguin_context(selected_object,O),object(O,_),_clinguin_context(inspector_open,true).
attr(save(position_edit,term),label,"Save") :- _clinguin_context(selected_object,O),object(O,_),_clinguin_context(inspector_open,true).
attr(save(position_edit,term),class,"btn-primary") :- _clinguin_context(selected_object,O),object(O,_),_clinguin_context(inspector_open,true).
when(save(position_edit,term),click,context,(submitted,true)) :- _clinguin_context(selected_object,O),object(O,_),_clinguin_context(inspector_open,true).
elem(dialog(form(image_add)),container,w) :- _clinguin_context(selected_object,O),object(O,_),_clinguin_context(inspector_open,true).
attr(dialog_title(form(image_add)),label,"Add image") :- _clinguin_context(selected_object,O),object(O,_),_clinguin_context(inspector_open,true).
attr(dialog(form(image_add)),visibility,shown) :- _clinguin_context(selected_object,O),object(O,_),_clinguin_context(inspector_open,true),_clinguin_context(dialog,form(image_add)),not _clinguin_context(submitted,true).
attr(dialog(form(image_add)),visibility,shown) :- _clinguin_context(selected_object,O),object(O,_),_clinguin_context(inspector_open,true),_clinguin_context(dialog,form(image_add)),_clinguin_unsat.
attr(dialog(form(image_add)),visibility,hidden) :- _clinguin_context(selected_object,O),object(O,_),_clinguin_context(inspector_open,true),not _clinguin_context(dialog,form(image_add)).
attr(dialog(form(image_add)),visibility,hidden) :- _clinguin_context(selected_object,O),object(O,_),_clinguin_context(inspector_open,true),_clinguin_context(submitted,true),not _clinguin_unsat.
elem(form_body(image_add),container,dialog_sheet(form(image_add))) :- _clinguin_context(selected_object,O),object(O,_),_clinguin_context(inspector_open,true).
attr(form_body(image_add),class,("d-flex";"flex-column";"gap-3";"p-3")) :- _clinguin_context(selected_object,O),object(O,_),_clinguin_context(inspector_open,true).

elem(input(image_add,new_image_path),textfield,form_body(image_add)) :- _clinguin_context(selected_object,O),object(O,_),_clinguin_context(inspector_open,true).
attr(input(image_add,new_image_path),placeholder,"Image path") :- _clinguin_context(selected_object,O),object(O,_),_clinguin_context(inspector_open,true).
attr(input(image_add,new_image_path),order,1) :- _clinguin_context(selected_object,O),object(O,_),_clinguin_context(inspector_open,true).
when(input(image_add,new_image_path),input,context,(new_image_path,_value)) :- _clinguin_context(selected_object,O),object(O,_),_clinguin_context(inspector_open,true).

elem(previous(image_add,new_image_path),label,form_body(image_add)) :- _clinguin_context(selected_object,O),object(O,_),_clinguin_context(inspector_open,true),_clinguin_context(new_image_path,V).
attr(previous(image_add,new_image_path),label,@concat("Previous entry: ",V)) :- _clinguin_context(selected_object,O),object(O,_),_clinguin_context(inspector_open,true),_clinguin_context(new_image_path,V).
attr(previous(image_add,new_image_path),class,("small";"text-secondary")) :- _clinguin_context(selected_object,O),object(O,_),_clinguin_context(inspector_open,true),_clinguin_context(new_image_path,V).
attr(previous(image_add,new_image_path),order,11) :- _clinguin_context(selected_object,O),object(O,_),_clinguin_context(inspector_open,true),_clinguin_context(new_image_path,V).

elem(form_actions(image_add),container,form_body(image_add)) :- _clinguin_context(selected_object,O),object(O,_),_clinguin_context(inspector_open,true).
attr(form_actions(image_add),order,30) :- _clinguin_context(selected_object,O),object(O,_),_clinguin_context(inspector_open,true).
attr(form_actions(image_add),class,("d-flex";"gap-2";"justify-content-end")) :- _clinguin_context(selected_object,O),object(O,_),_clinguin_context(inspector_open,true).

elem(cancel(image_add),button,form_actions(image_add)) :- _clinguin_context(selected_object,O),object(O,_),_clinguin_context(inspector_open,true).
attr(cancel(image_add),label,"Cancel") :- _clinguin_context(selected_object,O),object(O,_),_clinguin_context(inspector_open,true).
attr(cancel(image_add),class,"btn-outline-secondary") :- _clinguin_context(selected_object,O),object(O,_),_clinguin_context(inspector_open,true).
when(cancel(image_add),click,context,(dialog,none)) :- _clinguin_context(selected_object,O),object(O,_),_clinguin_context(inspector_open,true).
when(cancel(image_add),click,update,(dialog(form(image_add)),visibility,hidden)) :- _clinguin_context(selected_object,O),object(O,_),_clinguin_context(inspector_open,true).

elem(save(image_add,str),button,form_actions(image_add)) :- _clinguin_context(selected_object,O),object(O,_),_clinguin_context(inspector_open,true).
attr(save(image_add,str),label,"Save image") :- _clinguin_context(selected_object,O),object(O,_),_clinguin_context(inspector_open,true).
attr(save(image_add,str),class,"btn-primary") :- _clinguin_context(selected_object,O),object(O,_),_clinguin_context(inspector_open,true).
when(save(image_add,str),click,context,(submitted,true)) :- _clinguin_context(selected_object,O),object(O,_),_clinguin_context(inspector_open,true).

elem(dialog(form(image_edit)),container,w) :- _clinguin_context(selected_object,O),object(O,_),_clinguin_context(inspector_open,true).
attr(dialog_title(form(image_edit)),label,"Edit image") :- _clinguin_context(selected_object,O),object(O,_),_clinguin_context(inspector_open,true).
attr(dialog(form(image_edit)),visibility,shown) :- _clinguin_context(selected_object,O),object(O,_),_clinguin_context(inspector_open,true),_clinguin_context(dialog,form(image_edit)),not _clinguin_context(submitted,true).
attr(dialog(form(image_edit)),visibility,shown) :- _clinguin_context(selected_object,O),object(O,_),_clinguin_context(inspector_open,true),_clinguin_context(dialog,form(image_edit)),_clinguin_unsat.
attr(dialog(form(image_edit)),visibility,hidden) :- _clinguin_context(selected_object,O),object(O,_),_clinguin_context(inspector_open,true),not _clinguin_context(dialog,form(image_edit)).
attr(dialog(form(image_edit)),visibility,hidden) :- _clinguin_context(selected_object,O),object(O,_),_clinguin_context(inspector_open,true),_clinguin_context(submitted,true),not _clinguin_unsat.

elem(form_body(image_edit),container,dialog_sheet(form(image_edit))) :- _clinguin_context(selected_object,O),object(O,_),_clinguin_context(inspector_open,true).
attr(form_body(image_edit),class,("d-flex";"flex-column";"gap-3";"p-3")) :- _clinguin_context(selected_object,O),object(O,_),_clinguin_context(inspector_open,true).

elem(input(image_edit,changed_image_path),textfield,form_body(image_edit)) :- _clinguin_context(selected_object,O),object(O,_),_clinguin_context(inspector_open,true).
attr(input(image_edit,changed_image_path),placeholder,"Replacement image path") :- _clinguin_context(selected_object,O),object(O,_),_clinguin_context(inspector_open,true).
attr(input(image_edit,changed_image_path),order,1) :- _clinguin_context(selected_object,O),object(O,_),_clinguin_context(inspector_open,true).
when(input(image_edit,changed_image_path),input,context,(changed_image_path,_value)) :- _clinguin_context(selected_object,O),object(O,_),_clinguin_context(inspector_open,true).

elem(previous(image_edit,changed_image_path),label,form_body(image_edit)) :- _clinguin_context(selected_object,O),object(O,_),_clinguin_context(inspector_open,true),_clinguin_context(changed_image_path,V).
attr(previous(image_edit,changed_image_path),label,@concat("Previous entry: ",V)) :- _clinguin_context(selected_object,O),object(O,_),_clinguin_context(inspector_open,true),_clinguin_context(changed_image_path,V).
attr(previous(image_edit,changed_image_path),class,("small";"text-secondary")) :- _clinguin_context(selected_object,O),object(O,_),_clinguin_context(inspector_open,true),_clinguin_context(changed_image_path,V).
attr(previous(image_edit,changed_image_path),order,11) :- _clinguin_context(selected_object,O),object(O,_),_clinguin_context(inspector_open,true),_clinguin_context(changed_image_path,V).

elem(form_actions(image_edit),container,form_body(image_edit)) :- _clinguin_context(selected_object,O),object(O,_),_clinguin_context(inspector_open,true).
attr(form_actions(image_edit),order,30) :- _clinguin_context(selected_object,O),object(O,_),_clinguin_context(inspector_open,true).
attr(form_actions(image_edit),class,("d-flex";"gap-2";"justify-content-end")) :- _clinguin_context(selected_object,O),object(O,_),_clinguin_context(inspector_open,true).

elem(cancel(image_edit),button,form_actions(image_edit)) :- _clinguin_context(selected_object,O),object(O,_),_clinguin_context(inspector_open,true).
attr(cancel(image_edit),label,"Cancel") :- _clinguin_context(selected_object,O),object(O,_),_clinguin_context(inspector_open,true).
attr(cancel(image_edit),class,"btn-outline-secondary") :- _clinguin_context(selected_object,O),object(O,_),_clinguin_context(inspector_open,true).
when(cancel(image_edit),click,context,(dialog,none)) :- _clinguin_context(selected_object,O),object(O,_),_clinguin_context(inspector_open,true).
when(cancel(image_edit),click,update,(dialog(form(image_edit)),visibility,hidden)) :- _clinguin_context(selected_object,O),object(O,_),_clinguin_context(inspector_open,true).

elem(save(image_edit,str),button,form_actions(image_edit)) :- _clinguin_context(selected_object,O),object(O,_),_clinguin_context(inspector_open,true).
attr(save(image_edit,str),label,"Save image") :- _clinguin_context(selected_object,O),object(O,_),_clinguin_context(inspector_open,true).
attr(save(image_edit,str),class,"btn-primary") :- _clinguin_context(selected_object,O),object(O,_),_clinguin_context(inspector_open,true).
when(save(image_edit,str),click,context,(submitted,true)) :- _clinguin_context(selected_object,O),object(O,_),_clinguin_context(inspector_open,true).


when(save(object_create,term),click,call,add_atom(request(create,_context_value(new_object_term,const),_context_value(new_object_type,const)))) :- not request(_,_,_).
when(save(object_create,term),click,call,(remove_atom(request(M,OldO,OldT)),add_atom(request(create,_context_value(new_object_term,const),_context_value(new_object_type,const))))) :- request(M,OldO,OldT).
when(save(object_edit,term),click,call,add_atom(request(edit(T),O,_context_value(new_type,const)))) :- _clinguin_context(selected_object,O),object(O,_),_clinguin_context(inspector_open,true),object(O,T),_clinguin_atom(object(O,T)),not request(_,_,_).
when(save(object_edit,term),click,call,(remove_atom(request(M,OldO,OldT)),add_atom(request(edit(T),O,_context_value(new_type,const))))) :- _clinguin_context(selected_object,O),object(O,_),_clinguin_context(inspector_open,true),object(O,T),_clinguin_atom(object(O,T)),request(M,OldO,OldT).


when(save(property_add,term),click,call,add_atom(property(O,_context_value(new_property_key,const),_context_value(new_property_value)))) :- _clinguin_context(selected_object,O),object(O,_),_clinguin_context(inspector_open,true).
when(save(property_edit,term),click,call,(remove_atom(property(_context_value(edit_property_object),_context_value(edit_property_key),_context_value(edit_property_value))),add_atom(property(O,_context_value(changed_property_key,const),_context_value(changed_property_value))))) :- _clinguin_context(selected_object,O),object(O,_),_clinguin_context(inspector_open,true).
when(save(property_add,int),click,call,add_atom(property(O,_context_value(new_property_key,const),_context_value(new_property_value,int)))) :- _clinguin_context(selected_object,O),object(O,_),_clinguin_context(inspector_open,true).
when(save(property_edit,int),click,call,(remove_atom(property(_context_value(edit_property_object),_context_value(edit_property_key),_context_value(edit_property_value))),add_atom(property(O,_context_value(changed_property_key,const),_context_value(changed_property_value,int))))) :- _clinguin_context(selected_object,O),object(O,_),_clinguin_context(inspector_open,true).
when(save(property_add,str),click,call,add_atom(property(O,_context_value(new_property_key,const),_context_value(new_property_value,str)))) :- _clinguin_context(selected_object,O),object(O,_),_clinguin_context(inspector_open,true).
when(save(property_edit,str),click,call,(remove_atom(property(_context_value(edit_property_object),_context_value(edit_property_key),_context_value(edit_property_value))),add_atom(property(O,_context_value(changed_property_key,const),_context_value(changed_property_value,str))))) :- _clinguin_context(selected_object,O),object(O,_),_clinguin_context(inspector_open,true).
when(save(position_add,term),click,call,add_atom(position((_context_value(new_row,int),_context_value(new_column,int)),R,O))) :- _clinguin_context(selected_object,O),object(O,_),_clinguin_context(inspector_open,true),_clinguin_context(placement_role,R),role(O,R,_,_,_).
when(save(position_edit,term),click,call,(remove_atom(position((_context_value(edit_position_row,int),_context_value(edit_position_col,int)),_context_value(edit_position_role),_context_value(edit_position_object))),add_atom(position((_context_value(changed_row,int),_context_value(changed_column,int)),_context_value(edit_position_role),O)))) :- _clinguin_context(selected_object,O),object(O,_),_clinguin_context(inspector_open,true).
when(save(image_add,str),click,call,add_atom(image(O,R,_context_value(new_image_path,str)))) :- _clinguin_context(selected_object,O),object(O,_),_clinguin_context(inspector_open,true),_clinguin_context(placement_role,R),role(O,R,_,_,_).
when(save(image_edit,str),click,call,(remove_atom(image(_context_value(edit_image_object),_context_value(edit_image_role),_context_value(edit_image_path))),add_atom(image(O,_context_value(edit_image_role),_context_value(changed_image_path,str))))) :- _clinguin_context(selected_object,O),object(O,_),_clinguin_context(inspector_open,true).
attr(sidebar_header,"gap","4px").
attr(sidebar_header,"padding","18px 18px 12px").
attr(sidebar_title,"font-size","17px").
attr(sidebar_title,"font-weight","750").
attr(sidebar_title,"letter-spacing","-.3px").
attr(sidebar_title,"color","#14263e").
attr(sidebar_title,order,1).
attr(sidebar_subtitle,"font-size","12px").
attr(sidebar_subtitle,"color","#64748b").
attr(sidebar_subtitle,"line-height","1.5").
attr(sidebar_subtitle,order,2).
attr(summary,child_layout,grid).
attr(summary,"grid-template-columns","repeat(2,minmax(0,1fr))").
attr(summary,"gap","8px").
attr(summary,"padding","0 18px 16px").
attr(summary_tile(0),order,0).
attr(summary_tile(0),grid_row,0).
attr(summary_tile(0),grid_column,0).
attr(summary_tile(0),"padding","9px 10px").
attr(summary_tile(0),"background","#f7f9fc").
attr(summary_tile(0),"border","1px solid #e9edf3").
attr(summary_tile(0),"border-radius","8px").
attr(summary_objects,"font-size","12px").
attr(summary_objects,"font-weight","600").
attr(summary_objects,"color","#475569").
attr(summary_tile(1),order,1).
attr(summary_tile(1),grid_row,0).
attr(summary_tile(1),grid_column,1).
attr(summary_tile(1),"padding","9px 10px").
attr(summary_tile(1),"background","#f7f9fc").
attr(summary_tile(1),"border","1px solid #e9edf3").
attr(summary_tile(1),"border-radius","8px").
attr(summary_properties,"font-size","12px").
attr(summary_properties,"font-weight","600").
attr(summary_properties,"color","#475569").
attr(summary_tile(2),order,2).
attr(summary_tile(2),grid_row,1).
attr(summary_tile(2),grid_column,0).
attr(summary_tile(2),"padding","9px 10px").
attr(summary_tile(2),"background","#f7f9fc").
attr(summary_tile(2),"border","1px solid #e9edf3").
attr(summary_tile(2),"border-radius","8px").
attr(summary_positions,"font-size","12px").
attr(summary_positions,"font-weight","600").
attr(summary_positions,"color","#475569").
attr(summary_tile(3),order,3).
attr(summary_tile(3),grid_row,1).
attr(summary_tile(3),grid_column,1).
attr(summary_tile(3),"padding","9px 10px").
attr(summary_tile(3),"background","#f7f9fc").
attr(summary_tile(3),"border","1px solid #e9edf3").
attr(summary_tile(3),"border-radius","8px").
attr(summary_edits,"font-size","12px").
attr(summary_edits,"font-weight","600").
attr(summary_edits,"color","#475569").
attr(catalogue,"min-width","0").
attr(catalogue,"border-top","1px solid #e2e8f0").

elem(catalogue_toolbar,container,catalogue).
attr(catalogue_toolbar,order,1).
attr(catalogue_toolbar,flex_direction,row).
attr(catalogue_toolbar,"align-items","center").
attr(catalogue_toolbar,"justify-content","space-between").
attr(catalogue_toolbar,"gap","12px").
attr(catalogue_toolbar,"padding","12px 18px").

elem(catalogue_heading,label,catalogue_toolbar).
attr(catalogue_heading,label,"AVAILABLE OBJECTS").
attr(catalogue_heading,order,1).
attr(catalogue_heading,"font-size","10px").
attr(catalogue_heading,"letter-spacing","1px").
attr(catalogue_heading,"font-weight","750").
attr(catalogue_heading,"color","#64748b").
attr(catalogue_add,order,2).
attr(catalogue_add,class,"btn-primary").
attr(catalogue_add,icon,"fa-plus").
attr(catalogue_empty,order,2) :- not object(_,_).
attr(catalogue_empty,"padding","24px 18px") :- not object(_,_).
attr(catalogue_empty,"font-size","13px") :- not object(_,_).
attr(catalogue_empty,"color","#64748b") :- not object(_,_).
attr(catalogue_list,order,2) :- object(_,_).
attr(catalogue_list,"gap","10px") :- object(_,_).
attr(catalogue_list,"overflow","auto") :- object(_,_).
attr(catalogue_list,"max-height","clamp(300px,calc(100vh - 360px),720px)") :- object(_,_).
attr(catalogue_list,"padding","0 10px 12px") :- object(_,_).
attr(catalogue_list,"overscroll-behavior","contain") :- object(_,_).
attr(catalogue_list,"scrollbar-gutter","stable") :- object(_,_).

elem(catalogue_footer,label,sidebar_panel).
attr(catalogue_footer,order,4).
attr(catalogue_footer,label,"Inspect opens object details. Selection stays active while placing.").
attr(catalogue_footer,"padding","12px 18px").
attr(catalogue_footer,"border-top","1px solid #e2e8f0").
attr(catalogue_footer,"font-size","11px").
attr(catalogue_footer,"line-height","1.5").
attr(catalogue_footer,"color","#64748b").
attr(catalogue_footer,"background","#fbfcfe").
attr(type_group(T),"gap","8px") :- object(_,T).
attr(type_group(T),"min-width","0") :- object(_,T).

elem(type_heading(T),container,type_group(T)) :- object(_,T).
attr(type_heading(T),order,1) :- object(_,T).
attr(type_heading(T),flex_direction,row) :- object(_,T).
attr(type_heading(T),"padding","4px 4px 2px") :- object(_,T).
attr(type_heading(T),"align-items","center") :- object(_,T).
attr(type_heading(T),"justify-content","space-between") :- object(_,T).
attr(type_title(T),order,1) :- object(_,T).
attr(type_title(T),"font-size","12px") :- object(_,T).
attr(type_title(T),"font-weight","750") :- object(_,T).
attr(type_title(T),"color","#475569") :- object(_,T).
attr(type_title(T),"text-transform","capitalize") :- object(_,T).

elem(type_items(T),container,type_group(T)) :- object(_,T).
attr(type_items(T),order,2) :- object(_,T).
attr(type_items(T),"gap","8px") :- object(_,T).
attr(type_items(T),"min-width","0") :- object(_,T).
attr(object_card(O,T),"gap","8px") :- object(O,T),_clinguin_context(selected_object,O),issue(O,error,_,_).
attr(object_card(O,T),"padding","10px") :- object(O,T),_clinguin_context(selected_object,O),issue(O,error,_,_).
attr(object_card(O,T),"border","1px solid #dc2626") :- object(O,T),_clinguin_context(selected_object,O),issue(O,error,_,_).
attr(object_card(O,T),"border-radius","10px") :- object(O,T),_clinguin_context(selected_object,O),issue(O,error,_,_).
attr(object_card(O,T),"background","#eff5ff") :- object(O,T),_clinguin_context(selected_object,O),issue(O,error,_,_).
attr(object_card(O,T),"min-width","0") :- object(O,T),_clinguin_context(selected_object,O),issue(O,error,_,_).
attr(object_card(O,T),"box-shadow","inset 3px 0 #2563eb") :- object(O,T),_clinguin_context(selected_object,O),issue(O,error,_,_).
attr(object_card(O,T),"gap","8px") :- object(O,T),_clinguin_context(selected_object,O),not issue(O,error,_,_).
attr(object_card(O,T),"padding","10px") :- object(O,T),_clinguin_context(selected_object,O),not issue(O,error,_,_).
attr(object_card(O,T),"border","2px solid #2563eb") :- object(O,T),_clinguin_context(selected_object,O),not issue(O,error,_,_),not issue(O,warning,property(_),_).
attr(object_card(O,T),"border-radius","10px") :- object(O,T),_clinguin_context(selected_object,O),not issue(O,error,_,_).
attr(object_card(O,T),"background","#eaf2ff") :- object(O,T),_clinguin_context(selected_object,O),not issue(O,error,_,_),not issue(O,warning,property(_),_).
attr(object_card(O,T),"min-width","0") :- object(O,T),_clinguin_context(selected_object,O),not issue(O,error,_,_).
attr(object_card(O,T),"box-shadow","0 5px 16px #2563eb2b") :- object(O,T),_clinguin_context(selected_object,O),not issue(O,error,_,_),not issue(O,warning,property(_),_).
attr(object_card(O,T),"gap","8px") :- object(O,T),not _clinguin_context(selected_object,O),issue(O,error,_,_).
attr(object_card(O,T),"padding","10px") :- object(O,T),not _clinguin_context(selected_object,O),issue(O,error,_,_).
attr(object_card(O,T),"border","1px solid #dc2626") :- object(O,T),not _clinguin_context(selected_object,O),issue(O,error,_,_).
attr(object_card(O,T),"border-radius","10px") :- object(O,T),not _clinguin_context(selected_object,O),issue(O,error,_,_).
attr(object_card(O,T),"background","#ffffff") :- object(O,T),not _clinguin_context(selected_object,O),issue(O,error,_,_).
attr(object_card(O,T),"min-width","0") :- object(O,T),not _clinguin_context(selected_object,O),issue(O,error,_,_).
attr(object_card(O,T),"gap","8px") :- object(O,T),not _clinguin_context(selected_object,O),not issue(O,error,_,_).
attr(object_card(O,T),"padding","10px") :- object(O,T),not _clinguin_context(selected_object,O),not issue(O,error,_,_).
attr(object_card(O,T),"border","1px solid #e2e8f0") :- object(O,T),not _clinguin_context(selected_object,O),not issue(O,error,_,_).
attr(object_card(O,T),"border-radius","10px") :- object(O,T),not _clinguin_context(selected_object,O),not issue(O,error,_,_).
attr(object_card(O,T),"background","#ffffff") :- object(O,T),not _clinguin_context(selected_object,O),not issue(O,error,_,_).
attr(object_card(O,T),"min-width","0") :- object(O,T),not _clinguin_context(selected_object,O),not issue(O,error,_,_).
attr(object_card(O,T),"box-shadow","0 2px 8px #0f172a0d") :- object(O,T),not _clinguin_context(selected_object,O),not issue(O,error,_,_),not issue(O,warning,property(_),_).
attr(object_card(O,T),title,"Select this ready object") :- object(O,T),not issue(O,error,_,_),not issue(O,warning,property(_),_).
attr(object_card(O,T),title,"Complete or correct this object before selection") :- object(O,T),issue(O,_,_,_).
attr(object_card(O,T),flex_direction,row) :- object(O,T).
attr(object_card(O,T),"flex-wrap","wrap") :- object(O,T).
attr(object_card(O,T),"align-items","center") :- object(O,T).
attr(object_media(O,T),order,1) :- elem(object_media(O,T),canvas,_).
attr(object_media(O,T),"flex-shrink","0") :- elem(object_media(O,T),canvas,_).

elem(object_info(O,T),container,object_card(O,T)) :- object(O,T).
attr(object_info(O,T),order,2) :- object(O,T).
attr(object_info(O,T),"flex","1 1 80px") :- object(O,T).
attr(object_info(O,T),"min-width","0") :- object(O,T).
attr(object_info(O,T),"gap","3px") :- object(O,T).
attr(object_body(O,T),order,1) :- object(O,T).
attr(object_body(O,T),"font-size","13px") :- object(O,T).
attr(object_body(O,T),"font-weight","650") :- object(O,T).
attr(object_body(O,T),"color","#1e293b") :- object(O,T).
attr(object_body(O,T),"overflow-wrap","anywhere") :- object(O,T).
attr(object_body(O,T),"line-height","1.4") :- object(O,T).

elem(object_state(O,T),label,object_info(O,T)) :- object(O,T).
attr(object_state(O,T),order,2) :- object(O,T).
attr(object_state(O,T),label,"Needs correction") :- object(O,T),issue(O,error,_,_).
attr(object_state(O,T),"font-size","10px") :- object(O,T),issue(O,error,_,_).
attr(object_state(O,T),"font-weight","600") :- object(O,T),issue(O,error,_,_).
attr(object_state(O,T),"color","#b91c1c") :- object(O,T),issue(O,error,_,_).
attr(object_state(O,T),label,"Incomplete") :- object(O,T),not issue(O,error,_,_),issue(O,warning,_,_).
attr(object_state(O,T),"font-size","10px") :- object(O,T),not issue(O,error,_,_),issue(O,warning,_,_).
attr(object_state(O,T),"font-weight","600") :- object(O,T),not issue(O,error,_,_),issue(O,warning,_,_).
attr(object_state(O,T),"color","#9a6206") :- object(O,T),not issue(O,error,_,_),issue(O,warning,_,_).
attr(object_state(O,T),label,"Ready") :- object(O,T),not issue(O,error,_,_),not issue(O,warning,_,_).
attr(object_state(O,T),"font-size","10px") :- object(O,T),not issue(O,error,_,_),not issue(O,warning,_,_).
attr(object_state(O,T),"font-weight","600") :- object(O,T),not issue(O,error,_,_),not issue(O,warning,_,_).
attr(object_state(O,T),"color","#18705b") :- object(O,T),not issue(O,error,_,_),not issue(O,warning,_,_).

elem(object_actions(O,T),container,object_card(O,T)) :- object(O,T).
attr(object_actions(O,T),order,3) :- object(O,T).
attr(object_actions(O,T),flex_direction,row) :- object(O,T).
attr(object_actions(O,T),"gap","5px") :- object(O,T).
attr(object_actions(O,T),"align-items","center") :- object(O,T).
attr(object_actions(O,T),"flex-wrap","wrap") :- object(O,T).
attr(object_select(O,T),order,1) :- object(O,T).
attr(object_delete(O,T),order,3) :- elem(object_delete(O,T),button,_).

attr(property_row(O,K,V),flex_direction,row) :- elem(property_row(O,K,V),container,_).
attr(property_row(O,K,V),"flex-wrap","wrap") :- elem(property_row(O,K,V),container,_).
attr(position_row(O,N,R),flex_direction,row) :- elem(position_row(O,N,R),container,_).
attr(position_row(O,N,R),"flex-wrap","wrap") :- elem(position_row(O,N,R),container,_).
attr(image_row(O,R,I),flex_direction,row) :- elem(image_row(O,R,I),container,_).
attr(image_row(O,R,I),"flex-wrap","wrap") :- elem(image_row(O,R,I),container,_).
attr(form_actions(F),flex_direction,row) :- elem(form_actions(F),container,_).
attr(form_actions(F),"flex-wrap","wrap") :- elem(form_actions(F),container,_).
attr(summary_objects,order,1).
attr(summary_properties,order,1).
attr(summary_positions,order,1).
attr(summary_edits,order,1).
when(E,click,context,(selected_object,O)) :- object(O,T),not issue(O,error,_,_),not issue(O,warning,property(_),_),elem(E,_,_),E=(object_select(O,T);object_body(O,T);object_media(O,T)).
when(E,click,context,(inspector_open,false)) :- object(O,T),not issue(O,error,_,_),not issue(O,warning,property(_),_),elem(E,_,_),E=(object_select(O,T);object_body(O,T);object_media(O,T)).
when(E,click,context,(dialog,none)) :- object(O,T),not issue(O,error,_,_),not issue(O,warning,property(_),_),elem(E,_,_),E=(object_select(O,T);object_body(O,T);object_media(O,T)).
when(E,click,call,()) :- object(O,T),not issue(O,error,_,_),not issue(O,warning,property(_),_),elem(E,_,_),E=(object_select(O,T);object_body(O,T);object_media(O,T)).
when(E,click,context,(placement_role,R)) :- object(O,T),not issue(O,error,_,_),not issue(O,warning,property(_),_),elem(E,_,_),E=(object_select(O,T);object_body(O,T);object_media(O,T)),_clinguin_context(placement_role,R),role(O,R,_,_,_).
when(E,click,context,(placement_role,R)) :- object(O,T),not issue(O,error,_,_),not issue(O,warning,property(_),_),elem(E,_,_),E=(object_select(O,T);object_body(O,T);object_media(O,T)),0=#count{Old:_clinguin_context(placement_role,Old),role(O,Old,_,_,_)},role(O,R,_,_,_),visual(O,R,_,_,_,_,true),R=#min{A:role(O,A,_,_,_),visual(O,A,_,_,_,_,true)}.
when(E,click,context,(placement_role,R)) :- object(O,T),not issue(O,error,_,_),not issue(O,warning,property(_),_),elem(E,_,_),E=(object_select(O,T);object_body(O,T);object_media(O,T)),0=#count{Old:_clinguin_context(placement_role,Old),role(O,Old,_,_,_)},0=#count{A:role(O,A,_,_,_),visual(O,A,_,_,_,_,true)},role(O,R,_,_,_),R=#min{A:role(O,A,_,_,_)}.
when(E,click,context,(placement_role,none)) :- object(O,T),not issue(O,error,_,_),not issue(O,warning,property(_),_),elem(E,_,_),E=(object_select(O,T);object_body(O,T);object_media(O,T)),not role(O,_,_,_,_).

elem(object_inspect(O,T),button,object_actions(O,T)) :- object(O,T).
attr(object_inspect(O,T),label,"Inspect") :- object(O,T).
attr(object_inspect(O,T),class,"btn-outline-secondary") :- object(O,T).
attr(object_inspect(O,T),order,2) :- object(O,T).
when(object_inspect(O,T),click,context,(selected_object,O)) :- object(O,T),not issue(O,error,_,_),not issue(O,warning,property(_),_).
when(object_inspect(O,T),click,context,(inspector_open,true)) :- object(O,T).
when(object_inspect(O,T),click,context,(dialog,none)) :- object(O,T).
when(object_inspect(O,T),click,call,()) :- object(O,T).
when(object_delete(O,T),click,context,(delete_object,O)) :- elem(object_delete(O,T),button,_).
when(position_remove(O,N,R),click,context,(delete_position,position(N,R,O))) :- elem(position_remove(O,N,R),button,_).

when(object_inspect(O,T),click,context,(placement_role,R)) :- object(O,T),when(object_select(O,T),click,context,(placement_role,R)).
