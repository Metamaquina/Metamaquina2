// PTFE liner for 3d printer hotend (JHead)
// 2d/3d model
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

module PTFE_liner_2d_outline(dimensions=true){
  epsilon = 0.01;

  d1 = 6.33;
  d2 = 3.25;
  d4 = 3.0;
  d5a = 4.5;
  d5b = 3.0;

  l2 = 47;
  l1 = l2 - (d1-d2)/(2*tan(118/2));
  l3 = 47.5;
  l4 = l3 + 1;
  l5 = 2;

  angulo = 2*atan2((d2-d1)/2,l2-l1);
  echo(str("angulo = ",angulo," graus"));

  if (dimensions){
    dimension(0, 8, l2, 8, line_thickness=0.05, fontsize=0.8);
    dimension(0, 10, l1, 10, line_thickness=0.05, fontsize=0.8);

    translate([l5,0])
    dimension(-l5, 6, 0, 6, line_thickness=0.05, fontsize=0.8);

    translate([4,0])
    rotate(90){
      dimension(-d5a/2, 11, d5a/2, 11, line_thickness=0.05, fontsize=0.8);
      dimension(-d5b/2, 9, d5b/2, 9, line_thickness=0.05, fontsize=0.8);
    }

    translate([l1-1,0])
    rotate(-90)
    dimension(-d1/2, 8, d1/2, 8, line_thickness=0.05, fontsize=0.8);
  }

  difference(){
    //exterior outline
    hull(){
      translate([0,-d1/2])
      square([l1,d1]);

      translate([0,-d2/2])
      square([l2,d2]);
    }

    //interior outline
    translate([0,-d4/2])
    square([l3,d4]);

    //entrance interior bevel    
    hull(){
      translate([l5-epsilon,-d5b/2])
      square([epsilon,d5b]);

      translate([-epsilon,-d5a/2])
      square([epsilon,d5a]);
    }
  }
}

module PTFE_liner(){
  color("red")
  rotate_extrude($fn=50)
  rotate(90)
  PTFE_liner_2d_outline();
}

PTFE_liner_2d_outline();
//PTFE_liner();

