$fn = 100;
minimal_mass_rohr = 149.2; //148.7 bei 30mm, 149.2 bei 15mm
maximal_mass_rohr = 149.5;
spalt_flies = 1.2;
ring_dicke = 3;
ring_hoehe = 15;  //Maximale Höhe 30mm

minimal_mass_ring = (minimal_mass_rohr / 2) + spalt_flies;
maximal_mass_ring = (maximal_mass_rohr / 2) + spalt_flies;

difference() {
    cylinder(h = ring_hoehe, r = maximal_mass_ring + ring_dicke);
    cylinder(ring_hoehe, minimal_mass_ring, maximal_mass_ring);
}
