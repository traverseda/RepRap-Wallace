
include <cold_end_settings.scad>;

rotate([180,0,0])


difference() {
    union() {

        //support material for bearing cutout
        translate([hobbed_bolt_x_pos,hobbed_bolt_y_pos,height-bearing_width]) {
            rotate_extrude(convexity=10) for(II=[2:4]){
                translate([II*bearing_radius/5,0,0]) square([.7,bearing_width]);
            }
            translate([0,0,bearing_width-.5]) cylinder(r=bearing_radius-1.5,h=.5);
        }
        // support material for fulcrum cutout
        translate([tensioner_x_pos+tension_width/2,tension_fulcrum_support_center*2-tension_fulcrum_bolt_diameter,height-height/6]) {
            translate([0,0,height/6-.5]) cylinder(r=tension_width/2+tension_mount_buffer -1,h=.5);
            rotate_extrude(convexity=10) for(II=[2:3]){
                translate([II*(tension_width/2+tension_mount_buffer)/4,0,0]) square([.7,height/6]);
            }
        }

        linear_extrude(height=height,convexity=10) difference() {
            union() {
                // arbitrary base
                translate([(quickfit_base_length-arbitrary_base_length)/2,0,0]){
                    // arbitrary base
                    translate([arbitrary_base_height/2,0,0]) square([arbitrary_base_length-arbitrary_base_height,arbitrary_base_height]);
                    translate([arbitrary_base_height/2,arbitrary_base_height/2,0]) circle(d=arbitrary_base_height);
                    translate([arbitrary_base_length-arbitrary_base_height/2,arbitrary_base_height/2,0]) circle(d=arbitrary_base_height);
                }
                // body section
                difference(){
                    translate([hot_end_left_bolt_x_pos-hot_end_fastening_bolt_radius,0,0])
                        square([arbitrary_base_end_x-arbitrary_base_height/2-(hot_end_left_bolt_x_pos-hot_end_fastening_bolt_radius), body_height]);
                    translate([arbitrary_base_end_x-arbitrary_base_height/2,hobbed_bolt_y_pos,0]) resize([2*(arbitrary_base_end_x-arbitrary_base_height/2-(hobbed_bolt_x_pos+bearing_radius+bearing_support_wall_thickness)),2*(hobbed_bolt_y_pos-arbitrary_base_height),0]) circle($fn=64);
                }
                // motor mount
                translate([hobbed_bolt_x_pos,hobbed_bolt_y_pos]) rotate([0,0,motor_mount_angle]) {
                    translate([0,-motor_casing/2,0]) square([stepper_distance+motor_casing/2,motor_casing]);
                }
                // tensioner fulcrum
                translate([tensioner_x_pos+tension_width/2,0]) {
                    translate([0,tension_fulcrum_support_center]) circle(r=tension_fulcrum_support_center);
                    square([tension_width/2+tension_mount_buffer,2*tension_fulcrum_support_center]);
                }
            }
            translate([hobbed_bolt_x_pos,hobbed_bolt_y_pos]) circle(r=bearing_bolt_radius);
            translate([tension_bearing_x_pos,tension_bearing_y_pos]) circle(r=bearing_radius+tension_mount_buffer);
            translate([0,hot_end_bolts_y_pos,0]){
                translate([hot_end_left_bolt_x_pos,0,0]) circle(r=hot_end_fastening_bolt_radius*ra6,$fn=6);
                translate([hot_end_right_bolt_x_pos,0,0]) circle(r=hot_end_fastening_bolt_radius*ra6,$fn=6);
            }
            // motor mount 2d cutout
            translate([hobbed_bolt_x_pos,hobbed_bolt_y_pos]) rotate([0,0,motor_mount_angle]) {
                translate([stepper_distance,0,0]) circle(r=motor_screw_spacing/2);
                for(xside=[-1,1]) for(yside=[-1,1]) translate([stepper_distance+motor_screw_spacing/2*xside,motor_screw_spacing/2*yside,0]) circle(r=motor_screw_radius*ra6,$fn=6);
            }
            // tensioner fulcrum 2d cutout
            translate([tensioner_x_pos+tension_width/2,tension_fulcrum_support_center*2-tension_fulcrum_bolt_diameter,0]) circle(r=tension_fulcrum_bolt_radius*ra6,$fn=6);
        }
        // quickfit
        translate([0,0,(height-max_quickfit_height)*quickfit_offset_ratio])
        linear_extrude(height=max_quickfit_height,convexity=10) difference() {
            translate([x_center,0,0]) {
                for (side = [0,1]) mirror([side,0,0]) {
                    translate([(arbitrary_base_length/2-arbitrary_base_height/2),0,0]) square([((quickfit_base_length/2-quickfit_height/2)-(arbitrary_base_length/2-arbitrary_base_height/2)),quickfit_height]);
                    translate([quickfit_base_length/2-quickfit_height/2,quickfit_height/2,0]) circle(d=quickfit_height,$fn=8);
                    translate([arbitrary_base_length/2-arbitrary_base_height/2,quickfit_height/2,0]) circle(d=quickfit_height,$fn=8);
                }
            }
        }
    }//end union
    translate([hobbed_bolt_x_pos,hobbed_bolt_y_pos,height]) rotate([0,0,motor_mount_angle]) {
        for(xside=[-1,1]) for(yside=[-1,1]) translate([stepper_distance+motor_screw_spacing/2*xside,motor_screw_spacing/2*yside,0]) rotate([180,0,0]) cylinder(h=motor_screw_diameter,r=motor_screw_diameter*ra6,$fn=6);
    }
    // body cutout where the motor will mount
    linear_extrude(height=height-motor_mount_width,convexity=10) {
        translate([arbitrary_base_end_x-arbitrary_base_height/2,hobbed_bolt_y_pos,0]) resize([2*(arbitrary_base_end_x-arbitrary_base_height/2-(hobbed_bolt_x_pos+bearing_radius+bearing_support_wall_thickness)),2*(hobbed_bolt_y_pos-arbitrary_base_height),0]) circle($fn=64);
        // cutout at top of body. Makes it look questionably better, but fucks with the geometry's happiness.
        translate([0,body_height,0]) square([quickfit_base_length,bearing_diameter+stepper_distance+motor_casing]);
        translate([hobbed_bolt_x_pos -.01,hobbed_bolt_y_pos -.01,0]) rotate([0,0,motor_mount_angle]){
            difference(){
                translate([0,-motor_casing/2,0]) square([stepper_distance+motor_casing/2 +.1,motor_casing +.1]);
                translate([-(bearing_diameter+2*bearing_support_wall_thickness)/2,0,0]) square([bearing_diameter+2*bearing_support_wall_thickness,motor_casing/2+1]);
                rotate([0,0,-90-motor_mount_angle]) square([hobbed_bolt_y_pos,arbitrary_base_end_x-arbitrary_base_height/2-hobbed_bolt_x_pos]);
                circle(r=bearing_radius+bearing_support_wall_thickness);
            }
        }
    }
    // filament feed cutout
    difference(){
        filament_feeder_ratio=1/2;
        filament_feed_curve_start_height=body_height-filament_feeder_ratio*(hobbed_bolt_x_pos-hot_end_left_bolt_x_pos);
        translate([x_center,filament_feed_curve_start_height,height/2]) rotate([-90,0,0])
        {
            rotate_extrude(convexity=10,$fn=6){
                difference(){
                    square([filament_feeder_ratio*(hobbed_bolt_x_pos-hot_end_left_bolt_x_pos), body_height-filament_feed_curve_start_height+.01]);
                    translate([filament_feeder_ratio*(hobbed_bolt_x_pos-hot_end_left_bolt_x_pos), 0,0])
                    resize([2*(filament_feeder_ratio*(hobbed_bolt_x_pos-hot_end_left_bolt_x_pos)-(filament_radius+filament_buffer)),2*(body_height-filament_feed_curve_start_height)]) circle($fn=32);
                }
            }
            rotate([180,0,0]) cylinder(r=filament_radius*ra6+filament_buffer,h=filament_feed_curve_start_height,$fn=6);
        }
        translate([hobbed_bolt_x_pos,hobbed_bolt_y_pos,height-motor_mount_width]) rotate([0,0,motor_mount_angle]) {
            translate([0,-motor_casing/2,0]) cube([stepper_distance+motor_casing/2,motor_casing,motor_mount_width]);
        }
        //translate([0,0,height-motor_mount_width]) cube([quickfit_base_length,body_height,motor_mount_width]);
    }
    // hotend cutout
    translate([x_center,-0.1,height/2]) rotate([-90,180/8,0]) cylinder(r=hot_end_radius*ra8,h=hot_end_hole_depth,$fn=8);
    // tensioner bolt cutouts
    translate([hot_end_left_bolt_x_pos+tension_nut_inset,body_height-tension_nut_diameter/2-tension_nut_top_buffer,height/2]) for (top_or_bottom = [0,1]) mirror([0,0,top_or_bottom]) {
        translate([0,0,height/4]) {
            translate([0,tension_nut_diameter/2,0]) cube([tension_nut_diameter*.707,tension_nut_diameter*2,tension_nut_diameter],center=true);
            difference(){
                union(){
                    translate([5,-5+tension_bolts_diameter/2,0]) cube([10,10,tension_bolts_diameter],center=true);
                    translate([-5,5-tension_bolts_diameter/2,0]) cube([10,10,tension_bolts_diameter],center=true);
                }
                rotate([0,0,60]){
                    translate([-5-tension_bolts_diameter/2,-5,0]) cube([10,10,tension_bolts_diameter],center=true);
                    translate([5+tension_bolts_diameter/2,5,0]) cube([10,10,tension_bolts_diameter],center=true);
                }
            }
        }
    }
    // things cut out of the sides!
    translate([0,0,height/2]) for (top_or_bottom = [0,1]) mirror([0,0,top_or_bottom]) {
        // bearing cutouts
        translate([hobbed_bolt_x_pos,hobbed_bolt_y_pos,-height/2]) cylinder(r=bearing_radius,h=bearing_width);
        // fulcrum attachment cutouts
        translate([tensioner_x_pos+tension_width/2,tension_fulcrum_support_center*2-tension_fulcrum_bolt_diameter,-height/2]) {
            cylinder(r=tension_width/2+tension_mount_buffer,h=height/6);
            rotate([0,0,45]) translate([-tension_width/2-tension_mount_buffer,0,0]) cube([tension_width+2*tension_mount_buffer,10,height/6]);
            translate([-tension_width/2-tension_mount_buffer,0,0]) cube([tension_width+2*tension_mount_buffer,10,height/6]);
        }
    }
}//end difference


