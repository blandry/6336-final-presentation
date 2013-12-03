function [ ] = visualize2D( x )
%VISUALIZE2D Summary of this function goes here
%   Detailed explanation goes here

xtraj = x(1,:);
ytraj = x(2,:);
plot(xtraj, ytraj);

end

