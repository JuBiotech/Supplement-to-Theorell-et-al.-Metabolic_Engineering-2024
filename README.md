# Supplement-to-Theorell-et-al.-Metabolic_Engineering-2024


Supplementary Materials for:
Rethinking 13C-Metabolic Flux Analysis – The Bayesian Way of Flux Inference
by Axel Theorell, Johann Fredrik Jadebeck, Wolfgang Wiechert, Johnjoe McFadden, Katharina Nöh


This repository contains the model files used for the analysis,
Bayesian inference results using MCMC (single models) and RJMCMC (Bayesian model averaging),
and Matlab scripts to evaluate these results to generate figures of the manuscript.
Furthermore the code to calculate the Wasserstein distances with respect to the published Zamboni model are contained,
as well as the script to calculate the rank-normalized Rhat and ESS values of the (RJ)MCMC runs.

Raw samples are downloadable in matlab format here: https://data.fz-juelich.de/dataset.xhtml?persistentId=doi%3A10.26165%2FJUELICH-DATA%2FBJK8GJ

Index:
models 
    1: M0 single (refence model); 
    2: M1 single (simple 1); 
    3: M2 single (simple 2); 
    4: M-1 single (complex); 
    5: {M0} set (reference);
    6: {M-1} set (complex)
