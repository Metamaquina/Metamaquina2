// Lasercutter Panel #3 for manufacturing the Metamaquina 2 desktop 3d printer
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

use <Metamaquina2.scad>;
use <endstop.scad>;

module lasercutter_panel3(){
  % plate_border();

  translate([130,150])
  YPlatform_face();

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

  translate([310,200])
  YEndstopHolder_face();

  translate([310,230])
  YEndstopHolder_face();

  translate([330,240])
  zmin_endstop_spacer_face1();

  translate([330,210])
  zmin_endstop_spacer_face2();

  translate([355,240])
  zmax_endstop_spacer_face1();

  translate([355,210])
  zmax_endstop_spacer_face2();

  translate([380,210])
  ymin_endstop_spacer_face();

  translate([380,240])
  ymax_endstop_spacer_face();
}

lasercutter_panel3();

