//
// Note:
// This file is generated by Mako Template
//-----------------------------------------
// ${agent_name} agent
//
`ifndef ${agent_name.upper()}_AGENT_SVH
`define ${agent_name.upper()}_AGENT_SVH
class ${agent_name}_agent extends uvm_agent;
  `uvm_component_utils(${agent_name}_agent)

  ${agent_name}_driver m_${agent_name}_driver;
  ${agent_name}_sequencer m_${agent_name}_sequencer;
  ${agent_name}_monitor m_${agent_name}_monitor;

  ${agent_name}_agent_cfg m_${agent_name}_agent_cfg;

  % for i in itf:
  virtual ${i}_if ${i}_vif;
  % endfor
    
  uvm_analysis_port #(${seq_name}_seq_item) ap;
  uvm_analysis_port #(${seq_name}_seq_item) ap_transfer;
  
  function new(string name = "${agent_name}_agent", uvm_component parent = null);
    super.new(name, parent);
  endfunction // new

  function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    if (!uvm_config_db #(${agent_name}_agent_cfg)::get(this, "", "m_${agent_name}_agent_cfg", m_${agent_name}_agent_cfg) )
      `uvm_fatal("CONFIG_LOAD", 
		 "Cannot get() configuration ${agent_name}_agent_config from uvm_config_db")

    % for i in itf:
    uvm_config_db #(virtual ${i}_if)::set(this, "m_${agent_name}_driver", "${i}_vif", m_${agent_name}_agent_cfg.${i}_vif);
    uvm_config_db #(virtual ${i}_if)::set(this, "m_${agent_name}_monitor", "${i}_vif", m_${agent_name}_agent_cfg.${i}_vif);
    % endfor
    
    if(m_${agent_name}_agent_cfg.ACTIVE)
    begin
	  m_${agent_name}_driver = ${agent_name}_driver::type_id::create("m_${agent_name}_driver", this);
	  m_${agent_name}_sequencer = ${agent_name}_sequencer::type_id::create("m_${agent_name}_sequencer", this);
	  m_${agent_name}_monitor = ${agent_name}_monitor::type_id::create("m_${agent_name}_monitor", this);
	  ap = new("ap", this);
	  ap_transfer = new("ap_transfer", this);
    end
  endfunction // build_phase

  function void connect_phase(uvm_phase phase);
    if(m_${agent_name}_agent_cfg.ACTIVE)
    begin
	  m_${agent_name}_driver.seq_item_port.connect(m_${agent_name}_sequencer.seq_item_export);
	  m_${agent_name}_monitor.ap.connect(ap);
	  m_${agent_name}_driver.ap.connect(ap_transfer);
    end
  endfunction // connect_phase
  
endclass // ${agent_name}_agent
`endif //${agent_name.upper()}_AGENT_SVH

