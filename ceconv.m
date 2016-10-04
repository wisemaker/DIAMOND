%
%  Name: CEconv.m
% 
%  Usage: CEconv.m
% 
%  Description:
%    Puts Frequency and Damping into a matrix
%    Freq is a column vector of frequencies
%    Dampings a column vector of damping
%
%  Version EGS960819
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
%

global hce hcec;

hCEconv=figure( ...
    'Name','Complex Exponential Convergence Studies', ...
    'NumberTitle','off', ...
    'Resize','on', ...
    'Position',[360 80 560 420], ...
    'BackingStore','off',...
	'menubar','none');
    
%%====================================
%% For the Complex Exponential window
%%====================================
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
hcec(1)=uicontrol(hCEconv, ...
        'Style','Frame', ...
        'units','normalized', ...
	'visible','on', ...
        'Position',frmpos, ...
        'BackgroundColor',[.5 .5 .5]);

%==================================
% Set up buttons
%==================================
%
% Generate Hankel H(0) matrix button
%
btnnum=1;
ypos=top-(btnnum-1)*(btnht+spacing);
btnpos=[left ypos-btnht btnwd btnht];
hcec(1)=uicontrol(hCEconv, ...
      'style','push', ...
      'unit','normalized', ...
      'position',btnpos, ...
      'visible','on', ...      
      'string','Hankel H(0)', ...
      'callback',['samples=str2num(get(hcec(3),''string''));', ...
		'[H0,Y,U0,S0,V0,hERAconva,fs_out,nresp,nref] = mkCEhank(G,nlines,fs,samples);',...
                  'xlabel(''Number of Poles'');',...
		  'global hcec;',...
		  'set(hcec(15:16),''visible'',''on''),']);

%
%  Samples, describes model size for Complex Exponential
%
btnnum=2;
ypos=top-(btnnum-1)*(btnht);
btnpos=[left ypos-btnht btnwd*.65 btnht];
hcec(2)=uicontrol(hCEconv, ...
      'style','text', ...
      'unit','normalized', ...
      'position',btnpos, ...
      'visible','on', ...      
      'string','samples');
btnpos=[left+.65*btnwd ypos-btnht btnwd*.35 btnht];
hcec(3)=uicontrol(hCEconv, ...
      'style','edit', ...
      'unit','normalized', ...
      'position',btnpos, ...
      'visible','on', ...      
      'string','?');

%
%  Poles
%
%  Select X axis value off of plot using mouse
btnnum=3;
ypos=top-(btnnum-1)*(btnht);
btnpos=[left ypos-btnht btnwd*.65 btnht];
hcec(15)=uicontrol(hCEconv, ...
        'style','pushbutton', ...
        'units','normalized', ...
        'pos',btnpos, ...
  	'visible','off', ...
	'string',' Poles', ...
	'callback',['global hce;',... 
                    '[f1,temp] = ginput(1);',...
		    'set(hcec(16),''string'',num2str(2*ceil(f1/2)));',...
		    'set(hce(9),  ''string'',num2str(2*ceil(f1/2)));']);

btnpos=[left+.65*btnwd ypos-btnht btnwd*.35 btnht];
hcec(16)=uicontrol(hCEconv, ...
      'style','edit', ...
      'unit','normalized', ...
      'position',btnpos, ...
      'visible','off', ...      
      'string','?', ...
      'callback',['global hce;', ... 
	          'value = get(hcec(16),''string'');', ...
		  'set(hce(9),''string'',value)']);



%
%  Run vine plot
%
btnnum=5;
ypos=top-(btnnum-1)*(btnht+spacing);
btnpos=[left ypos-btnht btnwd btnht];
hcec(6)=uicontrol(hCEconv, ...
      'style','push', ...
      'unit','normalized', ...
      'position',btnpos, ...
      'visible','on', ...      
      'string','Run Vine', ...
      'callback',['nxlow=str2num(get(herac(8),''string''));', ...
	'nxhigh=str2num(get(herac(10),''string''));', ...
	'dnx=str2num(get(herac(12),''string''));', ...
        '[H0,H1,Y,U0,S0,V0,hERAconva,fs_out,nresp,nref] = makehank(G,nlines,fs,q,d);',...
	'[freq_s,cmi_s,hERAconva] = vineplot(H0,H1,Y,U0,S0,V0,q,d,fs_out,nref,nresp,nxhigh,nxlow,dnx,hERAconva);']);

%
%  nx_low
%

btnnum=6;
ypos=ypos-btnht;
btnpos=[left ypos-btnht btnwd*.65 btnht];
hcec(7)=uicontrol(hCEconv, ...
      'style','text', ...
      'unit','normalized', ...
      'position',btnpos, ...
      'visible','on', ...      
      'string','nx_min');
btnpos=[left+.65*btnwd ypos-btnht btnwd*.35 btnht];
hcec(8)=uicontrol(hCEconv, ...
      'style','edit', ...
      'unit','normalized', ...
      'position',btnpos, ...
      'visible','on', ...      
      'string','1');
%
%  nx_high
%
btnnum=7;
ypos=ypos-btnht;
btnpos=[left ypos-btnht btnwd*.65 btnht];
hcec(9)=uicontrol(hCEconv, ...
      'style','text', ...
      'unit','normalized', ...
      'position',btnpos, ...
      'visible','on', ...      
      'string','nx_max');
btnpos=[left+.65*btnwd ypos-btnht btnwd*.35 btnht];
hcec(10)=uicontrol(hCEconv, ...
      'style','edit', ...
      'unit','normalized', ...
      'position',btnpos, ...
      'visible','on', ...      
      'string','1');
%
%  dnx
%
btnnum=8;
ypos=ypos-btnht;
btnpos=[left ypos-btnht btnwd*.65 btnht];
hcec(11)=uicontrol(hCEconv, ...
      'style','text', ...
      'unit','normalized', ...
      'position',btnpos, ...
      'visible','on', ...      
      'string','delta nx');
btnpos=[left+.65*btnwd ypos-btnht btnwd*.35 btnht];
hcec(12)=uicontrol(hCEconv, ...
      'style','edit', ...
      'unit','normalized', ...
      'position',btnpos, ...
      'visible','on', ...      
      'string','1');

%
%  Close window
%
btnnum=13;
ypos=top-(btnnum-1)*(btnht+spacing);
btnpos=[left ypos-btnht btnwd btnht];
hcec(13)=uicontrol(hCEconv, ...
      'style','push', ...
      'unit','normalized', ...
      'position',btnpos, ...
      'visible','on', ...      
      'string','Close',...
      'callback','set(hCEconv,''visible'',''off'')');










