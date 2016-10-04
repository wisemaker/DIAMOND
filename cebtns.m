function cebtns
% Function: cebtns.m
% 
% Usage: cebtns
% 
% Description:
%    Initializes the Complex Exponential Window
%    Handles and graphics elements.
%    Returns a vector to those elements.
%
% Version SWD970804
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% This matlab source code was originally     %
% developed as part of "DIAMOND" at          %
% Los Alamos National Laboratory. It may     %
% be copied, modified, and distributed in    %
% any form, provided:                        %
%  a) This notice accompanies the files and  %
%     appears near the top of all source     %
%     code files.                            %
%  b) No payment or commercial services are  %
%     received in exchange for the code.     %
%                                            %
% Original copyright is reserved by the      %
% Regents of the University of California,   %
% in addition to Scott W. Doebling, Phillip  %
% J. Cornwell, Erik G. Straser, and Charles  %
% R. Farrar.                                 %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

global HANDLES

%====================================
% General buttons parameters
%====================================
top=.95;
left=.84;
btnwd=.15;
btnht=.06;
spacing=.01;

%====================================
% Set up the console frame
%=====================================
frmborder=0.01;
ypos=.05-frmborder;
frmpos=[left-frmborder ypos btnwd+2*frmborder .9+2*frmborder];
HANDLES.hceb(1)=uicontrol(HANDLES.hfigdmnd, ...
        'Style','Frame', ...
        'Position',frmpos, ...
        'BackgroundColor',[.5 .5 .5]);

%====================================
% Set up the axes
%====================================

HANDLES.hceb(16) = axes('position',[.1 .2 .7 .7]);

%====================================
% Set up the cursors
%====================================

HANDLES.hceb(12) = line([0 0],[0 0]);
HANDLES.hceb(13) = text(0,0,'');
HANDLES.hceb(14) = line([0 0],[0 0]);
HANDLES.hceb(15) = text(0,0,'');

%==================================
% Set up buttons
%==================================
%
% Plot tools button
%
btnnum=1;
ypos=top-(btnnum-1)*(btnht+spacing);
btnpos=[left ypos-btnht btnwd btnht];
HANDLES.hceb(2)=uicontrol(HANDLES.hfigdmnd, ...
      'style','push', ...
      'position',btnpos, ...
      'string','Plot Tools', ...
      'callback',['eval(get(hplttl(11),''call'')),',...
		'set(hplttl(1),''visible'',''on''), figure(hplttl(1))']);

%==================================
% Set up buttons
%==================================
%
% Run Complex Exponential Algorithm
%
btnnum=2.5;
ypos=top-(btnnum-1)*(btnht);
btnpos=[left ypos-btnht btnwd btnht];
HANDLES.hceb(3)=uicontrol(HANDLES.hfigdmnd, ...
 	'style','push', ...
	'unit','normalized', ...
	'position',btnpos, ...
	'visible','off', ...      
	'string','Run Comp Exp', ...
	'callback',[ ...
		'm=str2num(get(onHndlVector(5),''string''));', ...
                'delta_f = sp / (nlines-1);',...
                '[Y, this_lambda, freq_t, damp_t, fs_out,err] = ',...
                '       compexp(G,nlines,delta_f,f1,f2,fs,m,iref,iresp);', ...
                'if err==0,',...
                '  fprintf(1,''\n\nFreq (Hz):\n'');',...
                '  fprintf(1,''%10.5f\n'',freq_t);', ...
                '  fprintf(1,''\n\nDamp (%%):\n'');',...
                '  fprintf(1,''%10.5f\n'',damp_t*100);', ...
                'end']);

%
%  Order
%
btnnum=3.5;
ypos=top-(btnnum-1)*(btnht);
btnpos=[left ypos-btnht btnwd*.6 btnht];
HANDLES.hceb(4)=uicontrol(HANDLES.hfigdmnd, ...
      'style','text', ...
      'unit','normalized', ...
      'position',btnpos, ...
      'visible','off', ...      
      'string','Order');
btnpos=[left+.6*btnwd ypos-btnht btnwd*.4 btnht];
HANDLES.hceb(5)=uicontrol(HANDLES.hfigdmnd, ...
      'style','edit', ...
      'unit','normalized', ...
      'position',btnpos, ...
      'visible','off', ...      
      'string','?');

%
%  sliders
%

