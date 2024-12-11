function [GROUNDSTATIONrECEF, northVector, eastVector, upVector]  = findGroundStationECEFLocation(La, Lo)

radius = 6378;

theta = Lo;
phi = 90 - La;

x = radius*sind(phi)*cosd(theta);

y = radius*sind(phi)*sind(theta);

z = radius*cosd(phi);


format long g

GROUNDSTATIONrECEF = [x, y, z];




%% find north, east, and up vectors
qY = rotationAsQ( [0,1,0], -La );
qZ = rotationAsQ( [0,0,1], Lo );


zHat = [0, 0, 1];
zHatRotatedAboutY = qrotate( zHat, qY );
northVector = qrotate( zHatRotatedAboutY, qZ );


yHat = [0, 1, 0];
yHatRotatedAboutY = qrotate( yHat, qY );
eastVector = qrotate( yHatRotatedAboutY, qZ );



xHat = [1, 0, 0];
xHatRotatedAboutY = qrotate( xHat, qY );
upVector = qrotate( xHatRotatedAboutY, qZ );


end 