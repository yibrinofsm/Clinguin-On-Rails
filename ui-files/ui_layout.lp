
% Workspace

elem(workspace,container,w).
attr(workspace,flex_direction,row).
attr(workspace,"flex-wrap","wrap").
attr(workspace,"align-items","stretch").
attr(workspace,"gap","12px").
attr(workspace,"padding","12px").
attr(workspace,"background","#eef2f7").
attr(workspace,"min-width","0").
attr(workspace,"box-sizing","border-box").

% Main Panel

elem(main_panel,container,workspace).
attr(main_panel,order,1).
attr(main_panel,"flex","8 1 900px").
attr(main_panel,"min-width","0").
attr(main_panel,"gap","10px").

% SideBar

elem(sidebar_panel,container,workspace).
attr(sidebar_panel,order,2).
attr(sidebar_panel,"flex","0 1 270px").
attr(sidebar_panel,"max-width","288px").
attr(sidebar_panel,"min-width","0").
attr(sidebar_panel,"background","white").
attr(sidebar_panel,"border","1px solid #dfe6ee").
attr(sidebar_panel,"border-radius","12px").
attr(sidebar_panel,"box-shadow","0 8px 24px #0f172a12").
attr(sidebar_panel,"overflow","hidden").
attr(sidebar_panel,"align-self","flex-start").

% Placement Panel
elem(placement_panel,container,main_panel).
attr(placement_panel,order,1).
attr(placement_panel,"gap","6px").
attr(placement_panel,"padding","9px 14px").
attr(placement_panel,"background","white").
attr(placement_panel,"border","1px solid #dfe6ee").
attr(placement_panel,"border-radius","12px").
attr(placement_panel,"box-shadow","0 6px 20px #0f172a0d").

elem(placement_header,container,placement_panel).
attr(placement_header,order,1).
attr(placement_header,flex_direction,row).
attr(placement_header,"align-items","center").
attr(placement_header,"justify-content","space-between").
attr(placement_header,"gap","12px").

elem(placement_title,label,placement_header).
attr(placement_title,order,1).
attr(placement_title,label,"Placement").
attr(placement_title,"font-size","14px").
attr(placement_title,"font-weight","700").
attr(placement_title,"color","#14263e").

elem(placement_step,label,placement_header).
attr(placement_step,order,2).
attr(placement_step,label,"01 Select  /  02 Choose role  /  03 Place").
attr(placement_step,"font-size","11px").
attr(placement_step,"color","#64748b").
attr(placement_step,"text-align","right").

elem(selection_empty,label,placement_panel) :- not _clinguin_context(selected_object,O):object(O,_).
attr(selection_empty,label,"Choose an object in the catalogue. Its placement controls will appear here.") :- elem(selection_empty,label,_).
elem(selection,container,placement_panel) :- _clinguin_context(selected_object,O),object(O,_).
elem(selection_name,label,selection_identity) :- _clinguin_context(selected_object,O),object(O,_).

attr(selection_name,label,@concat("",O)) :- _clinguin_context(selected_object,O),object(O,_).
elem(role_menu,dropdown_menu,role_control) :- _clinguin_context(selected_object,O),object(O,_).
attr(role_menu,selected,@concat("",R)) :- _clinguin_context(selected_object,O),object(O,_),_clinguin_context(placement_role,R),role(O,R,_,_,_).
attr(role_menu,selected,"Select a role") :- _clinguin_context(selected_object,O),object(O,_),not _clinguin_context(placement_role,R):role(O,R,_,_,_).
elem(role_item(R),dropdown_menu_item,role_menu) :- _clinguin_context(selected_object,O),object(O,_),role(O,R,_,_,_).
attr(role_item(R),label,@concat("",R)) :- _clinguin_context(selected_object,O),object(O,_),role(O,R,_,_,_).
when(role_item(R),click,context,(placement_role,R)) :- _clinguin_context(selected_object,O),object(O,_),role(O,R,_,_,_).
when(role_item(R),click,call,()) :- _clinguin_context(selected_object,O),object(O,_),role(O,R,_,_,_).
elem(unselect,button,selection) :- _clinguin_context(selected_object,O),object(O,_).
attr(unselect,label,"Unselect") :- _clinguin_context(selected_object,O),object(O,_).
when(unselect,click,context,(selected_object,none)) :- _clinguin_context(selected_object,O),object(O,_).
when(unselect,click,context,(placement_role,none)) :- _clinguin_context(selected_object,O),object(O,_).
when(unselect,click,context,(inspector_open,false)) :- _clinguin_context(selected_object,O),object(O,_).
when(unselect,click,context,(dialog,none)) :- _clinguin_context(selected_object,O),object(O,_).
when(unselect,click,call,()) :- _clinguin_context(selected_object,O),object(O,_).
elem(role_notice,label,role_notice_box) :- _clinguin_context(selected_object,O),object(O,_),not _clinguin_context(placement_role,R):role(O,R,_,_,_).
attr(role_notice,label,"Choose a placement role before clicking the grid.") :- elem(role_notice,label,_).

attr(selection,order,2) :- _clinguin_context(selected_object,O),object(O,_).
attr(selection,flex_direction,row) :- _clinguin_context(selected_object,O),object(O,_).
attr(selection,"gap","8px") :- _clinguin_context(selected_object,O),object(O,_).
attr(selection,"align-items","center") :- _clinguin_context(selected_object,O),object(O,_).
attr(selection,"flex-wrap","wrap") :- _clinguin_context(selected_object,O),object(O,_).
attr(selection,"min-width","0") :- _clinguin_context(selected_object,O),object(O,_).
elem(selection_identity,container,selection) :- _clinguin_context(selected_object,O),object(O,_).
attr(selection_identity,order,1) :- _clinguin_context(selected_object,O),object(O,_).
attr(selection_identity,"flex","1 1 140px") :- _clinguin_context(selected_object,O),object(O,_).
attr(selection_identity,"min-width","0") :- _clinguin_context(selected_object,O),object(O,_).
attr(selection_identity,"gap","3px") :- _clinguin_context(selected_object,O),object(O,_).
elem(selection_caption,label,selection_identity) :- _clinguin_context(selected_object,O),object(O,_).
attr(selection_caption,label,"SELECTED OBJECT") :- _clinguin_context(selected_object,O),object(O,_).
attr(selection_caption,order,1) :- _clinguin_context(selected_object,O),object(O,_).
attr(selection_caption,"font-size","10px") :- _clinguin_context(selected_object,O),object(O,_).
attr(selection_caption,"letter-spacing","1px") :- _clinguin_context(selected_object,O),object(O,_).
attr(selection_caption,"font-weight","700") :- _clinguin_context(selected_object,O),object(O,_).
attr(selection_caption,"color","#64748b") :- _clinguin_context(selected_object,O),object(O,_).
attr(selection_name,order,2) :- _clinguin_context(selected_object,O),object(O,_).
attr(selection_name,"font-size","15px") :- _clinguin_context(selected_object,O),object(O,_).
attr(selection_name,"font-weight","700") :- _clinguin_context(selected_object,O),object(O,_).
attr(selection_name,"color","#1e3a5f") :- _clinguin_context(selected_object,O),object(O,_).
attr(selection_name,"overflow-wrap","anywhere") :- _clinguin_context(selected_object,O),object(O,_).
elem(role_control,container,selection) :- _clinguin_context(selected_object,O),object(O,_).
attr(role_control,order,2) :- _clinguin_context(selected_object,O),object(O,_).
attr(role_control,"gap","4px") :- _clinguin_context(selected_object,O),object(O,_).
attr(role_control,"min-width","132px") :- _clinguin_context(selected_object,O),object(O,_).
elem(role_caption,label,role_control) :- _clinguin_context(selected_object,O),object(O,_).

