
% Root.

elem(w,window,root).
attr(w,child_layout,flex).
attr(w,flex_direction,column).
attr(w,class,("d-flex";"flex-column";"text-dark";"min-vh-100")).
attr(w,background_color,"#f3f5f9").

% Menu Bar

elem(menu_bar,menu_bar,w).
attr(menu_bar,order,1).
attr(menu_bar,background_color,"#0b1f3a").
attr(menu_bar,"color","#f8fafc").
attr(menu_bar,"box-shadow","0 4px 18px #02061733").
attr(workspace,order,2).

% Padding

attr(E,class,"editor-container") :- elem(E,container,_).
attr(E,class,("rounded-3";"btn-sm")) :- elem(E,button,_).

elem(new_object,button,menu_bar).
attr(new_object,label,"New object").
attr(new_object,icon,"fa-plus").
attr(new_object,order,1).
attr(new_object,class,("btn-primary";"px-3")).

elem(next_solution_button,button,menu_bar).
attr(next_solution_button,label,"Next solution").
attr(next_solution_button,icon,"fa-forward-step").
attr(next_solution_button,order,2).
attr(next_solution_button,class,("btn-outline-secondary";"px-3")).

elem(clear_edits,button,menu_bar).
attr(clear_edits,icon,"fa-eraser").
attr(clear_edits,order,3).
attr(clear_edits,class,("btn-outline-secondary";"px-3")).

elem(restart_button,button,menu_bar).
attr(restart_button,label,"Restart").
attr(restart_button,icon,"fa-arrows-rotate").
attr(restart_button,order,4).
attr(restart_button,class,("btn-outline-secondary";"px-3")).

elem(help_button,button,menu_bar).
attr(help_button,label,"Help").
attr(help_button,icon,"fa-circle-question").
attr(help_button,order,5).
attr(help_button,class,("btn-outline-secondary";"px-3")).
when(new_object,click,context,(dialog,form(object_create))).
when(new_object,click,update,(dialog(form(object_create)),visibility,shown)).
when(new_object,click,update,(local_feedback,visibility,hidden)).
when(next_solution_button,click,call,next_solution(optN)).
when(clear_edits,click,update,(dialog(clear),visibility,shown)).
when(restart_button,click,update,(dialog(restart),visibility,shown)).
when(help_button,click,update,(dialog(help),visibility,shown)).
attr(clear_edits,label,@concat("Clear edits · ",N)) :- A=#count{X:_clinguin_atom(X)},B=#count{M,O,T:_clinguin_atom(request(M,O,T))},N=A-B.

% Custom dialog containers are real UI elements; shared styles query elem/3.

