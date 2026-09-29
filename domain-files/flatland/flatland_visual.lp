#script (python)
import clingo
def sym_to_str(x):
  if(x.type)==clingo.SymbolType.Number:
    return x.number
  if (x.type)==clingo.SymbolType.Function:
    return x.name
  if (x.type)==clingo.SymbolType.String:
    return x.string
  return str(x)

def train_img_path(id,dir):
  id=sym_to_str(id)
  dir=sym_to_str(dir)
  return clingo.String(f"img/train_{dir}_{id}.png")
#end.

 % Images for the objects depending on their properties 
%  We derive image(...) atoms from object(...) atoms and their properties

% image(Object,Role, ImagePath).
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Trains
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

image(train(T),start,@train_img_path(T,D)):-object(train(T),train),property(train(T),direction,D).


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Tracks
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Straight Tracks
image(X,cell,"img/straight_0.png"):-object(X,track),propeerty(X,code,32800).
image(X,cell,"img/straight_90.png"):-object(X,track),property(X,code,1025).

% Simple switches
image(X,cell,"img/simple_switch_0.png"):-object(X,track),property(X,code,37408).
image(X,cell,"img/simple_switch_90.png"):-object(X,track),property(X,code,17411).
image(X,cell,"img/simple_switch_180.png"):-object(X,track),property(X,code,32872).
image(X,cell,"img/simple_switch_270.png"):-object(X,track),property(X,code,3089).
image(X,cell,"img/simple_switch_mirrored_0.png"):-object(X,track),property(X,code,49186).
image(X,cell,"img/simple_switch_mirrored_90.png"):-object(X,track),property(X,code,1097).
image(X,cell,"img/simple_switch_mirrored_180.png"):-object(X,track),property(X,code,34864).
image(X,cell,"img/simple_switch_mirrored_270.png"):-object(X,track),property(X,code,5633).

% Diamond crossing
image(X,cell,"img/diamond_crossing_0.png"):-object(X,track),property(X,code,33825).

% Single-slip switch
image(X,cell,"img/single_slip_0.png"):-object(X,track),property(X,code,38433).
image(X,cell,"img/single_slip_90.png"):-object(X,track),property(X,code,50211).
image(X,cell,"img/single_slip_180.png"):-object(X,track),property(X,code,33897).
image(X,cell,"img/single_slip_270.png"):-object(X,track),property(X,code,35889).

% Double-slip switch
image(X,cell,"img/double_slip_0.png"):-object(X,track),property(X,code,38505).
image(X,cell,"img/double_slip_90.png"):-object(X,track),property(X,code,52275).

% Symmetrical switch
image(X,cell,"img/symmetrical_0.png"):-object(X,track),property(X,code,20994).
image(X,cell,"img/symmetrical_90.png"):-object(X,track),property(X,code,16458).
image(X,cell,"img/symmetrical_180.png"):-object(X,track),property(X,code,2136).
image(X,cell,"img/symmetrical_270.png"):-object(X,track),property(X,code,6672).

% Turn
image(X,cell,"img/turn_0.png"):-object(X,track),property(X,code,4608).
image(X,cell,"img/turn_90.png"):-object(X,track),property(X,code,16386).
image(X,cell,"img/turn_180.png"):-object(X,track),property(X,code,72).
image(X,cell,"img/turn_270.png"):-object(X,track),property(X,code,2064).

% Dead end
image(X,cell,"img/dead_end_0.png"):-object(X,track),property(X,code,8192).
image(X,cell,"img/dead_end_90.png"):-object(X,track),property(X,code,4).
image(X,cell,"img/dead_end_180.png"):-object(X,track),property(X,code,128).
image(X,cell,"img/dead_end_270.png"):-object(X,track),property(X,code,256).



label(train(ID),ID,corner) :- object(train(ID),train).



visual(O,cell,1,"fill","1","none",true) :- object(O,track).

visual(O,start,20,"contain","1","none",true) :- object(O,train).

visual(O,end,20,"contain","1","none",false) :- object(O,train).
