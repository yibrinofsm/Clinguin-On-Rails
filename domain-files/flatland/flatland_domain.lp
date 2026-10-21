
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
object_type(track).
object_type(train).

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
type_property(train,id,int,required).

type_property(track,code,int,required).

% Trains require an existing track at the destination node.
type_placement_requirement(train,track).

% Valid train directions
train_direction(0).
train_direction(1).
train_direction(2).
train_direction(3).

