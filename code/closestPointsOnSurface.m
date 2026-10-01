function [C] = closestPointsOnSurface(S,X)

n = size(X,1);
best = inf(n,1);  
C = zeros(n,3);  

% legközelebbi pont az A-B szakaszon (P: n×3, A,B: 1×3)
seg = @(P,A,B) A + min(max(((P-A)*(B-A)')/((B-A)*(B-A)'), 0), 1) .* (B-A);

for k = 1 : size(S.F,1)

    a = S.V(S.F(k,1),:);
    b = S.V(S.F(k,2),:);
    c = S.V(S.F(k,3),:);
    N = cross(b-a, c-a);  
    NN = N*N';                

    % vetítés a háromszög síkjára
    Q = X - ((X-a)*N')/NN .* N;

    % baricentrikus koordináták: u az a, v a b súlya
    u = (cross(repmat(c-b,n,1), Q-b, 2)*N')/NN;
    v = (cross(repmat(a-c,n,1), Q-c, 2)*N')/NN;
    inside = (u >= 0) & (v >= 0) & (u+v <= 1);

    % ha a vetület kívül van, a legközelebbi pont valamelyik élen van
    E1 = seg(X,a,b);  
    E2 = seg(X,b,c);  
    E3 = seg(X,c,a);

    T = E1;  
    dt = sum((X-E1).^2, 2);
    d2 = sum((X-E2).^2, 2);
    m = d2 < dt;

    T(m,:) = E2(m,:);  
    dt(m) = d2(m);
    d3 = sum((X-E3).^2, 2);  
    m = d3 < dt;  
    
    T(m,:) = E3(m,:);
    T(inside,:) = Q(inside,:);                      

    % a globálisan legjobb megjegyzése
    d = sum((X-T).^2, 2);
    m = d < best;
    best(m) = d(m);  
    C(m,:) = T(m,:);  
end
end