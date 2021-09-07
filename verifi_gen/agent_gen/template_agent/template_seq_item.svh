`ifndef ${agent_name.upper()}_SEQ_ITEM_SVH
`define ${agent_name.upper()}_SEQ_ITEM_SVH

class ${agent_name}_seq_item extends uvm_sequence_item;
  randc bit [15:0] txdata;
  bit [15:0] rxdata;

  `uvm_object_utils_begin(${agent_name}_seq_item)
    `uvm_field_int(txdata, UVM_ALL_ON);
    `uvm_field_int(rxdata, UVM_ALL_ON);
  `uvm_object_utils_end
	
  function new(string name = "${agent_name}_seq_item");
    super.new(name);
  endfunction

endclass: ${agent_name}_seq_item
`endif //${agent_name.upper()}_SEQ_ITEM_SVH
