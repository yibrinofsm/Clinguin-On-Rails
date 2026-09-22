
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
#defined rejection/5.

rejection(create,O,T,object_term,"This object already exists. Choose another object identifier.") :-object(O,T), request(create,O,_).

