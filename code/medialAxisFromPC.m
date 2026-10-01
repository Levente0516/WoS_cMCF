function r = medialAxisFromPC(S, P, n, r0, tol, maxIter)

r = r0 * ones(size(P,1),1);

active = true(size(r));

for it = 1 : maxIter
  
    idx = find(active);

    if isempty(idx)
        break;
    end

    c = P(idx,:) + r(idx) .* n(idx,:);
    q = closestPointsOnSurface(S,c);

    converged = (r(idx) - vecnorm(c - q, 2, 2)) < tol * r(idx);
    active(idx(converged)) = false;

    idx = idx(~converged);
    q   = q(~converged,:);

    if isempty(idx) 
        break; 
    end

    w = q - P(idx,:);
    rNew = sum(w.^2, 2) ./ (2 * max(sum(w .* n(idx,:), 2), eps));
    r(idx) = min(r(idx), rNew);

end