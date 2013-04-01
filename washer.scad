// (c) 2013 Felipe C. da S. Sanches <fsanches@metamaquina.com.br>
// Licensed under the terms of the GNU General Public License
// version 3 (or later).

module M3_washer(){
  //TODO
  washer(washer_thickness = 1.5, external_diameter = 16, internal_diameter = 8.5);
}

module M4_washer(){
  //TODO
  washer(washer_thickness = 1.5, external_diameter = 16, internal_diameter = 8.5);
}

module M8_washer(){
  washer(washer_thickness = 1.5, external_diameter = 18, internal_diameter = 8.5);
}

module M8_mudguard_washer(){
  washer(washer_thickness = 2, external_diameter = 32, internal_diameter = 8.5);
}

module washer(washer_thickness, external_diameter, internal_diameter){
  linear_extrude(height=washer_thickness)
  difference(){
    circle(r=external_diameter/2);
    circle(r=internal_diameter/2);
  }
}

