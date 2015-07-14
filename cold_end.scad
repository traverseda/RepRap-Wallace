
m3_bolt = 3; // surprising
m3_nut = 5.5;
m4_bolt = 4; // surprising
m4_nut = 7;

// Hot end connection
hot_end_diameter = 16;
hot_end_fastening_diameter = 12;
hot_end_fastening_bolt_diameter = m3_bolt;
hot_end_fastening_brim_height = 3.7;// This is the distance down the hot end to the top of the cutout for the fastening bolts.
hot_end_hole_depth = 12;

// bearing clamp
bearing_diameter = 22;
bearing_bolt_diameter = 8;
// !!!!! I WANT TO SET THIS TO 0, BUT HAVE IT 3 AS TEST
bearing_height_buffer = 3;// how much higher the bearings are than the connection to the cold side of the hot end.

// filament feed
filament_diameter = 1.75;
filament_buffer = 1;

// tensioner
tension_width = 7.5;
tension_fulcrum_bolt_diameter = m3_bolt;
tension_mount_buffer = 1.5;
tension_bolts_diameter = m4_bolt;
tension_nut_diameter = m4_nut;

// stepper motor attachment
//!!!!! THIS VALUE IS A STAND IN FOR AN ACTUAL VALUE !!!
stepper_distance = 50;// distance from the center of the hobbed bolt to the center of the stepper motor.
motor_screw_spacing = 31; //26 for NEMA14, 31 for NEMA17
motor_casing = 45; //38 for NEMA14, 45 for NEMA17
motor_mount_angle = 30;

// quick fit attachment
quickfit_height = 5;
arbitrary_base_height = 7.5;
arbitrary_base_length = 64;
quickfit_base_length = 100;


// ## helper variables ##

x_center = quickfit_base_length/2;
// hot end
hot_end_radius = hot_end_diameter/2;
hot_end_fastening_radius = hot_end_fastening_diameter/2;
hot_end_fastening_bolt_radius = hot_end_fastening_bolt_diameter/2;
hot_end_fastening_bolt_x_offset = hot_end_fastening_radius + hot_end_fastening_bolt_radius;
hot_end_left_bolt_x_pos = x_center - hot_end_fastening_bolt_x_offset;
hot_end_right_bolt_x_pos = x_center + hot_end_fastening_bolt_x_offset;
hot_end_bolts_y_pos = hot_end_hole_depth - hot_end_fastening_brim_height - hot_end_fastening_bolt_radius;
//bearings
bearing_bolt_radius = bearing_bolt_diameter/2;
bearing_radius = bearing_diameter/2;
hobbed_bolt_x_pos = x_center + bearing_bolt_radius;
hobbed_bolt_y_pos = hot_end_hole_depth+bearing_height_buffer+bearing_radius;
tension_bearing_x_pos = x_center - bearing_radius;
tension_bearing_y_pos = hot_end_hole_depth+bearing_height_buffer+bearing_radius;
tensioner_x_pos = hot_end_left_bolt_x_pos-hot_end_fastening_bolt_radius-tension_mount_buffer-tension_width;
tension_nut_radius = tension_nut_diameter/2;
tensioner_bearing_cutout_bottom = (hot_end_hole_depth+bearing_height_buffer-tension_mount_buffer)/2;
//motor
stepper_x_pos = hobbed_bolt_x_pos + stepper_distance*cos(motor_mount_angle);
stepper_y_pos = hobbed_bolt_y_pos + stepper_distance*sin(motor_mount_angle);

// And now the actual csg tree!

difference() {
    union() {
        // quickfit
        translate([quickfit_height/2,0,0]) square([quickfit_base_length-quickfit_height,quickfit_height]);
        translate([quickfit_height/2,quickfit_height/2,0]) circle(d=quickfit_height);
        translate([quickfit_base_length-quickfit_height/2,quickfit_height/2,0]) circle(d=quickfit_height);
        translate([(quickfit_base_length-arbitrary_base_length)/2,0,0]){
            // arbitrary base
            translate([arbitrary_base_height/2,0,0]) square([arbitrary_base_length-arbitrary_base_height,arbitrary_base_height]);
            translate([arbitrary_base_height/2,arbitrary_base_height/2,0]) circle(d=arbitrary_base_height);
            translate([arbitrary_base_length-arbitrary_base_height/2,arbitrary_base_height/2,0]) circle(d=arbitrary_base_height);
        }
        // body section
        translate([hot_end_left_bolt_x_pos-hot_end_fastening_bolt_radius,0,0])
            square([hot_end_fastening_bolt_x_offset+hot_end_fastening_bolt_radius+bearing_bolt_radius+bearing_radius+3,  hot_end_hole_depth+bearing_height_buffer+bearing_diameter+tension_nut_diameter+4]);
        // motor mount
        translate([hobbed_bolt_x_pos,hobbed_bolt_y_pos]){
            rotate([0,0,motor_mount_angle]) translate([0,-motor_casing/2,0]) square([stepper_distance+motor_casing/2,motor_casing]);
        }
        translate([tensioner_x_pos+tension_width/2,0]) {
            translate([0,tensioner_bearing_cutout_bottom]) circle(r=tensioner_bearing_cutout_bottom);
            square([tension_width/2+tension_mount_buffer,2*tensioner_bearing_cutout_bottom]);
        }
    }
    translate([hobbed_bolt_x_pos,hobbed_bolt_y_pos]) circle(r=bearing_bolt_radius);
    translate([tension_bearing_x_pos,tension_bearing_y_pos]) circle(r=bearing_radius+tension_mount_buffer);
    translate([0,hot_end_bolts_y_pos,0]){
        translate([hot_end_left_bolt_x_pos,0,0]) circle(r=hot_end_fastening_bolt_radius,$fn=6);
        translate([hot_end_right_bolt_x_pos,0,0]) circle(r=hot_end_fastening_bolt_radius,$fn=6);
    }
}

