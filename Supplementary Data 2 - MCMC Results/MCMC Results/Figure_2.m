% This script loads net and free flux samples and labels from the archive 
% 'flux_data' and plots a selection of net fluxes. Observe that the free 
% net fluxes are represented both as free fluxes and as net fluxes. All xch 
% fluxes are in the free fluxes.

close all
clear all
load flux_data

% now plot everything
sc=3;
sr=3;
ppFig = sc*sr;
bins = 50;
fontsize  = 16;
fontsize2 = 10;
figure('rend','painters','pos',[100 100 1400 500])
sbplt = 0;

% results reported by Zamboni et al. 2009

nat_prot_2009_vals = [
    1.3155,     % emp1
    1.82946,    % emp3
    5.22073,    % emp6
    0.877402, 	% ppp1
    0.433834,   % tca3
    1.12003,    % tca5a
    0.514895,   % ana1
    0.0,        % ana3
    1.99962     % gs1
];

nat_prot_2009_stds = [
    0.393208,   % emp1
    0.20073,    % emp3
    0.0,        % emp6
    0.360135,   % ppp1
    0.215378,   % tca3
    0.172411,   % tca5a
    0.139667,   % ana1
    0.330261,   % ana3
    0.252905    % gs1
];

CrI_lower = [
	0.478033587954827,
	1.5841561104675,
	3.48696445269268,
	3.06520231244875e-05,
	0.202673470705287,
	0.966747001547044,
	0.0224734115544327,
	0.0001111525412854,
	1.56670224284272,
];

CrI_upper = [
	2.54734607605019,
	2.49880096855619,
	6.58686528651094,
	1.80886944833535,
	1.06003135749285,
	1.6793810623628,
	0.676927535192384,
	1.82519180633262,
	2.79836151813016,
];

net_flux_indices = [43,45,48,51,59,61,39,41,49];

for k = 1:length(net_flux_indices)
    sbplt=sbplt+1;
    subplot(sr,sc,sbplt)
    
    i = net_flux_indices(k)
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
    backward = 1;
    forward = 1;
    CrI = plot([CrI_lower(k), CrI_upper(k)], [0.1 * yl(2), 0.1 * yl(2)], "LineWidth", 4, "Color", "#0072BD");
    alpha(CrI, 0.5)
    hold on

   
    plot([nat_prot_2009_vals(k), nat_prot_2009_vals(k)], [0.05*yl(2), yl(2)], ":", "LineWidth", 1, "Color", "#A2142F");
    hold on
    
    % we want 95% CIs, so 2*stds below
    CI = plot([nat_prot_2009_vals(k)-2*nat_prot_2009_stds(k), nat_prot_2009_vals(k)+2*nat_prot_2009_stds(k)], [0.05 * yl(2), 0.05 * yl(2)], "LineWidth", 4, "Color", 	"#A2142F");
    alpha(CI, 0.5)
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

