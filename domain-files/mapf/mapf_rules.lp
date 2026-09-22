% MAPF DOMAIN RULES

#defined image/3.

rejection(create,O,T,object_term,"This object already exists. Choose another object identifier.") :- request(create,O,T),object(O,_).

role(O,start,origin,1,1) :- object(O,agent).

role(O,end,destination,1,1) :- object(O,agent).

visual(O,start,20,"contain","1","none",true) :- object(O,agent).

visual(O,end,10,"contain","1","none",false) :- object(O,agent).

label(agent(ID),ID,center) :- object(agent(ID),agent).
issue(O,warning,property(K),"A required property is missing.") :- object(O,_),property_schema(O,K,_,true),not property(O,K,_).
issue(O,warning,start,"The agent has no start position.") :- object(O,_),not position(_,start,O).
issue(O,warning,start,"The agent has no end position.") :- object(O,_),not position(_,end,O).


issue(O,warning,position(R),"A required position is missing.") :- object(O,_),role(O,R,_,Min,_),Min>0,Min>#count{N:position(N,R,O)}.

issue(O,error,support(R,S),"This position has no non-placeholder supporting object.") :- object(O,_),position(N,R,O),support(O,R,S),0=#count{Other,OtherRole:position(N,OtherRole,Other),role(Other,OtherRole,S,_,_),not placeholder(Other)}.

:- position(N,_,_),not node(N).

:- position(_,R,O),object(O,_),not role(O,R,_,_,_).

:- object(O,_),role(O,R,_,_,Max),Max>=0,Max<#count{N:position(N,R,O)}.

issue(O,error,position(end),"Start and end must be different nodes.") :- object(O,agent),position(N,start,O),position(N,end,O).

:- node(N),2<=#count{O:object(O,agent),position(N,start,O)}.

:- node(N),2<=#count{O:object(O,agent),position(N,end,O)}.
