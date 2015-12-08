include <settings.scad>;

!for(side = [0, 1]) mirror([side, 0, 0]) translate([-rod_size * 2.5, 0, 0]) z_top_clamp();

module z_top_clamp() difference() {
	union() {
		linear_extrude(height = rod_size * 2 + gusset_size, convexity = 5) difference() {
			union() {
				circle(r = rod_size * da6 * 2, $fn = 6);
				translate([0, -rod_size, 0]) square([rod_size * (1 + da6), rod_size * 2]);
				translate([rod_size - rod_size * da6, rod_size / 2, rod_size]) square([rod_size * da6 * 2, rod_size / 2 + gusset_size]);
			}
		}
		translate([rod_size, -rod_size - 1, rod_size]) rotate([-90, 0, 0]) cylinder(r = rod_size / cos(180 / 6), h = rod_size * 2 + gusset_size + 2, $fn = 6);
	}
	translate([rod_size, -rod_size - 2, rod_size]) rotate([-90, 0, 0]) cylinder(r = rod_size * da6, h = gusset_size + rod_size * 2 + 4, $fn = 6);
	translate([rod_size, rod_size + gusset_size, rod_size * 2 + gusset_size]) rotate([45, 0, 0]) cube([rod_size * 2, gusset_size * sqrt(2), gusset_size * sqrt(2)], center = true);
	translate([0, 0, -1]) linear_extrude(height = rod_size * 2 + gusset_size + 2, convexity = 5) {
		circle(r = rod_size * da6, $fn = 6);
		%translate([rod_size, -10, rod_size * da6 * 2]) rotate([-90, 0, 0]) cylinder(r = rod_size * da6, h = 160, $fn = 6);
		translate([0, -rod_size / 2, 0]) square([gusset_size + rod_size * 2 + 1, rod_size]);
	}
}
