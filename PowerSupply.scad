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
include <PowerSupply.h>;
include <bolts.h>;
include <washers.h>;
include <render.h>;
include <colors.h>;

module HiquaPowerSupply_holes(){
  translate([5, 6])
  circle(r=5/2, $fn=20);

  translate([6, PowerSupply_height - 22])
  circle(r=5/2, $fn=20);

  translate([PowerSupply_width - 5, 5])
  circle(r=5/2, $fn=20);

  translate([PowerSupply_width - 12, PowerSupply_height - 21])
  circle(r=5/2, $fn=20);
}

module HiquaPowerSupply(){
  BillOfMaterials("Power Supply");

  {//TODO: Add this to the CAD model
    BillOfMaterials("Power Supply cable");
    BillOfMaterials("M3x10 bolt", 4);
    BillOfMaterials("M3 washer", 4);
  }

  if (render_metal){
    color(metal_color){
      cube([PowerSupply_thickness, PowerSupply_width, PowerSupply_height]);
    }
  }
}