elem(dialog_sheet(D),container,dialog(D)) :- elem(dialog(D),container,w).
attr(dialog(D),"position","fixed") :- elem(dialog(D),container,w),D!=inspector.
attr(dialog(D),"inset","0") :- elem(dialog(D),container,w),D!=inspector.
attr(dialog(D),"z-index","9010") :- elem(dialog(D),container,w),D!=inspector.
attr(dialog(D),"background","rgba(15,23,42,.66)") :- elem(dialog(D),container,w),D!=inspector.
attr(dialog(D),"backdrop-filter","blur(5px)") :- elem(dialog(D),container,w),D!=inspector.
attr(dialog(D),"overflow","auto") :- elem(dialog(D),container,w),D!=inspector.
attr(dialog(D),"padding","4vh 16px 120px") :- elem(dialog(D),container,w),D!=inspector.
attr(dialog(D),"box-sizing","border-box") :- elem(dialog(D),container,w),D!=inspector.
attr(dialog(D),"position","fixed") :- elem(dialog(D),container,w),D=inspector.
attr(dialog(D),"inset","0") :- elem(dialog(D),container,w),D=inspector.
attr(dialog(D),"z-index","9000") :- elem(dialog(D),container,w),D=inspector.
attr(dialog(D),"background","rgba(15,23,42,.66)") :- elem(dialog(D),container,w),D=inspector.
attr(dialog(D),"backdrop-filter","blur(5px)") :- elem(dialog(D),container,w),D=inspector.
attr(dialog(D),"overflow","auto") :- elem(dialog(D),container,w),D=inspector.
attr(dialog(D),"padding","4vh 16px 120px") :- elem(dialog(D),container,w),D=inspector.
attr(dialog(D),"box-sizing","border-box") :- elem(dialog(D),container,w),D=inspector.
attr(dialog_sheet(D),"display","flex") :- elem(dialog(D),container,w),D!=inspector.
attr(dialog_sheet(D),"flex-direction","column") :- elem(dialog(D),container,w),D!=inspector.
attr(dialog_sheet(D),"position","relative") :- elem(dialog(D),container,w),D!=inspector.
attr(dialog_sheet(D),"margin","0 auto") :- elem(dialog(D),container,w),D!=inspector.
attr(dialog_sheet(D),"background","white") :- elem(dialog(D),container,w),D!=inspector.
attr(dialog_sheet(D),"border-radius","16px") :- elem(dialog(D),container,w),D!=inspector.
attr(dialog_sheet(D),"box-shadow","0 32px 100px #0005") :- elem(dialog(D),container,w),D!=inspector.
attr(dialog_sheet(D),"inline-size","min(100%,760px)") :- elem(dialog(D),container,w),D!=inspector.
attr(dialog_sheet(inspector),"display","flex") :- elem(dialog(inspector),container,w).
attr(dialog_sheet(inspector),"flex-direction","column") :- elem(dialog(inspector),container,w).
attr(dialog_sheet(inspector),"position","relative") :- elem(dialog(inspector),container,w).
attr(dialog_sheet(inspector),"margin","0 auto") :- elem(dialog(inspector),container,w).
attr(dialog_sheet(inspector),"background","white") :- elem(dialog(inspector),container,w).
attr(dialog_sheet(inspector),"border-radius","16px") :- elem(dialog(inspector),container,w).
attr(dialog_sheet(inspector),"box-shadow","0 32px 100px #0005") :- elem(dialog(inspector),container,w).
attr(dialog_sheet(inspector),"inline-size","min(100%,1100px)") :- elem(dialog(inspector),container,w).
elem(dialog_header(D),container,dialog_sheet(D)) :- elem(dialog(D),container,w).
attr(dialog_header(D),order,-100) :- elem(dialog(D),container,w).
attr(dialog_header(D),class,("d-flex";"justify-content-between";"align-items-center";"gap-3";"p-3";"text-white")) :- elem(dialog(D),container,w).
attr(dialog_header(D),"background","#18283f") :- elem(dialog(D),container,w).
attr(dialog_header(D),"border-radius","16px 16px 0 0") :- elem(dialog(D),container,w).
elem(dialog_title(D),label,dialog_header(D)) :- elem(dialog(D),container,w).
attr(dialog_title(D),class,("fw-bold";"fs-5")) :- elem(dialog(D),container,w).
elem(dialog_close(D),button,dialog_header(D)) :- elem(dialog(D),container,w).
attr(dialog_close(D),label,"Close ×") :- elem(dialog(D),container,w).
attr(dialog_close(D),class,"btn-outline-light") :- elem(dialog(D),container,w).
when(dialog_close(D),click,update,(dialog(D),visibility,hidden)) :- elem(dialog(D),container,w).
when(dialog_close(inspector),click,context,(inspector_open,false)) :- elem(dialog(inspector),container,w).
when(dialog_close(D),click,context,(dialog,none)) :- elem(dialog(D),container,w),D!=inspector.
elem(dialog(clear),container,w).
attr(dialog(clear),visibility,hidden).
attr(dialog_title(clear),label,"Clear session edits?").
elem(dialog_text(clear),label,dialog_sheet(clear)).
attr(dialog_text(clear),label,"Remove session-added facts? Source files will remain available.").
attr(dialog_text(clear),class,("p-3";"text-secondary")).
elem(confirm_clear,button,dialog_sheet(clear)).
attr(confirm_clear,label,"Confirm").
attr(confirm_clear,class,("btn-danger";"m-3";"align-self-end")).
when(confirm_clear,click,call,clear_atoms).
when(confirm_clear,click,context,(selected_object,none)).
when(confirm_clear,click,context,(placement_role,none)).
when(confirm_clear,click,context,(inspector_open,false)).
when(confirm_clear,click,context,(undo_operation,none)).
when(confirm_clear,click,context,(dialog,none)).
elem(dialog(restart),container,w).
attr(dialog(restart),visibility,hidden).
attr(dialog_title(restart),label,"Restart the session?").
elem(dialog_text(restart),label,dialog_sheet(restart)).
attr(dialog_text(restart),label,"Restore the original backend state and clear the active selection.").
attr(dialog_text(restart),class,("p-3";"text-secondary")).
elem(confirm_restart,button,dialog_sheet(restart)).
attr(confirm_restart,label,"Confirm").
attr(confirm_restart,class,("btn-danger";"m-3";"align-self-end")).
when(confirm_restart,click,call,restart).
when(confirm_restart,click,context,(selected_object,none)).
when(confirm_restart,click,context,(placement_role,none)).
when(confirm_restart,click,context,(inspector_open,false)).
when(confirm_restart,click,context,(undo_operation,none)).
when(confirm_restart,click,context,(dialog,none)).
elem(dialog(help),container,w).
attr(dialog(help),visibility,hidden).
attr(dialog_title(help),label,"Generic UI").
elem(dialog_text(help),label,dialog_sheet(help)).
attr(dialog_text(help),label,"Select an object, then click grid cells to place it repeatedly. Inspect opens details. Click the same session placement or right-click to delete immediately. Messages appear at the bottom.").
attr(dialog_text(help),class,("p-3";"text-secondary")).

