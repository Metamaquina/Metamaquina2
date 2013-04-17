// Lasercutter Panel #5 for manufacturing the Metamaquina 2 desktop 3d printer
//
// This plate constains the lasercut parts for our LCExtruder
//
// (c) 2013 Felipe C. da S. Sanches <fsanches@metamaquina.com.br>
// Licensed under the terms of the GNU General Public License
// version 3 (or later).

use <lasercut_extruder.scad>;

module lasercutter_panel5(){
  %plate_border(w=520);

  translate([50,5])
  slice1_face();

  translate([109,20])
  slice2_face();

  translate([170,95])
  rotate(180)
  slice3_face();

  translate([175,5])
  slice4_face();

  translate([90,115])
  rotate(180)
  slice5_face();

  translate([10,100])
  rotate(180)
  idler_side_face();

  translate([148,37])
  idler_side_face();

  translate([22,20])
  idler_back_face();

  translate([105,10])
  idler_spacer_face();

  translate([122,10])
  idler_spacer_face();

  translate([55,74])
  handle_face();
}

lasercutter_panel5();

