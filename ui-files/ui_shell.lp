% ============================================================
% ui_shell.lp 
% ============================================================

% Window
elem(w,window,root).
attr(w,child_layout,flex).
attr(w,class,("d-flex";"flex-column";"text-dark";"bg-light";"min-vh-100")).

% Menu Bar 
elem(menu_bar,menu_bar,w).
attr(menu_bar,order,0).
attr(menu_bar,title,"Generic UI").
attr(menu_bar,icon,"fa-table-cells").

% Add new Object

elem(add_new_object,button,menu_bar).
attr(add_new_object,order,1).
attr(add_new_object,label,"New object").
attr(add_new_object,icon,"fa-plus").
attr(add_new_object,class,("btn-primary";"px-3")).
when(add_new_object,click,context,(dialog,form(add_object))).
when(add_new_object,click,update,(dialog(form(add_object)),visibility,shown)).

% Next Solution

elem(next_solution_button,button,menu_bar).
attr(next_solution_button,order,2).
attr(next_solution_button,label,"Next solution").
attr(next_solution_button,icon,"fa-forward-step").
attr(next_solution_button,class,("btn-outline-primary";"px-3")).
when(next_solution_button,click,call,next_solution(optN)).

% Clear Edit

elem(clear_edits_button,button,menu_bar).
attr(clear_edits_button,order,3).
attr(clear_edits_button,label,@concat("Clear edits ")).
attr(clear_edits_button,icon,"fa-eraser").
attr(clear_edits_button,class,("btn-outline-primary";"px-3")).
when(clear_edits_button,click,update,(dialog(clear),visibility,shown)).

% Restart
elem(restart_button,button,menu_bar).
attr(restart_button,order,4).
attr(restart_button,label,"Restart").
attr(restart_button,icon,"fa-arrows-rotate").
attr(restart_button,class,("btn-outline-primary";"px-3")).
when(restart_button,click,update,(dialog(restart),visibility,shown)).

% Help
elem(help_button,button,menu_bar).
attr(help_button,order,5).
attr(help_button,label,"Help").
attr(help_button,icon,"fa-circle-question").
attr(help_button,class,("btn-outline-primary";"px-3")).
when(help_button,click,update,(dialog(help),visibility,shown)).

% %Undo Button

% elem(undo_button,button,menu_bar) .
% attr(undo_button,order,6) :- elem(undo_button,button,menu_bar).
% attr(undo_button,label,"Undo last change") :- elem(undo_button,button,menu_bar).
% attr(undo_button,class,"btn-outline-primary") :- elem(undo_button,button,menu_bar).


% ============================================================
% ACTIVE DOMAIN 
% ============================================================

elem(active_domain_container,container,w) :- active_domain(_).
attr(active_domain_container,order,1) :- active_domain(_).
attr(active_domain_container,flex_direction,row) :- active_domain(_).
attr(active_domain_container,class,("d-flex";"flex-row";"align-items-center";"px-2";"pt-2";"pb-0";"w-100")) :- active_domain(_).
attr(active_domain_container,"box-sizing","border-box") :- active_domain(_).




% ============================================================
% NO ACTIVE DOMAIN
% ============================================================

elem(no_active_domain_bar,container,w) :- no_active_domain.
attr(no_active_domain_bar,order,1) :- no_active_domain.
attr(no_active_domain_bar,flex_direction,row) :- no_active_domain.
attr(no_active_domain_bar,class,("d-flex";"flex-row";"flex-wrap";"align-items-center";"justify-content-between";"gap-2";"mx-2";"mt-2";"px-3";"py-2";"rounded-3")) :- no_active_domain.
attr(no_active_domain_bar,background_color,"#F8FAFC") :- no_active_domain.
attr(no_active_domain_bar,"border","1px solid #DDE6F0") :- no_active_domain.
attr(no_active_domain_bar,"border-left","4px solid #F59E0B") :- no_active_domain.
attr(no_active_domain_bar,"box-shadow","0 2px 8px rgba(15,23,42,0.05)") :- no_active_domain.
attr(no_active_domain_bar,"min-height","48px") :- no_active_domain.
attr(no_active_domain_bar,"box-sizing","border-box") :- no_active_domain.


