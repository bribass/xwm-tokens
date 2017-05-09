include <common.scad>

TOKEN_WIDTH = 18.85;
TOKEN_WIDTH_HALF = TOKEN_WIDTH / 2;
TOKEN_SIDE = 13.5;
TOKEN_SIDE_HALF = TOKEN_SIDE / 2;

token_base() {
    polygon([
             [TOKEN_SIDE_HALF, TOKEN_WIDTH_HALF],
             [TOKEN_WIDTH_HALF, TOKEN_SIDE_HALF],
             [TOKEN_WIDTH_HALF, -TOKEN_SIDE_HALF],
             [TOKEN_SIDE_HALF, -TOKEN_WIDTH_HALF],
             [-TOKEN_SIDE_HALF, -TOKEN_WIDTH_HALF],
             [-TOKEN_WIDTH_HALF, -TOKEN_SIDE_HALF],
             [-TOKEN_WIDTH_HALF, TOKEN_SIDE_HALF],
             [-TOKEN_SIDE_HALF, TOKEN_WIDTH_HALF]
    ]);
}
token_symbol() {
    translate([-0.25, -0.25]) {
        scale([1.75, 1.75]) {
            intersection() {
                text("\u00f1", font=XWING_FONT, halign="center", valign="center");
                circle(d=10);
            }
        }
    }
}
