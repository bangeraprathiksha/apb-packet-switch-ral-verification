`include "design.sv"
`include "uvm_macros.svh"

import uvm_pkg::*;

`include "ral_pkg.sv"
import ral_pkg::*;

`include "intf.sv"

module tb_top;

  bit pclk;
  bit presetn;

  // APB interface
  intf vif (pclk);

  // DUT
  apb_pkt_switch dut (
    .pclk    (pclk),
    .presetn (vif.presetn),

      .psel    (vif.psel),
      .penable (vif.penable),
      .pwrite  (vif.pwrite),
      .paddr   (vif.paddr),
      .pwdata  (vif.pwdata),

      .prdata  (vif.prdata),
      .pready  (vif.pready),
      .pslverr (vif.pslverr),

      .irq     (vif.irq)
  );

  // Clock generation
  initial pclk = 0;
  always #5 pclk = ~pclk;

  // Reset generation
  initial begin
    presetn = 1;

    // Keep reset active for 5 clock cycles
    repeat (5) @(posedge pclk);

    presetn = 1;
  end

  // Give virtual interface to UVM components
  initial begin
    uvm_config_db#(virtual intf)::set(null, "*", "vif", vif);

    // Run test
    //run_test("all_reg_reset_test");
    //run_test("gen_four_packets_test");
    //run_test("clear_sticky_status_test");
    //run_test("dest_drop_test");
    //run_test("device_id_test");
    //run_test("version_test");
    //run_test("switch_status_test");
    //run_test("port_status_test");
    //run_test("gen_status_test");
    //run_test("stat_rx_test");
    //run_test("stat_tx_test");
    //run_test("stat_drop_test");
    //run_test("switch_ctrl_test"); //doubt (not sure for desired and mirror value)
    //run_test("port_enable_test");
    //run_test("fwd_enable_test");
    //run_test("gen_ctrl_test"); // doubt (not sure for desired and mirror value)
    //run_test("gen_pkt_cfg_test");
    //run_test("gen_interval_test");
    //run_test("gen_count_test");
    //run_test("irq_status_test");
    //run_test("irq_enable_test");
    //run_test("irq_force_test");// doubt (not sure for desired and mirror value)
    //run_test("err_status_test");
    //run_test("err_enable_test");
    //run_test("err_inject_test");
    //run_test("err_count_test");
    //run_test("err_info_test");
    //run_test("lock_test");
    //run_test("soft_reset_test");
    run_test("all_reg_regression_test");

  end

  initial begin
    $dumpfile("waveform.vcd");
    $dumpvars(0, tb_top);
  end



endmodule
