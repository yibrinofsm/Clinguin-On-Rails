% ============================================================
% FILE: ui_notifications.lp
% ============================================================
%
% PURPOSE:
% Centralized notification component for the UI.
%
% SUPPORTED LEVELS:
%   info | success | warning | error
%
% FEATURES:
% 1. A single reusable notification container.
% 2. Automatic styling based on notification level.
% 3. Different background colors for each level.
% 4. Different borders, icons, and text colors.

%
% CONTEXT VARIABLES:
%   notice_level
%   notice_title
%   notice_message
%
% GENERIC EVENT:
%   notification_event(Element,Event,Level,Title,Message)

%
% ============================================================

% ============================================================
% 1. NOTIFICATION LEVELS
% ============================================================

notification_level(info;success;warning;error).

% ============================================================
% 2. NOTIFICATION STYLE CONFIGURATION
% ============================================================
%
% notification_style(
%     Level,
%     BackgroundColor,
%     BorderColor,
%     Icon,
%     IconColor,
%     TitleColor,
%     MessageColor
% ).
%
% ============================================================

% Information: Blue
notification_style(info,"#EFF6FF","#2563EB","fa-circle-info","#2563EB","#1E40AF","#1D4ED8").

% Success: Green
notification_style(success,"#F0FDF4","#16A34A","fa-circle-check","#16A34A","#166534","#15803D").

% Warning: Orange
notification_style(warning,"#FFFBEB","#D97706","fa-triangle-exclamation","#D97706","#92400E","#B45309").

% Error: Red
notification_style(error,"#FEE2E2","#DC2626","fa-circle-xmark","#DC2626","#991B1B","#B91C1C").

% ============================================================
% 3. NOTIFICATION CONTEXT STATE
% ============================================================

% A notification exists when its message is non-empty.
has_notification :- _clinguin_context(notice_message,M), M != "".

% Check whether a notification title exists.
has_notification_title :- has_notification, _clinguin_context(notice_title,T), T != "".

% Check whether a valid notification level exists.
has_valid_notification_level :- has_notification, _clinguin_context(notice_level,L), notification_level(L).

% Read the active notification level.
active_notification_level(L) :- has_notification, _clinguin_context(notice_level,L), notification_level(L).

% Default to information level.
active_notification_level(info) :- has_notification, not has_valid_notification_level.

% ============================================================
% 4. ACTIVE NOTIFICATION STYLE
% ============================================================

% Select styling based on the current notification level.
active_notification_style(L,BG,BC,I,IC,TC,MC) :- active_notification_level(L), notification_style(L,BG,BC,I,IC,TC,MC).

% ============================================================
% 5. NOTIFICATION CONTAINER
% ============================================================

% Always create the notification component.
elem(notification,container,w).

% ------------------------------------------------------------
% Visibility
% ------------------------------------------------------------

% Hide when no notification exists.
attr(notification,visibility,hidden) :- not has_notification.

% Show when a notification exists.
attr(notification,visibility,shown) :- has_notification.

% ------------------------------------------------------------
% Position
% ------------------------------------------------------------

attr(notification,"position","fixed").
attr(notification,"left","50%").
attr(notification,"bottom","20px").
attr(notification,"transform","translateX(-50%)").
attr(notification,"z-index","11000").

% ------------------------------------------------------------
% Dimensions
% ------------------------------------------------------------

attr(notification,"width","min(420px,calc(100vw - 32px))").
attr(notification,"box-sizing","border-box").

% ------------------------------------------------------------
% Background color
% ------------------------------------------------------------

% Default background.
attr(notification,background_color,"#FFFFFF") :- not has_notification.

% Automatically apply background based on notification level.
attr(notification,background_color,BG) :- active_notification_style(_,BG,_,_,_,_,_).

% ------------------------------------------------------------
% Border
% ------------------------------------------------------------

% Default border.
attr(notification,"border","1px solid #E2E8F0") :- not has_notification.

% Border for active notification.
attr(notification,"border",@concat("1px solid ",BC)) :- active_notification_style(_,_,BC,_,_,_,_).

% ------------------------------------------------------------
% Left border
% ------------------------------------------------------------

% Default left border.
attr(notification,"border-left","4px solid #2563EB") :- not has_notification.

% Level-specific left border.
attr(notification,"border-left",@concat("4px solid ",BC)) :- active_notification_style(_,_,BC,_,_,_,_).