attr(role_caption,label,"PLACEMENT ROLE") :- _clinguin_context(selected_object,O),object(O,_).
attr(role_caption,order,1) :- _clinguin_context(selected_object,O),object(O,_).
attr(role_caption,"font-size","10px") :- _clinguin_context(selected_object,O),object(O,_).
attr(role_caption,"letter-spacing","1px") :- _clinguin_context(selected_object,O),object(O,_).
attr(role_caption,"font-weight","700") :- _clinguin_context(selected_object,O),object(O,_).
attr(role_caption,"color","#64748b") :- _clinguin_context(selected_object,O),object(O,_).
attr(role_menu,order,2) :- _clinguin_context(selected_object,O),object(O,_).
attr(role_menu,class,("btn-outline-primary";"rounded-3")) :- _clinguin_context(selected_object,O),object(O,_).
attr(unselect,order,3) :- _clinguin_context(selected_object,O),object(O,_).
attr(unselect,class,"btn-outline-secondary") :- _clinguin_context(selected_object,O),object(O,_).
attr(selection_empty,order,2) :- elem(selection_empty,label,_).
attr(selection_empty,"font-size","13px") :- elem(selection_empty,label,_).
attr(selection_empty,"color","#64748b") :- elem(selection_empty,label,_).
attr(selection_empty,"line-height","1.6") :- elem(selection_empty,label,_).
attr(selection_empty,"padding","6px 0") :- elem(selection_empty,label,_).
attr(role_notice_box,order,3) :- elem(role_notice,label,_).
attr(role_notice,"font-size","12px") :- elem(role_notice,label,_).
attr(role_notice,"color","#9a6206") :- elem(role_notice,label,_).
attr(role_notice_box,"background","#fffbeb") :- elem(role_notice,label,_).
attr(role_notice_box,"border","1px solid #fde68a") :- elem(role_notice,label,_).
attr(role_notice_box,"border-radius","8px") :- elem(role_notice,label,_).
attr(role_notice_box,"padding","5px 10px") :- elem(role_notice,label,_).
% position(N,Role,O)
elem(placement_hint,label,placement_panel).
attr(placement_hint,label,"Click a grid cell to place. Your object stays selected until you click Unselect.").
attr(placement_hint,order,4).
attr(placement_hint,"font-size","11px").
attr(placement_hint,"color","#64748b").
attr(placement_hint,"line-height","1.5").
elem(grid_panel,container,main_panel) :- node((_,_)).
attr(grid_panel,order,2) :- node((_,_)).
attr(grid_panel,"min-width","0") :- node((_,_)).
attr(grid_panel,"overflow","hidden") :- node((_,_)).
attr(grid_panel,"background","#fff") :- node((_,_)).
attr(grid_panel,"border","1px solid #dfe6ee") :- node((_,_)).
attr(grid_panel,"border-radius","12px") :- node((_,_)).
attr(grid_panel,"box-shadow","0 10px 30px #0f172a12") :- node((_,_)).
elem(grid_header,container,grid_panel) :- node((_,_)).
attr(grid_header,order,1) :- node((_,_)).
attr(grid_header,flex_direction,row) :- node((_,_)).
attr(grid_header,"align-items","center") :- node((_,_)).
attr(grid_header,"justify-content","space-between") :- node((_,_)).
attr(grid_header,"gap","10px") :- node((_,_)).
attr(grid_header,"flex-wrap","wrap") :- node((_,_)).
attr(grid_header,"padding","12px 16px") :- node((_,_)).
elem(grid_title,label,grid_header) :- node((_,_)).
attr(grid_title,label,"Grid workspace") :- node((_,_)).
attr(grid_title,order,1) :- node((_,_)).
attr(grid_title,"font-size","15px") :- node((_,_)).
attr(grid_title,"font-weight","700") :- node((_,_)).
attr(grid_title,"color","#14263e") :- node((_,_)).
elem(grid_dimensions,label,grid_header) :- node((_,_)).
attr(grid_dimensions,order,2) :- node((_,_)).
attr(grid_dimensions,label,@concat(Rows," rows × ",Cols," columns · ",N," cells")) :- node((_,_)),Rows=#count{R:node((R,_))},Cols=#count{C:node((_,C))},N=#count{P:node(P)}.
attr(grid_dimensions,"font-size","11px") :- node((_,_)).
attr(grid_dimensions,"color","#64748b") :- node((_,_)).
attr(grid_viewport,order,3) :- node((_,_)).
attr(grid_viewport,"min-width","0") :- node((_,_)).
attr(grid_viewport,"height","clamp(600px,calc(100vh - 255px),1050px)") :- node((_,_)).
attr(grid_viewport,"overflow","auto") :- node((_,_)).
attr(grid_viewport,"padding","14px") :- node((_,_)).
attr(grid_viewport,"background","#edf1f6") :- node((_,_)).
attr(grid_viewport,"overscroll-behavior","contain") :- node((_,_)).
attr(grid_viewport,"scrollbar-gutter","stable") :- node((_,_)).
attr(grid_surface,"box-shadow","0 2px 8px #0f172a14") :- node((_,_)).
attr(grid_surface,"background","#e2e8f0") :- node((_,_)).
elem(grid_footer,container,grid_panel) :- node((_,_)).
attr(grid_footer,order,4) :- node((_,_)).
attr(grid_footer,flex_direction,row) :- node((_,_)).
attr(grid_footer,"padding","10px 18px") :- node((_,_)).
attr(grid_footer,"gap","12px") :- node((_,_)).
attr(grid_footer,"justify-content","space-between") :- node((_,_)).
attr(grid_footer,"flex-wrap","wrap") :- node((_,_)).
attr(grid_footer,"border-top","1px solid #e2e8f0") :- node((_,_)).
attr(grid_footer,"background","#fff") :- node((_,_)).
elem(grid_help,label,grid_footer) :- node((_,_)).
attr(grid_help,label,"Click to place · Click the same placement or right-click to delete") :- node((_,_)).
attr(grid_help,order,1) :- node((_,_)).
attr(grid_help,"font-size","11px") :- node((_,_)).
attr(grid_help,"color","#64748b") :- node((_,_)).
elem(grid_count,label,grid_footer) :- node((_,_)).
attr(grid_count,order,2) :- node((_,_)).
attr(grid_count,label,@concat(N," visible placements")) :- node((_,_)),N=#count{P,R,O:elem(placement(P,R,O),container,_),not placeholder(O)}.
attr(grid_count,"font-size","11px") :- node((_,_)).
attr(grid_count,"color","#475569") :- node((_,_)).
attr(grid_count,"font-weight","600") :- node((_,_)).
% Display preferences: direct context plus local CSS zoom.

elem(display_controls,container,grid_panel) :- node((_,_)).
elem(scale_caption,label,scale_controls) :- node((_,_)).
elem(scale_compact,button,scale_controls) :- node((_,_)).
when(scale_compact,click,context,(grid_scale,compact)) :- node((_,_)).
when(scale_compact,click,update,(grid_surface,zoom,"1")) :- node((_,_)).
elem(scale_normal,button,scale_controls) :- node((_,_)).
when(scale_normal,click,context,(grid_scale,normal)) :- node((_,_)).
when(scale_normal,click,update,(grid_surface,zoom,"1.2857142857")) :- node((_,_)).
elem(scale_large,button,scale_controls) :- node((_,_)).
when(scale_large,click,context,(grid_scale,large)) :- node((_,_)).
when(scale_large,click,update,(grid_surface,zoom,"1.7142857143")) :- node((_,_)).
elem(labels_explicit,button,label_controls) :- node((_,_)).
when(labels_explicit,click,context,(label_mode,explicit)) :- node((_,_)).
elem(labels_all,button,label_controls) :- node((_,_)).
when(labels_all,click,context,(label_mode,all)) :- node((_,_)).
elem(labels_off,button,label_controls) :- node((_,_)).
when(labels_off,click,context,(label_mode,off)) :- node((_,_)).