% ============================================================
% NO DOMAIN INFORMATION
% ============================================================

elem(no_active_domain_info,container,no_active_domain_bar) :- no_active_domain.
attr(no_active_domain_info,order,1) :- no_active_domain.
attr(no_active_domain_info,flex_direction,row) :- no_active_domain.
attr(no_active_domain_info,class,("d-flex";"flex-row";"align-items-center";"gap-2";"flex-shrink-0")) :- no_active_domain.



elem(no_active_domain_text,container,no_active_domain_info) :- no_active_domain.
attr(no_active_domain_text,order,2) :- no_active_domain.
attr(no_active_domain_text,flex_direction,column) :- no_active_domain.
attr(no_active_domain_text,class,("d-flex";"flex-column";"gap-0")) :- no_active_domain.

elem(no_active_domain_title,label,no_active_domain_text) :- no_active_domain.
attr(no_active_domain_title,order,1) :- no_active_domain.
attr(no_active_domain_title,label,"No domain configured") :- no_active_domain.
attr(no_active_domain_title,class,("fw-bold";"text-dark";"m-0";"text-nowrap")) :- no_active_domain.
attr(no_active_domain_title,"font-size","11px") :- no_active_domain.

elem(no_active_domain_hint,label,no_active_domain_text) :- no_active_domain.
attr(no_active_domain_hint,order,2) :- no_active_domain.
attr(no_active_domain_hint,label,"Enter a domain identifier to start.") :- no_active_domain.
attr(no_active_domain_hint,class,("text-secondary";"m-0";"text-nowrap")) :- no_active_domain.
attr(no_active_domain_hint,"font-size","9px") :- no_active_domain.


% ============================================================
% CREATE DOMAIN FORM
% ============================================================

elem(create_domain_form,container,no_active_domain_bar) :- no_active_domain.
attr(create_domain_form,order,2) :- no_active_domain.
attr(create_domain_form,flex_direction,row) :- no_active_domain.
attr(create_domain_form,class,("d-flex";"flex-row";"align-items-center";"gap-2";"flex-grow-1";"justify-content-end")) :- no_active_domain.
attr(create_domain_form,"min-width","240px") :- no_active_domain.

elem(input(domain,new_domain_name),textfield,create_domain_form) :- no_active_domain.
attr(input(domain,new_domain_name),order,1) :- no_active_domain.
attr(input(domain,new_domain_name),placeholder,"e.g. flatland") :- no_active_domain.
attr(input(domain,new_domain_name),class,("form-control";"bg-white";"text-dark";"rounded-3";"px-3";"py-1";"flex-grow-1")) :- no_active_domain.
attr(input(domain,new_domain_name),"border","1px solid #CBD5E1") :- no_active_domain.
attr(input(domain,new_domain_name),"box-shadow","0 1px 2px rgba(15,23,42,0.04)") :- no_active_domain.
attr(input(domain,new_domain_name),"font-size","12px") :- no_active_domain.
attr(input(domain,new_domain_name),"min-height","34px") :- no_active_domain.
attr(input(domain,new_domain_name),"min-width","180px") :- no_active_domain.
attr(input(domain,new_domain_name),"max-width","300px") :- no_active_domain.
when(input(domain,new_domain_name),input,context,(new_domain_name,_value)) :- no_active_domain.

elem(create_domain,button,create_domain_form) :- no_active_domain.
attr(create_domain,order,2) :- no_active_domain.
attr(create_domain,label,"Create domain") :- no_active_domain.
attr(create_domain,icon,"fa-plus") :- no_active_domain.
attr(create_domain,class,("btn-primary";"text-white";"fw-bold";"rounded-3";"px-3";"py-1";"shadow-sm";"text-nowrap")) :- no_active_domain.
attr(create_domain,"font-size","11px") :- no_active_domain.
attr(create_domain,"min-height","34px") :- no_active_domain.
when(create_domain,click,call,add_atom(active_domain(_context_value(new_domain_name)))) :- no_active_domain.


% ============================================================
% ACTIVE DOMAIN CARD
% ============================================================

