clear;clc

% midnight in PST is 8:00 am in UTC
% https://www.utctime.net/utc-to-pst-converter
startDateString = '03-Mar-2023';
startJulianDate = toJulianDate(startDateString, 8);

endDateString = '05-Mar-2023';
endJulianDate = toJulianDate(endDateString, 8);


% 0.00069444440305233 is 1 minute in julian date
times = startJulianDate:0.00069444440305233:endJulianDate;

% ground station La, Lo
La = 34.0209;
Lo = -118.2982;

tleFilename = 'issoriginal.tle';
accessReport( Lo, La, tleFilename, times )
