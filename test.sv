class test extends uvm_test;

        `uvm_component_utils(test)

        env e;
        top_reg_seq seq;

        function new(string name = "test", uvm_component parent);
                super.new(name,parent);
        endfunction

        virtual function void build_phase(uvm_phase phase);
                super.build_phase(phase);
                e = env::type_id::create("e",this);
                seq = top_reg_seq::type_id::create("seq");
        endfunction

        virtual task run_phase(uvm_phase phase);
                phase.raise_objection(this);
                        seq.regmodel = e.regmodel;
                        seq.start(e.ag.seqr);
                        phase.phase_done.set_drain_time(this, 20);
                        phase.drop_objection(this);
        endtask

        function void end_of_elaboration_phase(uvm_phase phase);
                super.end_of_elaboration_phase(phase);
                uvm_top.set_timeout(100000, 0);
        endfunction

endclass


//all_reg_reset_test
class all_reg_reset_test extends test;

                `uvm_component_utils(all_reg_reset_test)

        all_reg_reset_seq seq;

                function new(string name = "all_reg_reset_test", uvm_component parent);
                super.new(name,parent);
        endfunction

        virtual function void build_phase(uvm_phase phase);
                super.build_phase(phase);
                seq = all_reg_reset_seq::type_id::create("seq");
        endfunction

        virtual task run_phase(uvm_phase phase);
                        phase.raise_objection(this);
                        seq.regmodel = e.regmodel;
                        seq.start(e.ag.seqr);
                        phase.phase_done.set_drain_time(this, 20);
                        phase.drop_objection(this);
        endtask

endclass


//gen_four_packets_test- in spec
class gen_four_packets_test extends test;

                `uvm_component_utils(gen_four_packets_test)

        gen_four_packets_seq seq;

                function new(string name = "gen_four_packets_test", uvm_component parent);
                super.new(name,parent);
        endfunction

        virtual function void build_phase(uvm_phase phase);
                super.build_phase(phase);
                seq = gen_four_packets_seq::type_id::create("seq");
        endfunction

        virtual task run_phase(uvm_phase phase);
                        phase.raise_objection(this);
                        seq.regmodel = e.regmodel;
                        seq.start(e.ag.seqr);
                        phase.phase_done.set_drain_time(this, 20);
                        phase.drop_objection(this);
        endtask

endclass



//clear_sticky_status_test
class clear_sticky_status_test extends test;

       `uvm_component_utils(clear_sticky_status_test)

        clear_sticky_status_seq seq;

        function new(string name = "clear_sticky_status_test", uvm_component parent);
                super.new(name,parent);
        endfunction

        virtual function void build_phase(uvm_phase phase);
                super.build_phase(phase);
                seq = clear_sticky_status_seq::type_id::create("seq");
        endfunction

        virtual task run_phase(uvm_phase phase);
                        phase.raise_objection(this);
                        seq.regmodel = e.regmodel;
                        seq.start(e.ag.seqr);
                        phase.phase_done.set_drain_time(this, 20);
                        phase.drop_objection(this);
        endtask

endclass

class dest_drop_test extends test;

       `uvm_component_utils(dest_drop_test)

        dest_drop_seq seq;

        function new(string name = "dest_drop_test", uvm_component parent);
                super.new(name,parent);
        endfunction

        virtual function void build_phase(uvm_phase phase);
                super.build_phase(phase);
                seq = dest_drop_seq::type_id::create("seq");
        endfunction

        virtual task run_phase(uvm_phase phase);
                        phase.raise_objection(this);
                        seq.regmodel = e.regmodel;
                        seq.start(e.ag.seqr);
                        phase.phase_done.set_drain_time(this, 20);
                        phase.drop_objection(this);
        endtask

endclass

//apply_reset_test
class apply_reset_test extends test;

       `uvm_component_utils(apply_reset_test)

        apply_reset_seq seq;

        function new(string name = "apply_reset_test", uvm_component parent);
                super.new(name,parent);
        endfunction

        virtual function void build_phase(uvm_phase phase);
                super.build_phase(phase);
                seq = apply_reset_seq::type_id::create("seq");
        endfunction

        virtual task run_phase(uvm_phase phase);
                        phase.raise_objection(this);
                        seq.regmodel = e.regmodel;
                        seq.start(e.ag.seqr);
                        phase.phase_done.set_drain_time(this, 20);
                        phase.drop_objection(this);
        endtask

endclass


