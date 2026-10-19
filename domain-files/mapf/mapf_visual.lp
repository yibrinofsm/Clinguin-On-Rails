% ============================================================
% FILE: mapf_visual.lp
% ============================================================

image(O,start,"img/agent_ start_marker.png") :- object(O,agent).
image(O,end,"img/agent_ goal_ marker.png") :- object(O,agent).
image(O,cell,"img/wall_obstackle.png"):-object(O,wall).

% Describe how wall objects should appear.
% property(O,render_mode,fill) :-object(O,wall).

% property(O,background_color,"black") :-object(O,wall).
