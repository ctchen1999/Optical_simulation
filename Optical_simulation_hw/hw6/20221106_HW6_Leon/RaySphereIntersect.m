function [ t ] = RaySphereIntersect( ray, sphere )

L = sphere.center - ray.origin;
tca = dot(L, ray.direction);

if tca < 0
    t = -1;
    return
end

d2 = norm(L)^2 - tca^2;
r2 = sphere.radius^2;
if d2 < r2
    thc = sqrt(r2 - d2);

    t1 = tca - thc;
    if t1 > 0
        t = t1;
    else
        t = tca + thc;
    end
else
    t = -1;
end

end

