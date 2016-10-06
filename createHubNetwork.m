

function [Theta,hubcol] =  createHubNetwork(P,sparsity, hubnumber, hubsparsity, type)

    %generating Erdos Reni network with positive and negative entries
    bin_data = binornd(1,1-sparsity,P,P);
    samp = randsample([-1,1],P*P, 'true');
    
    b = 0.75;
    a = 0.25;
    r = (b-a).*rand(P,P) + a;  
    
    Theta = bin_data .* reshape(samp, P,P) .* r;
    Theta = tril(Theta,-1) ;   
    Theta = Theta + Theta';
    
    % hub nodes and make it symmetric
    hubcol = randsample(1:P,hubnumber, 'false'); %choose hub columns randomly 
    samp = randsample([-1,1],hubnumber*P, 'true'); 
    samp = reshape(samp, hubnumber,P);
    bin_data = binornd(1,1-hubsparsity,hubnumber,P);
    r = (b-a).*rand(hubnumber,P) + a; 
    x = samp .* bin_data .* r;
    Theta(:,hubcol) = x';
    Theta = (Theta+ Theta')/2;
    
    if(strcmp(type,'binary'))
        samp = randsample([-1,1],P, 'true');     
        r = (b-a).*rand(1,P) + a; 
        x = samp .* bin_data .* r;
        Theta(logical(eye(size(Theta)))) = r .* x;
        return;
    end

    %making matrix positive definite 
    
    Theta = Theta - (min(eig(Theta))-.1) * eye(P);
    if(strcmp(type, 'covariance'))
        
    end

end