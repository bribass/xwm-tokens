include <common.scad>

TOKEN_DIAMETER = 21.362;

// token base
token_base() {
    circle(d=TOKEN_DIAMETER, $fn=6);
}

// token symbol
translate([0, 0, TOKEN_THICKNESS - WELL_DEPTH]) {
    linear_extrude(WELL_DEPTH) {
        text("c", font=XWING_FONT, halign="center", valign="center");
    }
}
