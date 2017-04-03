include <common.scad>

TOKEN_DIAMETER = 21.151;
NIBBLE_DIAMETER = 3.3;
NUB_DEPTH = 3.61;
HEX_SIZE = 2.223;
HEX_SPACING_X = HEX_SIZE * 1.2;
HEX_SPACING_Y = HEX_SPACING_X * sin(60);

// token base
difference() {
    cylinder(d=TOKEN_DIAMETER, h=TOKEN_THICKNESS / 2);
    // circular nibble
    for(theta = [0 : 45 : 359]) {
        rotate(theta - 11) {
            translate([TOKEN_DIAMETER / 2, 0, 0]) {
                cylinder(d=NIBBLE_DIAMETER, h=TOKEN_THICKNESS / 2 + TOLERANCE);
            }
        }
    }
}
// shield hexes
module hex() {
    rotate(90) {
        circle(d=HEX_SIZE, $fn=6);
    }
}
hexpositions = [ [-2 : 1 : 2], [-1.5 : 1 : 1.5], [-1 : 1 : 1] ];
linear_extrude(TOKEN_THICKNESS) {
    for(row = [0 : len(hexpositions)]) {
        for(col = hexpositions[row]) {
            translate([HEX_SPACING_X * col, HEX_SPACING_Y * row, 0]) {
                hex();
            }
            translate([HEX_SPACING_X * col, -HEX_SPACING_Y * row, 0]) {
                hex();
            }
        }
    }
}
// outer nubs
difference() {
    cylinder(d=TOKEN_DIAMETER, h=TOKEN_THICKNESS);
    cylinder(d=TOKEN_DIAMETER - (NUB_DEPTH * 2), h=TOKEN_THICKNESS + TOLERANCE);
    for(theta = [0 : 45 : 359]) {
        linear_extrude(TOKEN_THICKNESS + TOLERANCE) {
            polygon([
                     [0, 0],
                     [cos(theta - 2) * TOKEN_DIAMETER, sin(theta - 2) * TOKEN_DIAMETER],
                     [cos(theta - 20) * TOKEN_DIAMETER, sin(theta - 20) * TOKEN_DIAMETER]
                    ]);
        }
    }
}
