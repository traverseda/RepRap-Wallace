rod_size = 8;
rod_nut_size = 15; //12 for M6, 15 for M8
bearing_size = 15.5; //12.5 for LM6UU, 15.5 for LM8UU,LM8SUU
bearing_length = 24.5; //19.5 for LM6UU, 17.5 for LM8SUU, 24.5 for LM8UU
yz_motor_distance = 25;
motor_screw_spacing = 26; //26 for NEMA14, 31 for NEMA17
motor_casing = 38; //38 for NEMA14, 45 for NEMA17
end_height = 40; //measure the height of your motor casing and add 4mm. Suggestion: 40 for NEMA14, 55 for NEMA17
bed_mount_height = 16;
//x_rod_spacing = motor_screw_spacing + 3 + rod_size;
x_rod_spacing = 30;
x_carriage_width = 70;
carriage_extruder_offset = 5;
pulley_size = 20;
idler_pulley_width = 10;
gusset_size = 15;
m3_size = 3;
m3_nut_size = 6;
// m3 nut height is because tristan doesn't know the height of an m3 nut, it is not implemented everywhere, just on the z stop in base_end_2off.scad
m3_nut_height = 2;
m4_size = 4;
motor_shaft_size = 5;
z_stop_screw_spacing = 10;
// these may be super unneeded, in which case we can easily do a search and replace. But they may be really useful for prototyping/whatever.
z_stop_mount_x_buffer = 2;
z_stop_mount_y_buffer = 2;
z_stop_mount_z_buffer = 2;
z_stop_side_holes = true;
z_stop_bottom_holes = false;

// ratio for converting diameter to apothem
da6 = 1 / cos(180 / 6) / 2;
da8 = 1 / cos(180 / 8) / 2;
