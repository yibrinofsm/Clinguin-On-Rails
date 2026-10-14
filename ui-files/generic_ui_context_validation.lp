% generic_ui_context_validation.lp

% This file contains validation rules  that depend  on generic domain predicates, 
% user-added atoms, and Clinguin UI context”
% The rules depends on the current user selection, so it is UI-context-dependent. 

% Declared Role
has_declared_type_role(R) :- type_role(_,R).

% ============================================================
% CURRENT UI SELECTION
% ============================================================

% Derive the object currently opened in the inspector.
object_selected_for_inspection(O,T) :-object(O,T),_clinguin_context(selected_for_inspection,O).

% Derive the object currently selected for grid placement.
object_selected_for_placement(O,T) :-object(O,T),_clinguin_context(object_selected_for_placement_for_placement,O).



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
object_missing_image_for_role(O,T,R) :-
    object_selected_for_inspection(O,T),
    type_role(T,R),
    not image(O,R,_).

% True if the selected object is missing at least one image.
object_missing_image(O,T) :-
    object_missing_image_for_role(O,T,_).

% True if at least one declared image role is missing.
has_object_missing_image_for_role(O,T) :-
    object_missing_image_for_role(O,T,_).



% ============================================================
% GRID LOGIC
% ============================================================
% node/1 gets facts from two sources:
% 1. Domain files (domain files(positions or nodes))
% 2. Clinguin UI()

% Grid dimensions
ui_grid_dimensions(Rows,Cols) :- _clinguin_context(new_rows,Rows),_clinguin_context(new_cols,Cols),Rows>0,Cols>0.

% user -addded nodes(from the UI)
ui_grid_node((R,C)) :- ui_grid_dimensions(Rows,Cols),R=0..Rows-1,C=0..Cols-1.

node((R,C)) :- ui_grid_node((R,C)).


has_ui_grid :- ui_grid_node(_).

domain_node((R,C)) :- node((R,C)),not ui_grid_node((R,C)).

has_domain_nodes :- domain_node(_).

% ============================================================
% IMAGE / ROLE LOGIC
% ============================================================
% image/3 gets facts from two sources:
% 1. Domain files (domain files(positions or nodes))
% 2. Clinguin UI()

% To add an image

% 1. Select on object for inspection
% 2. select a declared role for its type()
% 3. upload an image associated for that role for the object
% Session Added Image
session_image(O,R,I) :- image(O,R,I),_clinguin_atom(image(O,R,I)).
% Declared Image
domain_image(O,R,I) :- image(O,R,I),not _clinguin_atom(image(O,R,I)).



%How to  place an object on the Grid

% 1. check if the object is complete
% 2. check if the user selected the object for placement
% 3. check if the user selected a role for placement 

% An object O of type T is considered selected and ready for placement with role R if the user has selected the object and 
% role in the Clinguin interface, the object is complete.
placement_selected(O,T,R) :- _clinguin_context(object_selected_for_placement_for_placement,O),_clinguin_context(selected_role_for_placement,R),complete(O,T).

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
same_type_placement_conflict(N,R,O,T) :-placement_selected(O,T,R),position(N,ExistingRole,ExistingObject),object(ExistingObject,T),ExistingObject != O.

% A train should not be allowed to be placed on an empty grid cell. It must be placed on a cell that already contains a track.


% ============================================================
% GENERIC PLACEMENT VALIDATION
% ============================================================



% Identify an unsatisfied placement requirement.
missing_placement_requirement(N,O,T,R,RequiredType) :-node(N),placement_selected(O,T,R),type_placement_requirement(T,RequiredType),not node_contains_type(N,RequiredType).

% A placement is rejected if a declared requirement is missing.
placement_rejected(N,O,T,R) :-missing_placement_requirement(N,O,T,R,_).

% A placement is also rejected when another object of
% the same type occupies the destination node.
placement_rejected(N,O,T,R) :- same_type_placement_conflict(N,R,O,T).

%  Determine whether the selected object can be placed.
valid_object_placement(Row,Col,O,T,R) :-node((Row,Col)),placement_selected(O,T,R),not position((Row,Col),R,O),not placement_rejected((Row,Col),O,T,R),not _clinguin_unsat.

