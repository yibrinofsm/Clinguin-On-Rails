% ============================================================
% FILE: mapf_generic_instance_x20_y20_a15.lp
% Grid: 20 x 20, Agents: 15, Wall object: wall(1) at 60 positions
% All coordinates are (row, col)
% ============================================================

% ---------- AGENTS ----------
object(agent(1),agent).  object(agent(2),agent).  object(agent(3),agent).
object(agent(4),agent).  object(agent(5),agent).  object(agent(6),agent).
object(agent(7),agent).  object(agent(8),agent).  object(agent(9),agent).
object(agent(10),agent). object(agent(11),agent). object(agent(12),agent).
object(agent(13),agent). object(agent(14),agent). object(agent(15),agent).

property(agent(1),label,1).   property(agent(2),label,2).   property(agent(3),label,3).
property(agent(4),label,4).   property(agent(5),label,5).   property(agent(6),label,6).
property(agent(7),label,7).   property(agent(8),label,8).   property(agent(9),label,9).
property(agent(10),label,10). property(agent(11),label,11). property(agent(12),label,12).
property(agent(13),label,13). property(agent(14),label,14). property(agent(15),label,15).

% ---------- WALL OBJECT ----------
object(wall(1),wall).

% ---------- STARTS ----------
position((1,2),start,agent(1)).
position((2,18),start,agent(2)).
position((3,1),start,agent(3)).
position((4,10),start,agent(4)).
position((5,7),start,agent(5)).
position((6,15),start,agent(6)).
position((7,3),start,agent(7)).
position((8,20),start,agent(8)).
position((9,12),start,agent(9)).
position((10,5),start,agent(10)).
position((11,17),start,agent(11)).
position((12,8),start,agent(12)).
position((13,14),start,agent(13)).
position((14,1),start,agent(14)).
position((15,19),start,agent(15)).

% ---------- GOALS ----------
position((20,20),end,agent(1)).
position((19,1),end,agent(2)).
position((18,12),end,agent(3)).
position((17,6),end,agent(4)).
position((16,18),end,agent(5)).
position((15,3),end,agent(6)).
position((14,15),end,agent(7)).
position((13,9),end,agent(8)).
position((12,2),end,agent(9)).
position((11,20),end,agent(10)).
position((10,14),end,agent(11)).
position((9,4),end,agent(12)).
position((8,17),end,agent(13)).
position((7,11),end,agent(14)).
position((6,1),end,agent(15)).

% ---------- WALL POSITIONS (all occupied by wall(1), role = cell) ----------
position((1,5),cell,wall(1)).
position((1,9),cell,wall(1)).
position((1,14),cell,wall(1)).
position((1,18),cell,wall(1)).
position((2,3),cell,wall(1)).
position((2,7),cell,wall(1)).
position((2,12),cell,wall(1)).
position((2,16),cell,wall(1)).
position((3,6),cell,wall(1)).
position((3,11),cell,wall(1)).
position((3,15),cell,wall(1)).
position((3,19),cell,wall(1)).
position((4,2),cell,wall(1)).
position((4,8),cell,wall(1)).
position((4,13),cell,wall(1)).
position((4,17),cell,wall(1)).
position((5,4),cell,wall(1)).
position((5,11),cell,wall(1)).
position((5,16),cell,wall(1)).
position((5,20),cell,wall(1)).
position((6,6),cell,wall(1)).
position((6,10),cell,wall(1)).
position((6,13),cell,wall(1)).
position((6,18),cell,wall(1)).
position((7,8),cell,wall(1)).
position((7,15),cell,wall(1)).
position((7,19),cell,wall(1)).
position((7,5),cell,wall(1)).
position((8,3),cell,wall(1)).
position((8,10),cell,wall(1)).
position((8,14),cell,wall(1)).
position((8,18),cell,wall(1)).
position((9,6),cell,wall(1)).
position((9,9),cell,wall(1)).
position((9,16),cell,wall(1)).
position((9,19),cell,wall(1)).
position((10,2),cell,wall(1)).
position((10,8),cell,wall(1)).
position((10,12),cell,wall(1)).
position((10,17),cell,wall(1)).
position((11,4),cell,wall(1)).
position((11,9),cell,wall(1)).
position((11,13),cell,wall(1)).
position((11,18),cell,wall(1)).
position((12,5),cell,wall(1)).
position((12,11),cell,wall(1)).
position((12,16),cell,wall(1)).
position((12,19),cell,wall(1)).
position((13,3),cell,wall(1)).
position((13,7),cell,wall(1)).
position((13,12),cell,wall(1)).
position((13,17),cell,wall(1)).
position((14,6),cell,wall(1)).
position((14,10),cell,wall(1)).
position((14,14),cell,wall(1)).
position((14,18),cell,wall(1)).
position((15,8),cell,wall(1)).
position((15,12),cell,wall(1)).
position((15,16),cell,wall(1)).
position((15,20),cell,wall(1)).

% ---------- DOMAIN ----------
row(1..20).
col(1..20).

% ---------- FREE NODES----------
node((R,C)) :- row(R), col(C).