attr(display_controls,order,2) :- node((_,_)).
attr(display_controls,flex_direction,row) :- node((_,_)).
attr(display_controls,"flex-wrap","wrap") :- node((_,_)).
attr(display_controls,"gap","12px 24px") :- node((_,_)).
attr(display_controls,"align-items","center") :- node((_,_)).
attr(display_controls,"padding","10px 18px") :- node((_,_)).
attr(display_controls,"border-top","1px solid #edf1f5") :- node((_,_)).
attr(display_controls,"border-bottom","1px solid #e2e8f0") :- node((_,_)).
attr(display_controls,"background","#fbfcfe") :- node((_,_)).
elem(scale_controls,container,display_controls) :- node((_,_)).
attr(scale_controls,order,1) :- node((_,_)).
attr(scale_controls,flex_direction,row) :- node((_,_)).
attr(scale_controls,"gap","5px") :- node((_,_)).
attr(scale_controls,"align-items","center") :- node((_,_)).
attr(scale_controls,"flex-wrap","wrap") :- node((_,_)).
elem(label_controls,container,display_controls) :- node((_,_)).
attr(label_controls,order,2) :- node((_,_)).
attr(label_controls,flex_direction,row) :- node((_,_)).
attr(label_controls,"gap","5px") :- node((_,_)).
attr(label_controls,"align-items","center") :- node((_,_)).
attr(label_controls,"flex-wrap","wrap") :- node((_,_)).
attr(scale_caption,label,"Zoom") :- node((_,_)).
attr(scale_caption,order,0) :- node((_,_)).
attr(scale_caption,"font-size","12px") :- node((_,_)).
attr(scale_caption,"font-weight","650") :- node((_,_)).
attr(scale_caption,"color","#64748b") :- node((_,_)).
attr(scale_caption,"margin-right","5px") :- node((_,_)).
elem(label_caption,label,label_controls) :- node((_,_)).
attr(label_caption,label,"Labels") :- node((_,_)).
attr(label_caption,order,0) :- node((_,_)).
attr(label_caption,"font-size","12px") :- node((_,_)).
attr(label_caption,"font-weight","650") :- node((_,_)).
attr(label_caption,"color","#64748b") :- node((_,_)).
attr(label_caption,"margin-right","5px") :- node((_,_)).
attr(scale_compact,label,"28 px") :- node((_,_)).
attr(scale_compact,order,1) :- node((_,_)).
attr(scale_compact,class,("btn-outline-secondary";"px-2")) :- node((_,_)).
attr(scale_normal,label,"36 px") :- node((_,_)).
attr(scale_normal,order,2) :- node((_,_)).
attr(scale_normal,class,("btn-outline-secondary";"px-2")) :- node((_,_)).
attr(scale_large,label,"48 px") :- node((_,_)).
attr(scale_large,order,3) :- node((_,_)).
attr(scale_large,class,("btn-outline-secondary";"px-2")) :- node((_,_)).
attr(labels_explicit,label,"Object IDs") :- node((_,_)).
attr(labels_explicit,order,1) :- node((_,_)).
attr(labels_explicit,class,("btn-outline-secondary";"px-2")) :- node((_,_)).
attr(labels_all,label,"All") :- node((_,_)).
attr(labels_all,order,2) :- node((_,_)).
attr(labels_all,class,("btn-outline-secondary";"px-2")) :- node((_,_)).
attr(labels_off,label,"Off") :- node((_,_)).
attr(labels_off,order,3) :- node((_,_)).
attr(labels_off,class,("btn-outline-secondary";"px-2")) :- node((_,_)).
attr(scale_compact,"background","#e8efff") :- node((_,_)),not _clinguin_context(grid_scale,normal),not _clinguin_context(grid_scale,large).
attr(scale_compact,"color","#1d4ed8") :- node((_,_)),not _clinguin_context(grid_scale,normal),not _clinguin_context(grid_scale,large).
attr(scale_compact,"border-color","#93b4f8") :- node((_,_)),not _clinguin_context(grid_scale,normal),not _clinguin_context(grid_scale,large).
when(scale_compact,click,update,(scale_compact,"background","#e8efff")) :- node((_,_)).
when(scale_compact,click,update,(scale_compact,"color","#1d4ed8")) :- node((_,_)).
when(scale_compact,click,update,(scale_compact,"border-color","#93b4f8")) :- node((_,_)).
when(scale_compact,click,update,(scale_normal,"background","#ffffff")) :- node((_,_)).
when(scale_compact,click,update,(scale_normal,"color","#475569")) :- node((_,_)).
when(scale_compact,click,update,(scale_normal,"border-color","#cbd5e1")) :- node((_,_)).
when(scale_compact,click,update,(scale_large,"background","#ffffff")) :- node((_,_)).
when(scale_compact,click,update,(scale_large,"color","#475569")) :- node((_,_)).
when(scale_compact,click,update,(scale_large,"border-color","#cbd5e1")) :- node((_,_)).
attr(scale_normal,"background","#e8efff") :- node((_,_)),_clinguin_context(grid_scale,normal).
attr(scale_normal,"color","#1d4ed8") :- node((_,_)),_clinguin_context(grid_scale,normal).
attr(scale_normal,"border-color","#93b4f8") :- node((_,_)),_clinguin_context(grid_scale,normal).
when(scale_normal,click,update,(scale_compact,"background","#ffffff")) :- node((_,_)).
when(scale_normal,click,update,(scale_compact,"color","#475569")) :- node((_,_)).
when(scale_normal,click,update,(scale_compact,"border-color","#cbd5e1")) :- node((_,_)).
when(scale_normal,click,update,(scale_normal,"background","#e8efff")) :- node((_,_)).
when(scale_normal,click,update,(scale_normal,"color","#1d4ed8")) :- node((_,_)).
when(scale_normal,click,update,(scale_normal,"border-color","#93b4f8")) :- node((_,_)).
when(scale_normal,click,update,(scale_large,"background","#ffffff")) :- node((_,_)).
when(scale_normal,click,update,(scale_large,"color","#475569")) :- node((_,_)).
when(scale_normal,click,update,(scale_large,"border-color","#cbd5e1")) :- node((_,_)).
attr(scale_large,"background","#e8efff") :- node((_,_)),_clinguin_context(grid_scale,large).
attr(scale_large,"color","#1d4ed8") :- node((_,_)),_clinguin_context(grid_scale,large).
attr(scale_large,"border-color","#93b4f8") :- node((_,_)),_clinguin_context(grid_scale,large).
when(scale_large,click,update,(scale_compact,"background","#ffffff")) :- node((_,_)).
when(scale_large,click,update,(scale_compact,"color","#475569")) :- node((_,_)).
when(scale_large,click,update,(scale_compact,"border-color","#cbd5e1")) :- node((_,_)).
when(scale_large,click,update,(scale_normal,"background","#ffffff")) :- node((_,_)).
when(scale_large,click,update,(scale_normal,"color","#475569")) :- node((_,_)).
when(scale_large,click,update,(scale_normal,"border-color","#cbd5e1")) :- node((_,_)).
when(scale_large,click,update,(scale_large,"background","#e8efff")) :- node((_,_)).
when(scale_large,click,update,(scale_large,"color","#1d4ed8")) :- node((_,_)).
when(scale_large,click,update,(scale_large,"border-color","#93b4f8")) :- node((_,_)).
attr(labels_explicit,"background","#e8efff") :- node((_,_)),not _clinguin_context(label_mode,all),not _clinguin_context(label_mode,off).
attr(labels_explicit,"color","#1d4ed8") :- node((_,_)),not _clinguin_context(label_mode,all),not _clinguin_context(label_mode,off).
attr(labels_all,"background","#e8efff") :- node((_,_)),_clinguin_context(label_mode,all).
attr(labels_all,"color","#1d4ed8") :- node((_,_)),_clinguin_context(label_mode,all).
attr(labels_off,"background","#e8efff") :- node((_,_)),_clinguin_context(label_mode,off).
attr(labels_off,"color","#1d4ed8") :- node((_,_)),_clinguin_context(label_mode,off).
% Grid and visible placement elements. No visible_position helper.

