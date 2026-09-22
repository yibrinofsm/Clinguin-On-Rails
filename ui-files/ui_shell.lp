% Window
elem(w,window,root).
attr(w,child_layout,flex).
attr(w,class,("d-flex";"flex-column";"text-dark";"g-light";"min-vh-100")).

% Workspace
attr(workspace,order,2).

% Menu Bar
elem(menu_bar,menu_bar,w).
attr(menu_bar,title,"Generic UI").
attr(menu_bar,icon,"fa-table-cells").

% Add new Object
elem(add_new_object,button,menu_bar).
attr(add_new_object,label,"New object").
attr(add_new_object,icon,"fa-plus").
attr(add_new_object,order,1).
attr(add_new_object,class,("btn-primary";"px-3")).
when(add_new_object,click,context,(dialog,form(object_create))).
when(add_new_object,click,update,(dialog(form(object_create)),visibility,shown)).
when(add_new_object,click,update,(local_feedback,visibility,hidden)).

% Next Solution
elem(next_solution_button,button,menu_bar).
attr(next_solution_button,label,"Next solution").
attr(next_solution_button,icon,"fa-forward-step").
attr(next_solution_button,order,2).
attr(next_solution_button,class,("btn-outline-secondary";"px-3")).
when(next_solution_button,click,call,next_solution(optN)).

% Clear Edits Button
elem(clear_edits_button,button,menu_bar).
attr(clear_edits_button,icon,"fa-eraser").
attr(clear_edits_button,order,3).
attr(clear_edits_button,class,("btn-outline-secondary";"px-3")).
attr(clear_edits_button,label,@concat("Clear edits · ",N)) :- A=#count{X:_clinguin_atom(X)},B=#count{M,O,T:_clinguin_atom(request(M,O,T))},N=A-B.
when(clear_edits_button,click,update,(dialog(clear),visibility,shown)).

% Restart Button
elem(restart_button,button,menu_bar).
attr(restart_button,label,"Restart").
attr(restart_button,icon,"fa-arrows-rotate").
attr(restart_button,order,4).
attr(restart_button,class,("btn-outline-secondary";"px-3")).
when(restart_button,click,update,(dialog(restart),visibility,shown)).

% Help Button
elem(help_button,button,menu_bar).
attr(help_button,label,"Help").
attr(help_button,icon,"fa-circle-question").
attr(help_button,order,5).
attr(help_button,class,("btn-outline-secondary";"px-3")).
when(help_button,click,update,(dialog(help),visibility,shown)).

% Undo Button
elem(undo_button,button,menu_bar) :- _clinguin_context(undo_operation,Op),Op!=none.
attr(undo_button,order,6) :- _clinguin_context(undo_operation,Op),Op!=none.
attr(undo_button,label,"Undo last change") :- _clinguin_context(undo_operation,Op),Op!=none.
attr(undo_button,class,"btn-outline-secondary") :- _clinguin_context(undo_operation,Op),Op!=none.
when(undo_button,click,call,Op) :- _clinguin_context(undo_operation,Op),Op!=none,0=#count{Action:_clinguin_context(last_grid_action,Action),Action!=()}.
when(undo_button,click,context,(undo_operation,none)) :- _clinguin_context(undo_operation,Op),Op!=none.

% Shared Modal Attributes
attr(dialog(D),size,"lg") :- elem(dialog(D),modal,w),D!=inspector.
attr(dialog(D),visibility,hidden) :- elem(dialog(D),modal,w),elem(commit(_,_,_),container,w).

% Dialog Sheet
elem(dialog_sheet(D),container,dialog(D)) :- elem(dialog(D),modal,w).
attr(dialog_sheet(D),class,("d-flex";"flex-column";"gap-2";"p-0";"m-0")) :- elem(dialog(D),modal,w).
attr(dialog_sheet(D),order,1) :- elem(dialog(D),modal,w).

