include <common.scad>

TOKEN_DIAMETER = 18.55;

token_base() {
    circle(d=TOKEN_DIAMETER);
}
token_symbol() {
    text("f", font=XWING_FONT, halign="center", valign="center");
}
