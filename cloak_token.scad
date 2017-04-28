include <common.scad>

TOKEN_DIAMETER = 23;
TOKEN_RADIUS = TOKEN_DIAMETER / 2;
TIP_LENGTH = 2;
TIP_WIDTH = 9;
TIP_CENTER_ANGLE = 45;
TIP_ANGLE = angle_of_chord(TOKEN_RADIUS, TIP_WIDTH);
TIP_ANGLE_HALF = TIP_ANGLE / 2;
TAIL_LENGTH = 3.6;
TAIL_POINT_TO_POINT = 12.55;
TAIL_POINT_TO_SPUR = 13.5;
TAIL_CENTER_ANGLE = -135;
TAIL_ANGLE = angle_of_chord(TOKEN_RADIUS + TAIL_LENGTH, TAIL_POINT_TO_POINT);
TAIL_ANGLE_HALF = TAIL_ANGLE / 2;
TAIL_SPUR_ANGLE = 27;
TAIL_BASE_ANGLE_HALF = 90;

WELL_RIM = 2.8;

token_base() {
    circle(d=TOKEN_DIAMETER);
    // tip
    tip = point_on_circle(angle=TIP_CENTER_ANGLE, r=TOKEN_RADIUS + TIP_LENGTH);
    lci = point_on_circle(angle=TIP_CENTER_ANGLE + TIP_ANGLE_HALF, r=TOKEN_RADIUS);
    ldelta = (tip - lci) / 2;
    lcont = lci - ldelta;
    rci = point_on_circle(angle=TIP_CENTER_ANGLE - TIP_ANGLE_HALF, r=TOKEN_RADIUS);
    rdelta = (tip - rci) / 2;
    rcont = rci - rdelta;
    polygon([tip, lci, lcont, rcont, rci]);
    // tail
    tllbase = point_on_circle(angle=TAIL_CENTER_ANGLE + TAIL_BASE_ANGLE_HALF, r=TOKEN_RADIUS);
    tllpoint = point_on_circle(angle=TAIL_CENTER_ANGLE + TAIL_ANGLE_HALF, r=TOKEN_RADIUS + TAIL_LENGTH);
    tllspur = point_at_angle(point=tllpoint, angle=TAIL_CENTER_ANGLE - TAIL_SPUR_ANGLE, dist=-TAIL_POINT_TO_SPUR);
    tail = point_on_circle(angle=TAIL_CENTER_ANGLE, r=TOKEN_RADIUS);
    tlrbase = point_on_circle(angle=TAIL_CENTER_ANGLE - TAIL_BASE_ANGLE_HALF, r=TOKEN_RADIUS);
    tlrpoint = point_on_circle(angle=TAIL_CENTER_ANGLE - TAIL_ANGLE_HALF, r=TOKEN_RADIUS + TAIL_LENGTH);
    tlrspur = point_at_angle(point=tlrpoint, angle=TAIL_CENTER_ANGLE + TAIL_SPUR_ANGLE, dist=-TAIL_POINT_TO_SPUR);
    polygon([tllbase, tllspur, tllpoint, tail, tlrpoint, tlrspur, tlrbase]);
}
token_symbol() {
    rotate([28, 0]) {
        translate([-1, -1]) {
            text("k", font=XWING_FONT, halign="center", valign="center");
        }
    }
}