% Matlab script for manuscript ""
% 
% This script loads flux samples and their labels from the archive 'flux_data'
% and plots the bidirectionality probability of all reactions set bidirectional
% in the model file. Thus, only xch fluxes of BMA runs are investigated.

clear all
load flux_data

noSamples = size(free{1},1);

% Model set {M_0}
M_0_BMA  = free{1,5};
idx_M0 = [1,3,5,8,12:16,18:23,25:26];
for i=1:noSamples 
    res_M_0_BMA(i)=nnz(M_0_BMA(i,:)); 
end
M_0_BMA_xch = M_0_BMA(:,idx_M0);
res_M_0_BMA_xch=[];
for i=1:size(idx_M0,2)
    res_M_0_BMA_xch(i)=nnz(M_0_BMA_xch(:,i))./noSamples;
end
[mean(res_M_0_BMA), std(res_M_0_BMA)]
[mean(res_M_0_BMA_xch), std(res_M_0_BMA_xch)]

% Model set {M_{-1}}
MM_1_BMA = free{1,6};
idx_MM1 = [1,3,5,8,12:16,18:26,28:33];
for i=1:noSamples 
    res_MM_1_BMA(i)=nnz(MM_1_BMA(i,:)); 
end
MM_1_BMA_xch = MM_1_BMA(:,idx_MM1);
res_MM_1_BMA_xch=[];
for i=1:size(idx_MM1,2)
    res_MM_1_BMA_xch(i)=nnz(MM_1_BMA_xch(:,i))./noSamples;
end
[mean(res_MM_1_BMA), std(res_MM_1_BMA)]
[mean(res_MM_1_BMA_xch), std(res_MM_1_BMA_xch)]

% resorting
res_M_0_BMA_xch_resized = [res_M_0_BMA_xch(1:10),0,0,0,res_M_0_BMA_xch(11:15),0,0,0,0,res_M_0_BMA_xch(16:17)];

thres = 0.05;
figure;
hold on
bar([res_M_0_BMA_xch_resized',res_MM_1_BMA_xch']);
xlabel('flux name')
xticks([1:24]); 
xticklabels([freeNames{1,6}(idx_MM1)]);
xtickangle(45);
ylabel('posterior probability')
title('Probability for being bidirectional')
legend('\{M_0\}','\{M_{-1}\}')
line([0,24],[thres,thres],'Color','black','LineStyle',':')
line([0,24],[1-thres, 1-thres],'Color','black','LineStyle',':')
box;
