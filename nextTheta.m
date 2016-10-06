function theta = nextTheta(theta_, W1, S, rho)
    temp = theta_ - W1 - S/rho;
    [U,D] = eig(temp);
    tsqr = sqrt(D.*D + (4/rho) .* eye(size(S,1)));
    theta = (1/2) .* U * (D + tsqr) * U';
end