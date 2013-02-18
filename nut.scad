// (c) 2013 Felipe C. da S. Sanches <fsanches@metamaquina.com.br>
// Lincensed under the terms of the GNU General Public License
// version 3 (or later).

module M8_nut(){
  nut(r=4, R = 7, H = 6);
}

function hipotenusa(a, b) = sqrt(a*a + b*b);

module nut(r, R, H){
  difference(){
    //hexagon
    intersection(){
      cylinder(r=2*R/sqrt(3), h=H, $fn=6);
      sphere(r=hipotenusa(R, H), $fn=60);
      translate([0,0,H])
      sphere(r=hipotenusa(R, H), $fn=60);
    }

    //hole
    translate([0,0,-1])
    cylinder(r=r, h=H+2);
  }
}
