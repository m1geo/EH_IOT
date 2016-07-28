filename = 'LOGGER00_ROOF2_FINISHED_20150824_1700.CSV';

rawdata = importdata(filename, ',', 1);
rawtime  = rawdata.data(:,1);
rawsolar = rawdata.data(:,2);
rawtherm = rawdata.data(:,4);
rawpiezo = rawdata.data(:,5);
rawlux = rawdata.data(:,6);
totaltime = max(rawtime) / 1000;

aref = 5.00; % volts
adcres = 10; % bits

resistorsolar = 4667;
resistorpiezo = 42130; % values for ROOF2 (Aug 15)
resistortherm = 38900;

voltagesolar = rawsolar .* (aref/((2^adcres)-1));
voltagepiezo = rawpiezo .* (aref/((2^adcres)-1));
voltagetherm = rawtherm .* (aref/((2^adcres)-1));

powersolar = (voltagesolar.^2) ./ resistorsolar;
powerpiezo = (voltagepiezo.^2) ./ resistorpiezo;
powertherm = (voltagetherm.^2) ./ resistortherm;

powersolarCumulative = cum(powersolar);
powerpiezoCumulative = cum(powerpiezo);
powerthermCumulative = cum(powertherm);

energysolar = sum(powersolar) / totaltime;
energypeizo = sum(powerpiezo) / totaltime;
energytherm = sum(powertherm) / totaltime;

close all

figure(1)

%subplot(4,1,1)
plotyy (rawtime, powersolar.*1000, rawtime, rawlux)
title('Harvested Energy for Solar Cells');
xlabel('Time Sample / milliseconds');
ylabel('Energy Harvested / milliWatt');

error('die')

subplot(4,1,2)
plot (rawtime, powersolarCumulative.*1000, 'k')
title('Cumulative Harvested Energy for Solar Cells');
xlabel('Time Sample / milliseconds');
ylabel('Cumulative Energy Harvested / milliJoules');

subplot(4,1,3)
plot (rawtime, powerpiezo.*1000, 'k')
title('Harvested Energy for Piezo Strip');
xlabel('Time Sample / milliseconds');
ylabel('Energy Harvested / milliWatt');

subplot(4,1,4)
plot (rawtime, powerpiezoCumulative.*1000, 'k')
title('Cumulative Harvested Energy for Piezo Strip');
xlabel('Time Sample / milliseconds');
ylabel('Cumulative Energy Harvested / milliJoules');

% subplot(6,1,5)
% plot (rawtime, powertherm.*1000, 'k')
% title('Harvested Energy for Thermal Pad');
% xlabel('Time Sample / milliseconds');
% ylabel('Energy Harvested / milliWatt');
% 
% subplot(6,1,6)
% plot (rawtime, powerthermCumulative.*1000, 'k')
% title('Cumulative Harvested Energy for Thermal Pad');
% xlabel('Time Sample / milliseconds');
% ylabel('Cumulative Energy Harvested / milliJoules');