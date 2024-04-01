function fluxes = flux_data2csv(file, model_names, i)
    data = load(file);
    display(data)
    
    names = data.freeNames{i};
    fluxes = data.free{i};  
    names_table = cell2table(names);
        
    writetable(names_table, model_names{i} + "_freeNames.csv");
    csvwrite(model_names{i} + "_freeFluxes.csv", fluxes);
 end


