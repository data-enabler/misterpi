$fn = 100;

button_diameter = 6.6;
hole_diameter = 6.3;
surface_to_button = 7.55;
button_travel = 7.9 - surface_to_button;
button_height = 2.15; // measured to the nubs next to the button
plexi_thickness = 2.7;


d1 = hole_diameter - 0.3;
d2 = button_diameter + 1.5;
tolerance = 0.1;
inf = 1000;

module plunger() {
  cylinder(h = surface_to_button + button_travel, d = d1);
  translate([0, 0, surface_to_button - plexi_thickness]) cylinder(
    h = (hole_diameter - d1)/2,
    d1 = hole_diameter,
    d2 = d1
  );
  transition_height = (d2 - hole_diameter)/2;
  max_diameter_z = surface_to_button - plexi_thickness - transition_height;
  translate([0, 0, max_diameter_z]) cylinder(
    h = transition_height,
    d1 = d2,
    d2 = hole_diameter
  );
  difference() {
    ring_height = button_height - button_travel;
    translate([0, 0, -ring_height]) cylinder(h = max_diameter_z + ring_height, d = d2);
    mirror([0, 0, 1]) cylinder(h = inf, d = button_diameter + tolerance*2);
  }
}

mirror([0, 0, 1]) plunger();
