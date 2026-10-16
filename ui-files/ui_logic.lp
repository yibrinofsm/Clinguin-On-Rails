% ============================================================
% ui_logic.lp
% ============================================================
%
% Generic helper atoms derived from the current Clinguin UI
% interaction state.
% ============================================================


% ============================================================
% DOMAIN STATE
% ============================================================

% active_domain/1 gets facts from two sources:
% 1. Domain files ( domain is active if it's declared in a domain file)
% 2. Clinguin UI()

% ============================================================
% USER-ADDED DOMAINS (From the Clinguin UI)
% ============================================================
user_added_domain(D) :- _clinguin_atom(active_domain(D)).
active_domain(D) :- user_added_domain(D).

% ============================================================
% DOMAIN EXISTENCE
% ============================================================

has_active_domain :- active_domain(_).
no_active_domain :- not has_active_domain.

% ============================================================
% DOMAIN EDITABILITY
% ============================================================
editable_domain(D) :- active_domain(D), user_added_domain(D).
readonly_domain(D) :- active_domain(D), not user_added_domain(D).


% Add Object
% 1. ObjectName
% 2. ObjectType


% domain_type/2 gets facts from two sources

% 1. from the domain files
% 2. from the Clinguin UI

has_declared_object_type :- domain_type(_).


% ============================================================
% CURRENT UI SELECTION
% ============================================================

% Derive the object currently opened in the inspector.
object_selected_for_inspection(O,T) :-object(O,T),_clinguin_context(selected_for_inspection,O).

% Derive the object currently selected for grid placement.
object_selected_for_placement(O,T) :-object(O,T),_clinguin_context(object_selected_for_placement_for_placement,O).




% ============================================================
% AVAILABLE IMAGE ROLES
% ============================================================

object_missing_image_for_role(O,T,R) :- object_selected_for_inspection(O,T),type_role(T,R),not image(O,R,_).

has_object_missing_image_for_role(O,T) :- object_missing_image_for_role(O,T,_).
<<<<<<< HEAD

object_missing_image(O,T) :- object_missing_image_for_role(O,T,_).

session_image(O,R,I) :- image(O,R,I),_clinguin_atom(image(O,R,I)).
domain_image(O,R,I) :- image(O,R,I),not _clinguin_atom(image(O,R,I)).
=======
>>>>>>> 099658fafc97134e4963e8c7a3152f905d85e181
% node((R,C)) :-_clinguin_context(new_rows, Rows),_clinguin_context(new_cols, Cols),R = 0..Rows-1,C = 0..Cols-1.


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

% 1. select on object
% 2. select a role
% 3. upload an image associated for that role for the object


<<<<<<< HEAD
% object_missing_image_for_role(O,T,R) :- object_selected_for_inspection(O,T),type_role(T,R),not image(O,R,_).

%


=======
object_missing_image_for_role(O,T,R) :- object_selected_for_inspection(O,T),type_role(T,R),not image(O,R,_).

% has_object_missing_image_for_role
object_missing_image(O,T) :- object_missing_image_for_role(O,T,_).

session_image(O,R,I) :- image(O,R,I),_clinguin_atom(image(O,R,I)).
domain_image(O,R,I) :- image(O,R,I),not _clinguin_atom(image(O,R,I)).


% Selected complete object and valid role.
placement_selected(O,T,R) :- _clinguin_context(object_selected_for_placement_for_placement,O),_clinguin_context(selected_role_for_placement,R),complete(O,T).
>>>>>>> 099658fafc97134e4963e8c7a3152f905d85e181