% Dialog Close Button
elem(dialog_close(D),button,dialog_sheet(D)) :- elem(dialog(D),modal,w).
attr(dialog_close(D),label,"Close ×") :- elem(dialog(D),modal,w).
attr(dialog_close(D),class,("btn-outline-secondary";"align-self-end")) :- elem(dialog(D),modal,w).
attr(dialog_close(D),order,1000) :- elem(dialog(D),modal,w).
when(dialog_close(D),click,update,(dialog(D),visibility,hidden)) :- elem(dialog(D),modal,w).
when(dialog_close(inspector),click,context,(inspector_open,false)) :- elem(dialog(inspector),modal,w).
when(dialog_close(D),click,context,(dialog,none)) :- elem(dialog(D),modal,w),D!=inspector.

% Shared Dialog Text Attributes
attr(dialog_text(D),order,1) :- elem(dialog_text(D),label,_).

% Clear Modal
elem(dialog(clear),modal,w).
attr(dialog(clear),visibility,hidden).
attr(dialog(clear),title,"Clear session edits?").

% Clear Modal Text
elem(dialog_text(clear),label,dialog_sheet(clear)).
attr(dialog_text(clear),label,"Remove session-added facts? Source files will remain available.").
attr(dialog_text(clear),class,("p-3";"text-secondary")).

% Confirm Clear Button
elem(confirm_clear,button,dialog_sheet(clear)).
attr(confirm_clear,label,"Confirm").
attr(confirm_clear,class,("btn-danger";"m-3";"align-self-end")).
attr(confirm_clear,order,2).
when(confirm_clear,click,call,clear_atoms).
when(confirm_clear,click,context,(selected_object,none)).
when(confirm_clear,click,context,(placement_role,none)).
when(confirm_clear,click,context,(inspector_open,false)).
when(confirm_clear,click,context,(undo_operation,none)).
when(confirm_clear,click,context,(dialog,none)).

% Restart Modal
elem(dialog(restart),modal,w).
attr(dialog(restart),visibility,hidden).
attr(dialog(restart),title,"Restart the session?").

% Restart Modal Text
elem(dialog_text(restart),label,dialog_sheet(restart)).
attr(dialog_text(restart),label,"Restore the original backend state and clear the active selection.").
attr(dialog_text(restart),class,("p-3";"text-secondary")).

% Confirm Restart Button
elem(confirm_restart,button,dialog_sheet(restart)).
attr(confirm_restart,label,"Confirm").
attr(confirm_restart,class,("btn-danger";"m-3";"align-self-end")).
attr(confirm_restart,order,2).
when(confirm_restart,click,call,restart).
when(confirm_restart,click,context,(selected_object,none)).
when(confirm_restart,click,context,(placement_role,none)).
when(confirm_restart,click,context,(inspector_open,false)).
when(confirm_restart,click,context,(undo_operation,none)).
when(confirm_restart,click,context,(dialog,none)).

% Help Modal
elem(dialog(help),modal,w).
attr(dialog(help),visibility,hidden).
attr(dialog(help),title,"Generic UI").

% Help Modal Text
elem(dialog_text(help),label,dialog_sheet(help)).
attr(dialog_text(help),label,"Select an object, then click grid cells to place it repeatedly. Inspect opens details. Click the same session placement or right-click to delete immediately. Messages appear at the bottom.").
attr(dialog_text(help),class,("p-3";"text-secondary")).

% Inspector Modal
attr(dialog(inspector),size,"xl") :- elem(dialog(inspector),modal,w).

% Form Body
attr(form_body(F),order,1) :- elem(form_body(F),container,_).

% Inspector Content
attr(inspector_content,order,1) :- elem(inspector_content,container,_).

% Shared Commit Container Attributes
attr(commit(M,O,T),class,"d-none") :- elem(commit(M,O,T),container,w).

% Create Object Commit
elem(commit(create,O,T),container,w) :- request(create,O,T),_clinguin_atom(request(create,O,T)),not rejection(create,O,T,_,_),not _clinguin_unsat.
attr(commit(create,O,T),order,1000) :- request(create,O,T),_clinguin_atom(request(create,O,T)),not rejection(create,O,T,_,_),not _clinguin_unsat.
when(commit(create,O,T),load,context,(undo_operation,remove_atom(object(O,T)))) :- request(create,O,T),_clinguin_atom(request(create,O,T)),not rejection(create,O,T,_,_),not _clinguin_unsat.
when(commit(create,O,T),load,context,(dialog,none)) :- request(create,O,T),_clinguin_atom(request(create,O,T)),not rejection(create,O,T,_,_),not _clinguin_unsat.
when(commit(create,O,T),load,context,(K,V)) :- request(create,O,T),_clinguin_atom(request(create,O,T)),not rejection(create,O,T,_,_),not _clinguin_unsat,when(w,load,context,(K,V)),K!=undo_operation,K!=dialog.

