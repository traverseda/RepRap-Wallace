include <settings.scad>;

!for(b = [0:1]) mirror([0, b, 0]) for(a = [-1,1]) translate([a * -7.5, 18 - 5 * a, 0]) rotate(180 + 90 * a) bed_mount();


module bed_mount(){ 
    difference() {
	linear_extrude(height = 10, convexity = 5) difference() {
		union() {
			rotate(180 / 8) circle((rod_size + 8) * da8, $fn = 8);
			translate([0, -rod_size / 2 - 4-12.5, 0]) square([rod_size / 2 + 8, max(rod_size + 20.5, rod_size / 2 + 4 )]);
		}
		rotate(180 / 8) circle(rod_size * da8, $fn = 8);
		translate([0, -0.5-rod_size / (1 + sqrt(2)) / 2, 0]) square([rod_size + 10, rod_size / (0.5 + sqrt(2))]);
	}
	translate([rod_size / 2 + 1.5, -rod_size / 2 - 19.5, 5]) rotate([-90, 0, 0]) {
		cylinder(r = m4_size * da6, h = max(rod_size + 24, rod_size / 2 + 7 + bed_mount_height, $fn = 6));
		cylinder(r = m4_nut_size * da6, h = 8, $fn = 6);
	}
}

//##THIS IS PROBABLY THE PART THAT'S BREAKING
translate([0,-29,0])difference(){
    union(){
        translate([0,8,9])cube([12.5,12.5,7]);
        translate([12.5,14.25,16])rotate([-90,0,90])cylinder(r=12.5/2,h=12.5,$fn=8);
    }
    translate([15,14.25,15])rotate([-90,0,90])cylinder(r=rod_size/2,h=50,$fn=8);
}
}

