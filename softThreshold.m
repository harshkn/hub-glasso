function st = softThreshold(x, thres) 
    st = sign(x).*max(abs(x) - thres,0);
end
