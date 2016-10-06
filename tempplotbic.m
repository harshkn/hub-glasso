load('results-bic_test.mat');
temp_all = [];
for i =  1:numel(outall)
    for j = 1:numel(outall{i})
        temp_all = [temp_all ;outall{i}{j}];
    end
end
temp_all = abs(temp_all);

