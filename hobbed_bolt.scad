// Hobbed Bolt dimensions for a lasercut version of the GregsWade Extruder
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

use <technical_drawing.scad>;

MDF_thickness = 6;
bearing_thickness = 7; //based on 608zz_bearing.scad
M8_washer_thickness = 1.5; //based on washers.scad
wade_large_thickness = 2.5; //based on wade_big.stl (using projection(cut=true))
M8_nut_thickness = 6; //based on nuts.scad

bolt_diameter = 7.7; //The hobbed bolt diameter must not be any greater than 7.7 
         // otherwise it wont fit in the 608zz bearing.

//hobbing_position = 22; //3d printed wade block
hobbing_position = MDF_thickness*3/2 + bearing_thickness + 2*M8_washer_thickness + wade_large_thickness;

/* ideally these would be the lengths of the bolt:
screw_length = 2 * M8_washer_thickness + M8_nut_thickness;
bolt_length = hobbing_position + MDF_thickness*3/2 + bearing_thickness + screw_length;
hobbing_width = 16;
*/

// but these are the measures of the bolt we got from our supplier
screw_length = 24;
bolt_length = 50;
hobbing_width = 7.5;
hobbing_depth = 1;

echo(str("hobbing position: ", hobbing_position));
echo(str("bolt_length: ", bolt_length));
echo(str("screw_length: ", screw_length));
lt = 0.1;

module bolt_hex_head_frontal_view(D){
  //ISO standard for NON-STRUCTURAL hexagonal bolt head dimensions:
  e = 1.8 * D;
  s = 1.6 * D;

  translate([-15,0]){
    dimension(-s/2, 14, s/2, 14, line_thickness=lt);
    rotate([0,0,90])
    dimension(-e/2, 12, e/2, 12, line_thickness=lt);

    rotate([0,0,30])
    Hexagon(e/2);

    Circle(D/2, even_odd=true);
    dimension(-D/2, 10, D/2, 10, line_thickness=lt);

    Circle(e/2*sqrt(3)/2);
  }
}

module head(D){
  //ISO standard for NON-STRUCTURAL hexagonal bolt head dimensions:
  e = 1.8 * D;
  h = 0.7 * D;
//TODO: these rules are based on the info found at
//http://www.metrication.com/engineering/fastener.html
// We should double check it.

  Square(-h, -e/2, 0, e/2);
  Square(-h, -e/4, 0, e/4);

  dimension(-h,16,0,16, line_thickness=lt);
}

module body(diameter, length){
  Square(0, -diameter/2, hobbing_position - hobbing_width/2, diameter/2);
  Square(hobbing_position + hobbing_width/2, -diameter/2, length, diameter/2);
  dimension(0,-10, length,-10, line_thickness=lt);
}

module hobbing(position, diameter, length){
  N=6;
  dimension(0,11, position-length/2,11, line_thickness=lt);
  dimension(position-length/2, 12, position+length/2, 12, color="red", line_thickness=lt);

  translate([position,0]){
    for (i=[0:N])
    Square(-length/2, -(i/N)*diameter/2, length/2, (i/N)*diameter/2);
  }
}

module screw(diameter, length){
  N=10;
  spacing=3;
  dimension(bolt_length-length,11, bolt_length,11, line_thickness=lt);

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
module hobbed_bolt(){
  bolt_hex_head_frontal_view(bolt_diameter);

  head(bolt_diameter);
  body(diameter=bolt_diameter, length=bolt_length);
  hobbing(position=hobbing_position, diameter=bolt_diameter-2*hobbing_depth, length=hobbing_width);
  screw(diameter=bolt_diameter, length=screw_length);
}

hobbed_bolt();

