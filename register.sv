
class DEVICE_ID extends uvm_reg;
  `uvm_object_utils(DEVICE_ID)

  uvm_reg_field revision;
  uvm_reg_field vendor_id;
  uvm_reg_field product_id;

  covergroup device_id_cov with function sample(bit [7:0] revision_value, bit [7:0] vendor_value, bit [15:0] product_value);
    option.per_instance = 1;

    coverpoint revision_value {
      bins val = {[8'h00:8'hFF]};
    }

    coverpoint vendor_value {
      bins lower = {[8'h00:8'hFF]};
    }

    coverpoint product_value {
      bins val = {[16'h0000:16'hFFFF]};
    }
  endgroup

  function new(string name = "DEVICE_ID");
    super.new(name, 32, UVM_CVR_ALL);
    device_id_cov = new();
  endfunction

  function void build();
    revision = uvm_reg_field::type_id::create("revision");
    vendor_id = uvm_reg_field::type_id::create("vendor_id");
    product_id = uvm_reg_field::type_id::create("product_id");

    revision.configure(this, 8, 24, "RO", 0, 8'h02, 1, 0, 1);
    vendor_id.configure(this, 8, 16, "RO", 0, 8'hA5, 1, 0, 1);
    product_id.configure(this, 16, 0, "RO", 0, 16'h5357, 1, 0, 1);
  endfunction

  virtual function void sample(uvm_reg_data_t data, uvm_reg_data_t byte_en, bit is_read, uvm_reg_map map);
    if (is_read) begin
      device_id_cov.sample(data[31:24], data[23:16], data[15:0]);
    end
  endfunction

  virtual function void sample_values();
    uvm_reg_data_t mirror_data;

    super.sample_values();

    mirror_data = get_mirrored_value();
    device_id_cov.sample(mirror_data[31:24], mirror_data[23:16], mirror_data[15:0]);
  endfunction

endclass

//////// VERSION REGISTER (0x04)

class VERSION extends uvm_reg;
`uvm_object_utils(VERSION)

        uvm_reg_field reserved;
        uvm_reg_field major;
        uvm_reg_field minor;
        uvm_reg_field patch;

        covergroup version_cov;
        option.per_instance = 1;

        coverpoint major.get() {
                bins val = {[8'h00:8'hFF]};
        }

coverpoint minor.get() {
        bins val = {[8'h00:8'hFF]};
}

coverpoint patch.get() {
        bins val = {[8'h00:8'hFF]};
}

endgroup

function new(string name = "VERSION");
super.new(name, 32, UVM_CVR_ALL);
version_cov = new();
endfunction

function void build();
reserved = uvm_reg_field::type_id::create("reserved");
major = uvm_reg_field::type_id::create("major");
minor = uvm_reg_field::type_id::create("minor");
patch = uvm_reg_field::type_id::create("patch");

