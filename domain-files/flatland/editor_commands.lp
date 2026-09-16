
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
#defined object/2.
#defined property/3.
#defined position/3.
#defined node/1.
#defined role/5.
#defined property_schema/4.
#defined support/3.
#defined placeholder/1.
#defined request/3.
#defined admissible/2.
#defined rejection/5.

rejection(create,O,T,object_term,"This object already exists. Choose another object identifier.") :- request(create,O,T),object(O,_).

rejection(M,O,T,object_term,"This object identifier is not supported by the active domain.") :- request(M,O,T),not admissible(O,_),M!=create.

rejection(create,O,T,object_term,"This object identifier is not supported by the active domain.") :- request(create,O,T),not admissible(O,_),not object(O,_).

rejection(M,O,T,type_term,"The declared type does not match the object identifier.") :- request(M,O,T),admissible(O,_),not admissible(O,T),M!=create.

rejection(create,O,T,type_term,"The declared type does not match the object identifier.") :- request(create,O,T),admissible(O,_),not admissible(O,T),not object(O,_).

rejection(edit(Old),O,T,object_term,"The original object/type no longer exists. Reopen the inspector.") :- request(edit(Old),O,T),not object(O,Old).
