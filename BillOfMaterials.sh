openscad -o Metamaquina2.csg Metamaquina2.scad 2>&1 > /dev/null |grep BOM|sort|uniq -c
