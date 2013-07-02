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

include <Metamaquina2.h>;
include <BillOfMaterials.h>;
include <jhead.h>;
include <render.h>;
use <nozzle.scad>;

module J_head_assembly(){
  J_head_body();

  translate([-0.15625*25.4,-0.250*25.4,-50])
  v4nozzle();
}

module J_head_body(){
  BillOfMaterials("JHead machined body", ref="MM2_PEEK");

  {
    //TODO: Add this part to the CAD model
    BillOfMaterials("PTFE liner", ref="MM2_PTFE_liner");
  }

  material("peek"){
    translate([0,0,-50+4.76+4.64]){
      cylinder(h=50,r=6);
      cylinder(h=50-4.76-4.64,r=(5/8)*inch/2);
      translate([0,0,50-4.76])
      cylinder(h=4.64,r=(5/8)*inch/2);
    }
  }
}

J_head_assembly();
