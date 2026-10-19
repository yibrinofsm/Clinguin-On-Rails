% generic_ui_context_validation.lp

% This file contains validation rules  that depend  on generic domain predicates, 
% user-added atoms, and Clinguin UI context”
% The rules depends on the current user selection, so it is UI-context-dependent. 

% ============================================================
% CURRENT UI SELECTION
% ============================================================

% Derive the object currently opened in the inspector.
object_selected_for_inspection(O,T) :-object(O,T),_clinguin_context(selected_for_inspection,O).

% Derive the object currently selected for grid placement.
object_selected(O,T) :-object(O,T),_clinguin_context(object_selected,O).

object_selected_for_placement(O,T,R):-object(O,T),object_selected(O,T),type_role(T,R),_clinguin_context(selected_role_for_placement,R).


% ============================================================
% ============================================================
% MISSING IMAGE ROLE VALIDATION
% ============================================================
%
% PURPOSE:
% Identify image roles for which the selected object
% does not yet have an assigned image.
%
% CHECKS:
% - Whether object O of type T is selected for inspection.
% - Whether role R is declared for object type T.
% - Whether object O has no image assigned for role R.
%
% RESULTS:
% - object_missing_image_for_role/3:
%     Identifies each missing role image.
%
% - object_missing_image/2:
%     Indicates that the selected object has at least
%     one missing role image.
%
% - has_object_missing_image_for_role/2:
%     Indicates that at least one role image is missing.
%
% NOTE:
% This section depends on object_selected_for_inspection/2.
% If that predicate depends on Clinguin UI context,
% these rules are UI-context-dependent.
%


% Identify each missing image role for the selected object.
object_missing_image_for_role(O,T,R) :-object_selected_for_inspection(O,T), type_role(T,R),not image(O,R,_).

% True if the selected object is missing at least one image.
object_missing_image(O,T) :-object_missing_image_for_role(O,T,_).

% True if at least one declared image role is missing.
has_object_missing_image_for_role(O,T) :-object_missing_image_for_role(O,T,_).


% ============================================================
% SAME-TYPE OBJECT PLACEMENT CONFLICT
% ============================================================
%
% Detects whether the selected object is being placed at
% a node already occupied by another object of the same type.
%
%
% ============================================================
% An object cannot be placed if another object of the same type occupies the selected node.
% Thsi rule prevents two different objects of the same type from occupying the same node,
same_type_placement_conflict(N,R,O,T) :-object_selected_for_placement(O,T,R),position(N,ExistingRole,ExistingObject),object(ExistingObject,T),ExistingObject != O.

% A train should not be allowed to be placed on an empty grid cell. It must be placed on a cell that already contains a track.


% ============================================================
% GENERIC PLACEMENT VALIDATION
% ============================================================

% Identify an unsatisfied placement requirement.
missing_placement_requirement(N,O,T,R,RequiredType) :-node(N),object_selected_for_placement(O,T,R),type_placement_requirement(T,RequiredType),not node_contains_type(N,RequiredType).

% A placement is rejected if a declared requirement is missing.
object_placement_rejected(N,O,T,R) :-missing_placement_requirement(N,O,T,R,_).

% A placement is also rejected when another object of
% the same type occupies the destination node.
object_placement_rejected(N,O,T,R) :- same_type_placement_conflict(N,R,O,T).

%  Determine whether the selected object can be placed.
valid_object_placement(Row,Col,O,T,R) :-node((Row,Col)),object_selected_for_placement(O,T,R),not position((Row,Col),R,O),not object_placement_rejected((Row,Col),O,T,R),not _clinguin_unsat.

