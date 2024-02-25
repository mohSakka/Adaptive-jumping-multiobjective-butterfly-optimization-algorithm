function[]=styledBar(bdata,Lgnd,xLabl,yLabl,Titl,xLimR,yLimR)
figure
colors = ['b','g','r','y','c','m'];
set(axes,'XTick',zeros(1,0))
hold on
sz=size(bdata,2);
for i = 1:sz
    bar(i,bdata(i),colors(i))
end
title(Titl,'LineWidth',1,'FontWeight','bold','FontSize',14);
legend(Lgnd,'FontWeight','bold','FontSize',11);
 xlabel(xLabl,'LineWidth',1,'FontWeight','bold','FontSize',14);
ylabel(yLabl,'LineWidth',1,'FontWeight','bold','FontSize',14);
xlim([0 (size(bdata,2)+1)*xLimR])
ylim([0 max(max(bdata))*yLimR])