function az = azimuth(ENU)

[m, n] = size(ENU);

az = [];

for num = 1:m
    R_E = ENU(num,1);
    R_N = ENU(num,2);
    R_U = ENU(num,3);

    az(num) = atan2(R_N, R_E) .* 180 ./ pi;
end
end