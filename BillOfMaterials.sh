echo "Bill of Materials - Metamaquina 2"
openscad -o Metamaquina2.csg Metamaquina2.scad 2>&1 > /dev/null |grep BOM|cut -d: -f3|cut -d\" -f1|sort|uniq -c

COUNT=$(openscad -o Metamaquina2.csg Metamaquina2.scad 2>&1 > /dev/null |grep BOM|cut -d: -f3|cut -d\" -f1|wc -l)

echo "Metamaquina 2 is composed of" $COUNT "parts."
