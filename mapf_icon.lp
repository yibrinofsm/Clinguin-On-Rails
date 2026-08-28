% image(Object,Imagepath)
% image(O,"img/agent.png"):-object(O,agent).
image(O,start,"img/agent.png"):-object(O,agent),position(_,start,O).
image(O,end,"img/rectangle.png"):-object(O,agent),position(_,end,O).