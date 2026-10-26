% ============================================================
% FILE: flatland_sanity_check.lp
% ============================================================
%
% PURPOSE:
% This file contains rules that validate Flatland-specific
% instances 


% Trains require an existing track at the destination node.
type_placement_requirement(train,track).