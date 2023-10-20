function [t1,t2,P1_analytical,P2_analytical] = analyticSolution(normalized_D, origin, center, radius)
t = zeros([1,2]);
a = normalized_D.^2;
b = 2.*normalized_D.*(origin - center);
c = power(abs(origin - center),2) - radius^2;
t1 = (-b + sqrt(b.^2 - 4.*a.*c))./(2*a);
t2 = (-b - sqrt(b.^2 - 4.*a.*c))./(2*a);
P1_analytical = origin + t1 .* normalized_D
P2_analytical = origin + t2 .* normalized_D
% N1_analytical = normalize(P1_analytical, 'norm');
% N2_analytical = normalize(P2_analytical, 'norm');
end