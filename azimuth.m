function az = azimuth(ENU)

[m, n] = size(ENU);

az = [];

for num = 1:n
    R_E = ENU(num,1);
    R_N = ENU(num,2);
    R_U = ENU(num,3);

    az(num) = acosd(R_N / sqrt(R_E^2 + R_N^2));
end
end