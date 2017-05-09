include <common.scad>

TOKEN_DIAMETER = 69.3;
TOKEN_RADIUS = TOKEN_DIAMETER / 2;
TOKEN_DIAMETER_AT_GUIDE = 67.75;
CENTER_TO_GUIDE = TOKEN_DIAMETER_AT_GUIDE - TOKEN_RADIUS;

linear_extrude(TOKEN_THICKNESS) {
    difference() {
        // main circle
        translate([0, CENTER_TO_GUIDE]) {
            circle(d=TOKEN_DIAMETER);
        }
        // flat spot near guide
        translate([-TOKEN_RADIUS, -TOKEN_RADIUS]) {
            square([TOKEN_DIAMETER, TOKEN_RADIUS]);
        }
    }
    guide_nubs();
}
// proximity bomb
translate([0, CENTER_TO_GUIDE, TOKEN_THICKNESS]) {
    rotate([0, 0, 30]) {
        difference() {
            minkowski() {
                cylinder(d=18.5, h=1.5, $fn=3);
                sphere(r=2);
            }
            translate([0, 0, 3]) {
                cylinder(d1=4, d2=5, h=.5);
            }
            translate([0, 0, 2.75]) {
                cylinder(d1=3, d2=4, h=.25);
            }
            for(theta = [30 : 120 : 359]) {
                rotate([0, 0, theta]) {
                    translate([0, 6.75, 3.25]) {
                        cylinder(d1=1, d2=2, h=.25);
                    }
                }
            }
        }
        translate([0, 0, 2.75]) {
            cylinder(d1=2, d2=1, h=.25);
        }
        rotate([0, 0, 330]) {
            translate([-1, 5.5, 0]) {
                minkowski() {
                    cube([2, 1, 2.5]);
                    sphere(r=1.5);
                }
            }
        }
    }
}