% Request commits: standard operations, no editor_commit/pending_commit predicates.

elem(commit(create,O,T),container,w) :- request(create,O,T),_clinguin_atom(request(create,O,T)),not rejection(create,O,T,_,_),not _clinguin_unsat.
attr(commit(create,O,T),order,1000) :- request(create,O,T),_clinguin_atom(request(create,O,T)),not rejection(create,O,T,_,_),not _clinguin_unsat.
attr(commit(create,O,T),"display","none") :- request(create,O,T),_clinguin_atom(request(create,O,T)),not rejection(create,O,T,_,_),not _clinguin_unsat.
when(commit(create,O,T),load,context,(undo_operation,remove_atom(object(O,T)))) :- request(create,O,T),_clinguin_atom(request(create,O,T)),not rejection(create,O,T,_,_),not _clinguin_unsat.
when(commit(create,O,T),load,context,(dialog,none)) :- request(create,O,T),_clinguin_atom(request(create,O,T)),not rejection(create,O,T,_,_),not _clinguin_unsat.
when(commit(create,O,T),load,call,(remove_atom(request(create,O,T)),add_atom(object(O,T)))) :- request(create,O,T),_clinguin_atom(request(create,O,T)),not rejection(create,O,T,_,_),not _clinguin_unsat.
when(commit(create,O,T),load,context,(K,V)) :- request(create,O,T),_clinguin_atom(request(create,O,T)),not rejection(create,O,T,_,_),not _clinguin_unsat,when(w,load,context,(K,V)),K!=undo_operation,K!=dialog.
elem(commit(edit(Old),O,T),container,w) :- request(edit(Old),O,T),_clinguin_atom(request(edit(Old),O,T)),not rejection(edit(Old),O,T,_,_),not _clinguin_unsat.
attr(commit(edit(Old),O,T),order,1000) :- request(edit(Old),O,T),_clinguin_atom(request(edit(Old),O,T)),not rejection(edit(Old),O,T,_,_),not _clinguin_unsat.
attr(commit(edit(Old),O,T),"display","none") :- request(edit(Old),O,T),_clinguin_atom(request(edit(Old),O,T)),not rejection(edit(Old),O,T,_,_),not _clinguin_unsat.
when(commit(edit(Old),O,T),load,context,(undo_operation,(remove_atom(object(O,T)),add_atom(object(O,Old))))) :- request(edit(Old),O,T),_clinguin_atom(request(edit(Old),O,T)),not rejection(edit(Old),O,T,_,_),not _clinguin_unsat.
when(commit(edit(Old),O,T),load,context,(dialog,none)) :- request(edit(Old),O,T),_clinguin_atom(request(edit(Old),O,T)),not rejection(edit(Old),O,T,_,_),not _clinguin_unsat.
when(commit(edit(Old),O,T),load,call,(remove_atom(request(edit(Old),O,T)),remove_atom(object(O,Old)),add_atom(object(O,T)))) :- request(edit(Old),O,T),_clinguin_atom(request(edit(Old),O,T)),not rejection(edit(Old),O,T,_,_),not _clinguin_unsat.
when(commit(edit(Old),O,T),load,context,(K,V)) :- request(edit(Old),O,T),_clinguin_atom(request(edit(Old),O,T)),not rejection(edit(Old),O,T,_,_),not _clinguin_unsat,when(w,load,context,(K,V)),K!=undo_operation,K!=dialog.

% Replay durable context. All context changes are native Clinguin actions.

