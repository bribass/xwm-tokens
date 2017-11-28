include <common.scad>

TOKEN_DIAMETER = 19;
NO_SYMBOL_RADIUS = 7.25;
NO_SYMBOL_THICKNESS = 1.25;

token_base() {
    circle(d=TOKEN_DIAMETER);
}
token_symbol() {
    union() {
        difference() {
            // icon
            scale([0.75, 0.75]) {
                text("%", font=XWING_FONT, halign="center", valign="center");
            }
            // negative space for no symbol crossbar
            pt = point_on_circle(45, NO_SYMBOL_RADIUS);
            adjust = no_symbol_crossbar_adjust(NO_SYMBOL_THICKNESS * 1.75);
            polygon([pt + adjust, pt - adjust, -pt - adjust, -pt + adjust]);
        }
        // no symbol, circle
        difference() {
            circle(r=NO_SYMBOL_RADIUS);
            circle(r=NO_SYMBOL_RADIUS - NO_SYMBOL_THICKNESS);
        }
        // no symbol, crossbar
        pt = point_on_circle(45, NO_SYMBOL_RADIUS - NO_SYMBOL_THICKNESS + TOLERANCE);
        adjust = no_symbol_crossbar_adjust(NO_SYMBOL_THICKNESS);
        polygon([pt + adjust, pt - adjust, -pt - adjust, -pt + adjust]);
    }
}

function no_symbol_crossbar_adjust(width) = [-width * sin(45) / 2 , width * sin(45) / 2];