elem(active_domain_card(D),container,active_domain_container) :- active_domain(D).
attr(active_domain_card(D),order,1) :- active_domain(D).
attr(active_domain_card(D),flex_direction,row) :- active_domain(D).
attr(active_domain_card(D),class,("d-flex";"flex-row";"flex-wrap";"align-items-center";"justify-content-between";"gap-2";"px-3";"py-2";"rounded-3";"w-100")) :- active_domain(D).
attr(active_domain_card(D),background_color,"#F8FAFC") :- active_domain(D).
attr(active_domain_card(D),"border","1px solid #DCE5F0") :- active_domain(D).
attr(active_domain_card(D),"border-left","4px solid #2563EB") :- active_domain(D).
attr(active_domain_card(D),"box-shadow","0 2px 8px rgba(15,23,42,0.06)") :- active_domain(D).
attr(active_domain_card(D),"min-height","44px") :- active_domain(D).
attr(active_domain_card(D),"min-width","0") :- active_domain(D).
attr(active_domain_card(D),"box-sizing","border-box") :- active_domain(D).


% ============================================================
% LEFT SIDE
% ============================================================

elem(active_domain_left(D),container,active_domain_card(D)) :- active_domain(D).
attr(active_domain_left(D),order,1) :- active_domain(D).
attr(active_domain_left(D),flex_direction,row) :- active_domain(D).
attr(active_domain_left(D),class,("d-flex";"flex-row";"align-items-center";"gap-2";"flex-grow-1")) :- active_domain(D).
attr(active_domain_left(D),"min-width","0") :- active_domain(D).


% ============================================================
% DOMAIN ICON
% ============================================================

elem(active_domain_icon_box(D),container,active_domain_left(D)) :- active_domain(D).
attr(active_domain_icon_box(D),order,1) :- active_domain(D).
attr(active_domain_icon_box(D),flex_direction,row) :- active_domain(D).
attr(active_domain_icon_box(D),class,("d-flex";"align-items-center";"justify-content-center";"rounded-3";"flex-shrink-0")) :- active_domain(D).
attr(active_domain_icon_box(D),width,30) :- active_domain(D).
attr(active_domain_icon_box(D),height,30) :- active_domain(D).
attr(active_domain_icon_box(D),background_color,"#E8F0FE") :- active_domain(D).
attr(active_domain_icon_box(D),"border","1px solid #C7D7FE") :- active_domain(D).

elem(active_domain_icon(D),icon,active_domain_icon_box(D)) :- active_domain(D).
attr(active_domain_icon(D),order,1) :- active_domain(D).
attr(active_domain_icon(D),icon,"fa-layer-group") :- active_domain(D).
attr(active_domain_icon(D),class,("text-primary";"m-0")) :- active_domain(D).
attr(active_domain_icon(D),"font-size","12px") :- active_domain(D).


% ============================================================
% DOMAIN INFORMATION
% ============================================================

elem(active_domain_text(D),container,active_domain_left(D)) :- active_domain(D).
attr(active_domain_text(D),order,2) :- active_domain(D).
attr(active_domain_text(D),flex_direction,column) :- active_domain(D).
attr(active_domain_text(D),class,("d-flex";"flex-column";"gap-0";"flex-grow-1")) :- active_domain(D).
attr(active_domain_text(D),"min-width","0") :- active_domain(D).

elem(active_domain_label(D),label,active_domain_text(D)) :- active_domain(D).
attr(active_domain_label(D),order,1) :- active_domain(D).
attr(active_domain_label(D),label,"ACTIVE DOMAIN") :- active_domain(D).
attr(active_domain_label(D),class,("fw-bold";"text-primary";"m-0")) :- active_domain(D).
attr(active_domain_label(D),"font-size","8px") :- active_domain(D).
attr(active_domain_label(D),"letter-spacing","0.09em") :- active_domain(D).

elem(active_domain_name(D),label,active_domain_text(D)) :- active_domain(D).
attr(active_domain_name(D),order,2) :- active_domain(D).
attr(active_domain_name(D),label,@concat("",D)) :- active_domain(D).
attr(active_domain_name(D),class,("fw-bold";"text-dark";"text-break";"m-0")) :- active_domain(D).
attr(active_domain_name(D),"font-size","13px") :- active_domain(D).
attr(active_domain_name(D),"line-height","1.2") :- active_domain(D).
attr(active_domain_name(D),"overflow-wrap","anywhere") :- active_domain(D).


