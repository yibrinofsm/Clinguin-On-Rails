%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%  ui_shell.lp
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

#defined feedback_on/5.

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Generic feedback dispatcher

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

when(E,Event,context,(feedback_kind,Kind)) :-feedback_on(E,Event,Kind,_,_).

when(E,Event,context,(feedback_title,Title)) :-feedback_on(E,Event,_,Title,_).

when(E,Event,context,(feedback_message,Message)) :-feedback_on(E,Event,_,_,Message).

% Immediate local acknowledgement

when(E,Event,update,(operation_pending,visibility,shown)) :-feedback_on(E,Event,_,_,_).
when(E,Event,update,(operation_pending,title,@concat("Working · ",Title))) :-feedback_on(E,Event,_,Title,_).
when(E,Event,update,(operation_pending,message,@concat("",Message))) :-feedback_on(E,Event,_,_,Message).

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Root Window
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

elem(w,window,root).
attr(w,child_layout,flex).
attr(w,flex_direction,column).
attr(w,class,("d-flex";"flex-column";"min-vh-100";"text-dark")).
attr(w,"padding-bottom","74px").
attr(w,"background","radial-gradient(circle at 12% -10%,rgba(99,102,241,.13),transparent 30%),radial-gradient(circle at 88% 0%,rgba(14,165,233,.09),transparent 27%),linear-gradient(180deg,#f8fafc 0%,#eef2f7 100%)").

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Application Menu
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

elem(menu_bar,menu_bar,w).
attr(menu_bar,order,1).
attr(menu_bar,title,"Generic UI").
attr(menu_bar,icon,"fa-cubes").
attr(menu_bar,class,("border-0";"text-white")).
attr(menu_bar,"background","linear-gradient(110deg,#0f172a 0%,#1e293b 58%,#312e81 100%)").
attr(menu_bar,"box-shadow","0 10px 34px rgba(15,23,42,.24)").

% Add Object.
elem(menu_add_object,button,menu_bar).
attr(menu_add_object,order,1).
attr(menu_add_object,label,"Add New object").
attr(menu_add_object,icon,"fa-plus").
attr(menu_add_object,class,("btn-light";"text-primary";"border-0";"fw-bold";"rounded-pill";"px-3")).
when(menu_add_object,click,update,(object_create_modal,visibility,shown)).

% Browse models.
elem(menu_next_solution,button,menu_bar).
attr(menu_next_solution,order,2).
attr(menu_next_solution,label,"Next solution").
attr(menu_next_solution,icon,"fa-forward-step").
attr(menu_next_solution,class,("btn-light";"btn-outline-light";"text-primary";"border-0";"rounded-pill";"px-3")).
when(menu_next_solution,click,call,next_solution(optN)).
feedback_on(menu_next_solution,click,info,"Solution updated","The next available solution has been loaded.").

% Clear Session Edits Button
elem(menu_clear_edits,button,menu_bar).
attr(menu_clear_edits,order,3).
attr(menu_clear_edits,icon,"fa-eraser").
attr(menu_clear_edits,label,@concat("Clear edits (",N,")")) :- interactive_edit_count(N), N > 0.
attr(menu_clear_edits,label,"No edits") :- interactive_edit_count(0).
attr(menu_clear_edits,class,("btn-outline-light";"border-0";"text-primary";"rounded-pill";"px-3")) :- interactive_edit_count(N), N > 0.
attr(menu_clear_edits,class,("btn-outline-light";"border-0";"rounded-pill";"px-3";"disabled";"opacity-50")) :- interactive_edit_count(0).
when(menu_clear_edits,click,update,(clear_edits_modal,visibility,shown)) :- interactive_edit_count(N), N > 0.

% Restart Button
elem(menu_restart,button,menu_bar).
attr(menu_restart,order,4).
attr(menu_restart,label,"Restart").
attr(menu_restart,icon,"fa-arrows-rotate").
attr(menu_restart,class,("btn-outline-light";"border-0";"rounded-pill")).
when(menu_restart,click,update,(restart_modal,visibility,shown)).

% Help.
elem(menu_help,button,menu_bar).
attr(menu_help,order,5).
attr(menu_help,label,"Help").
attr(menu_help,icon,"fa-circle-question").
attr(menu_help,class,("btn-outline-light";"border-0";"rounded-pill")).
when(menu_help,click,update,(help_modal,visibility,shown)).

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Toolbar Animations
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

toolbar_button(menu_add_object;menu_next_solution;menu_clear_edits;menu_restart;menu_help).

