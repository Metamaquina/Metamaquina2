/*Thickness of acrylic or plywood sheets to use. Be sure to use a value slightly larger than the nominal material thickness in order to be tolerant to variations on the material's actual thickness*/
thickness = 6 + 0.5; //6mm thick sheets

/*z motor placement in the original Prusa was on top. Our design uses the z motors in the bottom of the machine, but if you want them on top, you can set this variable to true. */
zmotors_on_top = false;

/* Desired build volume: */
BuildVolume_X=200;
BuildVolume_Y=200;
BuildVolume_Z=150;

//rendering configs:
preview_lasercut=true;
preview_pcb=true;
preview_ABS=true;
preview_PLA=true;
preview_metal=true;
preview_threaded_metal=true;
preview_rubber=true;
preview_nozzle=true;
preview_peek=true;
preview_powersupply=true;

render_calibration_guide = false;
render_build_volume=false;
render_xplatform=true;
render_bolts = false; //work-in-progress

//Colors
rubber_color = [0.1, 0.1, 0.1];
nozzle_color = "gold";
pcb_color = [1.0, 0.0, 0.0];
threaded_metal_color = [0.6, 0.6, 0.6];
metal_color = [0.7, 0.7, 0.7];
powersupply_color = metal_color;
PLA_color = [0.95, 0.35, 0.35];
ABS_color = [0.95, 0.95, 0.85];
//sheet_color = [0.95, 0.8, 0.65];
sheet_color = [0.9, 0.3, 0.3, 1];
peek_color = "beige";

