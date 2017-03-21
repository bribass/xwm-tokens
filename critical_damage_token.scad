include <common.scad>

TOKEN_DIAMETER = 21.362;

token_base() {
    circle(d=TOKEN_DIAMETER, $fn=6);
}
token_symbol() {
    text("c", font=XWING_FONT, halign="center", valign="center");
}
