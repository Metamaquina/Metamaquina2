// Lasercutter Panel #2 for manufacturing the Metamaquina 2 desktop 3d printer
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
use <belt-clamp.scad>;

module lasercutter_panel2(){
  % plate_border();

  translate([410,350])
  for (i=[0:1])
    for (j=[0:1])
      translate([i*12,j*30])
      rotate(90)
      beltclamp_curves(width=28, r=5);

  translate([340,275])
  rotate([0,0,-90])
  MachineTopPanel_face();

  translate([395,155])
  rotate([0,0,90])
  MachineArcPanel_face();

  translate([190,230])
  rotate([0,0,90])
  MachineBottomPanel_face();

  translate([80,230]){
    rotate([0,0,90])
    XPlatform_bottom_face();

    translate([25,-40])
    rotate([0,0,90]){
      XEnd_front_face();//Motor

      translate([90,0])
      mirror([1,0]) XEnd_front_face();//Idler <-- this is mirrored so that the laser burnt side ends up turned to the same side (eighter exterior or interior) for both XEnds
    }
  }

  translate([400,160])
  rotate([0,0,90])
  YMotorHolder_face();

  translate([330,356])
  rotate([0,0,-90])
  render() XCarriage_bottom_face();

  translate([190,470]){
    for (i=[0:1]){
      translate([i*25,0]) RodEndBottom_face();
    }
  }

  translate([240,440]){
    for (i=[-1,1]){
      translate([0,i*15]) RodEndTop_face();
      translate([0,i*45]) SecondaryRodEndTop_face();
    }
  }

}

lasercutter_panel2();