% Edit Object Commit
elem(commit(edit(Old),O,T),container,w) :- request(edit(Old),O,T),_clinguin_atom(request(edit(Old),O,T)),not rejection(edit(Old),O,T,_,_),not _clinguin_unsat.
attr(commit(edit(Old),O,T),order,1000) :- request(edit(Old),O,T),_clinguin_atom(request(edit(Old),O,T)),not rejection(edit(Old),O,T,_,_),not _clinguin_unsat.
when(commit(edit(Old),O,T),load,context,(undo_operation,(remove_atom(object(O,T)),add_atom(object(O,Old))))) :- request(edit(Old),O,T),_clinguin_atom(request(edit(Old),O,T)),not rejection(edit(Old),O,T,_,_),not _clinguin_unsat.
when(commit(edit(Old),O,T),load,context,(dialog,none)) :- request(edit(Old),O,T),_clinguin_atom(request(edit(Old),O,T)),not rejection(edit(Old),O,T,_,_),not _clinguin_unsat.
when(commit(edit(Old),O,T),load,context,(K,V)) :- request(edit(Old),O,T),_clinguin_atom(request(edit(Old),O,T)),not rejection(edit(Old),O,T,_,_),not _clinguin_unsat,when(w,load,context,(K,V)),K!=undo_operation,K!=dialog.

% Commit Apply Container
elem(commit_apply(M,O,T),container,commit(M,O,T)) :- elem(commit(M,O,T),container,w).
when(commit_apply(create,O,T),load,call,(remove_atom(request(create,O,T)),add_atom(object(O,T)))) :- request(create,O,T),_clinguin_atom(request(create,O,T)),not rejection(create,O,T,_,_),not _clinguin_unsat.
when(commit_apply(edit(Old),O,T),load,call,(remove_atom(request(edit(Old),O,T)),remove_atom(object(O,Old)),add_atom(object(O,T)))) :- request(edit(Old),O,T),_clinguin_atom(request(edit(Old),O,T)),not rejection(edit(Old),O,T,_,_),not _clinguin_unsat.

% Local Feedback
elem(local_feedback,message,w).
attr(local_feedback,visibility,hidden) :- not _clinguin_context(notice_message,_),not _clinguin_context(last_grid_action,()).
attr(local_feedback,visibility,hidden) :- _clinguin_unsat.
attr(local_feedback,visibility,shown) :- _clinguin_context(notice_message,M),M!="",not _clinguin_unsat.
attr(local_feedback,visibility,hidden) :- _clinguin_context(notice_message,""),not _clinguin_context(last_grid_action,remove_atom(_)),not _clinguin_context(last_grid_action,()).
attr(local_feedback,visibility,shown) :- _clinguin_context(last_grid_action,remove_atom(_)),not _clinguin_unsat.
attr(local_feedback,title,"Feedback") :- not _clinguin_context(notice_title,_).
attr(local_feedback,title,Title) :- _clinguin_context(notice_title,Title).
attr(local_feedback,message,"") :- not _clinguin_context(notice_message,_),not _clinguin_context(last_grid_action,remove_atom(_)),not _clinguin_context(last_grid_action,()).
attr(local_feedback,message,Message) :- _clinguin_context(notice_message,Message),not _clinguin_context(last_grid_action,remove_atom(_)),not _clinguin_context(last_grid_action,()).
attr(local_feedback,message,"Placement removed.") :- _clinguin_context(last_grid_action,remove_atom(_)),not _clinguin_unsat.
attr(local_feedback,type,warning).

