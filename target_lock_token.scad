include <common.scad>

BASE_CORNER_RADIUS = 2;
BASE_PT_A_X = 9.55 - BASE_CORNER_RADIUS;
BASE_PT_A_Y = 12.4 - BASE_CORNER_RADIUS;
BASE_PT_B_X = 8.3 - BASE_CORNER_RADIUS;
BASE_PT_B_Y = 5.2 - BASE_CORNER_RADIUS;
BASE_PT_C_X = 14.4 - BASE_CORNER_RADIUS;
BASE_PT_C_Y = 5.8 - BASE_CORNER_RADIUS;
TEXT_SIZE = 3.35;
CIRCLE_OUTER_RADIUS = 5.5;
CIRCLE_INNER_RADIUS = CIRCLE_OUTER_RADIUS - 0.8;
SPUR_LENGTH = 3.75;
SPUR_WIDTH = 3.4;
SPUR_ANGLE = angle_of_chord(CIRCLE_OUTER_RADIUS, SPUR_WIDTH);
SPUR_ANGLE_HALF = SPUR_ANGLE / 2;

WELL_RIM = 1.6;

LETTER = "@@";

token_base() {
    minkowski() {
        polygon([
                 [ BASE_PT_A_X,  BASE_PT_A_Y],
                 [ BASE_PT_B_X,  BASE_PT_B_Y],
                 [ BASE_PT_C_X,  BASE_PT_C_Y],
                 [ BASE_PT_C_X, -BASE_PT_C_Y],
                 [ BASE_PT_B_X, -BASE_PT_B_Y],
                 [ BASE_PT_A_X, -BASE_PT_A_Y],
                 [-BASE_PT_A_X, -BASE_PT_A_Y],
                 [-BASE_PT_B_X, -BASE_PT_B_Y],
                 [-BASE_PT_C_X, -BASE_PT_C_Y],
                 [-BASE_PT_C_X,  BASE_PT_C_Y],
                 [-BASE_PT_B_X,  BASE_PT_B_Y],
                 [-BASE_PT_A_X,  BASE_PT_A_Y]
                ]);
        circle(r=BASE_CORNER_RADIUS);
    }
}
token_symbol() {
    // letter
    text(LETTER, size=TEXT_SIZE, font="Liberation Sans:style=Bold", halign="center", valign="center");
    // circle
    difference() {
        circle(r=CIRCLE_OUTER_RADIUS);
        circle(r=CIRCLE_INNER_RADIUS);
    }
    // spurs off of circle
    for(theta = [0 : 90 : 359]) {
        polygon([
                 point_on_circle(theta + SPUR_ANGLE_HALF, CIRCLE_OUTER_RADIUS),
                 point_on_circle(theta, CIRCLE_OUTER_RADIUS + SPUR_LENGTH),
                 point_on_circle(theta - SPUR_ANGLE_HALF, CIRCLE_OUTER_RADIUS)
                ]);
    }
}