include <settings.scad>;

!z_stop_arm();

module z_stop_arm() difference() {
    rotate([90,0,90]) linear_extrude(height = z_stop_arm_height,convexity=5) difference() {
        union(){
            square([x_end_cylinder_protrution_depth + z_stop_arm_x_support_depth, distance_between_x_end_cylinders]);
            translate([x_end_cylinder_protrution_depth + z_stop_arm_x_support_depth,0,0]) square([z_stop_arm_depth-z_stop_arm_x_support_depth-x_end_cylinder_protrution_depth, z_stop_arm_actuator_width]);
        }
        translate([x_end_cylinder_protrution_depth+z_stop_arm_x_support_depth, distance_between_x_end_cylinders]) resize([(z_stop_arm_x_support_depth)*2,(distance_between_x_end_cylinders-z_stop_arm_actuator_width)*2]) circle($fn=32);
        for (ii = [0,1]){
            translate([-x_end_front_face_y_offset, ii*distance_between_x_end_cylinders,0]) circle(x_end_cylinder_radius);
        }
    }
    cube([z_stop_arm_actuator_height, z_stop_arm_depth-z_stop_arm_actuator_depth, distance_between_x_end_cylinders]);
    translate([z_stop_arm_height,z_stop_arm_depth,0]) resize([2*(z_stop_arm_height-z_stop_arm_actuator_height-z_stop_arm_actuator_depth), 2*(z_stop_arm_depth-x_end_cylinder_protrution_depth),distance_between_x_end_cylinders]) cylinder($fn=4);
    
    translate([z_stop_arm_height-(z_stop_arm_height-z_stop_arm_actuator_height)/2,0,distance_between_x_end_cylinders/2])
		rotate([-90, 0, 0]) {
			translate([0,0,x_end_cylinder_protrution_depth]) cylinder(r = m3_nut_size * da6, h = 100, center = false, $fn = 6);
			cylinder(r = m3_size * da6, h = 100, center = false, $fn = 6);
		}
}
