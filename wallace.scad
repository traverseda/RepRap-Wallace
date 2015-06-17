include <settings.scad>;

//modules
use <z_top_clamps.scad>;
use <feet.scad>;
use <idler_pulleys.scad>;
use <y_idler.scad>;
use <leadscrew_couplers.scad>;
use <x_carriage.scad>;
use <x_end_left.scad>;
//use <x_end_right.scad>;
use <bed_mounts.scad>;
use <y_bearing_retainers.scad>;
use <base_end_2off_left.scad>;
use <z_stop_arm.scad>;


//The following section positions parts for rendering the assembled machine.

	translate([0, 0, -bearing_size]) rotate([0, 180, 0]) base_end();
	for(end = [1, -1]) translate([0, end * motor_screw_spacing / 2 + 5, -bearing_size + bearing_size * sqrt(2) / 4]) rotate([-90, 0, 180]) y_bearing_retainer();
	for(side = [0, 1]) mirror([0, side, 0]) translate([yz_motor_distance / 2 - bearing_size / 2, -motor_casing / 2 - rod_size * 2 - 10, -bearing_size + bearing_size * sqrt(2) / 4]) rotate([90, 0, 0]) bed_mount();
	translate([-yz_motor_distance / 2 + rod_size - motor_casing / 4 - rod_size / 2, 0, 60 + (x_rod_spacing + 8 + rod_size) / 2]) rotate([0, 180, 0]) x_end(0);
	translate([-distance_between_x_end_cylinders/2 -yz_motor_distance / 2 + rod_size - motor_casing / 4 - rod_size / 2, -1-x_end_front_face_y_offset, 60 - z_stop_arm_height + (x_rod_spacing + 8 + rod_size) / 2]) rotate([180, -90, 0]) z_stop_arm();
	translate([140, 0, 60 + (x_rod_spacing + 8 + rod_size) / 2]) rotate([0, 180, 0]) {
		x_end(2);
		translate([0, 8 + rod_size, 0]) rotate([90, 0, 0]) translate([0, (x_rod_spacing + 8 + rod_size) / 2, rod_size / 2 - 2 - bearing_size / 2 - 4 - idler_pulley_width - 1.5]) idler_pulley(true);
	}
	translate([40, rod_size + bearing_size / 2 + 1 - rod_size / 2 + 2, 60]) {
		rotate([90, 0, 90]) x_carriage();
		translate([x_carriage_width / 2 + carriage_extruder_offset, -14 - bearing_size / 2 - 4, x_rod_spacing / 2 + bearing_size / 2 + 4]) {
			rotate([90, 0, 180]) translate([10.57, 30.3, -14]) import("gregs/gregs_accessible_wade-wildseyed_mount.stl", convexity = 5);
			%rotate(180 / 8) cylinder(r = 2, h = 150, center = true, $fn = 8);
		}
	}
	translate([-yz_motor_distance / 2 - motor_casing / 2, 0, -bearing_size / 2]) leadscrew_coupler();
	translate([60, 0, -bearing_size - rod_size / 2 - bearing_size / 2]) {
		rotate([0, 90, 0]) y_idler();
		for(side = [1, -1]) translate([5, side * (motor_casing / 2 - rod_size / 2), idler_pulley_width + 1.5 + rod_size]) rotate([180, 0, 0]) idler_pulley(true);
	}
	for(side = [0, 1]) mirror([0, side, 0]) translate([0, -motor_casing / 2 - rod_size * 2 - 10, -bearing_size - end_height + rod_size * 1.5]) rotate([90, 0, 0]) foot();
	translate([-yz_motor_distance / 2 + rod_size, 0, 210 - end_height]) rotate([180, 0, 90]) z_top_clamp(0);

