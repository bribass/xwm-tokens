include <common.scad>

TOKEN_WIDTH = 32.25;
TOKEN_CENTER_X = TOKEN_WIDTH / 2;
TOKEN_HEIGHT = 30.2;
TOKEN_CENTER_Y = TOKEN_HEIGHT / 2;
TOKEN_FILLET = 2;

linear_extrude(TOKEN_THICKNESS) {
    minkowski() {
        translate([-(TOKEN_CENTER_X - TOKEN_FILLET), TOKEN_FILLET]) {
            square([TOKEN_WIDTH - (2 * TOKEN_FILLET), TOKEN_HEIGHT - (2 * TOKEN_FILLET)]);
        }
        circle(r=TOKEN_FILLET);
    }
    guide_nubs();
}
// ion bomb
translate([0, TOKEN_CENTER_Y, TOKEN_THICKNESS]) {
    intersection() {
        translate([0, 0, -.5]) {
            scale([7, 7, 2.5]) {
                soccerball();
            }
        }
        translate([-7, -7, 0]) {
            cube([14, 14, 3]);
        }
    }
}

// derived from https://github.com/nico/hack/blob/master/openscad/soccerball.scad
r = sqrt(3 / (1 + 2*sqrt(5)/5) - 1);
module f(n, m) {  // 5, 3: icosahedron; 3, 5: dodecahedron
    for (j = [0, 180]) {
        rotate([0, j, 0]) {
            for (i = [0:(n-1)]) {
                rotate([0, 0, i * 360 / n]) {
                    for (k = [0, 1]) {
                        rotate([0, -atan(r) - 2*k*atan(r*cos(180/m)), 0]) {
                            rotate([0, 0, 180*k]) {
                                cylinder(1, 0, r, $fn=m);
                            }
                        }
                    }
                }
            }
        }
    }
}
module soccerball() {
    intersection() {
        f(5, 3);
        rotate([0, 0, 36]) {
            rotate([0, 36, 0]) {
                f(3, 5);
            }
        }
    }
}
