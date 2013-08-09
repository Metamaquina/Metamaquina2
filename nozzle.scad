//This file came from the RepRap.org wiki

include <Metamaquina2.h>;
include <BillOfMaterials.h>;
include <render.h>;

module nozzle(){
  BillOfMaterials("JHead nozzle");

  if (render_nozzle){
    material("golden"){
      //scale(10)
      difference() {
        union() {

          // outside threaded top heater
          cylinder (h = 8.27, r = 7.87/2, center = false, $fn = 100);

          // threaded top end
          translate([0,0,8.27])
          cylinder (h = 14.44+2.94, r = 9.39/2, center = false, $fn = 100);

          // threaded bottom projection
          translate([0,0,-1.62])
          cylinder (h = 1.62,r = 7.87/2, center = false, $fn = 100);

          // nozzle profile
          translate([0,0,-1.62-2.4])
          cylinder (h = 2.4, r1 = 2.35, r2 = 7.87/2, center = false, $fn = 100);
        }

        // melt chamber
        translate([0,0,8.27+2.94])
        cylinder (h = 14.55, r = 6.15/2, center = false, $fn = 100);

        // orifice
        translate([0,0,-1.62-2.4-2])
        cylinder (h = 5, r = 0.69/2, center = false, $fn = 100);

        // internal nozzle profile
        translate([0,0,-1.62])
        cylinder (h = 14.44+1.62, r = 3/2, center = false, $fn = 100);

        translate([0,0,-8.27/2])
        cylinder (h = 2.4, r1 = 0.69/2, r2 = 3/2, center = false, $fn = 100);

        translate([0,0,-1.62])
        cylinder (h = 14.44+1.62, r = 3/2, center = false, $fn = 100);
      }
    }
  }
}

module heater_block(){
  BillOfMaterials("JHead nozzle");//Heater Block

  {
    //TODO: Add these parts to the CAD model
    BillOfMaterials("extruder thermistor");
    BillOfMaterials("extruder heater resistance");
  }

  if (render_nozzle){
    material("golden"){
      //scale(10)
      difference(){
        // heater block threaded inside
        translate([-19/2,-9.39/2,0])       
        cube(size = [19,15.88,8.27], $fn = 100);

        union(){
        // heater resistor hole
        translate([-19/2-0.5,-9.39/2+15.88-5.5/2-1.07,8.27/2]) 
        rotate ([0,90,0]) cylinder (h=20, r = 6/2, center = false, $fn = 100);

        // threaded hole to fast the heater resistor
        translate([-13/2+12.76/2,-9.39/2+15.88-5.5/2-1.07,-2]) 
        rotate ([0,0,0]) cylinder (h=5, r = 1.5/2, center = false, $fn = 100);//usar isto aqui

        // thermistor hole
        translate([-12.76/2+1.55/2+1.15,-9.39/2+3,8.27/2]) 
        rotate ([90,0,0]) cylinder (h=3.1, r = 1.55/2, center = false, $fn = 100);

        // threaded nozzle
        translate([0,0,-0.1])
        cylinder (h = 9, r = 7.87/2, center = false, $fn = 100);
        }
      }
    }
  }
}

module v4nozzle(){
  rotate([0,0,270]){
    //translate([-19/2,9.39/2,0]){
      nozzle();
      heater_block();
    //}
  }
}

v4nozzle();
