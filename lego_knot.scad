// makes a 45-degree arc "lego knot" piece as described in http://archive.bridgesmathart.org/2014/bridges2014-261.html


inner_female_square_side = 25.4;
female_wall_thickness = 2;
male_wall_thickness = 2.2;

// the whole shape is made with a ring with a center cut out of it.
// the ring will ultimately have r of the desired female_square_side
// plus the center core radius
ring_radius = 45; // see paper
center_circle_radius = ring_radius - (inner_female_square_side + (2 * female_wall_thickness));
notch_width = inner_female_square_side/2;
inner_male_square_side = inner_female_square_side - (female_wall_thickness * 2);

rotate([90,-45,0])
union() {
difference() {
  // the main arc
  cylinder(d=ring_radius * 2, h = inner_female_square_side + (2 * female_wall_thickness));


  // the bits that remove all but a 45-degree arc
  rotate([0,0,135]) translate([-ring_radius,0,-1])
    cube([inner_female_square_side*4, inner_female_square_side*4,inner_female_square_side*4]);

  translate([0, -ring_radius, -1]) 
    cube([inner_female_square_side * 4, inner_female_square_side * 4, inner_female_square_side * 4]);

  translate([0,0,-1]) cylinder(d=center_circle_radius * 2, h = (inner_female_square_side * 3));
  
  // the "hollowing-out" square
  translate([0,0,female_wall_thickness])
  difference() {
    cylinder(d = (ring_radius - female_wall_thickness) * 2, h = inner_female_square_side);
   cylinder(d = (center_circle_radius + female_wall_thickness) * 2, h = inner_female_square_side);
  }
}6

// now the male end
translate([-female_wall_thickness, center_circle_radius + female_wall_thickness, female_wall_thickness])
  difference() {
  cube([male_wall_thickness*2, inner_female_square_side, inner_female_square_side]);

  translate([-1, female_wall_thickness, female_wall_thickness])
    cube([(male_wall_thickness + 1) * 2, inner_female_square_side - (female_wall_thickness * 2), inner_female_square_side - (male_wall_thickness * 2)]);

  // notches
  translate([(male_wall_thickness), (inner_male_square_side/2) - (notch_width/3), -1])
    cube([male_wall_thickness * 3, notch_width, inner_male_square_side * 2]);

  translate([male_wall_thickness, -1, (inner_male_square_side/2) - (notch_width/3)])
    cube([male_wall_thickness * 3, inner_male_square_side * 2, notch_width]);
}
}