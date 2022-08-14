mdick=1;
schale_tiefe    = 30;
schale_breite   = 15;
schale_hoehe    = 20;

radio_tiefe     = 40;
radio_breite    = 100;
radio_hoehe     = 187;

steg_tiefe      = 5;
steg_breite     = 10;
steg_hoehe      = 150;

glasdicke       = 10;
haken_hoehe     = 10;


module schale() {
    difference() {
        cube([schale_breite + 1 * mdick,
              schale_tiefe + 2 * mdick,
              schale_hoehe + 1 * mdick], true);
        translate([mdick * 1.5, 0, mdick * 1.0])
            cube([schale_breite + 2 * mdick, schale_tiefe, schale_hoehe], true);
    }
}

module steg() {
    union() {
        cube([steg_breite, steg_tiefe, steg_hoehe],true);
        translate([0, steg_tiefe / 2  + glasdicke / 2, steg_hoehe / 2 - steg_tiefe / 2])
            cube([steg_breite, glasdicke, steg_tiefe],true);
        translate([0, steg_tiefe + glasdicke, steg_hoehe / 2 - haken_hoehe/2])
            cube([steg_breite, steg_tiefe, haken_hoehe],true);
    }
}


module halterseite() {
    schale();
    translate([-(schale_breite/2 - steg_breite / 2 + mdick / 2),
                schale_tiefe/2 + mdick * 0.75,
                steg_hoehe/2 - schale_hoehe / 2 - mdick / 2])
        steg();
}
module haltestreifen() {
    cube([radio_breite + 2 * mdick - (2 * steg_breite) + 2,
          steg_breite,
          mdick], true);
}

translate([-(radio_breite / 2 - schale_breite / 2 + mdick / 2),0,0]) halterseite();
translate([+(radio_breite / 2 - schale_breite / 2 + mdick / 2),0,0]) mirror([1,0,0]) halterseite();
rotate([0,90,0]) haltestreifen();


*translate([0,0,0]) cube([radio_breite, radio_tiefe, radio_hoehe], true);
