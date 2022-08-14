$fn=50;

LEGSCREW=3.5;

module leg(length = 150, thick = 10, screwhole = 3) {
    union() {
        difference() {
            //leg
            translate([0, 0, -0.5])
                minkowski() {
                    cylrad=thick/2.5;
                    cube([length-(2*cylrad), thick-(2*cylrad), thick-1], true);
                    cylinder(r=cylrad,h=1, true);
                }
            // Screwhole
            translate([(length/2)-screwhole*1.5, 0, 0])
                cylinder(h = thick + 10, r = screwhole/2, center = true);
                
            // Mountcut
            translate([(length/2)-screwhole, 0, 0])
                cube([thick*1.25, thick+5, thick*0.5], true);   

            //Speedholes
            for(i= [ (-length/2)+(1*thick) : 0.75*thick : (length/2)-(1*thick)] ) {
                translate([i, 0, 0]) cylinder(h = thick + 10, r = (thick/2)/2, center = true);
            }
        }
    }
}


module mountbase(length = 40, thick = 5, mountthick=5, screwhole = 3) {
    union() {
        //Plate
        translate([0, 0, -0.5])
            difference() {
                minkowski() {
                    cylrad=thick/2.5;
                    cube([length-(4*cylrad), length-(4*cylrad), thick-1], true);
                    cylinder(r=cylrad,h=1, true);
                }
                cylinder(h=thick+2, r=6.5, center=true);
            }

        //Mounts
        cylrad=mountthick/2.5;
        for( i = [0 : 120 : 360] ) {
            rotate([0, 0, i]) {
                translate([length/3, 0, -(mountthick+thick-cylrad)/2  ]) {
                    difference() {
                        // Foot
                        minkowski() {
                           cube([mountthick-(2*cylrad), mountthick/2 - 1, mountthick-cylrad], true);
                           rotate([90,0,0]) cylinder(h=1,r=cylrad, true);
                        }
                        //Screwhole
                        rotate([90,0,0])
                         translate([0,-(1*screwhole),0])
                            cylinder(h = thick + 10, r = screwhole/2, center = true);
                     }
                 }
             }
         }
     }
}




*leg(150, 10, LEGSCREW);
mountbase(65, 5, 10, LEGSCREW);

