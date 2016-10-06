function bic = computeBIC(S,theta,Z, V, n, p , c, v)


t1 = - (n .* log(det(theta))) + (n.* trace ( S * theta));
termZ = log(n) .* (sum(sum(abs(Z) ~= 0)) - p ) ./2;
tmpV = V + V';
tmpV(logical(eye(size(tmpV)))) = 0;
termV = log(n) .* ( v + c .* ((sum(tmpV(:) ~= 0) - v) ./ 2));

bic = t1 + termZ + termV;

end

