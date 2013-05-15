# This file automatically generates a Bill of Materials for
# the Metamaquina 2 desktop 3d printer.
#
# (c) 2013 Metamáquina <http://www.metamaquina.com.br/>
#
# Author:
# * Felipe C. da S. Sanches <fsanches@metamaquina.com.br>
#
# This program is free software: you can redistribute it and/or modify
# it under the terms of the GNU General Public License as published by
# the Free Software Foundation, either version 3 of the License, or
# (at your option) any later version.
#
# This program is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU General Public License for more details.
#
# You should have received a copy of the GNU General Public License
# along with this program.  If not, see <http://www.gnu.org/licenses/>.

echo "Bill of Materials - Metamaquina 2"
openscad -o Metamaquina2.csg Metamaquina2.scad 2>&1 > /dev/null |grep BOM|cut -d: -f3|cut -d\" -f1|sort|uniq -c

COUNT=$(openscad -o Metamaquina2.csg Metamaquina2.scad 2>&1 > /dev/null |grep BOM|cut -d: -f3|cut -d\" -f1|wc -l)

echo "Metamaquina 2 is composed of" $COUNT "parts."
