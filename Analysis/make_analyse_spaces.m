%% Preliminatires.

tic
close all
clear

%filename = 'LOGGER00_ROOF2_FINISHED_20150824_1700.CSV';
%resistorsolar = 4667; resistorpiezo = 42200; resistortherm = 42130; resistordiode = 38900;

%filename = 'LOGGER01_ROOF_FINISHED_20150707_1610.CSV';
%resistorsolar = 7190; resistorpiezo = 42200; resistortherm = 7170; resistordiode = 7160;

%filename = 'LOGGER01_CAR_FINISHED_20150629_1610.CSV';
%resistorsolar = 7190; resistorpiezo = 42200; resistortherm = 7170; resistordiode = 7160;

filename = 'LOGGER07_DOOR_FINISHED_20150622_1600.CSV';
resistorsolar = 7190; resistorpiezo = 42200; resistortherm = 7170; resistordiode = 7160;


%% Get the raw data.
fprintf('Loading input data\n')
rawdata = importdata(filename, ',', 1);
rawtime  = rawdata.data(:,1); % milliseconds
rawsolar = rawdata.data(:,2);
rawdiode = rawdata.data(:,3);
rawtherm = rawdata.data(:,4);
rawpiezo = rawdata.data(:,5);
rawlight = rawdata.data(:,6);
rawtempe = rawdata.data(:,7);
rawhumid = rawdata.data(:,8);
trimmedlight = rawdata.data(:,6);
trimmedtempe = rawdata.data(:,7);
trimmedhumid = rawdata.data(:,8);






searchingset = rawsolar;
TH = 80;
figure(1)
subplot(3,1,1)
plot(rawtime/1000, rawlight)
title ('Lux values')
subplot(3,1,2)
hold on
plot(rawtime/1000, searchingset)
plot(rawtime/1000, TH*ones(1,length(rawtime)),'k')
title ('Raw ADC Data & ADC Threshold')
hold off
subplot(3,1,3)
plot([0; rawtime/1000; max(rawtime/1000)+1], [-1; searchingset>TH; 2])
title ('Active or not?')
%% Operating variables
harvestStart = 1;
harvestStop = 1;
n = harvestStart;
harvestingStartT = [];
harvestingStopT = [];
%% find all the references first.
fprintf('Searching Data for On periods\n')
while n < (length(rawtime))
    % scan through file while NOT harvesting
    while ((searchingset(n) <= TH) && (n < (length(rawtime))))
        %fprintf('OFF ');
        %disp([1 n rawsolar(n) rawpiezo(n)])
        n = n + 1;
    end
    % here, the harvesting has stopped
    harvestStart = n;
    harvestingStartT = [harvestingStartT; rawtime(harvestStart)];
    % scan through file while harvesting happens
    while ((searchingset(n) > TH) && (n < (length(rawtime))))
        %fprintf('ON ');
        %disp([0 n rawsolar(n) rawpiezo(n)])
        n = n + 1;
    end
    % once here, harvesting is happening in both sections
    harvestStop = n;
    harvestingStopT = [harvestingStopT; rawtime(harvestStop)];
end
fprintf('Calculating On intervals\n')
harvestingtimes = (harvestingStopT-harvestingStartT);
fprintf('Plotting Figures\n')
figure(2)
hist (harvestingtimes(harvestingtimes<(1000*60)),500)
title ('Harvesting Duration Histogram')
xlabel('Continious Harvesting Time / milliseconds')
ylabel('Frequency')
figure(3)
plot(rawtime,searchingset)
hold on
plot(harvestingStartT, ones(1,length(harvestingStartT)),'go')
plot(harvestingStopT, zeros(1,length(harvestingStopT)),'ro')
hold off

SolarharvestingStopT = harvestingStopT;
SolarharvestingStartT = harvestingStartT;
SolarharvestingDuration = harvestingtimes;



searchingset = rawpiezo;
TH = 0;
figure(4)
subplot(3,1,1)
plot(rawtime/1000, rawlight)
title ('Lux values')
subplot(3,1,2)
hold on
plot(rawtime/1000, searchingset)
plot(rawtime/1000, TH*ones(1,length(rawtime)),'k')
title ('Raw ADC Data & ADC Threshold')
hold off
subplot(3,1,3)
plot([0; rawtime/1000; max(rawtime/1000)+1], [-1; searchingset>TH; 2])
title ('Active or not?')
%% Operating variables
harvestStart = 1;
harvestStop = 1;
n = harvestStart;
harvestingStartT = [];
harvestingStopT = [];
%% find all the references first.
fprintf('Searching Data for On periods\n')
while n < (length(rawtime))
    % scan through file while NOT harvesting
    while ((searchingset(n) <= TH) && (n < (length(rawtime))))
        %fprintf('OFF ');
        %disp([1 n rawsolar(n) rawpiezo(n)])
        n = n + 1;
    end
    % here, the harvesting has stopped
    harvestStart = n;
    harvestingStartT = [harvestingStartT; rawtime(harvestStart)];
    % scan through file while harvesting happens
    while ((searchingset(n) > TH) && (n < (length(rawtime))))
        %fprintf('ON ');
        %disp([0 n rawsolar(n) rawpiezo(n)])
        n = n + 1;
    end
    % once here, harvesting is happening in both sections
    harvestStop = n;
    harvestingStopT = [harvestingStopT; rawtime(harvestStop)];
end
fprintf('Calculating On intervals\n')
harvestingtimes = (harvestingStopT-harvestingStartT);
fprintf('Plotting Figures\n')
figure(5)
hist (harvestingtimes(harvestingtimes<(1000*60)),500)
title ('Harvesting Duration Histogram')
xlabel('Continious Harvesting Time / milliseconds')
ylabel('Frequency')
figure(6)
plot(rawtime,searchingset)
hold on
plot(harvestingStartT, ones(1,length(harvestingStartT)),'go')
plot(harvestingStopT, zeros(1,length(harvestingStopT)),'ro')
hold off

PiezoharvestingStopT = harvestingStopT;
PiezoharvestingStartT = harvestingStartT;
PiezoharvestingDuration = harvestingtimes;


%% Save the data out.
fprintf('Saving output data\n')
matfile  = strrep(filename, '.CSV', '_TIMINGS.MAT');
save(matfile, 'SolarharvestingStopT', 'SolarharvestingStartT', 'SolarharvestingDuration', 'PiezoharvestingStopT', 'PiezoharvestingStartT', 'PiezoharvestingDuration');

toc