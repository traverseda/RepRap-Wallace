include <settings.scad>;

!base_end();

module base_end(left = true) difference() {
    union() {
        linear_extrude(height = end_height, convexity = 5) difference() {
            square([yz_motor_distance + motor_casing - motor_screw_spacing + 10, motor_casing + rod_size * 4], center = true);
            for(end = [1, -1]) {
                for(side = [1, -1]) translate([end * (yz_motor_distance + motor_casing - motor_screw_spacing) / 2, side * motor_screw_spacing / 2, 0]) circle(m3_size * da6, $fn = 6);
                translate([end * (yz_motor_distance + motor_casing) / 2, 0, 0]) circle(motor_screw_spacing / 2);
            }
        }
        // z stop sensor attachment
        if (left) {
            // z stop mount support structure
            difference() {
                linear_extrude(height = end_height, convexity = 5) difference() {
                    translate ([(yz_motor_distance+motor_casing - motor_screw_spacing + 10)/2, -motor_casing/2 - rod_size * 2, 0]) {
                        square([z_mount_width - ((yz_motor_distance + motor_casing - motor_screw_spacing + 10)/2 - z_stop_x_offset), rod_size * 2]);
                    }
                    translate([(yz_motor_distance+motor_casing - motor_screw_spacing + 10)/2 + z_mount_width - ((yz_motor_distance + motor_casing - motor_screw_spacing + 10)/2 - z_stop_x_offset),-motor_casing/2,0]) resize([(z_mount_width - ((yz_motor_distance + motor_casing - motor_screw_spacing + 10)/2 - z_stop_x_offset))*2,rod_size * 4]) circle (1,$fn = 32);
                }
                translate([z_stop_x_offset + z_mount_width, -motor_casing/2 - rod_size * 2,m3_nut_size+z_stop_mount_z_buffer])
                    rotate([0,-atan2(z_mount_width - ((yz_motor_distance + motor_casing - motor_screw_spacing + 10)/2 - z_stop_x_offset), end_height-m3_nut_size-z_stop_mount_z_buffer),0])
                        cube([(z_mount_width - ((yz_motor_distance + motor_casing - motor_screw_spacing + 10)/2 - z_stop_x_offset)), rod_size * 2, sqrt(pow((z_mount_width - ((yz_motor_distance + motor_casing - motor_screw_spacing + 10)/2 - z_stop_x_offset)),2)+pow(end_height-m3_nut_size-z_stop_mount_z_buffer,2))]);
            }
            // z stop mount
            translate([z_stop_x_offset, -m3_nut_height-(z_stop_mount_y_buffer*2)-(motor_casing + (rod_size*4))/2, 0]){
                difference () {
                    cube([z_mount_width, m3_nut_height+(z_stop_mount_y_buffer*2), m3_nut_size+z_stop_mount_z_buffer]);
                    // holes for bolting
                    for(side = [0,1]) {
                        translate([(m3_nut_size+(z_stop_mount_x_buffer*2))/2+side*z_stop_screw_spacing,
                                   m3_nut_height/2+z_stop_mount_y_buffer,
                                   m3_nut_size/2]){
                            cube([m3_nut_size,m3_nut_height,m3_nut_size],center=true);
                            if (z_stop_side_holes)
                             rotate([0,90,0])
                              translate([0,0,(side-.5)*(z_stop_mount_x_buffer+m3_nut_size)])
                               cylinder(h=z_stop_mount_x_buffer,r=m3_size * da6, $fn = 6, center=true);
                            if (z_stop_bottom_holes)
                              translate([0,0,(z_stop_mount_z_buffer+m3_nut_size)/2])
                               cylinder(h=z_stop_mount_z_buffer,r=m3_size * da6, $fn = 6, center=true);
 
                            rotate([90,0,0])
                             translate([0,0,(z_stop_mount_y_buffer+m3_nut_height)/2])
                              cylinder(h=z_stop_mount_y_buffer,r=m3_size * da6, $fn = 6, center=true);
                        }
                    }
                }
            }
        }
        // motor supports
        sides= left ? [1,-1] : [1];
        for ( side = sides ){
            difference(){
                translate ([side*((yz_motor_distance - motor_screw_spacing + 10)/2+motor_casing - yz_motor_distance/4), 0, end_height/2])
                    cube([motor_casing - yz_motor_distance/2, motor_casing + rod_size*4, end_height],center=true);
                translate ([side*((yz_motor_distance - motor_screw_spacing + 10)/2+motor_casing - yz_motor_distance/4 + (motor_casing - yz_motor_distance/2)/2), 0, end_height])
                  resize([motor_casing*2 - yz_motor_distance,motor_casing + rod_size*4,2*(end_height-3)])
                    rotate([90,0,0])
                      cylinder($fn=4,center=true);
                for ( edge = [1,-1]) {
                  translate ([side*((yz_motor_distance - motor_screw_spacing + 10)/2+motor_casing - yz_motor_distance/4 + (motor_casing - yz_motor_distance/2)/2), edge*(motor_casing + rod_size*4)/2, end_height/2])
                    resize([2*(motor_casing - yz_motor_distance/2), rod_size*4, end_height])
                      cylinder($fn=32,center=true);
                }
                translate([side*((yz_motor_distance + motor_casing) / 2),0,0]){
                  cylinder(h=3,r=motor_screw_spacing / 2);
                  for(edge = [1,-1]){
                    translate([side*(motor_screw_spacing/2), edge*motor_screw_spacing / 2,0])
                      cylinder(h=3,r=m3_size * da6);
                  }
                }
            }
        }
    }
    // motor cutouts
	for(end = [1, -1]) translate([end * (yz_motor_distance + motor_casing) / 2, 0, 3]) linear_extrude(height = end_height, convexity = 5) square(motor_casing, center = true);
    // holes for x axis threaded rod for connecting to other base.
	for(side = [1, -1]) translate([0, side * (motor_casing / 2 + rod_size), rod_size / 2 + bearing_size / 2]) rotate([90, 180 / 8, 90]) {
		cylinder(r = rod_size * da8, h = yz_motor_distance + motor_casing + 20, center = true, $fn = 8);
		%translate([0, 0, -70]) cylinder(r = rod_size * da8, h = 200, center = true, $fn = 8);
	}
    
