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
// seismic charge
translate([0, TOKEN_CENTER_Y, TOKEN_THICKNESS]) {
    intersection() {
        scale([1, 1, .7]) {
            rotate([-30, 0, 0]) {
                translate([0, 0, -2.5]) {
                    cylinder(d=8.0, h=4);
                }
                translate([0, 0, -4]) {
                    cylinder(d=6.0, h=8);
                }
                translate([0, 0, 4]) {
                    cylinder(d1=5, d2=0, h=1);
                }
                for(theta=[-90, 90]) {
                    rotate([0, theta, 0]) {
                        translate([0, 0, 3.5]) {
                            cylinder(d=8, h=1);
                        }
                        translate([0, 0, 4.5]) {
                            cylinder(d1=7, d2=4, h=3);
                        }
                        translate([0, 0, 7.5]) {
                            cylinder(d=3, h=.5);
                        }
                    }
                }
            }
        }
        translate([-8, -5, 0]) {
            cube([16, 10, 5]);
        }
    }
}
