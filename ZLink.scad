// z_threaded_bar_link (a.k.a. z-link)
//
// These are the plastic parts that link the XPlatform to the 
// Z-axis threaded bars.
//
// (c) 2013 Felipe C. da S. Sanches <fsanches@metamaquina.com.br>
// Lincensed under the terms of the GNU General Public License
// version 3 (or later).

//TODO: better names for these parameters
module z_threaded_bar_link (
    dx_z_threaded = 14,
    XPlatform_height = 45,
    thickness = 6,
    ZLink_rod_height = 11*sqrt(3)/2,
  	clearance = 0.2
  ){

  difference(){
    union(){
    linear_extrude(height=2.6){
	    difference(){
		    union(){
			    square([2*dx_z_threaded, 12], center=true);
			    translate([-dx_z_threaded, 0])
			    circle(r=6);
			    translate([dx_z_threaded, 0])
			    circle(r=6);
		    }
		    translate([-dx_z_threaded, 0])
		    circle(r=3/2, $fn=20);

		    translate([dx_z_threaded, 0])
		    circle(r=3/2, $fn=20);
	    }
    }
  		translate([-dx_z_threaded, 0, 2.6]) cylinder(r=5, h=2, $fn=6);
    	translate([dx_z_threaded, 0, 2.6]) cylinder(r=5, h=2, $fn=6);
    }

    translate([-dx_z_threaded, 0, 2]) cylinder(r=3, h=5, $fn=6);
    translate([dx_z_threaded, 0, 2]) cylinder(r=3, h=5, $fn=6);
  }

  translate([0,(XPlatform_height - thickness)/2, ZLink_rod_height])
  rotate([90, 0, 0]){
    linear_extrude(height=XPlatform_height - thickness)
    difference(){
	    circle($fn=6, r=11);
	    circle($fn=6, r=8);
    }

    translate([0,0,7]){
	    linear_extrude(height=4)
	    difference(){
		    circle($fn=6, r=10);
			hull(){
				for (i=[-1,1])
				translate([0,i*2.5])
			    circle($fn=20, r=(8+clearance)/2);
			}
	    }
    }
  }
}

z_threaded_bar_link();

