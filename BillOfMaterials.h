module BillOfMaterials(partname, quantity=1){
  for (q =[1:quantity])
    echo(str("BOM: ", partname));
}

