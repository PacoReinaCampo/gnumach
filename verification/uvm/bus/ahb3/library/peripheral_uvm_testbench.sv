`define PERIPHERAL_UVM_ADDR_WIDTH 16

`include "peripheral_uvm_pkg.sv"
`include "peripheral_uvm_if.sv"

module peripheral_uvm_testbench;
  import uvm_pkg::*;
  import peripheral_uvm_pkg::*;
  `include "peripheral_uvm_test_library.sv"

  // SystemVerilog Interface
  peripheral_uvm_if vif ();

  peripheral_design dut (
    vif.hclk,
    vif.hresetn,

    vif.hsel,
    vif.haddr,
    vif.hwdata,
    vif.hrdata,
    vif.hwrite,
    vif.hsize,
    vif.hburst,
    vif.hprot,
    vif.htrans,
    vif.hmastlock,
    vif.hreadyout,
    vif.hready,
    vif.hresp
  );

  initial begin
    // Passing the interface handle to lower heirarchy using set method
    uvm_config_db#(virtual peripheral_uvm_if)::set(uvm_root::get(), "*", "vif", vif);

    // Enable wave dump
    $dumpfile("dump.vcd");
    $dumpvars(0);
  end

  // Calling TestCase
  initial begin
    run_test();
  end

  // Generate Reset
  initial begin
    vif.hresetn <= 1'b1;
    #50;
    vif.hresetn <= 1'b0;
  end

  // Generate Clock
  always #5 vif.hclk = ~vif.hclk;

  initial begin
    vif.hclk <= 1'b1;
  end

endmodule
