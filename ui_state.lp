%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% REPLACE EXISTING FILE: ui_state.lp
%
% Domain-independent contract
% -----------------------------------------------------------------------------
% Required:
%   object(Object,Type).
%   property(Object,Key,Value).
%   position((Row,Column),Role,Object).
%   node((Row,Column)).
%
% Optional presentation metadata:
%   image(Object,Role,Path).
%
% Optional generic presentation conventions through property/3:
%   property(Object,label,Label).
%   property(Object,(ui,label),Label).
%   property(Object,(ui,show_label),false).
%   property(Object,(ui,layer),Integer).
%   property(Object,(ui,layer,Role),Integer).
%   property(Object,(ui,fit),contain_or_cover).
%   property(Object,(ui,fit,Role),contain_or_cover).
%   property(Object,(ui,opacity),Value).
%   property(Object,(ui,opacity,Role),Value).
%   property(Object,(ui,slot),Slot).
%   property(Object,(ui,slot,Role),Slot).
%   property(Object,(ui,transform),CssTransform).
%   property(Object,(ui,transform,Role),CssTransform).
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

#defined image/3.
#defined _clinguin_atom/1.
#defined _clinguin_context/2.
#defined _clinguin_unsat/0.
#defined _clinguin_browsing/0.

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Presence
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

has_objects :- object(_,_).
has_grid :- node((_,_)).

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Grid geometry
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

grid_bounds(Rmin,Rmax,Cmin,Cmax) :-
    has_grid,
    Rmin = #min { R : node((R,_)) },
    Rmax = #max { R : node((R,_)) },
    Cmin = #min { C : node((_,C)) },
    Cmax = #max { C : node((_,C)) }.

grid_dimensions(H,W) :-
    grid_bounds(Rmin,Rmax,Cmin,Cmax),
    H = Rmax - Rmin + 1,
    W = Cmax - Cmin + 1.

% Preserve sparse coordinate geometry.
grid_slot((R,C)) :-
    grid_bounds(Rmin,Rmax,Cmin,Cmax),
    R = Rmin..Rmax,
    C = Cmin..Cmax.

grid_row_index(R) :- grid_slot((R,_)).

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Generic
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

object_type(T) :- object(_,T).
position_role(Role) :- position(_,Role,_).

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Counts
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

total_object_count(N) :- N = #count { O,T : object(O,T) }.
total_type_count(N) :- N = #count { T : object_type(T) }.
total_property_count(N) :- N = #count { O,K,V : property(O,K,V) }.
total_position_count(N) :- N = #count { Node,Role,O : visible_position(Node,Role,O) }.
total_image_count(N) :- N = #count { O,Role,I : valid_image_path(O,Role,I) }.
total_node_count(N) :- N = #count { R,C : node((R,C)) }.

object_type_count(T,N) :-object_type(T),N = #count { O : object(O,T) }.
object_property_count(O,N) :-object(O,_),N = #count { K,V : property(O,K,V) }.

object_position_count(O,N) :-object(O,_),N = #count { Node,Role : visible_position(Node,Role,O) }.

object_image_count(O,N) :-object(O,_),N = #count { Role,I : valid_image_path(O,Role,I) }.

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Deterministic ordering
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

object_rank(O,N) :-object(O,_),N = #count { O2 : object(O2,_), O2 < O }.

type_rank(T,N) :-
    object_type(T),
    N = #count { T2 : object_type(T2), T2 < T }.

role_rank(Role,N) :-
    position_role(Role),
    N = #count { Role2 : position_role(Role2), Role2 < Role }.

first_role(Role) :-
    position_role(Role),
    role_rank(Role,0).

property_rank(O,K,V,N) :-
    property(O,K,V),
    N = #count {
        K2,V2 : property(O,K2,V2), K2 < K;
        K2,V2 : property(O,K2,V2), K2 = K, V2 < V
    }.

position_rank(O,Node,Role,N) :-
    visible_position(Node,Role,O),
    N = #count {
        Node2,Role2 : visible_position(Node2,Role2,O), Node2 < Node;
        Node2,Role2 : visible_position(Node2,Role2,O), Node2 = Node, Role2 < Role
    }.

