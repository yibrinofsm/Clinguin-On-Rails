% FLATLAND DOMAIN
#include "generic_rules.lp".
#include "editor_commands.lp".
#defined image/3.

role(O,cell,infrastructure,0,-1) :- object(O,track).

role(O,start,mobile,1,1) :- object(O,train).

role(O,end,mobile,1,1) :- object(O,train).

property_schema(O,dep,int,true) :- object(O,train).

property_schema(O,direction,term,true) :- object(O,train).

property_schema(O,arr,int,true) :- object(O,train).

property_schema(O,speed,int,true) :- object(O,train).

support(O,start,infrastructure) :- object(O,train).

support(O,end,infrastructure) :- object(O,train).

placeholder(track(0)) :- object(track(0),track).

replaceable(track(0)) :- object(track(0),track).

label(train(ID),ID,corner) :- object(train(ID),train).

visual(O,cell,1,"fill","1","none",true) :- object(O,track).

visual(O,start,20,"contain","1","none",true) :- object(O,train).

visual(O,end,20,"contain","1","none",false) :- object(O,train).

admissible(track(0;4;72;128;256;1025;1097;2064;2136;3089;4608;5633;6672;8192;16386;16458;17411;20994;32800;32872;33825;33897;34864;35889;37408;38433;38505;49186;50211;52275),track).
% track1
% object(track(1025),track).


% object(track2,track).
% property(track1,code,1025).

% object(track1,track).
% property(track2,code,1025).

% trak2 
% type_domain(track). 
% type_domain(train).

% property_domain(track, code, (0;1023,,,,,,,)).


admissible(train(ID),train) :- object(train(ID),_).

admissible(train(ID),train) :- request(_,train(ID),_).

issue(O,error,property(arr),"Arrival must be greater than departure.") :- object(O,train),property(O,dep,D),property(O,arr,A),A<=D.

issue(O,error,position(end),"Start and end must be different nodes.") :- object(O,train),position(N,start,O),position(N,end,O).


:- node(N),2<=#count{Code:position(N,cell,track(Code)),Code!=0}.

:- position(N,start,train(ID)),0=#count{Code:position(N,cell,track(Code)),Code!=0}.

:- position(N,end,train(ID)),0=#count{Code:position(N,cell,track(Code)),Code!=0}.
