% ##########################################################
% Generic Flatland instance using object/2, property/3,
% and position/3.
% ##########################################################

% ----------------------------------------------------------
% Objects
% ----------------------------------------------------------

% % Train
% object(train(0),train).

% % Tracks
% object(track(0),track).
% object(track(16386),track).
% object(track(1025),track).
% object(track(4608),track).
% object(track(38433),track).
% object(track(6672),track).
% object(track(72),track).
% object(track(3089),track).
% object(track(2064),track).


% % ----------------------------------------------------------
% % Properties
% % property(Object, PropertyName, Value)
% % ----------------------------------------------------------

% property(train(0),dep,0).
% property(train(0),direction,w).
% property(train(0),arr,12).
% property(train(0),speed,1).


% % ----------------------------------------------------------
% % Track positions
% % position((Row,Column), Role, Object)
% % ----------------------------------------------------------

% position((0,0),cell,track(0)).
% position((0,1),cell,track(16386)).
% position((0,2),cell,track(1025)).
% position((0,3),cell,track(4608)).

% position((1,0),cell,track(16386)).
% position((1,1),cell,track(38433)).
% position((1,2),cell,track(1025)).
% position((1,3),cell,track(6672)).

% position((2,0),cell,track(72)).
% position((2,1),cell,track(3089)).
% position((2,2),cell,track(1025)).
% position((2,3),cell,track(2064)).


% % ----------------------------------------------------------
% % Train start and end positions
% % ----------------------------------------------------------

% position((0,2),start,train(0)).
% % position((2,2),end,train(0)).



