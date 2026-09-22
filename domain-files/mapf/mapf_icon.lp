% Catalogue previews must be available before the first position is placed.
image(O,start,"img/agent.png") :- object(O,agent).
image(O,end,"img/rectangle.png") :- object(O,agent).
image(_,start,"img/agent.png")