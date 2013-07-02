// 608zz bearing
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

include <BillOfMaterials.h>;
include <render.h>;

module 608zz_bearing(details=false){
  BillOfMaterials("608zz bearing", ref="608ZZ");

  if(details){
    608zz_bearing_detailed();
  } else {
    608zz_bearing_simple();
  }
}

module 608zz_bearing_simple(){
  material("metal"){
    linear_extrude(height=7)
    difference(){
      circle(r=22/2, $fn=40);
      circle(r=8/2, $fn=40);
    }
  }
}

module 608zz_bearing_detailed(){
  material("metal"){
    //inner disc
    linear_extrude(height=7)
    difference(){
      circle(r=11/2, $fn=40);
      circle(r=8/2, $fn=40);
    }

    //middle disc
    translate([0,0,0.5])
    linear_extrude(height=6)
    difference(){
      circle(r=18/2, $fn=40);
      circle(r=12/2, $fn=40);
    }

    //outer disc
    linear_extrude(height=7)
    difference(){
      circle(r=22/2, $fn=40);
      circle(r=19/2, $fn=40);
    }
  }
}
