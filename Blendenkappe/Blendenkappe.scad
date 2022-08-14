$fn = 50;

durchmesser_gross = 76.5;
durchmesser_klein = 32.4;
einfall = 1;
durchmesserextender = 0.5;

hoehe       = 10;
wandstaerke = 2;

durchmesser = durchmesser_klein + durchmesserextender;
radius = durchmesser / 2;

union() {
    difference() {     
        cylinder(h = hoehe, r2 = radius + wandstaerke, r1 = radius + wandstaerke, center = true);
        cylinder(h = hoehe, r2 = radius, r1 = radius - einfall, center = true);
    }
    translate([0, 0, -((hoehe + wandstaerke)/2)] )
        cylinder(h = wandstaerke, r = radius + wandstaerke, center = true);
}