//This file came from the RepRap.org wiki

include <Metamaquina2.h>;
include <BillOfMaterials.h>;
include <render.h>;

module v4nozzle(){
  BillOfMaterials("JHead nozzle");

  {
    //TODO: Add these parts to the CAD model
    BillOfMaterials("extruder thermistor");
    BillOfMaterials("extruder heater resistance");
  }

  if (render_nozzle){
    material("golden"){
      scale(25.4)
      difference() {
        union() {
          // heater block
          cube(size = [0.630,0.550,0.325]);

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

        // heater resistor hole with guide
        translate([0.458,0.551,0.1625])
        rotate ([90,0,0]) cylinder (h=0.602, r = 0.117, center = false, $fn = 100);

        translate([0.458,0.501,0.1625-0.117])
        cube([0.117*2,0.117*2+1,0.117*2], center = true);

        // thermistor hole with guide
        translate([-0.001,0.480,0.1625])
        rotate ([90,0,90]) cylinder (h=0.170, r = 0.045, center = false, $fn = 100);

        translate([-0.001+0.170/2,0.480,0.1625-0.045*2])
        rotate ([90,0,90]) cube([0.045*2,0.170,0.170], center = true);


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
