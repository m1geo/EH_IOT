

function data = energyHarvestPlot(csvFilePath)

x = importdata(csvFilePath, ',', 1);
x.filename = csvFilePath;

% Nearest minute only
splitPath = strsplit(csvFilePath, '_');
pathParts = length(splitPath);
timeCSV = strsplit(splitPath{pathParts}, '.');

hourMin = timeCSV{1};
yearMonthDay = splitPath{pathParts - 1};

formatIn = ['yyyymmdd' 'HHMM' 'SS' 'FFF'];

x.endDate = datenum([yearMonthDay hourMin '00' '000'], formatIn);
maxMS = x.data(end,1);
x.startDate = addtodate(x.endDate, -maxMS, 'millisecond');



data = x;
drawSolarPlot(x);
drawThermalPlot(x);
drawPeizoPlot(x);


% %% Round up endDate to nearest 3 hour period
% endDateVec = datevec([yearMonthDay hourMin '00' '000'], formatIn);
% axisEndDate = endDateVec;
% axisEndDate(4) = ceil(axisEndDate(4) / 3) * 3;
% axisEndDate = datenum(axisEndDate);
% 
% xTicksCount = ???;
% xTickLabels = cell(xTicksCount, 1);
% xTickValues = cell(xTicksCount, 1);
% 
% i = xTicksCount;
% currentDate = axisEndDate;
% currentMS =  maxMS + (axisEndDate - x.endDate) * 1000;
% 
% while(currentDate > x.startDate)
%     
%     xTickValues{i} = currentMS;
%     xTickLabels{i} = datestr(currentDate, 'dd/mm HH:MM');
%     
%     i--;
%     
%     
% end


end


function drawSolarPlot(x)

    plot(x.data(:,1), x.data(:,[2,6]));

    xTickPoints = get(gca,'XTick');
    xTickPointsCount = length(xTickPoints);
    xTickLabels = cell(xTickPointsCount,1);

    for i = 1:xTickPointsCount

        tickDateTime = addtodate(x.startDate, xTickPoints(i), 'millisecond');

        xTickLabels{i} = datestr(tickDateTime, 'dd/mm HH:MM');

    end

    set(gca, 'XTickLabel', xTickLabels);
    title('Solar Energy Harvested');
    xlabel('Date/Time');
    
    savefig('solarPlot.fig');

end

function drawThermalPlot(x)

    plot(x.data(:,1), x.data(:,[4,7]));

    xTickPoints = get(gca,'XTick');
    xTickPointsCount = length(xTickPoints);
    xTickLabels = cell(xTickPointsCount,1);

    for i = 1:xTickPointsCount

        tickDateTime = addtodate(x.startDate, xTickPoints(i), 'millisecond');

        xTickLabels{i} = datestr(tickDateTime, 'dd/mm HH:MM');

    end

    set(gca, 'XTickLabel', xTickLabels);
    title('Thermal Energy Harvested');
    xlabel('Date/Time');
    
    savefig('thermalPlot.fig');
end

function drawPeizoPlot(x)

    plot(x.data(:,1), x.data(:,5));

    xTickPoints = get(gca,'XTick');
    xTickPointsCount = length(xTickPoints);
    xTickLabels = cell(xTickPointsCount,1);

    for i = 1:xTickPointsCount

        tickDateTime = addtodate(x.startDate, xTickPoints(i), 'millisecond');

        xTickLabels{i} = datestr(tickDateTime, 'dd/mm HH:MM');

    end

    set(gca, 'XTickLabel', xTickLabels);
    title('Peizoelectric Energy Harvested');
    xlabel('Date/Time');
    
    savefig('peizoPlot.fig');

end