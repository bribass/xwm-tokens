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

// Module to create the token symbol given the 2D outline
module token_symbol() {
    translate([0, 0, TOKEN_THICKNESS - WELL_DEPTH]) {
        linear_extrude(WELL_DEPTH) {
            children();
        }
    }
}

// Function to determine a point on a circle (for use in calls to polygon())
function point_on_circle(angle, r) = [cos(angle) * r, sin(angle) * r];

// Function to determine the central angle a chord of a circle sweeps out
function angle_of_chord(r, l) = 2 * asin(l / (2 * r));

// Function to determine a new point that is a set distance and angle from an existing point
function point_at_angle(point, angle, dist) = point + point_on_circle(angle, dist);
