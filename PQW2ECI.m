function rotation_matrix = PQW2ECI(arg_prg, inc_angle, RAAN)

arg_prg_rad = arg_prg * pi/180;
inc_angle_rad = inc_angle * pi/180;
RAAN_rad = RAAN * pi/180;

arg_prg_matrix = [cos(arg_prg_rad) sin(arg_prg_rad) 0
    -sin(arg_prg_rad) cos(arg_prg_rad) 0
    0 0 1];

inc_angle_matrix = [1 0 0
    0 cos(inc_angle_rad) sin(inc_angle_rad)
    0 -sin(inc_angle_rad) cos(inc_angle_rad)];

RAAN_matrix = [cos(RAAN_rad) sin(RAAN_rad) 0
    -sin(RAAN_rad) cos(RAAN_rad) 0
    0 0 1];

rotation_matrix = transpose(arg_prg_matrix * inc_angle_matrix * RAAN_matrix);

end