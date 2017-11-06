include <common.scad>

TOKEN_DIAMETER = 18.55;
FRONT_REAR_OUTER_DIAMETER = 14.5;
FRONT_REAR_INNER_DIAMETER = 11.5;
REAR_SEPARATION_ANGLE = 10;

SIDE = "both";

token_base() {
    circle(d=TOKEN_DIAMETER);
}
token_symbol() {
    if(SIDE == "front") {
        union() {
            translate([-1, 0]) {
                scale([0.8, 0.8]) {
                    text("i", font=XWING_FONT, halign="center", valign="center");
                }
            }
            intersection() {
                difference() {
                    circle(d=FRONT_REAR_OUTER_DIAMETER);
                    circle(d=FRONT_REAR_INNER_DIAMETER);
                }
                polygon([[0, 0],
                         point_on_circle(45, FRONT_REAR_OUTER_DIAMETER * 1.25),
                         point_on_circle(-45, FRONT_REAR_OUTER_DIAMETER * 1.25)
                        ]);
            }
        }
    } else if(SIDE == "rear") {
        union() {
            translate([1, 0]) {
                scale([0.8, 0.8]) {
                    text("i", font=XWING_FONT, halign="center", valign="center");
                }
            }
            intersection() {
                difference() {
                    circle(d=FRONT_REAR_OUTER_DIAMETER);
                    circle(d=FRONT_REAR_INNER_DIAMETER);
                }
                filled_angle = (90 - 2 * REAR_SEPARATION_ANGLE) / 3;
                polygon([[0, 0],
                         point_on_circle(135, FRONT_REAR_OUTER_DIAMETER * 1.25),
                         point_on_circle(135 + filled_angle, FRONT_REAR_OUTER_DIAMETER * 1.25),
                         [0, 0],
                         point_on_circle(135 + filled_angle + REAR_SEPARATION_ANGLE, FRONT_REAR_OUTER_DIAMETER * 1.25),
                         point_on_circle(-135 - filled_angle - REAR_SEPARATION_ANGLE, FRONT_REAR_OUTER_DIAMETER * 1.25),
                         [0, 0],
                         point_on_circle(-135 - filled_angle, FRONT_REAR_OUTER_DIAMETER * 1.25),
                         point_on_circle(-135, FRONT_REAR_OUTER_DIAMETER * 1.25)
                        ]);
            }
        }
    }
}
