
% ##########################################################
% Generic Flatland instance using object/2,property/3,at/2.
% This represents a small environment

% ##########################################################
% ################################################
% Objects
%   - Train
%   - Tracks
% object(ObjectName,Type).
% We declare what the object is
% ################################################


% Trains
object(train(0),train).

% Tracks
object(track(0),track).
object(track(16386),track).
object(track(1025),track).
object(track(4608),track).

% property(track(0),type,0).

% icon(train(ID), „Train ID“):- object(train(ID),train).

object(track(38433),track).
object(track(6672),track).
object(track(72),track).
object(track(3089),track).
object(track(2064),track).

% property(track(1025),icon,"Vertical")

% Properties
% stores property of an object
% property(ObjectName,PropertyName,Value)

% - train
%    - Has start position  
%    - has earliest departure time  
%    - Has a direction   
%    - Has target position 
%    - has lattest arrival time
%    - Has a speed

% ###############################################

% initial position
% property(train(0),(position,start),(0,8)).

% earliest departure 
property(train(0),dep,0).

% direction
property(train(0),direction,w).

% property(train(0),label,"1").

% target position
% property(train(0),(position,end),(2,2)).

% Latest Arrival Time
property(train(0),arr,12).

% speed
property(train(0),speed,1).


% Valid track arrangement 
%  position(Node,Role,ObjectName)

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

position((0,2),start,train(0)).
position((5,10),cell,track(0)).

position((39,39),cell,track(1025)).

% position((3,3),cell,track(0)).
% position((9,9),cell,track(0)).



% Nodes

node((R,C)):-Rmax=#max{RR:position((RR,_),_,_)},Cmax=#max{CC:position((_,CC),_,_)},R=0..Rmax,C=0..Cmax.


% Basic Track Types

% track(0).
% track(1).
% track(2).
% track(3).
% track(4).
% track(5).
% track(6).
% track(8).
% track(9).

% position(2,1)

% What is the set of permitted transitions for the track type (2,90) located at position (2,1)?

% The track at cell c
% 2,1	​has type

% t(c2,1)=(2,90).

% Its transition relation is

% H(2,90)={(e,e),(w,w),(e,n),(s,w)}

% H(3,0)​={(e,e),(w,w),(e,s),(n,w),(w,n),(s,e)}


% (track(2),90).
% (track(2),180).
% (track(2),270).


% transitions
% {(e,e),(w,w),(e,n),(s,w)}


% :-cell(X,Y),cell(X',Y'),