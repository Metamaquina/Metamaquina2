// Reimplementation of Brook Drum's lasercut extruder
//
// (c) 2013 Felipe C. da S. Sanches <fsanches@metamaquina.com.br>
// Lincensed under the terms of the GNU General Public License
// version 3 (or later).

thickness = 6;
moduleault_sheet_color = [0.9, 0.7, 0.45, 0.9];

module bolt_head(r, h){
  difference(){
    cylinder(r=r, h=h, $fn=60);
    translate([0,0,h/2]){
      cylinder(r=0.6*r, h=h, $fn=6);
    }
  }
}

module bolt(dia, length){
  color("silver"){
    bolt_head(r=dia, h=dia);
    translate([0,0,-length]){
      cylinder(r=dia/2, h=length, $fn=60);
    }
  }
}

module handle_face(){
  square([28,20]);
}

module handle_sheet(c=moduleault_sheet_color){
  color(c){
    linear_extrude(height=thickness){
      handle_face();
    }
  }
}

module sheet(name, height=0, c=moduleault_sheet_color){
  color(c)
  translate([0,0,height])
  linear_extrude(height=thickness)
  import("extruder-printrbot-layers.dxf", layer=name);
}

module handle(){
  nut_height = 3;
  handle_bolt_length = 70;

  union(){
    handle_sheet();
    sheet("handle");
    translate([9,5,handle_bolt_length - nut_height]){
      bolt(4, handle_bolt_length);
    }
    translate([20,5,handle_bolt_length - nut_height]){
      bolt(4, handle_bolt_length);
    }
  }
}

module idler(){
  rotate([90,0]){
    sheet("idler");
    sheet("idler",4*thickness);
    translate([9.5,35,-2.5]){
      rotate([0,-90,0]){
        sheet("idler2",thickness);
      }
    }
  }
}

module extruder_block(){
  rotate([90,0]){
    sheet("slice1");
    sheet("slice2", thickness);
    sheet("slice3", 2*thickness);
    sheet("slice4", 3*thickness);
    sheet("slice5", 4*thickness);
  }
}

//JHead MKIV nozzle
module nozzle(length=50){
  color([0.2,0.2,0.2]){
    translate([0,0,5])
    cylinder(r=8,h=5);

    cylinder(r=6,h=5);

    translate([0,0,-length+10])
    cylinder(r=8,h=length-10);
  }
}

module lasercut_extruder(){
  rotate(90)
  union(){
    translate([-37,2.5*thickness]){
      extruder_block();
      idler();
    }

    translate([7,14,58]){
      rotate([0,-90,0]){
        rotate([0,0,-90]){
          handle();
        }
      }
    }

    nozzle();
  }
}

lasercut_extruder();

