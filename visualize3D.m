function [ ] = visualize3D( x, t )
%VISUALIZE3D Summary of this function goes here
%   Detailed explanation goes here

% to get some sensible boundaries from another simulation
tdata = dlmread('/usr/local/MATLAB/R2013b/toolbox/aero/astdemos/asthl20log.csv',',',1,0);

N = size(x,2);

xtraj = x(1,:)';
ytraj = x(2,:)';

altmin = 0;
ymin = min(ytraj);
ymax = max(ytraj);
altmax = min(10*ymax,10000);
ytrajn = (ytraj-ymin)/(ymax-ymin);
alt = ytrajn*(altmax-altmin)+altmin;

coordsref = convang(tdata(:,[3 2]), 'deg', 'rad');
coordsstart = coordsref(1,:);
coordsend = coordsref(end,:);
xmin = min(xtraj);
xmax = max(xtraj);
xtrajn = (xtraj-xmin)/(xmax-xmin);
coords = xtrajn*(coordsend-coordsstart)+repmat(coordsstart,N,1);

pitch = zeros(N,1);
for i=2:N-1
    hdist = pos2dist(coords(i-1,1),coords(i-1,2),coords(i,1),coords(i,2),2)*1000;
    vdist = alt(i)-alt(i-1);
    pitch(i) = convang(atan(vdist/hdist),'deg','rad');
end

eulang = [zeros(N,1),pitch,2.0577*ones(N,1)];

% scales time to make it play nicely
t0 = tdata(1,1);
tf = tdata(end,1);
t0s = t(1);
tfs = t(end);
tn = (t-t0s)/(tfs-t0s);
time = tn*(tf-t0)+t0;

ts = timeseries([coords,alt,eulang],time);

h = Aero.FlightGearAnimation;
h.TimeseriesSourceType = 'Timeseries';
h.TimeseriesSource = ts;

h.FlightGearBaseDirectory = '/usr/share/games/flightgear';
h.FlightGearVersion = '2.10';
h.GeometryModelName = 'ASK13';
h.DestinationIpAddress = '127.0.0.1';
h.DestinationPort = '5502';

h.AirportId = 'KSFO';
h.RunwayId = '10L';
h.InitialAltitude = alt(1);
h.InitialHeading = 2.0577;
h.OffsetDistance = 4.72;
h.OffsetAzimuth = 0;

h.TimeScaling = 10;

GenerateRunScript(h);
system('. runfg.bat &');

play(h);

end

