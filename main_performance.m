clear variables 
%% network parameters 
n = 250; % number of samples
p = 500; % number of variables
sparsity = 0.98 ; %sparsity of the network
hub_sparsity = 0.3; %sparsity of the hub columns
hub_number = 10; %number of hubs


%% Tuning parameters
lamda1 = 0.4;
lamda2 = 0.32;
lamda3 = 2;
l2val = 0.2:0.05:0.5;
l3val = 1:1:3;
%% other variables
simul = [];
%% Generate the network 
[true_theta, true_hubcol] = createHubNetwork(p,sparsity,hub_number,hub_sparsity, 'gaussian');
sim_cycles = 1;
res = cell(1,numel(l3val));
for l3ind = 1:numel(l3val)
    lamda3 = l3val(l3ind);
    avgsimul = zeros(numel(l2val), 9);
    for l2ind = 1:numel(l2val)
        lamda2 = l2val(l2ind);
        simul = zeros(sim_cycles, 6);
        for simulations = 1:sim_cycles
%% Sample data from the network

        invS = inv(true_theta);  
        x = mvnrnd(zeros(p,1),invS,n);
        x = zscore(x); %check 
        S = cov(x);

%% Run ADMM 
        [theta, Z,V,lsfnval] = hglasso(S, lamda1, lamda2 , lamda3);
        est_hubcol = getNodeColumns(V,p * 0.2);
        out.bic = computeBIC(S,theta,Z, V, n, p , 0.2, numel(est_hubcol));
        % show_matrices();
        measure_perf();
        % fn = 'results.txt';
        % writetofile();
%         print_results
        simul(simulations,:) =  out.all;
        end
        avgsimul(l2ind,:) = [lamda1 lamda2 lamda3 mean(simul,1)];
    end
    res{1,l3ind} = avgsimul;
end
save_plot = 0;
perf = 1;
show_plots();

% save ('allvarnew.mat', 'res', 'true_theta', 'true_hubcol', 'out');

