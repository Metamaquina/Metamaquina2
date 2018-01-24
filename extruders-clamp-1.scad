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

epsilon = 0.1;

include <bolts.h>
include <configuration.scad>
include <BillOfMaterials.h>;
include <render.h>
include <lm8uu_bearing.h>
include <nuts.h>;
use <Metamaquina2.scad>

module extrudersclamp(r1 = 12/2, r2 = 11/2, h = 6, largura_total = 84, comprimento_total = 23, pescoco = false, abertura = 3, separador = 1, distancia = 25){

  BillOfMaterials(category="Lasercut wood", partname="Extruders Clamp", ref="");

  material("lasercut"){
    translate([0,-0.5,h/2])
    difference(){

      union(){

        for (i=[-1,1]){

            //círculo maior para colocação dos parafusos 
            translate([i*distancia/2, 0, -h/2])
            cylinder(h = h, r = comprimento_total/2, $fn=80);

          hull(){

            //círculo menor - extremidades
            translate([i*35,0,-h/2])
            cylinder(h = h, r = m3_diameter*3/2, $fn=80);

            //círculo maior para colocação dos parafusos 
            translate([i*distancia/2, 0, -h/2])
            cylinder(h = h, r = comprimento_total/2, $fn=80);

            //junção meio
            translate([-distancia/2,-30/4,-h/2]) 
            cube([distancia,30/2,h]);
          }
        }
      }
      

      union(){
        for (i=[-1,1]){
          //
          translate([i*distancia/2,0,-4.5/2])
          if (pescoco){
            hull(){
              translate([0,0,0])
              cylinder(h = 0.1, r = r2, $fn=80);

              translate([0,0,4.5])
              cylinder(h = 0.1, r = r1, $fn=80);
            }
          } else {
            translate([0,0,-10])
            cylinder(h = 100, r = r2, $fn=80);
          }

          //define profundidade do sulco para encaixe do extrusor
          translate([i*distancia/2,0,4.5/2-0.1])
          cylinder(h = (h-4.5)/2+0.2, r = r2, $fn=80);

          //furo para encaixe dos extrusores
          translate([i*distancia/2,0,-(h-4.5)/2-4.5/2-0.1])
          cylinder(h = (h-4.5)/2+0.2, r = r2, $fn=80);

          //furo parafusos que prendem no carrinho
          translate([i*35,0,-h/2-1])
          cylinder(h = h+2, r = m3_diameter/2, $fn=80);   
        
        }
      }
    }
  }
}


thickness = 6;
XCarPosition = -100;
XMotor_height = 31;
PulleyRadius = 6;
X_rod_height = XMotor_height + PulleyRadius - lm8uu_diameter/2 - 2*thickness;
XCarriage_height = thickness + X_rod_height + lm8uu_diameter/2;

//descomente para ver no carrinho
/*
color("red") 
translate([XCarPosition, 0, XCarriage_height-2*thickness]){
extrudersclamp();
mirror([0,1,0]){extrudersclamp(pescoco=false);}
}
%XCarriage();
*/

//descomente para ver apenas a peça

extrudersclamp(pescoco=false);

translate([0,0,6])
extrudersclamp(pescoco=false);

//parafuro e porca lateral
/*
largura_total = 84;

for (i=[-1,1])
  translate([XCarPosition, 0, XCarriage_height-36])
  translate([i*18,-29/2, 6])
  rotate([0, i*90])

  translate([-largura_total/3.5*i,7,(thickness+6)/2])
  rotate([90,0]){
    M3x16();
    translate([0,0,-14])
    M3_nut();
*/