when(w,load,context,(K,V)) :- _clinguin_context(K,V),K=(placement_role;grid_scale;label_mode;inspector_open;edit_property_object;edit_property_key;edit_property_value;edit_position_object;edit_position_row;edit_position_col;edit_position_role;edit_image_object;edit_image_role;edit_image_path).
when(w,load,context,(inspected(O),true)) :- object(O,_),_clinguin_context(inspected(O),true).
when(w,load,context,(K,V)) :- elem(input(_,K),textfield,_),_clinguin_context(K,V).
when(w,load,context,(undo_operation,Op)) :- _clinguin_context(undo_operation,Op),not elem(commit(_,_,_),container,w),0=#count{Action:_clinguin_context(last_grid_action,Action),Action!=()}.
when(w,load,context,(dialog,D)) :- _clinguin_context(dialog,D),not elem(commit(_,_,_),container,w),not _clinguin_context(submitted,true).
when(w,load,context,(dialog,D)) :- _clinguin_context(dialog,D),not elem(commit(_,_,_),container,w),_clinguin_context(submitted,true),_clinguin_unsat.
when(w,load,context,(dialog,none)) :- _clinguin_context(submitted,true),not _clinguin_unsat,not elem(commit(_,_,_),container,w).

% One-step undo for property/position/image operations; no helper predicates.

when(E,click,context,(undo_operation,remove_atom(property(O,K,V)))) :- when(E,click,call,add_atom(property(O,K,V))),E!=undo_button.
when(E,click,context,(undo_operation,add_atom(property(O,K,V)))) :- when(E,click,call,remove_atom(property(O,K,V))),E!=undo_button,not when(E,click,context,(delete_object,_)).
when(E,click,context,(undo_operation,remove_atom(position(N,R,O)))) :- when(E,click,call,add_atom(position(N,R,O))),E!=undo_button.
when(E,click,context,(undo_operation,add_atom(position(N,R,O)))) :- when(E,click,call,remove_atom(position(N,R,O))),E!=undo_button,not when(E,click,context,(delete_object,_)).
when(E,click,context,(undo_operation,remove_atom(image(O,R,I)))) :- when(E,click,call,add_atom(image(O,R,I))),E!=undo_button.
when(E,click,context,(undo_operation,add_atom(image(O,R,I)))) :- when(E,click,call,remove_atom(image(O,R,I))),E!=undo_button,not when(E,click,context,(delete_object,_)).
when(E,click,context,(undo_operation,(remove_atom(property(O2,K2,V2)),add_atom(property(O,K,V))))) :- when(E,click,call,(remove_atom(property(O,K,V)),add_atom(property(O2,K2,V2)))),E!=undo_button.
when(E,click,context,(undo_operation,(remove_atom(position(N2,R2,O2)),add_atom(position(N,R,O))))) :- when(E,click,call,(remove_atom(position(N,R,O)),add_atom(position(N2,R2,O2)))),E!=undo_button.
when(E,click,context,(undo_operation,(remove_atom(image(O2,R2,I2)),add_atom(image(O,R,I))))) :- when(E,click,call,(remove_atom(image(O,R,I)),add_atom(image(O2,R2,I2)))),E!=undo_button.
elem(undo_button,button,menu_bar) :- _clinguin_context(undo_operation,Op),Op!=none.
attr(undo_button,label,"Undo last change") :- _clinguin_context(undo_operation,Op),Op!=none.
attr(undo_button,class,"btn-outline-secondary") :- _clinguin_context(undo_operation,Op),Op!=none.
attr(undo_button,order,6) :- _clinguin_context(undo_operation,Op),Op!=none.
when(undo_button,click,call,Op) :- _clinguin_context(undo_operation,Op),Op!=none,0=#count{Action:_clinguin_context(last_grid_action,Action),Action!=()}.
when(undo_button,click,context,(undo_operation,none)) :- _clinguin_context(undo_operation,Op),Op!=none.

% Immediate feedback: an existing panel updated locally.

elem(local_feedback,container,w).
attr(local_feedback,visibility,hidden) :- not _clinguin_context(notice_message,_),not _clinguin_context(last_grid_action,()).
attr(local_feedback,visibility,hidden) :- _clinguin_unsat.
attr(local_feedback,visibility,shown) :- _clinguin_context(notice_message,M),M!="",not _clinguin_unsat.
attr(local_feedback,visibility,hidden) :- _clinguin_context(notice_message,""),not _clinguin_context(last_grid_action,remove_atom(_)),not _clinguin_context(last_grid_action,()).
attr(local_feedback,visibility,shown) :- _clinguin_context(last_grid_action,remove_atom(_)),not _clinguin_unsat.
attr(local_feedback,"position","fixed").
attr(local_feedback,"left","18px").
attr(local_feedback,"bottom","20px").
attr(local_feedback,"z-index","10021").
attr(local_feedback,"width","min(380px,calc(50vw - 28px))").
attr(local_feedback,"max-height","30vh").
attr(local_feedback,"overflow","auto").
attr(local_feedback,"padding","16px").
attr(local_feedback,"box-sizing","border-box").
attr(local_feedback,"border-left","4px solid #3b82f6").
attr(local_feedback,"border-radius","16px").
attr(local_feedback,"background","white").
attr(local_feedback,"color","#172554").
attr(local_feedback,"box-shadow","0 16px 54px #0f172a40").
elem(local_title,label,local_feedback).
attr(local_title,class,"fw-bold").
attr(local_title,label,"Feedback") :- not _clinguin_context(notice_title,_).
attr(local_title,label,Title) :- _clinguin_context(notice_title,Title).
elem(local_detail,label,local_feedback).
attr(local_detail,class,("small";"d-block";"mt-2")).
attr(local_detail,label,"") :- not _clinguin_context(notice_message,_),not _clinguin_context(last_grid_action,remove_atom(_)),not _clinguin_context(last_grid_action,()).
attr(local_detail,label,Message) :- _clinguin_context(notice_message,Message),not _clinguin_context(last_grid_action,remove_atom(_)),not _clinguin_context(last_grid_action,()).
attr(local_detail,label,"Placement removed.") :- _clinguin_context(last_grid_action,remove_atom(_)),not _clinguin_unsat.
elem(local_close,button,local_feedback).
attr(local_close,label,"Dismiss").
attr(local_close,class,("btn-outline-secondary";"mt-2")).
when(local_close,click,update,(local_feedback,visibility,hidden)).

