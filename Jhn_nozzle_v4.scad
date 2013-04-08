

difference() {

union() {
    // heater block
    color ("gold") cube(size = [0.500,0.500,0.325]);

    // threaded top end
    translate([0.15625,0.250,0.325])
    color ("gold")
    cylinder (h = 0.350, r = 0.15625, center = false, $fn = 100);
    translate([0.15625,0.250,0.675])
    cylinder (h = 0.150, r = 0.1275, center = false, $fn = 100);

    // bottom projection
    translate([0.15625,0.250,-0.050])
    color ("gold")
    cylinder (h = 0.050,r = 0.15625, center = false, $fn = 100);

    // nozzle profile
    translate([0.15626,0.250,-0.120])
    color ("gold")
    cylinder (h = 0.070, r1 = 0.025, r2 = 0.15625, center = false, $fn = 100);
  }

// heater resistor hole
translate([0.358,0.501,0.1625])
color ("gold") rotate ([90,0,0]) cylinder (h=0.502, r = 0.117, center = false, $fn = 100);

// thermistor hole
translate([-0.001,0.430,0.1625])
color ("gold") rotate ([90,0,90]) cylinder (h=0.170, r = 0.045, center = false, $fn = 100);



// melt chamber
translate([0.15625,0.250,-0.029])
color ("gold") cylinder (h = 0.855, r = 0.069, center = false, $fn = 100);

// orifice
translate([0.15625,0.250,-0.120])
color ("gold") cylinder (h = 0.100, r = 0.010, center = false, $fn = 100);

// internal nozzle profile
translate([0.15625,0.250,-0.100])
color ("gold") cylinder (h = 0.070, r1 = 0.010, r2 = 0.069,center = false, $fn = 100);
}



