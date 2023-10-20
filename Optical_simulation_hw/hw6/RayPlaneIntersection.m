function [ t ] = RayPlaneIntersection(ray, plane)
t = dot((plane.point - ray.origin), plane.normal) / dot(ray.direction, plane.normal);
end