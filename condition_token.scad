include <common.scad>

TOKEN_DIAMETER = 21.362;

linear_extrude(TOKEN_THICKNESS) {
    circle(d=TOKEN_DIAMETER, $fn=6);
}
