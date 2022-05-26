// openscad -o Stapelbox_rows_columns.stl -D 'rows=2'  -D 'columns=3' -D 'width=160' -D 'depth=80' -D 'height=20' Stapelbox.scad 


/* Bash script
#!/bin/bash
rows=5
columns=5

for (( r = 1; r <= ${rows}; r++ )) 
do
    for (( c = 1; c <= ${columns}; c++ )) 
    do
        cmd="openscad -o Stapelbox_${r}_${c}.stl -D 'rows=${r}'  -D 'columns=${c}' -D 'width=160' -D 'depth=80' -D 'height=20' Stapelbox.scad"
        echo $cmd
        $cmd
    done
done
*/

fnQuali=75;

module boxBody(depth, width, height, roundsize) {
    union() {
        minkowski() {
            cube([  width - (roundsize),
                    depth - (roundsize),
                    height], true);
            cylinder(d=roundsize, h=1, $fn=fnQuali);
        }
    }
}

module boxRecess(depth,width,height,roundsize,wallthick) {
    union() {
        minkowski() {
            cube([  width - (2 * wallthick) - (roundsize),
                    depth - (2 * wallthick) - (roundsize),
                    height], true);
            cylinder(d=roundsize, h=1, $fn=fnQuali);
        }
    }
}

module boxFrame(depth,width,height,roundsize,wallthick, bottomthick) {
    union() {
        difference() {
            boxBody(depth,width,height,roundsize);
            translate([0,0,bottomthick])
                boxRecess(depth,width,height,roundsize,wallthick);
        }
    }
}

module cover(depth = 100, width = 50, height = 20, roundsize = 5, wallthick = 4) {
    difference() {
        box(depth,width,height,roundsize,wallthick);
        translate([0,0,wallthick])
            cube([width + 5,depth + 5,height], true);
    }    
}

module pin() {
    cylinder(h=3, r1=2.5, r2=0, center=true,$fn=50);
}

module hole() {
    cylinder(h=3, r1=2.5, r2=0, center=true, $fn=50);
}


module holesBottom(depth = 100, width = 50, height = 20, wallthick = 4){
    union() {
        translate([width/2 - 3.0,depth/2 - 3.0,-height/2 + (1.5)])
            hole();

        translate([-width/2 + 3.0,depth/2 - 3.0,-height/2 + (1.5)])
            hole();

        translate([width/2 - 3.0,-depth/2 + 3.0,-height/2 + (1.5)])
            hole();

        translate([-width/2 + 3.0,-depth/2 + 3.0,-height/2 + (1.5)])
            hole();
    
    }
}
module pinsTop(depth = 100, width = 50, height = 20, wallthick = 4){
    union() {
        translate([width/2 - 3.0,depth/2 - 3.0,height/2 + (2)]) //hole h=3, minkowski size = 1
            pin();

        translate([-width/2 + 3.0,depth/2 - 3.0,height/2 + (2)]) //hole h=3, minkowski size = 1
            pin();

        translate([width/2 - 3.0,-depth/2 + 3.0,height/2 + (2)]) //hole h=3, minkowski size = 1
            pin();

        translate([-width/2 + 3.0,-depth/2 + 3.0,height/2 + (2)]) //hole h=3, minkowski size = 1
            pin();
    
    }
}

module box(depth = 100, width = 50, height = 20, roundsize = 5, wallthick = 4, bottomthick = 3) {
    echo("Measure outside:",  depth, "x", width, "x", height);
    echo("Measure inside:",  depth - 2*wallthick, "x", width - 2*wallthick, "x", height-bottomthick);
    echo("Wallthick:", wallthick);
        
    difference() {
        union(){
            boxFrame(depth,width,height,roundsize,wallthick,bottomthick);
            pinsTop(depth,width,height,wallthick);
        }
        holesBottom(depth,width,height,wallthick);
    }
}

module probeschnitt() {
        union() {
        translate([0,-30,0]) {
            cube([200,250,15], true);
            cube([300,200,50], true);
        }
    }
}

module dividers(rows = 2, columns = 3, width = 100, depth = 50, height = 20, wallthick = 4, bottomthick = 3, dividerthick = 2) {
    echo("Dividers: rows=", rows, "columns=", columns);
    
    if (rows < 2 || columns < 2) {
        echo("WARNING");
        echo("rows or columns < 2");
        echo("WARNING");
    }
    
    rowSize = (width - 2 * wallthick) / rows;
    columnSize = (depth - 2 * wallthick) / columns;
    
    if (rows > 1) {
        for(r = [1 : (rows-1)]) {
            translate([-(width/2 - wallthick) + (rowSize * r) ,0 , 0])
                divider("horizontal", width, depth, height, wallthick, bottomthick, dividerthick);
        }
    }
    
    if ( columns > 1) {
        for(c = [1 : (columns-1)]) {
            translate([0, -(depth/2 - wallthick) + (columnSize* c), 0]) 
                divider("vertical", width, depth, height, wallthick, bottomthick, dividerthick);
        }
    }    
}

module divider(orientation = "horizontal", width = 50, depth = 100, height = 20, wallthick = 4, bottomthick = 3, dividerthick = 2) {
    if (orientation == "horizontal") {
        rotate([0,0,90])
            cube([depth, dividerthick, height], true);

    }
    else if (orientation == "vertical") {
        cube([width, dividerthick, height], true);
    }
    else {
        cube(20, true);
    }
}



/*  Größen
depth           = 165;
width           = 115;
height          = 25;
roundsize       = 5;
wallthick       = 4;
bottomthick     = 3;
dividerthick    = 1;
*/

depth           = 115;
width           = 165;
height          = 35;
roundsize       = 5;
wallthick       = 4;
bottomthick     = 3;
dividerthick    = 1;
rows            = 2;
columns         = 3;


*cover(depth, width, height, roundsize, wallthick);

difference() {
    union() {
        box(depth, width, height, roundsize, wallthick, bottomthick);
        dividers(rows, columns, width, depth, height, wallthick, bottomthick, dividerthick);
    }
    *probeschnitt();
}