attr(B,"transition","transform 140ms ease,box-shadow 140ms ease,filter 140ms ease") :- toolbar_button(B).
when(B,mouseenter,update,(B,"transform","translateY(-2px)")) :- toolbar_button(B).
when(B,mouseenter,update,(B,"box-shadow","0 9px 20px rgba(37,99,235,.18)")) :- toolbar_button(B).
when(B,mouseleave,update,(B,"transform","translateY(0)")) :- toolbar_button(B).
when(B,mouseleave,update,(B,"box-shadow","none")) :- toolbar_button(B).

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Preserve UI context after server calls
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

when(w,load,context,(selected_object,O)) :-_clinguin_context(selected_object,O),object(O,_).

when(w,load,context,(placement_role,Role)) :-_clinguin_context(placement_role,Role).

when(w,load,context,(placement_role,Role)) :- first_role(Role),not _clinguin_context(placement_role,_).

when(w,load,context,(grid_scale,S)) :-
    _clinguin_context(grid_scale,S),
    allowed_grid_scale(S).

when(w,load,context,(grid_scale,S)) :-
    default_grid_scale(S),
    not _clinguin_context(grid_scale,_).

when(w,load,context,(label_mode,M)) :-
    _clinguin_context(label_mode,M),
    allowed_label_mode(M).

when(w,load,context,(label_mode,selected)) :-
    not _clinguin_context(label_mode,_).

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Bottom-of-screen operation feedback
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Hidden by default and shown locally before a server call.
elem(operation_pending,message,w).
attr(operation_pending,title,"Working").
attr(operation_pending,message,"Processing the requested operation…").
attr(operation_pending,type,info).
attr(operation_pending,visibility,hidden).
attr(operation_pending,class,("shadow-lg";"border-0";"rounded-3")).
attr(operation_pending,"box-shadow","0 18px 48px rgba(15,23,42,.22)").

% Final response after the UI state has been recomputed.
elem(operation_message,message,w) :- feedback_view(_,_,_).
attr(operation_message,title,@concat("",Title)) :- feedback_view(_,Title,_).
attr(operation_message,message,@concat("",Message)) :- feedback_view(_,_,Message).
attr(operation_message,type,Type) :- feedback_message_type(Type).
attr(operation_message,class,("shadow-lg";"border-0";"rounded-3")) :- feedback_view(_,_,_).
attr(operation_message,"box-shadow","0 20px 54px rgba(15,23,42,.24)") :- feedback_view(_,_,_).

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Clear edits confirmation
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

elem(clear_edits_modal,modal,w).
attr(clear_edits_modal,title,"Clear session edits").
attr(clear_edits_modal,size,"m").
attr(clear_edits_modal,visibility,hidden).
attr(clear_edits_modal,class,"fade").

elem(clear_edits_content,container,clear_edits_modal).
attr(clear_edits_content,child_layout,flex).
attr(clear_edits_content,flex_direction,column).
attr(clear_edits_content,class,("d-flex";"flex-column";"gap-3";"p-2")).

elem(clear_edits_text,label,clear_edits_content).
attr(clear_edits_text,order,1).
attr(clear_edits_text,label,@concat("Remove all ",N," facts added during this session? Source facts remain available.")) :- interactive_edit_count(N).
attr(clear_edits_text,class,("small";"text-muted";"bg-light";"border";"rounded-3";"p-3")).

elem(clear_edits_actions,container,clear_edits_content).
attr(clear_edits_actions,order,2).
attr(clear_edits_actions,child_layout,flex).
attr(clear_edits_actions,flex_direction,row).
attr(clear_edits_actions,class,("d-flex";"flex-row";"justify-content-end";"gap-2")).

elem(clear_edits_cancel,button,clear_edits_actions).
attr(clear_edits_cancel,order,1).
attr(clear_edits_cancel,label,"Cancel").
attr(clear_edits_cancel,class,"btn-outline-secondary").
when(clear_edits_cancel,click,update,(clear_edits_modal,visibility,hidden)).

elem(clear_edits_confirm,button,clear_edits_actions).
attr(clear_edits_confirm,order,2).
attr(clear_edits_confirm,label,"Clear edits").
attr(clear_edits_confirm,icon,"fa-eraser").
attr(clear_edits_confirm,class,("btn-danger";"fw-bold")).
when(clear_edits_confirm,click,update,(clear_edits_modal,visibility,hidden)).
when(clear_edits_confirm,click,context,(selected_object,none)).
when(clear_edits_confirm,click,call,clear_atoms).
feedback_on(clear_edits_confirm,click,success,"Edits cleared","All session-added facts were removed.").

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Restart confirmation
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