% ============================================================
% RIGHT SIDE
% ============================================================

elem(active_domain_right(D),container,active_domain_card(D)) :- active_domain(D).
attr(active_domain_right(D),order,2) :- active_domain(D).
attr(active_domain_right(D),flex_direction,row) :- active_domain(D).
attr(active_domain_right(D),class,("d-flex";"flex-row";"flex-wrap";"align-items-center";"justify-content-end";"gap-1";"flex-shrink-0")) :- active_domain(D).


% ============================================================
% ACTIVE STATUS
% ============================================================

elem(active_domain_status(D),container,active_domain_right(D)) :- active_domain(D).
attr(active_domain_status(D),order,1) :- active_domain(D).
attr(active_domain_status(D),flex_direction,row) :- active_domain(D).
attr(active_domain_status(D),class,("d-flex";"flex-row";"align-items-center";"gap-1";"rounded-pill";"px-2";"py-1";"flex-shrink-0")) :- active_domain(D).
attr(active_domain_status(D),background_color,"#ECFDF5") :- active_domain(D).
attr(active_domain_status(D),"border","1px solid #A7F3D0") :- active_domain(D).

elem(active_domain_status_label(D),label,active_domain_status(D)) :- active_domain(D).
attr(active_domain_status_label(D),order,2) :- active_domain(D).
attr(active_domain_status_label(D),label,"Active") :- active_domain(D).
attr(active_domain_status_label(D),class,("fw-bold";"text-success";"text-nowrap";"m-0")) :- active_domain(D).
attr(active_domain_status_label(D),"font-size","8px") :- active_domain(D).


% ============================================================
% USER-ADDED / READ-ONLY BADGES
% ============================================================

elem(active_domain_user_badge(D),label,active_domain_right(D)) :- editable_domain(D).
attr(active_domain_user_badge(D),order,2) :- editable_domain(D).
attr(active_domain_user_badge(D),label,"User added") :- editable_domain(D).
attr(active_domain_user_badge(D),class,("rounded-pill";"px-2";"py-1";"fw-bold";"text-primary";"bg-white";"border";"m-0";"text-nowrap")) :- editable_domain(D).
attr(active_domain_user_badge(D),"font-size","8px") :- editable_domain(D).

elem(active_domain_readonly_badge(D),label,active_domain_right(D)) :- readonly_domain(D).
attr(active_domain_readonly_badge(D),order,2) :- readonly_domain(D).
attr(active_domain_readonly_badge(D),label,"Declared in a domain file") :- readonly_domain(D).
attr(active_domain_readonly_badge(D),class,("rounded-pill";"px-2";"py-1";"fw-bold";"text-secondary";"bg-white";"border";"m-0";"text-nowrap")) :- readonly_domain(D).
attr(active_domain_readonly_badge(D),"font-size","8px") :- readonly_domain(D).

% ============================================================
% EDIT BUTTON
% ============================================================


elem(domain_edit(D),button,active_domain_right(D)) :- editable_domain(D).
attr(domain_edit(D),order,3) :- editable_domain(D).
attr(domain_edit(D),label,"Edit") :- editable_domain(D).
attr(domain_edit(D),icon,"fa-pen") :- editable_domain(D).
attr(domain_edit(D),class,("btn-outline-primary";"btn-sm";"fw-bold";"rounded-2";"px-2";"py-1";"text-nowrap")) :- editable_domain(D).
attr(domain_edit(D),"font-size","8px") :- editable_domain(D).
when(domain_edit(D),click,context,(edit_domain_name(D),D)) :- editable_domain(D).
when(domain_edit(D),click,update,(dialog(form(edit_domain(D))),visibility,shown)) :- editable_domain(D).


% ============================================================
% REMOVE BUTTON
% ============================================================

elem(domain_remove(D),button,active_domain_right(D)) :- editable_domain(D).
attr(domain_remove(D),order,4) :- editable_domain(D).
attr(domain_remove(D),label,"Remove") :- editable_domain(D).
attr(domain_remove(D),icon,"fa-trash") :- editable_domain(D).
attr(domain_remove(D),class,("btn-outline-danger";"btn-sm";"fw-bold";"rounded-2";"px-2";"py-1";"text-nowrap")) :- editable_domain(D).
attr(domain_remove(D),"font-size","8px") :- editable_domain(D).
when(domain_remove(D),click,update,(dialog(form(remove_domain(D))),visibility,shown)) :- editable_domain(D).



