[V,F] = read_obj_file('spot_triangulated.obj');
trisurf(F,V(:,1),V(:,2),V(:,3), FaceColor='w', FaceAlpha='0.3'); 
axis equal;

S.V = V;
S.F = F;

hold on
profile on
M = medialAxisPointCloud(S);
profile viewer
hold off
