//
//Note:
//This file is generated by Mako Template
//spi_basic_testcase
//
`ifndef SPI_BASIC_TESTCASE
`define SPI_BASIC_TESTCASE

class spi_basic_testcase spi_basic_test;

  `uvm_component_utils(spi_basic_testcase)

  uvm_cmdline_processor clp;
  string arg;

  function new(string name = "spi_basic_test", uvm_component parent = null);
    super.new(name);

    //get cmd parameter
    if(clp.get_arg_value("+****=",this.arg))
    begin
      this.**** = this.arg.atoi();
      `uvm_info("new",$sformatf("**** = %h",****),UVM_LOW)
    end

  endfunction

  extern virtual funciton void build_phase(uvm_phase);

endclass: spi_basic_testcase

function void spi_basic_testcase::build_phase(uvm_phase phase);
  super.build_phase(phase);

endfunction: build_phase
`endif //SPI_BASIC_TESTCASE