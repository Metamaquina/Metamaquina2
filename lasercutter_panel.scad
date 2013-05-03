// Large Lasercutter Panel containing all parts for manufacturing the Metamaquina 2 desktop 3d printer
//
// (c) 2013 Felipe C. da S. Sanches <fsanches@metamaquina.com.br>
// Licensed under the terms of the GNU General Public License
// version 3 (or later).

use <Metamaquina2.scad>;
use <endstop.scad>;
use <lasercut_extruder.scad>;
use <belt-clamp.scad>;

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

    translate([242,0]){
      translate([205,222]){
        XEndIdler_back_face();

        translate([40,70])
        XEndMotor_back_face();
      }

      translate([216,153])
      XEndMotor_plain_face();

      translate([154,111])
      XEndMotor_belt_face();

      translate([256,143])
      rotate(180)
      XEndIdler_belt_face();

      translate([488,314])
      rotate(180)
      XEndIdler_plain_face();
    }
  }

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

      translate([25,-40])
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
    render() XCarriage_bottom_face();

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

    translate([275,20]){
      rotate(90) for (i=[-1,1]){
        translate([0,i*15]) RodEndTop_face();
        translate([60,i*15]) SecondaryRodEndTop_face();
      }
    }
  }

  translate([350,70]){
    translate([-64, 147])
    rotate(-90)
    render() YPlatform_face();

    translate([378,55])
    rotate(90){
      xend_bearing_sandwich_face();

      translate([42,0])
      xend_bearing_sandwich_face();
    }

    translate([350,160])
    rotate(90)
    XCarriage_sandwich_face();

    translate([75,120])
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
  }

  translate([650,100]){
    rotate(90)
    render() LCExtruder_panel();
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

  translate([105,10])
  idler_spacer_face();

  translate([122,10])
  idler_spacer_face();

  translate([55,74])
  handle_face();
}

lasercutter_panel();

