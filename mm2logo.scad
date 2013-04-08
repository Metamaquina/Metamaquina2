module MM2_logo(){
  difference(){
    import("metamaquina-2.dxf");
    remove_original_letter_Q();
  }
  new_letter_Q(37); //Tony, mude o valor dessa linha. A sua tipografia original corresponde ao valor 29. Quanto maior este valor, menos frágil fica o corte a laser na madeira. 
}

line_thickness=3.1;
r=line_thickness/2;
length = 6;
N=120;
R=8.4;

module new_letter_Q(angle=29){
  start = angle;
  end = 360 - angle;

  translate([111.5,4.52]){

    hull(){
      for (j=[-1,1])
        translate([0,j*length/2])
        circle(r=r, $fn=50);
    }

    translate([0,8.4])
    for (i=[0:N])
      rotate(-90 + start + (i/N)*(end-start))
      translate([R,0])
      circle(r=r, $fn=50);
  }
}

module remove_original_letter_Q(){
  translate([111.5,4.52+8.4]){
    color("green"){
      circle(r=11);
      hull(){
        for (j=[-1,1])
          translate([0,-8.4+j*length/2])
          circle(r=3.3, $fn=50);
      }
    }
  }
}

MM2_logo();
