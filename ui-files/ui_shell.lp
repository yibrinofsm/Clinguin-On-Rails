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
% when(clear_edits_button,click,call,)).

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





%  shared styling.
attr(E,class,("rounded-3";"btn-sm")) :- elem(E,button,_).
attr(E,class,"m-0") :- elem(E,label,_).