%
% Lower frequency
%
HANDLES.hceb(6) = uicontrol(HANDLES.hfigdmnd, ...
        'style','slider', ...
        'pos',[.13 .01 .2 0.04], ...
        'back','w', ...
	'value',1, ...	
	'max',100, ...
	'min',0, ...
   'userdata',1, ...
   'call',['f1_t=get(onHndlVector(6),''value'');',...
      '[f1,onHndlVector(12:13)] = slidfreq(f1_t,onHndlVector(6),',...
      'onHndlVector(12:13),onHndlVector(16),ymaxm,yminm,lnst(2,:),lnco(2,:));',...    
      'set(onHndlVector(8),''string'',num2str(f1));',...
      ' hline(2) = onHndlVector(12);']);
    
HANDLES.hceb(7)=uicontrol(HANDLES.hfigdmnd, ...
        'style','text', ...
        'pos',[.13 .05 .1 .04], ...
        'string','Lower');
HANDLES.hceb(8)=uicontrol(HANDLES.hfigdmnd, ...
	'style','edit', ...
	'pos',[.23 .05 .1 .04], ...
	'string','fminm', ...
	'back','w', ...
   'callback',['f1_t=str2num(get(onHndlVector(8),''string''));', ...
      '[f1,onHndlVector(12:13)] = slidfreq(f1_t,onHndlVector(6),',...
		    'onHndlVector(12:13),onHndlVector(16),ymaxm,yminm,lnst(2,:),lnco(2,:));',...    
       'set(onHndlVector(8),''string'',num2str(f1));',...
		' hline(2) = onHndlVector(12);']);

%
% Upper frequency
%
HANDLES.hceb(9) = uicontrol(HANDLES.hfigdmnd, ...
        'style','slider', ...
        'pos',[.55 .01 .2 0.04], ...
	'value',1, ...
	'max',100, ...
	'min',0, ...
	'userdata',1, ...
        'back','w', ...
        'call',['f2_t=get(onHndlVector(9),''value'');',...
           '[f2,onHndlVector(14:15)] = slidfreq(f2_t,onHndlVector(9),',...
           'onHndlVector(14:15),onHndlVector(16),ymaxm,yminm,lnst(3,:),lnco(3,:));',...    
           'set(onHndlVector(11),''string'',num2str(f2));',...
           'hline(3) = onHndlVector(14);']);

HANDLES.hceb(10)=uicontrol(HANDLES.hfigdmnd, ...
        'style','text', ...
        'pos',[.55 .05 .1 .04], ...
        'string','upper');
HANDLES.hceb(11)=uicontrol(HANDLES.hfigdmnd, ...
	'style','edit', ...
	'back','w', ...
	'pos',[.65 .05 .1 .04], ...
	'string','temp', ...
   'callback',['f2_t=str2num(get(onHndlVector(11),''string''));', ...
           '[f2,onHndlVector(14:15)] = slidfreq(f2_t,onHndlVector(9),',...
           'onHndlVector(14:15),onHndlVector(16),ymaxm,yminm,lnst(3,:),lnco(3,:));',...    
           'set(onHndlVector(11),''string'',num2str(f2));',...
           'hline(3) = onHndlVector(14);']);


%
%  Mouse-based cursor position
%

%  Lower Freq.

HANDLES.hceb(17)=uicontrol(HANDLES.hfigdmnd, ...
        'style','pushbutton', ...
        'pos',[.13 .10 .2 .04], ...
        'string','Use Mouse', ...
        'callback',['[f1_t,temp] = ginput(1);',...
           '[f1,onHndlVector(12:13)] = slidfreq(f1_t,onHndlVector(6),',...
		     'onHndlVector(12:13),onHndlVector(16),ymaxm,yminm,lnst(2,:),lnco(2,:));',...    
           'set(onHndlVector(8),''string'',num2str(f1));',...
		     'hline(2) = onHndlVector(12);']);

%  Upper Freq.

HANDLES.hceb(18)=uicontrol(HANDLES.hfigdmnd, ...
        'style','pushbutton', ...
        'pos',[.55 .10 .2 .04], ...
        'string','Use Mouse', ...
        'callback',['[f2_t,temp] = ginput(1);',...
           '[f2,onHndlVector(14:15)] = slidfreq(f2_t,onHndlVector(9),',...
           'onHndlVector(14:15),onHndlVector(16),ymaxm,yminm,lnst(3,:),lnco(3,:));',...    
           'set(onHndlVector(11),''string'',num2str(f2));',...
           'hline(3) = onHndlVector(14);']);
      
set(HANDLES.hceb,'visible','off')

return