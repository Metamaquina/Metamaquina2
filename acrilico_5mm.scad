use <endstop.scad>;
use <lasercut_extruder.scad>;

translate([30,20]){
  translate([40,0])
  idler_spacer_face();

  translate([0,45])
  zmin_endstop_spacer_face1();

  translate([0,10])
  zmin_endstop_spacer_face2();

  translate([5,45])
  zmax_endstop_spacer_face1();

  translate([5,10])
  zmax_endstop_spacer_face2();
}