% Constraint Error Feedback
elem(feedback_message(unsat),message,w) :- _clinguin_unsat.
attr(feedback_message(unsat),title,"No solution") :- _clinguin_unsat.
attr(feedback_message(unsat),message,"The current facts violate a domain constraint. Use Undo last change or Clear edits to recover.") :- _clinguin_unsat.

% Create Object Feedback
elem(feedback_message(request(create,O,T,F,Message)),message,w) :- request(create,O,T),rejection(create,O,T,F,Message),_clinguin_context(dialog,form(object_create)),not _clinguin_unsat.
attr(feedback_message(request(create,O,T,F,Message)),message,@concat(F," · ",Message)) :- request(create,O,T),rejection(create,O,T,F,Message),_clinguin_context(dialog,form(object_create)),not _clinguin_unsat.

% Edit Object Feedback
elem(feedback_message(request(edit(Old),O,T,F,Message)),message,w) :- request(edit(Old),O,T),rejection(edit(Old),O,T,F,Message),_clinguin_context(dialog,form(object_edit)),not _clinguin_unsat.
attr(feedback_message(request(edit(Old),O,T,F,Message)),message,@concat(F," · ",Message)) :- request(edit(Old),O,T),rejection(edit(Old),O,T,F,Message),_clinguin_context(dialog,form(object_edit)),not _clinguin_unsat.

% Object Error Feedback
elem(feedback_message(object(O,F,Message)),message,w) :- issue(O,error,F,Message),not _clinguin_unsat.
attr(feedback_message(object(O,F,Message)),message,@concat(O," · ",Message)) :- elem(feedback_message(object(O,F,Message)),message,_).

% Operation Toast
elem(operation_toast,container,placement_panel).
attr(operation_toast,order,5).
attr(operation_toast,class,("d-flex";"p-2";"rounded";"bg-light";"border")).

% Operation Status
elem(operation_status,label,operation_toast).
attr(operation_status,order,1).
attr(operation_status,class,("small";"fw-bold";"text-primary")).
attr(operation_status,label,"Ready") :- not _clinguin_context(selected_object,O):object(O,_).
attr(operation_status,label,"Ready to place") :- _clinguin_context(selected_object,O),object(O,_),_clinguin_context(placement_role,R),role(O,R,S,_,Max),not issue(O,error,_,_),not issue(O,warning,property(_),_).
attr(operation_status,label,"Complete object first") :- _clinguin_context(selected_object,O),object(O,_),issue(O,error,_,_).
attr(operation_status,label,"Choose a placement role") :- _clinguin_context(selected_object,O),object(O,_),not issue(O,error,_,_),not issue(O,warning,property(_),_),not _clinguin_context(placement_role,R):role(O,R,_,_,_).
attr(operation_status,label,"Complete object first") :- _clinguin_context(selected_object,O),object(O,_),not issue(O,error,_,_),issue(O,warning,property(_),_).

% Shared Button Attributes
attr(E,class,("rounded-3";"btn-sm")) :- elem(E,button,_).

% Shared Label Attributes
attr(E,class,"m-0") :- elem(E,label,_).

% Shared Error Message Attributes
attr(E,type,error) :- elem(E,message,w),E!=local_feedback.
attr(E,visibility,shown) :- elem(E,message,w),E!=local_feedback.
attr(E,title,"Please correct this entry") :- elem(E,message,w),E!=local_feedback,E!=feedback_message(unsat).

