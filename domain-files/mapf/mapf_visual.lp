% ============================================================
% FILE: mapf_visual.lp
% ============================================================

image(O,start,"img/agent.png") :- object(O,agent).
image(O,end,"img/rectangle.png") :- object(O,agent).
image(O,cell,"img/wall01_cell.png"):-object(O,wall).
