interface intf(input logic pclk);
  logic presetn;
  logic psel;
  logic penable;
  logic pwrite;
  logic pready;
  logic pslverr;
  logic irq;
  logic [15:0] paddr;
  logic [31:0] pwdata;
  logic [31:0] prdata;

endinterface
