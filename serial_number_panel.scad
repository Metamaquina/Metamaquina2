//A lasercutter plate for a batch_run with serial number strings

include <Metamaquina2.h>;
include <PowerSupply.h>;

module serial_number_plate(){
  assign(revision_id = batch_run[0],
         batch_number = batch_run[1],
         first_id = batch_run[2],
         size_of_batch = batch_run[3]){
    for (i=[0:size_of_batch-1]){
      translate([7*(i%2), i*52])
      face_with_serial_number(revision_id, batch_number, first_id+i);
    }
  }
}

module glyph(char, fontsize){
  scale(fontsize/12){
    import("font.dxf", layer=char);
  }
}

module draw_number(value, digits, spacing=0.7, fontsize=7){
  string = str(value + pow(10,digits));
  text_length = (len(string)+1) * spacing*fontsize;
  translate([- text_length/2, fontsize/3]){
    for (i=[0:digits-1]){
      translate([spacing*fontsize*i,0])
        if (i+1<len(string))
          glyph(string[i+1], fontsize);
        else
          glyph("0", fontsize);
    }
  }
}

module face_with_serial_number(revision_id, batch_number, id){
  difference(){
    PowerSupplyBox_bottom_face();
    translate([30,15])
    import("serial_number_template.dxf");

    translate([45,13])
    draw_number(batch_number, 2);

    translate([64,13])
    draw_number(id, 4);
  }
}

serial_number_plate();
