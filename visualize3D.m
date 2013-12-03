function [ ] = visualize3D( x )
%VISUALIZE3D Summary of this function goes here
%   Detailed explanation goes here

xtraj = x(1,:);
ytraj = x(2,:);
comet3(xtraj, zeros(1,size(xtraj,2)), ytraj);

end

