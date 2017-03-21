include <common.scad>

// token base
token_base() {
    circle(d=21.362, $fn=6);
}

// token symbol
translate([0, 0, TOKEN_THICKNESS - WELL_DEPTH]) {
    linear_extrude(WELL_DEPTH) {
        text("c", font=XWING_FONT, halign="center", valign="center");
    }
}
