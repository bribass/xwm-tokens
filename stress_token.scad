include <common.scad>

// token base
translate([-(22.089/2), -11, 0]) {
    difference() {
        linear_extrude(TOKEN_THICKNESS) {
            polygon([[10.045, 0], [12.045, 0], [22.089, 16.94], [21.069, 18.66], [1.02, 18.66], [0, 16.94]]);
        }
        translate([0, 0, TOKEN_THICKNESS - WELL_DEPTH]) {
            linear_extrude(WELL_DEPTH) {
                polygon([[10.50, 0.80], [11.589, 0.80], [21.159, 16.94], [20.613, 17.86], [1.476, 17.86], [0.93, 16.94]]);
            }
        }
    }
}

// token symbol
translate([0, 0, TOKEN_THICKNESS - WELL_DEPTH]) {
    linear_extrude(WELL_DEPTH) {
        scale([2.25, 1, 1]) {
            text("!", font="Liberation Sans", halign="center", valign="center");
        }
    }
}
