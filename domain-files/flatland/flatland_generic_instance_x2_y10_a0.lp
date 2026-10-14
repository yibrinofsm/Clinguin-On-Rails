
% ============================================================
% FILE: flatland_generic_instance_x2_y10_a0.lp
% ============================================================

% % ##########################################################
% % Generic Flatland instance using object/2, property/3,
% This file defines a Flatland instance using our generic ASP representation
% % ##########################################################

% % ----------------------------------------------------------
% % Objects
% % ----------------------------------------------------------

% % % Train
object(train(0),train).

% % % Tracks
% object(track(0),track).
% object(track(16386),track).
object(track(1025),track).
% object(track(4608),track).
% object(track(38433),track).
% object(track(6672),track).
% object(track(72),track).
% object(track(3089),track).
% object(track(2064),track).

% % position((0,0),cell,track(1025)).
% % % ----------------------------------------------------------
% % % Properties
% % % property(Object, PropertyName, Value)
% % % ----------------------------------------------------------
property(track(1025),code,1025).
property(train(0),direction,n).

% property(train(0),dep,0).
% property(train(0),direction,w).
% property(train(0),arr,12).
% property(train(0),speed,1).


% % % ----------------------------------------------------------
% % % Track positions
% % % position((Row,Column), Role, Object)
% % % ----------------------------------------------------------

% % position((0,0),cell,track(0)).
% % position((0,1),cell,track(16386)).
% % position((0,2),cell,track(1025)).
% % position((0,3),cell,track(4608)).
% % position((0,2),cell,track(1025)).

% % position((1,0),cell,track(16386)).
% % position((1,1),cell,track(38433)).
% % position((1,2),cell,track(1025)).
% % position((1,3),cell,track(6672)).

position((2,0),cell,track(72)).
position((2,1),cell,track(3089)).
position((2,2),cell,track(1025)).
position((2,3),cell,track(2064)).


% % % ----------------------------------------------------------
% % % Train start and end positions
% % % ----------------------------------------------------------

% % position((0,2),start,train(0)).
% % % position((2,2),end,train(0)).



% % % ----------------------------------------------------------
% % % Generate all grid nodes
% % % ----------------------------------------------------------
% % node((R,C)):-Rmax=#max{RR:position((RR,_),_,_)},Cmax=#max{CC:position((_,CC),_,_)},R=0..Rmax,C=0..Cmax.
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
node((0,11)).
node((0,12)).
node((0,13)).
node((0,14)).
node((0,15)).
node((0,16)).
node((0,17)).
node((0,18)).
node((0,19)).
node((0,20)).
node((0,21)).
node((0,22)).


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
node((1,11)).
node((1,12)).
node((1,13)).
node((1,14)).
node((1,15)).
node((1,16)).
node((1,17)).
node((1,18)).
node((1,19)).
node((1,20)).
node((1,21)).
node((1,22)).


node((2,0)).
node((2,1)).
node((2,2)).
node((2,3)).
node((2,4)).
node((2,5)).
node((2,6)).
node((2,7)).
node((2,8)).
node((2,9)).
node((2,10)).
node((2,11)).
node((2,12)).
node((2,13)).
node((2,14)).
node((2,15)).
node((2,16)).
node((2,17)).
node((2,18)).
node((2,19)).
node((2,20)).
node((2,21)).
node((2,22)).


node((3,0)).
node((3,1)).
node((3,2)).
node((3,3)).
node((3,4)).
node((3,5)).
node((3,6)).
node((3,7)).
node((3,8)).
node((3,9)).
node((3,10)).
node((3,11)).
node((3,12)).
node((3,13)).
node((3,14)).
node((3,15)).
node((3,16)).
node((3,17)).
node((3,18)).
node((3,19)).
node((3,20)).
node((3,21)).
node((3,22)).




% % property(agent(1),label,"1").
% % object(agent(10),agent).
% % object(agent(11),agent).
% % object(agent(12),agent).
% % object(agent(13),agent).
% % object(agent(14),agent).
% % object(agent(15),agent).
% % object(agent(1),agent).
% % object(agent(2),agent).
% % object(agent(3),agent).
% % object(agent(4),agent).
% % object(agent(5),agent).
% % object(agent(6),agent).
% % object(agent(7),agent).
% % object(agent(8),agent).
% % object(agent(9),agent).