% ------------------------------------------------------------
% General appearance
% ------------------------------------------------------------

attr(notification,"border-radius","12px").
attr(notification,"box-shadow","0 12px 32px rgba(15,23,42,0.18)").
attr(notification,class,("d-flex";"flex-row";"align-items-start";"gap-3";"p-3")).

% ============================================================
% 6. NOTIFICATION ICON
% ============================================================

elem(notification_icon,icon,notification).
attr(notification_icon,order,1).

% ------------------------------------------------------------
% Icon selection
% ------------------------------------------------------------

% Default icon.
attr(notification_icon,icon,"fa-circle-info") :- not has_notification.

% Notification-level icon.
attr(notification_icon,icon,I) :- active_notification_style(_,_,_,I,_,_,_).

% ------------------------------------------------------------
% Icon color
% ------------------------------------------------------------

% Default icon color.
attr(notification_icon,foreground_color,"#2563EB") :- not has_notification.

% Level-specific icon color.
attr(notification_icon,foreground_color,IC) :- active_notification_style(_,_,_,_,IC,_,_).

% ------------------------------------------------------------
% Icon layout
% ------------------------------------------------------------

attr(notification_icon,class,("mt-1";"flex-shrink-0")).

% ============================================================
% 7. NOTIFICATION TEXT CONTAINER
% ============================================================

elem(notification_text,container,notification).
attr(notification_text,order,2).
attr(notification_text,flex_direction,column).
attr(notification_text,class,("d-flex";"flex-column";"gap-1";"flex-grow-1")).
attr(notification_text,"min-width","0").

% ============================================================
% 8. NOTIFICATION TITLE
% ============================================================

elem(notification_title,label,notification_text).
attr(notification_title,order,1).

% ------------------------------------------------------------
% Title content
% ------------------------------------------------------------

% Default title.
attr(notification_title,label,"Notification") :- not has_notification_title.

% Context-driven title.
attr(notification_title,label,T) :- has_notification_title, _clinguin_context(notice_title,T), T != "".

% ------------------------------------------------------------
% Title styling
% ------------------------------------------------------------

attr(notification_title,class,("fw-bold";"m-0")).
attr(notification_title,"font-size","13px").

% ------------------------------------------------------------
% Title color
% ------------------------------------------------------------

% Default title color.
attr(notification_title,foreground_color,"#1E293B") :- not has_notification.

% Level-specific title color.
attr(notification_title,foreground_color,TC) :- active_notification_style(_,_,_,_,_,TC,_).

% ============================================================
% 9. NOTIFICATION MESSAGE
% ============================================================

elem(notification_message,label,notification_text).
attr(notification_message,order,2).

% ------------------------------------------------------------
% Message content
% ------------------------------------------------------------

% Default empty message.
attr(notification_message,label,"") :- not has_notification.

% Context-driven message.
attr(notification_message,label,M) :- has_notification, _clinguin_context(notice_message,M), M != "".

% ------------------------------------------------------------
% Message styling
% ------------------------------------------------------------

attr(notification_message,class,("text-wrap";"m-0")).
attr(notification_message,"font-size","11px").
attr(notification_message,"line-height","1.5").
attr(notification_message,"overflow-wrap","anywhere").

% ------------------------------------------------------------
% Message color
% ------------------------------------------------------------

% Default message color.
attr(notification_message,foreground_color,"#64748B") :- not has_notification.

% Level-specific message color.
attr(notification_message,foreground_color,MC) :- active_notification_style(_,_,_,_,_,_,MC).

% ============================================================
% 10. NOTIFICATION CLOSE BUTTON
% ============================================================

elem(notification_close,button,notification).
attr(notification_close,order,3).
attr(notification_close,icon,"fa-xmark").
attr(notification_close,label,"").

% ------------------------------------------------------------
% Close button styling
% ------------------------------------------------------------

attr(notification_close,class,("btn-light";"border-0";"rounded-circle";"p-1";"flex-shrink-0")).

% ------------------------------------------------------------
% Close button color
% ------------------------------------------------------------

% Default close button color.
attr(notification_close,foreground_color,"#64748B") :- not has_notification.

% Level-specific close button color.
attr(notification_close,foreground_color,IC) :- active_notification_style(_,_,_,_,IC,_,_).

