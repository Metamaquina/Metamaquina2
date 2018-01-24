// Extruders clamp
// Used for joining 2 peeks
//
// Author:
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

include <extruders-clamp-1.scad>

for(i=[-1,1]){
  translate([0,i*(23/2+0.5)+0.5,0])
  extrudersclamp_face();
}
