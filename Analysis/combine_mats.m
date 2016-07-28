N=3;

switch N
    case 1
        load('LOGGER07_DOOR_FINISHED_20150622_1600_REMOVEDSPACES_SOLAR.MAT')
    case 2
        load('LOGGER07_DOOR_FINISHED_20150622_1600_REMOVEDSPACES_PIEZO.MAT')
    case 3
        load('LOGGER07_DOOR_FINISHED_20150622_1600_REMOVEDSPACES_SOLARPIEZO.MAT')
end
powerpiezo_door = powerpiezo;
powersolar_door = powersolar;
powertherm_door = powertherm;
powerdiode_door = powerdiode;
rawhumid_door = rawhumid;
rawlight_door = rawlight;
rawtempe_door = rawtempe;
trimmedhumid_door = trimmedhumid;
trimmedlight_door = trimmedlight;
trimmedtempe_door = trimmedtempe;
scaledtime_door = scaledtime;

switch N
    case 1
        load('LOGGER01_CAR_FINISHED_20150629_1610_REMOVEDSPACES_SOLAR.MAT')
    case 2
        load('LOGGER01_CAR_FINISHED_20150629_1610_REMOVEDSPACES_PIEZO.MAT')
    case 3
        load('LOGGER01_CAR_FINISHED_20150629_1610_REMOVEDSPACES_SOLARPIEZO.MAT')
end
powerpiezo_car = powerpiezo;
powersolar_car = powersolar;
powertherm_car = powertherm;
powerdiode_car = powerdiode;
rawhumid_car = rawhumid;
rawlight_car = rawlight;
rawtempe_car = rawtempe;
trimmedhumid_car = trimmedhumid;
trimmedlight_car = trimmedlight;
trimmedtempe_car = trimmedtempe;
scaledtime_car = scaledtime;

switch N
    case 1
        load('LOGGER01_ROOF_FINISHED_20150707_1610_REMOVEDSPACES_SOLAR.MAT')
    case 2
        load('LOGGER01_ROOF_FINISHED_20150707_1610_REMOVEDSPACES_PIEZO.MAT')
    case 3
        load('LOGGER01_ROOF_FINISHED_20150707_1610_REMOVEDSPACES_SOLARPIEZO.MAT')
end
powerpiezo_roof = powerpiezo;
powersolar_roof = powersolar;
powertherm_roof = powertherm;
powerdiode_roof = powerdiode;
rawhumid_roof = rawhumid;
rawlight_roof = rawlight;
rawtempe_roof = rawtempe;
trimmedhumid_roof = trimmedhumid;
trimmedlight_roof = trimmedlight;
trimmedtempe_roof = trimmedtempe;
scaledtime_roof = scaledtime;

switch N
    case 1
        load('LOGGER00_ROOF2_FINISHED_20150824_1700_REMOVEDSPACES_SOLAR.MAT')
    case 2
        load('LOGGER00_ROOF2_FINISHED_20150824_1700_REMOVEDSPACES_PIEZO.MAT')
    case 3
        load('LOGGER00_ROOF2_FINISHED_20150824_1700_REMOVEDSPACES_SOLARPIEZO.MAT')
end
powerpiezo_roof2 = powerpiezo;
powersolar_roof2 = powersolar;
powertherm_roof2 = powertherm;
powerdiode_roof2 = powerdiode;
rawhumid_roof2 = rawhumid;
rawlight_roof2 = rawlight;
rawtempe_roof2 = rawtempe;
trimmedhumid_roof2 = trimmedhumid;
trimmedlight_roof2 = trimmedlight;
trimmedtempe_roof2 = trimmedtempe;
scaledtime_roof2 = scaledtime;

switch N
    case 1
        save ('COMBINED_VARIABLES_SOLAR.MAT', 'powerpiezo_door', 'powersolar_door', 'powertherm_door', 'powerdiode_door', 'rawhumid_door', 'rawlight_door', 'rawtempe_door', 'scaledtime_door', 'powerpiezo_car', 'powersolar_car', 'powertherm_car', 'powerdiode_car', 'rawhumid_car', 'rawlight_car', 'rawtempe_car', 'scaledtime_car', 'powerpiezo_roof', 'powersolar_roof', 'powertherm_roof', 'powerdiode_roof', 'rawhumid_roof', 'rawlight_roof', 'rawtempe_roof', 'scaledtime_roof', 'powerpiezo_roof2', 'powersolar_roof2', 'powertherm_roof2', 'powerdiode_roof2', 'rawhumid_roof2', 'rawlight_roof2', 'rawtempe_roof2', 'scaledtime_roof2', 'trimmedhumid_roof2', 'trimmedlight_roof2', 'trimmedtempe_roof2', 'trimmedhumid_roof', 'trimmedlight_roof', 'trimmedtempe_roof', 'trimmedhumid_car', 'trimmedlight_car', 'trimmedtempe_car', 'trimmedhumid_door', 'trimmedlight_door', 'trimmedtempe_door')
    case 2
        save ('COMBINED_VARIABLES_PIEZO.MAT', 'powerpiezo_door', 'powersolar_door', 'powertherm_door', 'powerdiode_door', 'rawhumid_door', 'rawlight_door', 'rawtempe_door', 'scaledtime_door', 'powerpiezo_car', 'powersolar_car', 'powertherm_car', 'powerdiode_car', 'rawhumid_car', 'rawlight_car', 'rawtempe_car', 'scaledtime_car', 'powerpiezo_roof', 'powersolar_roof', 'powertherm_roof', 'powerdiode_roof', 'rawhumid_roof', 'rawlight_roof', 'rawtempe_roof', 'scaledtime_roof', 'powerpiezo_roof2', 'powersolar_roof2', 'powertherm_roof2', 'powerdiode_roof2', 'rawhumid_roof2', 'rawlight_roof2', 'rawtempe_roof2', 'scaledtime_roof2', 'trimmedhumid_roof2', 'trimmedlight_roof2', 'trimmedtempe_roof2', 'trimmedhumid_roof', 'trimmedlight_roof', 'trimmedtempe_roof', 'trimmedhumid_car', 'trimmedlight_car', 'trimmedtempe_car', 'trimmedhumid_door', 'trimmedlight_door', 'trimmedtempe_door')
    case 3
        save ('COMBINED_VARIABLES_SOLARPIEZO.MAT', 'powerpiezo_door', 'powersolar_door', 'powertherm_door', 'powerdiode_door', 'rawhumid_door', 'rawlight_door', 'rawtempe_door', 'scaledtime_door', 'powerpiezo_car', 'powersolar_car', 'powertherm_car', 'powerdiode_car', 'rawhumid_car', 'rawlight_car', 'rawtempe_car', 'scaledtime_car', 'powerpiezo_roof', 'powersolar_roof', 'powertherm_roof', 'powerdiode_roof', 'rawhumid_roof', 'rawlight_roof', 'rawtempe_roof', 'scaledtime_roof', 'powerpiezo_roof2', 'powersolar_roof2', 'powertherm_roof2', 'powerdiode_roof2', 'rawhumid_roof2', 'rawlight_roof2', 'rawtempe_roof2', 'scaledtime_roof2', 'trimmedhumid_roof2', 'trimmedlight_roof2', 'trimmedtempe_roof2', 'trimmedhumid_roof', 'trimmedlight_roof', 'trimmedtempe_roof', 'trimmedhumid_car', 'trimmedlight_car', 'trimmedtempe_car', 'trimmedhumid_door', 'trimmedlight_door', 'trimmedtempe_door')
end