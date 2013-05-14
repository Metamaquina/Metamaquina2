compact=false;

module BillOfMaterials(partname, quantity=1, category=false){
  for (q =[1:quantity]){
    if (category && compact){
      echo(str("BOM: ", category));
    } else {
      if (category){
        echo(str("BOM: [", category, "] ", partname));
      } else {
        echo(str("BOM: ", partname));
      }
    }
  }
}