% Shared modal appearance 
attr(dialog(D),size,"lg") :- elem(dialog(D),modal,w).
elem(dialog_sheet(D),container,dialog(D)) :- elem(dialog(D),modal,w).
attr(dialog_sheet(D),order,1) :- elem(dialog(D),modal,w).
attr(dialog_sheet(D),class,("d-flex";"flex-column";"gap-2";"p-0";"m-0")) :- elem(dialog(D),modal,w).

elem(dialog_close(D),button,dialog_sheet(D)) :- elem(dialog(D),modal,w).
attr(dialog_close(D),order,1000) :- elem(dialog(D),modal,w).
attr(dialog_close(D),label,"Close ×") :- elem(dialog(D),modal,w).
attr(dialog_close(D),class,("btn-outline-primary";"align-self-end")) :- elem(dialog(D),modal,w).
when(dialog_close(D),click,update,(dialog(D),visibility,hidden)) :- elem(dialog(D),modal,w).
when(dialog_close(D),click,context,(dialog,none)) :- elem(dialog(D),modal,w).
attr(dialog_text(D),order,1) :- elem(dialog_text(D),label,_).
attr(form_body(F),order,1) :- elem(form_body(F),container,_).




% Clear modal.
elem(dialog(clear),modal,w).
attr(dialog(clear),visibility,hidden).
attr(dialog(clear),title,"Clear session edits?").

elem(dialog_text(clear),label,dialog_sheet(clear)).
attr(dialog_text(clear),label,"Remove session-added facts? Source files will remain available.").
attr(dialog_text(clear),class,("p-2";"text-secondary")).

elem(confirm_clear,button,dialog_sheet(clear)).
attr(confirm_clear,order,2).
attr(confirm_clear,label,"Confirm").
attr(confirm_clear,class,("btn-danger";"m-3";"align-self-end")).


%Restart modal.
elem(dialog(restart),modal,w).
attr(dialog(restart),visibility,hidden).
attr(dialog(restart),title,"Restart the session?").

elem(dialog_text(restart),label,dialog_sheet(restart)).
attr(dialog_text(restart),label,"Restore the original backend state and clear session edits.").
attr(dialog_text(restart),class,("p-3";"text-secondary")).

elem(confirm_restart,button,dialog_sheet(restart)).
attr(confirm_restart,order,2).
attr(confirm_restart,label,"Confirm").
attr(confirm_restart,class,("btn-danger";"m-3";"align-self-end")).


% Help modal
elem(dialog(help),modal,w).
attr(dialog(help),visibility,hidden).
attr(dialog(help),title,"Generic UI").
elem(dialog_text(help),label,dialog_sheet(help)).
attr(dialog_text(help),label,"The catalogue lists the available objects. Use Add object to create an object and Add node to add a grid node. Grid cells are display-only: selection, roles, placement and inspection are not enabled.").
attr(dialog_text(help),class,("p-3";"text-secondary")).




% ============================================================
% EDIT DOMAIN MODAL
% ============================================================

% ============================================================

elem(dialog(form(edit_domain(D))),modal,w) :- editable_domain(D).
attr(dialog(form(edit_domain(D))),title,"Edit domain") :- editable_domain(D).
attr(dialog(form(edit_domain(D))),size,"m") :- editable_domain(D).
attr(dialog(form(edit_domain(D))),visibility,hidden) :- editable_domain(D).
attr(dialog_close(form(edit_domain(D))),visibility,hidden) :- editable_domain(D),elem(dialog_close(form(edit_domain(D))),button,_).
attr(dialog_close(form(edit_domain(D))),class,"d-none") :- editable_domain(D),elem(dialog_close(form(edit_domain(D))),button,_).


% ============================================================
% EDIT DOMAIN BODY
% ============================================================

