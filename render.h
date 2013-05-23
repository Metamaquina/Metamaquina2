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

// $fa is the minimum angle for a fragment. Even a huge circle does not have more fragments than 360 divided by this number. The default value is 12 (i.e. 30 fragments for a full circle). The minimum allowed value is 0.01.
$fa = 0.01;

// $fs is the minimum size of a fragment. Because of this variable very small circles have a smaller number of fragments than specified using $fa. The default value is 2. The minimum allowed value is 0.01.
$fs = 0.5;

dark_green = [0,0.2,0];
rubber_color = [0.1, 0.1, 0.1];
nozzle_color = "gold";
pcb_color = [1.0, 0.0, 0.0];
glass_color = [0.6, 0.6, 1, 0.4];
threaded_metal_color = [0.6, 0.6, 0.6];
metal_color = [0.7, 0.7, 0.7];
powersupply_color = metal_color;
PLA_color = [0.95, 0.35, 0.35];
ABS_color = [0.35, 0.35, 0.35];
sheet_color = [227/230, 190/230, 151/230];
peek_color = "beige";
dark_grey = [0.3, 0.3, 0.3];
green_plastic_color = [0.7,0.8,0,7];
black_plastic_color = [0.3,0.3,0.3];
nylon_color = [1, 1, 0.8];
acrylic_color = [1, 0.6, 0.6, 0.4];

render_materials = [
  "lasercut",
  "pcb",
  "glass",
  "ABS",
  "PLA",
  "metal",
  "threaded metal",
  "rubber",
  "peek",
  "nylon",
  "acrylic",
  "silk",
  "golden"];

module material(id){
  for (m=render_materials){
    if (id==m){
      if (id=="lasercut")
      for (i=[0:$children-1])
      color(sheet_color) child(i);

      if (id=="pcb")
      for (i=[0:$children-1])
      color(pcb_color) child(i);

      if (id=="glass")
      for (i=[0:$children-1])
      color(glass_color) child(i);

      if (id=="ABS")
      for (i=[0:$children-1])
      color(ABS_color) child(i);

      if (id=="PLA")
      for (i=[0:$children-1])
      color(PLA_color) child(i);

      if (id=="metal")
      for (i=[0:$children-1])
      color(metal_color) child(i);

      if (id=="threaded metal")
      for (i=[0:$children-1])
      color(threaded_metal_color) child(i);

      if (id=="rubber")
      for (i=[0:$children-1])
      color(rubber_color) child(i);

      if (id=="peek")
      for (i=[0:$children-1])
      color(peek_color) child(i);

      if (id=="nylon")
      for (i=[0:$children-1])
      color(nylon_color) child(i);

      if (id=="acrylic")
      for (i=[0:$children-1])
      color(acrylic_color) child(i);

      if (id=="silk")
      for (i=[0:$children-1])
      color("white") child(i);

      if (id=="golden")
      for (i=[0:$children-1])
      color("gold") child(i);
    }
  }
}

//subassembly rendering switches:
render_nozzle=true;
render_powersupply=true;
render_calibration_guide = false;
render_build_volume=false;
render_xplatform=true;
render_bolts = false; //work-in-progress
render_extruder = true;

