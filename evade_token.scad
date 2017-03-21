include <common.scad>

TOKEN_DIAMETER = 18.55;

// token base
difference() {
    cylinder(d=TOKEN_DIAMETER, h=TOKEN_THICKNESS);
    translate([0, 0, TOKEN_THICKNESS - WELL_DEPTH]) {
        cylinder(d=TOKEN_DIAMETER - 2*WELL_RIM, h=WELL_DEPTH);
    }
}

// token symbol
translate([0, 0, TOKEN_THICKNESS - WELL_DEPTH]) {
    linear_extrude(WELL_DEPTH) {
        text("e", font=XWING_FONT, halign="center", valign="center");
    }
}
