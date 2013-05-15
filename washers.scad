// (c) 2013 Felipe C. da S. Sanches <fsanches@metamaquina.com.br>
// (c) 2013 Rafael H. de L. Moretti <moretti@metamaquina.com.br>
// Licensed under the terms of the GNU General Public License
// version 3 (or later).

include <washers.h>;
include <BillOfMaterials.h>;
include <render.h>;
include <colors.h>;

module M3_washer(){
  BillOfMaterials("M3 washer");
  washer(washer_thickness = m3_washer_thickness,
         external_diameter = m3_washer_D,
         internal_diameter = m3_washer_d);
}

module M4_washer(){
  BillOfMaterials("M4 washer");
  washer(washer_thickness = m4_washer_thickness,
         external_diameter = m4_washer_D,
         internal_diameter = m4_washer_d);
}

module M8_washer(){
  BillOfMaterials("M8 washer");
  washer(washer_thickness = m8_washer_thickness,
         external_diameter = m8_washer_D,
         internal_diameter = m8_washer_d);
}

module M8_mudguard_washer(){
  BillOfMaterials("M8 mudguard washer");
  washer(washer_thickness = m8_mudguard_washer_thickness,
         external_diameter = m8_mudguard_washer_D,
         internal_diameter = m8_mudguard_washer_d);
}

module washer(washer_thickness, external_diameter, internal_diameter){
  if (render_metal){
    color(metal_color){
      linear_extrude(height=washer_thickness)
      difference(){
        circle(r=external_diameter/2);
        circle(r=internal_diameter/2);
      }
    }
  }
}

