% ########################################################################

%  Flatlalnd->Generic Representation

%  Converts flatland facts into generic representation:

% Generic Output
% object/2,position/3,property/3

% clingo flatland_x80_y80_a1.lp flatland_to_generic.lp --models=1 --outf=2 > result.json

% jq -r  '.Call[].Witnesses[].Value[] | . + "."'  result.json   | sort  > flatland_generic_instance_x80_y80_a1.lp

% ########################################################################
% train(ID) -> object(train(ID),train)
object(train(ID),train):-train(ID). 

% each flatland track code becomes a generic track object 
% cell(_,K) -> object(track(K),track)
object(track(K),track):-cell(_,K),K!=0.


% Positions
% cell(Node,TrackCode) -> position(Node,cell,track(TrackCode))
position(N,cell,track(K)):-cell(N,K),K!=0.

% start positions
position(N,start,train(ID)):-train(ID),start(ID,N,_,_).
% end positions
position(N,end,train(ID)):-train(ID),end(ID,N,_).

% Properties
property(train(ID),direction,D):-train(ID),start(ID,_,_,D).
property(train(ID),dep,DEP):-train(ID),start(ID,_,DEP,_).
property(train(ID),arr,A):-train(ID),end(ID,N,A).
property(train(ID),speed,S):-train(ID),speed(ID,S).
node((R,C)):-Rmax=#max{RR:position((RR,_),_,_)},Cmax=#max{CC:position((_,CC),_,_)},R=0..Rmax,C=0..Cmax.

% Nodes
total_nodes(Count):-Count=#count{N:node((N))}.

% Track Nodes
track_nodes(Count):-Count=#count{N:position((N),cell,track(K)),k!=0}.

% Total Trains
total_trains(Count):-Count=#count{T:object(T,train)}.

% Height
height(H+1):-H=#max{RR:node((RR,_))}.

% Width
width(W+1):-W=#max{CC:node((_,CC))}.

% Temporary Stastics Atoms

stat(total_nodes,N) :-total_nodes(N).
stat(track_nodes,N) :-track_nodes(N).
stat(width,W) :-width(W).
stat(height,H) :-height(H).
stat(trains,N) :-total_trains(N).

% #####################################
% % Debug output
% #####################################

#show object/2.
#show position/3.
#show property/3.
#show node/1.
#show stat/2.

train(0). start(0,(7,9),0,s). end(0,(18,5),95). speed(0,4).

train(1). start(1,(18,6),2,n). end(1,(7,10),97). speed(1,4).

train(2). start(2,(18,6),5,n). end(2,(7,10),100). speed(2,4).

train(3). start(3,(7,7),38,n). end(3,(18,5),91). speed(3,1).

cell((0,0), 0).
cell((0,1), 0).

% % Option1
% object(train(ID),train):-train(ID).

% % train(T):-object(T,train).

% tracks