% ------------------------------------------------------------
% Close button actions
% ------------------------------------------------------------

% Hide the notification immediately.
when(notification_close,click,update,(notification,visibility,hidden)).

% Clear notification context.
when(notification_close,click,context,(notice_message,"")).
when(notification_close,click,context,(notice_title,"")).
when(notification_close,click,context,(notice_level,info)).

% ============================================================
% 11. GENERIC NOTIFICATION EVENT HANDLING
% ============================================================
%
% PURPOSE:
% Allow any UI component to trigger a notification.
%
% Other files only need to define:
%
% notification_event(Element,Event,Level,Title,Message).
%
% The generic handlers automatically update:
% - Notification visibility
% - Title and message
% - Background color
% - Border color
% - Icon
% - Icon color
% - Title color
% - Message color
% - Close button color
%
% ============================================================

% ------------------------------------------------------------
% 11.1 Show notification
% ------------------------------------------------------------

when(E,Event,update,(notification,visibility,shown)) :- notification_event(E,Event,L,T,M), notification_level(L).

% ------------------------------------------------------------
% 11.2 Set notification title
% ------------------------------------------------------------

when(E,Event,update,(notification_title,label,T)) :- notification_event(E,Event,L,T,M), notification_level(L).

% ------------------------------------------------------------
% 11.3 Set notification message
% ------------------------------------------------------------

when(E,Event,update,(notification_message,label,M)) :- notification_event(E,Event,L,T,M), notification_level(L).

% ------------------------------------------------------------
% 11.4 Set notification background
% ------------------------------------------------------------
% IMPORTANT:
% Use background_color rather than "background".

when(E,Event,update,(notification,background_color,BG)) :- notification_event(E,Event,L,T,M), notification_style(L,BG,BC,I,IC,TC,MC).

% ------------------------------------------------------------
% 11.5 Set notification border
% ------------------------------------------------------------

when(E,Event,update,(notification,"border",@concat("1px solid ",BC))) :- notification_event(E,Event,L,T,M), notification_style(L,BG,BC,I,IC,TC,MC).

% ------------------------------------------------------------
% 11.6 Set notification left border
% ------------------------------------------------------------

when(E,Event,update,(notification,"border-left",@concat("4px solid ",BC))) :- notification_event(E,Event,L,T,M), notification_style(L,BG,BC,I,IC,TC,MC).

% ------------------------------------------------------------
% 11.7 Set notification icon
% ------------------------------------------------------------

when(E,Event,update,(notification_icon,icon,I)) :- notification_event(E,Event,L,T,M), notification_style(L,BG,BC,I,IC,TC,MC).

% ------------------------------------------------------------
% 11.8 Set notification icon color
% ------------------------------------------------------------

when(E,Event,update,(notification_icon,foreground_color,IC)) :- notification_event(E,Event,L,T,M), notification_style(L,BG,BC,I,IC,TC,MC).

% ------------------------------------------------------------
% 11.9 Set notification title color
% ------------------------------------------------------------

when(E,Event,update,(notification_title,foreground_color,TC)) :- notification_event(E,Event,L,T,M), notification_style(L,BG,BC,I,IC,TC,MC).

% ------------------------------------------------------------
% 11.10 Set notification message color
% ------------------------------------------------------------

when(E,Event,update,(notification_message,foreground_color,MC)) :- notification_event(E,Event,L,T,M), notification_style(L,BG,BC,I,IC,TC,MC).

% ------------------------------------------------------------
% 11.11 Set close button color
% ------------------------------------------------------------

when(E,Event,update,(notification_close,foreground_color,IC)) :- notification_event(E,Event,L,T,M), notification_style(L,BG,BC,I,IC,TC,MC).

% ============================================================
% 12. GENERIC NOTIFICATION CONTEXT UPDATES
% ============================================================
%
% PURPOSE:
% Synchronize the notification state with Clinguin context.
%
% This allows notification content and styling to be
% reconstructed when the UI is regenerated.
%
% ============================================================

% Set notification level.
when(E,Event,context,(notice_level,L)) :- notification_event(E,Event,L,T,M), notification_level(L).

% Set notification title.
when(E,Event,context,(notice_title,T)) :- notification_event(E,Event,L,T,M), notification_level(L).

% Set notification message.
when(E,Event,context,(notice_message,M)) :- notification_event(E,Event,L,T,M), notification_level(L).

