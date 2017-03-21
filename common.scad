// Font information
use <font/dist/xwing-miniatures.ttf>
XWING_FONT = "x\\-wing\\-symbols:style=wing\\-symbols";

// Increase resolution on circles
$fn = 120;

// Dimension constants
TOKEN_THICKNESS = 2.25;
WELL_DEPTH = 1.2;
WELL_RIM = 0.8;
TOLERANCE = 0.05;

// Module to create a token base given the 2D outline
module token_base() {
    difference() {
        linear_extrude(TOKEN_THICKNESS) {
            children();
        }
        translate([0, 0, TOKEN_THICKNESS - WELL_DEPTH]) {
            linear_extrude(WELL_DEPTH + TOLERANCE) {
                offset(delta=-WELL_RIM) {
                    children();
                }
            }
        }
    }
}
