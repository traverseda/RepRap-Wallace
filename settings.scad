rod_size = 9;
rod_nut_size = 15.5; //12 for M6, 15 for M8
bearing_size = 15.5; //12.5 for LM6UU, 15.5 for LM8UU,LM8SUU
bearing_length = 25.5; //19.5 for LM6UU, 17.5 for LM8SUU, 24.5 for LM8UU
yz_motor_distance = 25;
motor_screw_spacing = 31; //26 for NEMA14, 31 for NEMA17
motor_casing = 45; //38 for NEMA14, 45 for NEMA17
end_height = 55; //measure the height of your motor casing and add 4mm. Suggestion: 40 for NEMA14, 55 for NEMA17
bed_mount_height = 16;
//x_rod_spacing = motor_screw_spacing + 3 + rod_size;
x_rod_spacing = 30;
x_carriage_width = 70;
carriage_extruder_offset = 5;
pulley_size = 20;
idler_pulley_width = 10;
gusset_size = 15;
m3_size = 3.5;
m3_nut_size = 7;
// m3 nut height is because tristan doesn't know the height of an m3 nut, it is not implemented everywhere, just on the z stop in base_end_2off.scad
m3_nut_height = 3;
m4_size = 4.5;
m4_nut_size = 7.5;
motor_shaft_size = 5.5;

z_stop_screw_spacing = 20;
// these may be super unneeded, in which case we can easily do a search and replace. But they may be really useful for prototyping/whatever.
z_stop_mount_x_buffer = 2;
z_stop_mount_y_buffer = 2;
z_stop_mount_z_buffer = 2;
z_stop_side_holes = true;
z_stop_bottom_holes = false;

z_stop_arm_actuator_width = 2;
z_stop_arm_actuator_depth = 8;
z_stop_arm_actuator_height = 60;
z_stop_depth = -30;//this is for the optical endstop, this is the width from where it is mounted to where it is clear for the arm to go through.
z_stop_x_adjust=0;

// printer properties. These settings affect major changes in the structure of the printer.
use_rod_for_x_ends = true; // This makes the holes that clamp the x ends the size for rod. This is good when mounting the optical endstop arm, because it is hard to find bolts long enough to go through the end and the endstop arm. (metric ones at least)

// meta vars, these are set by other vars for ease of reference.
z_mount_width = m3_nut_size+z_stop_screw_spacing+(z_stop_mount_x_buffer*2);
base_z_rod_x_offset = yz_motor_distance / 2 - rod_size;
distance_between_x_end_cylinders = motor_casing / 2 + rod_size;
z_stop_x_offset = base_z_rod_x_offset + distance_between_x_end_cylinders - (z_mount_width/2) + z_stop_x_adjust;
x_end_cylinder_radius = bearing_size / 2 + 3;
x_end_front_face_y_offset = (bearing_size / 2 + 3)/2;//In case it's non obvious, this is for getting the amount the x end cylinders extend past the front face.
x_end_cylinder_protrution_depth = x_end_cylinder_radius - x_end_front_face_y_offset;
z_stop_arm_depth = z_stop_arm_actuator_depth + z_stop_depth + m3_nut_height+(z_stop_mount_y_buffer*2)+(motor_casing + (rod_size*4))/2 - x_end_front_face_y_offset;
z_stop_arm_height = z_stop_arm_actuator_height + x_rod_spacing + 8 + rod_size;
z_stop_arm_x_support_depth = (z_stop_arm_depth - x_end_cylinder_protrution_depth) / 3;

// ratio for converting diameter to apothem
da6 = 1 / cos(180 / 6) / 2;
da8 = 1 / cos(180 / 8) / 2;
