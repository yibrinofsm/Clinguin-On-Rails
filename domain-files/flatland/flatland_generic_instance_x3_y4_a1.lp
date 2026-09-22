% ##########################################################
% Generic Flatland instance using object/2, property/3,
% and position/3.
% ##########################################################

% ----------------------------------------------------------
% Objects
% ----------------------------------------------------------

% Train
object(train(0),train).

% Tracks
object(track(0),track).
object(track(16386),track).
object(track(1025),track).
object(track(4608),track).
object(track(38433),track).
object(track(6672),track).
object(track(72),track).
object(track(3089),track).
object(track(2064),track).


% ----------------------------------------------------------
% Properties
% property(Object, PropertyName, Value)
% ----------------------------------------------------------

property(train(0),dep,0).
property(train(0),direction,w).
property(train(0),arr,12).
property(train(0),speed,1).


% ----------------------------------------------------------
% Track positions
% position((Row,Column), Role, Object)
% ----------------------------------------------------------

position((0,0),cell,track(0)).
position((0,1),cell,track(16386)).
position((0,2),cell,track(1025)).
position((0,3),cell,track(4608)).

position((1,0),cell,track(16386)).
position((1,1),cell,track(38433)).
position((1,2),cell,track(1025)).
position((1,3),cell,track(6672)).

position((2,0),cell,track(72)).
position((2,1),cell,track(3089)).
position((2,2),cell,track(1025)).
position((2,3),cell,track(2064)).


% ----------------------------------------------------------
% Train start and end positions
% ----------------------------------------------------------

position((0,2),start,train(0)).
% position((2,2),end,train(0)).



% % ----------------------------------------------------------
% % Generate all grid nodes
% % ----------------------------------------------------------
node((R,C)):-Rmax=#max{RR:position((RR,_),_,_)},Cmax=#max{CC:position((_,CC),_,_)},R=0..Rmax,C=0..Cmax.
