include <Metamaquina2.h>;
include <jhead.h>;
use <nozzle.scad>;

module J_head_assembly(){
  J_head();

  translate([-0.15625*25.4,-0.250*25.4,-50])
  v4nozzle();
}

module J_head(){
  if (render_peek){
    color(peek_color){
      translate([0,0,-50+4.76+4.64]){
        cylinder(h=50,r=6);
        cylinder(h=50-4.76-4.64,r=(5/8)*inch/2);
        translate([0,0,50-4.76])
        cylinder(h=4.64,r=(5/8)*inch/2);
      }
    }
  }
}

J_head_assembly();