//DEVICE_ID
class device_id_test extends test;

        `uvm_component_utils(device_id_test)

        device_id_seq seq;

        function new(string name = "idevice_id_test", uvm_component parent);
                super.new(name,parent);
        endfunction

        virtual function void build_phase(uvm_phase phase);
                super.build_phase(phase);
                seq = device_id_seq::type_id::create("seq");
        endfunction

        virtual task run_phase(uvm_phase phase);
                        phase.raise_objection(this);
                        seq.regmodel = e.regmodel;
                        seq.start(e.ag.seqr);
                        phase.phase_done.set_drain_time(this, 20);
                        phase.drop_objection(this);
        endtask

endclass

//VERSION
class version_test extends test;

  `uvm_component_utils(version_test)

        version_seq seq;

                function new(string name = "version_test", uvm_component parent);
                super.new(name,parent);
        endfunction

        virtual function void build_phase(uvm_phase phase);
                super.build_phase(phase);
                seq = version_seq::type_id::create("seq");
        endfunction

        virtual task run_phase(uvm_phase phase);
                        phase.raise_objection(this);
                        seq.regmodel = e.regmodel;
                        seq.start(e.ag.seqr);
                        phase.phase_done.set_drain_time(this, 20);
                        phase.drop_objection(this);
        endtask

endclass



//SWITCH_STATUS
class switch_status_test extends test;

  `uvm_component_utils(switch_status_test)

        switch_status_seq seq;

        function new(string name = "switch_status_test", uvm_component parent);
                super.new(name,parent);
        endfunction

        virtual function void build_phase(uvm_phase phase);
                super.build_phase(phase);
                seq = switch_status_seq::type_id::create("seq");
        endfunction

        virtual task run_phase(uvm_phase phase);
                        phase.raise_objection(this);
                        seq.regmodel = e.regmodel;
                        seq.start(e.ag.seqr);
                        phase.phase_done.set_drain_time(this, 20);
                        phase.drop_objection(this);
        endtask

endclass

//PORT_STATUS
class port_status_test extends test;

       `uvm_component_utils(port_status_test)

        port_status_seq seq;

        function new(string name = "port_status_test", uvm_component parent);
                super.new(name,parent);
        endfunction

        virtual function void build_phase(uvm_phase phase);
                super.build_phase(phase);
                seq = port_status_seq::type_id::create("seq");
        endfunction

        virtual task run_phase(uvm_phase phase);
                        phase.raise_objection(this);
                        seq.regmodel = e.regmodel;
                        seq.start(e.ag.seqr);
                        phase.phase_done.set_drain_time(this, 20);
                        phase.drop_objection(this);
        endtask

endclass


//GEN_STATUS
class gen_status_test extends test;

       `uvm_component_utils(gen_status_test)

        gen_status_seq seq;

        function new(string name = "gen_status_test", uvm_component parent);
                super.new(name,parent);
        endfunction

        virtual function void build_phase(uvm_phase phase);
                super.build_phase(phase);
                seq = gen_status_seq::type_id::create("seq");
        endfunction

        virtual task run_phase(uvm_phase phase);
                        phase.raise_objection(this);
                        seq.regmodel = e.regmodel;
                        seq.start(e.ag.seqr);
                        phase.phase_done.set_drain_time(this, 20);
                        phase.drop_objection(this);
        endtask

endclass

//STAT_RX
class stat_rx_test extends test;

       `uvm_component_utils(stat_rx_test)

        stat_rx_seq seq;

        function new(string name = "stat_rx_test", uvm_component parent);
                super.new(name,parent);
        endfunction

        virtual function void build_phase(uvm_phase phase);
                super.build_phase(phase);
                seq = stat_rx_seq::type_id::create("seq");
        endfunction

        virtual task run_phase(uvm_phase phase);
                        phase.raise_objection(this);
                        seq.regmodel = e.regmodel;
                        seq.start(e.ag.seqr);
                        phase.phase_done.set_drain_time(this, 20);
                        phase.drop_objection(this);
        endtask

endclass


