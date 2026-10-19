
% ============================================================
% FILE: mapf_domain.lp
% ============================================================

% Domain configuration
active_domain(mapf).

% Type Declaration
object_type(agent).
object_type(wall).

% Role Declaration
type_role(agent,start).
type_role(agent,end).

type_role(wall,cell).


% Agent Property Declaration
% type_property(ObjectType,PropertyName,PropertyValue,Requirement)
% type_property(agent,direction,int,required).
% type_property(agent,speed,int,required).
% type_property(agent,dep,int,required).
% type_property(agent,arr,int,required).