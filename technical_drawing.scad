// Helper modules for parametric technical drawing
//
// (c) 2013 Metamáquina <http://www.metamaquina.com.br/>
//
// Author:
// * Felipe C. da S. Sanches <fsanches@metamaquina.com.br>
//
// This program is free software: you can redistribute it and/or modify
// it under the terms of the GNU General Public License as published by
// the Free Software Foundation, either version 3 of the License, or
// (at your option) any later version.
//
// This program is distributed in the hope that it will be useful,
// but WITHOUT ANY WARRANTY; without even the implied warranty of
// MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
// GNU General Public License for more details.
//
// You should have received a copy of the GNU General Public License
// along with this program.  If not, see <http://www.gnu.org/licenses/>.

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

module RegularPolygon(N,r, even_odd=false){
  if (even_odd){
    for (i=[1:N/2])
      roundline(r*cos(2*i*360/N), r*sin(2*i*360/N),
                r*cos((2*i+1)*360/N), r*sin((2*i+1)*360/N));
  } else {
    for (i=[1:N])
      roundline(r*cos(i*360/N), r*sin(i*360/N),
                r*cos((i+1)*360/N), r*sin((i+1)*360/N));
  }
}

module Hexagon(r){
  RegularPolygon(6,r);
}

module Circle(r, even_odd=false){
  RegularPolygon(60,r, even_odd=even_odd);
}

module glyph(char, fontsize){
  scale(fontsize/12){
    import("font.dxf", layer=char);
  }
}

module dimension_label(x, y, string, spacing=0.7, fontsize=2){
//draw dimension text at coordinate x,y

  text_length = (len(string)+1) * spacing*fontsize;
  translate([x - text_length/2,y + fontsize/3]){
    for (i=[0:len(string)-1]){
      translate([spacing*fontsize*i,0]) glyph(string[i], fontsize);
    }

    translate([len(string)*spacing*fontsize, 0]) glyph("mm", fontsize);
  }
}

module arrow(x,y,angle, thickness=0.1){
  length = 10*thickness;
  width = 4*thickness;

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

module dimension(x1,y1, x2,y2, color="blue", line_thickness=1, fontsize=2){
  length = round(1000*sqrt((x2-x1)*(x2-x1)+(y2-y1)*(y2-y1)))/1000.0;
  angle = atan2(y2-y1, x2-x1);

  color(color){
    arrow(x1,y1, 0, thickness=line_thickness);
    roundline(x1,y1+1, x1,y1-6, thickness=line_thickness);

    arrow(x2,y2, -180, thickness=line_thickness);
    roundline(x2,y2+1, x2,y2-6, thickness=line_thickness);

    roundline(x1,y1, x2,y2, thickness=line_thickness);
    dimension_label((x1+x2)/2, (y1+y2)/2, str(length), fontsize=fontsize);
  }
}

