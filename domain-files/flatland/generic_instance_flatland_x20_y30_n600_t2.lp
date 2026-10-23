
% ============================================================
% FILE: flatland_generic_x3_y4.lp
% ============================================================
%  This file defines a Flatland instance using our generic ASP representation
% ##########################################################
% Generic Flatland instance using node/1,object/2, property/3,
% Generic Flatland instance using object/2, property/3,
% and position/3.
% ##########################################################

% ----------------------------------------------------------
% Objects
% What object exist, and what kind of object is it
% object(ObjectName,ObjectType)
% ----------------------------------------------------------



% Train
object(train(0),train).
object(train(1),train).


% Tracks
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
% property(ObjectName, PropertyName, Value)
% What attribute does an object have, and what is its value?
% ----------------------------------------------------------


% Train Properties

% Train0
property(train(0),dep,0).
property(train(0),direction,1).
property(train(0),arr,12).
property(train(0),speed,1).
property(train(0),id,0).

% Train1
property(train(1),dep,0).
property(train(1),direction,0).
property(train(1),arr,12).
property(train(1),speed,1).
property(train(1),id,1).

% Track Properties
property(track(2064),code,2064).
property(track(4608),code,4608).
property(track(38433),code,38433).
property(track(6672),code,6672).
property(track(72),code,72).
property(track(3089),code,3089).
property(track(2064),code,2064).
property(track(16386),code,16386).
property(track(1025),code,1025).

% ----------------------------------------------------------
% Track positions
% position((Row,Column), Role, ObjectName)
% ----------------------------------------------------------

% position((0,0),cell,track(0)).
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
position((2,2),end,train(0)).



% % % ----------------------------------------------------------
% % % x and y dimension
% % % ----------------------------------------------------------
% row(0..19).
% col(0..29).

% % ---------- NODES----------
% node((R,C)) :- row(R), col(C).% % % ----------------------------------------------------------