% % ----------------------------------------------------------
% % Generate all grid nodes
% % ----------------------------------------------------------
% node((R,C)):-Rmax=#max{RR:position((RR,_),_,_)},Cmax=#max{CC:position((_,CC),_,_)},R=0..Rmax,C=0..Cmax.
node((0,0)).
node((0,1)).
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
node((0,2)).
node((0,3)).
node((0,4)).
node((0,5)).
node((0,6)).
node((0,7)).
node((0,8)).
node((0,9)).
node((1,0)).
node((10,0)).
node((10,1)).
node((10,10)).
node((10,11)).
node((10,12)).
node((10,13)).
node((10,14)).
node((10,15)).
node((10,16)).
node((10,17)).
node((10,18)).
node((10,19)).
node((10,2)).
node((10,3)).
node((10,4)).
node((10,5)).
node((10,6)).
node((10,7)).
node((10,8)).
node((10,9)).
node((1,1)).
node((1,10)).
node((11,0)).
node((1,11)).
node((11,1)).
node((11,10)).
node((11,11)).
node((11,12)).
node((11,13)).
node((11,14)).
node((11,15)).
node((11,16)).
node((11,17)).
node((11,18)).
node((11,19)).
node((1,12)).
node((11,2)).
node((1,13)).
node((11,3)).
node((1,14)).
node((11,4)).
node((1,15)).
node((11,5)).
node((1,16)).
node((11,6)).
node((1,17)).
node((11,7)).
node((1,18)).
node((11,8)).
node((1,19)).
node((11,9)).
node((1,2)).
node((12,0)).
node((12,1)).
node((12,10)).
node((12,11)).
node((12,12)).
node((12,13)).
node((12,14)).
node((12,15)).
node((12,16)).
node((12,17)).
node((12,18)).
node((12,19)).
node((12,2)).
node((12,3)).
node((12,4)).
node((12,5)).
node((12,6)).
node((12,7)).
node((12,8)).
node((12,9)).
node((1,3)).
node((13,0)).
node((13,1)).
node((13,10)).
node((13,11)).
node((13,12)).
node((13,13)).
node((13,14)).
node((13,15)).
node((13,16)).
node((13,17)).
node((13,18)).
node((13,19)).
node((13,2)).
node((13,3)).
node((13,4)).
node((13,5)).
node((13,6)).
node((13,7)).
node((13,8)).
node((13,9)).
node((1,4)).
node((14,0)).
node((14,1)).
node((14,10)).
node((14,11)).
node((14,12)).
node((14,13)).
node((14,14)).
node((14,15)).
node((14,16)).
node((14,17)).
node((14,18)).
node((14,19)).
node((14,2)).
node((14,3)).
node((14,4)).
node((14,5)).
node((14,6)).
node((14,7)).
node((14,8)).
node((14,9)).
node((1,5)).
node((15,0)).
node((15,1)).
node((15,10)).
node((15,11)).
node((15,12)).
node((15,13)).
node((15,14)).
node((15,15)).
node((15,16)).
node((15,17)).
node((15,18)).
node((15,19)).
node((15,2)).
node((15,3)).
node((15,4)).
node((15,5)).
node((15,6)).
node((15,7)).
node((15,8)).
node((15,9)).
node((1,6)).
node((16,0)).
node((16,1)).
node((16,10)).
node((16,11)).
node((16,12)).
node((16,13)).
node((16,14)).
node((16,15)).
node((16,16)).
node((16,17)).
node((16,18)).
node((16,19)).
node((16,2)).
node((16,3)).
node((16,4)).
node((16,5)).
node((16,6)).
node((16,7)).
node((16,8)).
node((16,9)).
node((1,7)).
node((17,0)).
node((17,1)).
node((17,10)).
node((17,11)).
node((17,12)).
node((17,13)).
node((17,14)).
node((17,15)).
node((17,16)).
node((17,17)).
node((17,18)).
node((17,19)).
node((17,2)).
node((17,3)).
node((17,4)).
node((17,5)).
node((17,6)).
node((17,7)).
node((17,8)).
node((17,9)).
node((1,8)).
node((18,0)).
node((18,1)).
node((18,10)).
node((18,11)).
node((18,12)).
node((18,13)).
node((18,14)).
node((18,15)).
node((18,16)).
node((18,17)).
node((18,18)).
node((18,19)).
node((18,2)).
node((18,3)).
node((18,4)).
node((18,5)).
node((18,6)).
node((18,7)).
node((18,8)).
node((18,9)).
node((1,9)).
node((19,0)).
node((19,1)).
node((19,10)).
node((19,11)).
node((19,12)).
node((19,13)).
node((19,14)).
node((19,15)).
node((19,16)).
node((19,17)).
node((19,18)).
node((19,19)).
node((19,2)).
node((19,3)).
node((19,4)).
node((19,5)).
node((19,6)).
node((19,7)).
node((19,8)).
node((19,9)).
node((2,0)).
node((20,0)).
node((20,1)).
node((20,10)).
node((20,11)).
node((20,12)).
node((20,13)).
node((20,14)).
node((20,15)).
node((20,16)).
node((20,17)).
node((20,18)).
node((20,19)).
node((20,2)).
node((20,3)).
node((20,4)).
node((20,5)).
node((20,6)).
node((20,7)).
node((20,8)).
node((20,9)).
node((2,1)).
node((2,10)).
node((21,0)).
node((2,11)).
node((21,1)).
node((21,10)).
node((21,11)).
node((21,12)).
node((21,13)).
node((21,14)).
node((21,15)).
node((21,16)).
node((21,17)).
node((21,18)).
node((21,19)).
node((2,12)).
node((21,2)).
node((2,13)).
node((21,3)).
node((2,14)).
node((21,4)).
node((2,15)).
node((21,5)).
node((2,16)).
node((21,6)).
node((2,17)).
node((21,7)).
node((2,18)).
node((21,8)).
node((2,19)).
node((21,9)).
node((2,2)).
node((22,0)).
node((22,1)).
node((22,10)).
node((22,11)).
node((22,12)).
node((22,13)).
node((22,14)).
node((22,15)).
node((22,16)).
node((22,17)).
node((22,18)).
node((22,19)).
node((22,2)).
node((22,3)).
node((22,4)).
node((22,5)).
node((22,6)).
node((22,7)).
node((22,8)).
node((22,9)).
node((2,3)).
node((23,0)).
node((23,1)).
node((23,10)).
node((23,11)).
node((23,12)).
node((23,13)).
node((23,14)).
node((23,15)).
node((23,16)).
node((23,17)).
node((23,18)).
node((23,19)).
node((23,2)).
node((23,3)).
node((23,4)).
node((23,5)).
node((23,6)).
node((23,7)).
node((23,8)).
node((23,9)).
node((2,4)).
node((24,0)).
node((24,1)).
node((24,10)).
node((24,11)).
node((24,12)).
node((24,13)).
node((24,14)).
node((24,15)).
node((24,16)).
node((24,17)).
node((24,18)).
node((24,19)).
node((24,2)).
node((24,3)).
node((24,4)).
node((24,5)).
node((24,6)).
node((24,7)).
node((24,8)).
node((24,9)).
node((2,5)).
node((25,0)).
node((25,1)).
node((25,10)).
node((25,11)).
node((25,12)).
node((25,13)).
node((25,14)).
node((25,15)).
node((25,16)).
node((25,17)).
node((25,18)).
node((25,19)).
node((25,2)).
node((25,3)).
node((25,4)).
node((25,5)).
node((25,6)).
node((25,7)).
node((25,8)).
node((25,9)).
node((2,6)).
node((26,0)).
node((26,1)).
node((26,10)).
node((26,11)).
node((26,12)).
node((26,13)).
node((26,14)).
node((26,15)).
node((26,16)).
node((26,17)).
node((26,18)).
node((26,19)).
node((26,2)).
node((26,3)).
node((26,4)).
node((26,5)).
node((26,6)).
node((26,7)).
node((26,8)).
node((26,9)).
node((2,7)).
node((27,0)).
node((27,1)).
node((27,10)).
node((27,11)).
node((27,12)).
node((27,13)).
node((27,14)).
node((27,15)).
node((27,16)).
node((27,17)).
node((27,18)).
node((27,19)).
node((27,2)).
node((27,3)).
node((27,4)).
node((27,5)).
node((27,6)).
node((27,7)).
node((27,8)).
node((27,9)).
node((2,8)).
node((28,0)).
node((28,1)).
node((28,10)).
node((28,11)).
node((28,12)).
node((28,13)).
node((28,14)).
node((28,15)).
node((28,16)).
node((28,17)).
node((28,18)).
node((28,19)).
node((28,2)).
node((28,3)).
node((28,4)).
node((28,5)).
node((28,6)).
node((28,7)).
node((28,8)).
node((28,9)).
node((2,9)).
node((29,0)).
node((29,1)).
node((29,10)).
node((29,11)).
node((29,12)).
node((29,13)).
node((29,14)).
node((29,15)).
node((29,16)).
node((29,17)).
node((29,18)).
node((29,19)).
node((29,2)).
node((29,3)).
node((29,4)).
node((29,5)).
node((29,6)).
node((29,7)).
node((29,8)).
node((29,9)).
node((3,0)).
node((3,1)).
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
node((3,2)).
node((3,3)).
node((3,4)).
node((3,5)).
node((3,6)).
node((3,7)).
node((3,8)).
node((3,9)).
node((4,0)).
node((4,1)).
node((4,10)).
node((4,11)).
node((4,12)).
node((4,13)).
node((4,14)).
node((4,15)).
node((4,16)).
node((4,17)).
node((4,18)).
node((4,19)).
node((4,2)).
node((4,3)).
node((4,4)).
node((4,5)).
node((4,6)).
node((4,7)).
node((4,8)).
node((4,9)).
node((5,0)).
node((5,1)).
node((5,10)).
node((5,11)).
node((5,12)).
node((5,13)).
node((5,14)).
node((5,15)).
node((5,16)).
node((5,17)).
node((5,18)).
node((5,19)).
node((5,2)).
node((5,3)).
node((5,4)).
node((5,5)).
node((5,6)).
node((5,7)).
node((5,8)).
node((5,9)).
node((6,0)).
node((6,1)).
node((6,10)).
node((6,11)).
node((6,12)).
node((6,13)).
node((6,14)).
node((6,15)).
node((6,16)).
node((6,17)).
node((6,18)).
node((6,19)).
node((6,2)).
node((6,3)).
node((6,4)).
node((6,5)).
node((6,6)).
node((6,7)).
node((6,8)).
node((6,9)).
node((7,0)).
node((7,1)).
node((7,10)).
node((7,11)).
node((7,12)).
node((7,13)).
node((7,14)).
node((7,15)).
node((7,16)).
node((7,17)).
node((7,18)).
node((7,19)).
node((7,2)).
node((7,3)).
node((7,4)).
node((7,5)).
node((7,6)).
node((7,7)).
node((7,8)).
node((7,9)).
node((8,0)).
node((8,1)).
node((8,10)).
node((8,11)).
node((8,12)).
node((8,13)).
node((8,14)).
node((8,15)).
node((8,16)).
node((8,17)).
node((8,18)).
node((8,19)).
node((8,2)).
node((8,3)).
node((8,4)).
node((8,5)).
node((8,6)).
node((8,7)).
node((8,8)).
node((8,9)).
node((9,0)).
node((9,1)).
node((9,10)).
node((9,11)).
node((9,12)).
node((9,13)).
node((9,14)).
node((9,15)).
node((9,16)).
node((9,17)).
node((9,18)).
node((9,19)).
node((9,2)).
node((9,3)).
node((9,4)).
node((9,5)).
node((9,6)).
node((9,7)).
node((9,8)).
node((9,9)).
% property(agent(1),label,"1").