% Shared Undo Events
when(E,click,context,(undo_operation,remove_atom(property(O,K,V)))) :- when(E,click,call,add_atom(property(O,K,V))),E!=undo_button.
when(E,click,context,(undo_operation,add_atom(property(O,K,V)))) :- when(E,click,call,remove_atom(property(O,K,V))),E!=undo_button,not when(E,click,context,(delete_object,_)).
when(E,click,context,(undo_operation,remove_atom(position(N,R,O)))) :- when(E,click,call,add_atom(position(N,R,O))),E!=undo_button.
when(E,click,context,(undo_operation,add_atom(position(N,R,O)))) :- when(E,click,call,remove_atom(position(N,R,O))),E!=undo_button,not when(E,click,context,(delete_object,_)).
when(E,click,context,(undo_operation,remove_atom(image(O,R,I)))) :- when(E,click,call,add_atom(image(O,R,I))),E!=undo_button.
when(E,click,context,(undo_operation,add_atom(image(O,R,I)))) :- when(E,click,call,remove_atom(image(O,R,I))),E!=undo_button,not when(E,click,context,(delete_object,_)).
when(E,click,context,(undo_operation,(remove_atom(property(O2,K2,V2)),add_atom(property(O,K,V))))) :- when(E,click,call,(remove_atom(property(O,K,V)),add_atom(property(O2,K2,V2)))),E!=undo_button.
when(E,click,context,(undo_operation,(remove_atom(position(N2,R2,O2)),add_atom(position(N,R,O))))) :- when(E,click,call,(remove_atom(position(N,R,O)),add_atom(position(N2,R2,O2)))),E!=undo_button.
when(E,click,context,(undo_operation,(remove_atom(image(O2,R2,I2)),add_atom(image(O,R,I))))) :- when(E,click,call,(remove_atom(image(O,R,I)),add_atom(image(O2,R2,I2)))),E!=undo_button.
when(E,right_click,context,(undo_operation,add_atom(position(N,R,O)))) :- when(E,right_click,call,remove_atom(position(N,R,O))).

% Delete Placement Events
when(E,Ev,call,remove_atom(position(N,R,O))) :- when(E,Ev,context,(delete_position,position(N,R,O))),_clinguin_atom(position(N,R,O)),role(O,R,S,_,_),0=#count{Dep,Rd:elem(placement(N,Rd,Dep),container,_),support(Dep,Rd,S),Dep!=O},not _clinguin_unsat.
when(E,Ev,update,(placement(N,R,O),visibility,hidden)) :- when(E,Ev,context,(delete_position,position(N,R,O))),_clinguin_atom(position(N,R,O)),role(O,R,S,_,_),0=#count{Dep,Rd:elem(placement(N,Rd,Dep),container,_),support(Dep,Rd,S),Dep!=O},not _clinguin_unsat,elem(placement(N,R,O),container,_).
when(E,Ev,context,(notice_title,"Deleted")) :- when(E,Ev,context,(delete_position,position(N,R,O))),_clinguin_atom(position(N,R,O)),role(O,R,S,_,_),0=#count{Dep,Rd:elem(placement(N,Rd,Dep),container,_),support(Dep,Rd,S),Dep!=O},not _clinguin_unsat.
when(E,Ev,context,(notice_message,"Placement removed.")) :- when(E,Ev,context,(delete_position,position(N,R,O))),_clinguin_atom(position(N,R,O)),role(O,R,S,_,_),0=#count{Dep,Rd:elem(placement(N,Rd,Dep),container,_),support(Dep,Rd,S),Dep!=O},not _clinguin_unsat.
when(E,Ev,update,(operation_status,label,"Removing…")) :- when(E,Ev,context,(delete_position,position(N,R,O))),_clinguin_atom(position(N,R,O)),role(O,R,S,_,_),0=#count{Dep,Rd:elem(placement(N,Rd,Dep),container,_),support(Dep,Rd,S),Dep!=O},not _clinguin_unsat.

% Delete Placeholder Placement Events
when(E,Ev,call,remove_atom(position(N,R,O))) :- when(E,Ev,context,(delete_position,position(N,R,O))),_clinguin_atom(position(N,R,O)),role(O,R,S,_,_),placeholder(O),not _clinguin_unsat.
when(E,Ev,update,(placement(N,R,O),visibility,hidden)) :- when(E,Ev,context,(delete_position,position(N,R,O))),_clinguin_atom(position(N,R,O)),role(O,R,S,_,_),placeholder(O),not _clinguin_unsat,elem(placement(N,R,O),container,_).
when(E,Ev,context,(notice_title,"Deleted")) :- when(E,Ev,context,(delete_position,position(N,R,O))),_clinguin_atom(position(N,R,O)),role(O,R,S,_,_),placeholder(O),not _clinguin_unsat.
when(E,Ev,context,(notice_message,"Placement removed.")) :- when(E,Ev,context,(delete_position,position(N,R,O))),_clinguin_atom(position(N,R,O)),role(O,R,S,_,_),placeholder(O),not _clinguin_unsat.
when(E,Ev,update,(operation_status,label,"Removing…")) :- when(E,Ev,context,(delete_position,position(N,R,O))),_clinguin_atom(position(N,R,O)),role(O,R,S,_,_),placeholder(O),not _clinguin_unsat.

