include <common.scad>

TOKEN_DIAMETER = 18.75;

token_base() {
    rotate([0, 0, 22.5]) {
        circle(d=TOKEN_DIAMETER, $fn=8);
    }
}
token_symbol() {
    text("j", font=XWING_FONT, halign="center", valign="center");
}
