function SPACECRAFTrECEF  = findSpacecraftECEFLocation( elems, epoch, time )

mu = 3.986E5;

a = elems(1);
ecc = elems(2);
longAscendingNode = elems(3);
inclination = elems(4);
argOfPerigee = elems(5);
trueAnomaly = elems(6);


timeDiff = time - epoch;


tspEpoch = timeSincePeriapsis( trueAnomaly, a, ecc, mu);

tspNow = tspEpoch + (timeDiff/0.0416666665114462)*3600;



trueAnomalyNow = trueAnomalyAtTime( tspNow, a, ecc, mu);


%% Calculate perturbations and convert from deg/day to deg/sec
dLongAscendingNodedt = ((-2.06474E14) * ((cosd(inclination)) / ((a^(7/2))*(1-ecc^2)^2)))*(1/86400);

longAscendingNodeNow = longAscendingNode + (timeDiff/0.0416666665114462)*3600 * (dLongAscendingNodedt);



dArgOfPerigeedt = ((1.0324E14) * ((4-5*(sind(inclination))^2) / ((a^(7/2)) * (1-ecc^2)^2)))*(1/86400);

argOfPerigeeNow = argOfPerigee + (timeDiff/0.0416666665114462)*3600 * (dArgOfPerigeedt);




argOfLatitude = argOfPerigeeNow + trueAnomalyNow;




La = asind( sind(inclination) * sind(argOfLatitude) );

sinlo = tand(La)/tand(inclination);

coslo = (cosd(La)-sind(argOfLatitude)*sinlo*cosd(inclination))/cosd(argOfLatitude);

lo = atan2d(sinlo, coslo);


angleVernalEquinox = angleOfVernalEquinox( time );


longAscendingNodeECEF = longAscendingNodeNow - angleVernalEquinox;



Lo = longAscendingNodeECEF + lo;

LoCorrected = -180 + mod(Lo+180, 360);



%% Calculate orbital radius and altitude
radius = (a*(1-ecc^2))/(1+ecc*cosd(trueAnomalyNow));

altitude = radius - 6378;


%% Use La, LoCorrected, orbital radius to calculate (x, y, z) using spherical coordiante equations

theta = LoCorrected;
phi = 90 - La;

x = radius*sind(phi)*cosd(theta);

y = radius*sind(phi)*sind(theta);

z = radius*cosd(phi);



%% Output
format long g

SPACECRAFTrECEF = [x, y, z];


end 