% ============================================================
% ui_presentation.lp
% ============================================================
%
% Generic visual presentation of the Clinguin interface.
% Contains the application shell, layout, catalogue,
% inspector, forms, and notifications.
% ============================================================

#include "ui_shell.lp".         % Window, menu, domain banner and shared dialogs
#include "ui_layout.lp".        % Workspace and  grid structure
#include "ui_sidebar.lp".       % Object catalogue, forms and inspector
#include "ui_notification.lp".  % notification component 
#include "ui_logic.lp".  % Contains generic helper atoms derived from the current Clinguin UI
% interaction state.
#include "generic_ui_context_validation.lp".  % Contains validation rules  that depend  on generic domain predicates, 
% user-added atoms, and Clinguin UI context