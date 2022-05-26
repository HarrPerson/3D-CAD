fnQuali=75;

module boxBody(depth, width, height,roundsize) {
    union() {
        minkowski() {
            cube([  width - (roundsize),
                    depth - (roundsize),
                    height - 1], true);
            cylinder(d=roundsize, h=1, $fn=fnQuali);
        }
    }
}

module boxRecess(depth,width,height,roundsize,wallthick) {
    union() {
        minkowski() {
            cube([  width - (2 * wallthick) - (roundsize),
                    depth - (2 * wallthick) - (roundsize),
                    height - 1], true);
            cylinder(d=roundsize, h=1, $fn=fnQuali);
        }
    }
}

module boxFrame(depth,width,height,roundsize,wallthick) {
    union() {
        difference() {
            boxBody(depth,width,height,roundsize);
            translate([0,0,wallthick])
                boxRecess(depth,width,height,roundsize,wallthick);
        }
    }
}


module box(depth = 100, width = 50, height = 20, roundsize = 5, wallthick = 4, bottomborder = 1) {
    if (bottomborder >= wallthick) {
        echo("WARNING");
        echo("WARNING: bottomborder >= wallthick!!");
        echo("WARNING");
    }
    union() {
        difference() {
            boxFrame(depth,width,height,roundsize,wallthick);
            translate([0,0,-(height - bottomborder)])
                    boxFrame(depth,width,height,roundsize,wallthick);
        }
    }
}



module divider(orientation = "horizontal", length = 100, height = 20, wallthick = 4, dividerthick = 2) {
    if (orientation == "horizontal") {
        rotate([0,0,90])
            cube([length - (2*wallthick), dividerthick, height], true);

    }
    cube([length, dividerthick, height], true);
}


box(depth = 100, width = 50, height = 20, roundsize = 5, wallthick = 3, bottomborder = 2);
*divider(orientation = "horizontal", length = 100, height = 20, wallthick = 4, dividerthick = 2);

