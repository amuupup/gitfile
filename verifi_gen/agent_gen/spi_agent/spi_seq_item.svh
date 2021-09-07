`ifndef SPI_SEQ_ITEM_SVH
`define SPI_SEQ_ITEM_SVH

class spi_seq_item extends uvm_sequence_item;
  randc bit [15:0] txdata;
  bit [15:0] rxdata;

  `uvm_object_utils_begin(spi_seq_item)
    `uvm_field_int(txdata, UVM_ALL_ON);
    `uvm_field_int(rxdata, UVM_ALL_ON);
  `uvm_object_utils_end
	
  function new(string name = "spi_seq_item");
    super.new(name);
  endfunction

endclass: spi_seq_item
`endif //SPI_SEQ_ITEM_SVH
