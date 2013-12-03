function [ x ] = foreulerplane( x0, u, tf, dt )
%TRAPRULEPLANE Summary of this function goes here
%   Detailed explanation goes here

f = @(x,u) fplane(x,u);
df = @(x,u) dfplane(x,u);
x = foreuler(f,df,u,x0,tf,dt);

end