valid_image_path(O,Role,I) :-
    image(O,Role,I),
    I != "",
    I != " ".

has_image_metadata(O,Role) :- image(O,Role,_).

image_rank(O,Role,I,N) :-
    valid_image_path(O,Role,I),
    N = #count {
        Role2,I2 : valid_image_path(O,Role2,I2), Role2 < Role;
        Role2,I2 : valid_image_path(O,Role2,I2), Role2 = Role, I2 < I
    }.

primary_image(O,Role,I) :-
    object(O,_),
    image_rank(O,Role,I,0).

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Client selection and arbitrary placement role
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

selected_object(O) :-
    _clinguin_context(selected_object,O),
    object(O,_).

selected_role(Role) :-
    _clinguin_context(placement_role,Role).

% Optional generic default-role metadata. When absent, the first role for which
% the object has image/3 metadata is used; this keeps the reusable UI free of
% application-specific role names.
object_default_role(O,Role) :-
    object(O,_),
    property(O,(ui,default_role),Role).

object_default_role(O,Role) :-
    object(O,_),
    not property(O,(ui,default_role),_),
    primary_image(O,Role,_).

object_position_role(O,Role) :- position(_,Role,O).

object_position_role_rank(O,Role,N) :-
    object_position_role(O,Role),
    N = #count { Role2 : object_position_role(O,Role2), Role2 < Role }.

object_default_role(O,Role) :-
    object(O,_),
    not property(O,(ui,default_role),_),
    not primary_image(O,_,_),
    object_position_role_rank(O,Role,0).

effective_role(Role) :- selected_role(Role).
effective_role(Role) :-
    selected_object(O),
    object_default_role(O,Role),
    not selected_role(_).
selected_has_default_role :-
    selected_object(O),
    object_default_role(O,_).

effective_role(Role) :-
    first_role(Role),
    not selected_role(_),
    not selected_has_default_role.

selected_object_at(Node) :-
    selected_object(O),
    visible_position(Node,_,O).

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% UI preferences retained through client context
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

allowed_grid_scale(compact;normal;large).
requested_grid_scale(S) :-
    _clinguin_context(grid_scale,S),
    allowed_grid_scale(S).

large_grid :-
    grid_dimensions(H,W),
    Slots = H * W,
    Slots >= 900.

default_grid_scale(compact) :- large_grid.
default_grid_scale(normal) :- has_grid, not large_grid.
default_grid_scale(normal) :- not has_grid.

grid_scale(S) :- requested_grid_scale(S).
grid_scale(S) :- default_grid_scale(S), not requested_grid_scale(_).

grid_node_size(28) :- grid_scale(compact).
grid_node_size(36) :- grid_scale(normal).
grid_node_size(48) :- grid_scale(large).

grid_node_css("28px") :- grid_scale(compact).
grid_node_css("36px") :- grid_scale(normal).
grid_node_css("48px") :- grid_scale(large).

grid_badge_size(18) :- grid_scale(compact).
grid_badge_size(22) :- grid_scale(normal).
grid_badge_size(26) :- grid_scale(large).

grid_badge_x(X) :- grid_node_size(S), grid_badge_size(B), X = S - B - 2.
grid_badge_y(2) :- has_grid.

grid_badge_font("7px") :- grid_scale(compact).
grid_badge_font("9px") :- grid_scale(normal).
grid_badge_font("10px") :- grid_scale(large).

grid_text_size("7px") :- grid_scale(compact).
grid_text_size("8px") :- grid_scale(normal).
grid_text_size("10px") :- grid_scale(large).

allowed_label_mode(selected;explicit;all;none).
requested_label_mode(M) :-
    _clinguin_context(label_mode,M),
    allowed_label_mode(M).

label_mode(M) :- requested_label_mode(M).
label_mode(selected) :- not requested_label_mode(_).

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Facts added during the current Clinguin session
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