	if (left) for(side = [1, -1]) translate([0, side * (motor_casing / 2 + rod_size), rod_size / 2 + bearing_size / 2]) rotate([90, 180 / 6, 90])
		translate([0,0,(yz_motor_distance + motor_casing - motor_screw_spacing + 10)/2 - 5])
            cylinder(r = rod_nut_size / 2, h = z_mount_width+z_stop_x_offset, center = false, $fn = 6);

    // bottom arch. Mostly cosmetic.
	translate([0, 0, end_height]) scale([1, 1, .5]) rotate([90, 0, 90]) cylinder(r = motor_casing / 2, h = yz_motor_distance + 20, center = true);
    // z smooth rod hole and holes for securing z rod.
	translate([yz_motor_distance / 2 - rod_size, 0, 0]) {
		translate([0, 0, -3]) linear_extrude(height = end_height - motor_casing / 4, convexity = 5) {
			rotate(180 / 8) circle(rod_size * da8, $fn = 8);
			translate([0, -rod_size / 4, 0]) square([rod_size * .6, rod_size / 2]);
		}
		// z axis clamping
		for(h = [8, end_height - motor_casing / 4 - 8]) translate([0, 0, h]) rotate([90, 0, 90]) {
			cylinder(r = m3_size * da6, h = yz_motor_distance + motor_casing, center = true, $fn = 6);
			translate([0, 0, -rod_size / 2 - 3]) cylinder(r = m3_nut_size* da6, h = yz_motor_distance + motor_casing, $fn = 6);
			translate([0, 0, 0]) cylinder(r = m3_nut_size / 2 + 0.5, h = yz_motor_distance + motor_casing, $fn = 6);
			translate([0, 0, -rod_size / 2 - 8]) rotate([0, 180, 0]) cylinder(r = m3_size * da6 * 2, h = yz_motor_distance + motor_casing, $fn = 6);
		}
	}
    // y bearing holes
	translate([-yz_motor_distance / 2 + bearing_size / 2, 0, -bearing_size * sqrt(2) / 4]) rotate([90, -45, 0]) {
		%cylinder(r = rod_size * da8, h = 100, center = true, $fn = 8);
		for(side = [0, 1]) mirror([0, 0, side]) translate([0, 0, rod_size / 2 + 2]) {
			cylinder(r = bearing_size / 2, h = bearing_length, center = false, $fn = 80);
			cube([bearing_size / 2, bearing_size / 2, bearing_length]);
		}
	}
    // y support rod hole
	translate([0, 0, end_height - rod_size * 1.5]) rotate([90, 180 / 8, 0]) cylinder(r = rod_size * da8, h = motor_casing + rod_size * 5, $fn = 8, center = true);
	%translate([0, 0, end_height - rod_size * 1.5]) rotate([90, 180 / 8, 0]) cylinder(r = rod_size * da8, h = 100, $fn = 8, center = true);
}
