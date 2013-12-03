function [ ] = visualize3D( x, t )
%VISUALIZE3D Summary of this function goes here
%   Detailed explanation goes here

tdata = dlmread('/usr/local/MATLAB/R2013b/toolbox/aero/astdemos/asthl20log.csv',',',1,0);
N = size(tdata,1);
pitch = zeros(N,1);
for i=1:N-1
    u = [x(1,i);x(2,i)];
    v = [x(1,i+1);x(2,i+1)];
    d = v-u;
    pitch(i) = atan(d(2)/d(1));;
end
pitch(N) = pitch(N-1);

xtraj = x(1,1:N)';
ytraj = x(2,1:N)';
t = t(1:N);

% could just be a constant?
lat = convang(tdata(:,3),'deg','rad');

lng0 = convang(tdata(1,2),'deg','rad');
lngf = convang(tdata(end,2), 'deg','rad');
lng0s = xtraj(1);
lngfs = xtraj(end);
xtrajn = (xtraj-lng0s)/(lngfs-lng0s);
lng = xtrajn*(lngf-lng0)+lng0;

alt0 = tdata(1,4);
altf = tdata(end,4);
alt0s = ytraj(1);
altfs = ytraj(end);
ytrajn = (ytraj-alt0s)/(altfs-alt0s);
alt = ytrajn*(altf-alt0)+alt0;

%eulang = convang(tdata(:,5:7),'deg','rad');
eulang = [zeros(N,1),pitch,zeros(N,1)];

t0 = tdata(1,1);
tf = tdata(end,1);
t0s = t(1);
tfs = t(end);
tn = (t-t0s)/(tfs-t0s);
time = tn*(tf-t0)+t0;

ts = timeseries([lat,lng,alt,eulang],time);

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
h.InitialHeading = 113;
h.OffsetDistance = 4.72;
h.OffsetAzimuth = 0;

h.TimeScaling = 5;

GenerateRunScript(h);
system('. runfg.bat &');

play(h);

end