user_object(O,T) :- _clinguin_atom(object(O,T)).
user_property(O,K,V) :- _clinguin_atom(property(O,K,V)).
user_position(Node,Role,O) :- _clinguin_atom(position(Node,Role,O)).
user_image(O,Role,I) :- _clinguin_atom(image(O,Role,I)).

user_object_count(N) :- N = #count { O,T : user_object(O,T) }.
user_property_count(N) :- N = #count { O,K,V : user_property(O,K,V) }.
user_position_count(N) :- N = #count { Node,Role,O : user_position(Node,Role,O) }.
user_image_count(N) :- N = #count { O,Role,I : user_image(O,Role,I) }.

interactive_edit_count(N) :-
    user_object_count(A),
    user_property_count(B),
    user_position_count(C),
    user_image_count(D),
    N = A + B + C + D.

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Generic position slots and session overrides
%
% A role is the default slot. A domain may optionally map several roles to a
% shared slot through property/3. One session-added object is rendered per
% (Node,Slot); different slots remain independently layerable at one node.
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

generic_role(Role) :- position_role(Role).
generic_role(Role) :- selected_role(Role).
generic_role(Role) :- image(_,Role,_).
generic_role(Role) :- property(_,(ui,default_role),Role).

object_slot(O,Role,Slot) :-
    object(O,_),
    property(O,(ui,slot,Role),Slot).

object_slot(O,Role,Slot) :-
    object(O,_),
    generic_role(Role),
    not property(O,(ui,slot,Role),_),
    property(O,(ui,slot),Slot).

object_slot(O,Role,Role) :-
    object(O,_),
    generic_role(Role),
    not property(O,(ui,slot,Role),_),
    not property(O,(ui,slot),_).

user_slot_position(Node,Slot,Role,O) :-
    user_position(Node,Role,O),
    object_slot(O,Role,Slot).

user_slot_exists(Node,Slot) :- user_slot_position(Node,Slot,_,_).

user_slot_priority(Node,Slot,Role,O,P) :-
    user_slot_position(Node,Slot,Role,O),
    role_rank(Role,RN),
    object_rank(O,ON),
    P = RN * 100000 + ON.

user_slot_max_priority(Node,Slot,M) :-
    user_slot_exists(Node,Slot),
    M = #max { P : user_slot_priority(Node,Slot,_,_,P) }.

active_user_position(Node,Role,O) :-
    user_slot_priority(Node,Slot,Role,O,P),
    user_slot_max_priority(Node,Slot,P).

% Session positions override source positions only within the same generic slot.
visible_position(Node,Role,O) :- active_user_position(Node,Role,O).

visible_position(Node,Role,O) :-
    position(Node,Role,O),
    object_slot(O,Role,Slot),
    not user_slot_exists(Node,Slot).

selected_active_user_position(Node,Role,O) :-
    selected_object(O),
    active_user_position(Node,Role,O).

selected_slot(Role,Slot) :-
    selected_object(O),
    effective_role(Role),
    object_slot(O,Role,Slot).

slot_active_user(Node,Role,O) :-
    selected_slot(_,Slot),
    active_user_position(Node,Role,O),
    object_slot(O,Role,Slot).

% Deterministic representative for the effective object in each visual slot.
% This is primarily a safeguard for source encodings that accidentally expose
% several objects in the same slot; session-added positions already reduce to
% one active position per (Node,Slot).
visible_slot_priority(Node,Slot,Role,O,P) :-
    visible_position(Node,Role,O),
    object_slot(O,Role,Slot),
    role_rank(Role,RN),
    object_rank(O,ON),
    P = RN * 100000 + ON.

visible_slot_max_priority(Node,Slot,M) :-
    visible_slot_priority(Node,Slot,_,_,_),
    M = #max { P : visible_slot_priority(Node,Slot,_,_,P) }.

slot_visible_position(Node,Slot,Role,O) :-
    visible_slot_priority(Node,Slot,Role,O,P),
    visible_slot_max_priority(Node,Slot,P).