//STAT_TX
class stat_tx_test extends test;

                `uvm_component_utils(stat_tx_test)

        stat_tx_seq seq;

                function new(string name = "stat_tx_test", uvm_component parent);
                super.new(name,parent);
        endfunction

        virtual function void build_phase(uvm_phase phase);
                super.build_phase(phase);
                seq = stat_tx_seq::type_id::create("seq");
        endfunction

        virtual task run_phase(uvm_phase phase);
                        phase.raise_objection(this);
                        seq.regmodel = e.regmodel;
                        seq.start(e.ag.seqr);
                        phase.phase_done.set_drain_time(this, 20);
                        phase.drop_objection(this);
        endtask

endclass


//STAT_DROP
class stat_drop_test extends test;

                `uvm_component_utils(stat_drop_test)

        stat_drop_seq seq;

                function new(string name = "stat_drop_test", uvm_component parent);
                super.new(name,parent);
        endfunction

        virtual function void build_phase(uvm_phase phase);
                super.build_phase(phase);
                seq = stat_drop_seq::type_id::create("seq");
        endfunction

        virtual task run_phase(uvm_phase phase);
                        phase.raise_objection(this);
                        seq.regmodel = e.regmodel;
                        seq.start(e.ag.seqr);
                        phase.phase_done.set_drain_time(this, 20);
                        phase.drop_objection(this);
        endtask

endclass


//SWITCH_CTRL
class switch_ctrl_test extends test;

                `uvm_component_utils(switch_ctrl_test)

        switch_ctrl_seq seq;

                function new(string name = "switch_ctrl_test", uvm_component parent);
                super.new(name,parent);
        endfunction

        virtual function void build_phase(uvm_phase phase);
                super.build_phase(phase);
                seq = switch_ctrl_seq::type_id::create("seq");
        endfunction

        virtual task run_phase(uvm_phase phase);
                        phase.raise_objection(this);
                        seq.regmodel = e.regmodel;
                        seq.start(e.ag.seqr);
                        phase.phase_done.set_drain_time(this, 20);
                        phase.drop_objection(this);
        endtask

endclass


//PORT_ENABLE
class port_enable_test extends test;

                `uvm_component_utils(port_enable_test)

        port_enable_seq seq;

                function new(string name = "port_enable_test", uvm_component parent);
                super.new(name,parent);
        endfunction

        virtual function void build_phase(uvm_phase phase);
                super.build_phase(phase);
                seq = port_enable_seq::type_id::create("seq");
        endfunction

        virtual task run_phase(uvm_phase phase);
                        phase.raise_objection(this);
                        seq.regmodel = e.regmodel;
                        seq.start(e.ag.seqr);
                        phase.phase_done.set_drain_time(this, 20);
                        phase.drop_objection(this);
        endtask

endclass



//FWD_ENABLE
class fwd_enable_test extends test;

                `uvm_component_utils(fwd_enable_test)

        fwd_enable_seq seq;

                function new(string name = "fwd_enable_test", uvm_component parent);
                super.new(name,parent);
        endfunction

        virtual function void build_phase(uvm_phase phase);
                super.build_phase(phase);
                seq = fwd_enable_seq::type_id::create("seq");
        endfunction

        virtual task run_phase(uvm_phase phase);
                        phase.raise_objection(this);
                        seq.regmodel = e.regmodel;
                        seq.start(e.ag.seqr);
                        phase.phase_done.set_drain_time(this, 20);
                        phase.drop_objection(this);
        endtask

endclass


//GEN_CTRL
class gen_ctrl_test extends test;

                `uvm_component_utils(gen_ctrl_test)

        gen_ctrl_seq seq;

                function new(string name = "gen_ctrl_test", uvm_component parent);
                super.new(name,parent);
        endfunction

        virtual function void build_phase(uvm_phase phase);
                super.build_phase(phase);
                seq = gen_ctrl_seq::type_id::create("seq");
        endfunction

        virtual task run_phase(uvm_phase phase);
                        phase.raise_objection(this);
                        seq.regmodel = e.regmodel;
                        seq.start(e.ag.seqr);
                        phase.phase_done.set_drain_time(this, 20);
                        phase.drop_objection(this);
        endtask

endclass


