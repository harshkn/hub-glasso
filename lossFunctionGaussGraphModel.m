function lsfnval = lossFunctionGaussGraphModel(theta, S, Z, V, lamda1, lamda2, lamda3)
    
    t1 = - log(det(theta)) + trace ( S .* theta);
    t2 = lamda1 * sum(sum(abs(Z- diag(diag(Z)))));
    t3sub = V- diag(diag(V));
    t3 = lamda2 * sum(sum(abs(t3sub)));
    t4 = lamda3 * sum(sqrt(sum(t3sub .^2)));
    lsfnval = t1 +  t2 + t3 + t4;

end