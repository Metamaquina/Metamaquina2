
Metamaquina2
============

Metamaquina 2 - fully parametric 3D printer

![A photo of the Metamaquina 2 desktop 3d printer](http://metamaquina.com.br/site/wp-content/themes/ifeaturepro/includes/landing-page/img/header.jpg)

Manufacturing Instructions
==========================

This is a 3d printer project that is completely designed using the parametric CAD tools
 provided by OpenSCAD. In order to deal with this source code you'll need to install OpenSCAD,
following the instructions at: www.openscad.org

The main structure of the machine is built using lasercut MDF panels. The curves for lasercutting 
can be exported to DXF by rendering the lasercutter_6mm_MDF.scad file. Open it in OpenSCAD, press F6 (to compile) and then click Design->Export DXF. The resulting DXF file can be used to cut 6mm thick MDF sheets (or you can change the thickness in the source if you plan to work with some other materials but be sure to review the 3d model in this case since some parts of the design depend on 6mm thickness).

There is also a panel for lasercutting 2mm acrylic to cover the electronics PCB and a panel for lasercutting 5mm acrylic for the ZMAX/ZMIN endstop holders and a couple of 5mm spacers for the LCExtruder. There can be generated from the lasercutter_2m_acrylic.scad and lasercutter_5m_acrylic.scad, respectively. 

![Laser Cutter Panel #1](https://raw.github.com/Metamaquina/Metamaquina2/master/img/lasercutter_panel1.png)
![Laser Cutter Panel #2](https://raw.github.com/Metamaquina/Metamaquina2/master/img/lasercutter_panel2.png)
![Laser Cutter Panel #3](https://raw.github.com/Metamaquina/Metamaquina2/master/img/lasercutter_panel3.png)

The complete 3D model of the machine is described by the Metamaquina2.scad file. Open is in 
OpenSCAD and press F5 to render it.

![An OpenSCAD rendering of the Metamaquina 2 desktop 3d printer](https://raw.github.com/Metamaquina/Metamaquina2/master/img/MM2.png)

Hacking the code
================
Feel free to send us pull requests at https://github.com/Metamaquina/Metamaquina2
 if you make any change to this design that you consider worth sharing with us.

happy hacking,

Felipe Sanches

R&D director at Metamaquina.com.br