//GEN_PKT_CFG
class gen_pkt_cfg_test extends test;

                `uvm_component_utils(gen_pkt_cfg_test)

        gen_pkt_cfg_seq seq;

                function new(string name = "gen_pkt_cfg_test", uvm_component parent);
                super.new(name,parent);
        endfunction

        virtual function void build_phase(uvm_phase phase);
                super.build_phase(phase);
                seq = gen_pkt_cfg_seq::type_id::create("seq");
        endfunction

        virtual task run_phase(uvm_phase phase);
                        phase.raise_objection(this);
                        seq.regmodel = e.regmodel;
                        seq.start(e.ag.seqr);
                        phase.phase_done.set_drain_time(this, 20);
                        phase.drop_objection(this);
        endtask

endclass


//GEN_INTERVAL
class gen_interval_test extends test;

  `uvm_component_utils(gen_interval_test)

        gen_interval_seq seq;

                function new(string name = "gen_pkt_cfg_test", uvm_component parent);
                super.new(name,parent);
        endfunction

        virtual function void build_phase(uvm_phase phase);
                super.build_phase(phase);
                seq = gen_interval_seq::type_id::create("seq");
        endfunction

        virtual task run_phase(uvm_phase phase);
                        phase.raise_objection(this);
                        seq.regmodel = e.regmodel;
                        seq.start(e.ag.seqr);
                        phase.phase_done.set_drain_time(this, 20);
                        phase.drop_objection(this);
        endtask

endclass


//GEN_COUNT
class gen_count_test extends test;

        `uvm_component_utils(gen_count_test)

        gen_count_seq seq;

                function new(string name = "gen_count_test", uvm_component parent);
                super.new(name,parent);
        endfunction

        virtual function void build_phase(uvm_phase phase);
                super.build_phase(phase);
                seq = gen_count_seq::type_id::create("seq");
        endfunction

        virtual task run_phase(uvm_phase phase);
                        phase.raise_objection(this);
                        seq.regmodel = e.regmodel;
                        seq.start(e.ag.seqr);
                        phase.phase_done.set_drain_time(this, 20);
                        phase.drop_objection(this);
        endtask

endclass



//IRQ_STATUS
class irq_status_test extends test;

        `uvm_component_utils(irq_status_test)

        irq_status_seq seq;

        function new(string name = "irq_status_test", uvm_component parent);
                super.new(name,parent);
        endfunction

        virtual function void build_phase(uvm_phase phase);
                super.build_phase(phase);
                seq = irq_status_seq::type_id::create("seq");
        endfunction

        virtual task run_phase(uvm_phase phase);
                        phase.raise_objection(this);
                        seq.regmodel = e.regmodel;
                        seq.start(e.ag.seqr);
                        phase.phase_done.set_drain_time(this, 20);
                        phase.drop_objection(this);
        endtask

endclass


//IRQ_ENABLE
class irq_enable_test extends test;

        `uvm_component_utils(irq_enable_test)

        irq_enable_seq seq;

        function new(string name = "irq_enable_test", uvm_component parent);
                super.new(name,parent);
        endfunction

        virtual function void build_phase(uvm_phase phase);
                super.build_phase(phase);
                seq = irq_enable_seq::type_id::create("seq");
        endfunction

        virtual task run_phase(uvm_phase phase);
                        phase.raise_objection(this);
                        seq.regmodel = e.regmodel;
                        seq.start(e.ag.seqr);
                        phase.phase_done.set_drain_time(this, 20);
                        phase.drop_objection(this);
        endtask

endclass


//IRQ_ENABLE
class irq_force_test extends test;

                `uvm_component_utils(irq_force_test)

        irq_force_seq seq;

                function new(string name = "irq_force_test", uvm_component parent);
                super.new(name,parent);
        endfunction

        virtual function void build_phase(uvm_phase phase);
                super.build_phase(phase);
                seq = irq_force_seq::type_id::create("seq");
        endfunction

        virtual task run_phase(uvm_phase phase);
                        phase.raise_objection(this);
                        seq.regmodel = e.regmodel;
                        seq.start(e.ag.seqr);
                        phase.phase_done.set_drain_time(this, 20);
                        phase.drop_objection(this);
        endtask

endclass


//ERR_STATUS
class err_status_test extends test;

                `uvm_component_utils(err_status_test)

        err_status_seq seq;

                function new(string name = "err_status_test", uvm_component parent);
                super.new(name,parent);
        endfunction

        virtual function void build_phase(uvm_phase phase);
                super.build_phase(phase);
                seq = err_status_seq::type_id::create("seq");
        endfunction

        virtual task run_phase(uvm_phase phase);
                        phase.raise_objection(this);
                        seq.regmodel = e.regmodel;
                        seq.start(e.ag.seqr);
                        phase.phase_done.set_drain_time(this, 20);
                        phase.drop_objection(this);
        endtask

endclass


//ERR_ENABLE(0x4C)
class err_enable_test extends test;

                `uvm_component_utils(err_enable_test)

        err_enable_seq seq;

                function new(string name = "err_enable_test", uvm_component parent);
                super.new(name,parent);
        endfunction

        virtual function void build_phase(uvm_phase phase);
                super.build_phase(phase);
                seq = err_enable_seq::type_id::create("seq");
        endfunction

        virtual task run_phase(uvm_phase phase);
                        phase.raise_objection(this);
                        seq.regmodel = e.regmodel;
                        seq.start(e.ag.seqr);
                        phase.phase_done.set_drain_time(this, 20);
                        phase.drop_objection(this);
        endtask

