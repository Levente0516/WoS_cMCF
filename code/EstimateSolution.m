function u = EstimateSolution(S, C, x, Np, Nv, epsilon)

M = medialAxisPointCloud(S);
u_sum = 0;
for n = 1 : Np
    u_hat = RecursiveEstimate(S, M, C, Nv, x, epsilon);
    u_sum = u_sum + u_hat;
end

u = u_sum/Np;

end