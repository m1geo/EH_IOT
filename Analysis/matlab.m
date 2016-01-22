filename = 'LOGGER01_FINISHED_20150527_1748.CSV';

rawdata = importdata(filename, ',', 1);
rawtime  = rawdata.data(:,1);
rawsolar = rawdata.data(:,2);
rawpiezo = rawdata.data(:,5);
totaltime = max(rawtime) / 1000;

aref = 5.00; % volts
adcres = 10; % bits

resistorsolar = 7190;
resistorpiezo = 7170; %7170

voltagesolar = rawsolar .* (aref/((2^adcres)-1));
voltagepiezo = rawpiezo .* (aref/((2^adcres)-1));

powersolar = (voltagesolar.^2) ./ resistorsolar;
powerpiezo = (voltagepiezo.^2) ./ resistorpiezo;

powersolarCumulative = cum(powersolar);
powerpiezoCumulative = cum(powerpiezo);

energysolar = sum(powersolar) / totaltime;
energypeizo = sum(powerpiezo) / totaltime;

close all

figure(1)

subplot(4,1,1)
plot (rawtime, powersolar.*1000, 'k')
title('Harvested Energy for Solar Cells');
xlabel('Time Sample / milliseconds');
ylabel('Energy Harvested / milliWatt');

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

text (0,-3,filename)
