include <wallace.scad>;

!for(side = [-1,1]) translate([0, side * motor_screw_spacing / 2, 0]) leadscrew_coupler();

module leadscrew_coupler() difference() {
	linear_extrude(height = 10 + rod_nut_size / 2 + 1, convexity = 5) difference() {
		circle(motor_screw_spacing / 2 - 1);
		#circle(motor_shaft_size * da6, $fn = 6);
	}
	translate([0, 0, m3_nut_size / 2]) rotate([-90, 0, 90]) {
		cylinder(r = m3_size * da6, h = motor_screw_spacing / 2 + 1);
		%rotate(90) cylinder(r = m3_nut_size / 2, h = 5.5, $fn = 6);
		translate([0, 0, 12]) cylinder(r = m3_size * da6 * 2, h = motor_screw_spacing / 2);
		translate([-m3_nut_size / da6 / 4, -m3_nut_size / 2, 0]) cube([m3_nut_size / da6 / 2, m3_nut_size + 1, 5.7]);
	}
	translate([0, 0, 10]) cylinder(r = rod_nut_size / 2, h = rod_nut_size + 1, $fn = 6);
	//translate([0, 0, -1]) cube(100);
}
