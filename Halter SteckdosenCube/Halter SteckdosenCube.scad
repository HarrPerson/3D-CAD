$fn=100;

cube_size       = 82; //77.8
ausspahrung     = 55;
framewidth      = 4;
cut_shift       = (cube_size * 1/4);
holeradius      = 5;
edgeround       = 2;

module mountholes() {
    rotate([90, 0, 0])
        cylinder(framewidth, holeradius, holeradius);
}
module cut() {
    cube([ausspahrung,
          cube_size + (framewidth * 2),
          cube_size + (framewidth * 2)], center = true);
}


module innercube() {
    cube([  cube_size,
                    cube_size,
                    cube_size + framewidth *2], center = true);
}

module outercube() {
    minkowski() {
    cube([  cube_size + (framewidth * 2) - edgeround*2,
                    cube_size + (framewidth * 2)- edgeround*2,
                    cube_size + (framewidth * 2)- edgeround*2],  center = true);
    sphere(edgeround);
    }
}


module steckdosencupe() {
    difference() {
        outercube();
        translate([0, 0, framewidth])
            innercube();
        translate([0, framewidth + cut_shift, 0])
            cut();
        translate([0, -(cube_size/2), (cube_size * 1/2.5)])
            mountholes();
        translate([0, -(cube_size/2), -(cube_size * 1/2.5)])
            mountholes();
        translate([0, -(cube_size/2), 0])
            mountholes();
    };   
}


difference() {
    steckdosencupe();
    translate([0, 45, 60]) rotate([55, 0, 0]) 
        cube(cube_size *1.5, true);;
}