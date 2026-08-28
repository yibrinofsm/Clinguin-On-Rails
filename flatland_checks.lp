% % #####################################
% % integrity constraints
% % #####################################

% % Every train must have exactly one start position.
% :-object(T,train),#count {N:position(T,start,N)}!=1.

% % Every train must have exactly one end/target position.
% :-object(T,train),#count {N:position(T,end,N)}!=1.

% % Every train must have exactly one initial direction.
% :-object(T,train),#count{D:property(T,direction,D)}!=1.

% % % Direction must be valid.
% % :- train_direction(T,D),not direction(D).

% % Rail Cell
% rail_cell(N,R):-object(track(K),track),position(track(K),R,N),K!=0.
% % position(track(0),cell,N):-node(N), object(track(0),track), not position(_,_,N).

% % Train start must be on a rail cell.
% :-object(T,train),position(T,start,N),not rail_cell(N,_).

% % Train end must be on a rail cell.
% :-object(T,train),position(T,end,N),not rail_cell(N,_).



% occupied_by_other(N) :- position(O,_,N),O != track(0).

% 1 {position(track(0),cell,N):node(N),not occupied_by_other(N)} 1 :-object(track(0),track).

% % Train start must be associated with exactly one city.
% % :-object(T,train),property(T,(position,start),N),#count{C:object(C,city),at(N,C)}!=1.

% % Train end must be associated with exactly one city.
% % :-object(T,train),property(T,(position,end),N),#count{C:object(C,city),at(N,C)}!=1.

% % It is not the case that a train starts and ends in the same city.
% % :-object(T,train),property(T,(position,start),N1),property(T,(position,end),N2),object(C,city),at(N1,C),at(N2,C)

