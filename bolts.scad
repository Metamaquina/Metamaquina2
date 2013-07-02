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
include <bolts.h>;
include <render.h>;

module M3x10(){
  bolt(3,10);
}

module M3x12(){
  bolt(3,12);
}

module M3x16(){
  bolt(3,16);
}

module M3x20(){
  bolt(3,20);
}

module M3x25(){
  bolt(3,25);
}

module M3x30(){
  bolt(3,30);
}

module M3x35(){
  bolt(3,35);
}

module bolt_head(r, h){
  difference(){
    cylinder(r=r, h=h, $fn=60);
    translate([0,0,h/2]){
      cylinder(r=0.6*r, h=h, $fn=6);
    }
  }
}

module bolt(dia, length){
  //TODO: assuming hexagonal/cylindric cap bolt
  BillOfMaterials(str("M",dia,"x",length," bolt"), ref=str("H_M",dia,"x",length));

  material("metal"){
    bolt_head(r=dia, h=dia);

    translate([0,0,-length])
    cylinder(r=dia/2, h=length, $fn=60);
  }
}

