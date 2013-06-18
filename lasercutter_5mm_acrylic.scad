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

include <endstop.h>;
use <lasercut_extruder.scad>;

translate([10,80])
idler_spacer_face();

translate([30,80])
idler_spacer_face();

translate([25,60])
zmin_endstop_spacer_face1();

translate([25,25])
zmin_endstop_spacer_face2();

translate([30,60])
zmax_endstop_spacer_face1();

translate([30,25])
zmax_endstop_spacer_face2();

