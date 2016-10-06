%% Number of correctly estimated edges

true_edges = abs(true_theta) > 0 ;
est_edges = abs(theta) > (10^-5);
out.total_true_edges = sum(sum(triu(true_edges,1)));
out.total_est_edges = sum(sum(triu(est_edges,1)));
out.est_correct_edges = sum(sum(triu(true_edges .* est_edges, 1)));

%% Proportion of correctly estimated hub edges 

temptrtheta = true_theta;
temptheta = theta;
temptrtheta(logical(eye(size(temptrtheta)))) = 0;
temptheta(logical(eye(size(temptheta)))) = 0;
only_true_hubedges = temptrtheta(:,true_hubcol);
only_est_hubedges = temptheta(:,true_hubcol);

tr_hub_edges = abs(only_true_hubedges) > 0 ;
est_hub_edges = abs(only_est_hubedges) > (10^-5);
out.prop_1 = sum(sum(tr_hub_edges .* est_hub_edges)) / sum(sum(tr_hub_edges));

%% Proportion of correctly estimated hub nodes 

out.prop_2 = numel(intersect(true_hubcol,est_hubcol)) / numel(true_hubcol);

%% Sum of squared error 

out.sse = sum(sum(triu(theta - true_theta,1) .^ 2)) ;

%%
if(perf == 1)
out.all = [out.total_est_edges out.est_correct_edges out.prop_1 out.prop_2 out.sse out.bic];
end