elem(restart_modal,modal,w).
attr(restart_modal,title,"Restart the session").
attr(restart_modal,size,"m").
attr(restart_modal,visibility,hidden).
attr(restart_modal,class,"fade").

elem(restart_content,container,restart_modal).
attr(restart_content,child_layout,flex).
attr(restart_content,flex_direction,column).
attr(restart_content,class,("d-flex";"flex-column";"gap-3";"p-2")).

elem(restart_text,label,restart_content).
attr(restart_text,order,1).
attr(restart_text,label,"Restarting restores the original backend state and ends solution browsing.").
attr(restart_text,class,("small";"text-muted";"bg-light";"border";"rounded-3";"p-3")).

elem(restart_actions,container,restart_content).
attr(restart_actions,order,2).
attr(restart_actions,child_layout,flex).
attr(restart_actions,flex_direction,row).
attr(restart_actions,class,("d-flex";"flex-row";"justify-content-end";"gap-2")).

elem(restart_cancel,button,restart_actions).
attr(restart_cancel,order,1).
attr(restart_cancel,label,"Cancel").
attr(restart_cancel,class,"btn-outline-secondary").
when(restart_cancel,click,update,(restart_modal,visibility,hidden)).

elem(restart_confirm,button,restart_actions).
attr(restart_confirm,order,2).
attr(restart_confirm,label,"Restart").
attr(restart_confirm,icon,"fa-arrows-rotate").
attr(restart_confirm,class,("btn-danger";"fw-bold")).
when(restart_confirm,click,update,(restart_modal,visibility,hidden)).
when(restart_confirm,click,context,(selected_object,none)).
when(restart_confirm,click,call,restart).
feedback_on(restart_confirm,click,info,"Session restarted","The original domain state has been restored.").

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Help modal
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

elem(help_modal,modal,w).
attr(help_modal,title,"Generic UI contract and controls").
attr(help_modal,size,"lg").
attr(help_modal,visibility,hidden).
attr(help_modal,class,"fade").

elem(help_content,container,help_modal).
attr(help_content,child_layout,flex).
attr(help_content,flex_direction,column).
attr(help_content,class,("d-flex";"flex-column";"gap-3";"p-2")).

elem(help_intro,label,help_content).
attr(help_intro,order,1).
attr(help_intro,label,"The interface is driven exclusively by object/2, property/3, position/3 and node/1. image/3 is optional presentation metadata.").
attr(help_intro,class,("small";"text-muted";"bg-light";"border";"rounded-3";"p-3")).

elem(help_contract,label,help_content).
attr(help_contract,order,2).
attr(help_contract,label,"Required: object(Object,Type). property(Object,Key,Value). position((Row,Column),Role,Object). node((Row,Column)).").
attr(help_contract,class,("small";"font-monospace";"text-primary";"border";"rounded-3";"p-3")).

% elem(help_labels,label,help_content).
% attr(help_labels,order,3).
% attr(help_labels,label,"Circular labels support numbers, strings and ASP terms through property(Object,label,Value) or property(Object,(ui,label),Value). The default mode shows only the selected object.").
% attr(help_labels,class,("small";"text-muted")).

% elem(help_controls,label,help_content).
% attr(help_controls,order,4).
% attr(help_controls,label,"Select an object, choose or enter a role, then click a node. One effective object is shown per generic slot; different slots may coexist and layer. Replacements and removals always require confirmation.").
% attr(help_controls,class,("small";"text-muted")).

% elem(help_feedback,label,help_content).
% attr(help_feedback,order,5).
% attr(help_feedback,label,"Every backend operation shows an immediate working popup followed by a bottom completion notification. A red notification means that the resulting state is unsatisfiable.").
% attr(help_feedback,class,("small";"text-muted")).

elem(help_close,button,help_content).
attr(help_close,order,6).
attr(help_close,label,"Got it").
attr(help_close,icon,"fa-check").
attr(help_close,class,("btn-primary";"align-self-end";"fw-bold")).
when(help_close,click,update,(help_modal,visibility,hidden)).

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Generic UNSAT feedback when no operation notification is available
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

elem(unsat_message,message,w) :- _clinguin_unsat, not feedback_raw(_,_,_).
attr(unsat_message,title,"No solution") :- _clinguin_unsat, not feedback_raw(_,_,_).
attr(unsat_message,message,"The current facts make the domain unsatisfiable.") :- _clinguin_unsat, not feedback_raw(_,_,_).
attr(unsat_message,type,error) :- _clinguin_unsat, not feedback_raw(_,_,_).