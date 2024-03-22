% Matlab script for manuscript ""
%
% This script loads net and free flux samples and their labels from the archive 
% 'flux_data' and plots all net flux posterior distributions. 
% Observe that the free net fluxes are represented both as free fluxes and as net fluxes. 
% All xch fluxes are in the free fluxes.

clear all
load flux_data

% prepare plots 
sc=6;
sr=5;
ppFig = sc*sr;
bins = 50;
fontsize = 10;
figNr = 1;
xlims = [0,2; 0,4; 0,4; 0,20; 0,4; 0,4;
         0,4; 0,10; 0,10; 0,10; 0,4; 0,4;
         0,4; 0,2; 0,2; 0,1; 0,2; 0,2;
         0,10; 0,5; 0,5; 0,5; 0,4; 0,4; 
         0,10; 0,4; 1,3; 0,1];
ylims = [0,3;0,2;0,15;0,0.6;0,2.5;0,3;
    0,3;0,1.5;0,1.5;0,1;0,2;0,2;
    0,2;0,3.5;0,6;0,6;0,6;0,6;
    0,1;0,1.5;0,3;0,3;0,3;0,3;
    0,1;0,3;0,4;0,15];

% plot everything: single-models
for i = 39:length(netNames{1})
    if mod(figNr-1,ppFig)==0
       figure(); 
    end
    subplot(sr,sc,mod(figNr-1,ppFig)+1)
    for j=1:4
       h = histogram(net{j}(:,i),bins,'Normalization','pdf');
       hold on;
       h.EdgeAlpha=0;
       h.FaceAlpha = 0.5;
    end
    xlabel('mmol/(gCDW h)','fontsize',fontsize); 
    ylabel('Prob. density','fontsize',fontsize);
    title(strcat(netNames{1}{i},'.n')); 
    xlim(xlims(figNr,:));
    ylim(ylims(figNr,:));
    figNr = figNr+1;
end
subplot(sr,sc,1);
legend('M_0','M_1','M_2','M_{-1}','location','northeast');

% plot everything: model sets
figNr = 1;
for i = 39:length(netNames{1})
    if mod(figNr-1,ppFig)==0
       figure(); 
    end
    subplot(sr,sc,mod(figNr-1,ppFig)+1)
    for j=5:6
       h = histogram(net{j}(:,i),bins,'Normalization','pdf');
       hold on;
       h.EdgeAlpha=0;
       h.FaceAlpha = 0.5;
    end
    xlabel('mmol/(gCDW h)','fontsize',fontsize); 
    ylabel('Prob. density','fontsize',fontsize);
    title(strcat(netNames{1}{i},'.n')); 
    xlim(xlims(figNr,:));
    ylim(ylims(figNr,:));
    figNr = figNr+1;
end
subplot(sr,sc,1)
legend('\{M_{0}\}','\{M_{-1}\}','location','northeast');

% plot everything: M0 vs. {M0}
figNr = 1;
for i = 39:length(netNames{1})
    if mod(figNr-1,ppFig)==0
       figure(); 
    end
    subplot(sr,sc,mod(figNr-1,ppFig)+1)
    for j=[1,5]
       h = histogram(net{j}(:,i),bins,'Normalization','pdf');
       hold on;
       h.EdgeAlpha=0;
       h.FaceAlpha = 0.5;
    end
    xlabel('mmol/(gCDW h)','fontsize',fontsize); 
    ylabel('Prob. density','fontsize',fontsize);
    title(strcat(netNames{1}{i},'.n')); 
    xlim(xlims(figNr,:));
    ylim(ylims(figNr,:));
    figNr = figNr+1;
end
subplot(sr,sc,1)
legend('M_0','\{M_{0}\}','location','northeast');

% plot everything: M0 vs. {M-1}
figNr = 1;
for i = 39:length(netNames{1})
    if mod(figNr-1,ppFig)==0
       figure(); 
    end
    subplot(sr,sc,mod(figNr-1,ppFig)+1)
    for j=[1,6]
       h = histogram(net{j}(:,i),bins,'Normalization','pdf');
       hold on;
       h.EdgeAlpha=0;
       h.FaceAlpha = 0.5;
    end
    xlabel('mmol/(gCDW h)','fontsize',fontsize); 
    ylabel('Prob. density','fontsize',fontsize);
    title(strcat(netNames{1}{i},'.n')); 
    xlim(xlims(figNr,:));
    ylim(ylims(figNr,:));
    figNr = figNr+1;
end
subplot(sr,sc,1)
legend('M_0','\{M_{-1}\}','location','northeast');