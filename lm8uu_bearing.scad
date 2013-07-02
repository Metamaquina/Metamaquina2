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

include <lm8uu_bearing.h>;
include <render.h>;
include <BillOfMaterials.h>;

module LM8UU(bom=true){
  if (bom)
    BillOfMaterials("LM8UU linear bearing", ref="LM8UU");

  material("metal")
  translate([0,lm8uu_length/2])
  rotate([90,0])
  linear_extrude(height=lm8uu_length)
  difference(){
      circle(r=lm8uu_diameter/2);
      circle(r=lm8uu_internal_diameter/2);
  }
}

LM8UU();
