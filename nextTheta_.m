function theta_ = nextTheta_(theta, W1, gamma, rho)
    theta_ =  W1+theta-gamma/rho;
end