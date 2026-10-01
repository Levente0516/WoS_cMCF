function [M, Rm] = pruneMedialBalls(Cb, rb, s)

n = size(Cb,1);
removed = false(n,1);

[~, ord] = sort(rb, 'descend');         % process the big balls first

for j = ord'
    if removed(j)
        continue;                       % whatever j contains, its container already removed
    end
    dd = vecnorm(Cb - Cb(j,:), 2, 2);   % distances of all centers from center j
    inside = (rb < rb(j)) & (s*rb + dd <= s*rb(j));
    removed(inside) = true;
end

M  = Cb(~removed,:);
Rm = rb(~removed);

end