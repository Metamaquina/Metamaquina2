include <BillOfMaterials.h>;
include <bolts.h>;
include <render.h>;
include <colors.h>;

module M3x10(){
  bolt(3,10);  
}

module bolt_head(r, h){
  difference(){
    cylinder(r=r, h=h, $fn=60);
    translate([0,0,h/2]){
      cylinder(r=0.6*r, h=h, $fn=6);
    }
  }
}

module bolt(dia, length){
  BillOfMaterials(str("M",dia,"x",length," bolt"));

  if (render_metal)
  color(metal_color){
    bolt_head(r=dia, h=dia);
    translate([0,0,-length]){
      cylinder(r=dia/2, h=length, $fn=60);
    }
  }
}

