% ########################################################################
%  Converts generic object/property/at representation into Flatland facts:
% ########################################################################
% train(ID) :- object(train(ID),train).
% cell(N,Code) :- object(track(Code),track),at(N,track(Code)).
% start(ID,N,T,D):-object(train(ID),train),property(train(ID),(position,start),N),property(train(ID),dep,T),property(train(ID),direction,D).
% end(ID,N,A):-object(train(ID),train),property(train(ID),(position,end),N),property(train(ID),arr,A).
% speed(ID,S):-object(train(ID),train),property(train(ID),speed,S).



% % #####################################
% % % Debug output
% % #####################################

% #show train/1.
% #show start/4.
% #show end/3.
% #show speed/2.
% #show cell/2.

% position(N,cell,track(0)) :-node(N),
%     not position(N,cell,O1) : object(O1,track), O1 != track(0);
%     not position(N,start,O2) : object(O2,train).


% 40 by 40
% 1600 nodes
% nodes without track type 0

% position(N,cell,track(0)) :- node(N), not position(N,cell,O1) : object(O1,track), O1 != track(0); not position(N,start,O2) : object(O2,train).

:-node(N), position(N,cell,track(K1)),position(N,cell,track(K2)),K1!=K2.


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% TRAIN 
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

validation_error(flatland_missing_start,O,"train has no start position") :-object(O,train),not position(_,start,O).
validation_error(flatland_multiple_starts,O,"train has more than one start position") :-object(O,train),2 <= #count {Node :position(Node,start,O)}.


validation_error(flatland_missing_end,O,"train has no end/goal position") :-object(O,train),not position(_,end,O).

validation_error(flatland_multiple_ends,O,"train has more than one end/goal position") :-object(O,train),2 <= #count {Node :position(Node,end,O) }.


validation_error(flatland_same_start_end,O,"train start and goal must be different") :-object(O,train),position(Node,start,O),position(Node,end,O).


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% DEPARTURE
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

validation_error(flatland_missing_departure,O,"train has no earliest departure property") :-object(O,train),not property(O,dep,_).

validation_error(flatland_multiple_departures,O,"train has more than one departure value") :-object(O,train),property(O,dep,D1),property(O,dep,D2),D1 < D2.


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% DIRECTION
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

validation_error( flatland_missing_direction,O,"train has no initial direction") :-object(O,train),not property(O,direction,_).
validation_error(flatland_multiple_directions,O,"train has more than one initial direction") :-object(O,train),property(O,direction,D1),property(O,direction,D2),D1 < D2.


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% ARRIVAL
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

validation_error(flatland_missing_arrival,O,"train has no latest arrival property") :-object(O,train),not property(O,arr,_).
validation_error(flatland_multiple_arrivals,O,"train has more than one latest arrival value") :-object(O,train),property(O,arr,A1),property(O,arr,A2),A1 < A2.


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% TEMPORAL 
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

validation_error(flatland_invalid_time_window,O,"latest arrival must be greater than earliest departure") :-object(O,train),property(O,dep,Departure),property(O,arr,Arrival),Arrival <= Departure.


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% SPEED
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

validation_error(flatland_missing_speed,O,"train has no speed property") :-object(O,train),not property(O,speed,_).


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% TRACK 
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

validation_error(flatland_multiple_tracks,Node,"grid cell contains more than one track object") :-position(Node,cell,_),2 <= #count {O :position(Node,cell,O),object(O,track)}.

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% START 
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

validation_error(flatland_start_without_track,start(O,Node),"train start node has no track") :-object(O,train),position(Node,start,O),not position(Node,cell,_).
validation_error(flatland_end_without_track,end(O,Node),"train goal node has no track") :-object(O,train),position(Node,end,O),not position(Node,cell,_).


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% WARNINGS
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

validation_warning(flatland_missing_native_id,O,"generic train has no native Flatland ID") :-object(O,train),not native_train(O,_).
validation_warning(flatland_missing_native_code,O,"semantic track has no native Flatland code property") :-position(_,cell,O),object(O,track),property(O,base,_),not property(O,code,_).