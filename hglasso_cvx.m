function [theta,Z,V, lsfnval] = hglasso(S, lamda1, lamda2 , lamda3)

% n = size(S,1);
p = size(S,2);
%% Init 
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


%% ADMM algorithm parameters
rho = 2.5; %from paper
tau = 1e-10; %from paper
max_iter = 1500; %maximum number of iteration

%% Other parameters

iter = 1;
sc_val = 1e10;
tic;

cvx_begin

    t1 = - log(det(theta)) + trace ( S .* theta);
    t2 = lamda1 * sum(sum(abs(Z- diag(diag(Z)))));
    t3sub = V- diag(diag(V));
    t3 = lamda2 * sum(sum(abs(t3sub)));
    t4 = lamda3 * sum(sqrt(sum(t3sub .^2)));
    minimize(t1 +  t2 + t3 + t4)
cvx_end

% %% ADMM begin
% while (( sc_val > tau) && (iter < max_iter))
%        
%     %update theta, V, Z
%     theta = nextTheta(theta_, W1, S, rho); 
%     Z = nextZ(Z_, W3, lamda1, rho);
%     V = nextV(V_, W2, lamda2, lamda3, rho);
%     
%     %update theta_tilde, V_tilde, Z_tilde (tilde denoted with '_' after the
%     %variable
%     gamma = nextGamma(W1, W2, W3, theta, V, Z, rho);
%     theta_ = nextTheta_(theta, W1, gamma, rho);
%     V_ = nextV_(V,W2,gamma,rho);
%     Z_ = nextZ_(Z,W3,gamma,rho);
%     
%     %update W
%     W1 = W1 + theta - theta_;
%     W2 = W2 + V - V_;
%     W3 = W3 + Z - Z_;
%     
%    
%     theta = Z + V + V';	
%     if(mod(iter, 10) == 0) 
%         disp(['Current Iteration : ' , num2str(iter)]);
%     end
%     iter = iter + 1;
%     
%     sc_val = sum(sum((theta-theta_old).^2))./sum(sum((theta_old).^2));
%     theta_old = theta;
% 
% end
toc;
lsfnval = lossFunctionGaussGraphModel(theta, S, Z, V, lamda1, lamda2, lamda3);

end
