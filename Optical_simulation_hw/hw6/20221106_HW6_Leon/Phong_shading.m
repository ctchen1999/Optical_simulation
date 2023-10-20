function ilumi = Phong_shading(N, L, V, obj_color, light)
%% variables
% diffusion coefficient
D = 0.6;
% specular coefficient
S = 0.2;
Alpha = 10;
%% diffuse
L_cos = dot(L, N);
cosTheta = max([L_cos 0]);
diffuse = D * obj_color .* light.color * cosTheta;

%% specular
L_sin = L - L_cos*N;
R = L_cos*N - L_sin;

cosTheta = max([dot(R, V) 0]);
total = cosTheta^Alpha;
specular = S * light.color * total;

%% return
ilumi = diffuse + specular;
end