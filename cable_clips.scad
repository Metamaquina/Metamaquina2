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
include <render.h>;

module ring(r, R, start=0, end=360){
    N=200;
    for (i=[0:N])
    rotate(start + i*(end-start)/N)
    translate([R,0])
    circle(r=r, $fn=20);
}

module clip_2d(height, diameter, clip_thickness){
    r = clip_thickness/2;
    R = diameter/2+r;
    stick_length = 5;

    translate([0,height-R-r])
    {
        ring(r=r, R=R, start=-30, end=240);

        //stick
        hull(){
            rotate(-30)
            translate([R,0]){
                circle(r=r, $fn=20);

                rotate(60)
                translate([stick_length,0])
                circle(r=r, $fn=20);
            }
        }

        //tip
        rotate(-30)
        translate([R,0])
        rotate(60)
        translate([stick_length,0])
        circle(r=r*1.2, $fn=20);

        //details
        for (angle = [30, 180-30]){
            rotate(angle)
            translate([R+r,0])
            circle(r=r*1.2, $fn=20);
        }
    }
}

module base_2d(length, clip_thickness){
    hull(){
        for (i=[-1,1])
            translate([i*length/2, clip_thickness/2])
            circle(r=clip_thickness/2, $fn=20);
    }

    for (i=[-1,1])
        translate([i*length/2, 1.2*clip_thickness/2])
        circle(r=1.2*clip_thickness/2, $fn=20);
}

module base_3d(width, length, clip_thickness){
    translate([0,width/2])
    rotate([90,0])
    linear_extrude(height=width)
    base_2d(length=length, clip_thickness=clip_thickness);
}

module clip_3d(width, height, diameter, clip_thickness){
    translate([0,width/2])
    rotate([90,0])
    linear_extrude(height=width)
    clip_2d(height=height, diameter=diameter, clip_thickness=clip_thickness);
}

module cable_clip_model(D, H, L, W, W2, clip_thickness){
    base_3d(width=W, length=L, clip_thickness=clip_thickness);
    clip_3d(width=W2, height=H, diameter=D, clip_thickness=clip_thickness);
}

module hellerman_cable_clip_with_sticker(D, H, L, W, W2, sticker_thickness=1, clip_thickness){
    material("rubber")
    translate([-L/2, -W/2])
    cube([L, W, sticker_thickness]);

    material("nylon")
    translate([0,0,sticker_thickness])
    cable_clip_model(D=D, H=H, L=L, W=W, W2=W2, clip_thickness=clip_thickness);
}

module arrow(length, line_thickness=0.5, angle=30){
    lt = line_thickness;
    square([length,lt]);
    for (i=[-1:1])
        rotate(i*angle)
        square([length/4, lt]);
}

module clip_mount(L,W, line_thickness=0.5){
    lt = line_thickness;
    difference(){
        translate([-L/2, -W/2])
        square([L, W]);

        translate([-L/2 + lt, -W/2 + lt])
        square([L - 2*lt, W - 2*lt]);
    }

    translate([0.4*L, 0])
    rotate(180)
    arrow(length=0.4*L, line_thickness=lt);
}

module cable_clip_mount(type){
    if (type == "RA3") RA3_cable_clip_mount();
    if (type == "RA6") RA6_cable_clip_mount();
    if (type == "RA9") RA9_cable_clip_mount();
    if (type == "RA13") RA13_cable_clip_mount();
    if (type == "RA18") RA18_cable_clip_mount();
}

module cable_clip(type){
    if (type == "RA3") RA3_cable_clip();
    if (type == "RA6") RA6_cable_clip();
    if (type == "RA9") RA9_cable_clip();
    if (type == "RA13") RA13_cable_clip();
    if (type == "RA18") RA18_cable_clip();
}

//http://www.farnell.com/datasheets/1504045.pdf
module RA3_cable_clip_mount() clip_mount(L=13, W=13);
module RA3_cable_clip(){
  BillOfMaterials("Cable-clip Hellerman RA3", ref="RA3");
  hellerman_cable_clip_with_sticker(D=3, H=5, L=13, W=13, W2=5, clip_thickness=1);
}

module RA6_cable_clip_mount(){
  clip_mount(L=20.7, W=11.6);

  translate([-9,5])
  rotate(-90)
  scale(0.6)
  import("RA6.dxf");
}

module RA6_cable_clip(){
  BillOfMaterials("Cable-clip Hellerman RA6", ref="RA6");
  hellerman_cable_clip_with_sticker(D=6, L=20.7, H=9, W=11.6, W2=5, clip_thickness=1.5);
}

module RA9_cable_clip_mount() clip_mount(L=19, W=11.25);
module RA9_cable_clip(){
  BillOfMaterials("Cable-clip Hellerman RA9", ref="RA9");
  hellerman_cable_clip_with_sticker(D=9, H=12.5, L=19, W=11.25, W2=6.75, clip_thickness=1.5 /*todo*/);
}

module RA13_cable_clip_mount() clip_mount(L=23.3, W=24);
module RA13_cable_clip(){
  BillOfMaterials("Cable-clip Hellerman RA13", ref="RA13");
  hellerman_cable_clip_with_sticker(D=13, H=16.5, L=23.3, W=24, W2=9.5, clip_thickness=1.8 /*todo*/);
}

module RA18_cable_clip_mount() clip_mount(L=28.5, W=28.5);
module RA18_cable_clip(){
  BillOfMaterials("Cable-clip Hellerman RA18", ref="RA18");
  hellerman_cable_clip_with_sticker(D=18, L=28.5, H=23, W=28.5, W2=10, clip_thickness=1.8);
}

translate([0,0]) RA3_cable_clip();
translate([20,0]) RA6_cable_clip();
translate([43,0]) RA9_cable_clip();
translate([70,0]) RA13_cable_clip();
translate([103,0]) RA18_cable_clip();