elem(grid_viewport,container,grid_panel) :- node((_,_)).
elem(grid_surface,container,grid_viewport) :- node((_,_)).
attr(grid_surface,child_layout,absstatic) :- node((_,_)).
attr(grid_surface,"position","relative") :- node((_,_)).
attr(grid_surface,"isolation","isolate") :- node((_,_)).
attr(grid_surface,"line-height","0") :- node((_,_)).
attr(grid_surface,"margin","0") :- node((_,_)).
attr(grid_surface,"padding","0") :- node((_,_)).
attr(grid_surface,"flex-shrink","0") :- node((_,_)).
attr(grid_surface,width,(C-C0+1)*cell_size) :- node((_,_)),C=#max{X:node((_,X))},C0=#min{X:node((_,X))}.
attr(grid_surface,height,(R-R0+1)*cell_size) :- node((_,_)),R=#max{X:node((X,_))},R0=#min{X:node((X,_))}.
attr(grid_surface,"zoom","1.2857142857") :- node((_,_)),_clinguin_context(grid_scale,normal).
attr(grid_surface,"zoom","1.7142857143") :- node((_,_)),_clinguin_context(grid_scale,large).
attr(grid_surface,"zoom","1") :- node((_,_)),not _clinguin_context(grid_scale,normal),not _clinguin_context(grid_scale,large).
elem(node_box(Row,Col),container,grid_surface) :- node((Row,Col)).
elem(placement(N,R,O),container,node_box(Row,Col)) :- node((Row,Col)),N=(Row,Col),position(N,R,O),object(O,_),role(O,R,S,_,_),_clinguin_atom(position(N,R,O)),(R,O)=#max{(R2,O2):_clinguin_atom(position(N,R2,O2)),position(N,R2,O2),object(O2,_),role(O2,R2,S,_,_)}.
elem(placement(N,R,O),container,node_box(Row,Col)) :- node((Row,Col)),N=(Row,Col),position(N,R,O),object(O,_),role(O,R,S,_,_),0=#count{R2,O2:_clinguin_atom(position(N,R2,O2)),position(N,R2,O2),object(O2,_),role(O2,R2,S,_,_)}.
attr(placement(N,R,O),visibility,hidden) :- elem(placement(N,R,O),container,_),placeholder(O).
elem(node_image(N,R,O,I),canvas,placement(N,R,O)) :- elem(placement(N,R,O),container,_),not placeholder(O),image(O,R,I),I!="",I!=" ".
attr(node_image(N,R,O,I),image,I) :- elem(node_image(N,R,O,I),canvas,_).
attr(node_image(N,R,O,I),width,cell_size) :- elem(node_image(N,R,O,I),canvas,_).
attr(node_image(N,R,O,I),height,cell_size) :- elem(node_image(N,R,O,I),canvas,_).
attr(node_image(N,R,O,I),"display","block") :- elem(node_image(N,R,O,I),canvas,_).
attr(node_image(N,R,O,I),"padding","0") :- elem(node_image(N,R,O,I),canvas,_).
attr(node_image(N,R,O,I),"margin","0") :- elem(node_image(N,R,O,I),canvas,_).
attr(node_image(N,R,O,I),"pointer-events","none") :- elem(node_image(N,R,O,I),canvas,_).
attr(node_image(N,R,O,I),"object-fit",Fit) :- elem(node_image(N,R,O,I),canvas,_),visual(O,R,_,Fit,_,_,_).
elem(node_text(N,R,O),label,placement(N,R,O)) :- elem(placement(N,R,O),container,_),not placeholder(O),0=#count{I:image(O,R,I),I!="",I!=" "}.
attr(node_text(N,R,O),label,@concat("",L)) :- elem(node_text(N,R,O),label,_),label(O,L,_).
attr(node_text(N,R,O),label,@concat("",O)) :- elem(node_text(N,R,O),label,_),not label(O,_,_).
attr(node_text(N,R,O),"display","flex") :- elem(node_text(N,R,O),label,_).
attr(node_text(N,R,O),"align-items","center") :- elem(node_text(N,R,O),label,_).
attr(node_text(N,R,O),"justify-content","center") :- elem(node_text(N,R,O),label,_).
attr(node_text(N,R,O),"width","100%") :- elem(node_text(N,R,O),label,_).
attr(node_text(N,R,O),"height","100%") :- elem(node_text(N,R,O),label,_).
attr(node_text(N,R,O),"overflow","hidden") :- elem(node_text(N,R,O),label,_).
attr(node_text(N,R,O),"pointer-events","none") :- elem(node_text(N,R,O),label,_).
attr(node_text(N,R,O),"font","700 10px monospace") :- elem(node_text(N,R,O),label,_).
attr(node_text(N,R,O),"line-height","1") :- elem(node_text(N,R,O),label,_).
attr(node_text(N,R,O),"color","#1d4ed8") :- elem(node_text(N,R,O),label,_).

% Topmost image labels; explicit/all/off read directly from context.

elem(node_badge(N,R,O),label,badge_box(N,R,O)) :- elem(placement(N,R,O),container,_),not placeholder(O),visual(O,R,Z,_,_,_,_),Z=#max{Z2:elem(placement(N,R2,O2),container,_),visual(O2,R2,Z2,_,_,_,_)},image(O,R,I),I!="",I!=" ",label(O,_,_),not _clinguin_context(label_mode,off).
elem(node_badge(N,R,O),label,badge_box(N,R,O)) :- elem(placement(N,R,O),container,_),not placeholder(O),visual(O,R,Z,_,_,_,_),Z=#max{Z2:elem(placement(N,R2,O2),container,_),visual(O2,R2,Z2,_,_,_,_)},image(O,R,I),I!="",I!=" ",not label(O,_,_),_clinguin_context(label_mode,all).
attr(node_badge(N,R,O),label,@concat("",L)) :- elem(node_badge(N,R,O),label,_),label(O,L,_).
attr(node_badge(N,R,O),label,@concat("",O)) :- elem(node_badge(N,R,O),label,_),not label(O,_,_).
attr(badge_box(N,R,O),"position","absolute") :- elem(node_badge(N,R,O),label,_),label(O,_,center).
attr(badge_box(N,R,O),"left",@concat((cell_size-12)/2,"px")) :- elem(node_badge(N,R,O),label,_),label(O,_,center).
attr(badge_box(N,R,O),"top",@concat((cell_size-12)/2,"px")) :- elem(node_badge(N,R,O),label,_),label(O,_,center).
attr(badge_box(N,R,O),"width","12px") :- elem(node_badge(N,R,O),label,_),label(O,_,center).
attr(badge_box(N,R,O),"height","12px") :- elem(node_badge(N,R,O),label,_),label(O,_,center).
attr(node_badge(N,R,O),"color","#0f172a") :- elem(node_badge(N,R,O),label,_),label(O,_,center).
attr(node_badge(N,R,O),"font","bold 9px sans-serif") :- elem(node_badge(N,R,O),label,_),label(O,_,center).
attr(node_badge(N,R,O),"line-height","12px") :- elem(node_badge(N,R,O),label,_),label(O,_,center).
attr(node_badge(N,R,O),"text-align","center") :- elem(node_badge(N,R,O),label,_),label(O,_,center).
attr(badge_box(N,R,O),"pointer-events","none") :- elem(node_badge(N,R,O),label,_),label(O,_,center).
attr(badge_box(N,R,O),"z-index","100") :- elem(node_badge(N,R,O),label,_),label(O,_,center).
attr(badge_box(N,R,O),"position","absolute") :- elem(node_badge(N,R,O),label,_),not label(O,_,center).
attr(badge_box(N,R,O),"right","2px") :- elem(node_badge(N,R,O),label,_),not label(O,_,center).
attr(badge_box(N,R,O),"top","2px") :- elem(node_badge(N,R,O),label,_),not label(O,_,center).
attr(badge_box(N,R,O),"width","12px") :- elem(node_badge(N,R,O),label,_),not label(O,_,center).
attr(badge_box(N,R,O),"height","12px") :- elem(node_badge(N,R,O),label,_),not label(O,_,center).
attr(node_badge(N,R,O),"color","#0f172a") :- elem(node_badge(N,R,O),label,_),not label(O,_,center).
attr(node_badge(N,R,O),"font","bold 9px sans-serif") :- elem(node_badge(N,R,O),label,_),not label(O,_,center).
attr(node_badge(N,R,O),"line-height","12px") :- elem(node_badge(N,R,O),label,_),not label(O,_,center).
attr(node_badge(N,R,O),"text-align","center") :- elem(node_badge(N,R,O),label,_),not label(O,_,center).
attr(badge_box(N,R,O),"pointer-events","none") :- elem(node_badge(N,R,O),label,_),not label(O,_,center).
attr(badge_box(N,R,O),"z-index","100") :- elem(node_badge(N,R,O),label,_),not label(O,_,center).

