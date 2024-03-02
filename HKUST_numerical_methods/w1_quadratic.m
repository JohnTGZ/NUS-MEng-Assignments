clear all; close all; clc;


[p, q ] = quadratic_formula(1, -10^(12), 1)

function [p,q ] = quadratic_formula(a,b, c)
    p = (-b + sqrt(b^2 - 4*a*c))/(2*a);
    q = (-b - sqrt(b^2 - 4*a*c))/(2*a);
end 