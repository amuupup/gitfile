//
//Note:
//This file is generated by Mako Template
//${basic_test_name}
//
`ifndef ${basic_test_name.upper()}_SVH
`define ${basic_test_name.upper()}_SVH
class ${basic_test_name} extends uvm_test;

  %for i in interface:
  virtual ${i} ${i}_vif;
  %endfor
  ${env_name}_env env;
  ${reg_model_name} rm;
  apb_adapter reg_sqr_adapter;
  ${vsqr_name} vsqr;
  ${scoreboard}_scoreboard scb;

  function new(string name = "${basic_test_name}",uvm_component parent);
    super.new(name, parent);
  endfunction:new

  extern virtual function void build_phase(uvm_phase phase);
  extern virtual function void connect_phase(uvm_phase phase);
  extern virtual function void report_phase(uvm_phase phase);
  extern virtual function void final_phase(uvm_phase phase);

  `uvm_component_utils(${basic_test_name})
endclass: ${basic_test_name}

function void ${basic_test_name}::build_phase(uvm_phase phase);
  super.build_phase();

  env = ${env_name}_env::type_id::create("env",this);
  vsqr = ${vsqr_name}::type_id::create("vsqr",this);
  rm = ${reg_model_name}::type_id::create("rm",this);
  rm.configure(null, "");
  rm.build();
  rm.lock_model();
  rm.reset();
  rm.set_hdl_path_root("");
  reg_sqr_adapter = new("reg_sqr_adapter");
endfunction:build_phase

function void ${basic_test_name}::connect_phase(uvm_phase phase);
  super.connect_phase(phase);
  %for i in seq_item:
  vsqr.${i}_sqr = env.${i}_agt.${i}_sqr;
  %endfor
  vsqr.p_rm = this.rm;
  %for i in interface:
  vsqr.p_${i}_vif = env.${i}_vif;
  %endfor
  rm.default_map.set_sequencer(env.apb_agt.sqr, reg_sqr_adapter);
  rm.default_map.set_auto_predict(1);
endfunction: connect_phase

function void ${basic_test_name}::report_phase(uvm_phase phase);
  uvm_report_server server;
  int err_num;
  super.report_phase(phase);
  server  = get_report_server();
  err_num = server.get_severity_count(UVM_ERROR);
  if(err_num != 0)
    $display("TEST CASE FAILED!")
  else
    $display("TEST CASE PASSED!")
endfunction: report_phase

function void ${basic_test_name}::final_phase(uvm_phase phase);
  super.final_phase(phase);
  //uvm_top.print_topology();
  //factory.print();
endfunction:final_phase

`endif //${basic_test_name.upper()}_SVH