% Target selected by the user for a concrete node.
selected_target(Node,Role,O,Slot) :-
    node(Node),
    selected_object(O),
    effective_role(Role),
    object_slot(O,Role,Slot).

selected_same_visible_position(Node,Role,O) :-
    selected_target(Node,Role,O,Slot),
    slot_visible_position(Node,Slot,Role,O).

selected_empty_slot(Node,Role,O) :-
    selected_target(Node,Role,O,Slot),
    not slot_visible_position(Node,Slot,_,_).

% A different effective object occupies the selected generic slot.
selected_slot_conflict(Node,OldRole,OldO,NewRole,NewO) :-
    selected_target(Node,NewRole,NewO,Slot),
    slot_visible_position(Node,Slot,OldRole,OldO),
    OldRole != NewRole.

selected_slot_conflict(Node,Role,OldO,Role,NewO) :-
    selected_target(Node,Role,NewO,Slot),
    slot_visible_position(Node,Slot,Role,OldO),
    OldO != NewO.

selected_user_slot_conflict(Node,OldRole,OldO,NewRole,NewO) :-
    selected_slot_conflict(Node,OldRole,OldO,NewRole,NewO),
    active_user_position(Node,OldRole,OldO).

selected_source_slot_conflict(Node,OldRole,OldO,NewRole,NewO) :-
    selected_slot_conflict(Node,OldRole,OldO,NewRole,NewO),
    not active_user_position(Node,OldRole,OldO).

% Exact session-added position of the selected object under the active role.
selected_effective_user_position(Node,Role,O) :-
    selected_object(O),
    effective_role(Role),
    active_user_position(Node,Role,O).

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Generic labels
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

explicit_object_label(O,L) :-
    object(O,_),
    property(O,(ui,label),L).

explicit_object_label(O,L) :-
    object(O,_),
    property(O,label,L),
    not property(O,(ui,label),_).

object_label(O,L) :- explicit_object_label(O,L).

object_label(O,O) :-
    object(O,_),
    not explicit_object_label(O,_).

object_has_explicit_label(O) :- explicit_object_label(O,_).

object_label_hidden(O) :- property(O,(ui,show_label),false).
object_label_hidden(O) :- property(O,(ui,show_label),"false").
object_label_hidden(O) :- property(O,(ui,show_label),0).

label_candidate(O,L) :-
    label_mode(selected),
    selected_object(O),
    object_label(O,L),
    not object_label_hidden(O).

label_candidate(O,L) :-
    label_mode(explicit),
    explicit_object_label(O,L),
    not object_label_hidden(O).

label_candidate(O,L) :-
    label_mode(all),
    object_label(O,L),
    not object_label_hidden(O).

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Optional images and text fallback
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

object_image(O,Role,I) :-
    object(O,_),
    valid_image_path(O,Role,I).

has_role_image(O,Role) :- valid_image_path(O,Role,_).

node_image(Node,Role,O,I) :-
    node(Node),
    object(O,_),
    visible_position(Node,Role,O),
    valid_image_path(O,Role,I).

% If a domain intentionally supplies blank image metadata, render no technical
% fallback. Text fallback is used only when image/3 metadata is absent.
node_text(Node,Role,O,L) :-
    node(Node),
    object(O,_),
    visible_position(Node,Role,O),
    object_label(O,L),
    not has_image_metadata(O,Role).

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Generic visual metadata
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

visual_fit(O,Role,Fit) :-
    visible_position(_,Role,O),
    property(O,(ui,fit,Role),Fit).

visual_fit(O,Role,Fit) :-
    visible_position(_,Role,O),
    not property(O,(ui,fit,Role),_),
    property(O,(ui,fit),Fit).

visual_fit(O,Role,"contain") :-
    visible_position(_,Role,O),
    not property(O,(ui,fit,Role),_),
    not property(O,(ui,fit),_).

visual_opacity(O,Role,V) :-
    visible_position(_,Role,O),
    property(O,(ui,opacity,Role),V).

visual_opacity(O,Role,V) :-
    visible_position(_,Role,O),
    not property(O,(ui,opacity,Role),_),
    property(O,(ui,opacity),V).

