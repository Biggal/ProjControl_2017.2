%  Nitin Skandan, 11-Aug-2011
% This function collects data from the GUI and passes to the model
% The editable portions are commented with %-NS- way
function [sys,x0,str,ts] = inpgui_sf(t,x,u,flag,Ts)
switch flag,
  case 0,
    [sys,x0,str,ts]=mdlInitializeSizes(Ts); 
  case 2,
    sys=mdlUpdate(t,x,u,Ts);
  case 3,
    sys = mdlOutputs(t,x,u); % Calculate outputs
  case { 1, 4, 9 },
     sys = [0 0 0 0 0 0 0 0 0 0] ;
  otherwise
    error(['Unhandled flag = ',num2str(flag)]);
end


function [sys,x0,str,ts]=mdlInitializeSizes(Ts)

% call simsizes for a sizes structure, fill it in and convert to a sizes array.
sizes = simsizes;

sizes.NumContStates  = 0;
sizes.NumDiscStates  = 1;
sizes.NumOutputs     = 11; %-NS Specify the number of outputs
sizes.NumInputs      = 0; %-NS Specify the number of inputs
sizes.DirFeedthrough = 0;
sizes.NumSampleTimes = 1;

sys = simsizes(sizes);
x0  = [0];
str = [];
ts  = [Ts 0];
% create the figure, if necessary
InpGUI;
% end mdlInitializeSizes

function sys=mdlUpdate(t,x,u,Ts)
fig = get_param(gcbh,'UserData');
sys=x;


function sys = mdlOutputs(t,x,u)
 fig = get_param(gcbh,'UserData') ;
 if ishandle(fig),
%     chnd = findobj(fig,'Tag','spd_edt') ;
    ud = get(fig,'UserData') ;
%     set(chnd,'String', num2str(ud.VehSpd)) ;     
    sys = [ud.tension ud.permax ud.permin ud.ampmax ud.ampmin ud.offset ud.mesh ud.waveform ud.start ud.input ud.output];
 else
     sys = [0 0 0 0 0 0 0 0 0 0] ;
 end
 
% end mdlOutputs

