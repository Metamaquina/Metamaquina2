// (c) 2013 Metamáquina <http://www.metamaquina.com.br/>
//
// Authors:
// * Felipe C. da S. Sanches <fsanches@metamaquina.com.br>
// * Rodrigo Rodrigues da Silva <rsilva@metamaquina.com.br>
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

module BillOfMaterials(partname="", quantity=1, category=false, ref=false){
  if (len (str(partname)) || len(ref)){
    for (q = [1:quantity]){
      if (ref && category)
        echo (str("BOM: ", "[", ref, "] ",  "{", category,"} ", partname));
      else if (ref)
        echo (str("BOM: ", "[", ref, "] ", partname));
      else if (category)
        echo(str("BOM: ", "{", category,"} ", partname));
      else
        echo (str("BOM: ", partname));
    }
  }
}

//TEST

module test_BillOfMaterials(){
  BillOfMaterials("TEST Simple part");
  BillOfMaterials("TEST Part with quantity 3", 3);
  BillOfMaterials("TEST Part with ref and category", 1, "The Cool Parts' Category", "COOLPART");
  BillOfMaterials("TEST Part with category only", 2, "The Cool Parts' Category");
  BillOfMaterials("TEST Another part no category", ref = "REFFOO", quantity = 2);
  BillOfMaterials(ref="H_M4x70", quantity=12);

  //no output
  BillOfMaterials(quantity=3);
  BillOfMaterials("");
  BillOfMaterials(category="foo");
  BillOfMaterials(partname="", ref="", quantity=20);
}

//test_BillOfMaterials();
