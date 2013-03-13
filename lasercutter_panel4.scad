// Lasercutter Panel #4 for manufacturing the Metamaquina 2 desktop 3d printer
//
// (c) 2013 Felipe C. da S. Sanches <fsanches@metamaquina.com.br>
// Lincensed under the terms of the GNU General Public License
// version 3 (or later).

use <RAMBo.scad>;

//This is intended to be lasercut in acrylic
module lasercutter_panel4(){
  %plate_border();

  RAMBo_cover_curves();

  translate([110,0])
  RAMBo_cover_curves(3);
}

lasercutter_panel4();

