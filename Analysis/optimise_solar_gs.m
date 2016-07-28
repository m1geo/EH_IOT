global pshist
global xvar
global inputdata

MaxFunEval    = 1E4;
TolFun        = 1E-25;

load('GOOD_SOLAR_PIEZO.MAT')

%% ROOF
display('Roof')
inputdata = powersolar_roof2;
[pshist xvar]= hist(inputdata,200);
LB = [1E-99 0 1E-99    1E-99 0 1E-99          1E-99 0 1E-99                  1E-99 0 1E-99];
UB = [1E99 0 1E99      1E99 2.5E-3 1E99       1E99 2.5E-3 1E99               1E99 2.5E-3 1E99];
X0 = [1E1 0 45E-6      0.8E1 0.3E-3 2E-4      0.75E1 1.25E-3 50E-5           0.5E1 2.4E-3 1E-5];
options = gaoptimset('TolFun',TolFun,'InitialPopulation',X0,'Generations',MaxFunEval);
[x fval] = ga(@min_kl, 12, [], [], [], [], LB, UB, @nocon, options);

powersolar_roof2_x = x;
powersolar_roof2_fval = fval;

%% DOOR
display('Door')
inputdata = powersolar_door;
[pshist xvar]= hist(inputdata,200);
LB = [1E-99 0 1E-99         1E-99 0 1E-99          1E-99 0 1E-99             0 1 1];
UB = [1E99 4.5E-4 1E99      1E99 4.5E-4 1E99       1E99 4.5E-4 1E99          0 1 1];
X0 = [1E1 0.2E-4 15E-6      0.1E1 1.5E-4 1E-4      0.3E1 0.25E-4 1E-4        0 1 1];
options = gaoptimset('TolFun',TolFun,'InitialPopulation',X0,'Generations',MaxFunEval);
[x fval] = ga(@min_kl, 12, [], [], [], [], LB, UB, @nocon, options);

powersolar_door_x = x;
powersolar_door_fval = fval;

%% CAR
display('Car')
inputdata = powersolar_car;
[pshist xvar]= hist(inputdata,200);
LB = [1E-99 0 1E-99         1E-99 0 1E-99          1E-99 0 1E-99             0 1 1];
UB = [1E99 0 1E99           1E99 1.6E-3 1E99       1E99 1.6E-3 1E99          0 1 1];
X0 = [20E-1 0 2E-6          2E-2 1.954E-5 1E-5     0.01 0.25E-4 10E-4        0 1 1];
options = gaoptimset('TolFun',TolFun,'InitialPopulation',X0,'Generations',MaxFunEval);
[x fval] = ga(@min_kl, 12, [], [], [], [], LB, UB, @nocon, options);

powersolar_car_x = x;
powersolar_car_fval = fval;

save('powersolar_optimise2.mat');
