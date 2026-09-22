
#defined object/2.
#defined property/3.
#defined position/3.
#defined node/1.
#defined role/5.
#defined property_schema/4.
#defined support/3.
#defined placeholder/1.


issue(O,warning,property(K),"A required property is missing.") :- object(O,_),property_schema(O,K,_,true),not property(O,K,_).

issue(O,warning,position(R),"A required position is missing.") :- object(O,_),role(O,R,_,Min,_),Min>0,Min>#count{N:position(N,R,O)}.

issue(O,error,support(R,S),"This position has no non-placeholder supporting object.") :- object(O,_),position(N,R,O),support(O,R,S),0=#count{Other,OtherRole:position(N,OtherRole,Other),role(Other,OtherRole,S,_,_),not placeholder(Other)}.


:- position(N,_,_),not node(N).

:- position(_,R,O),object(O,_),not role(O,R,_,_,_).

:- object(O,_),role(O,R,_,_,Max),Max>=0,Max<#count{N:position(N,R,O)}.