% Direct placement and deletion. Context signals are native when/4 actions.
elem(no_grid,label,main_panel) :- not node((_,_)).
attr(no_grid,label,"No grid is loaded. Open a scenario containing grid nodes to begin.") :- not node((_,_)).
attr(no_grid,class,("p-5";"text-center";"text-muted")) :- not node((_,_)).
attr(no_grid,order,2) :- not node((_,_)).
% Native coordinates and dimensions avoid cssText resetting placement geometry.
attr(node_box(Row,Col),pos_x,(Col-C0)*cell_size) :- node((Row,Col)),C0=#min{X:node((_,X))}.
attr(node_box(Row,Col),pos_y,(Row-R0)*cell_size) :- node((Row,Col)),R0=#min{X:node((X,_))}.
attr(node_box(Row,Col),"position","absolute") :- node((Row,Col)).
attr(node_box(Row,Col),"left",@concat((Col-C0)*cell_size,"px")) :- node((Row,Col)),C0=#min{X:node((_,X))}.
attr(node_box(Row,Col),"top",@concat((Row-R0)*cell_size,"px")) :- node((Row,Col)),R0=#min{X:node((X,_))}.
attr(node_box(Row,Col),width,cell_size) :- node((Row,Col)).
attr(node_box(Row,Col),height,cell_size) :- node((Row,Col)).
attr(node_box(Row,Col),"margin","0") :- node((Row,Col)).
attr(node_box(Row,Col),"padding","0") :- node((Row,Col)).
attr(node_box(Row,Col),"border","0") :- node((Row,Col)).
attr(node_box(Row,Col),"outline","1px solid #d4dce6") :- node((Row,Col)).
attr(node_box(Row,Col),"outline-offset","-1px") :- node((Row,Col)).
attr(node_box(Row,Col),"box-sizing","border-box") :- node((Row,Col)).
attr(node_box(Row,Col),"overflow","hidden") :- node((Row,Col)).
attr(node_box(Row,Col),"isolation","isolate") :- node((Row,Col)).
attr(node_box(Row,Col),"cursor","pointer") :- node((Row,Col)).
attr(node_box(Row,Col),"background","#ffffff") :- node((Row,Col)).
% Highlight only empty cells with a valid add handler; preserve track images.
when(node_box(Row,Col),mouseenter,update,(node_box(Row,Col),"background","#eaf2ff")) :- node((Row,Col)),when(node_box(Row,Col),click,call,add_atom(_)).
when(node_box(Row,Col),mouseleave,update,(node_box(Row,Col),"background","#ffffff")) :- node((Row,Col)),when(node_box(Row,Col),click,call,add_atom(_)).

