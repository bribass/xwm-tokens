include <common.scad>

TOKEN_DIAMETER = 44.25;
TOKEN_RADIUS = TOKEN_DIAMETER / 2;
TOKEN_CUT_TO_CUT = 40;
TOKEN_CUT_POS_X = (TOKEN_CUT_TO_CUT / 2) + TOKEN_RADIUS;
CENTER_RADIUS = 24.4;

PART = "both";

if(PART == "guide") {
    guide_part();
} else if(PART == "noguide") {
    no_guide_part();
} else {
    guide_part();
    translate([TOKEN_DIAMETER, 0, 0]) no_guide_part();
    translate([-TOKEN_DIAMETER, 0, 0]) no_guide_part();
}

module guide_part() {
    linear_extrude(TOKEN_THICKNESS) {
        difference() {
            // main circle
                union() {
                    // top half
                    difference() {
                        translate([0, CENTER_RADIUS - 4.9]) {
                            circle(r=CENTER_RADIUS);
                        }
                        translate([-CENTER_RADIUS, -5]) {
                            square([CENTER_RADIUS * 2, CENTER_RADIUS], center=false);
                        }
                    }
                    // bottom half
                    difference() {
                        translate([0, CENTER_RADIUS - 4.73]) {
                            circle(r=CENTER_RADIUS);
                        }
                        translate([-CENTER_RADIUS, CENTER_RADIUS]) {
                            square([CENTER_RADIUS * 2, CENTER_RADIUS], center=false);
                        }
                        translate([-NUB_SPACING_HALF, -10]) {
                            square([NUB_SPACING, 10], center=false);
                        }
                    }
                }
            // cut outs at each side
            for(dist = [-TOKEN_CUT_POS_X, TOKEN_CUT_POS_X]) {
                translate([dist, TOKEN_RADIUS]) {
                    circle(d=TOKEN_DIAMETER);
                }
            }
        }
        guide_nubs();
    }
    translate([0, TOKEN_RADIUS, TOKEN_THICKNESS]) {
        cluster_mine();
    }
}
module no_guide_part() {
    translate([0, TOKEN_RADIUS, 0]) {
        linear_extrude(TOKEN_THICKNESS) {
            circle(d=TOKEN_DIAMETER);
        }
    }
    translate([0, TOKEN_RADIUS, TOKEN_THICKNESS]) {
        cluster_mine();
    }
}
// cluster mines
module cluster_mine() {
    intersection() {
        rotate([0, 0, -45]) {
            scale([15, 9, 5]) {
                sphere(d=1);
            }
        }
        translate([-15, -15, 0]) {
            cube(30, center=false);
        }
    }
}
