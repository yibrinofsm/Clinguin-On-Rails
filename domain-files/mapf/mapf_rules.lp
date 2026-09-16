% MAPF DOMAIN RULES

#include "generic_rules.lp".
#include "editor_commands.lp".
#defined image/3.


role(O,start,origin,1,1) :- object(O,agent).

role(O,end,destination,1,1) :- object(O,agent).

visual(O,start,20,"contain","1","none",true) :- object(O,agent).

visual(O,end,10,"contain","1","none",false) :- object(O,agent).

label(agent(ID),ID,center) :- object(agent(ID),agent).

admissible(agent(ID),agent) :- object(agent(ID),_).

admissible(agent(ID),agent) :- request(_,agent(ID),_).

issue(O,error,position(end),"Start and end must be different nodes.") :- object(O,agent),position(N,start,O),position(N,end,O).

:- node(N),2<=#count{O:object(O,agent),position(N,start,O)}.

:- node(N),2<=#count{O:object(O,agent),position(N,end,O)}.
