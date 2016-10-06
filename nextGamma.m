function gamma = nextGamma(W1, W2, W3, theta, V, Z, rho)
    gamma = (rho/6)*  ((theta + W1) - (V + W2) - (V + W2)' - (Z+W3));
end