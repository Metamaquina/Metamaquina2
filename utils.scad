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

use <rounded_square.scad>;

//TODO: move these declarations to a header file
m25_diameter = 2.5;
m3_diameter=3;

module M3_hole(){
  circle(r=m3_diameter/2, $fn=20);
}

module M25_hole(){
  circle(r=m25_diameter/2, $fn=20);
}

module rounded_edge_cut(width=10, height=20, r=5, plain_left=false, plain_right=false){
    translate([-width/2,-height])
    rounded_square([width,height], corners=[r,r,0,0]);

    if (!plain_left)
    translate([-width/2-r,-r]){
        difference(){
            square([r,r]);
            circle(r=r);
        }
    }


    if (!plain_right)
    translate([width/2,-r]){
        difference(){
            square([r,r]);
            translate([r,0])
            circle(r=r);
        }
    }

}

module trapezoid(h, l1, l2, r=0, xoffset=0){
  hull(){
    translate([xoffset, h]) circle(r=r);
    translate([xoffset+l1,h]) circle(r=r);
    circle(r=r);
    translate([l2,0]) circle(r=r);
  }
}
