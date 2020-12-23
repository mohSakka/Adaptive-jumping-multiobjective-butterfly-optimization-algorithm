function[]=styledBar2(bdata,Lgnd,xLabl,yLabl,Titl,xLimR,yLimR)
figure

%set(axes,'XTickLabel',[1:size(bdata,1)])
hold on
bar(bdata)
title(Titl,'LineWidth',1,'FontWeight','bold','FontSize',14);
legend(Lgnd,'FontWeight','bold','FontSize',11);
 xlabel(xLabl,'LineWidth',1,'FontWeight','bold','FontSize',14);
ylabel(yLabl,'LineWidth',1,'FontWeight','bold','FontSize',14);
xlim([0 (size(bdata,1)+1)*xLimR])
ylim([0 max(max(bdata))*yLimR])