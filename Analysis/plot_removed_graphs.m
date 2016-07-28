fn = {'LOGGER00_ROOF2_FINISHED_20150824_1700_REMOVEDSPACES_SOLAR.MAT' 'LOGGER01_CAR_FINISHED_20150629_1610_REMOVEDSPACES_SOLAR.MAT' 'LOGGER01_ROOF_FINISHED_20150707_1610_REMOVEDSPACES_SOLAR.MAT' 'LOGGER07_DOOR_FINISHED_20150622_1600_REMOVEDSPACES_SOLAR.MAT'};
%fn = {'LOGGER00_ROOF2_FINISHED_20150824_1700_REMOVEDSPACES_PIEZO.MAT' 'LOGGER01_CAR_FINISHED_20150629_1610_REMOVEDSPACES_PIEZO.MAT' 'LOGGER01_ROOF_FINISHED_20150707_1610_REMOVEDSPACES_PIEZO.MAT' 'LOGGER07_DOOR_FINISHED_20150622_1600_REMOVEDSPACES_PIEZO.MAT'};
%fn = {'LOGGER00_ROOF2_FINISHED_20150824_1700_REMOVEDSPACES_SOLARPIEZO.MAT' 'LOGGER01_CAR_FINISHED_20150629_1610_REMOVEDSPACES_SOLARPIEZO.MAT' 'LOGGER01_ROOF_FINISHED_20150707_1610_REMOVEDSPACES_SOLARPIEZO.MAT' 'LOGGER07_DOOR_FINISHED_20150622_1600_REMOVEDSPACES_SOLARPIEZO.MAT'};
sn = {'Roof 2' 'Car Boot' 'Roof' 'Office Door'};

files = 4;
histbins = 200;

close all

for M=1:2
    for N=1:files
        disp(fn{N})
        load(fn{N})
                
        % select the correct dataset for harvesting technology
        switch M
            case 1
                power = powersolar;
                tech = 'Solar';
            case 2
                power = powerpiezo;
                tech = 'Piezo';
            case 3
                power = powertherm;
                tech = 'Thermal';
            case 4
                power = powerdiode;
                tech = 'Diode';
            otherwise
                error('Problem')
        end
        
        figure(((M-1)*(files+1))+1)
        subplot(files,1,N);
        plot(power)
        xlabel('Time / s')
        ylabel('Energy / W')
        title([sn{N} ' ' tech],'Interpreter','none')

        figure(((M-1)*(files+1))+2)
        subplot(files,1,N);
        binsize = (max(power)/histbins);
        hist(power, histbins);
        ylabel('Frequency')
        xlabel('Momentary Energy / W')
        title([sn{N} ' ' tech ' Histogram - ' num2str(binsize)],'Interpreter','none')

        figure(((M-1)*(files+1))+3)
        subplot(files,1,N);
        binsize = (max(power)/histbins);
        hist(power, histbins);
        set(gca, 'YScale', 'log')
        ylabel('Frequency (log)')
        xlabel('Momentary Energy / W')
        title([sn{N} ' ' tech ' Log-Histogram - ' num2str(binsize)],'Interpreter','none')

        figure(((M-1)*(files+1))+4)
        subplot(files,1,N);
        cdfX=0:binsize:max(power); cdfX(size(cdfX,2))=[];
        j=cum(hist(power, histbins));
        plot(cdfX,j)
        ylabel('Density')
        xlabel('Momentary Energy / W')
        title([sn{N} ' ' tech ' CDF - ' num2str(binsize)],'Interpreter','none')
        
        figure(((M-1)*(files+1))+5)
        subplot(files,1,N);
%         if N==3
%             s=107.8317; % awful attempt at LUX SCALING
%         else
%             s=1;
%         end
%         plot(rawlight.*s)
        plot(rawlight)
        ylabel('Luminosity / Lux')
        xlabel('Time / s')
        title([sn{N} ' ' tech ' Lux Levels: P' num2str(max(rawlight)) ' A' num2str(mean(rawlight))])
    end
end
