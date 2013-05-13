openscad -o Metamaquina2.csg Metamaquina2.scad 2>&1 > /dev/null |grep BOM|cut -d: -f3|cut -d\" -f1|sort|uniq -c
