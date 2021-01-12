function [GUI,f]=generateGUI(varargin)
%%
f = fig;
clf
sz_v = 50;
sz_h = 200;
if isempty(varargin)
    num_button = 0;
elseif iscell(varargin) & numel(varargin{1,1}) > 1
    varargin    = varargin{1,1};
    num_button  = numel(varargin);
else
    num_button  = nargin;
end

num_column   = ceil(num_button/2);
poslist     = zeros(4,num_button);
poslist(1,:)= (560-sz_h)*(ceil((1:num_button)/num_column)-1) ;
tmp= mod((1:num_button),num_column);
tmp(tmp==0) = num_column;
poslist(2,:)= 1*(420-sz_v)*(tmp-1)-300*(tmp-1);
poslist(3,:)= sz_h;
poslist(4,:)= sz_v;

GUI = cell(num_button,1);
for i_button = 1 : num_button
    tmpUI = uicontrol(f,'style','push','position',poslist(:,i_button),...
        'string',varargin{i_button},'fontsize',20,...
        'callback',(sprintf('Wrapper(''%s'');',varargin{i_button}))...
        );
    GUI{i_button} = tmpUI;
end
setPos([1 90 580 150*(max(1,num_column-2))]);
end

%'callback',eval(sprintf('Wrapper(''%s'');',varargin{i_button}))...