% Matlab script for manuscript ""

% This script loads net and free flux samples and their labels from the archive 
% 'flux_data' and prior and posterior DOF distributions for BMA solutions. 

clear all
load flux_data

figNr=10;
figure(figNr);
clf;
 
dens_collect=[];
BMA_collect=[];

for BMA_idx=[5,6]

    M_0_BMA  = free{1,BMA_idx};
    
    idx = find(contains(freeNames{1,BMA_idx},'.x'))';
    M_0_BMA  = M_0_BMA(:,idx);
    freeNames_xch = freeNames{1,BMA_idx}(idx);
    
    noSamples = size(M_0_BMA,1);
    
    res_M_0_BMA=[];
    for i=1:noSamples
        res_M_0_BMA(i) = nnz(M_0_BMA(i,:));
    end
    [BMA_idx, size(M_0_BMA,2), mean(res_M_0_BMA), std(res_M_0_BMA)]
    
    xbins=[min([res_M_0_BMA]):max([res_M_0_BMA])]
    
    coef = [];
    noFree = size(M_0_BMA,2);
    for i=0:noFree
        coef=[coef, nchoosek(noFree,i)];
    end
    dens           = coef;
    dens_norm = coef./sum(coef);
    
    [counts_M_0_BMA,centers_M_0_BMA]=hist(res_M_0_BMA,xbins);
    M=sum(centers_M_0_BMA.*counts_M_0_BMA)/sum(counts_M_0_BMA);
    BMA_collect = [BMA_collect; size(M_0_BMA,2), M,  sqrt(sum((M-centers_M_0_BMA).^2)/ length(centers_M_0_BMA))];
    
    figure(figNr);
    subplot(2,1,1);
    hold on;
    if BMA_idx == 5
        % h1=bar(10.+[0:noFree],dens,'b');
        h1=bar(10.+[0:noFree],dens_norm,'b');
    else
        % h1=bar(10.+[0:noFree],dens,'r');
        h1=bar(10.+[0:noFree],dens_norm,'r');
    end
    h1.FaceAlpha=0.5;
    xlim(10.+[0 24]);
    title(cat(2, 'Prior DOF Distribution'),'Fontsize',24);% (', num2str(size(M_0_BMA,2)), '; ', num2str(sum(coef)), ' Models'), ')');    xlabel('DOF (net + xch'),'Fontsize',18);
    
    subplot(2,1,2);
    hold on;
    if BMA_idx == 5
        h2= bar(10.+centers_M_0_BMA,counts_M_0_BMA./sum(counts_M_0_BMA),'b');
    else
        h2= bar(10.+centers_M_0_BMA,counts_M_0_BMA./sum(counts_M_0_BMA),'r');
    end
    h2.FaceAlpha=0.5;
    xlim(10.+[0 24]);
    title('Posterior DOF Distribution','Fontsize',24); % cat(2, 'DOF (posterior) = ', num2str(size(M_0_BMA,2)), '; ', num2str(sum(coef)), ' models'));

end

figure(figNr); 
subplot(2,1,1); 
box;
xlabel('DOF (net + xch)','Fontsize',20,'FontWeight','bold','FontName','Arial');
ylabel('# models','Fontsize',20,'FontWeight','bold', 'FontName','Arial');
subplot(2,1,2); 
box;
xlabel('DOF (net + xch)','Fontsize',20,'FontWeight','bold','FontName','Arial');
ylabel('probability density','Fontsize',20,'FontWeight','bold','FontName','Arial');
