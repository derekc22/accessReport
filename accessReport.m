function accessReport( Lo, La, tleFilename, times )


[ a, ecc, Omega, inc, omega, theta, epoch ] = readTLE( tleFilename );
elems = [a, ecc, Omega, inc, omega, theta];


[GROUNDSTATIONrECEF, northVector, eastVector, upVector]  = findGroundStationECEFLocation(La, Lo);


for time = times

    SPACECRAFTrECEF = findSpacecraftECEFLocation( elems, epoch, time );


    ground2scVec = SPACECRAFTrECEF - GROUNDSTATIONrECEF;

    eastProj = dot(ground2scVec, eastVector);
    northProj = dot(ground2scVec, northVector);
    upProj = dot(ground2scVec, upVector);
    
    
    azimuth =  atan2d(eastProj, northProj);
    elevation = asind(upProj/norm(ground2scVec));


    if elevation >= 10
        [ dateString, timeUTHours ] = fromJulianDate( time  );
        fprintf("On %s at %f UTC: \n", dateString, timeUTHours)
        fprintf("The ISS elevation is %f° \n", elevation)
        fprintf("The ISS azimuth is %f° \n\n", azimuth)
    end 

end
end