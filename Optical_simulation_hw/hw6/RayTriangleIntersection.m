function [ t ] = RayTriangleIntersection(ray, triangle)
edge0 = triangle.point2 - triangle.point1;
edge1 = triangle.point3 - triangle.point2;
edge2 = triangle.point1 - triangle.point3;
N = cross(triangle.point2 - triangle.point1, triangle.point3- triangle.point1);
D = -dot(triangle.point1, N);
t = -(dot(N, ray.origin) + D) / dot(N, ray.direction);
if t < 0 % the triangle is behind
    t = -1;
end
P = ray.origin + t * ray.direction;
if dot(N, ray.direction < 0.01) % ray direction almost paraller to normal 
    t = -1;
end

co = P - triangle.point1;
c1 = P - triangle.point2;
c2 = P - triangle.point3;

if dot(N, cross(edge0, co))>0 && dot(N, cross(edge1, c1))>0 && dot(N, cross(edge2, c2))>0
    t = 1;
else
    t = -1;
end