% Blocked Placement Deletion Events
when(E,Ev,update,(local_feedback,visibility,shown)) :- when(E,Ev,context,(delete_position,position(N,R,O))),_clinguin_atom(position(N,R,O)),role(O,R,S,_,_),0<#count{Dep,Rd:elem(placement(N,Rd,Dep),container,_),support(Dep,Rd,S),Dep!=O},not placeholder(O),not _clinguin_unsat.
when(E,Ev,update,(local_feedback,title,"Deletion blocked")) :- when(E,Ev,context,(delete_position,position(N,R,O))),_clinguin_atom(position(N,R,O)),role(O,R,S,_,_),0<#count{Dep,Rd:elem(placement(N,Rd,Dep),container,_),support(Dep,Rd,S),Dep!=O},not placeholder(O),not _clinguin_unsat.
when(E,Ev,update,(local_feedback,message,"This object supports another placement. Remove the dependent placement first.")) :- when(E,Ev,context,(delete_position,position(N,R,O))),_clinguin_atom(position(N,R,O)),role(O,R,S,_,_),0<#count{Dep,Rd:elem(placement(N,Rd,Dep),container,_),support(Dep,Rd,S),Dep!=O},not placeholder(O),not _clinguin_unsat.

% Preserve Selection After Placement Deletion
when(E,Ev,context,(selected_object,_context_value(selected_object,const,none))) :- when(E,Ev,call,remove_atom(position(N,R,O))),not when(E,Ev,context,(delete_object,_)).
when(E,Ev,context,(placement_role,_context_value(placement_role,const,none))) :- when(E,Ev,call,remove_atom(position(N,R,O))),not when(E,Ev,context,(delete_object,_)).

% Delete Object Events
when(E,Ev,call,remove_atom(object(O,T))) :- when(E,Ev,context,(delete_object,O)),object(O,T),_clinguin_atom(object(O,T)),0=#count{N,R,Dep,Rd:position(N,R,O),role(O,R,S,_,_),elem(placement(N,Rd,Dep),container,_),support(Dep,Rd,S),Dep!=O,not placeholder(O)},not _clinguin_unsat.
when(E,Ev,update,(object_card(O,T),visibility,hidden)) :- when(E,Ev,context,(delete_object,O)),object(O,T),_clinguin_atom(object(O,T)),0=#count{N,R,Dep,Rd:position(N,R,O),role(O,R,S,_,_),elem(placement(N,Rd,Dep),container,_),support(Dep,Rd,S),Dep!=O,not placeholder(O)},not _clinguin_unsat.
when(E,Ev,call,remove_atom(property(O,K,V))) :- when(E,Ev,context,(delete_object,O)),object(O,T),_clinguin_atom(object(O,T)),0=#count{N,R,Dep,Rd:position(N,R,O),role(O,R,S,_,_),elem(placement(N,Rd,Dep),container,_),support(Dep,Rd,S),Dep!=O,not placeholder(O)},not _clinguin_unsat,_clinguin_atom(property(O,K,V)).
when(E,Ev,call,remove_atom(position(N,R,O))) :- when(E,Ev,context,(delete_object,O)),object(O,T),_clinguin_atom(object(O,T)),0=#count{N,R,Dep,Rd:position(N,R,O),role(O,R,S,_,_),elem(placement(N,Rd,Dep),container,_),support(Dep,Rd,S),Dep!=O,not placeholder(O)},not _clinguin_unsat,_clinguin_atom(position(N,R,O)).
when(E,Ev,call,remove_atom(image(O,R,I))) :- when(E,Ev,context,(delete_object,O)),object(O,T),_clinguin_atom(object(O,T)),0=#count{N,R,Dep,Rd:position(N,R,O),role(O,R,S,_,_),elem(placement(N,Rd,Dep),container,_),support(Dep,Rd,S),Dep!=O,not placeholder(O)},not _clinguin_unsat,_clinguin_atom(image(O,R,I)).
when(E,Ev,context,(undo_operation,none)) :- when(E,Ev,context,(delete_object,O)),object(O,T),_clinguin_atom(object(O,T)),0=#count{N,R,Dep,Rd:position(N,R,O),role(O,R,S,_,_),elem(placement(N,Rd,Dep),container,_),support(Dep,Rd,S),Dep!=O,not placeholder(O)},not _clinguin_unsat.
when(E,Ev,context,(dialog,none)) :- when(E,Ev,context,(delete_object,O)),object(O,T),_clinguin_atom(object(O,T)),0=#count{N,R,Dep,Rd:position(N,R,O),role(O,R,S,_,_),elem(placement(N,Rd,Dep),container,_),support(Dep,Rd,S),Dep!=O,not placeholder(O)},not _clinguin_unsat.
when(E,Ev,context,(notice_title,"Deleted")) :- when(E,Ev,context,(delete_object,O)),object(O,T),_clinguin_atom(object(O,T)),0=#count{N,R,Dep,Rd:position(N,R,O),role(O,R,S,_,_),elem(placement(N,Rd,Dep),container,_),support(Dep,Rd,S),Dep!=O,not placeholder(O)},not _clinguin_unsat.
when(E,Ev,context,(notice_message,"Object removed.")) :- when(E,Ev,context,(delete_object,O)),object(O,T),_clinguin_atom(object(O,T)),0=#count{N,R,Dep,Rd:position(N,R,O),role(O,R,S,_,_),elem(placement(N,Rd,Dep),container,_),support(Dep,Rd,S),Dep!=O,not placeholder(O)},not _clinguin_unsat.

