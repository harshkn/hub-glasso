clear variables 
%% network parameters 
n = 50; % number of samples
p = 100; % number of variables
sparsity = 0.99  ; %sparsity of the network
hub_sparsity = 0.1; %sparsity of the hub columns
hub_number = 4; %number of hubs


%% Tuning parameters

lamda1 = 0.3;
lamda2 = 0.3;
lamda3 = 1.5;

%% other variables
simul = [];
%% Generate the network 
[true_theta, true_hubcol] = createHubNetwork(p,sparsity,hub_number,hub_sparsity, 'gaussian');

%% Sample data from the network
disp(strcat('True Hub nodes are :', int2str(true_hubcol)))
invS = inv(true_theta);  
x = mvnrnd(zeros(p,1),invS,n);
x = zscore(x); %check 
S = cov(x);

%% Run ADMM 
[theta, Z,V,lsfnval] = hglasso(S, lamda1, lamda2 , lamda3);

%% Results 
est_hubcol = getNodeColumns(V,p * 0.2);
show_matrices();
perf = 0;
measure_perf();
% fn = 'results.txt';
% writetofile();
print_results