visual_opacity(O,Role,"1") :-
    visible_position(_,Role,O),
    not property(O,(ui,opacity,Role),_),
    not property(O,(ui,opacity),_).

visual_transform(O,Role,T) :-
    visible_position(_,Role,O),
    property(O,(ui,transform,Role),T).

visual_transform(O,Role,T) :-
    visible_position(_,Role,O),
    not property(O,(ui,transform,Role),_),
    property(O,(ui,transform),T).

visual_transform(O,Role,"none") :-
    visible_position(_,Role,O),
    not property(O,(ui,transform,Role),_),
    not property(O,(ui,transform),_).

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Fully generic visual stacking
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

visual_z_index(O,Role,Z) :-
    visible_position(_,Role,O),
    property(O,(ui,layer,Role),L),
    role_rank(Role,RN),
    object_rank(O,ON),
    Z = L * 1000000 + RN * 1000 + ON + 1.

visual_z_index(O,Role,Z) :-
    visible_position(_,Role,O),
    not property(O,(ui,layer,Role),_),
    property(O,(ui,layer),L),
    role_rank(Role,RN),
    object_rank(O,ON),
    Z = L * 1000000 + RN * 1000 + ON + 1.

visual_z_index(O,Role,Z) :-
    visible_position(_,Role,O),
    not property(O,(ui,layer,Role),_),
    not property(O,(ui,layer),_),
    role_rank(Role,RN),
    object_rank(O,ON),
    Z = (RN + 1) * 1000000 + ON + 1.

node_max_z(Node,Z) :-
    visible_position(Node,_,_),
    Z = #max { Z0 : visible_position(Node,Role,O), visual_z_index(O,Role,Z0) }.

node_top_visual(Node,Role,O) :-
    visible_position(Node,Role,O),
    visual_z_index(O,Role,Z),
    node_max_z(Node,Z).

overlay_z_index(Node,Z2) :-
    node_max_z(Node,Z),
    Z2 = Z + 1000000.

node_overlay_label(Node,Role,O,L) :-
    node_top_visual(Node,Role,O),
    has_role_image(O,Role),
    label_candidate(O,L).

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Operation feedback supplied through context before a server call
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

feedback_raw(K,T,M) :-
    _clinguin_context(feedback_kind,K),
    _clinguin_context(feedback_title,T),
    _clinguin_context(feedback_message,M).

feedback_view(error,"Operation needs attention","The requested change was received, but the resulting domain state is unsatisfiable.") :-
    feedback_raw(_,_,_),
    _clinguin_unsat.

feedback_view(K,T,M) :-
    feedback_raw(K,T,M),
    not _clinguin_unsat.

feedback_message_type(error) :- feedback_view(error,_,_).
feedback_message_type(warning) :- feedback_view(warning,_,_).
feedback_message_type(info) :- feedback_view(info,_,_).
feedback_message_type(info) :- feedback_view(success,_,_).

feedback_symbol(success,"✓").
feedback_symbol(info,"i").
feedback_symbol(warning,"!").
feedback_symbol(error,"!").

feedback_accent(success,"#15803d").
feedback_accent(info,"#2563eb").
feedback_accent(warning,"#b45309").
feedback_accent(error,"#b91c1c").

feedback_background(success,"linear-gradient(135deg,rgba(22,163,74,.11),rgba(240,253,244,.96))").
feedback_background(info,"linear-gradient(135deg,rgba(37,99,235,.10),rgba(239,246,255,.96))").
feedback_background(warning,"linear-gradient(135deg,rgba(245,158,11,.13),rgba(255,251,235,.96))").
feedback_background(error,"linear-gradient(135deg,rgba(220,38,38,.11),rgba(254,242,242,.96))").

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Inspector helpers
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

selected_has_properties :- selected_object(O), property(O,_,_).
selected_has_positions :- selected_object(O), visible_position(_,_,O).
selected_has_images :- selected_object(O), valid_image_path(O,Role,I).