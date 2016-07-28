global pshist
global xvar
global inputdata

%load('../EnergyData/COMBINED_VARIABLES_SOLAR.MAT')
%inputdata = powersolar_door;

%load('../EnergyData/COMBINED_VARIABLES_PIEZO.MAT')
inputdata = powerpiezo_roof;

pshist = hist(inputdata,200);
xvar = linspace(min(pshist),max(pshist),size(pshist,2));

