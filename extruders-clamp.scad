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

module extrudersclamp(r1 = 12/2, r2 = 16/2, h = 12, largura_total = 84, comprimento_total = 25, pescoco = true, abertura = 3, separador = 1){

  BillOfMaterials(category="3D Printed", partname="Extruders Clamp", ref="");

  material("ABS"){
    translate([0,0,h/2])
    difference(){

      union(){

        for (i=[-1,1]){
          hull(){
            //círculo menor - extremidades
            translate([i*33,0,-h/2])
            cylinder(h = h, r = m3_diameter*3/2, $fn=80);

            //círculo maior para colocação dos parafusos 
            translate([i*largura_total/10, 0, -h/2])
            cylinder(h = h, r = comprimento_total/2, $fn=80);
          }
        }
      }

      union(){
        for (i=[-1,1]){
          //
          translate([i*largura_total/10,0,-4.5/2])
          if (pescoco){
            hull(){
              translate([0,0,0])
              cylinder(h = 0.1, r = r2, $fn=80);

              translate([0,0,4.3])
              cylinder(h = 0.1, r = r1, $fn=80);
            }
          } else {

            cylinder(h = 4.5, r = r2, $fn=80);
          }

          //define profundidade do sulco para encaixe do extrusor
          translate([i*largura_total/10,0,4.5/2-0.2])
          cylinder(h = (h-4.5)/2+0.4, r = r2, $fn=80);

          //furo para encaixe dos extrusores
          translate([i*largura_total/10,0,-(h-4.5)/2-4.5/2-0.1])
          cylinder(h = (h-4.5)/2+0.2, r = r2, $fn=80);

          //furo parafusos que prendem os bicos
          translate([-largura_total/3.5*i,7, 0])
          rotate(180)
          rotate([90,0])
          cylinder(r=m3_diameter/2, h=largura_total, center=true);

          if(porca){

            //chanfro para a alocação das cabeças dos parafusos e das porcas
            translate([-largura_total/3.5*i,-55, 0])
            rotate([90,0])
            cylinder(r=3.8, h=100, $fn=6, center=true);

          } else {

            //chanfro para a alocação das cabeças dos parafusos e das porcas
            translate([-largura_total/3.5*i,-55, 0])
            rotate([90,0])
            cylinder(r=6.3/2, h=100, center=true);
          }

          //furo parafusos que prendem no carrinho
          translate([i*32,0,-h/2-1])
          cylinder(h = h+2, r = m4_diameter/2, $fn=80);   

          //divide ao meio
          translate([-largura_total/2,0,-h/2-1])
          cube([largura_total,comprimento_total/2,h+2]);         
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
  rotate([0,0,90]){
    extrudersclamp();
    mirror([0,1,0]){extrudersclamp(pescoco=true, porca=true);}
  }
}
%XCarriage();
*/

//descomente para ver apenas a peça

  translate([0,-0.5,0])
  extrudersclamp(pescoco=true, porca=false);

  translate([0,0.5,0])
  mirror([0,1,0])
  extrudersclamp(pescoco=true, porca=true);

//parafuro e porca lateral
/*
largura_total = 84;

for (i=[-1,1])
/*
  translate([XCarPosition, 0, XCarriage_height-36])
  rotate([0,0,90])
/*
  translate([0,0,-24])

  translate([i*18,-29/2, 6])
  rotate([0, i*90])

  translate([-largura_total/3.5*i,7,(thickness+6)/2])
  rotate([90,0]){
    M3x16();
    rotate(30,0,0)
    translate([0,0,-14])
    M3_nut();
}
*/
