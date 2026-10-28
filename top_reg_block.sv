class top_reg_block extends uvm_reg_block;
    `uvm_object_utils(top_reg_block)

    rand DEVICE_ID device_id;
    rand VERSION version;
    rand SWITCH_STATUS switch_status;
    rand PORT_STATUS port_status;
    rand GEN_STATUS gen_status;
    rand STAT_RX stat_rx;
    rand STAT_TX stat_tx;
    rand STAT_DROP stat_drop;
    rand SWITCH_CTRL switch_ctrl;
    rand PORT_ENABLE port_enable;
    rand FWD_ENABLE fwd_enable;
    rand GEN_CTRL gen_ctrl;
    rand GEN_PKT_CFG gen_pkt_cfg;
    rand GEN_INTERVAL gen_interval;
    rand GEN_COUNT gen_count;
    rand IRQ_STATUS irq_status;
    rand IRQ_ENABLE irq_enable;
    rand IRQ_FORCE irq_force;
    rand ERR_STATUS err_status;
    rand ERR_ENABLE err_enable;
    rand ERR_INJECT err_inject;
    rand ERR_COUNT err_count;
    rand ERR_INFO err_info;
    rand LOCK lock;
    rand SOFT_RESET soft_reset;

    function new(string name = "top_reg_block");
        super.new(name, UVM_CVR_FIELD_VALS);
    endfunction

    function void build();
        add_hdl_path ("dut", "RTL");

        uvm_reg::include_coverage("*", UVM_CVR_FIELD_VALS);

        // DEVICE_ID - 0x00
        device_id = DEVICE_ID::type_id::create("device_id");
        device_id.build();
        device_id.configure(this);
        device_id.set_coverage(UVM_CVR_FIELD_VALS);

        // VERSION - 0x04
        version = VERSION::type_id::create("version");
        version.build();
        version.configure(this);
        version.set_coverage(UVM_CVR_FIELD_VALS);

        // SWITCH_STATUS - 0x08
        switch_status = SWITCH_STATUS::type_id::create("switch_status");
        switch_status.build();
        switch_status.configure(this);
        switch_status.set_coverage(UVM_CVR_FIELD_VALS);

        // PORT_STATUS - 0x0C
        port_status = PORT_STATUS::type_id::create("port_status");
        port_status.build();
        port_status.configure(this);
        port_status.set_coverage(UVM_CVR_FIELD_VALS);

        // GEN_STATUS - 0x10
        gen_status = GEN_STATUS::type_id::create("gen_status");
        gen_status.build();
        gen_status.configure(this);
        gen_status.set_coverage(UVM_CVR_FIELD_VALS);

        // STAT_RX - 0x14
        stat_rx = STAT_RX::type_id::create("stat_rx");
        stat_rx.build();
        stat_rx.configure(this);
        stat_rx.set_coverage(UVM_CVR_FIELD_VALS);

        // STAT_TX - 0x18
        stat_tx = STAT_TX::type_id::create("stat_tx");
        stat_tx.build();
        stat_tx.configure(this);
        stat_tx.set_coverage(UVM_CVR_FIELD_VALS);

       // STAT_DROP - 0x1C
        stat_drop = STAT_DROP::type_id::create("stat_drop");
        stat_drop.build();
        stat_drop.configure(this);
        stat_drop.set_coverage(UVM_CVR_FIELD_VALS);

        // SWITCH_CTRL - 0x20
        switch_ctrl = SWITCH_CTRL::type_id::create("switch_ctrl");
        switch_ctrl.build();
        switch_ctrl.configure(this);
        switch_ctrl.set_coverage(UVM_CVR_FIELD_VALS);

        // PORT_ENABLE - 0x24
        port_enable = PORT_ENABLE::type_id::create("port_enable");
        port_enable.build();
        port_enable.configure(this);
        port_enable.set_coverage(UVM_CVR_FIELD_VALS);

        // FWD_ENABLE - 0x28
        fwd_enable = FWD_ENABLE::type_id::create("fwd_enable");
        fwd_enable.build();
        fwd_enable.configure(this);
        fwd_enable.set_coverage(UVM_CVR_FIELD_VALS);

        // GEN_CTRL - 0x2C

        gen_ctrl = GEN_CTRL::type_id::create("gen_ctrl");
        gen_ctrl.build();
        gen_ctrl.configure(this);
        gen_ctrl.set_coverage(UVM_CVR_FIELD_VALS);

        // GEN_PKT_CFG - 0x30
        gen_pkt_cfg = GEN_PKT_CFG::type_id::create("gen_pkt_cfg");
        gen_pkt_cfg.build();
        gen_pkt_cfg.configure(this);
        gen_pkt_cfg.set_coverage(UVM_CVR_FIELD_VALS);

        // GEN_INTERVAL - 0x34
        gen_interval = GEN_INTERVAL::type_id::create("gen_interval");
        gen_interval.build();
        gen_interval.configure(this);
        gen_interval.set_coverage(UVM_CVR_FIELD_VALS);

        // GEN_COUNT - 0x38
        gen_count = GEN_COUNT::type_id::create("gen_count");
        gen_count.build();
        gen_count.configure(this);
        gen_count.set_coverage(UVM_CVR_FIELD_VALS);

        // IRQ_STATUS - 0x3C
        irq_status = IRQ_STATUS::type_id::create("irq_status");
        irq_status.build();
        irq_status.configure(this);
        irq_status.set_coverage(UVM_CVR_FIELD_VALS);

        // IRQ_ENABLE - 0x40
        irq_enable = IRQ_ENABLE::type_id::create("irq_enable");
        irq_enable.build();
        irq_enable.configure(this);
        irq_enable.set_coverage(UVM_CVR_FIELD_VALS);

        // IRQ_FORCE - 0x44
        irq_force = IRQ_FORCE::type_id::create("irq_force");
        irq_force.build();
        irq_force.configure(this);
        irq_force.set_coverage(UVM_CVR_FIELD_VALS);

        // ERR_STATUS - 0x48
        err_status = ERR_STATUS::type_id::create("err_status");
        err_status.build();
        err_status.configure(this);
        err_status.set_coverage(UVM_CVR_FIELD_VALS);

        // ERR_ENABLE - 0x4C
        err_enable = ERR_ENABLE::type_id::create("err_enable");
        err_enable.build();
        err_enable.configure(this);
        err_enable.set_coverage(UVM_CVR_FIELD_VALS);

        // ERR_INJECT - 0x50
        err_inject = ERR_INJECT::type_id::create("err_inject");
        err_inject.build();
        err_inject.configure(this);
        err_inject.set_coverage(UVM_CVR_FIELD_VALS);

        // ERR_COUNT - 0x54
        err_count = ERR_COUNT::type_id::create("err_count");
        err_count.build();
        err_count.configure(this);
        err_count.set_coverage(UVM_CVR_FIELD_VALS);


        // ERR_INFO - 0x58
        err_info = ERR_INFO::type_id::create("err_info");
        err_info.build();
        err_info.configure(this);
        err_info.set_coverage(UVM_CVR_FIELD_VALS);

        // LOCK - 0x5C
        lock = LOCK::type_id::create("lock");
        lock.build();
        lock.configure(this);
        lock.set_coverage(UVM_CVR_FIELD_VALS);

        // SOFT_RESET - 0x60
        soft_reset = SOFT_RESET::type_id::create("soft_reset");
        soft_reset.build();
        soft_reset.configure(this);
        soft_reset.set_coverage(UVM_CVR_FIELD_VALS);

        switch_status.add_hdl_path_slice("switch_status_r", 0, 32);
        port_status.add_hdl_path_slice("port_status_r", 0, 32);
        gen_status.add_hdl_path_slice("gen_status_r", 0, 32);
        stat_rx.add_hdl_path_slice("stat_rx", 0, 16);
        stat_tx.add_hdl_path_slice("stat_tx", 0, 16);
        stat_drop.add_hdl_path_slice("stat_drop", 0, 16);
        switch_ctrl.add_hdl_path_slice("switch_ctrl_q", 0, 32);
        port_enable.add_hdl_path_slice("port_enable_q", 0, 4);
        fwd_enable.add_hdl_path_slice("fwd_enable_q", 0, 4);
        gen_ctrl.add_hdl_path_slice("gen_ctrl_q", 0, 32,);
        gen_pkt_cfg.add_hdl_path_slice("gen_pkt_cfg_q", 0, 32);
        gen_interval.add_hdl_path_slice("gen_interval_q", 0, 32);
        gen_count.add_hdl_path_slice("gen_count_q", 0, 32);
        irq_status.add_hdl_path_slice( "irq_status_q", 0, 8);
        irq_enable.add_hdl_path_slice("irq_enable_q", 0, 8);
        irq_force.add_hdl_path_slice("irq_force_w", 0, 8);
        err_enable.add_hdl_path_slice("err_enable_q", 0, 8);
        err_count.add_hdl_path_slice("err_count_q", 0, 16);
        err_info.add_hdl_path_slice("err_info_q", 0, 32);
        lock.add_hdl_path_slice("locked", 0, 1);

        default_map = create_map("default_map",'h0, 4,UVM_LITTLE_ENDIAN);

        default_map.add_reg(device_id, 32'h00, "RW");
        default_map.add_reg(version, 32'h04, "RW");
        default_map.add_reg(switch_status, 32'h08, "RW");
        default_map.add_reg(port_status, 32'h0C, "RW");
        default_map.add_reg(gen_status, 32'h10, "RW");
        default_map.add_reg(stat_rx, 32'h14, "RW");
        default_map.add_reg(stat_tx, 32'h18, "RW");
        default_map.add_reg(stat_drop, 32'h1C, "RW");
        default_map.add_reg(switch_ctrl, 32'h20, "RW");
        default_map.add_reg(port_enable, 32'h24, "RW");
        default_map.add_reg(fwd_enable, 32'h28, "RW");
        default_map.add_reg(gen_ctrl, 32'h2C, "RW");
        default_map.add_reg(gen_pkt_cfg, 32'h30, "RW");
        default_map.add_reg(gen_interval, 32'h34, "RW");
        default_map.add_reg(gen_count, 32'h38, "RW");
        default_map.add_reg(irq_status, 32'h3C, "RW");
        default_map.add_reg(irq_enable, 32'h40, "RW");
        default_map.add_reg(irq_force, 32'h44, "RW");
        default_map.add_reg(err_status, 32'h48, "RW");
        default_map.add_reg(err_enable, 32'h4C, "RW");
        default_map.add_reg(err_inject, 32'h50, "RW");
        default_map.add_reg(err_count, 32'h54, "RW");
        default_map.add_reg(err_info, 32'h58, "RW");
        default_map.add_reg(lock, 32'h5C, "RW");
        default_map.add_reg(soft_reset, 32'h60, "RW");
        lock_model();

    endfunction

endclass
