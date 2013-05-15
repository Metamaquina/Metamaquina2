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

//rendering configs:
render_lasercut=true;
render_pcb=true;
render_glass=true;
render_ABS=true;
render_PLA=true;
render_metal=true;
render_threaded_metal=true;
render_rubber=true;
render_peek=true;
render_nylon=true;
render_acrylic=true;

render_nozzle=true;
render_powersupply=true;
render_calibration_guide = false;
render_build_volume=false;
render_xplatform=true;
render_bolts = false; //work-in-progress
render_extruder = true;

