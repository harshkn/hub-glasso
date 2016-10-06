function est_hcol = getNodeColumns(V,r)
    V(logical(eye(size(V)))) = 0;
    est_hcol = find(sum(~~real(V), 1)>r);
    
end