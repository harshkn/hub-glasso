function Z = nextZ(Z_, W3, lamda1, rho)
    Z = softThreshold(Z_-W3, lamda1/rho); %diag(Z) ??
    Z(logical(eye(size(Z)))) = diag(Z_ - W3);
end