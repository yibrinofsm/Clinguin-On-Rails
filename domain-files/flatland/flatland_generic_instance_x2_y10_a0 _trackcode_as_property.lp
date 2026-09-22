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
object(track1,track).






object(track(0),track).
object(track0,track).


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
% % position((2,2),end,train(0)).



% % ----------------------------------------------------------
% % Generate all grid nodes
% % ----------------------------------------------------------
% node((R,C)):-Rmax=#max{RR:position((RR,_),_,_)},Cmax=#max{CC:position((_,CC),_,_)},R=0..Rmax,C=0..Cmax.
node((0,0)).
node((0,1)).
node((0,2)).
node((0,3)).
node((0,4)).
node((0,5)).
node((0,6)).
node((0,7)).
node((0,8)).
node((0,9)).
node((0,10)).

node((1,0)).
node((1,1)).
node((1,2)).
node((1,3)).
node((1,4)).
node((1,5)).
node((1,6)).
node((1,7)).
node((1,8)).
node((1,9)).
node((1,10)).
property(agent(1),label,"1").

% Trains
train0 = train(0).

% All Tracks
track0  = track(0).
track1  = track(32800).
track2  = track(1025).
track3  = track(37408).
track4  = track(17411).
track5  = track(32872).
track6  = track(3089).
track7  = track(49186).
track8  = track(1097).
track9  = track(34864).
track10 = track(5633).
track11 = track(33825).

% Single-slip switch

track12 = track(38433).
track13 = track(50211).
track14 = track(33897).
track15 = track(35889).

% Double-slip switch

track16 = track(38505).
track17 = track(52275).

% Symmetrical Switch

track18 = track(20994).
track19 = track(16458).
track20 = track(2136).
track21 = track(6672).

% Turn

track22 = track(4608).
track23 = track(16386).
track24 = track(72).
track25 = track(2064).

% Dead end

track26 = track(8192).
track27 = track(4).
track28 = track(128).
track29 = track(256).