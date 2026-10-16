% ============================================================
% FILE: flatland_visual.lp
% ============================================================
%
% PURPOSE:
% This file contains Flatland-specific rules for assigning
% images to trains and railway tracks based on their
% properties in the generic domain representation.
%
% FUNCTIONALITY:
% 1. Generates train image paths based on train identifiers
%    and directions using an embedded Python function. ?
%
% 2. Assigns images to railway tracks according to their
%    Flatland transition codes.
%
% 3. Supports different track types and orientations,
%    including straight tracks, switches, crossings,
%    turns, and dead ends.
%
% 4. Derives image/3 atoms for visualizing Flatland
%    objects in the Clinguin UI.
%
% DEPENDENCIES:
%   object/2   - Identifies trains and tracks.
%   property/3 - Provides train directions and track codes.
%
% OUTPUT:
%   image(Object, Role, ImagePath)
%
% NOTE:
% These rules are specific to Flatland but use the generic
% object and property predicates. They derive image facts
% without modifying the underlying domain instance.
%
% ============================================================

% #script (python)
% import clingo

% def sym_to_str(x):
%     if x.type == clingo.SymbolType.Number:
%         return x.number
%     if x.type == clingo.SymbolType.Function:
%         return x.name
%     if x.type == clingo.SymbolType.String:
%         return x.string
%     return str(x)

% def train_img_path(id, direction):
%     id = sym_to_str(id)
%     direction = sym_to_str(direction)
%     return clingo.String(f"img/train_{direction}_{id}.png")
% #end.

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Trains
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% image(train(T),start,@train_img_path(T,D)):-object(train(T),train),property(train(T),direction,D).
% image(train(0),start,"img/train_e_0.png"):-object(train(0),train).
% image(train(1),start,"img/train_e_1.png"):-object(train(1),train).
% image(train(2),start,"img/train_e_2.png"):-object(train(2),train).

image(T,start,"img/train_e_0.png"):-object(T,train),property(T,direction,e).
image(T,start,"img/train_n_0.png"):-object(T,train),property(T,direction,n).
image(T,start,"img/train_s_0.png"):-object(T,train),property(T,direction,s).
image(T,start,"img/train_w_0.png"):-object(T,train),property(T,direction,w).


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Tracks
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Straight Tracks
image(X,cell,"img/straight_0.png"):-object(X,track),property(X,code,32800).

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

