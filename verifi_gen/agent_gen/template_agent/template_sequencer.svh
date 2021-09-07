//
// Note:
// This file is generated by Mako Template
//-----------------------------------------
// ${agent_name} sequencer
//
`ifndef ${agent_name.upper()}_SEQUENCER_SVH
`define ${agent_name.upper()}_SEQUENCER_SVH
class ${agent_name}_sequencer extends uvm_sequencer #(${seq_name}_seq_item, ${seq_name}_seq_item);
  `uvm_component_utils(${agent_name}_sequencer)

  function new (string name = "${agent_name}_sequencer", uvm_component parent = null);
    super.new(name, parent);
  endfunction // new
  
endclass // ${agent_name}_sequencer
`endif //${agent_name.upper()}_SEQUENCER_SVH