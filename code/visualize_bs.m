function visualize_bs(R, center)

[X, Y, Z] = sphere(50); 

X = X * R + center(1);
Y = Y * R + center(2);
Z = Z * R + center(3);

surf(X, Y, Z, FaceAlpha=0.2);

end