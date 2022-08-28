$fn = 100;

case_width = 55;
case_radius = 5;

upper_dome_diam = 25.8;
lower_dome_diam = 28;
upper_dome_offset = 7;

upper_display_length = 23;
upper_display_width = 6;
upper_display_offset = 17;
lower_display_width = 12;
lower_display_length = 38.2;
lower_display_length_offset = 6.7;  // Pins end.

module plate() {
    offset(r=case_radius) square(case_width-case_radius*2, center=true);
}

module upper_plate() {
    difference() {
        plate();
        translate([0, upper_dome_offset, 0]) {
            circle(d=upper_dome_diam);
        }
        translate([0, -upper_display_offset, 0]) {
            square([upper_display_length, upper_display_width], center=true);
        }
    }
}

module lower_plate() {
    difference() {
        plate();
        translate([0, upper_dome_offset, 0]) {
            circle(d=lower_dome_diam);
        }
        cutout_offset = ((lower_display_length - upper_display_length) / 2) - lower_display_length_offset;
        echo(cutout_offset);

        translate([cutout_offset, -upper_display_offset, 0]) {
            square([lower_display_length, lower_display_width], center=true);
        }
    }
}

upper_plate();
translate([case_width+10, 0, 0]) lower_plate();
