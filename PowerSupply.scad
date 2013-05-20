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

metal_sheet_thickness = 1;
bottom_offset = 11;
top_offset = 5;
pcb_thickness = 2;
pcb_height = 9 - pcb_thickness;
pcb_bottom_advance = 2;

module HiquaPowerSupply(){
  BillOfMaterials("Power Supply");

  {//TODO: Add this to the CAD model
    BillOfMaterials("Power Supply cable");
  }

  if (render_metal){
    color(metal_color){
      cube([PowerSupply_width, PowerSupply_height, metal_sheet_thickness]);

      translate([PowerSupply_width - metal_sheet_thickness, 0])
      cube([metal_sheet_thickness, PowerSupply_height, PowerSupply_thickness]);

      translate([0,bottom_offset])
      cube([PowerSupply_width, PowerSupply_height - bottom_offset - top_offset, PowerSupply_thickness]);
    }
  }

  if (render_pcb){
    color(pcb_color){
      translate([metal_sheet_thickness, -pcb_bottom_advance, pcb_height])
      cube([PowerSupply_width - 2*metal_sheet_thickness, PowerSupply_height - top_offset, pcb_thickness]);
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
