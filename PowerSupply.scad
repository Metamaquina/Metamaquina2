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
include <PowerSupply.h>;
include <bolts.h>;
include <washers.h>;
include <render.h>;
include <colors.h>;

mount_positions = [[5, 6],
                  [6, PowerSupply_height - 22],
                  [PowerSupply_width - 5, 5],
                  [PowerSupply_width - 12, PowerSupply_height - 21]
];

module HiquaPowerSupply_holes(){
  for (p = mount_positions){
    translate(p)
    circle(r=5/2, $fn=20);
  }
}

module oldHiquaPowerSupply(){
  BillOfMaterials("Power Supply");

  {//TODO: Add this to the CAD model
    BillOfMaterials("Power Supply cable");
  }

  if (render_metal){
    color(metal_color){
      cube([PowerSupply_thickness, PowerSupply_width, PowerSupply_height]);
    }
  }
}

module HiquaPowerSupply(){
  BillOfMaterials("Power Supply");

  {//TODO: Add this to the CAD model
    BillOfMaterials("Power Supply cable");
  }

  if (render_metal){
    color(metal_color){
      cube([PowerSupply_width, PowerSupply_height, PowerSupply_thickness]);
    }
  }
}

module HiquaPowerSupply_subassembly(th=thickness){
  HiquaPowerSupply();
  for (p = mount_positions){
    translate([PowerSupply_width - p[0], p[1]]){
      translate([0, 0, -th - m3_washer_thickness]){
        M3_washer();

        rotate([180,0])
        M3x10();
      }
    }
  }
}

HiquaPowerSupply_subassembly();
