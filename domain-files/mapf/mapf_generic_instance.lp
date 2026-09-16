% ###########################################
% Objects
% ###########################################

object(agent(1),agent).
object(agent(2),agent).
object(agent(3),agent).
object(agent(4),agent).
object(agent(5),agent).
object(agent(6),agent).
object(agent(7),agent).
object(agent(8),agent).
object(agent(9),agent).

% ###########################################
% Agent properties
% property(ObjectName,PropertyName,Value)
% ###########################################

property(agent(1),label,"1").
property(agent(2),label,"2").
property(agent(3),label,"3").
property(agent(4),label,"4").
property(agent(5),label,"5").
property(agent(6),label,"6").
property(agent(7),label,"7").
property(agent(8),label,"8").
property(agent(9),label,"9").

% ###########################################
%  start positions
% ###########################################

position((1,3),start,agent(1)).
position((4,17),start,agent(2)).
position((7,6),start,agent(3)).
position((2,14),start,agent(4)).
position((11,2),start,agent(5)).
position((15,18),start,agent(6)).
position((19,5),start,agent(7)).
position((6,12),start,agent(8)).
position((13,20),start,agent(9)).


% ###########################################
% end positions
% ###########################################

position((18,16),end,agent(1)).
position((10,4),end,agent(2)).
position((16,9),end,agent(3)).
position((20,1),end,agent(4)).
position((3,19),end,agent(5)).
position((8,7),end,agent(6)).
position((14,13),end,agent(7)).
position((5,0),end,agent(8)).
position((17,15),end,agent(9)).


% ###########################################
% grid coordinates
% ###########################################

node((R,C)) :-
    Rmax = #max { RR : position((RR,_),_,_) },
    Cmax = #max { CC : position((_,CC),_,_) },
    R = 0..Rmax,
    C = 0..Cmax.