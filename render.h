// $fa is the minimum angle for a fragment. Even a huge circle does not have more fragments than 360 divided by this number. The default value is 12 (i.e. 30 fragments for a full circle). The minimum allowed value is 0.01.
$fa = 0.01;

// $fs is the minimum size of a fragment. Because of this variable very small circles have a smaller number of fragments than specified using $fa. The default value is 2. The minimum allowed value is 0.01.
$fs = 0.5;

//rendering configs:
render_lasercut=true;
render_pcb=true;
render_ABS=true;
render_PLA=true;
render_metal=true;
render_threaded_metal=true;
render_rubber=true;
render_peek=true;
render_nylon=true;
render_acrylic=true;

render_nozzle=true;
render_powersupply=true;
render_calibration_guide = false;
render_build_volume=false;
render_xplatform=true;
render_bolts = false; //work-in-progress
render_extruder = true;

