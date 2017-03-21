include <common.scad>

TOKEN_DIAMETER = 18.55;

// token base
token_base() {
    circle(d=TOKEN_DIAMETER);
}

// token symbol
translate([0, 0, TOKEN_THICKNESS - WELL_DEPTH]) {
    linear_extrude(WELL_DEPTH) {
        text("f", font=XWING_FONT, halign="center", valign="center");
    }
}
