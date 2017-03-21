include <common.scad>

// token base
slope_intercepts = [
    [ 0, 7.66 ],           // top triangle edge
    [ -1.6865, 24.5658 ],  // top right clipped corner
    [ 1.6865, -12.6865 ],  // right triangle edge
    [ 0, -11 ],            // bottom clipped corner
    [ -1.6865, -12.6865 ], // left triangle edge
    [ 1.6865, 24.5658 ]    // top left clipped corner
];
// Formulas for computing the intersection of two lines given by slope-intercept form (y = ax + c and y = bx + d)
// https://en.wikipedia.org/wiki/Line%E2%80%93line_intersection#Given_the_equations_of_the_lines
function si_intersect(a, b, c, d) = [ (d-c)/(a-b), ((a*d)-(b*c))/(a-b) ];
function si_intersect_for(v, i, j) = si_intersect(v[i][0], v[j][0], v[i][1], v[j][1]);

token_base() {
    polygon([
        for(i = [ 0 : len(slope_intercepts) - 1])
            si_intersect_for(slope_intercepts, i, i == (len(slope_intercepts) - 1) ? 0 : i + 1)
    ]);
}

// token symbol
translate([0, 0, TOKEN_THICKNESS - WELL_DEPTH]) {
    linear_extrude(WELL_DEPTH) {
        scale([2.25, 1, 1]) {
            text("!", font="Liberation Sans", halign="center", valign="center");
        }
    }
}
