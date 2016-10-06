clear variables 


lamda3iter = [1,2,3];

%% network parameters 
n = 250; % number of samples
p = 500; % number of variables
sparsity = 0.98 ; %sparsity of the network
hub_sparsity = 0.3; %sparsity of the hub columns
hub_number = 4; %number of hubs



%% ADMM algorithm parameters
rho = 2.5; %from paper
tau = 1e-10; %from paper
max_iter = 500; %maximum number of iteration

%% generate the network 
[true_theta, true_hubcol] = createHubNetwork(p,sparsity,hub_number,hub_sparsity, 'gaussian');
val.true_theta = true_theta;
val.true_hubcol = true_hubcol;
invS = inv(true_theta); 

for lam = 1:3

%% tuning parameters
lamda1 = 0.35;
lamda2 = 0.32;
lamda3 = lamda3iter(lam);


%% temp
val.n = n;
val.p = p;
val.sparsity = sparsity ;
val.hub_sparsity = hub_sparsity ;
val.hub_number = hub_number;
val.lamda1 = lamda1 ;
val.lamda2 = lamda2 ;
val.lamda3 = lamda3 ;

tot_simul = 5;
for i = 1:tot_simul
% generate samples from the network 
x = mvnrnd(zeros(p,1),invS,n);
x = zscore(x); %check 
S = cov(x);

%init matrices
theta = eye(p); 
theta_old = theta;
theta_ = zeros(p,p);
V = eye(p);
Z = eye(p);
V_ = zeros(p,p);
Z_ = zeros(p,p);

W1 = zeros(p,p);
W2 = zeros(p,p);
W3 = zeros(p,p);
gamma = zeros(p,p);

%stop criterion function 
% stop_crit = @(p1, p1minus1) sum((p1-p1minus1)^2)/sum((p1minus1)^2) ;
iter = 1;
sc_val = 1e10;
lsfnval = zeros(1,max_iter -1);

%ADMM begin
while (( sc_val > tau) && (iter < max_iter))
       
    %update theta, V, Z
    theta = nextTheta(theta_, W1, S, rho); 
    Z = nextZ(Z_, W3, lamda1, rho);
    V = nextV(V_, W2, lamda2, lamda3, rho);
    
    %update theta_tilde, V_tilde, Z_tilde (tilde denoted with '_' after the
    %variable
    gamma = nextGamma(W1, W2, W3, theta, V, Z, rho);
    theta_ = nextTheta_(theta, W1, gamma, rho);
    V_ = nextV_(V,W2,gamma,rho);
    Z_ = nextZ_(Z,W3,gamma,rho);
    
    %update W
    W1 = W1 + theta - theta_;
    W2 = W2 + V - V_;
    W3 = W3 + Z - Z_;
    
    lsfnval(iter) = lossFunctionGaussGraphModel(theta, S, Z, V, lamda1, lamda2, lamda3);
    sc_val = sum(sum((theta-theta_old)^2))./sum(sum((theta_old)^2));
    theta = Z + V + V';	
    if(mod(iter, 10) == 0) 
        disp(['Lamda val: ' ,num2str(lam) ,' Current Loop: ' num2str(i) , ' Current Iter: ', num2str(iter)]);
    end
    iter = iter + 1;
    theta_old = theta;

end
%%
est_hubcol = getNodeColumns(V,p * 0.2);

% show_plots();
measure_perf();
final_out(i) = out;

%%
fid = fopen('simulation.txt','a');
fprintf(fid, 'Simulation iteration: %d  \n', i);
fprintf(fid, 'Parameters  \n');
fprintf(fid, 'lamda1: %.2f  lamda2: %.2f  lamda3: %.2f  \n',lamda1,lamda2,lamda3);
fprintf(fid, 'n: %d  p: %d  \n',n,p);
fprintf(fid, 'sparsity: %.2f  hub sparsity: %.2f  hub number: %d \n\n',sparsity,hub_sparsity, hub_number);

%%
fprintf(fid, 'Total true edges: %d\n',out.total_true_edges);
fprintf(fid, 'Total estimated edges: %d\n',out.total_est_edges);
fprintf(fid, 'Estimated correct edges: %d\n',out.est_correct_edges);
fprintf(fid, 'Prop of correctly estimated hub edges: %f\n',out.prop_1);
fprintf(fid, 'Prop of correctly estimated hub nodes: %f\n',out.prop_2);
fprintf(fid, 'Sum of squared errors: %f\n',out.sse);
fprintf(fid, '--------------------------------------------------------------');
fclose(fid);


end

result(lam).val = val;
result(lam).final_out = final_out;
end
%% final results
% fprintf(fid, 'Average over %d  \n', tot_simul);
% fprintf(fid, 'lamda1: %.2f  lamda2: %.2f  lamda3: %.2f  \n',result(1).val.lamda1,result(1).val.lamda2,result(1).val.lamda3);
% fprintf(fid, 'Total true edges: %d\n',result(1).final_out.total_true_edges);
% fprintf(fid, 'Avg total estimated edges: %d\n',result(1).final_out.total_est_edges);
% fprintf(fid, 'Avg tstimated correct edges: %d\n',result(1).final_out.est_correct_edges);
% fprintf(fid, 'Avg prop of correctly estimated hub edges: %f\n',result(1).final_out.prop_1);
% fprintf(fid, 'Avg prop of correctly estimated hub nodes: %f\n',result(1).final_out.prop_2);
% fprintf(fid, 'Avg sum of squared errors: %f\n',result(1).final_out.sse);
% fprintf(fid, '--------------------------------------------------------------');
% fclose(fid);

[~,sx]=sort([result(1).final_out.total_est_edges]);
sf1 = result(1).final_out(sx);
[~,sx]=sort([result(2).final_out.total_est_edges]);
sf2 = result(2).final_out(sx);
[~,sx]=sort([result(2).final_out.total_est_edges]);
sf3 = result(3).final_out(sx);

figure(1)
hold on
plot([sf1.total_est_edges],[sf1.est_correct_edges],'r*');
plot([sf2.total_est_edges],[sf2.est_correct_edges],'g*');
plot([sf3.total_est_edges],[sf3.est_correct_edges],'b*');
legend('lamba3 = 1','lamba3 = 2','lamba3 = 3');
xlabel('Num. Est Edges')
ylabel('Num Corr Est Edges');

figure(2)
hold on
plot([sf1.total_est_edges],[sf1.prop_1],'r*');
plot([sf2.total_est_edges],[sf2.prop_1],'g*');
plot([sf3.total_est_edges],[sf3.prop_1],'b*');
legend('lamba3 = 1','lamba3 = 2','lamba3 = 3');
xlabel('Num. Est Edges')
ylabel('Prop Corr Est Hub Edges');

figure(3)
hold on
plot([sf1.total_est_edges],[sf1.prop_2],'r*');
plot([sf2.total_est_edges],[sf2.prop_2],'g*');
plot([sf3.total_est_edges],[sf3.prop_2],'b*');
legend('lamba3 = 1','lamba3 = 2','lamba3 = 3');
xlabel('Num. Est Edges')
ylabel('Prop Corr Est Hubs');

figure(4)
hold on
plot([sf1.total_est_edges],[sf1.sse],'r*');
plot([sf2.total_est_edges],[sf2.sse],'g*');
plot([sf3.total_est_edges],[sf3.sse],'b*');
legend('lamba3 = 1','lamba3 = 2','lamba3 = 3');
xlabel('Num. Est Edges')
ylabel('Sum of squared Errors');


    


