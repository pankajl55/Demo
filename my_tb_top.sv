//------------ TB_TOP -------------------//
`include "uvm_macros.svh"
import uvm_pkg::*;

`include "my_interface.sv"
`include "my_test.sv"

module tb_top;
  bit clk;
  bit reset;
  always #2 clk = ~clk;
  
  initial begin
    reset = 1;
    #5;
    reset = 0;
  end
  
  adder_if if_inst(clk, reset);
  
  adder DUT(.clk(if_inst.clk), .reset(if_inst.reset), .a(if_inst.a), .b(if_inst.b), .sum(if_inst.sum));
  
  initial begin
    uvm_config_db #(virtual adder_if) :: set(uvm_root::get(), "*", "vif", if_inst);
  end
  
  initial begin
    run_test("my_test");
  end
endmodule
