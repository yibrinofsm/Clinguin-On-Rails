% FLATLAND DOMAIN
#defined image/3.
#defined rejection/5.

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


% track1
% object(track(1025),track).


% object(track1,track).
% property(track1,code,1025).

% object(track2,track).
% property(track2,code,1025).



% trak2 
% type_domain(track). 
% type_domain(train).

% property_domain(track, code, (0;1023,,,,,,,)).

% Role

% type_role(R):-position(_,R,_).
% type_role(R):-image(_,R_).

% Type
% type_domain(T):-object(_,T).

role(O,R):-object(O,_),image(O,R,_).
role(O,R):-object(O,_),position(_,R,O).

rejection(create,O,T,object_term,"This object already exists. Choose another object identifier.") :-object(O,T), request(create,O,_).




issue(O,error,property(arr),"Arrival must be greater than departure.") :- object(O,train),property(O,dep,D),property(O,arr,A),A<=D.

issue(O,error,position(end),"Start and end must be different nodes.") :- object(O,train),position(N,start,O),position(N,end,O).
issue(O,warning,property(K),"A required property is missing.") :- object(O,_),property_schema(O,K,_,true),not property(O,K,_).

issue(O,warning,position(R),"A required position is missing.") :- object(O,_),role(O,R,_,Min,_),Min>0,Min>#count{N:position(N,R,O)}.

issue(O,error,support(R,S),"This position has no non-placeholder supporting object.") :- object(O,_),position(N,R,O),support(O,R,S),0=#count{Other,OtherRole:position(N,OtherRole,Other),role(Other,OtherRole,S,_,_),not placeholder(Other)}.




:- object(O,_),role(O,R,_,_,Max),Max>=0,Max<#count{N:position(N,R,O)}.

:- node(N),2<=#count{Code:position(N,cell,track(Code)),Code!=0}.

:- position(N,_,_),not node(N).

:- position(_,R,O),object(O,_),not role(O,R,_,_,_).

:- position(N,start,train(ID)),0=#count{Code:position(N,cell,track(Code)),Code!=0}.

:- position(N,end,train(ID)),0=#count{Code:position(N,cell,track(Code)),Code!=0}.
