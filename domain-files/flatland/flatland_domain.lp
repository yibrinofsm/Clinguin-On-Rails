
% ============================================================
% FILE: flatland_domain.lp
% ============================================================

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% It tells our Generic UI and the other ASP files what kinds of objects exist, 
% what roles they may have, what properties they require.
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


% Domain configuration
active_domain(flatland).

% Type Declaration
domain_type(track).
domain_type(train).

% Role Declaration
% domain_role(flatland,cell).
% domain_role(flatland,start).
% domain_role(flatland,end).

% Type Role

type_role(track,cell).
type_role(train,start).
type_role(train,end).


% add_atom (type_role(type,role))


% Allowed Code 
valid_track_code(32800;1025;37408;17411;32872;3089;49186;1097;34864;5633;33825;38433;50211;33897;35889;38505;52275;20994;16458;2136;6672;4608;16386;72;2064;8192;4;128;256).

% Train property declaration
% type_property(
%     ObjectType,
%     PropertyName,
%     ValueType,
%     Requirement
% ).

type_property(train,direction,int,required).
type_property(train,speed,int,required).
type_property(train,dep,int,required).
type_property(train,arr,int,required).

type_property(track,code,int,required).

% Trains require an existing track at the destination node.
type_placement_requirement(train,track).

% Valid train directions
train_direction(n).
train_direction(e).
train_direction(s).
train_direction(w).


<<<<<<< HEAD
position((0,0),start,train0).
position((0,0),end,train10).






% ============================================================
% FILE: domain-files/flatland/flatland_track_validation.lp
% Domain-level Flatland track compatibility (UI-independent).
% Inputs: object/2, property/3, position/3.
% Output: flatland_invalid_placement/5.
% No placement_selected/3, _clinguin_context/2 or UI predicates.
% ============================================================

flatland_track_code(32800;1025).
flatland_track_code(37408;17411;32872;3089).
flatland_track_code(49186;1097;34864;5633).
flatland_track_code(33825).
flatland_track_code(38433;50211;33897;35889).
flatland_track_code(38505;52275).
flatland_track_code(20994;16458;2136;6672).
flatland_track_code(4608;16386;72;2064).
flatland_track_code(8192;4;128;256).

flatland_dir_index(n,0).
flatland_dir_index(e,1).
flatland_dir_index(s,2).
flatland_dir_index(w,3).

flatland_opposite(n,s).
flatland_opposite(s,n).
flatland_opposite(e,w).
flatland_opposite(w,e).

flatland_offset(n,-1,0).
flatland_offset(e,0,1).
flatland_offset(s,1,0).
flatland_offset(w,0,-1).

% Decode the four-by-four (incoming, outgoing) Flatland transition bitmask.
flatland_transition(Code,In,Out) :-
    flatland_track_code(Code),
    flatland_dir_index(In,I),
    flatland_dir_index(Out,J),
    Bit = 15 - 4*I - J,
    (Code / (2 ** Bit)) \ 2 = 1.

% A rail opens at side D if travel can exit toward D, or enter from
% that side while facing the opposite direction.
flatland_port(Code,D) :- flatland_transition(Code,_,D).
flatland_port(Code,D) :-
    flatland_opposite(D,ArrivalDirection),
    flatland_transition(Code,ArrivalDirection,_).

flatland_object_code(O,Code) :-
    object(O,track),
    property(O,code,Code),
    flatland_track_code(Code).

% Candidate position N is adjacent to an already placed neighbor.
flatland_neighbor((X,Y),D,(NX,NY),Existing,ExistingCode) :-
    position((NX,NY),cell,Existing),
    flatland_object_code(Existing,ExistingCode),
    flatland_offset(D,DX,DY),
    X = NX-DX,
    Y = NY-DY.

% Pure domain validation: candidate O cannot be placed at N if its
% shared boundary disagrees with the existing neighbor's boundary.
% Arguments: N, O, direction, neighbor position, neighbor object.
flatland_invalid_placement(N,O,D,Neighbor,Existing) :-
    flatland_object_code(O,NewCode),
    flatland_neighbor(N,D,Neighbor,Existing,ExistingCode),
    O != Existing,
    flatland_opposite(D,Opp),
    flatland_port(NewCode,D),
    not flatland_port(ExistingCode,Opp).

flatland_invalid_placement(N,O,D,Neighbor,Existing) :-
    flatland_object_code(O,NewCode),
    flatland_neighbor(N,D,Neighbor,Existing,ExistingCode),
    O != Existing,
    flatland_opposite(D,Opp),
    flatland_port(ExistingCode,Opp),
    not flatland_port(NewCode,D).

% No integrity constraint here: while building an instance, the domain
% must remain satisfiable so Clinguin can display placement errors.
% If domain files contain #show directives, expose this predicate via
% a matching #show flatland_invalid_placement/5 directive as needed

=======



>>>>>>> 099658fafc97134e4963e8c7a3152f905d85e181
