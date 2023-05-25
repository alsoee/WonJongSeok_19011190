function rangeInPQW = solveRangeInPerifocalFrame(semimajor_axis, eccentricity, true_anomaly)

% deg(input unit) -> rad(matlab unit)
true_anomaly = true_anomaly * pi/180;
% eccentric_anomaly(unit : rad)
eccentric_anomaly = acos((eccentricity + cos(true_anomaly)) / (1 + eccentricity * cos(true_anomaly)));

rangeInPQW = [semimajor_axis*(1-eccentricity*cos(eccentric_anomaly))*cos(true_anomaly)
    semimajor_axis*(1-eccentricity*cos(eccentric_anomaly))*sin(true_anomaly)
    0];

end