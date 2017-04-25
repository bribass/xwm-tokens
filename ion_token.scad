include <common.scad>

TOKEN_DIAMETER = 19.5;
TOKEN_RADIUS = TOKEN_DIAMETER / 2;
SPIKE_LENGTH = (23.75 - TOKEN_DIAMETER) / 2;
SPIKE_WIDTH = 4.75;
SPIKE_ANGLE = angle_of_chord(TOKEN_RADIUS, SPIKE_WIDTH);
SPIKE_ANGLE_HALF = SPIKE_ANGLE / 2;

token_base() {
    circle(d=TOKEN_DIAMETER);
    for(theta = [45 : 90 : 359]) {
        tip = point_on_circle(angle=theta, r=TOKEN_RADIUS + SPIKE_LENGTH);
        lci = point_on_circle(angle=theta + SPIKE_ANGLE_HALF, r=TOKEN_RADIUS);
        ldelta = tip - lci;
        lcont = lci - ldelta;
        rci = point_on_circle(angle=theta - SPIKE_ANGLE_HALF, r=TOKEN_RADIUS);
        rdelta = tip - rci;
        rcont = rci - rdelta;
        polygon([tip, lci, lcont, rcont, rci]);
    }
}
token_symbol() {
    translate([-0.25, -0.25]) {
        scale([1.75, 1.75]) {
            intersection() {
                text("\u00f3", font=XWING_FONT, halign="center", valign="center");
                circle(d=10);
            }
        }
    }
}