% Backend feedback uses generic rejection/5 and issue/4 directly.

elem(feedback_panel,container,w) :- _clinguin_unsat.
elem(feedback_panel,container,w) :- request(M,O,T),rejection(M,O,T,_,_),_clinguin_context(dialog,form(object_create)),M=create.
elem(feedback_panel,container,w) :- request(edit(Old),O,T),rejection(edit(Old),O,T,_,_),_clinguin_context(dialog,form(object_edit)).
elem(feedback_panel,container,w) :- issue(O,error,F,_).
attr(feedback_panel,"position","fixed") :- elem(feedback_panel,container,w).
attr(feedback_panel,"right","20px") :- elem(feedback_panel,container,w).
attr(feedback_panel,"bottom","20px") :- elem(feedback_panel,container,w).
attr(feedback_panel,"z-index","10020") :- elem(feedback_panel,container,w).
attr(feedback_panel,"width","min(520px,calc(50vw - 28px))") :- elem(feedback_panel,container,w).
attr(feedback_panel,"max-height","28vh") :- elem(feedback_panel,container,w).
attr(feedback_panel,"overflow","auto") :- elem(feedback_panel,container,w).
attr(feedback_panel,"padding","16px") :- elem(feedback_panel,container,w).
attr(feedback_panel,"border-left","5px solid #ef4444") :- elem(feedback_panel,container,w).
attr(feedback_panel,"border-radius","16px") :- elem(feedback_panel,container,w).
attr(feedback_panel,"background","#fef2f2") :- elem(feedback_panel,container,w).
attr(feedback_panel,"color","#991b1b") :- elem(feedback_panel,container,w).
attr(feedback_panel,"box-shadow","0 16px 54px #0f172a40") :- elem(feedback_panel,container,w).
elem(feedback_heading,label,feedback_panel) :- elem(feedback_panel,container,w).
attr(feedback_heading,class,"fw-bold") :- elem(feedback_panel,container,w).
attr(feedback_heading,label,"No solution") :- _clinguin_unsat.
attr(feedback_heading,label,"Please correct this entry") :- elem(feedback_panel,container,w),not _clinguin_unsat.
elem(feedback_message(unsat),label,feedback_panel) :- _clinguin_unsat.
attr(feedback_message(unsat),label,"The current facts violate a domain constraint. Use Undo last change or Clear edits to recover.") :- _clinguin_unsat.
elem(feedback_message(request(create,O,T,F,Message)),label,feedback_panel) :- request(create,O,T),rejection(create,O,T,F,Message),_clinguin_context(dialog,form(object_create)),not _clinguin_unsat.
attr(feedback_message(request(create,O,T,F,Message)),label,@concat(F," · ",Message)) :- request(create,O,T),rejection(create,O,T,F,Message),_clinguin_context(dialog,form(object_create)),not _clinguin_unsat.
elem(feedback_message(request(edit(Old),O,T,F,Message)),label,feedback_panel) :- request(edit(Old),O,T),rejection(edit(Old),O,T,F,Message),_clinguin_context(dialog,form(object_edit)),not _clinguin_unsat.
attr(feedback_message(request(edit(Old),O,T,F,Message)),label,@concat(F," · ",Message)) :- request(edit(Old),O,T),rejection(edit(Old),O,T,F,Message),_clinguin_context(dialog,form(object_edit)),not _clinguin_unsat.
elem(feedback_message(object(O,F,Message)),label,feedback_panel) :- issue(O,error,F,Message),not _clinguin_unsat.
attr(feedback_message(object(O,F,Message)),label,@concat(O," · ",Message)) :- elem(feedback_message(object(O,F,Message)),label,_).
elem(feedback_close,button,feedback_panel) :- elem(feedback_panel,container,w).
attr(feedback_close,label,"Dismiss") :- elem(feedback_panel,container,w).
attr(feedback_close,class,("btn-outline-secondary";"mt-2")) :- elem(feedback_panel,container,w).
when(feedback_close,click,update,(feedback_panel,visibility,hidden)) :- elem(feedback_panel,container,w).
elem(operation_toast,container,w).
attr(operation_toast,"position","fixed").
attr(operation_toast,"left","18px").
attr(operation_toast,"bottom","20px").
attr(operation_toast,"z-index","10015").
attr(operation_toast,"background","#172554").
attr(operation_toast,"color","white").
attr(operation_toast,"padding","14px").
attr(operation_toast,"border-radius","12px").
attr(operation_toast,"max-width","420px").
elem(operation_status,label,operation_toast).
attr(operation_status,label,"Ready") :- not _clinguin_context(selected_object,O):object(O,_).
attr(operation_status,label,"Ready to place") :- _clinguin_context(selected_object,O),object(O,_),_clinguin_context(placement_role,R),role(O,R,S,_,Max),not issue(O,error,_,_),not issue(O,warning,property(_),_).
attr(operation_status,label,"Complete object first") :- _clinguin_context(selected_object,O),object(O,_),issue(O,_,_,_).
attr(operation_status,label,"Choose a placement role") :- _clinguin_context(selected_object,O),object(O,_),not _clinguin_context(placement_role,R):role(O,R,_,_,_).