% Blocked Object Deletion Events
when(E,Ev,update,(local_feedback,visibility,shown)) :- when(E,Ev,context,(delete_object,O)),object(O,T),_clinguin_atom(object(O,T)),0<#count{N,R,Dep,Rd:position(N,R,O),role(O,R,S,_,_),elem(placement(N,Rd,Dep),container,_),support(Dep,Rd,S),Dep!=O,not placeholder(O)},not _clinguin_unsat.
when(E,Ev,update,(local_feedback,title,"Deletion blocked")) :- when(E,Ev,context,(delete_object,O)),object(O,T),_clinguin_atom(object(O,T)),0<#count{N,R,Dep,Rd:position(N,R,O),role(O,R,S,_,_),elem(placement(N,Rd,Dep),container,_),support(Dep,Rd,S),Dep!=O,not placeholder(O)},not _clinguin_unsat.
when(E,Ev,update,(local_feedback,message,"This object supports another placement. Remove the dependent placement first.")) :- when(E,Ev,context,(delete_object,O)),object(O,T),_clinguin_atom(object(O,T)),0<#count{N,R,Dep,Rd:position(N,R,O),role(O,R,S,_,_),elem(placement(N,Rd,Dep),container,_),support(Dep,Rd,S),Dep!=O,not placeholder(O)},not _clinguin_unsat.

% Placement Deletion Events During Constraint Errors
when(E,Ev,update,(local_feedback,visibility,shown)) :- when(E,Ev,context,(delete_position,_)),_clinguin_unsat.
when(E,Ev,update,(local_feedback,title,"Resolve the constraint error")) :- when(E,Ev,context,(delete_position,_)),_clinguin_unsat.
when(E,Ev,update,(local_feedback,message,"Use Undo last change before deleting another placement or object.")) :- when(E,Ev,context,(delete_position,_)),_clinguin_unsat.

% Object Deletion Events During Constraint Errors
when(E,Ev,update,(local_feedback,visibility,shown)) :- when(E,Ev,context,(delete_object,_)),_clinguin_unsat.
when(E,Ev,update,(local_feedback,title,"Resolve the constraint error")) :- when(E,Ev,context,(delete_object,_)),_clinguin_unsat.
when(E,Ev,update,(local_feedback,message,"Use Undo last change before deleting another placement or object.")) :- when(E,Ev,context,(delete_object,_)),_clinguin_unsat.