elem(edit_domain_body(D),container,dialog_sheet(form(edit_domain(D)))) :- editable_domain(D).
attr(edit_domain_body(D),order,1) :- editable_domain(D).
attr(edit_domain_body(D),flex_direction,column) :- editable_domain(D).
attr(edit_domain_body(D),class,("d-flex";"flex-column";"gap-3";"p-3";"bg-white";"w-100")) :- editable_domain(D).


% ============================================================
% EDIT INTRO
% ============================================================

elem(edit_domain_intro(D),container,edit_domain_body(D)) :- editable_domain(D).
attr(edit_domain_intro(D),order,1) :- editable_domain(D).
attr(edit_domain_intro(D),flex_direction,row) :- editable_domain(D).
attr(edit_domain_intro(D),class,("d-flex";"flex-row";"align-items-center";"gap-3";"p-3";"rounded-3")) :- editable_domain(D).
attr(edit_domain_intro(D),background_color,"#EFF6FF") :- editable_domain(D).
attr(edit_domain_intro(D),"border","1px solid #BFDBFE") :- editable_domain(D).

elem(edit_domain_intro_icon(D),icon,edit_domain_intro(D)) :- editable_domain(D).
attr(edit_domain_intro_icon(D),order,1) :- editable_domain(D).
attr(edit_domain_intro_icon(D),icon,"fa-pen") :- editable_domain(D).
attr(edit_domain_intro_icon(D),class,"text-primary") :- editable_domain(D).

elem(edit_domain_intro_text(D),container,edit_domain_intro(D)) :- editable_domain(D).
attr(edit_domain_intro_text(D),order,2) :- editable_domain(D).
attr(edit_domain_intro_text(D),flex_direction,column) :- editable_domain(D).
attr(edit_domain_intro_text(D),class,("d-flex";"flex-column";"gap-0")) :- editable_domain(D).

elem(edit_domain_intro_title(D),label,edit_domain_intro_text(D)) :- editable_domain(D).
attr(edit_domain_intro_title(D),order,1) :- editable_domain(D).
attr(edit_domain_intro_title(D),label,"Rename domain") :- editable_domain(D).
attr(edit_domain_intro_title(D),class,("fw-bold";"text-dark";"m-0")) :- editable_domain(D).
attr(edit_domain_intro_title(D),"font-size","12px") :- editable_domain(D).

elem(edit_domain_intro_current(D),label,edit_domain_intro_text(D)) :- editable_domain(D).
attr(edit_domain_intro_current(D),order,2) :- editable_domain(D).
attr(edit_domain_intro_current(D),label,@concat("Current identifier: ",D)) :- editable_domain(D).
attr(edit_domain_intro_current(D),class,("text-secondary";"m-0")) :- editable_domain(D).
attr(edit_domain_intro_current(D),"font-size","9px") :- editable_domain(D).


% ============================================================
% EDIT DOMAIN FIELD
% ============================================================

elem(edit_domain_field(D),container,edit_domain_body(D)) :- editable_domain(D).
attr(edit_domain_field(D),order,2) :- editable_domain(D).
attr(edit_domain_field(D),flex_direction,column) :- editable_domain(D).
attr(edit_domain_field(D),class,("d-flex";"flex-column";"gap-2";"w-100")) :- editable_domain(D).

elem(edit_domain_label(D),label,edit_domain_field(D)) :- editable_domain(D).
attr(edit_domain_label(D),order,1) :- editable_domain(D).
attr(edit_domain_label(D),label,"New domain identifier") :- editable_domain(D).
attr(edit_domain_label(D),class,("fw-bold";"text-dark";"m-0")) :- editable_domain(D).
attr(edit_domain_label(D),"font-size","11px") :- editable_domain(D).

elem(input(edit_domain(D),edit_domain_name(D)),textfield,edit_domain_field(D)) :- editable_domain(D).
attr(input(edit_domain(D),edit_domain_name(D)),order,2) :- editable_domain(D).
attr(input(edit_domain(D),edit_domain_name(D)),placeholder,@concat("Current: ",D)) :- editable_domain(D).
attr(input(edit_domain(D),edit_domain_name(D)),class,("form-control";"rounded-3";"bg-white";"text-dark";"px-3";"py-2";"w-100")) :- editable_domain(D).
attr(input(edit_domain(D),edit_domain_name(D)),"border","1px solid #CBD5E1") :- editable_domain(D).
attr(input(edit_domain(D),edit_domain_name(D)),"font-size","12px") :- editable_domain(D).
when(input(edit_domain(D),edit_domain_name(D)),input,context,(edit_domain_name(D),_value)) :- editable_domain(D).


