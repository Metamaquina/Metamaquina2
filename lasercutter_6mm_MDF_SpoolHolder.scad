// (c) 2013 Metamáquina <http://www.metamaquina.com.br/>
//
// Author:
// * Felipe C. da S. Sanches <fsanches@metamaquina.com.br>
// * Sara Rodriguez <sara@metamaquina.com.br>
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

//utils
use <rounded_square.scad>;
use <tslot.scad>;
include <render.h>;
include <BillOfMaterials.h>;
use <mm2logo.scad>;
use <domed_cap_nuts.scad>;
use <FilamentSpoolHolder.scad>


//measures copy of FilamentSpoolHolder.scad
thickness = 6;
margin = 10;

feet_height = 12;
feet_width = 50;
base_height = 80;

adjust=12;

total_width = 160+2*thickness+2*margin+adjust/2;

top_cut_height = 20;
top_cut_width = 9;

radius = 15;
rad=3/2;

spool_holder_width = 160+2*margin+2*thickness;
spool_holder_height = 40;

tslot_length = 16;
tslot_diameter = 3;

hole_domed_cap_nut=12.75;

bar_diameter=8;
bar_length= spool_holder_width+hole_domed_cap_nut*2;

total_height = 160/2+35/2-bar_diameter/2+top_cut_height+feet_height+top_cut_width/2;
radius_feet=5;

diameter=3;

//measures

distance=5;

module lasercutter_panel(){
  FilamentSpoolHolder_sidepanel_face();

  translate([0,-total_height,0])
  FilamentSpoolHolder_sidepanel_face();

  rotate([0,0,90])
  translate([0,(-base_height+total_width+spool_holder_height)/2+distance,0])
  FilamentSpoolHolder_front_and_back_panels_face();

  rotate([0,0,90])
  translate([0,(-base_height/2-(+total_width+spool_holder_height)/2-distance),0])
  FilamentSpoolHolder_front_and_back_panels_face();
}

lasercutter_panel();
