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

extruder_wiring_radius = 6;
YEndstopHolder_distance = 66;

//utils
use <utils.scad>;
use <mm2logo.scad>;
use <rounded_square.scad>;
use <tslot.scad>;
use <Metamaquina2.scad>
use <CalibrationRules-conf.scad>

FrontRule();
RearRule();
//RearAssembly();
//RearBars();
//FrontBars();
//LaserCutPanels();
//Metamaquina2();
