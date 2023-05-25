function velocityInPQW = solveVelocityInPerifocalFrame(semimajor_axis, eccentricity, true_anomaly)

% deg(input unit) -> rad(matlab unit)
true_anomaly = true_anomaly * pi/180;
% unit : m^3 * s^(-2)
mu = 3.986004418 * 10^14;

semi_latus_rectum = semimajor_axis * (1 - eccentricity^2);

velocityInPQW = sqrt(mu / semi_latus_rectum) .* [-sin(true_anomaly)
    eccentricity+cos(true_anomaly)
    0];

end