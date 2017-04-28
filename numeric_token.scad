include <common.scad>

TOKEN_WIDTH = 14.75;
TOKEN_WIDTH_HALF = TOKEN_WIDTH / 2;
TOKEN_HEIGHT = 17.25;
TEXT_SIZE = 7;

NUMBER = "00";

difference() {
    // token body
    linear_extrude(TOKEN_THICKNESS) {
        circle(d=TOKEN_WIDTH);
        polygon([
                 [TOKEN_WIDTH_HALF, 0],
                 [TOKEN_WIDTH_HALF, -(TOKEN_HEIGHT - TOKEN_WIDTH_HALF)],
                 [-TOKEN_WIDTH_HALF, -(TOKEN_HEIGHT - TOKEN_WIDTH_HALF)],
                 [-TOKEN_WIDTH_HALF, 0]
                ]);
    }
    // reduced thickness at bottom
    translate([-TOKEN_WIDTH_HALF, -(TOKEN_HEIGHT - TOKEN_WIDTH_HALF), 0]) {
        rotate([0, 90, 0]) {
            linear_extrude(TOKEN_WIDTH) {
                polygon([
                         [-TOKEN_THICKNESS, 0],
                         [-TOKEN_THICKNESS, TOKEN_THICKNESS * 2],
                         [-TOKEN_THICKNESS * 0.8, 0]
                        ]);
            }
        }
    }
    // token number
    translate([0, 0, TOKEN_THICKNESS - WELL_DEPTH]) {
        linear_extrude(WELL_DEPTH + TOLERANCE) {
            text(NUMBER, font="Liberation Sans:style=bold", size=TEXT_SIZE, halign="center", valign="center");
        }
    }
}
