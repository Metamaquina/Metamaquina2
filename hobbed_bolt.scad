// Hobbed Bolt dimensions for a lasercut version of the GregsWade Extruder
//
// (c) 2013 Felipe C. da S. Sanches <fsanches@metamaquina.com.br>
//
// Licensed under the terms of the GNU General Public License
// version 3 (or later).

MDF_thickness = 6;
bearing_thickness = 7; //based on 608zz_bearing.scad
M8_washer_thickness = 1.5; //based on washer.scad
wade_large_thickness = 6; //based on wade_big.stl (using projection(cut=true))
M8_nut_thickness = 6; //based on nut.scad

bolt_diameter = 8;
//hobbing_position = 22; //3d printed wade block
hobbing_position = MDF_thickness*3/2 + bearing_thickness + 2*M8_washer_thickness + wade_large_thickness;

hobbing_width = 16;
screw_length = 2 * M8_washer_thickness + M8_nut_thickness;
bolt_length = hobbing_position + MDF_thickness*3/2 + bearing_thickness + screw_length;

echo(str("hobbing position: ", hobbing_position));
echo(str("bolt_length: ", bolt_length));
echo(str("screw_length: ", screw_length));

module roundline(x1,y1,x2,y2, color="black", thickness=0.3){
  color(color){
    hull(){
      translate([x1,y1])
      circle(r=thickness/2, $fn=20);

      translate([x2,y2])
      circle(r=thickness/2, $fn=20);
    }
  }
}

module line(x1,y1,x2,y2, color="black", thickness=1){
  angle = atan2(y2-y1, x2-x1);
  length = sqrt((x2-x1)*(x2-x1) + (y2-y1)*(y2-y1));

  color(color){
    translate([x1,y1]){
      rotate([0,0,angle])
      translate([0,-thickness/2])
      square([length,thickness]);
    }
  }
}


module Square(x1,y1,x2,y2){
  roundline(x1,y1,x2,y1);
  roundline(x2,y1,x2,y2);
  roundline(x2,y2,x1,y2);
  roundline(x1,y2,x1,y1);
}

module arrow(x,y,angle,length=1, width=0.4, thickness=0.1){
  translate([x,y])
  rotate([0,0,angle])
  hull(){
    circle(r=thickness, $fn=20);

    translate([length, width/2])
    circle(r=thickness, $fn=20);

    translate([length, -width/2])
    circle(r=thickness, $fn=20);
  }
}

module head(h, w){
  Square(-h, -w/2, 0, w/2);
  Square(-h, -w/5, 0, w/5);
}

module body(diameter, length){
  Square(0, -diameter/2, length, diameter/2);
  cota(0,-10, length,-10);
}

module glyph(char, fontsize){
  scale(fontsize/12){
    import("font.dxf", layer=char);
  }
}

module dimension(x, y, string, spacing=0.7, fontsize=2){
//draw dimension text at coordinate x,y

  text_length = (len(string)+1) * spacing*fontsize;
  translate([x - text_length/2,y + fontsize/3]){
    for (i=[0:len(string)-1]){
      translate([spacing*fontsize*i,0]) glyph(string[i], fontsize);
      echo(string[i]);
    }

    translate([len(string)*spacing*fontsize, 0]) glyph("mm", fontsize);
  }
}

module cota(x1,y1, x2,y2, color="blue"){
  length = round(1000*sqrt((x2-x1)*(x2-x1)+(y2-y1)*(y2-y1)))/1000.0;
  angle = atan2(y2-y1, x2-x1);

  color(color){
    arrow(x1,y1, 0);
    roundline(x1,y1+1, x1,y1-6);

    arrow(x2,y2, -180);
    roundline(x2,y2+1, x2,y2-6);

    roundline(x1,y1, x2,y2);
    dimension((x1+x2)/2, (y1+y2)/2, str(length));
  }
}

module hobbing(position, diameter, length){
  N=6;
  cota(0,11, position,11);
  cota(position-length/2, 12, position+length/2, 12, color="red");

  translate([position,0]){
    for (i=[0:N])
    Square(-length/2, -(i/N)*diameter/2, length/2, (i/N)*diameter/2);
  }
}

module screw(diameter, length){
  N=10;
  spacing=3;
  cota(bolt_length-length,11, bolt_length,11);

  Square(bolt_length-length, -diameter/2, bolt_length, diameter/2);

color("black")
  translate([bolt_length-length, -diameter/2])
  intersection(){
    square([length, diameter]);
    for(i=[0:N]){
      line(i*spacing-diameter, -1, i*spacing, diameter+1);
    }
  }
}

module wade_large(){
  color("brown")
  projection(cut=true){
    rotate([0,-90])
    rotate([0,0,10])
    import("MM_wade-big.stl");
  }
}

module wade_large_3d(){
    rotate([0,-90])
    rotate([0,0,10])
    import("MM_wade-big.stl");
}

use <thingiverse_20413.scad>;
module wade_block_3d(){
  jhead_mount=256;
  wade(hotend_mount=jhead_mount, layer_thickness=0.25);
}

module wade_block_2d(){
  projection(cut=true)
  wade_block_3d();
}

wade_height = 6;
translate([wade_height,0]){
  wade_large();
//  %wade_large_3d();
}

//%wade_block_3d();

module parafuso_trator(){
  head(h=5, w=16);
  body(diameter=bolt_diameter, length=bolt_length);
  hobbing(position=hobbing_position, diameter=bolt_diameter, length=hobbing_width);
  screw(diameter=bolt_diameter, length=screw_length);
}

parafuso_trator();