endclass

//ERR_INJECT(0x4C)
class err_inject_test extends test;

                `uvm_component_utils(err_inject_test)

        err_inject_seq seq;

                function new(string name = "err_inject_test", uvm_component parent);
                super.new(name,parent);
        endfunction

        virtual function void build_phase(uvm_phase phase);
                super.build_phase(phase);
                seq = err_inject_seq::type_id::create("seq");
        endfunction

        virtual task run_phase(uvm_phase phase);
                        phase.raise_objection(this);
                        seq.regmodel = e.regmodel;
                        seq.start(e.ag.seqr);
                        phase.phase_done.set_drain_time(this, 20);
                        phase.drop_objection(this);
        endtask

endclass


//ERR_INJECT(0x54)
class err_count_test extends test;

                `uvm_component_utils(err_count_test)

        err_count_seq seq;

                function new(string name = "err_count_test", uvm_component parent);
                super.new(name,parent);
        endfunction

        virtual function void build_phase(uvm_phase phase);
                super.build_phase(phase);
                seq = err_count_seq::type_id::create("seq");
        endfunction

        virtual task run_phase(uvm_phase phase);
                        phase.raise_objection(this);
                        seq.regmodel = e.regmodel;
                        seq.start(e.ag.seqr);
                        phase.phase_done.set_drain_time(this, 20);
                        phase.drop_objection(this);
        endtask

endclass



//ERR_INFO(0x54)
class err_info_test extends test;

                `uvm_component_utils(err_info_test)

        err_info_seq seq;

                function new(string name = "err_count_test", uvm_component parent);
                super.new(name,parent);
        endfunction

        virtual function void build_phase(uvm_phase phase);
                super.build_phase(phase);
                seq = err_info_seq::type_id::create("seq");
        endfunction

        virtual task run_phase(uvm_phase phase);
                        phase.raise_objection(this);
                        seq.regmodel = e.regmodel;
                        seq.start(e.ag.seqr);
                        phase.phase_done.set_drain_time(this, 20);
                        phase.drop_objection(this);
        endtask

endclass


//lock(0x5c)
class lock_test extends test;

                `uvm_component_utils(lock_test)

        lock_seq seq;

                function new(string name = "lock_test", uvm_component parent);
                super.new(name,parent);
        endfunction

        virtual function void build_phase(uvm_phase phase);
                super.build_phase(phase);
                seq = lock_seq::type_id::create("seq");
        endfunction

        virtual task run_phase(uvm_phase phase);
                        phase.raise_objection(this);
                        seq.regmodel = e.regmodel;
                        seq.start(e.ag.seqr);
                        phase.phase_done.set_drain_time(this, 20);
                        phase.drop_objection(this);
        endtask

endclass


//soft_reset(0x60)
class soft_reset_test extends test;

                `uvm_component_utils(soft_reset_test)

        soft_reset_seq seq;

                function new(string name = "soft_reset_test", uvm_component parent);
                super.new(name,parent);
        endfunction

        virtual function void build_phase(uvm_phase phase);
                super.build_phase(phase);
                seq = soft_reset_seq::type_id::create("seq");
        endfunction

        virtual task run_phase(uvm_phase phase);
                        phase.raise_objection(this);
                        seq.regmodel = e.regmodel;
                        seq.start(e.ag.seqr);
                        phase.phase_done.set_drain_time(this, 20);
                        phase.drop_objection(this);
        endtask

endclass


//regression test

class all_reg_regression_test extends test;
    `uvm_component_utils(all_reg_regression_test)

    function new(string name = "all_reg_regression_test",uvm_component parent );
        super.new(name, parent);
    endfunction

    task run_phase(uvm_phase phase);

        all_reg_regression_seq seq;

        phase.raise_objection(this);

        seq = all_reg_regression_seq::type_id::create("seq");
        seq.regmodel = e.regmodel;
        seq.start(e.ag.seqr);

        phase.drop_objection(this);

    endtask
endclass
