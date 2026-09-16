% ########################################################################

%  MAPF->Generic Representation

%  Converts MAPF facts into generic representation:

% Generic Output
% object/2,position/3,property/3

% clingo mapf_x20_y20_a15.lp mapf_to_generic.lp --models=1 --outf=2 > result.json

% jq -r  '.Call[].Witnesses[].Value[] | . + "."'  result.json   | sort  > mapf_generic_instance_x20_y20_a15.lp


% ########################################################################
% agent(ID) -> object(agent(ID),agent)
object(agent(ID),agent):-start(ID,_). 




% Positions

% start positions
position(N,start,agent(ID)):-start(ID,N).
% end positions
position(N,end,agent(ID)):-goal(ID,N).

% Properties
property(agent(ID),label,ID):-start(ID,_).
node((R,C)):-vertex((R,C)).

% Nodes
total_nodes(Count):-Count=#count{N:node((N))}.

% % Track Nodes
% track_nodes(Count):-Count=#count{N:position((N),cell,track(K)),k!=0}.

% Total Agents
total_agents(Count):-Count=#count{T:object(T,agent)}.

% Height
height(H+1):-H=#max{RR:node((RR,_))}.

% Width
width(W+1):-W=#max{CC:node((_,CC))}.

% Temporary Stastics Atoms

stat(total_nodes,N) :-total_nodes(N).
% stat(track_nodes,N) :-track_nodes(N).
stat(width,W) :-width(W).
stat(height,H) :-height(H).
stat(agents,N) :-total_agents(N).

% #####################################
% % Debug output
% #####################################

#show object/2.
#show position/3.
#show property/3.
#show node/1.
#show stat/2.

