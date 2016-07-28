%% Preliminatires.
clear

filename = 'LOGGER00_ROOF2_FINISHED_20150824_1700.CSV';
resistorsolar = 4667; resistorpiezo = 42200; resistortherm = 42130; resistordiode = 38900;

%filename = 'LOGGER01_ROOF_FINISHED_20150707_1610.CSV';
%resistorsolar = 7190; resistorpiezo = 42200; resistortherm = 7170; resistordiode = 7160;

%filename = 'LOGGER01_CAR_FINISHED_20150629_1610.CSV';
%resistorsolar = 7190; resistorpiezo = 42200; resistortherm = 7170; resistordiode = 7160;

%filename = 'LOGGER07_DOOR_FINISHED_20150622_1600.CSV';
%resistorsolar = 7190; resistorpiezo = 42200; resistortherm = 7170; resistordiode = 7160;

minDwell = 300*1000; % milliseconds

%% Get the raw data.
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

%% Operating variables
harvestStart = 1;
harvestStop = 1;
harvestDwell = 1;
n = harvestStart;
removecells = [];

%% find all the references first.
while n < (length(rawtime))
    
    % dont need this as we're running sequentially through N anyway
    %n = harvestStart;
    
    % scan through file while harvesting happens
    while ((rawsolar(n) > 0) && (rawpiezo(n) > 0) && (n < (length(rawtime))))
    %while ((rawsolar(n) > 0) && (n < (length(rawtime))))
    %while ((rawpiezo(n) > 0) && (n < (length(rawtime))))
        %fprintf('H');
        %disp([1 n rawsolar(n) rawpiezo(n)])
        n = n + 1;
    end
    % here, the harvesting has stopped
    harvestStop = n;
    
    % scan through file while NOT harvesting on BOTH
    while ((rawsolar(n) == 0) || (rawpiezo(n) == 0) && (n < (length(rawtime))))
    %while ((rawsolar(n) == 0) && (n < (length(rawtime))))
    %while ((rawpiezo(n) == 0) && (n < (length(rawtime))))
        %fprintf('S');
        %disp([0 n rawsolar(n) rawpiezo(n)])
        n = n + 1;
    end
    % once here, harvesting is happening in both sections
    harvestStart = n;
    
    harvestDwell = rawtime(harvestStart) - rawtime(harvestStop);
    
    if (harvestDwell >= minDwell)
        fprintf('Stop: %d (%d ms)  Start again: %d (%d ms) (dwell %d ms)\n', harvestStop, rawtime(harvestStart)/1e7, harvestStart, rawtime(harvestStop)/1e7, harvestDwell);
        removecells = [removecells; [harvestStop harvestStart]];
    end
end

%% show what we have found.
removecells

%% go through the list backwards so we don't break any of the cell references.
for n = size(removecells,1):-1:1
    tmp=removecells(n,:);
    a=tmp(1);
    b=tmp(2);
    fprintf('Deleting from %d to %d:  ', a, b)
    rawtime(a:b) = [];
    rawsolar(a:b) = [];
    rawtherm(a:b) = [];
    rawpiezo(a:b) = [];
    rawdiode(a:b) = [];
    trimmedlight(a:b) = [];
    trimmedtempe(a:b) = [];
    trimmedhumid(a:b) = [];
    
    fprintf('OK\n')
end

%% progess data from raw to meaninful units.

aref = 5.00; % volts
adcres = 10; % bits

% load resistors for technologies
%resistorsolar = 7190;
%resistorpiezo = 42200;
%resistortherm = 7170;
%resistordiode = 7170;


% calculate time
scaledtime = rawtime/1000; % seconds
totaltime = max(scaledtime); % seconds

% Rest of code for energy conversion
voltagesolar = rawsolar .* (aref/((2^adcres)-1));
voltagepiezo = rawpiezo .* (aref/((2^adcres)-1));
voltagetherm = rawtherm .* (aref/((2^adcres)-1));
voltagediode = rawdiode .* (aref/((2^adcres)-1));

powersolar = (voltagesolar.^2) ./ resistorsolar;
powerpiezo = (voltagepiezo.^2) ./ resistorpiezo;
powertherm = (voltagetherm.^2) ./ resistortherm;
powerdiode = (voltagediode.^2) ./ resistordiode;

powersolarCumulative = cum(powersolar);
powerpiezoCumulative = cum(powerpiezo);
powerthermCumulative = cum(powertherm);
powerdiodeCumulative = cum(powerdiode);

energysolar = sum(powersolar) / totaltime;
energypeizo = sum(powerpiezo) / totaltime;
energytherm = sum(powertherm) / totaltime;
energydiode = sum(powerdiode) / totaltime;

%% Save the data out.
%matfile  = strrep(filename, '.CSV', '_REMOVEDSPACES_SOLARPIEZO.MAT');
%save(matfile, 'scaledtime', 'powersolar', 'powerdiode', 'powerpiezo', 'powertherm', 'rawlight', 'rawtempe', 'rawhumid', 'trimmedlight', 'trimmedtempe', 'trimmedhumid');