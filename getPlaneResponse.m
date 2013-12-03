function [ x ] = getPlaneResponse( x0, u, tf, dt )
%GETPLANERESPONSE Summary of this function goes here
%   Detailed explanation goes here

f = @(x,u) fplane(x,u);
df = @(x,u) dfplane(x,u);

% simulating the plane
x = traprule(f,df,u,x0,tf,dt);

end

