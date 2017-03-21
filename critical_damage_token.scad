include <common.scad>

// token base
token_base() {
    polygon([[-5.34, 9.25], [5.34, 9.25], [10.681, 0], [5.34, -9.25], [-5.34, -9.25], [-10.681, 0]]);
}

// token symbol
translate([0, 0, TOKEN_THICKNESS - WELL_DEPTH]) {
    linear_extrude(WELL_DEPTH) {
        text("c", font=XWING_FONT, halign="center", valign="center");
    }
}
