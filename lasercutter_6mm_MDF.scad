// Large Lasercutter Panel containing all parts for manufacturing the Metamaquina 2 desktop 3d printer
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

include <Metamaquina2.h>;
use <endstop.scad>;
use <lasercut_extruder.scad>;
use <belt-clamp.scad>;
include <spacer.h>;
use <PowerSupply.scad>;

module lasercutter_panel(){
  % plate_border(w=2500, h=1300, border=2);

  translate([10,0]){
    translate([0,10])
    MachineRightPanel_face();

    translate([902,10])
    mirror([1,0]) //this is mirrored to place the etchings in the right side of the sheet
    render() MachineLeftPanel_face();

    translate([1215,88])
    set_of_M3_spacers(h=6, w=11);

    translate([207,195]){
      XEndIdler_back_face();

      translate([40,70])
      XEndMotor_back_face();
    }

    translate([236,153])
    XEndMotor_plain_face();

    translate([444,341])
    XEndMotor_belt_face();

    translate([276,143])
    rotate(180)
    XEndIdler_belt_face();

    translate([730,314])
    rotate(180)
    XEndIdler_plain_face();
  }

#  for (i=[0:1])
    translate([1280+i*18,238])
    rotate(90)
    beltclamp_curves(width=28, r=5, for_y_platform=true);

  translate([908,0]){
    translate([405,170])
    for (i=[0:1])
      translate([i*18,0])
      rotate(90)
      beltclamp_curves(width=28, r=5, for_y_platform=true);

    translate([372,170]){
      rotate(90)
      beltclamp_curves(width=28, r=5, for_x_carriage=true);

      translate([12,0])
      rotate(90)
      mirror([0,1])
      beltclamp_curves(width=28, r=5, for_x_carriage=true);
    }

    translate([338,230])
    mirror([0,1])
    rotate([0,0,-90])
    MachineTopPanel_face();

    translate([393,340])
    rotate([0,0,90])
    MachineArcPanel_face();

    translate([185,230])
    rotate(90)
    mirror([1,0]) //mirroring to make laser etching in the correct side of the panel
    MachineBottomPanel_face();

    translate([80,230]){
      rotate([0,0,90])
      XPlatform_bottom_face();

      translate([30,-40])
      rotate([0,0,90]){
        XEnd_front_face();//Motor

        translate([90,0])
        mirror([1,0]) XEnd_front_face();//Idler <-- this is mirrored so that the laser burnt side ends up turned to the same side (eighter exterior or interior) for both XEnds
      }
    }
    
    translate([10,330])
    rotate(180)
    mirror([0,1])
    YMotorHolder_face();

    translate([352,310])
    rotate(-90)
    render()
    mirror([1,0]) //we want the burnt side up because it's cool!
    XCarriage_bottom_face();

    translate([335,170]){
      for (i=[0:1]){
        translate([i*20,0]) RodEndBottom_face();
      }
    }

    translate([415,205]){
    rotate(90)
      for (i=[0:1]){
        translate([i*30,0])
         rotate(45)
         top_wiring_hole_aux(r=6);
      }
    }

    translate([275,15]){
      rotate(90) for (i=[-1,1]){
        translate([0,i*15]) RodEndTop_face();
        translate([60,i*15]) SecondaryRodEndTop_face();
      }
    }
  }

  translate([350,70]){
    translate([70, 147])
    rotate(90)
    render() YPlatform_face();

    translate([370,85])
    rotate(90) xend_bearing_sandwich_face();

    translate([228,292])
    rotate(90)
    xend_bearing_sandwich_face();

    translate([350,160])
    rotate(90)
    XCarriage_sandwich_face();

    translate([-150,80])
    rotate(90)
    YPlatform_left_sandwich_face();

    translate([8,283])
    rotate(90)
    YPlatform_right_sandwich_face();

    translate([320,210]){
      YEndstopHolder_face();

      translate([0,28])
      YEndstopHolder_face();
    }

    translate([480,-135]){
      translate([365,210])
      ymin_endstop_spacer_face();

      translate([335,210])
      ymin_endstop_spacer_face();

      translate([365,245])
      ymax_endstop_spacer_face();

      translate([335,245])
      ymax_endstop_spacer_face();
    }
  }

  translate([650,100]){
    rotate(90)
    render() LCExtruder_panel();
  }

#  translate([20,380])
  PowerSupplyBox_side_face();
#  translate([210,380])
  PowerSupplyBox_front_face();
#  translate([130,380])
  rotate(90)
  mirror([0,1]) //we want to keep the burnt side visible because it looks good!
  PowerSupplyBox_back_face();

  if (batch_run==false){
    #translate([265,385])
    PowerSupplyBox_bottom_face();
  }
}


module LCExtruder_panel(){
  translate([50,5])
  slice1_face();

  translate([109,20])
  slice2_face();

  translate([170,100])
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

  translate([55,74])
  handle_face();
}

lasercutter_panel();

