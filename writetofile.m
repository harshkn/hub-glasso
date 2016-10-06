

%%
fid = fopen(fn,'a');
fprintf(fid, 'Simulation iteration: %d  \n', simulations);
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