% Position a container, not both the label host and its internal paragraph.
elem(badge_box(N,R,O),container,placement(N,R,O)) :- elem(node_badge(N,R,O),label,_).
attr(node_badge(N,R,O),class,"text-center") :- elem(node_badge(N,R,O),label,_).
attr(role_item(R),order,N) :- elem(role_item(R),dropdown_menu_item,_),N=#count{Other:elem(role_item(Other),dropdown_menu_item,_),Other<R}.
elem(role_notice_box,container,placement_panel) :- elem(role_notice,label,_).
attr(role_notice,order,1) :- elem(role_notice,label,_).
attr(placement(N,R,O),"position","absolute") :- elem(placement(N,R,O),container,_).
attr(placement(N,R,O),"inset","0") :- elem(placement(N,R,O),container,_).
attr(placement(N,R,O),"padding","0") :- elem(placement(N,R,O),container,_).
attr(placement(N,R,O),"margin","0") :- elem(placement(N,R,O),container,_).
attr(placement(N,R,O),"pointer-events","none") :- elem(placement(N,R,O),container,_).
attr(placement(N,R,O),"transform-origin","center") :- elem(placement(N,R,O),container,_).
attr(placement(N,R,O),"z-index",Z) :- elem(placement(N,R,O),container,_),visual(O,R,Z,_,_,_,_).
attr(placement(N,R,O),"z-index",1) :- elem(placement(N,R,O),container,_),not visual(O,R,_,_,_,_,_).
attr(placement(N,R,O),"opacity",Opacity) :- elem(placement(N,R,O),container,_),visual(O,R,_,_,Opacity,_,_).
attr(placement(N,R,O),"transform",Transform) :- elem(placement(N,R,O),container,_),visual(O,R,_,_,_,Transform,_).
when(node_box(Row,Col),click,call,add_atom(position(N,R,O))) :- _clinguin_context(selected_object,O),object(O,_),_clinguin_context(placement_role,R),role(O,R,S,_,Max),not issue(O,error,_,_),not issue(O,warning,property(_),_),node((Row,Col)),N=(Row,Col),A=#count{Needed:support(O,R,Needed)},A=#count{Needed:support(O,R,Needed),elem(placement(N,Rd,Dep),container,_),role(Dep,Rd,Needed,_,_),not placeholder(Dep)},0=#count{OldRole,OldO:elem(placement(N,OldRole,OldO),container,_),role(OldO,OldRole,S,_,_),not placeholder(OldO)},not elem(placement(N,R,O),container,_),Max<0,not _clinguin_unsat.
when(node_box(Row,Col),click,call,add_atom(position(N,R,O))) :- _clinguin_context(selected_object,O),object(O,_),_clinguin_context(placement_role,R),role(O,R,S,_,Max),not issue(O,error,_,_),not issue(O,warning,property(_),_),node((Row,Col)),N=(Row,Col),A=#count{Needed:support(O,R,Needed)},A=#count{Needed:support(O,R,Needed),elem(placement(N,Rd,Dep),container,_),role(Dep,Rd,Needed,_,_),not placeholder(Dep)},0=#count{OldRole,OldO:elem(placement(N,OldRole,OldO),container,_),role(OldO,OldRole,S,_,_),not placeholder(OldO)},not elem(placement(N,R,O),container,_),Max>=0,Max>#count{Other:position(Other,R,O)},not _clinguin_unsat.
when(node_box(Row,Col),click,call,add_atom(position(N,R,O))) :- _clinguin_context(selected_object,O),object(O,_),_clinguin_context(placement_role,R),role(O,R,S,_,Max),not issue(O,error,_,_),not issue(O,warning,property(_),_),node((Row,Col)),N=(Row,Col),A=#count{Needed:support(O,R,Needed)},A=#count{Needed:support(O,R,Needed),elem(placement(N,Rd,Dep),container,_),role(Dep,Rd,Needed,_,_),not placeholder(Dep)},elem(placement(N,OldRole,OldO),container,_),role(OldO,OldRole,S,_,_),not _clinguin_atom(position(N,OldRole,OldO)),not placeholder(OldO),replaceable(OldO),(OldRole,OldO)!=(R,O),Max<0,not _clinguin_unsat.
when(node_box(Row,Col),click,call,add_atom(position(N,R,O))) :- _clinguin_context(selected_object,O),object(O,_),_clinguin_context(placement_role,R),role(O,R,S,_,Max),not issue(O,error,_,_),not issue(O,warning,property(_),_),node((Row,Col)),N=(Row,Col),A=#count{Needed:support(O,R,Needed)},A=#count{Needed:support(O,R,Needed),elem(placement(N,Rd,Dep),container,_),role(Dep,Rd,Needed,_,_),not placeholder(Dep)},elem(placement(N,OldRole,OldO),container,_),role(OldO,OldRole,S,_,_),not _clinguin_atom(position(N,OldRole,OldO)),not placeholder(OldO),replaceable(OldO),(OldRole,OldO)!=(R,O),Max>=0,Max>#count{Other:position(Other,R,O)},not _clinguin_unsat.
when(node_box(Row,Col),click,context,(selected_object,O)) :- when(node_box(Row,Col),click,call,add_atom(position(N,R,O))).
when(node_box(Row,Col),click,context,(placement_role,R)) :- when(node_box(Row,Col),click,call,add_atom(position(N,R,O))).
when(node_box(Row,Col),click,context,(inspector_open,false)) :- when(node_box(Row,Col),click,call,add_atom(position(N,R,O))).
when(node_box(Row,Col),click,context,(dialog,none)) :- when(node_box(Row,Col),click,call,add_atom(position(N,R,O))).
when(node_box(Row,Col),click,update,(local_feedback,visibility,hidden)) :- when(node_box(Row,Col),click,call,add_atom(position(N,R,O))).
when(node_box(Row,Col),click,update,(operation_status,label,"Placing…")) :- when(node_box(Row,Col),click,call,add_atom(position(N,R,O))).
elem(placement_preview(Row,Col),container,node_box(Row,Col)) :- _clinguin_context(selected_object,O),object(O,_),_clinguin_context(placement_role,R),role(O,R,S,_,Max),not issue(O,error,_,_),not issue(O,warning,property(_),_),node((Row,Col)).
attr(placement_preview(Row,Col),visibility,hidden) :- elem(placement_preview(Row,Col),container,_).
attr(placement_preview(Row,Col),"position","absolute") :- elem(placement_preview(Row,Col),container,_).
attr(placement_preview(Row,Col),"inset","0") :- elem(placement_preview(Row,Col),container,_).
attr(placement_preview(Row,Col),"padding","0") :- elem(placement_preview(Row,Col),container,_).
attr(placement_preview(Row,Col),"margin","0") :- elem(placement_preview(Row,Col),container,_).
attr(placement_preview(Row,Col),"pointer-events","none") :- elem(placement_preview(Row,Col),container,_).
attr(placement_preview(Row,Col),"z-index","1000") :- elem(placement_preview(Row,Col),container,_).
attr(placement_preview(Row,Col),width,cell_size) :- elem(placement_preview(Row,Col),container,_).
attr(placement_preview(Row,Col),height,cell_size) :- elem(placement_preview(Row,Col),container,_).
elem(placement_preview_image(Row,Col),canvas,placement_preview(Row,Col)) :- _clinguin_context(selected_object,O),object(O,_),_clinguin_context(placement_role,R),role(O,R,S,_,Max),not issue(O,error,_,_),not issue(O,warning,property(_),_),node((Row,Col)),image(O,R,I),I!="",I!=" ",I=#min{Path:image(O,R,Path),Path!="",Path!=" "}.
attr(placement_preview_image(Row,Col),image,I) :- _clinguin_context(selected_object,O),object(O,_),_clinguin_context(placement_role,R),role(O,R,S,_,Max),not issue(O,error,_,_),not issue(O,warning,property(_),_),node((Row,Col)),image(O,R,I),I!="",I!=" ",I=#min{Path:image(O,R,Path),Path!="",Path!=" "}.
attr(placement_preview_image(Row,Col),width,cell_size) :- elem(placement_preview_image(Row,Col),canvas,_).
attr(placement_preview_image(Row,Col),height,cell_size) :- elem(placement_preview_image(Row,Col),canvas,_).
attr(placement_preview_image(Row,Col),"pointer-events","none") :- elem(placement_preview_image(Row,Col),canvas,_).
elem(placement_preview_id_box(Row,Col),container,placement_preview(Row,Col)) :- _clinguin_context(selected_object,O),object(O,_),_clinguin_context(placement_role,R),role(O,R,S,_,Max),not issue(O,error,_,_),not issue(O,warning,property(_),_),node((Row,Col)),label(O,L,_),0<#count{I:image(O,R,I),I!="",I!=" "},not _clinguin_context(label_mode,off).
elem(placement_preview_id(Row,Col),label,placement_preview_id_box(Row,Col)) :- _clinguin_context(selected_object,O),object(O,_),_clinguin_context(placement_role,R),role(O,R,S,_,Max),not issue(O,error,_,_),not issue(O,warning,property(_),_),node((Row,Col)),label(O,L,_),0<#count{I:image(O,R,I),I!="",I!=" "},not _clinguin_context(label_mode,off).
attr(placement_preview_id(Row,Col),label,@concat("",L)) :- _clinguin_context(selected_object,O),object(O,_),_clinguin_context(placement_role,R),role(O,R,S,_,Max),not issue(O,error,_,_),not issue(O,warning,property(_),_),node((Row,Col)),label(O,L,_),0<#count{I:image(O,R,I),I!="",I!=" "},not _clinguin_context(label_mode,off).
attr(placement_preview_id_box(Row,Col),"position","absolute") :- elem(placement_preview_id_box(Row,Col),container,_).
attr(placement_preview_id_box(Row,Col),"left",@concat((cell_size-12)/2,"px")) :- elem(placement_preview_id_box(Row,Col),container,_),_clinguin_context(selected_object,O),label(O,_,center).
attr(placement_preview_id_box(Row,Col),"top",@concat((cell_size-12)/2,"px")) :- elem(placement_preview_id_box(Row,Col),container,_),_clinguin_context(selected_object,O),label(O,_,center).
attr(placement_preview_id_box(Row,Col),"top","2px") :- elem(placement_preview_id_box(Row,Col),container,_),_clinguin_context(selected_object,O),not label(O,_,center).
attr(placement_preview_id_box(Row,Col),"right","2px") :- elem(placement_preview_id_box(Row,Col),container,_),_clinguin_context(selected_object,O),not label(O,_,center).
attr(placement_preview_id_box(Row,Col),"width","12px") :- elem(placement_preview_id_box(Row,Col),container,_).
attr(placement_preview_id_box(Row,Col),"height","12px") :- elem(placement_preview_id_box(Row,Col),container,_).
attr(placement_preview_id_box(Row,Col),"pointer-events","none") :- elem(placement_preview_id_box(Row,Col),container,_).
attr(placement_preview_id_box(Row,Col),"justify-content","center") :- elem(placement_preview_id_box(Row,Col),container,_).
attr(placement_preview_id(Row,Col),class,"text-center") :- elem(placement_preview_id(Row,Col),label,_).
attr(placement_preview_id(Row,Col),"color","#0f172a") :- elem(placement_preview_id(Row,Col),label,_).
attr(placement_preview_id(Row,Col),"font","bold 9px sans-serif") :- elem(placement_preview_id(Row,Col),label,_).
elem(placement_preview_text(Row,Col),label,placement_preview(Row,Col)) :- _clinguin_context(selected_object,O),object(O,_),_clinguin_context(placement_role,R),role(O,R,S,_,Max),not issue(O,error,_,_),not issue(O,warning,property(_),_),node((Row,Col)),0=#count{I:image(O,R,I),I!="",I!=" "}.
attr(placement_preview_text(Row,Col),label,@concat("",O)) :- not label(O,_,_), _clinguin_context(selected_object,O),object(O,_),_clinguin_context(placement_role,R),role(O,R,S,_,Max),not issue(O,error,_,_),not issue(O,warning,property(_),_),node((Row,Col)),0=#count{I:image(O,R,I),I!="",I!=" "}.
attr(placement_preview_text(Row,Col),"font-size","9px") :- elem(placement_preview_text(Row,Col),label,_).
attr(placement_preview_text(Row,Col),"pointer-events","none") :- elem(placement_preview_text(Row,Col),label,_).
when(node_box(Row,Col),click,update,(placement_preview(Row,Col),visibility,shown)) :- when(node_box(Row,Col),click,call,add_atom(position(N,R,O))).
when(node_box(Row,Col),right_click,context,(delete_position,position(N,R,O))) :- node((Row,Col)),N=(Row,Col),elem(placement(N,R,O),container,_),_clinguin_atom(position(N,R,O)),(R,O)=#max{(R2,O2):elem(placement(N,R2,O2),container,_),_clinguin_atom(position(N,R2,O2))}.
when(node_box(Row,Col),click,context,(delete_position,position(N,R,O))) :- node((Row,Col)),N=(Row,Col),elem(placement(N,R,O),container,_),_clinguin_atom(position(N,R,O)),(R,O)=#max{(R2,O2):elem(placement(N,R2,O2),container,_),_clinguin_atom(position(N,R2,O2))},not _clinguin_context(selected_object,Chosen):object(Chosen,_).
when(node_box(Row,Col),click,context,(delete_position,position(N,R,O))) :- node((Row,Col)),N=(Row,Col),_clinguin_context(selected_object,O),_clinguin_context(placement_role,R),elem(placement(N,R,O),container,_),_clinguin_atom(position(N,R,O)),not when(node_box(Row,Col),click,call,add_atom(_)).
when(node_box(Row,Col),click,update,(local_feedback,visibility,shown)) :- _clinguin_context(selected_object,O),object(O,_),_clinguin_context(placement_role,R),role(O,R,S,_,Max),not issue(O,error,_,_),not issue(O,warning,property(_),_),node((Row,Col)),N=(Row,Col),not when(node_box(Row,Col),click,context,(delete_position,_)),support(O,R,Needed),0=#count{Dep,Rd:elem(placement(N,Rd,Dep),container,_),role(Dep,Rd,Needed,_,_),not placeholder(Dep)},not _clinguin_unsat.
when(node_box(Row,Col),click,update,(local_title,label,"Placement blocked")) :- _clinguin_context(selected_object,O),object(O,_),_clinguin_context(placement_role,R),role(O,R,S,_,Max),not issue(O,error,_,_),not issue(O,warning,property(_),_),node((Row,Col)),N=(Row,Col),not when(node_box(Row,Col),click,context,(delete_position,_)),support(O,R,Needed),0=#count{Dep,Rd:elem(placement(N,Rd,Dep),container,_),role(Dep,Rd,Needed,_,_),not placeholder(Dep)},not _clinguin_unsat.
when(node_box(Row,Col),click,update,(local_detail,label,"A required supporting object is missing at this node.")) :- _clinguin_context(selected_object,O),object(O,_),_clinguin_context(placement_role,R),role(O,R,S,_,Max),not issue(O,error,_,_),not issue(O,warning,property(_),_),node((Row,Col)),N=(Row,Col),not when(node_box(Row,Col),click,context,(delete_position,_)),support(O,R,Needed),0=#count{Dep,Rd:elem(placement(N,Rd,Dep),container,_),role(Dep,Rd,Needed,_,_),not placeholder(Dep)},not _clinguin_unsat.
when(node_box(Row,Col),click,update,(local_feedback,visibility,shown)) :- _clinguin_context(selected_object,O),object(O,_),_clinguin_context(placement_role,R),role(O,R,S,_,Max),not issue(O,error,_,_),not issue(O,warning,property(_),_),node((Row,Col)),N=(Row,Col),A=#count{Needed:support(O,R,Needed)},A=#count{Needed:support(O,R,Needed),elem(placement(N,Rd,Dep),container,_),role(Dep,Rd,Needed,_,_),not placeholder(Dep)},not when(node_box(Row,Col),click,context,(delete_position,_)),Max>=0,Max<=#count{Other:position(Other,R,O)},not elem(placement(N,R,O),container,_),not _clinguin_unsat.
when(node_box(Row,Col),click,update,(local_title,label,"Position limit reached")) :- _clinguin_context(selected_object,O),object(O,_),_clinguin_context(placement_role,R),role(O,R,S,_,Max),not issue(O,error,_,_),not issue(O,warning,property(_),_),node((Row,Col)),N=(Row,Col),A=#count{Needed:support(O,R,Needed)},A=#count{Needed:support(O,R,Needed),elem(placement(N,Rd,Dep),container,_),role(Dep,Rd,Needed,_,_),not placeholder(Dep)},not when(node_box(Row,Col),click,context,(delete_position,_)),Max>=0,Max<=#count{Other:position(Other,R,O)},not elem(placement(N,R,O),container,_),not _clinguin_unsat.
when(node_box(Row,Col),click,update,(local_detail,label,"This role already has its maximum positions. Choose another role or move an existing position.")) :- _clinguin_context(selected_object,O),object(O,_),_clinguin_context(placement_role,R),role(O,R,S,_,Max),not issue(O,error,_,_),not issue(O,warning,property(_),_),node((Row,Col)),N=(Row,Col),A=#count{Needed:support(O,R,Needed)},A=#count{Needed:support(O,R,Needed),elem(placement(N,Rd,Dep),container,_),role(Dep,Rd,Needed,_,_),not placeholder(Dep)},not when(node_box(Row,Col),click,context,(delete_position,_)),Max>=0,Max<=#count{Other:position(Other,R,O)},not elem(placement(N,R,O),container,_),not _clinguin_unsat.
when(node_box(Row,Col),click,update,(local_feedback,visibility,shown)) :- _clinguin_context(selected_object,O),object(O,_),_clinguin_context(placement_role,R),role(O,R,S,_,Max),not issue(O,error,_,_),not issue(O,warning,property(_),_),node((Row,Col)),N=(Row,Col),A=#count{Needed:support(O,R,Needed)},A=#count{Needed:support(O,R,Needed),elem(placement(N,Rd,Dep),container,_),role(Dep,Rd,Needed,_,_),not placeholder(Dep)},not when(node_box(Row,Col),click,context,(delete_position,_)),elem(placement(N,OldRole,OldO),container,_),role(OldO,OldRole,S,_,_),not placeholder(OldO),(OldRole,OldO)!=(R,O),not when(node_box(Row,Col),click,call,add_atom(_)),Max<0,not _clinguin_unsat.
when(node_box(Row,Col),click,update,(local_feedback,visibility,shown)) :- _clinguin_context(selected_object,O),object(O,_),_clinguin_context(placement_role,R),role(O,R,S,_,Max),not issue(O,error,_,_),not issue(O,warning,property(_),_),node((Row,Col)),N=(Row,Col),A=#count{Needed:support(O,R,Needed)},A=#count{Needed:support(O,R,Needed),elem(placement(N,Rd,Dep),container,_),role(Dep,Rd,Needed,_,_),not placeholder(Dep)},not when(node_box(Row,Col),click,context,(delete_position,_)),elem(placement(N,OldRole,OldO),container,_),role(OldO,OldRole,S,_,_),not placeholder(OldO),(OldRole,OldO)!=(R,O),not when(node_box(Row,Col),click,call,add_atom(_)),Max>=0,Max>#count{Other:position(Other,R,O)},not _clinguin_unsat.
when(node_box(Row,Col),click,update,(local_title,label,"Slot occupied")) :- _clinguin_context(selected_object,O),object(O,_),_clinguin_context(placement_role,R),role(O,R,S,_,Max),not issue(O,error,_,_),not issue(O,warning,property(_),_),node((Row,Col)),N=(Row,Col),A=#count{Needed:support(O,R,Needed)},A=#count{Needed:support(O,R,Needed),elem(placement(N,Rd,Dep),container,_),role(Dep,Rd,Needed,_,_),not placeholder(Dep)},not when(node_box(Row,Col),click,context,(delete_position,_)),elem(placement(N,OldRole,OldO),container,_),role(OldO,OldRole,S,_,_),not placeholder(OldO),(OldRole,OldO)!=(R,O),not when(node_box(Row,Col),click,call,add_atom(_)),Max<0,not _clinguin_unsat.
when(node_box(Row,Col),click,update,(local_title,label,"Slot occupied")) :- _clinguin_context(selected_object,O),object(O,_),_clinguin_context(placement_role,R),role(O,R,S,_,Max),not issue(O,error,_,_),not issue(O,warning,property(_),_),node((Row,Col)),N=(Row,Col),A=#count{Needed:support(O,R,Needed)},A=#count{Needed:support(O,R,Needed),elem(placement(N,Rd,Dep),container,_),role(Dep,Rd,Needed,_,_),not placeholder(Dep)},not when(node_box(Row,Col),click,context,(delete_position,_)),elem(placement(N,OldRole,OldO),container,_),role(OldO,OldRole,S,_,_),not placeholder(OldO),(OldRole,OldO)!=(R,O),not when(node_box(Row,Col),click,call,add_atom(_)),Max>=0,Max>#count{Other:position(Other,R,O)},not _clinguin_unsat.
when(node_box(Row,Col),click,update,(local_detail,label,"Right-click the existing session placement to remove it, then place your selected object.")) :- _clinguin_context(selected_object,O),object(O,_),_clinguin_context(placement_role,R),role(O,R,S,_,Max),not issue(O,error,_,_),not issue(O,warning,property(_),_),node((Row,Col)),N=(Row,Col),A=#count{Needed:support(O,R,Needed)},A=#count{Needed:support(O,R,Needed),elem(placement(N,Rd,Dep),container,_),role(Dep,Rd,Needed,_,_),not placeholder(Dep)},not when(node_box(Row,Col),click,context,(delete_position,_)),elem(placement(N,OldRole,OldO),container,_),role(OldO,OldRole,S,_,_),not placeholder(OldO),(OldRole,OldO)!=(R,O),not when(node_box(Row,Col),click,call,add_atom(_)),Max<0,not _clinguin_unsat.
when(node_box(Row,Col),click,update,(local_detail,label,"Right-click the existing session placement to remove it, then place your selected object.")) :- _clinguin_context(selected_object,O),object(O,_),_clinguin_context(placement_role,R),role(O,R,S,_,Max),not issue(O,error,_,_),not issue(O,warning,property(_),_),node((Row,Col)),N=(Row,Col),A=#count{Needed:support(O,R,Needed)},A=#count{Needed:support(O,R,Needed),elem(placement(N,Rd,Dep),container,_),role(Dep,Rd,Needed,_,_),not placeholder(Dep)},not when(node_box(Row,Col),click,context,(delete_position,_)),elem(placement(N,OldRole,OldO),container,_),role(OldO,OldRole,S,_,_),not placeholder(OldO),(OldRole,OldO)!=(R,O),not when(node_box(Row,Col),click,call,add_atom(_)),Max>=0,Max>#count{Other:position(Other,R,O)},not _clinguin_unsat.
when(node_box(Row,Col),click,update,(local_feedback,visibility,shown)) :- _clinguin_context(selected_object,O),object(O,_),node((Row,Col)),0=#count{R:_clinguin_context(placement_role,R),role(O,R,_,_,_)},not when(node_box(Row,Col),click,context,(delete_position,_)),not _clinguin_unsat.
when(node_box(Row,Col),click,update,(local_title,label,"Choose a role")) :- _clinguin_context(selected_object,O),object(O,_),node((Row,Col)),0=#count{R:_clinguin_context(placement_role,R),role(O,R,_,_,_)},not when(node_box(Row,Col),click,context,(delete_position,_)),not _clinguin_unsat.
when(node_box(Row,Col),click,update,(local_detail,label,"Select a placement role first.")) :- _clinguin_context(selected_object,O),object(O,_),node((Row,Col)),0=#count{R:_clinguin_context(placement_role,R),role(O,R,_,_,_)},not when(node_box(Row,Col),click,context,(delete_position,_)),not _clinguin_unsat.
when(node_box(Row,Col),click,update,(local_feedback,visibility,shown)) :- _clinguin_context(selected_object,O),object(O,_),node((Row,Col)),issue(O,error,object_term,_),not when(node_box(Row,Col),click,context,(delete_position,_)),not _clinguin_unsat.
when(node_box(Row,Col),click,update,(local_title,label,"Invalid object")) :- _clinguin_context(selected_object,O),object(O,_),node((Row,Col)),issue(O,error,object_term,_),not when(node_box(Row,Col),click,context,(delete_position,_)),not _clinguin_unsat.
when(node_box(Row,Col),click,update,(local_detail,label,"Correct the object identifier or type before placing it.")) :- _clinguin_context(selected_object,O),object(O,_),node((Row,Col)),issue(O,error,object_term,_),not when(node_box(Row,Col),click,context,(delete_position,_)),not _clinguin_unsat.
when(node_box(Row,Col),click,update,(local_feedback,visibility,shown)) :- _clinguin_context(selected_object,O),object(O,_),node((Row,Col)),issue(O,error,type_term,_),not when(node_box(Row,Col),click,context,(delete_position,_)),not _clinguin_unsat.
when(node_box(Row,Col),click,update,(local_title,label,"Invalid object")) :- _clinguin_context(selected_object,O),object(O,_),node((Row,Col)),issue(O,error,type_term,_),not when(node_box(Row,Col),click,context,(delete_position,_)),not _clinguin_unsat.
when(node_box(Row,Col),click,update,(local_detail,label,"Correct the object identifier or type before placing it.")) :- _clinguin_context(selected_object,O),object(O,_),node((Row,Col)),issue(O,error,type_term,_),not when(node_box(Row,Col),click,context,(delete_position,_)),not _clinguin_unsat.
when(node_box(Row,Col),click,update,(local_feedback,visibility,shown)) :- node((Row,Col)),_clinguin_unsat,not when(node_box(Row,Col),click,context,(delete_position,_)).
when(node_box(Row,Col),click,update,(local_title,label,"Resolve the constraint error")) :- node((Row,Col)),_clinguin_unsat,not when(node_box(Row,Col),click,context,(delete_position,_)).
when(node_box(Row,Col),click,update,(local_detail,label,"Use Undo last change before adding another placement.")) :- node((Row,Col)),_clinguin_unsat,not when(node_box(Row,Col),click,context,(delete_position,_)).

% .
attr(placement_preview_text(Row,Col),label,@concat("",L)) :- elem(placement_preview_text(Row,Col),label,_),_clinguin_context(selected_object,O),label(O,L,_).
attr(placement_preview_text(Row,Col),"line-height","1") :- elem(placement_preview_text(Row,Col),label,_).
attr(placement_preview_text(Row,Col),class,"text-center") :- elem(placement_preview_text(Row,Col),label,_).
attr(placement_preview_image(Row,Col),"object-fit",Fit) :- elem(placement_preview_image(Row,Col),canvas,_),_clinguin_context(selected_object,O),_clinguin_context(placement_role,R),visual(O,R,_,Fit,_,_,_).
