// Lasercutter Panel #3 for manufacturing the Metamaquina 2 desktop 3d printer
//
// (c) 2013 Felipe C. da S. Sanches <fsanches@metamaquina.com.br>
// Lincensed under the terms of the GNU General Public License
// version 3 (or later).

use <Metamaquina2.scad>;

module lasercutter_panel3(){
  % plate_border();

  translate([130,150])
  YPlatform_sheet_curves();

  translate([270,30])
  xend_bearing_sandwich_face();

  translate([320,30])
  xend_bearing_sandwich_face();

  translate([290,145])
  XCarriage_sandwich_face();

  translate([270,220])
  YPlatform_left_sandwich_face();

  translate([370,80])
  YPlatform_right_sandwich_face();
}

lasercutter_panel3();