attr(dialog_header(D),flex_direction,row) :- elem(dialog(D),container,w).
attr(dialog_title(D),order,1) :- elem(dialog(D),container,w).
attr(dialog_close(D),order,2) :- elem(dialog(D),container,w).

% Label paragraphs otherwise default to centered text in AngularFrontend.
attr(E,class,"text-start") :- elem(E,label,P),not elem(P,container,node_box(_,_)),not elem(P,container,placement(_,_,_)),P!=placement_preview_id_box,P!=placement_preview.
% Native application bar reserves its own height and wraps actions on small screens.
attr(menu_bar,title,"Generic UI").
attr(menu_bar,icon,"fa-table-cells").

% Direct deletion: a valid click causes one backend request; blocked deletion updates local feedback.
when(E,Ev,call,remove_atom(position(N,R,O))) :- when(E,Ev,context,(delete_position,position(N,R,O))),_clinguin_atom(position(N,R,O)),role(O,R,S,_,_),0=#count{Dep,Rd:elem(placement(N,Rd,Dep),container,_),support(Dep,Rd,S),Dep!=O},not _clinguin_unsat.
when(E,Ev,update,(placement(N,R,O),visibility,hidden)) :- when(E,Ev,context,(delete_position,position(N,R,O))),_clinguin_atom(position(N,R,O)),role(O,R,S,_,_),0=#count{Dep,Rd:elem(placement(N,Rd,Dep),container,_),support(Dep,Rd,S),Dep!=O},not _clinguin_unsat,elem(placement(N,R,O),container,_).
when(E,Ev,context,(notice_title,"Deleted")) :- when(E,Ev,context,(delete_position,position(N,R,O))),_clinguin_atom(position(N,R,O)),role(O,R,S,_,_),0=#count{Dep,Rd:elem(placement(N,Rd,Dep),container,_),support(Dep,Rd,S),Dep!=O},not _clinguin_unsat.
when(E,Ev,context,(notice_message,"Placement removed.")) :- when(E,Ev,context,(delete_position,position(N,R,O))),_clinguin_atom(position(N,R,O)),role(O,R,S,_,_),0=#count{Dep,Rd:elem(placement(N,Rd,Dep),container,_),support(Dep,Rd,S),Dep!=O},not _clinguin_unsat.
when(E,Ev,update,(operation_status,label,"Removing…")) :- when(E,Ev,context,(delete_position,position(N,R,O))),_clinguin_atom(position(N,R,O)),role(O,R,S,_,_),0=#count{Dep,Rd:elem(placement(N,Rd,Dep),container,_),support(Dep,Rd,S),Dep!=O},not _clinguin_unsat.
when(E,Ev,call,remove_atom(position(N,R,O))) :- when(E,Ev,context,(delete_position,position(N,R,O))),_clinguin_atom(position(N,R,O)),role(O,R,S,_,_),placeholder(O),not _clinguin_unsat.
when(E,Ev,update,(placement(N,R,O),visibility,hidden)) :- when(E,Ev,context,(delete_position,position(N,R,O))),_clinguin_atom(position(N,R,O)),role(O,R,S,_,_),placeholder(O),not _clinguin_unsat,elem(placement(N,R,O),container,_).
when(E,Ev,context,(notice_title,"Deleted")) :- when(E,Ev,context,(delete_position,position(N,R,O))),_clinguin_atom(position(N,R,O)),role(O,R,S,_,_),placeholder(O),not _clinguin_unsat.
when(E,Ev,context,(notice_message,"Placement removed.")) :- when(E,Ev,context,(delete_position,position(N,R,O))),_clinguin_atom(position(N,R,O)),role(O,R,S,_,_),placeholder(O),not _clinguin_unsat.
when(E,Ev,update,(operation_status,label,"Removing…")) :- when(E,Ev,context,(delete_position,position(N,R,O))),_clinguin_atom(position(N,R,O)),role(O,R,S,_,_),placeholder(O),not _clinguin_unsat.
when(E,Ev,update,(local_feedback,visibility,shown)) :- when(E,Ev,context,(delete_position,position(N,R,O))),_clinguin_atom(position(N,R,O)),role(O,R,S,_,_),0<#count{Dep,Rd:elem(placement(N,Rd,Dep),container,_),support(Dep,Rd,S),Dep!=O},not placeholder(O),not _clinguin_unsat.
when(E,Ev,update,(local_title,label,"Deletion blocked")) :- when(E,Ev,context,(delete_position,position(N,R,O))),_clinguin_atom(position(N,R,O)),role(O,R,S,_,_),0<#count{Dep,Rd:elem(placement(N,Rd,Dep),container,_),support(Dep,Rd,S),Dep!=O},not placeholder(O),not _clinguin_unsat.
when(E,Ev,update,(local_detail,label,"This object supports another placement. Remove the dependent placement first.")) :- when(E,Ev,context,(delete_position,position(N,R,O))),_clinguin_atom(position(N,R,O)),role(O,R,S,_,_),0<#count{Dep,Rd:elem(placement(N,Rd,Dep),container,_),support(Dep,Rd,S),Dep!=O},not placeholder(O),not _clinguin_unsat.
when(E,Ev,context,(selected_object,_context_value(selected_object,const,none))) :- when(E,Ev,call,remove_atom(position(N,R,O))),not when(E,Ev,context,(delete_object,_)).
when(E,Ev,context,(placement_role,_context_value(placement_role,const,none))) :- when(E,Ev,call,remove_atom(position(N,R,O))),not when(E,Ev,context,(delete_object,_)).
when(E,right_click,context,(undo_operation,add_atom(position(N,R,O)))) :- when(E,right_click,call,remove_atom(position(N,R,O))).
when(E,Ev,call,remove_atom(object(O,T))) :- when(E,Ev,context,(delete_object,O)),object(O,T),_clinguin_atom(object(O,T)),0=#count{N,R,Dep,Rd:position(N,R,O),role(O,R,S,_,_),elem(placement(N,Rd,Dep),container,_),support(Dep,Rd,S),Dep!=O,not placeholder(O)},not _clinguin_unsat.
when(E,Ev,update,(object_card(O,T),visibility,hidden)) :- when(E,Ev,context,(delete_object,O)),object(O,T),_clinguin_atom(object(O,T)),0=#count{N,R,Dep,Rd:position(N,R,O),role(O,R,S,_,_),elem(placement(N,Rd,Dep),container,_),support(Dep,Rd,S),Dep!=O,not placeholder(O)},not _clinguin_unsat.
when(E,Ev,call,remove_atom(property(O,K,V))) :- when(E,Ev,context,(delete_object,O)),object(O,T),_clinguin_atom(object(O,T)),0=#count{N,R,Dep,Rd:position(N,R,O),role(O,R,S,_,_),elem(placement(N,Rd,Dep),container,_),support(Dep,Rd,S),Dep!=O,not placeholder(O)},not _clinguin_unsat,_clinguin_atom(property(O,K,V)).
when(E,Ev,call,remove_atom(position(N,R,O))) :- when(E,Ev,context,(delete_object,O)),object(O,T),_clinguin_atom(object(O,T)),0=#count{N,R,Dep,Rd:position(N,R,O),role(O,R,S,_,_),elem(placement(N,Rd,Dep),container,_),support(Dep,Rd,S),Dep!=O,not placeholder(O)},not _clinguin_unsat,_clinguin_atom(position(N,R,O)).
when(E,Ev,call,remove_atom(image(O,R,I))) :- when(E,Ev,context,(delete_object,O)),object(O,T),_clinguin_atom(object(O,T)),0=#count{N,R,Dep,Rd:position(N,R,O),role(O,R,S,_,_),elem(placement(N,Rd,Dep),container,_),support(Dep,Rd,S),Dep!=O,not placeholder(O)},not _clinguin_unsat,_clinguin_atom(image(O,R,I)).
when(E,Ev,context,(undo_operation,none)) :- when(E,Ev,context,(delete_object,O)),object(O,T),_clinguin_atom(object(O,T)),0=#count{N,R,Dep,Rd:position(N,R,O),role(O,R,S,_,_),elem(placement(N,Rd,Dep),container,_),support(Dep,Rd,S),Dep!=O,not placeholder(O)},not _clinguin_unsat.
when(E,Ev,context,(dialog,none)) :- when(E,Ev,context,(delete_object,O)),object(O,T),_clinguin_atom(object(O,T)),0=#count{N,R,Dep,Rd:position(N,R,O),role(O,R,S,_,_),elem(placement(N,Rd,Dep),container,_),support(Dep,Rd,S),Dep!=O,not placeholder(O)},not _clinguin_unsat.
when(E,Ev,context,(notice_title,"Deleted")) :- when(E,Ev,context,(delete_object,O)),object(O,T),_clinguin_atom(object(O,T)),0=#count{N,R,Dep,Rd:position(N,R,O),role(O,R,S,_,_),elem(placement(N,Rd,Dep),container,_),support(Dep,Rd,S),Dep!=O,not placeholder(O)},not _clinguin_unsat.
when(E,Ev,context,(notice_message,"Object removed.")) :- when(E,Ev,context,(delete_object,O)),object(O,T),_clinguin_atom(object(O,T)),0=#count{N,R,Dep,Rd:position(N,R,O),role(O,R,S,_,_),elem(placement(N,Rd,Dep),container,_),support(Dep,Rd,S),Dep!=O,not placeholder(O)},not _clinguin_unsat.
when(E,Ev,update,(local_feedback,visibility,shown)) :- when(E,Ev,context,(delete_object,O)),object(O,T),_clinguin_atom(object(O,T)),0<#count{N,R,Dep,Rd:position(N,R,O),role(O,R,S,_,_),elem(placement(N,Rd,Dep),container,_),support(Dep,Rd,S),Dep!=O,not placeholder(O)},not _clinguin_unsat.
when(E,Ev,update,(local_title,label,"Deletion blocked")) :- when(E,Ev,context,(delete_object,O)),object(O,T),_clinguin_atom(object(O,T)),0<#count{N,R,Dep,Rd:position(N,R,O),role(O,R,S,_,_),elem(placement(N,Rd,Dep),container,_),support(Dep,Rd,S),Dep!=O,not placeholder(O)},not _clinguin_unsat.
when(E,Ev,update,(local_detail,label,"This object supports another placement. Remove the dependent placement first.")) :- when(E,Ev,context,(delete_object,O)),object(O,T),_clinguin_atom(object(O,T)),0<#count{N,R,Dep,Rd:position(N,R,O),role(O,R,S,_,_),elem(placement(N,Rd,Dep),container,_),support(Dep,Rd,S),Dep!=O,not placeholder(O)},not _clinguin_unsat.
attr(local_title,order,1).
attr(local_detail,order,1).
attr(local_close,order,3).

when(E,Ev,update,(local_feedback,visibility,shown)) :- when(E,Ev,context,(delete_position,_)),_clinguin_unsat.
when(E,Ev,update,(local_title,label,"Resolve the constraint error")) :- when(E,Ev,context,(delete_position,_)),_clinguin_unsat.
when(E,Ev,update,(local_detail,label,"Use Undo last change before deleting another placement or object.")) :- when(E,Ev,context,(delete_position,_)),_clinguin_unsat.
when(E,Ev,update,(local_feedback,visibility,shown)) :- when(E,Ev,context,(delete_object,_)),_clinguin_unsat.
when(E,Ev,update,(local_title,label,"Resolve the constraint error")) :- when(E,Ev,context,(delete_object,_)),_clinguin_unsat.
when(E,Ev,update,(local_detail,label,"Use Undo last change before deleting another placement or object.")) :- when(E,Ev,context,(delete_object,_)),_clinguin_unsat.
when(w,load,context,(selected_object,O)) :- _clinguin_context(selected_object,O),object(O,_).
when(w,load,context,(selected_object,none)) :- _clinguin_context(selected_object,O),not object(O,_).
