function [ df ] = dfplane( x,u )
%DFPLANE Summary of this function goes here
%   Detailed explanation goes here

m = 1;          % mass of the plane in kg
p = 1.2041;     % air density

Al = 1;         % airfoil area
L = 1.5;        % lift coefficient
kl = (0.5*p*Al*L)/m;

Ad = 0.1;       % area of the wing generating drag
D = 1.5;        % drag coefficient
kd = (0.5*p*Ad*D)/m;

df=zeros(size(x,1),size(x,1));
df(:,3)=[1;0;-2*kd*x(3);2*kl*x(3)];
df(:,4)=[0;1;0;0];

end

