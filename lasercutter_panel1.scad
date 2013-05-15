// Lasercutter Panel #1 for manufacturing the Metamaquina 2 desktop 3d printer
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

module lasercutter_panel1(){
  %plate_border(w=520);

  translate([10,10])
  render() MachineLeftPanel_face();

  translate([510,470])
  rotate([0,0,180])
  MachineRightPanel_face();

  translate([280,335])
  set_of_M3_spacers(h=3, w=7);

  translate([450,5])
  set_of_M3_spacers(h=10, w=2);

  translate([24,0]){
    translate([145,165])
    set_of_M3_spacers(h=2, w=6);

    translate([240,200])
    XEndIdler_back_face();

    translate([280,200+70])
    XEndMotor_back_face();

    translate([155,110])
    XEndMotor_belt_face();

    translate([195,270])
    rotate([0,0,90])
    XEndMotor_plain_face();

    translate([187,205])
    rotate([0,0,90])
    XEndIdler_belt_face();

    translate([270,157])
    XEndIdler_plain_face();
  }
}

lasercutter_panel1();

