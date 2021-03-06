//
//Note:
//This file is generated by Mako Template
//${vsqr_name}
//
`ifndef ${vsqr_name.upper()}_SVH
`define ${vsqr_name.upper()}_SVH
class ${vsqr_name} extends uvm_sequencer;

  //add sequencer:
  ${reg_model_name} p_rm;
  %for i in seq_item:
  ${i}_sequencer p_${i}_sqr;
  %endfor
  %for i in interface:
  ${i}_if p_${i}_vif;
  %endfor

  function new(string name = "${vsqr_name}",uvm_component parent);
    super.new(name, parent);
  endfunction:new

  `uvm_component_utils(${vsqr_name})
 endclass: ${vsqr_name}
`endif //${vsqr_name.upper()}_SVH