reserved.configure(this, 8, 24, "RO", 0, 0, 1, 0, 1);
major.configure(this, 8, 16, "RO", 0, 8'd1, 1, 0, 1);
minor.configure(this, 8, 8, "RO", 0, 8'd2, 1, 0, 1);
patch.configure(this, 8, 0, "RO", 0, 8'd0, 1, 0, 1);
endfunction

virtual function void sample(uvm_reg_data_t data, uvm_reg_data_t byte_en, bit is_read, uvm_reg_map map);
version_cov.sample();
endfunction

virtual function void sample_values();
super.sample_values();
version_cov.sample();
endfunction
endclass

//////// SWITCH_STATUS REGISTER (0x08)
class SWITCH_STATUS extends uvm_reg;
    `uvm_object_utils(SWITCH_STATUS)

    uvm_reg_field reserved_31_18;
    uvm_reg_field gen_fsm;
    uvm_reg_field reserved_15_10;
    uvm_reg_field err_pending;
    uvm_reg_field gen_running;
    uvm_reg_field port_enabled;
    uvm_reg_field locked;
    uvm_reg_field switch_enabled;
    uvm_reg_field busy;
    uvm_reg_field ready;

    covergroup switch_status_cov with function sample(bit [1:0] fsm_value, bit err_value, bit running_value, bit [3:0] port_value, bit lock_value, bit enable_value, bit busy_value, bit ready_value);
        option.per_instance = 1;

        coverpoint fsm_value {
            bins states = {[2'd0:2'd3]};
        }

        coverpoint err_value {
            bins err_val = {[0:1]};
        }

        coverpoint running_value {
            bins running_val = {[0:1]};
        }

        coverpoint port_value {
            bins enabled = {[4'b0000:4'hFFFF]};
        }

        coverpoint lock_value {
            bins locked_val   = {[0:1]};
        }

        coverpoint enable_value {
            bins enable_val = {[0:1]};
        }

        coverpoint busy_value {
            bins busy_val = {[0:1]};
        }

        coverpoint ready_value {
            bins ready_val = {[0:1]};
        }
    endgroup

    function new(string name = "SWITCH_STATUS");
        super.new(name, 32, UVM_CVR_ALL);
        switch_status_cov = new();
    endfunction

    function void build();
        reserved_31_18 = uvm_reg_field::type_id::create("reserved_31_18");
        gen_fsm = uvm_reg_field::type_id::create("gen_fsm");
        reserved_15_10 = uvm_reg_field::type_id::create("reserved_15_10");
        err_pending = uvm_reg_field::type_id::create("err_pending");
        gen_running = uvm_reg_field::type_id::create("gen_running");
        port_enabled = uvm_reg_field::type_id::create("port_enabled");
        locked = uvm_reg_field::type_id::create("locked");
        switch_enabled = uvm_reg_field::type_id::create("switch_enabled");
        busy = uvm_reg_field::type_id::create("busy");
        ready = uvm_reg_field::type_id::create("ready");

        reserved_31_18.configure(this, 14, 18, "RO", 0, 0, 1, 0, 1);
        gen_fsm.configure(this, 2, 16, "RO", 1, 0, 1, 0, 1);
        reserved_15_10.configure(this, 6, 10, "RO", 0, 0, 1, 0, 1);
        err_pending.configure(this, 1, 9, "RO", 1, 0, 1, 0, 1);
        gen_running.configure(this, 1, 8, "RO", 1, 0, 1, 0, 1);
        port_enabled.configure(this, 4, 4, "RO", 1, 4'hF, 1, 0, 1);
        locked.configure(this, 1, 3, "RO", 1, 1, 1, 0, 1);
        switch_enabled.configure(this, 1, 2, "RO", 1, 0, 1, 0, 1);
        busy.configure(this, 1, 1, "RO", 1, 0, 1, 0, 1);
        ready.configure(this, 1, 0, "RO", 1, 1, 1, 0, 1);
    endfunction

    virtual function void sample(uvm_reg_data_t data, uvm_reg_data_t byte_en, bit is_read, uvm_reg_map map);
        if (is_read) begin
            switch_status_cov.sample(data[17:16], data[9], data[8], data[7:4], data[3], data[2], data[1], data[0]);
        end
    endfunction

    virtual function void sample_values();
        uvm_reg_data_t mirror_data;

        super.sample_values();

        mirror_data = get_mirrored_value();
        switch_status_cov.sample(mirror_data[17:16], mirror_data[9], mirror_data[8], mirror_data[7:4], mirror_data[3], mirror_data[2], mirror_data[1], mirror_data[0]);
    endfunction

endclass

//////// PORT_STATUS REGISTER (0x0C)

class PORT_STATUS extends uvm_reg;
`uvm_object_utils(PORT_STATUS)

        uvm_reg_field port3_level;
        uvm_reg_field port2_level;
        uvm_reg_field port1_level;
        uvm_reg_field port0_level;

        covergroup port_status_cov;
        option.per_instance = 1;
        coverpoint port3_level.get() {
                bins val = {[0:16]};
        }
coverpoint port2_level.get() {
        bins val = {[0:16]};
}
coverpoint port1_level.get() {
        bins val = {[0:16]};
}
coverpoint port0_level.get() {
        bins val = {[0:16]};
}
endgroup

function new(string name = "PORT_STATUS");
super.new(name,32,UVM_CVR_ALL);
port_status_cov = new();
endfunction

function void build();
port3_level = uvm_reg_field::type_id::create("port3_level");
port2_level = uvm_reg_field::type_id::create("port2_level");
port1_level = uvm_reg_field::type_id::create("port1_level");
port0_level = uvm_reg_field::type_id::create("port0_level");

port3_level.configure(this,8,24,"RO",1,0,1,0,1);
port2_level.configure(this,8,16,"RO",1,0,1,0,1);
port1_level.configure(this,8,8,"RO",1,0,1,0,1);
port0_level.configure(this,8,0,"RO",1,0,1,0,1);
endfunction

virtual function void sample(uvm_reg_data_t data, uvm_reg_data_t byte_en, bit is_read, uvm_reg_map map);
port_status_cov.sample();
endfunction

virtual function void sample_values();
super.sample_values();
port_status_cov.sample();
endfunction
endclass

//////// GEN_STATUS REGISTER (0x10)
class GEN_STATUS extends uvm_reg;
`uvm_object_utils(GEN_STATUS)

        uvm_reg_field reserved_31_24;
        uvm_reg_field remaining;
        uvm_reg_field reserved_7_4;
        uvm_reg_field fsm;
        uvm_reg_field done;
        uvm_reg_field running;

        covergroup gen_status_cov with function sample(bit [15:0] remaining_count, bit [1:0] fsm_state, bit done_status, bit running_status);
        option.per_instance = 1;

        coverpoint remaining_count {
                bins zero     = {16'd0};
                bins one      = {16'd1};
                bins multiple = {[16'd2:16'hFFFF]};
        }

coverpoint fsm_state {
        bins idle = {0};
        bins send = {1};
        bins gap  = {2};
        bins done = {3};
}

coverpoint done_status {
        bins no  = {0};
        bins yes = {1};
}

coverpoint running_status {
        bins no  = {0};
        bins yes = {1};
}
endgroup

function new(string name = "GEN_STATUS");
super.new(name, 32, UVM_CVR_ALL);
gen_status_cov = new();
endfunction

function void build();
reserved_31_24 = uvm_reg_field::type_id::create("reserved_31_24");
remaining = uvm_reg_field::type_id::create("remaining");
reserved_7_4 = uvm_reg_field::type_id::create("reserved_7_4");
fsm = uvm_reg_field::type_id::create("fsm");
done = uvm_reg_field::type_id::create("done");
running = uvm_reg_field::type_id::create("running");

reserved_31_24.configure(this, 8, 24, "RO", 0, 0, 1, 0, 1);
remaining.configure(this, 16, 8, "RO", 1, 0, 1, 0, 1);
reserved_7_4.configure(this, 4, 4, "RO", 0, 0, 1, 0, 1);
fsm.configure(this, 2, 2, "RO", 1, 0, 1, 0, 1);
done.configure(this, 1, 1, "RO", 1, 0, 1, 0, 1);
running.configure(this, 1, 0, "RO", 1, 0, 1, 0, 1);
endfunction

virtual function void sample(uvm_reg_data_t data, uvm_reg_data_t byte_en, bit is_read, uvm_reg_map map);
if (is_read) begin
gen_status_cov.sample(data[23:8], data[3:2], data[1], data[0]);
end
endfunction

virtual function void sample_values();
uvm_reg_data_t mirror_data;

super.sample_values();

mirror_data = get_mirrored_value();
gen_status_cov.sample(mirror_data[23:8], mirror_data[3:2],
                mirror_data[1], mirror_data[0]);
endfunction

endclass



//////// STAT_RX REGISTER (0x14)
class STAT_RX extends uvm_reg;
  `uvm_object_utils(STAT_RX)

  uvm_reg_field reserved;
  uvm_reg_field rx_packets;

  covergroup stat_rx_cov with function sample(bit [15:0] count);
    option.per_instance = 1;

    coverpoint count {
      bins zero     = {16'd0};
      bins one      = {16'd1};
      bins multiple = {[16'd2:16'hFFFF]};
    }
  endgroup

  function new(string name = "STAT_RX");
    super.new(name, 32, UVM_CVR_ALL);
    stat_rx_cov = new();
  endfunction

  function void build();
    reserved = uvm_reg_field::type_id::create("reserved");
    rx_packets = uvm_reg_field::type_id::create("rx_packets");

    reserved.configure(this, 16, 16, "RO", 0, 0, 1, 0, 1);
    rx_packets.configure(this, 16, 0, "RO", 1, 0, 1, 0, 1);
  endfunction

  virtual function void sample(uvm_reg_data_t data, uvm_reg_data_t byte_en, bit is_read, uvm_reg_map map);
    stat_rx_cov.sample(data[15:0]);
  endfunction

  virtual function void sample_values();
    uvm_reg_data_t mirror_data;

    super.sample_values();

    mirror_data = rx_packets.get_mirrored_value();
    stat_rx_cov.sample(mirror_data[15:0]);
  endfunction

endclass

//////// STAT_TX REGISTER (0x18)
class STAT_TX extends uvm_reg;
  `uvm_object_utils(STAT_TX)

  uvm_reg_field reserved;
  uvm_reg_field tx_packets;

  covergroup stat_tx_cov with function sample(bit [15:0] count);
    option.per_instance = 1;

    coverpoint count {
      bins zero     = {16'd0};
      bins one      = {16'd1};
      bins multiple = {[16'd2:16'hFFFF]};
    }
  endgroup

  function new(string name = "STAT_TX");
    super.new(name, 32, UVM_CVR_ALL);
    stat_tx_cov = new();
  endfunction

  function void build();
    reserved = uvm_reg_field::type_id::create("reserved");
    tx_packets = uvm_reg_field::type_id::create("tx_packets");

    reserved.configure(this, 16, 16, "RO", 0, 0, 1, 0, 1);
    tx_packets.configure(this, 16, 0, "RO", 1, 0, 1, 0, 1);
  endfunction

  virtual function void sample(uvm_reg_data_t data, uvm_reg_data_t byte_en, bit is_read, uvm_reg_map map);
    stat_tx_cov.sample(data[15:0]);
  endfunction

  virtual function void sample_values();
    uvm_reg_data_t mirror_data;

    super.sample_values();

    mirror_data = tx_packets.get_mirrored_value();
    stat_tx_cov.sample(mirror_data[15:0]);
  endfunction

endclass

//////// STAT_DROP REGISTER (0x1C)
class STAT_DROP extends uvm_reg;
  `uvm_object_utils(STAT_DROP)

  uvm_reg_field reserved;
  uvm_reg_field dropped_packets;

  covergroup stat_drop_cov with function sample(bit [15:0] count);
    option.per_instance = 1;

    coverpoint count {
      bins zero     = {16'd0};
      bins one      = {16'd1};
      bins multiple = {[16'd2:16'hFFFF]};
    }
  endgroup

  function new(string name = "STAT_DROP");
    super.new(name, 32, UVM_CVR_ALL);
    stat_drop_cov = new();
  endfunction

  function void build();
    reserved = uvm_reg_field::type_id::create("reserved");
    dropped_packets = uvm_reg_field::type_id::create("dropped_packets");

    reserved.configure(this, 16, 16, "RO", 0, 0, 1, 0, 1);
    dropped_packets.configure(this, 16, 0, "RO", 1, 0, 1, 0, 1);
  endfunction

  virtual function void sample(uvm_reg_data_t data, uvm_reg_data_t byte_en, bit is_read, uvm_reg_map map);
    stat_drop_cov.sample(data[15:0]);
  endfunction

  virtual function void sample_values();
    uvm_reg_data_t mirror_data;

    super.sample_values();

    mirror_data = dropped_packets.get_mirrored_value();
    stat_drop_cov.sample(mirror_data[15:0]);
  endfunction

endclass


//////// SWITCH_CTRL REGISTER (0x20)

class SWITCH_CTRL extends uvm_reg;
    `uvm_object_utils(SWITCH_CTRL)

    uvm_reg_field reserved_31_4;
    uvm_reg_field irq_global_en;
    uvm_reg_field reserved_2;
    uvm_reg_field stat_clear;
    uvm_reg_field enable;

    covergroup switch_ctrl_cov;
        option.per_instance = 1;
        coverpoint irq_global_en.get() {
          bins disabled = {0};
          bins enabled = {1};
        }
        coverpoint stat_clear.get() {
          bins pulse = {1};
          bins no_pulse = {0};
        }
        coverpoint enable.get() {
          bins disabled = {0};
          bins enabled = {1};
        }
    endgroup

    function new(string name = "SWITCH_CTRL");
        super.new(name,32,UVM_CVR_ALL);
        switch_ctrl_cov = new();
    endfunction

    function void build();
        reserved_31_4 = uvm_reg_field::type_id::create("reserved_31_4");
            irq_global_en = uvm_reg_field::type_id::create("irq_global_en");
                reserved_2 = uvm_reg_field::type_id::create("reserved_2");
        stat_clear = uvm_reg_field::type_id::create("stat_clear");
        enable = uvm_reg_field::type_id::create("enable");

        reserved_31_4.configure(this,28,4,"RO",0,0,1,0,1);
        irq_global_en.configure(this,1,3,"RW",0,0,1,1,1);
        reserved_2.configure(this,1,2,"RO",0,0,1,0,1);
        stat_clear.configure(this,1,1,"WO",0,0,1,0,1);
        enable.configure(this,1,0,"RW",0,0,1,1,1);

    endfunction

    virtual function void sample(uvm_reg_data_t data, uvm_reg_data_t byte_en, bit is_read, uvm_reg_map map);
        switch_ctrl_cov.sample();
    endfunction

    virtual function void sample_values();
        super.sample_values();
        switch_ctrl_cov.sample();
    endfunction
endclass




//////// PORT_ENABLE REGISTER (0x24)

class PORT_ENABLE extends uvm_reg;
    `uvm_object_utils(PORT_ENABLE)

    uvm_reg_field reserved;
    uvm_reg_field port3_en;
    uvm_reg_field port2_en;
    uvm_reg_field port1_en;
    uvm_reg_field port0_en;

    covergroup port_enable_cov;
        option.per_instance = 1;
        coverpoint port3_en.get() {
          bins disabled = {0};
          bins enabled = {1};
        }
        coverpoint port2_en.get() {
          bins disabled = {0};
          bins enabled = {1};
        }
        coverpoint port1_en.get() {
          bins disabled = {0};
          bins enabled = {1};
        }
        coverpoint port0_en.get() {
          bins disabled = {0};
          bins enabled = {1};
        }
    endgroup

    function new(string name = "PORT_ENABLE");
        super.new(name,32,UVM_CVR_ALL);
        port_enable_cov = new();
    endfunction

    function void build();
        reserved = uvm_reg_field::type_id::create("reserved");
        port3_en = uvm_reg_field::type_id::create("port3_en");
        port2_en = uvm_reg_field::type_id::create("port2_en");
        port1_en = uvm_reg_field::type_id::create("port1_en");
        port0_en = uvm_reg_field::type_id::create("port0_en");

        reserved.configure(this,28,4,"RO",0,0,1,0,1);
        port3_en.configure(this,1,3,"RW",0,1,1,1,1);
        port2_en.configure(this,1,2,"RW",0,1,1,1,1);
        port1_en.configure(this,1,1,"RW",0,1,1,1,1);
        port0_en.configure(this,1,0,"RW",0,1,1,1,1);
    endfunction

    virtual function void sample(uvm_reg_data_t data, uvm_reg_data_t byte_en, bit is_read, uvm_reg_map map);
        port_enable_cov.sample();
    endfunction

    virtual function void sample_values();
        super.sample_values();
        port_enable_cov.sample();
    endfunction
endclass


//////// FWD_ENABLE REGISTER (0x28)

class FWD_ENABLE extends uvm_reg;
    `uvm_object_utils(FWD_ENABLE)

    uvm_reg_field reserved;
    uvm_reg_field fwd3_en;
    uvm_reg_field fwd2_en;
    uvm_reg_field fwd1_en;
    uvm_reg_field fwd0_en;

    covergroup fwd_enable_cov;
        option.per_instance = 1;
        coverpoint fwd3_en.get() {
          bins disabled = {0};
          bins enabled = {1};
        }
        coverpoint fwd2_en.get() {
          bins disabled = {0};
          bins enabled = {1};
        }
        coverpoint fwd1_en.get() {
          bins disabled = {0};
          bins enabled = {1};
        }
        coverpoint fwd0_en.get() {
          bins disabled = {0};
          bins enabled = {1};
        }
    endgroup

    function new(string name = "FWD_ENABLE");
        super.new(name,32,UVM_CVR_ALL);
        fwd_enable_cov = new();
    endfunction

    function void build();
        reserved = uvm_reg_field::type_id::create("reserved");
        fwd3_en = uvm_reg_field::type_id::create("fwd3_en");
        fwd2_en = uvm_reg_field::type_id::create("fwd2_en");
        fwd1_en = uvm_reg_field::type_id::create("fwd1_en");
        fwd0_en = uvm_reg_field::type_id::create("fwd0_en");

        reserved.configure(this,28,4,"RO",0,0,1,0,1);
        fwd3_en.configure(this,1,3,"RW",0,1,1,1,1);
        fwd2_en.configure(this,1,2,"RW",0,1,1,1,1);
        fwd1_en.configure(this,1,1,"RW",0,1,1,1,1);
        fwd0_en.configure(this,1,0,"RW",0,1,1,1,1);
    endfunction

    virtual function void sample(uvm_reg_data_t data, uvm_reg_data_t byte_en, bit is_read, uvm_reg_map map);
        fwd_enable_cov.sample();
    endfunction

    virtual function void sample_values();
        super.sample_values();
        fwd_enable_cov.sample();
    endfunction
endclass


//////// GEN_CTRL REGISTER (0x2C)

class GEN_CTRL extends uvm_reg;
    `uvm_object_utils(GEN_CTRL)

    uvm_reg_field reserved;
    uvm_reg_field continuous;
    uvm_reg_field stop;
    uvm_reg_field start;
    uvm_reg_field enable;

    covergroup gen_ctrl_cov;
        option.per_instance = 1;
        coverpoint continuous.get() {
          bins count_mode = {0};
          bins continuous_mode = {1};
        }
        coverpoint stop.get() {
          bins stop = {1};
          bins no_stop = {0};
        }
        coverpoint start.get() {
          bins start = {1};
          bins no_start = {0};
        }
        coverpoint enable.get() {
          bins disabled = {0};
          bins enabled = {1};
        }
    endgroup

    function new(string name = "GEN_CTRL");
        super.new(name,32,UVM_CVR_ALL);
        gen_ctrl_cov = new();
    endfunction

    function void build();
        reserved = uvm_reg_field::type_id::create("reserved");
        continuous = uvm_reg_field::type_id::create("continuous");
        stop = uvm_reg_field::type_id::create("stop");
        start = uvm_reg_field::type_id::create("start");
        enable = uvm_reg_field::type_id::create("enable");

        reserved.configure(this,28,4,"RO",0,0,1,0,1);
        continuous.configure(this,1,3,"RW",0,0,1,1,1);
        stop.configure(this,1,2,"WO",0,0,1,0,1);
        start.configure(this,1,1,"WO",0,0,1,0,1);
        enable.configure(this,1,0,"RW",0,0,1,1,1);
    endfunction

    virtual function void sample(uvm_reg_data_t data, uvm_reg_data_t byte_en, bit is_read, uvm_reg_map map);
        gen_ctrl_cov.sample();
    endfunction

    virtual function void sample_values();
        super.sample_values();
        gen_ctrl_cov.sample();
    endfunction
endclass


//////// GEN_PKT_CFG REGISTER (0x30)

class GEN_PKT_CFG extends uvm_reg;
    `uvm_object_utils(GEN_PKT_CFG)

    uvm_reg_field reserved_31_24;
    uvm_reg_field seed;
    uvm_reg_field length;
    uvm_reg_field reserved_7_4;
    uvm_reg_field src_port;
    uvm_reg_field dst_port;

    covergroup gen_pkt_cfg_cov;
        option.per_instance = 1;

        coverpoint seed.get() {
            bins lower = {[8'h00:8'h55]};
            bins mid = {[8'h56:8'hAA]};
            bins high = {[8'hAB:8'hFF]};
        }
        coverpoint length.get() {
            bins low = {[1:16]};
            bins mid = {[17:150]};
            bins high = {[151:255]};
        }
        coverpoint src_port.get() {
            bins port0 = {0};
            bins port1 = {1};
            bins port2 = {2};
            bins port3 = {3};
        }
        coverpoint dst_port.get() {
            bins port0 = {0};
            bins port1 = {1};
            bins port2 = {2};
            bins port3 = {3};
        }
    endgroup

    function new(string name = "GEN_PKT_CFG");
        super.new(name,32,UVM_CVR_ALL);
        gen_pkt_cfg_cov = new();
    endfunction

    function void build();
        reserved_31_24 = uvm_reg_field::type_id::create("reserved_31_24");
        seed = uvm_reg_field::type_id::create("seed");
        length = uvm_reg_field::type_id::create("length");
        reserved_7_4 = uvm_reg_field::type_id::create("reserved_7_4");
        src_port = uvm_reg_field::type_id::create("src_port");
        dst_port = uvm_reg_field::type_id::create("dst_port");

        reserved_31_24.configure(this,8,24,"RO",0,0,1,0,1);
        seed.configure(this,8,16,"RW",0,0,1,1,1);
        length.configure(this,8,8,"RW",0,8'd4,1,1,1);
        reserved_7_4.configure(this,4,4,"RO",0,0,1,0,1);
        src_port.configure(this,2,2,"RW",0,0,1,1,1);
        dst_port.configure(this,2,0,"RW",0,2'd1,1,1,1);
    endfunction

    virtual function void sample(uvm_reg_data_t data, uvm_reg_data_t byte_en, bit is_read, uvm_reg_map map);
        gen_pkt_cfg_cov.sample();
    endfunction

    virtual function void sample_values();
        super.sample_values();
        gen_pkt_cfg_cov.sample();
    endfunction
endclass

//////// GEN_INTERVAL REGISTER (0x34)

class GEN_INTERVAL extends uvm_reg;
    `uvm_object_utils(GEN_INTERVAL)

    uvm_reg_field reserved;
    uvm_reg_field interval;

    covergroup gen_interval_cov;
        option.per_instance = 1;
        coverpoint interval.get() {
            bins low = {[0:50]};
            bins mid = {[51:16'hABC1]};
            bins high = {[16'hABC2:16'hFFFF]};
        }
    endgroup

    function new(string name = "GEN_INTERVAL");
        super.new(name,32,UVM_CVR_ALL);
        gen_interval_cov = new();
    endfunction

    function void build();
        reserved = uvm_reg_field::type_id::create("reserved");
        interval = uvm_reg_field::type_id::create("interval");

        reserved.configure(this,16,16,"RO",0,0,1,0,1);
        interval.configure(this,16,0,"RW",0,16'd2,1,1,1);
    endfunction

    virtual function void sample(uvm_reg_data_t data, uvm_reg_data_t byte_en, bit is_read, uvm_reg_map map);
        gen_interval_cov.sample();
    endfunction

    virtual function void sample_values();
        super.sample_values();
        gen_interval_cov.sample();
    endfunction
endclass


//////// GEN_COUNT REGISTER (0x38)

class GEN_COUNT extends uvm_reg;
    `uvm_object_utils(GEN_COUNT)

    uvm_reg_field reserved;
    uvm_reg_field packet_count;

    covergroup gen_count_cov;
        option.per_instance = 1;
        coverpoint packet_count.get() {
          bins low = {[0:50]};
          bins mid = {[51:16'hABC1]};
          bins high = {[16'hABC2:16'hFFFF]};
        }
    endgroup

    function new(string name = "GEN_COUNT");
        super.new(name,32,UVM_CVR_ALL);
        gen_count_cov = new();
    endfunction

    function void build();
        reserved = uvm_reg_field::type_id::create("reserved");
        packet_count = uvm_reg_field::type_id::create("packet_count");

        reserved.configure(this,16,16,"RO",0,0,1,0,1);
        packet_count.configure(this,16,0,"RW",0,16'd4,1,1,1);
    endfunction

    virtual function void sample(uvm_reg_data_t data, uvm_reg_data_t byte_en, bit is_read, uvm_reg_map map);
        gen_count_cov.sample();
    endfunction

    virtual function void sample_values();
        super.sample_values();
        gen_count_cov.sample();
    endfunction
endclass


//////// IRQ_STATUS REGISTER (0x3C)
class IRQ_STATUS extends uvm_reg;
    `uvm_object_utils(IRQ_STATUS)

    uvm_reg_field reserved;
    uvm_reg_field sw_event;
    uvm_reg_field start_ack;
    uvm_reg_field queue_almost_full;
    uvm_reg_field packet_forwarded;
    uvm_reg_field packet_dropped;
    uvm_reg_field queue_overflow;
    uvm_reg_field error;
    uvm_reg_field gen_done;

    covergroup irq_status_cov with function sample(bit [7:0] irq_value);
        option.per_instance = 1;

        coverpoint irq_value[7] {
            bins clear = {0};
            bins set   = {1};
        }

        coverpoint irq_value[6] {
            bins clear = {0};
            bins set   = {1};
        }

        coverpoint irq_value[5] {
            bins clear = {0};
            bins set   = {1};
        }

        coverpoint irq_value[4] {
            bins clear = {0};
            bins set   = {1};
        }

        coverpoint irq_value[3] {
            bins clear = {0};
            bins set   = {1};
        }

        coverpoint irq_value[2] {
            bins clear = {0};
            bins set   = {1};
        }

        coverpoint irq_value[1] {
            bins clear = {0};
            bins set   = {1};
        }

        coverpoint irq_value[0] {
            bins clear = {0};
            bins set   = {1};
        }
    endgroup

    function new(string name = "IRQ_STATUS");
        super.new(name, 32, UVM_CVR_ALL);
        irq_status_cov = new();
    endfunction

    function void build();
        reserved          = uvm_reg_field::type_id::create("reserved");
        sw_event          = uvm_reg_field::type_id::create("sw_event");
        start_ack         = uvm_reg_field::type_id::create("start_ack");
        queue_almost_full = uvm_reg_field::type_id::create("queue_almost_full");
        packet_forwarded  = uvm_reg_field::type_id::create("packet_forwarded");
        packet_dropped    = uvm_reg_field::type_id::create("packet_dropped");
        queue_overflow    = uvm_reg_field::type_id::create("queue_overflow");
        error             = uvm_reg_field::type_id::create("error");
        gen_done          = uvm_reg_field::type_id::create("gen_done");

        reserved.configure(this, 24, 8, "RO", 0, 0, 1, 0, 1);
        sw_event.configure(this, 1, 7, "W1C", 0, 0, 1, 0, 1);
        start_ack.configure(this, 1, 6, "W1C", 0, 0, 1, 0, 1);
        queue_almost_full.configure(this, 1, 5, "W1C", 0, 0, 1, 0, 1);
        packet_forwarded.configure(this, 1, 4, "W1C", 0, 0, 1, 0, 1);
        packet_dropped.configure(this, 1, 3, "W1C", 0, 0, 1, 0, 1);
        queue_overflow.configure(this, 1, 2, "W1C", 0, 0, 1, 0, 1);
        error.configure(this, 1, 1, "W1C", 0, 0, 1, 0, 1);
        gen_done.configure(this, 1, 0, "W1C", 0, 0, 1, 0, 1);
    endfunction

    virtual function void sample(uvm_reg_data_t data, uvm_reg_data_t byte_en, bit is_read, uvm_reg_map map);
        if (is_read)
            irq_status_cov.sample(data[7:0]);
    endfunction

    virtual function void sample_values();
        uvm_reg_data_t mirror_data;

        super.sample_values();

        mirror_data = get_mirrored_value();
        irq_status_cov.sample(mirror_data[7:0]);
    endfunction

endclass


//////// IRQ_ENABLE REGISTER (0x40)

class IRQ_ENABLE extends uvm_reg;
    `uvm_object_utils(IRQ_ENABLE)

    uvm_reg_field reserved;
    uvm_reg_field sw_event_en;
    uvm_reg_field start_ack_en;
    uvm_reg_field queue_af_en;
    uvm_reg_field packet_fwd_en;
    uvm_reg_field packet_drop_en;
    uvm_reg_field overflow_en;
    uvm_reg_field error_en;
    uvm_reg_field gen_done_en;

    covergroup irq_enable_cov;
        option.per_instance = 1;
        coverpoint sw_event_en.get() {
          bins disabled = {0};
          bins enabled = {1};
        }
        coverpoint start_ack_en.get() {
          bins disabled = {0};
          bins enabled = {1};
        }
        coverpoint queue_af_en.get() {
          bins disabled = {0};
          bins enabled = {1};
        }
        coverpoint packet_fwd_en.get() {
          bins disabled = {0};
          bins enabled = {1};
        }
        coverpoint packet_drop_en.get() {
          bins disabled = {0};
          bins enabled = {1};
        }
        coverpoint overflow_en.get() {
          bins disabled = {0};
          bins enabled = {1};
        }
        coverpoint error_en.get() {
          bins disabled = {0};
          bins enabled = {1};
        }
        coverpoint gen_done_en.get() {
          bins disabled = {0};
          bins enabled = {1};
        }
    endgroup

    function new(string name = "IRQ_ENABLE");
        super.new(name,32,UVM_CVR_ALL);
        irq_enable_cov = new();
    endfunction

    function void build();
        reserved = uvm_reg_field::type_id::create("reserved");
        sw_event_en = uvm_reg_field::type_id::create("sw_event_en");
        start_ack_en = uvm_reg_field::type_id::create("start_ack_en");
        queue_af_en = uvm_reg_field::type_id::create("queue_af_en");
        packet_fwd_en = uvm_reg_field::type_id::create("packet_fwd_en");
        packet_drop_en = uvm_reg_field::type_id::create("packet_drop_en");
        overflow_en = uvm_reg_field::type_id::create("overflow_en");
        error_en = uvm_reg_field::type_id::create("error_en");
        gen_done_en = uvm_reg_field::type_id::create("gen_done_en");

        reserved.configure(this,24,8,"RO",0,0,1,0,1);
        sw_event_en.configure(this,1,7,"RW",0,0,1,1,1);
        start_ack_en.configure(this,1,6,"RW",0,0,1,1,1);
        queue_af_en.configure(this,1,5,"RW",0,0,1,1,1);
        packet_fwd_en.configure(this,1,4,"RW",0,0,1,1,1);
        packet_drop_en.configure(this,1,3,"RW",0,0,1,1,1);
        overflow_en.configure(this,1,2,"RW",0,0,1,1,1);
        error_en.configure(this,1,1,"RW",0,0,1,1,1);
        gen_done_en.configure(this,1,0,"RW",0,0,1,1,1);
    endfunction

    virtual function void sample(uvm_reg_data_t data, uvm_reg_data_t byte_en, bit is_read, uvm_reg_map map);
        irq_enable_cov.sample();
    endfunction

    virtual function void sample_values();
        super.sample_values();
        irq_enable_cov.sample();
    endfunction
endclass



class IRQ_FORCE extends uvm_reg;
    `uvm_object_utils(IRQ_FORCE)

    uvm_reg_field reserved;
    uvm_reg_field force_;

    covergroup irq_force_cov;
        option.per_instance = 1;
        coverpoint force_.get() {
            bins low = {8'h00};
            bins single_bit = {1,2,4,8,16,32,64,128};
            bins multiple_bits = {[8'h03:8'hFE]};
        }
    endgroup

    function new(string name = "IRQ_FORCE");
        super.new(name,32,UVM_CVR_ALL);
        irq_force_cov = new();
    endfunction

    function void build();
        reserved = uvm_reg_field::type_id::create("reserved");
        force_ = uvm_reg_field::type_id::create("force_");

        reserved.configure(this,24,8,"RO",0,0,1,0,1);
        force_.configure(this,8,0,"WO",0,0,0,0,1);
    endfunction

    virtual function void sample(uvm_reg_data_t data, uvm_reg_data_t byte_en, bit is_read, uvm_reg_map map);
        irq_force_cov.sample();
    endfunction

    virtual function void sample_values();
        super.sample_values();
        irq_force_cov.sample();
    endfunction
endclass


//////// ERR_STATUS REGISTER (0x48)

class ERR_STATUS extends uvm_reg;
    `uvm_object_utils(ERR_STATUS)

    uvm_reg_field reserved;
    uvm_reg_field injected;
    uvm_reg_field length_error;
    uvm_reg_field crc_error;
    uvm_reg_field protocol_error;
    uvm_reg_field undersize;
    uvm_reg_field queue_overflow;
    uvm_reg_field dest_error;
    uvm_reg_field bus_error;

    covergroup err_status_cov;
        option.per_instance = 1;
        coverpoint injected.get() {
          bins clear = {0};
          bins set = {1};
        }
        coverpoint length_error.get() {
          bins length_error_val = {[0:1]};
        }
        coverpoint crc_error.get() {
          bins clear = {0};
          bins set = {1};
        }
        coverpoint protocol_error.get() {
          bins prtocol_err_val = {[0:1]};
        }
        coverpoint undersize.get() {
          bins undersize_val = {[0:1]};
        }
        coverpoint queue_overflow.get() {
          bins queue_overlow_val = {[0:1]};
        }
        coverpoint dest_error.get() {
          bins dest_error_val = {[0:1]};
        }
        coverpoint bus_error.get() {
          bins bus_error_val = {[0:1]};
        }
    endgroup

    function new(string name = "ERR_STATUS");
        super.new(name,32,UVM_CVR_ALL);
        err_status_cov = new();
    endfunction

    function void build();
        reserved = uvm_reg_field::type_id::create("reserved");
        injected = uvm_reg_field::type_id::create("injected");
        length_error = uvm_reg_field::type_id::create("length_error");
        crc_error = uvm_reg_field::type_id::create("crc_error");
        protocol_error = uvm_reg_field::type_id::create("protocol_error");
        undersize = uvm_reg_field::type_id::create("undersize");
        queue_overflow = uvm_reg_field::type_id::create("queue_overflow");
        dest_error = uvm_reg_field::type_id::create("dest_error");
        bus_error = uvm_reg_field::type_id::create("bus_error");

        reserved.configure(this,24,8,"RO",0,0,1,0,1);
        injected.configure(this,1,7,"W1C",0,0,1,0,1);
        length_error.configure(this,1,6,"W1C",0,0,1,0,1);
        crc_error.configure(this,1,5,"W1C",0,0,1,0,1);
        protocol_error.configure(this,1,4,"W1C",0,0,1,0,1);
        undersize.configure(this,1,3,"W1C",0,0,1,0,1);
        queue_overflow.configure(this,1,2,"W1C",0,0,1,0,1);
        dest_error.configure(this,1,1,"W1C",0,0,1,0,1);
        bus_error.configure(this,1,0,"W1C",0,0,1,0,1);
    endfunction

    virtual function void sample(uvm_reg_data_t data, uvm_reg_data_t byte_en, bit is_read, uvm_reg_map map);
        err_status_cov.sample();
    endfunction

    virtual function void sample_values();
        super.sample_values();
        err_status_cov.sample();
    endfunction
endclass


//////// ERR_ENABLE REGISTER (0x4C)

class ERR_ENABLE extends uvm_reg;
    `uvm_object_utils(ERR_ENABLE)

    uvm_reg_field reserved;
    uvm_reg_field injected_en;
    uvm_reg_field length_en;
    uvm_reg_field crc_en;
    uvm_reg_field protocol_en;
    uvm_reg_field undersize_en;
    uvm_reg_field overflow_en;
    uvm_reg_field dest_en;
    uvm_reg_field bus_en;

    covergroup err_enable_cov;
        option.per_instance = 1;
        coverpoint injected_en.get() {
          bins disabled = {0};
          bins enabled = {1};
        }
        coverpoint length_en.get() {
          bins disabled = {0};
          bins enabled = {1};
        }
        coverpoint crc_en.get() {
          bins disabled = {0};
          bins enabled = {1};
        }
        coverpoint protocol_en.get() {
          bins disabled = {0};
          bins enabled = {1};
        }
        coverpoint undersize_en.get() {
          bins disabled = {0};
          bins enabled = {1};
        }
        coverpoint overflow_en.get() {
          bins disabled = {0};
          bins enabled = {1};
        }
        coverpoint dest_en.get() {
          bins disabled = {0};
          bins enabled = {1};
        }
        coverpoint bus_en.get() {
          bins disabled = {0};
          bins enabled = {1};
        }
    endgroup

    function new(string name = "ERR_ENABLE");
        super.new(name,32,UVM_CVR_ALL);
        err_enable_cov = new();
    endfunction

    function void build();
        reserved = uvm_reg_field::type_id::create("reserved");
        injected_en = uvm_reg_field::type_id::create("injected_en");
        length_en = uvm_reg_field::type_id::create("length_en");
        crc_en = uvm_reg_field::type_id::create("crc_en");
        protocol_en = uvm_reg_field::type_id::create("protocol_en");
        undersize_en = uvm_reg_field::type_id::create("undersize_en");
        overflow_en = uvm_reg_field::type_id::create("overflow_en");
        dest_en = uvm_reg_field::type_id::create("dest_en");
        bus_en = uvm_reg_field::type_id::create("bus_en");

        reserved.configure(this,24,8,"RO",0,0,1,0,1);
        injected_en.configure(this,1,7,"RW",0,0,1,1,1);
        length_en.configure(this,1,6,"RW",0,0,1,1,1);
        crc_en.configure(this,1,5,"RW",0,0,1,1,1);
        protocol_en.configure(this,1,4,"RW",0,0,1,1,1);
        undersize_en.configure(this,1,3,"RW",0,0,1,1,1);
        overflow_en.configure(this,1,2,"RW",0,0,1,1,1);
        dest_en.configure(this,1,1,"RW",0,0,1,1,1);
        bus_en.configure(this,1,0,"RW",0,0,1,1,1);
    endfunction

    virtual function void sample(uvm_reg_data_t data, uvm_reg_data_t byte_en, bit is_read, uvm_reg_map map);
        err_enable_cov.sample();
    endfunction

    virtual function void sample_values();
        super.sample_values();
        err_enable_cov.sample();
    endfunction
endclass


//////// ERR_INJECT REGISTER (0x50)

class ERR_INJECT extends uvm_reg;
    `uvm_object_utils(ERR_INJECT)

    uvm_reg_field clear_count;
    uvm_reg_field reserved;
    uvm_reg_field injected;
    uvm_reg_field length;
    uvm_reg_field crc;
    uvm_reg_field protocol;
    uvm_reg_field undersize;
    uvm_reg_field overflow;
    uvm_reg_field dest;
    uvm_reg_field bus;

    covergroup err_inject_cov;
        option.per_instance = 1;
    coverpoint clear_count.get() {
          bins no = {0};
          bins yes = {1};
        }
        coverpoint injected.get() {
          bins no = {0};
          bins yes = {1};
        }
        coverpoint length.get() {
          bins no = {0};
          bins yes = {1};
        }
        coverpoint crc.get() {
          bins no = {0};
          bins yes = {1};
        }
        coverpoint protocol.get() {
          bins no = {0};
          bins yes = {1};
        }
        coverpoint undersize.get() {
          bins no = {0};
          bins yes = {1};
        }
        coverpoint overflow.get() {
          bins no = {0};
          bins yes = {1};
        }
        coverpoint dest.get() {
          bins no = {0};
          bins yes = {1};
        }
        coverpoint bus.get() {
          bins no = {0};
          bins yes = {1};
        }
    endgroup

    function new(string name = "ERR_INJECT");
        super.new(name,32,UVM_CVR_ALL);
        err_inject_cov = new();
    endfunction

    function void build();
        clear_count = uvm_reg_field::type_id::create("clear_count");
        reserved = uvm_reg_field::type_id::create("reserved");
        injected = uvm_reg_field::type_id::create("injected");
        length = uvm_reg_field::type_id::create("length");
        crc = uvm_reg_field::type_id::create("crc");
        protocol = uvm_reg_field::type_id::create("protocol");
        undersize = uvm_reg_field::type_id::create("undersize");
        overflow = uvm_reg_field::type_id::create("overflow");
        dest = uvm_reg_field::type_id::create("dest");
        bus = uvm_reg_field::type_id::create("bus");

        clear_count.configure(this,1,31,"WO",0,0,0,0,1);
        reserved.configure(this,23,8,"RO",0,0,1,0,1);
        injected.configure(this,1,7,"WO",0,0,1,0,1);
        length.configure(this,1,6,"WO",0,0,1,0,1);
            crc.configure(this,1,5,"WO",0,0,1,0,1);
        protocol.configure(this,1,4,"WO",0,0,1,0,1);
        undersize.configure(this,1,3,"WO",0,0,1,0,1);
        overflow.configure(this,1,2,"WO",0,0,1,0,1);
        dest.configure(this,1,1,"WO",0,0,1,0,1);
        bus.configure(this,1,0,"WO",0,0,1,0,1);
    endfunction

    virtual function void sample(uvm_reg_data_t data, uvm_reg_data_t byte_en, bit is_read, uvm_reg_map map);
        err_inject_cov.sample();
    endfunction

    virtual function void sample_values();
        super.sample_values();
        err_inject_cov.sample();
    endfunction
endclass


//////// ERR_COUNT REGISTER (0x54)
class ERR_COUNT extends uvm_reg;
  `uvm_object_utils(ERR_COUNT)

  uvm_reg_field reserved;
  uvm_reg_field error_count;

  covergroup err_count_cov with function sample(bit [15:0] count);
    option.per_instance = 1;

    coverpoint count {
      bins zero     = {16'd0};
      bins one      = {16'd1};
      bins multiple = {[16'd2:16'hFFFF]};
    }
  endgroup

  function new(string name = "ERR_COUNT");
    super.new(name, 32, UVM_CVR_ALL);
    err_count_cov = new();
  endfunction

  function void build();
    reserved = uvm_reg_field::type_id::create("reserved");
    error_count = uvm_reg_field::type_id::create("error_count");

    reserved.configure(this, 16, 16, "RO", 0, 0, 1, 0, 1);
    error_count.configure(this, 16, 0, "RO", 1, 0, 1, 0, 1);
  endfunction

  virtual function void sample(uvm_reg_data_t data, uvm_reg_data_t byte_en, bit is_read, uvm_reg_map map);
    err_count_cov.sample(data[15:0]);
  endfunction

  virtual function void sample_values();
    uvm_reg_data_t mirror_data;

    super.sample_values();

    mirror_data = error_count.get_mirrored_value();
    err_count_cov.sample(mirror_data[15:0]);
  endfunction

endclass




//////// ERR_INFO REGISTER (0x58)
// ERR_INFO REGISTER (0x58)

class ERR_INFO extends uvm_reg;
    `uvm_object_utils(ERR_INFO)

    uvm_reg_field tx_snapshot;
    uvm_reg_field reserved;
    uvm_reg_field dest_port;
    uvm_reg_field source;
    uvm_reg_field last_code;

    covergroup err_info_cov with function sample(bit [11:0] tx_value, bit [1:0] dest_value, bit [7:0] source_value, bit [7:0] code_value);
        option.per_instance = 1;

        coverpoint tx_value {
            bins all_values = {[12'h000:12'hFFF]};
        }

        coverpoint dest_value {
            bins dest_val = {[2'd0:2'd3]};
        }

        coverpoint source_value {
            bins hardware = {8'd0};
            bins injection = {8'd1};
        }

        coverpoint code_value {
            bins code_val = {[8'd0:8'd7]};
        }
    endgroup

    function new(string name = "ERR_INFO");
        super.new(name, 32, UVM_CVR_ALL);
        err_info_cov = new();
    endfunction

    function void build();
        tx_snapshot = uvm_reg_field::type_id::create("tx_snapshot");
        reserved    = uvm_reg_field::type_id::create("reserved");
        dest_port   = uvm_reg_field::type_id::create("dest_port");
        source      = uvm_reg_field::type_id::create("source");
        last_code   = uvm_reg_field::type_id::create("last_code");

        tx_snapshot.configure(this, 12, 20, "RO", 1, 0, 1, 0, 1);
        reserved.configure(this, 2, 18, "RO", 0, 0, 1, 0, 1);
        dest_port.configure(this, 2, 16, "RO", 1, 0, 1, 0, 1);
        source.configure(this, 8, 8, "RO", 1, 0, 1, 0, 1);
        last_code.configure(this, 8, 0, "RO", 1, 0, 1, 0, 1);
    endfunction

    virtual function void sample(uvm_reg_data_t data, uvm_reg_data_t byte_en, bit is_read, uvm_reg_map map);
        if (is_read) begin
            err_info_cov.sample(data[31:20], data[17:16], data[15:8], data[7:0]);
        end
    endfunction

    virtual function void sample_values();
        uvm_reg_data_t mirror_data;

        super.sample_values();

        mirror_data = get_mirrored_value();
        err_info_cov.sample(mirror_data[31:20], mirror_data[17:16], mirror_data[15:8], mirror_data[7:0]);
    endfunction

endclass




//////// LOCK REGISTER (0x5C)

class LOCK extends uvm_reg;
    `uvm_object_utils(LOCK)

    uvm_reg_field key_reserved;
    uvm_reg_field locked;

    covergroup lock_cov;
        option.per_instance = 1;
        coverpoint key_reserved.get() {
            bins zero = {0};
            bins other = {[1:32'hFFFF_FFFF]};
        }
        coverpoint locked.get() {
            bins unlocked = {0};
            bins locked = {1};
        }
    endgroup

    function new(string name = "LOCK");
        super.new(name,32,UVM_CVR_ALL);
        lock_cov = new();
    endfunction

    function void build();
        key_reserved = uvm_reg_field::type_id::create("key_reserved");
        locked = uvm_reg_field::type_id::create("locked");

        key_reserved.configure(this,31,1,"WO",0,0,0,0,1);
        locked.configure(this,1,0,"RO",0,1,1,0,1);
    endfunction

    virtual function void sample(uvm_reg_data_t data, uvm_reg_data_t byte_en, bit is_read, uvm_reg_map map);
        lock_cov.sample();
    endfunction

    virtual function void sample_values();
        super.sample_values();
        lock_cov.sample();
    endfunction
endclass


//////// SOFT_RESET REGISTER (0x60)

class SOFT_RESET extends uvm_reg;
    `uvm_object_utils(SOFT_RESET)

    uvm_reg_field reserved;
    uvm_reg_field pulse;

    covergroup soft_reset_cov;
        option.per_instance = 1;
        coverpoint pulse.get() {
            bins no_pulse = {0};
            bins reset_pulse = {1};
        }
    endgroup

    function new(string name = "SOFT_RESET");
        super.new(name,32,UVM_CVR_ALL);
        soft_reset_cov = new();
    endfunction

    function void build();
        reserved = uvm_reg_field::type_id::create("reserved");
        pulse = uvm_reg_field::type_id::create("pulse");

        reserved.configure(this,31,1,"RO",0,0,1,0,1);
        pulse.configure(this,1,0,"WO",0,0,1,0,1);
    endfunction

    virtual function void sample(uvm_reg_data_t data, uvm_reg_data_t byte_en,
                                  bit is_read, uvm_reg_map map);
        soft_reset_cov.sample();
    endfunction

    virtual function void sample_values();
        super.sample_values();
        soft_reset_cov.sample();
    endfunction
endclass






