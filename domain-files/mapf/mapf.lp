
% ============================================================
% FILE: mapf.lp
% ============================================================

#include "mapf_sanity_checks.lp". % Sanity checks, generates issue predicate to show in UI

#include "mapf_visual.lp". % Images for the objects depending on their properties

#include "mapf_domain.lp". % Defines the possible objects and properties
% some error or warnining:-not node(()).
% object alread added :-object(O,T), but if you try to request the same object
#include "mapf_generic_instance_x20_y20_a15.lp". % Contains generic instances of flatland domain.