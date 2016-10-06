function V = nextV(V_, W2, lamda2, lamda3, rho)
    sV = size(V_);
    t1 = (diag(V_ - W2));
    C = V_ - W2 - diag(t1) ;
    V = zeros(sV(1));
    for j = 1: sV(1)
        try
            t3 = softThreshold(C(:,j), lamda2/rho);
            t4 = max(0, 1 - (lamda3/(rho * norm(t3))) );
            V(:,j) = t4 .* t3;
            vs = size(V,1);
            V(1:vs+1:end) = t1;
            
%             V(logical(eye(size(V)))) = t1;
            
            

        catch ME 
            msg = 'Error occurred in nextV()';
            rethrow(ME)
        end
        
    end
    
