mode = "";
export = mode == "export";
$fn = export ? 150 : 30;

plate_width = 55;
plate_thickness = 2;
plate_offset = plate_width / 2;
plate_step = 3;

upper_dome_diam = 25.8;
lower_dome_diam = 28;
dome_inner_height = 13; // To hold wire and connector.
dome_inner_width = 10;

middle_plates = ceil(dome_inner_height / plate_thickness);

box_width = 60.4;
box_length = 119;
box_height = 30;
box_hole_width = 45.5;
box_hole_height = 19;
box_inset_length = 16.9;
box_post_width = 8;
box_post_spacing = 34.5; // centres
box_post_inset = 10.9; // centres

box_display_slot_from_end = 24.5;
box_display_slot_height = 8;
box_display_slot_length = 25.9;

module plate(step=0,tongue=0) {
    difference() {
        union() {
            circle(d=plate_width-step);
            translate([-box_hole_width/2, -plate_width/2-box_inset_length, 0]) square([box_hole_width, box_inset_length + plate_width/2]);
            translate([-box_hole_width/2+box_post_width, -plate_width/2-box_inset_length-tongue, 0]) square([box_hole_width-(box_post_width*2), box_inset_length + plate_width/2 + tongue]);
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

module top_plate() {
    difference() {
        plate(plate_step, box_display_slot_from_end+box_display_slot_height+10);
        circle(d=upper_dome_diam);
    }
}

module middle_plate() {
    difference() {
        plate();
        union() {
            circle(d=lower_dome_diam);
            translate([-dome_inner_width/2, -box_inset_length-plate_width/2-1, 0]) {
                square([dome_inner_width, box_inset_length+plate_width/2]);
            }
        }
    }
}

module bottom_plate() {
    plate(plate_step);
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
        translate([0, -plate_offset-(box_display_slot_height/2)-box_display_slot_from_end, box_height/2]) {
            cube([box_display_slot_length, box_display_slot_height, box_height], center=true);
        }
    }
}

if (export) {
    top_plate();
    translate([plate_width+10, 0, 0]) bottom_plate();
    for (p = [0:middle_plates-1]) {
        translate([(p+2)*(plate_width+10), 0, 0]) middle_plate();
    }
} else {
    translate([0, 0, -plate_thickness]) dome();
    color("silver") box();
    
    color("grey") translate([0, 0, -plate_thickness]) {
        linear_extrude(height=plate_thickness) top_plate();
        for (p = [1:middle_plates]) {
            translate([0, 0, -p*plate_thickness]) linear_extrude(height=plate_thickness) middle_plate();
        }
        translate([0, 0, -plate_thickness*(middle_plates+1)]) linear_extrude(height=plate_thickness) bottom_plate();
    }
}