// Lasercutter Panel #2 for manufacturing the Metamaquina 2 desktop 3d printer
//
// (c) 2013 Felipe C. da S. Sanches <fsanches@metamaquina.com.br>
// Lincensed under the terms of the GNU General Public License
// version 3 (or later).

use <Metamaquina2.scad>;
use <belt-clamp.scad>;

module lasercutter_panel2(){
  % plate_border();

  translate([230,150])
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

  translate([370,350])
  rotate([0,0,90])
  render() XCarriage_bottom_face();

  translate([240,470]){
    for (i=[0:1]){
      translate([i*25,0]) RodEndBottom_face();
    }
  }

  translate([240,400]){
    for (i=[0:1]){
      translate([0,i*35]) RodEndTop_face();
    }
  }

}

lasercutter_panel2();

