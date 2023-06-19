load('nav.mat')

% PQW -> ECI
Cip_GPS = PQW2ECI(nav.GPS.omega,nav.GPS.i,nav.GPS.OMEGA);
Cip_QZSS = PQW2ECI(nav.QZSS.omega,nav.QZSS.i,nav.QZSS.OMEGA);
Cip_BDS = PQW2ECI(nav.BDS.omega,nav.BDS.i,nav.BDS.OMEGA);
% 1 days = 86400 sec
day_sec = 86400;
% unit : m^3 * s^(-2)
mu = 3.986004418 * 10^14;
% mean motion
GPS_n = sqrt(mu/nav.GPS.a^3);
QZSS_n = sqrt(mu/nav.QZSS.a^3);
BDS_n = sqrt(mu/nav.BDS.a^3);

% GPS 기준 시간 설정
time_0 = datetime(nav.GPS.toc);
jd_0 = juliandate(time_0); % UTC -> juliandate
GST_0 = siderealTime(jd_0); % juliandate -> GST

% GPS 측정 시간 설정
time_initial = input('time : ');

time = datetime(time_initial);
jd = juliandate(time);
GST(1,1) = siderealTime(jd);

if GST(1,1) >= GST_0
    M(1,1) = GPS_n * (GST(1,1) - GST_0) + nav.GPS.M0;
elseif GST < GST_0
    M(1,1) = GPS_n * (GST + 360 - GST_0) + nav.GPS.M0;
end

% ECI -> ECEF
DCM(1,1) = ECI2ECEF_DCM(time_initial);

true_anomaly_GPS(1,1) = M(1,1) + 2 * nav.GPS.e * sin(M(1,1));
r_PQ(1,1) = solveRangeInPerifocalFrame(nav.GPS.a, nav.GPS.e, true_anomaly_GPS(1,1));
v_PQ(1,1) = solveVelocityInPerifocalFrame(nav.GPS.a, nav.GPS.e, true_anomaly_GPS(1,1));

for sec = 1:86400
    time_initial(6) = time_initial(6) + 1;

    if time_initial(6) == 60
        time_initial(5) = time_initial(5) + 1;
        time_initial(6) = 0;
    elseif time_initial(5) == 60
        time_initial(4) = time_initial(4) + 1;
        time_initial(5) = 0;
    elseif time_initial(4) == 24
        time_initial(3) = time_initial(3) + 1;
        if time_initial(2) == 2 || time_initial(2) == 4 || time_initial(2) == 6 || time_initial(2) == 9 || time_initial(2) == 11
            if time_initial(3) == 30
                time_initial(3) = 0;
                time_initial(2) = time_initial(2) + 1;
            end
        elseif time_initial(2) == 12
            if time_initial(3) == 31
                time_initial(3) = 0;
                time_initial(2) = 0;
                time_initial(1) = time_initial(1) + 1;
            end
        else
            if time_initial(3) == 31
                time_initial(3) = 0;
                time_initial(2) = time_initial(2) + 1;
            end
        end
    end

    time = datetime(time_initial);
    jd = juliandate(time);
    GST(sec + 1,1) = siderealTime(jd);

    if GST(sec + 1,1) >= GST_0
        M(sec + 1,1) = GPS_n * (GST(sec + 1,1) - GST_0) + nav.GPS.M0;
    elseif GST(sec + 1,1) < GST_0
        M(sec + 1,1) = GPS_n * (GST(sec + 1,1) + 360 - GST_0) + nav.GPS.M0;
    end

    % ECI -> ECEF
    DCM(sec + 1,1) = ECI2ECEF_DCM(time_initial);

    true_anomaly_GPS(sec + 1,1) = M(sec + 1,1) + 2 * nav.GPS.e * sin(M(sec + 1,1));
    r_PQ(sec + 1,1) = solveRangeInPerifocalFrame(nav.GPS.a, nav.GPS.e, true_anomaly_GPS(sec + 1,1));
    v_PQ(sec + 1,1) = solveVelocityInPerifocalFrame(nav.GPS.a, nav.GPS.e, true_anomaly_GPS(sec + 1,1));

end





%true_anomaly_GPS0 = nav.GPS.M0 + 2 * nav.GPS.e * sin(nav.GPS.M0);
%r_PQ = solveRangeInPerifocalFrame(nav.GPS.a, nav.GPS.e, true_anomaly_GPS0);
%v_PQ = solveVelocityInPerifocalFrame(nav.GPS.a, nav.GPS.e, true_anomaly_GPS0);