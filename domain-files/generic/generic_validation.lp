% ============================================================
% FILE: generic_validation.lp
% ============================================================
%
% PURPOSE:
% This file contains generic validation, counting, and
% completeness rules.
% The rules are independent of UI state.

%
% It works with generic predicates such as:
%
%   object_type/2 
%   node/1
%   object/2
%   property/3
%   type_property/4
%   type_role/2
%   image/3
%   position/3
%
% MAIN RESPONSIBILITIES:
%
% 1. Check whether generic domain information exists.
% 2. Count nodes, objects, types, images, and positions.
% 3. Identify declared properties and image roles.
% 4. Detect missing required properties and role images.
% 5. Determine whether an object is complete or incomplete.
%
% The generic facts may originate from:
%   - Domain files (e.g., MAPF, Flatland).
%   - Objects and  their properties can  dynamically be added through the Clinguin UI.

% ============================================================


% ============================================================
% 1. Object TYPE EXISTENCE 
% ============================================================
%
% PURPOSE:
% Check whether at least one object type is declared.
% Check whether at least one object role is declared.

%
% CHECKS:
% - Whether any object_type/2 fact exists.
% - Whether any object_role/2 fact exists.

% ============================================================
% Declared Object Type
has_declared_object_type :-object_type(_).

% Declared Role
has_declared_type_role(R) :- type_role(_,R).

% ============================================================
% 2. INSTANCE EXISTENCE CHECKS
% ============================================================
%
% PURPOSE:
% Determine whether the instance contains basic elements.
%
% CHECKS:
% - Whether any coordinate-based grid node exists.
% - Whether any object exists.
% - Whether an object has at least one image.
% - Whether an object has at least one position.
%
% These predicates can be used to control UI visibility,
%
% ============================================================

% True if at least one coordinate-based grid node exists.
has_grid_nodes :-node((_ , _)).

% True if at least one object exists.
has_objects :-object(_,_).

% True if object O has at least one image.
has_images(O) :-image(O,_,_).

% True if object O has at least one position.
has_positions(O) :-position(_,_,O).


% ============================================================
% 3. INSTANCE STATISTICS AND COUNTS
% ============================================================
%
% PURPOSE:
% Calculate statistics about the current domain instance.
%
% COUNTS:
% - Total number of nodes.
% - Total number of distinct objects.
% - Number of distinct object types.
% - Number of images assigned to each object.
% - Number of positions assigned to each object.
%
% These counts can be used in UI dashboards, object
% inspection panels, and instance summaries.
%
% ============================================================

% Count all nodes in the instance.
node_count(N) :-N = #count { Node : node((Node)) }.

% Count all distinct objects in the instance.
object_count(N) :-N = #count { O : object(O,_) }.

% Count distinct types declared through object_type/2.
type_count(N) :-N = #count { T : object_type(T) }.

% Count all images associated with object O.
object_image_count(O,N) :-object(O,_),N = #count { R,I : image(O,R,I) }.

% Count all positions associated with object O.
object_position_count(O,N) :-object(O,_),N = #count { Node,R : position(Node,R,O) }.


% ============================================================
% 4. GENERIC SCHEMA INFORMATION
% ============================================================
%
% PURPOSE:
% Derive information about properties and image roles
% defined in the generic domain representation.
%
% CHECKS:
% - Whether an object type declares any properties.
% - Whether an object has exactly one distinct image role.
%
% ============================================================

% True if type T declares at least one property.
has_properties(T) :-type_property(T,_,_,_).

% True if object O has exactly one distinct image role R.
object_single_role_image(O,R) :-object(O,_),image(O,R,_),1 = #count { R2 : image(O,R2,_) }.


% ============================================================
% 5. REQUIRED PROPERTY VALIDATION
% ============================================================
%
% PURPOSE:
% Identify required properties that are missing from
% existing objects.
%
% CHECKS:
% - Whether object O belongs to type T.
% - Whether property P is declared as required for type T.
% - Whether object O has no value assigned to property P.
%
% RESULT:
% object_missing_required_property(O,T,P,VT)
%
% where:
%   O  = Object identifier
%   T  = Object type
%   P  = Missing property name
%   VT = Expected value type
%
% ============================================================
 object_missing_required_property(O,T,P,VT) :-object(O,T),type_property(T,P,VT,required),not property(O,P,_).


% ============================================================
% 6. PROPERTY AND IMAGE COMPLETENESS CHECKS
% ============================================================
%
% PURPOSE:
% Determine whether an object satisfies the declared
% property and image requirements of its type.
%
% CHECKS:
%
% has_all_properties/2:
% - The object exists.
% - No required property is missing.
%
% has_all_images/2:
% - The object exists.
% - No declared image role is missing an image.

% ============================================================

% True if object O has all required properties.
has_all_properties(O,T) :-object(O,T), not object_missing_required_property(O,T,_,_).

% True if no image role is reported missing for object O.
has_all_images(O,T) :-object(O,T), not object_missing_image_for_role(O,T,_).


% ============================================================
% 7. OBJECT COMPLETENESS
% ============================================================
%
% PURPOSE:
% Classify existing objects as complete or incomplete.
%
% COMPLETE OBJECT:
% - Has all required properties.
% - Has an image for every declared role, according
%   to the missing-image rules.
%
% INCOMPLETE OBJECT:
% - Does not satisfy one or both completeness conditions.
%
% RESULTS:
%   complete(O,T)
%   incomplete(O,T)
%


%
% ============================================================

% Object is complete when both completeness checks succeed.
complete(O,T) :-object(O,T),has_all_properties(O,T),has_all_images(O,T).

% Object is incomplete when completeness cannot be established.
incomplete(O,T) :-object(O,T),not complete(O,T).


% Check whether a node contains an object of type T.
node_contains_type(N,T) :-position(N,_,O),object(O,T).


% :-position(N,R,O1),position(N,R,O2),O1<O2.
% ============================================================
% DISPLAY OBJECT LABELS
% ============================================================

% Use the label property, or fall back to the object name.
object_display_ID(O,ID) :-object(O,_),property(O,id,ID).

% generic_object_identifier_exists(O):-object(O,_)
% If an object with identifier O and type T already exists, and there is a request to create that same object,
%  derive a rejection result containing an error message
% object_creation_rejected(create,O,T,"Can not create object:an object with this identifier and type already exists."):-object(O,T),request(create,O,T).
% identifier/type pairs already present in the instance.
generic_object_exists(O,T) :-object(O,T).