// The Metamáquina logo and name are trademarks of
// Metamaquina Comercio de Kits Eletrônicos Ltda
// and cannot not be used without express written authorization.
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

module mm_logo(){
  translate([-10,-6])
  import("MM_logo_small.dxf");
}

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
