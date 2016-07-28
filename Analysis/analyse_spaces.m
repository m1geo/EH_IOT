%% Preliminatires.
close all
clear

ActivityThreshold = 60; % seconds
NumberofBins = 500;

%filename = 'LOGGER07_DOOR_FINISHED_20150622_1600_TIMINGS.MAT';

%filename = 'LOGGER01_CAR_FINISHED_20150629_1610_TIMINGS.MAT';

filename = 'LOGGER01_ROOF_FINISHED_20150707_1610_TIMINGS.MAT';

%filename = 'LOGGER00_ROOF2_FINISHED_20150824_1700_TIMINGS.MAT';

load(filename);

figure(1)
hist (SolarharvestingDuration(SolarharvestingDuration<(1000*ActivityThreshold)),NumberofBins)
title ('Solar Harvesting Duration Histogram')
xlabel('Continious Harvesting Time / milliseconds')
ylabel('Frequency')

figure(2)
hist (PiezoharvestingDuration(PiezoharvestingDuration<(1000*ActivityThreshold)),NumberofBins)
title ('Piezo Harvesting Duration Histogram')
xlabel('Continious Harvesting Time / milliseconds')
ylabel('Frequency')

