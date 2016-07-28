global pshist
global xvar
global inputdata

MaxFunEval    = 1E4;
TolFun        = 1E-25;

load('GOOD_SOLAR_PIEZO.MAT')

%% ROOF
display('Roof')
inputdata = powerpiezo_roof;
[pshist xvar]= hist(inputdata,200);
LB = [1E-99 0 1E-99         1E-99 0 1E-99          1E-99 0 1E-99             0 1 1];
UB = [1E99 0 1E99           1E99 1.4E-4 1E99       1E99 1.4E-4 1E99          0 1 1];
X0 = [7E-1 0 4E-7           15E-2 1.664E-6 5E-6    5E-1 3E-6 5E-5            0 1 1];
options = gaoptimset('TolFun',TolFun,'InitialPopulation',X0,'Generations',MaxFunEval);
[x fval] = ga(@min_kl, 12, [], [], [], [], LB, UB, @nocon, options);

powerpiezo_roof_x = x;
powerpiezo_roof_fval = fval;

%% DOOR
display('Door')
inputdata = powerpiezo_door;
[pshist xvar]= hist(inputdata,200);
LB = [1E-99 0 1E-99         1E-99 0 1E-99          1E-99 0 1E-99             0 1 1];
UB = [1E99 0 1E99           1E99 1.2E-4 1E99       1E99 1.2E-4 1E99          0 1 1];
X0 = [27E-2 0 2E-7          23E-3 0 4.8E-6         7E-3 3E-6 5E-5            0 1 1];
options = gaoptimset('TolFun',TolFun,'InitialPopulation',X0,'Generations',MaxFunEval);
[x fval] = ga(@min_kl, 12, [], [], [], [], LB, UB, @nocon, options);

powerpiezo_door_x = x;
powerpiezo_door_fval = fval;

%% CAR
display('Car')
inputdata = powerpiezo_car;
[pshist xvar]= hist(inputdata,200);
LB = [1E-99 0 1E-99         1E-99 0 1E-99          1E-99 0 1E-99             0 1 1];
UB = [1E99 0 1E99           1E99 1.6E-4 1E99       1E99 1.6E-4 1E99          0 1 1];
X0 = [4.7E-2 0 2E-7         8E-3 0 4.8E-6          5E-3 3E-6 5E-5            0 1 1];
options = gaoptimset('TolFun',TolFun,'InitialPopulation',X0,'Generations',MaxFunEval);
[x fval] = ga(@min_kl, 12, [], [], [], [], LB, UB, @nocon, options);

powerpiezo_car_x = x;
powerpiezo_car_fval = fval;

save('powerpiezo_optimise2.mat');
