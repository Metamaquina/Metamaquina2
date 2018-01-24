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

//utils
use <CalibrationZBars.scad>;

RodEndTop_face();

translate([30,28.5,0])
RodEndBottom_face();

translate([-70,-170,0])
rotate([0,180,-90])
MachineRightPanel_face();

translate([-60,10,0])
MachineTopPanel_face();

translate([-60,-55,0])
MachineBottomPanel_face();
