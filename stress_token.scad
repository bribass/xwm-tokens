include <common.scad>

// token base
token_base() {
    polygon([[-1, -11], [1, -11], [11.0445, 5.94], [10.0245, 7.66], [-10.0245, 7.66], [-11.0445, 5.94]]);
}

// token symbol
translate([0, 0, TOKEN_THICKNESS - WELL_DEPTH]) {
    linear_extrude(WELL_DEPTH) {
        scale([2.25, 1, 1]) {
            text("!", font="Liberation Sans", halign="center", valign="center");
        }
    }
}
