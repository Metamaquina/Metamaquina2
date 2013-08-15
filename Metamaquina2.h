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

use <Metamaquina2.scad>;
include <render.h>;

/*Thickness of acrylic or plywood sheets to use.*/
thickness = 6; //millimiters
acrylic_thickness = 5;

/*This value is added to the thickness value when drawing cuts for connecting perpendicular sheets together*/
slot_extra_thickness = 0.5;

module TSlot_holes(width=50){
  t_slot_holes(width=width, thickness=thickness+slot_extra_thickness);
}

module TSlot_joints(width=50){
  t_slot_joints(width=width, thickness=thickness, joint_size=5);
}

/* Desired build volume: */
BuildVolume_X=200;
BuildVolume_Y=200;
BuildVolume_Z=150;

epsilon=0.1;
inch=25.4;
m25_diameter = 2.5;
m3_diameter = 3;
m4_diameter = 4;
m8_diameter = 8;

//-------------------------
//RepRap standards:

X_rods_distance = 50;
X_rods_diameter=8;
z_rod_z_bar_distance = 30;
Y_rods_distance = 140;

//-------------------------
extruder_mount_holes_distance = X_rods_distance + 14;

XPlatform_height = 45;

//[revision_id, batch_number, first_id, size_of_batch]
//batch_run = ["revA", 0, 31, 6];
//batch_run = ["revB", 1, 37, 10];
//batch_run = ["revB", 2, 47, 10];
//batch_run = ["revC", 3, 57, 10];
//batch_run = ["revC", 4, 67, 10];
batch_run = false;
