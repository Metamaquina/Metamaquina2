// Lasercutter Panel #5 for manufacturing the Metamaquina 2 desktop 3d printer
//
// This plate constains the lasercut parts for our LCExtruder
//
// (c) 2013 Metamáquina <http://www.metamaquina.com.br/>
//
// Author:
// * Felipe C. da S. Sanches <fsanches@metamaquina.com.br>
//
// This program is free software: you can redistribute it and/or modify
// it under the terms of the GNU General Public License as published by
// the Free Software Foundation, either version 3 of the License, or
// (at your option) any later version.
//
// This program is distributed in the hope that it will be useful,
// but WITHOUT ANY WARRANTY; without even the implied warranty of
// MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
// GNU General Public License for more details.
//
// You should have received a copy of the GNU General Public License
// along with this program.  If not, see <http://www.gnu.org/licenses/>.

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