% ============================================================
% EDIT ACTIONS
% ============================================================

elem(edit_domain_actions(D),container,edit_domain_body(D)) :- editable_domain(D).
attr(edit_domain_actions(D),order,3) :- editable_domain(D).
attr(edit_domain_actions(D),flex_direction,row) :- editable_domain(D).
attr(edit_domain_actions(D),class,("d-flex";"flex-row";"justify-content-end";"gap-2";"border-top";"pt-3")) :- editable_domain(D).

elem(cancel(edit_domain(D)),button,edit_domain_actions(D)) :- editable_domain(D).
attr(cancel(edit_domain(D)),order,1) :- editable_domain(D).
attr(cancel(edit_domain(D)),label,"Cancel") :- editable_domain(D).
attr(cancel(edit_domain(D)),class,("btn-light";"border";"text-dark";"rounded-3";"px-3";"py-2")) :- editable_domain(D).
attr(cancel(edit_domain(D)),"font-size","11px") :- editable_domain(D).
when(cancel(edit_domain(D)),click,update,(dialog(form(edit_domain(D))),visibility,hidden)) :- editable_domain(D).

elem(save(edit_domain(D)),button,edit_domain_actions(D)) :- editable_domain(D).
attr(save(edit_domain(D)),order,2) :- editable_domain(D).
attr(save(edit_domain(D)),label,"Save changes") :- editable_domain(D).
attr(save(edit_domain(D)),icon,"fa-check") :- editable_domain(D).
attr(save(edit_domain(D)),class,("btn-primary";"text-white";"fw-bold";"rounded-3";"px-3";"py-2";"shadow-sm")) :- editable_domain(D).
attr(save(edit_domain(D)),"font-size","11px") :- editable_domain(D).
when(save(edit_domain(D)),click,update,(dialog(form(edit_domain(D))),visibility,hidden)) :- editable_domain(D).
when(save(edit_domain(D)),click,call,(remove_atom(active_domain(D)),add_atom(active_domain(_context_value(edit_domain_name(D)))))) :- editable_domain(D).


% ============================================================
% REMOVE DOMAIN MODAL
% ============================================================

% ============================================================

elem(dialog(form(remove_domain(D))),modal,w) :- editable_domain(D).
attr(dialog(form(remove_domain(D))),title,"Remove domain") :- editable_domain(D).
attr(dialog(form(remove_domain(D))),size,"m") :- editable_domain(D).
attr(dialog(form(remove_domain(D))),visibility,hidden) :- editable_domain(D).
attr(dialog_close(form(remove_domain(D))),visibility,hidden) :- editable_domain(D),elem(dialog_close(form(remove_domain(D))),button,_).
attr(dialog_close(form(remove_domain(D))),class,"d-none") :- editable_domain(D),elem(dialog_close(form(remove_domain(D))),button,_).


% ============================================================
% REMOVE DOMAIN BODY
% ============================================================

elem(remove_domain_body(D),container,dialog_sheet(form(remove_domain(D)))) :- editable_domain(D).
attr(remove_domain_body(D),order,1) :- editable_domain(D).
attr(remove_domain_body(D),flex_direction,column) :- editable_domain(D).
attr(remove_domain_body(D),class,("d-flex";"flex-column";"gap-3";"p-3";"bg-white";"w-100")) :- editable_domain(D).


% ============================================================
% REMOVE WARNING
% ============================================================

elem(remove_domain_warning(D),container,remove_domain_body(D)) :- editable_domain(D).
attr(remove_domain_warning(D),order,1) :- editable_domain(D).
attr(remove_domain_warning(D),flex_direction,row) :- editable_domain(D).
attr(remove_domain_warning(D),class,("d-flex";"flex-row";"align-items-start";"gap-3";"p-3";"rounded-3")) :- editable_domain(D).
attr(remove_domain_warning(D),background_color,"#FEF2F2") :- editable_domain(D).
attr(remove_domain_warning(D),"border","1px solid #FECACA") :- editable_domain(D).

