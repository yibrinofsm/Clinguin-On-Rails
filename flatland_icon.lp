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

% image(Object,Role, ImagePath).

image(train(T),start,@train_img_path(T,D)):-object(train(T),train),property(train(T),direction,D).
image(track(0),cell," "):-object(track(0),track).
image(track(32800),cell,"img/straight_0.png"):-object(track(32800),track).
image(track(1025),cell,"img/straight_90.png"):-object(track(1025),track).

image(track(37408),cell,"img/simple_switch_0.png"):-object(track(37408),track).
image(track(17411),cell,"img/simple_switch_90.png"):-object(track(17411),track).
image(track(32872),cell,"img/simple_switch_180.png"):-object(track(32872),track).
image(track(3089),cell,"img/simple_switch_270.png"):-object(track(3089),track).

image(track(49186),cell,"img/simple_switch_mirrored_0.png"):-object(track(49186),track).
image(track(1097),cell,"img/simple_switch_mirrored_90.png"):-object(track(1097),track).
image(track(34864),cell,"img/simple_switch_mirrored_180.png"):-object(track(34864),track).
image(track(5633),cell,"img/simple_switch_mirrored_270.png"):-object(track(5633),track).


image(track(33825),cell,"img/diamond_crossing_0.png"):-object(track(33825),track).


% Single-slip switch
image(track(38433),cell,"img/single_slip_0.png"):-object(track(38433),track).
image(track(50211),cell,"img/single_slip_90.png"):-object(track(50211),track).
image(track(33897),cell,"img/single_slip_180.png"):-object(track(33897),track).
image(track(35889),cell,"img/single_slip_270.png"):-object(track(35889),track).

% Double-slip switch
image(track(38505),cell,"img/double_slip_0.png"):-object(track(38505),track).
image(track(52275),cell,"img/double_slip_90.png"):-object(track(52275),track).

% Symmetrical Switch
image(track(20994),cell,"img/symmetrical_0.png"):-object(track(20994),track).
image(track(16458),cell,"img/symmetrical_90.png"):-object(track(16458),track).
image(track(2136),cell,"img/symmetrical_180.png"):-object(track(2136),track).
image(track(6672),cell,"img/symmetrical_270.png"):-object(track(6672),track).

% Turn
image(track(4608),cell,"img/turn_0.png"):-object(track(4608),track).
image(track(16386),cell,"img/turn_90.png"):-object(track(16386),track).
image(track(72),cell,"img/turn_180.png"):-object(track(72),track).
image(track(2064),cell,"img/turn_270.png"):-object(track(2064),track).

%  Dead end
image(track(8192),cell,"img/dead_end_0.png"):-object(track(8192),track).
image(track(4),cell,"img/dead_end_90.png"):-object(track(4),track).
image(track(128),cell,"img/dead_end_180.png"):-object(track(128),track).
image(track(256),cell,"img/dead_end_270.png"):-object(track(256),track).
