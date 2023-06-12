function DCM = ECI2ECEF_DCM(time)

time = datetime(time);
jd = juliandate(time); % UTC -> juliandate
GST = siderealTime(jd); % juliandate -> GST

C11 = cosd(GST);
C12 = sind(GST);
C13 = 0; C23 = 0; C31 = 0; C32 = 0;
C21 = -sind(GST);
C22 = cosd(GST);
C33 = 1;

DCM = [C11 C12 C13; C21 C22 C23; C31 C32 C33];
end