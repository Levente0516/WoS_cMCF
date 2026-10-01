function M = medialAxisPointCloud(S)

%Medial ball extraction
%Scattering points densly inside a ball in R^3 with a radius
%of the half of the diagonal of the bounding box contaning S

bb = getBoundingBox(S);

center = mean(bb);
r = norm(bb(2,:) - bb(1,:)) / 2;

%Optionally visualize the bounding sphere
%visualize_bs(R,center);

%exact number of needed scattered points is not discussed in the paper
N = 10^3;
d = randn(N,3);                
d = d ./ vecnorm(d,2,2);            
rr = r * rand(N,1).^(1/3);       
X = center + d .* rr;  

%Optionally visualize the scattered points
%scatter3(X(:,1), X(:,2), X(:,3), 2, 'filled');

P   = closestPointsOnSurface(S, X);
n1  = X - P;
len = vecnorm(n1, 2, 2);
ok  = len > 1e-9;              
P = P(ok,:);
n1  = n1(ok,:) ./ len(ok);     
n2  = -n1;                      

%Medial axis extraction from point cloud using the method of Ma et al. [2012]

tol     = 1e-3;     % termination tolerance (the paper's "adjusted termination criteria")
maxIter = 100;

R = r*2;

r1 = medialAxisFromPC(S, P, n1, R, tol, maxIter);
r2 = medialAxisFromPC(S, P, n2, R, tol, maxIter);

rm = min(r1, r2);
Cb = [P + rm.*n1; P + rm.*n2];
rb = [rm; rm];

s = 1.15;                               % the paper's default
[M,Rm] = pruneMedialBalls(Cb, rb, s);

scatter3(M(:,1), M(:,2), M(:,3), 4, 'red', 'filled');

end