clc;clear;close all;
t=linspace(-2,8,100);
a1=axes;
plot(t,cos(t));
% xt=get(gca,'xtick');
% set(gca,'XTick',[],'XColor','w');
% xL=xlim;
% p=get(gca,'Position');
% box off;
% a2=axes('Position',p+[0,p(4)/2,0,-p(4)/2]);
% xlim(xL);box off;
% set(gca,'XTick',xt,'Color','None','YTick',[]);
new_fig_handle = shift_axis_to_origin( gca ) ;