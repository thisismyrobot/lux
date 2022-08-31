mode = "";
export = mode == "export";
$fn = export ? 150 : 30;

plate_width = 55;
plate_thickness = 2;
plate_offset = plate_width / 2;

upper_dome_diam = 25.8;
lower_dome_diam = 28;

box_width = 60.4;
box_length = 119;
box_height = 30;
box_hole_width = 45.5;
box_hole_height = 19;
box_inset_length = 16.9;
box_post_width = 8;
box_post_spacing = 34.5; // centres
box_post_inset = 10.9; // centres

module plate() {
    difference() {
        union() {
            circle(d=plate_width);
            translate([-box_hole_width/2, -plate_width/2-box_inset_length, 0]) square([box_hole_width, box_inset_length + plate_width/2]);
        }
        hull() {
            translate([-box_post_spacing/2, -box_post_inset-plate_width/2, 0]) circle(d=box_post_width);
            translate([-box_post_spacing, -box_post_inset-plate_width/2, 0]) circle(d=box_post_width);
        }
        hull() {
            translate([box_post_spacing/2, -box_post_inset-plate_width/2, 0]) circle(d=box_post_width);
            translate([box_post_spacing, -box_post_inset-plate_width/2, 0]) circle(d=box_post_width);
        }
    }
}

module upper_plate() {
    difference() {
        plate();
        circle(d=upper_dome_diam);
    }
}

module middle_plate() {
    difference() {
        plate();
        circle(d=lower_dome_diam);
    }
}

module bottom_plate() {
    plate();
}

module dome() {
    color("white") difference() {
        sphere(d=upper_dome_diam);
        translate([0, 0, -plate_width/2]) cube([plate_width, plate_width, plate_width], center=true);
    }
}

module box() {
    translate([0, 0, -box_hole_height / 2]) difference() {
        translate([-box_width/2, -box_length-plate_offset, -box_height/2]) cube([box_width, box_length, box_height]);
        translate([-box_hole_width/2, -box_length-plate_offset-1, -box_hole_height/2]) cube([box_hole_width, box_length+2, box_hole_height]);
    }
}

if (export) {
    upper_plate();
    translate([plate_width+10, 0, 0]) middle_plate();
    translate([-plate_width-10, 0, 0]) bottom_plate();
} else {
    translate([0, 0, -plate_thickness]) dome();
    color("grey") box();
    
    color("grey") translate([0, 0, -plate_thickness]) {
        linear_extrude(height=plate_thickness) upper_plate();
        translate([0, 0, -plate_thickness]) linear_extrude(height=plate_thickness) middle_plate();
        translate([0, 0, -plate_thickness*2]) linear_extrude(height=plate_thickness) bottom_plate();
    }
}