elem(remove_domain_warning_icon(D),icon,remove_domain_warning(D)) :- editable_domain(D).
attr(remove_domain_warning_icon(D),order,1) :- editable_domain(D).
attr(remove_domain_warning_icon(D),icon,"fa-triangle-exclamation") :- editable_domain(D).
attr(remove_domain_warning_icon(D),class,"text-danger") :- editable_domain(D).
attr(remove_domain_warning_icon(D),"font-size","15px") :- editable_domain(D).

elem(remove_domain_warning_content(D),container,remove_domain_warning(D)) :- editable_domain(D).
attr(remove_domain_warning_content(D),order,2) :- editable_domain(D).
attr(remove_domain_warning_content(D),flex_direction,column) :- editable_domain(D).
attr(remove_domain_warning_content(D),class,("d-flex";"flex-column";"gap-1";"flex-grow-1")) :- editable_domain(D).

elem(remove_domain_warning_title(D),label,remove_domain_warning_content(D)) :- editable_domain(D).
attr(remove_domain_warning_title(D),order,1) :- editable_domain(D).
attr(remove_domain_warning_title(D),label,@concat("Remove domain ",D,"?")) :- editable_domain(D).
attr(remove_domain_warning_title(D),class,("fw-bold";"text-danger";"m-0")) :- editable_domain(D).
attr(remove_domain_warning_title(D),"font-size","12px") :- editable_domain(D).

elem(remove_domain_warning_description(D),label,remove_domain_warning_content(D)) :- editable_domain(D).
attr(remove_domain_warning_description(D),order,2) :- editable_domain(D).
attr(remove_domain_warning_description(D),label,"This removes the current active  domain created through the UI") :- editable_domain(D).
attr(remove_domain_warning_description(D),class,("text-secondary";"text-wrap";"m-0")) :- editable_domain(D).
attr(remove_domain_warning_description(D),"font-size","10px") :- editable_domain(D).


% ============================================================
% REMOVE ACTIONS
% ============================================================

elem(remove_domain_actions(D),container,remove_domain_body(D)) :- editable_domain(D).
attr(remove_domain_actions(D),order,2) :- editable_domain(D).
attr(remove_domain_actions(D),flex_direction,row) :- editable_domain(D).
attr(remove_domain_actions(D),class,("d-flex";"flex-row";"justify-content-end";"gap-2";"border-top";"pt-3")) :- editable_domain(D).

elem(cancel(remove_domain(D)),button,remove_domain_actions(D)) :- editable_domain(D).
attr(cancel(remove_domain(D)),order,1) :- editable_domain(D).
attr(cancel(remove_domain(D)),label,"Cancel") :- editable_domain(D).
attr(cancel(remove_domain(D)),class,("btn-light";"border";"text-dark";"rounded-3";"px-3";"py-2")) :- editable_domain(D).
attr(cancel(remove_domain(D)),"font-size","11px") :- editable_domain(D).
when(cancel(remove_domain(D)),click,update,(dialog(form(remove_domain(D))),visibility,hidden)) :- editable_domain(D).

elem(confirm_remove_domain(D),button,remove_domain_actions(D)) :- editable_domain(D).
attr(confirm_remove_domain(D),order,2) :- editable_domain(D).
attr(confirm_remove_domain(D),label,"Remove domain") :- editable_domain(D).
attr(confirm_remove_domain(D),icon,"fa-trash") :- editable_domain(D).
attr(confirm_remove_domain(D),class,("btn-danger";"text-white";"fw-bold";"rounded-3";"px-3";"py-2")) :- editable_domain(D).
attr(confirm_remove_domain(D),"font-size","11px") :- editable_domain(D).
when(confirm_remove_domain(D),click,update,(dialog(form(remove_domain(D))),visibility,hidden)) :- editable_domain(D).
when(confirm_remove_domain(D),click,call,remove_atom(active_domain(D))) :- editable_domain(D).



%  shared styling.
attr(E,class,("rounded-3";"btn-sm")) :- elem(E,button,_).
attr(E,class,"m-0") :- elem(E,label,_).