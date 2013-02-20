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
}

lasercutter_panel3();

