% Defines the possible objects and properties


% Type Declarations

type_domain(track).
type_domain(train).

% Declare code propeerty
property_domain(track,code).

% Allowed Code 
property_domain(track,code,(32800;1025;37408;17411;32872;3089;49186;1097;34864;5633;33825;38433;50211;33897;35889;38505;52275;20994;16458;2136;6672;4608;16386;72;2064;8192;4;128;256)).

% Train property declaration
property_domain(train,direction,int,required).
property_domain(train,speed,int,required).
property_domain(train,dep,int,required).
property_domain(train,arr,int,required).


% Role Declaration
type_role(start;end;cell;current).
