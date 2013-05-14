// z_threaded_bar_link (a.k.a. z-link)
//
// These are the plastic parts that link the XPlatform to the 
// Z-axis threaded bars.
//
// (c) 2013 Felipe C. da S. Sanches <fsanches@metamaquina.com.br>
// Licensed under the terms of the GNU General Public License
// version 3 (or later).

include <Metamaquina2.h>;
include <ZLink.h>;
include <BillOfMaterials.h>;

module ZLink(clearance = 0.2, hull_size=0){
  BillOfMaterials(category="3D Printed", partname="ZLink");

  if (render_ABS){
    color(ABS_color){
      difference(){
        union(){
          linear_extrude(height=2.6){
	          difference(){
		          hull(){
                for (i=[-1,1])
        			    translate([i*dx_z_threaded, 0])
        			    circle(r=6);
		          }
              for (i=[-1,1])
		            translate([i*dx_z_threaded, 0])
		            circle(r=m3_diameter/2, $fn=20);
	          }
          }
          for (i=[-1,1])
        		translate([i*dx_z_threaded, 0, 2.6]) cylinder(r=5, h=2, $fn=6);
        }

        for (i=[-1,1])
          translate([i*dx_z_threaded, 0, 2]) cylinder(r=3, h=5, $fn=6);
      }

      translate([0,Zlink_hole_height, ZLink_rod_height])
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
				    translate([0,i*hull_size/2])
			        circle($fn=20, r=(8+clearance)/2);
			    }
	        }
        }
      }
    }
  }
}

ZLink();

