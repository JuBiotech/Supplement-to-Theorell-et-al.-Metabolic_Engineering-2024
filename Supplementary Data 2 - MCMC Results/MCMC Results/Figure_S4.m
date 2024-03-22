% This script loads net and free flux samples and labels from the archive 
% 'flux_data' and plots a selection of net fluxes. Observe that the free 
% net fluxes are represented both as free fluxes and as net fluxes. All xch 
% fluxes are in the free fluxes.

close all
clear all
load flux_data

% now plot everything
sc=6;
sr=5;
ppFig = sc*sr;
bins = 50;
fontsize  = 10;
figure('rend','painters','pos',[100 100 1400 500]);
sbplt = 0;

% results reported by Zamboni et al. 2009
nat_prot_2009_vals = [
	0.51,
	2.11,
	0.0,
	0.0,
	1.32,
	2.0,
	1.83,
	3.88,
	3.69,
	5.22,
	2.0,
	2.0,
	0.88,
	0.52,
	0.35,
	0.23,
	0.29,
	0.29,
	4.72,
	2.43,
	0.43,
	0.24,
	1.12,
	1.12,
	4.24,
	2.2,
	1.76,
	0.44
];

nat_prot_2009_stds = [
	0.14,
	0.4,
	0.33,
	0.0,
	0.39,
	0.2,
	0.2,
	0.34,
	0.34,
	0.0,
	0.25,
	0.25,
	0.36,
	0.24,
	0.12,
	0.12,
	0.12,
	0.12,
	0.57,
	0.34,
	0.22,
	0.22,
	0.17,
	0.17,
	0.65,
	0.16,
	0.13,
	0.03
];

CrI_lower = [
	0.063115964332653,
	0.356089551798592,
	0.0001111525412854,
	7.64774442002405,
	0.760922920770413,
	1.67125670358714,
	1.67125670358714,
	3.6967500866765,
	3.5032710866765,
	3.68488716618378,
	1.67293034319747,
	1.67293034319747,
	3.06520231244875e-05,
	-0.0623108986512503,
	0.0623415506743748,
	-0.0585604493256252,
	-0.0037504493256251,
	-0.0037504493256251,
	4.25948447657022,
	2.2503030866765,
	0.262704587768017,
	0.0693145877680172,
	1.02845654333825,
	1.02845654333825,
	2.76311316618378,
	2.09815660176688,
	1.67852528141351,
	0.419631320353377,
];

CrI_upper = [
	0.628315260388327,
	2.45810612287826,
	1.5508392852726,
	11.0002560075752,
	2.48177100078686,
	2.43961226268221,
	2.43961226268221,
	4.8931068556747,
	4.6996278556747,
	6.34486110093425,
	2.7103226652578,
	2.7103226652578,
	1.52008460451614,
	0.951058403010757,
	0.569026201505378,
	0.448124201505378,
	0.502934201505378,
	0.502934201505378,
	6.3749468698953,
	3.44665985567471,
	1.00288274850425,
	0.809492748504249,
	1.62663492783735,
	1.62663492783735,
	5.42308710093425,
	2.6571231922279,
	2.12569855378232,
	0.531424638445579,
];

for i = 39:length(netNames{1})
    sbplt=sbplt+1;
    subplot(sr,sc,sbplt)
    
    % models 1: M0; 2: M1; 3: M2; 4: M-1; 5: {M0}; 6: {M-1}
    j = 1;
    %for j = [1:4]
    % for j= [1,5,6] 
    display(netNames{j}(i));
    
    h = histogram(net{j}(:,i),bins,'Normalization','pdf');
    alpha(h,.25)
    hold on;
    h.EdgeAlpha=0.0;
    
    yl = ylim;
   
    map_flux = net{j}(34635, i);
    plot([map_flux, map_flux], [0.1*yl(2), yl(2)], "LineWidth", 1, "Color", "#0072BD");
    hold on;
    k = i - 38;
    CrI = plot([CrI_lower(k), CrI_upper(k)], [0.1 * yl(2), 0.1 * yl(2)], "LineWidth", 4, "Color", "#0072BD");
    alpha(CrI, 0.5);
    hold on
    
    plot([nat_prot_2009_vals(k), nat_prot_2009_vals(k)], [0.05*yl(2), yl(2)], ":", "LineWidth", 1, "Color", "#A2142F");
    hold on
    
    % we want 95% CIs, so 2*stds below
    CI = plot([nat_prot_2009_vals(k)-2*nat_prot_2009_stds(k), nat_prot_2009_vals(k)+2*nat_prot_2009_stds(k)], [0.05 * yl(2), 0.05 * yl(2)], "LineWidth", 4, "Color", 	"#A2142F");
    alpha(CI, 0.5);
    hold on
    
    %end
    xlabel("mmol/gCDW \cdot h"); 
    ylabel("Probability Density");
    title(strcat(netNames{1}{i},'.n'),'Fontsize',fontsize); 
    
end
%subplot(sr,sc,1)
fig = gcf;
fig.Position(3) = fig.Position(3) + 250;
% legend('flux posterior distribution','MAP', "95% credible interval",'best fit','95% confidence interval','northwest','Fontsize',fontsize);

