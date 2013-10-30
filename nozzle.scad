//This file came from the RepRap.org wiki

include <Metamaquina2.h>;
include <BillOfMaterials.h>;
include <render.h>;

module v4nozzle(){
  BillOfMaterials("J-Head 0.35mm nozzle", ref="035_NZ");

  {
    //TODO: Add these parts to the CAD model
    BillOfMaterials("extruder thermistor", ref="TV100000X");
    BillOfMaterials("extruder heater resistance", ref="UB5C-5RF1");
  }

  if (render_nozzle){
    material("golden"){
      scale(25.4)
      difference() {
        union() {
          // heater block
          cube(size = [0.500,0.500,0.325]);

          // threaded top end
          translate([0.15625,0.250,0.325])
          cylinder (h = 0.350, r = 0.15625, center = false, $fn = 100);
          translate([0.15625,0.250,0.675])
          cylinder (h = 0.150, r = 0.1275, center = false, $fn = 100);

          // bottom projection
          translate([0.15625,0.250,-0.050])
          cylinder (h = 0.050,r = 0.15625, center = false, $fn = 100);

          // nozzle profile
          translate([0.15626,0.250,-0.120])
          cylinder (h = 0.070, r1 = 0.025, r2 = 0.15625, center = false, $fn = 100);
        }

        // heater resistor hole
        translate([0.358,0.501,0.1625])
        rotate ([90,0,0]) cylinder (h=0.502, r = 0.117, center = false, $fn = 100);

        // thermistor hole
        translate([-0.001,0.430,0.1625])
        rotate ([90,0,90]) cylinder (h=0.170, r = 0.045, center = false, $fn = 100);



        // melt chamber
        translate([0.15625,0.250,-0.029])
        cylinder (h = 0.855, r = 0.069, center = false, $fn = 100);

        // orifice
        translate([0.15625,0.250,-0.120])
        cylinder (h = 0.100, r = 0.010, center = false, $fn = 100);

        // internal nozzle profile
        translate([0.15625,0.250,-0.100])
        cylinder (h = 0.070, r1 = 0.010, r2 = 0.069,center = false, $fn = 100);
      }
    }
  }
}

v4nozzle();
