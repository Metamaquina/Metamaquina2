// (c) 2013 Metamáquina <http://www.metamaquina.com.br/>
//
// Authors:
// * Felipe C. da S. Sanches <fsanches@metamaquina.com.br>
// * Rafael H. de L. Moretti <moretti@metamaquina.com.br>
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

include <washers.h>;
include <BillOfMaterials.h>;
include <render.h>;

module M3_washer(){
  BillOfMaterials("M3 washer", ref="AL_M3");
  washer(washer_thickness = m3_washer_thickness,
         external_diameter = m3_washer_D,
         internal_diameter = m3_washer_d);
}

module M4_washer(){
  BillOfMaterials("M4 washer", ref="AL_M4");
  washer(washer_thickness = m4_washer_thickness,
         external_diameter = m4_washer_D,
         internal_diameter = m4_washer_d);
}

module M8_washer(){
  BillOfMaterials("M8 washer", ref="AL_M8");
  washer(washer_thickness = m8_washer_thickness,
         external_diameter = m8_washer_D,
         internal_diameter = m8_washer_d);
}

module M8_mudguard_washer(){
  BillOfMaterials("M8 mudguard washer", ref="AF_M8");
  washer(washer_thickness = m8_mudguard_washer_thickness,
         external_diameter = m8_mudguard_washer_D,
         internal_diameter = m8_mudguard_washer_d);
}

module M8_lock_washer(){
  BillOfMaterials("M8 lock washer", ref="AP_M8");
  //TODO: render
}

module washer(washer_thickness, external_diameter, internal_diameter){
  material("metal"){
    linear_extrude(height=washer_thickness)
    difference(){
      circle(r=external_diameter/2);
      circle(r=internal_diameter/2);
    }
  }
}

