global pshist
global xvar
global inputdata

load('GOOD_SOLAR_PIEZO.MAT')
load('optimised_both.mat')

%% SOLAR ROOF
inputdata = powersolar_roof2;
[pshist xvar]= hist(inputdata,200);
min_kl(powersolar_roof2_x,'Photovoltaic Roof Ledge');
print('fits/powersolar_roof2','-dpng')

%% SOLAR DOOR
inputdata = powersolar_door;
[pshist xvar]= hist(inputdata,200);
min_kl(powersolar_door_x,'Photovoltaic Office Door');
print('fits/powersolar_door','-dpng')

%% SOLAR CAR
inputdata = powersolar_car;
[pshist xvar]= hist(inputdata,200);
min_kl(powersolar_car_x,'Photovoltaic Car Trunk');
print('fits/powersolar_car','-dpng')



%% PIEZO ROOF
inputdata = powerpiezo_roof;
[pshist xvar]= hist(inputdata,200);
min_kl(powerpiezo_roof_x,'Piezoelectric Roof Ledge');
print('fits/powerpiezo_roof','-dpng')

%% PIEZO DOOR
inputdata = powerpiezo_door;
[pshist xvar]= hist(inputdata,200);
min_kl(powerpiezo_door_x,'Piezoelectric Office Door');
print('fits/powerpiezo_door','-dpng')

%% PIEZO CAR
inputdata = powerpiezo_car;
[pshist xvar]= hist(inputdata,200);
min_kl(powerpiezo_car_x,'Piezoelectric Car Trunk');
print('fits/powerpiezo_car','-dpng')