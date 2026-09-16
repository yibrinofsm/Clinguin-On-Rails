% Grid C
% The incoming direction of a train determines  its valid outgoing movement.
%  We translate grid environments into alternative graph structures
% The graph contains non trivial cells from  the grid 
% edge the set of two cells such that both are connected in the direction d
% vertex- the set of each cell such that there is an edge between them
% two partial functions d and p

% Transition/2

transition(32800,(n,n)).
transition(32800,(s,s)).

transition(1025,(e,e)).
transition(1025,(w,w)).

% simple switch

transition(37408,(n,n))
transition(37408,(n,w))
transition(37408,(s,s))
transition(37408,(e,s))


transition(17411,(e,e))
transition(17411,(w,w))
transition(17411,(w,s))
transition(17411,(n,e))

transition(32872,(n,n))
transition(17411,(s,s))
transition(17411,(s,e))
transition(17411,(w,n))


transition(3089,(s,w))
transition(3089,(w,w))
transition(3089,(e,e))
transition(3089,(e,n))

