include <common.scad>

TOKEN_WIDTH = 19.35;
TOKEN_WIDTH_HALF = TOKEN_WIDTH / 2;
TOKEN_LENGTH = 22;
TOKEN_LENGTH_HALF = TOKEN_LENGTH / 2;
TOKEN_SNIP = 1.75;
TOKEN_SNIP_HALF = TOKEN_SNIP / 2;

token_base() {
    polygon([
             [TOKEN_SNIP_HALF, TOKEN_LENGTH_HALF],
             [TOKEN_WIDTH_HALF, TOKEN_SNIP_HALF],
             [TOKEN_WIDTH_HALF, -TOKEN_SNIP_HALF],
             [TOKEN_SNIP_HALF, -TOKEN_LENGTH_HALF],
             [-TOKEN_SNIP_HALF, -TOKEN_LENGTH_HALF],
             [-TOKEN_WIDTH_HALF, -TOKEN_SNIP_HALF],
             [-TOKEN_WIDTH_HALF, TOKEN_SNIP_HALF],
             [-TOKEN_SNIP_HALF, TOKEN_LENGTH_HALF]
    ]);
}
token_symbol() {
    translate([-0.25, 0]) {
        scale([1.75, 1.75]) {
            intersection() {
                text("\u00ef", font=XWING_FONT, halign="center", valign="center");
                circle(d=8.4);
            }
        }
    }
}
