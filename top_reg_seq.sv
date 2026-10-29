`include "define.svh"
class top_reg_seq extends uvm_sequence;
        `uvm_object_utils(top_reg_seq)

        top_reg_block regmodel;

        function new(string name = "top_reg_seq");
                super.new(name);
        endfunction

        task body();
                // this base sequence does nothing
                if (regmodel == null)
                        `uvm_fatal("NO_REGMODEL", "regmodel not assigned")

                `uvm_info(get_type_name(), "Base RAL sequence started (no register access)", UVM_LOW)
        endtask

        // Common methods
        task do_write(uvm_reg r, uvm_reg_data_t data);
                uvm_status_e status;
                r.write(.status(status), .value(data), .parent(this));
                if (status != UVM_IS_OK)
                        `uvm_error("RAL", "Write failed")
        endtask

        task do_read(uvm_reg r, output uvm_reg_data_t data);
                uvm_status_e status;
                r.read(.status(status), .value(data), .parent(this));
                if (status != UVM_IS_OK)
                        `uvm_error("RAL", "Read failed")
        endtask

endclass



// Check reset/read values of all 25 registers
class all_reg_reset_seq extends top_reg_seq;
    `uvm_object_utils(all_reg_reset_seq)

    function new(string name = "all_reg_reset_seq");
        super.new(name);
    endfunction

    task body();

        uvm_reg_data_t rdata;

        if (regmodel == null)
            `uvm_fatal("NO_REGMODEL", "regmodel not assigned")

        `uvm_info(get_type_name(),"========== ALL REGISTER RESET CHECK START ==========", UVM_LOW)

        // 1. DEVICE_ID - 0x00
        do_read(regmodel.device_id, rdata);
        if (rdata !== 32'h02A5_5357)
            `uvm_error("RESET", $sformatf("DEVICE_ID | Expected=02A55357 Got=%08h", rdata))

        // 2. VERSION - 0x04
        do_read(regmodel.version, rdata);
        if (rdata !== 32'h0001_0200)
            `uvm_error("RESET", $sformatf("VERSION | Expected=00010200 Got=%08h", rdata))

        // 3. SWITCH_STATUS - 0x08
        do_read(regmodel.switch_status, rdata);
        if (rdata !== 32'h0000_00F9)
            `uvm_error("RESET", $sformatf("SWITCH_STATUS | Expected=000000F9 Got=%08h", rdata))

        // 4. PORT_STATUS - 0x0C
        do_read(regmodel.port_status, rdata);
        if (rdata !== 32'h0000_0000)
            `uvm_error("RESET", $sformatf("PORT_STATUS | Expected=00000000 Got=%08h", rdata))

        // 5. GEN_STATUS - 0x10
        do_read(regmodel.gen_status, rdata);
        if (rdata !== 32'h0000_0000)
            `uvm_error("RESET", $sformatf("GEN_STATUS | Expected=00000000 Got=%08h", rdata))

        // 6. STAT_RX - 0x14
        do_read(regmodel.stat_rx, rdata);
        if (rdata !== 32'h0000_0000)
            `uvm_error("RESET", $sformatf("STAT_RX | Expected=00000000 Got=%08h", rdata))

        // 7. STAT_TX - 0x18
        do_read(regmodel.stat_tx, rdata);
        if (rdata !== 32'h0000_0000)
            `uvm_error("RESET", $sformatf("STAT_TX | Expected=00000000 Got=%08h", rdata))

        // 8. STAT_DROP - 0x1C
        do_read(regmodel.stat_drop, rdata);
        if (rdata !== 32'h0000_0000)
            `uvm_error("RESET", $sformatf("STAT_DROP | Expected=00000000 Got=%08h", rdata))

        // 9. SWITCH_CTRL - 0x20
        do_read(regmodel.switch_ctrl, rdata);
        if (rdata !== 32'h0000_0000)
            `uvm_error("RESET", $sformatf("SWITCH_CTRL | Expected=00000000 Got=%08h", rdata))

        // 10. PORT_ENABLE - 0x24
        do_read(regmodel.port_enable, rdata);
        if (rdata !== 32'h0000_000F)
            `uvm_error("RESET", $sformatf("PORT_ENABLE | Expected=0000000F Got=%08h", rdata))

        // 11. FWD_ENABLE - 0x28
        do_read(regmodel.fwd_enable, rdata);
        if (rdata !== 32'h0000_000F)
            `uvm_error("RESET", $sformatf("FWD_ENABLE | Expected=0000000F Got=%08h", rdata))

        // 12. GEN_CTRL - 0x2C
        do_read(regmodel.gen_ctrl, rdata);
        if (rdata !== 32'h0000_0000)
            `uvm_error("RESET", $sformatf("GEN_CTRL | Expected=00000000 Got=%08h", rdata))

        // 13. GEN_PKT_CFG - 0x30
        do_read(regmodel.gen_pkt_cfg, rdata);
        if (rdata !== 32'h0000_0401)
            `uvm_error("RESET", $sformatf("GEN_PKT_CFG | Expected=00000401 Got=%08h", rdata))

        // 14. GEN_INTERVAL - 0x34
        do_read(regmodel.gen_interval, rdata);
        if (rdata !== 32'h0000_0002)
            `uvm_error("RESET", $sformatf("GEN_INTERVAL | Expected=00000002 Got=%08h", rdata))

        // 15. GEN_COUNT - 0x38
        do_read(regmodel.gen_count, rdata);
        if (rdata !== 32'h0000_0004)
            `uvm_error("RESET", $sformatf("GEN_COUNT | Expected=00000004 Got=%08h", rdata))

        // 16. IRQ_STATUS - 0x3C
        do_read(regmodel.irq_status, rdata);
        if (rdata !== 32'h0000_0000)
            `uvm_error("RESET", $sformatf("IRQ_STATUS | Expected=00000000 Got=%08h", rdata))

        // 17. IRQ_ENABLE - 0x40
        do_read(regmodel.irq_enable, rdata);
        if (rdata !== 32'h0000_0000)
            `uvm_error("RESET", $sformatf("IRQ_ENABLE | Expected=00000000 Got=%08h", rdata))

        // 18. IRQ_FORCE - 0x44
        do_read(regmodel.irq_force, rdata);
        if (rdata !== 32'h0000_0000)
            `uvm_error("RESET", $sformatf("IRQ_FORCE | Expected=00000000 Got=%08h", rdata))

        // 19. ERR_STATUS - 0x48
        do_read(regmodel.err_status, rdata);
        if (rdata !== 32'h0000_0000)
            `uvm_error("RESET", $sformatf("ERR_STATUS | Expected=00000000 Got=%08h", rdata))

        // 20. ERR_ENABLE - 0x4C
        do_read(regmodel.err_enable, rdata);
        if (rdata !== 32'h0000_0000)
            `uvm_error("RESET", $sformatf("ERR_ENABLE | Expected=00000000 Got=%08h", rdata))

        // 21. ERR_INJECT - 0x50 (write-only, reads zero)
        do_read(regmodel.err_inject, rdata);
        if (rdata !== 32'h0000_0000)
            `uvm_error("RESET", $sformatf("ERR_INJECT | Expected=00000000 Got=%08h", rdata))

        // 22. ERR_COUNT - 0x54
        do_read(regmodel.err_count, rdata);
        if (rdata !== 32'h0000_0000)
            `uvm_error("RESET", $sformatf("ERR_COUNT | Expected=00000000 Got=%08h", rdata))

        // 23. ERR_INFO - 0x58
        do_read(regmodel.err_info, rdata);
        if (rdata !== 32'h0000_0000)
            `uvm_error("RESET", $sformatf("ERR_INFO | Expected=00000000 Got=%08h", rdata))

        // 24. LOCK - 0x5C
        do_read(regmodel.lock, rdata);
        if (rdata !== 32'h0000_0001)
            `uvm_error("RESET", $sformatf("LOCK | Expected=00000001 Got=%08h", rdata))

        // 25. SOFT_RESET - 0x60 (write-only, reads zero)
        do_read(regmodel.soft_reset, rdata);
        if (rdata !== 32'h0000_0000)
            `uvm_error("RESET", $sformatf("SOFT_RESET | Expected=00000000 Got=%08h", rdata))

        `uvm_info(get_type_name(),"========== ALL REGISTER RESET CHECK END ==========", UVM_LOW)

    endtask
endclass



 // Generate four packets from source 0 to destination 1
class gen_four_packets_seq extends top_reg_seq;
        `uvm_object_utils(gen_four_packets_seq)

        function new(string name = "gen_four_packets_seq");
                super.new(name);
        endfunction

        task body();

                uvm_reg_data_t rdata;

                if (regmodel == null)
                `uvm_fatal("NO_REGMODEL", "regmodel not assigned")

                `uvm_info(get_type_name(),"========== GENERATE FOUR PACKETS START ==========", UVM_LOW)

                do_write(regmodel.lock, 32'hA5A5_C3C3);
            do_write(regmodel.port_enable, 32'h0000_000F);
            do_write(regmodel.fwd_enable, 32'h0000_000F);
                do_write(regmodel.switch_ctrl, 32'h0000_0009);
                do_write(regmodel.gen_pkt_cfg, 32'h0010_0401);
                do_write(regmodel.gen_interval, 32'h0000_0002);
                do_write(regmodel.gen_count, 32'h0000_0004);
                do_write(regmodel.irq_enable, 32'h0000_0041);
                do_write(regmodel.gen_ctrl, 32'h0000_0003);

                `uvm_info("GEN_PKT","Generator configured and START written", UVM_LOW)

                // wait
                repeat (100) begin
                        do_read(regmodel.gen_status, rdata);
                        if (rdata[1] === 1'b1)
                                break;
                        end

                `uvm_info("GEN_PKT", "GEN_STATUS.DONE CHECK PASS", UVM_LOW)

                do_read(regmodel.stat_rx, rdata);

                if (rdata !== 32'h0000_0004)
                `uvm_error("GEN_PKT",$sformatf("STAT_RX ERROR | Expected=4 Got=%0d", rdata))
                else
                `uvm_info("GEN_PKT", "STAT_RX CHECK PASS", UVM_LOW)

                do_read(regmodel.stat_tx, rdata);

                if (rdata !== 32'h0000_0004)
                `uvm_error("GEN_PKT",$sformatf("STAT_TX ERROR | Expected=4 Got=%0d", rdata))
                else
                `uvm_info("GEN_PKT", "STAT_TX CHECK PASS", UVM_LOW)

                do_read(regmodel.stat_drop, rdata);

                if (rdata !== 32'h0000_0000)
                `uvm_error("GEN_PKT",$sformatf("STAT_DROP ERROR | Expected=0 Got=%0d", rdata))
                else
                `uvm_info("GEN_PKT", "STAT_DROP CHECK PASS", UVM_LOW)

                do_read(regmodel.irq_status, rdata);

                if (rdata[0] !== 1'b1)
                        `uvm_error("GEN_PKT", "IRQ_STATUS.GEN_DONE CHECK FAILED")
                else
                        `uvm_info("GEN_PKT", "IRQ_STATUS.GEN_DONE CHECK PASS", UVM_LOW)

                `uvm_info(get_type_name(),"========== GENERATE FOUR PACKETS END ==========",UVM_LOW)

        endtask
endclass

class clear_sticky_status_seq extends top_reg_seq;
        `uvm_object_utils(clear_sticky_status_seq)

        function new(string name = "clear_sticky_status_seq");
        super.new(name);
        endfunction

        task body();
        uvm_reg_data_t rdata;

        if (regmodel == null)
                `uvm_fatal("NO_REGMODEL", "regmodel not assigned")

        `uvm_info(get_type_name(),"========== CLEAR STICKY STATUS START ==========",UVM_LOW)

        //  1: Clear GEN_DONE (bit 0) and START_ACK (bit 6)
        do_write(regmodel.irq_status, 32'h0000_0041);
        do_read(regmodel.irq_status, rdata);

        if ((rdata & 32'h0000_0041) == 0)
                `uvm_info("IRQ_CLEAR","GEN_DONE and START_ACK cleared successfully",UVM_LOW)
        else
                `uvm_error("IRQ_CLEAR",$sformatf("Failed to clear GEN_DONE/START_ACK. IRQ_STATUS = 0x%08h",rdata))

        //  2: Clear DEST_ERROR (bit 1)
        do_write(regmodel.err_status, 32'h0000_0002);
        do_read(regmodel.err_status, rdata);

        if ((rdata & 32'h0000_0002) == 0)
                `uvm_info("ERR_CLEAR","DEST_ERROR cleared successfully",UVM_LOW)
        else
                `uvm_error("ERR_CLEAR",$sformatf("Failed to clear DEST_ERROR. ERR_STATUS = 0x%08h", rdata))

        //  3: Clear all implemented IRQ bits [7:0]
        do_write(regmodel.irq_status, 32'h0000_00FF);
        do_read(regmodel.irq_status, rdata);

        if ((rdata & 32'h0000_00FF) == 0)
                `uvm_info("IRQ_CLEAR","All implemented IRQ bits cleared successfully",UVM_LOW)
        else
                `uvm_error("IRQ_CLEAR",$sformatf("Failed to clear all IRQ bits. IRQ_STATUS = 0x%08h",rdata))

          `uvm_info(get_type_name(),"========== CLEAR STICKY STATUS END ==========",UVM_LOW)
        endtask

endclass

class dest_drop_seq extends top_reg_seq;

        `uvm_object_utils(dest_drop_seq)

        function new(string name = "dest_drop_seq");
        super.new(name);
        endfunction

        task body();
        uvm_reg_data_t rdata;
        bit dest_error_seen;
        bit packet_dropped_seen;
        bit stat_drop_seen;

        if (regmodel == null) `uvm_fatal("NO_REGMODEL", "regmodel not assigned")

        `uvm_info(get_type_name(), "========== DESTINATION DROP TEST START ==========", UVM_LOW)

        do_write(regmodel.lock, 32'hA5A5_C3C3);
        do_write(regmodel.switch_ctrl, 32'h0000_0009);
        do_write(regmodel.port_enable, 32'h0000_000F);
        do_write(regmodel.fwd_enable, 32'h0000_0001);
        do_write(regmodel.gen_pkt_cfg, 32'h0000_0501);

        do_write(regmodel.gen_count, 32'h0000_0001);
        do_write(regmodel.gen_ctrl, 32'h0000_0003);

        dest_error_seen = 0;
        repeat (100) begin
                do_read(regmodel.err_status, rdata);
                if (rdata[1] === 1'b1) begin
                        dest_error_seen = 1;
                        break;
                end
                end

        if (dest_error_seen)
                `uvm_info("DEST_DROP", "ERR_STATUS.DEST_ERROR CHECK PASS", UVM_LOW)
        else
                `uvm_error("DEST_DROP", "ERR_STATUS.DEST_ERROR was not set")

        stat_drop_seen = 0;
        repeat (100) begin
                do_read(regmodel.stat_drop, rdata);
                if (rdata >= 32'h0000_0001) begin
                        stat_drop_seen = 1;
                        break;
                end
        end

        if (stat_drop_seen)
                `uvm_info("DEST_DROP", "STAT_DROP increment CHECK PASS", UVM_LOW)
        else
                `uvm_error("DEST_DROP", "STAT_DROP did not increment")

        packet_dropped_seen = 0;
        repeat (100) begin
                do_read(regmodel.irq_status, rdata);
                if (rdata[3] === 1'b1) begin
                        packet_dropped_seen = 1;
                        break;
                end
        end

        if (packet_dropped_seen)
                `uvm_info("DEST_DROP", "IRQ_STATUS.PACKET_DROPPED CHECK PASS", UVM_LOW)
        else
          `uvm_error("DEST_DROP", "IRQ_STATUS.PACKET_DROPPED was not set")

        `uvm_info(get_type_name(), "========== DESTINATION DROP TEST END ==========", UVM_LOW)

        endtask

endclass


class apply_reset_seq extends top_reg_seq;

        `uvm_object_utils(apply_reset_seq)

        function new(string name = "apply_reset_seq");
        super.new(name);
        endfunction

        task body();

        if (regmodel == null)
                `uvm_fatal("NO_REGMODEL", "regmodel not assigned")

        `uvm_info(get_type_name(), "========== APPLY RESET VALUES TO ALL REGISTERS START ==========", UVM_LOW)

        do_write(regmodel.lock, 32'hA5A5_C3C3);
        do_write(regmodel.switch_ctrl, 32'h0000_0000);
        do_write(regmodel.port_enable, 32'h0000_000F);
        do_write(regmodel.fwd_enable, 32'h0000_000F);
        do_write(regmodel.gen_ctrl, 32'h0000_0000);
        do_write(regmodel.gen_pkt_cfg, 32'h0000_0401);
        do_write(regmodel.gen_interval, 32'h0000_0002);
        do_write(regmodel.gen_count, 32'h0000_0004);
        do_write(regmodel.irq_status, 32'h0000_00FF);
        do_write(regmodel.irq_enable, 32'h0000_0000);
        do_write(regmodel.irq_force, 32'h0000_0000);
        do_write(regmodel.err_status, 32'hFFFF_FFFF);
        do_write(regmodel.err_enable, 32'h0000_0000);
        do_write(regmodel.err_inject, 32'h0000_0000);
        do_write(regmodel.soft_reset, 32'h0000_0001);

    `uvm_info(get_type_name(), "========== APPLY RESET VALUES TO ALL REGISTERS END ==========", UVM_LOW)

  endtask

endclass


//device_id_seq 0x00
class device_id_seq extends top_reg_seq;
        `uvm_object_utils(device_id_seq)

        function new(string name = "device_id_seq");
                super.new(name);
        endfunction

        task body();
                uvm_reg_data_t rdata;
                uvm_reg_data_t wdata;
                uvm_reg_data_t des;
                uvm_reg_data_t mir;

                if (regmodel == null)
                        `uvm_fatal("NO_REGMODEL", "regmodel not assigned")

                `uvm_info(get_type_name(), "\n\n================ DEVICE_ID CHECK START ================\n\n", UVM_LOW)

                // 1. Initial read - check fixed DEVICE_ID value

                do_read(regmodel.device_id, rdata);
                des = regmodel.device_id.get();
                mir = regmodel.device_id.get_mirrored_value();

                `uvm_info(get_type_name(), $sformatf("DEFAULT READ | DUT=0x%08h DESIRED=0x%08h MIRRORED=0x%08h", rdata, des, mir), UVM_LOW)

                if (rdata !== 32'h02A5_5357)
                        `uvm_error(get_type_name(), $sformatf("DEVICE_ID mismatch! Expected=0x02A55357 Actual=0x%08h", rdata))

                if (mir !== rdata)
                        `uvm_error(get_type_name(), $sformatf("Mirror mismatch! DUT=0x%08h MIRRORED=0x%08h", rdata, mir))


                // 2. Write random values and check RO behavior

                repeat(`no_of_trans) begin

                        wdata = $urandom();

                        do_write(regmodel.device_id, wdata);

                        des = regmodel.device_id.get();
                        mir = regmodel.device_id.get_mirrored_value();

                        `uvm_info(get_type_name(), $sformatf("RO WRITE | WDATA=0x%08h DESIRED=0x%08h MIRRORED=0x%08h", wdata, des, mir), UVM_LOW)

                        // Read after write
                        do_read(regmodel.device_id, rdata);

                        des = regmodel.device_id.get();
                        mir = regmodel.device_id.get_mirrored_value();

                        `uvm_info(get_type_name(), $sformatf("READ AFTER WRITE | DUT=0x%08h DESIRED=0x%08h MIRRORED=0x%08h", rdata, des, mir), UVM_LOW)

                        // DEVICE_ID must remain fixed
                        if (rdata !== 32'h02A5_5357)
                                `uvm_error(get_type_name(), $sformatf("DEVICE_ID changed after RO write! WDATA=0x%08h READ=0x%08h", wdata, rdata))

                        // Mirror must match DUT
                        if (mir !== rdata)
                                `uvm_error(get_type_name(), $sformatf("Mirror mismatch! DUT=0x%08h MIRRORED=0x%08h", rdata, mir))
                          `uvm_info(get_type_name(),"---------------------------------------------------------------",UVM_LOW)

                end


                // 3. Check individual fields

                do_read(regmodel.device_id, rdata);

                `uvm_info(get_type_name(), $sformatf("FIELD CHECK | REVISION=0x%02h VENDOR_ID=0x%02h PRODUCT_ID=0x%04h", rdata[31:24], rdata[23:16], rdata[15:0]), UVM_LOW)

                if (rdata[31:24] !== 8'h02)
                        `uvm_error(get_type_name(), $sformatf("REVISION mismatch! Expected=0x02 Actual=0x%02h", rdata[31:24]))

                if (rdata[23:16] !== 8'hA5)
                        `uvm_error(get_type_name(), $sformatf("VENDOR_ID mismatch! Expected=0xA5 Actual=0x%02h", rdata[23:16]))

                if (rdata[15:0] !== 16'h5357)
                        `uvm_error(get_type_name(), $sformatf("PRODUCT_ID mismatch! Expected=0x5357 Actual=0x%04h", rdata[15:0]))


                `uvm_info(get_type_name(), "\n\n================ DEVICE_ID CHECK END ==================\n\n", UVM_LOW)

                // DEVICE_ID is a constant (localparam) and has no actual RTL
                //so backdoor access is not applicable since no physical HDL path

        endtask
endclass

// version_seq 0x04
class version_seq extends top_reg_seq;
        `uvm_object_utils(version_seq)

        function new(string name = "version_seq");
                super.new(name);
        endfunction

        task body();
                uvm_reg_data_t rdata;
                uvm_reg_data_t wdata;
                uvm_reg_data_t des;
                uvm_reg_data_t mir;

                if (regmodel == null)
                        `uvm_fatal("NO_REGMODEL", "regmodel not assigned")

                  `uvm_info(get_type_name(), "\n\n================ VERSION CHECK START ================\n\n", UVM_LOW)

                // 1. Initial read - check fixed VERSION value

                do_read(regmodel.version, rdata);

                des = regmodel.version.get();
                mir = regmodel.version.get_mirrored_value();

                `uvm_info(get_type_name(), $sformatf("DEFAULT READ | DUT=0x%08h DESIRED=0x%08h MIRRORED=0x%08h", rdata, des, mir), UVM_LOW)

                if (rdata !== 32'h0001_0200)
                        `uvm_error(get_type_name(), $sformatf("VERSION mismatch! Expected=0x00010200 Actual=0x%08h", rdata))

                if (mir !== rdata)
                        `uvm_error(get_type_name(), $sformatf("Mirror mismatch! DUT=0x%08h MIRRORED=0x%08h", rdata, mir))


                // 2. Write random values and check RO behavior

                repeat(`no_of_trans) begin

                        wdata = $urandom();

                        do_write(regmodel.version, wdata);

                        des = regmodel.version.get();
                        mir = regmodel.version.get_mirrored_value();

                        `uvm_info(get_type_name(), $sformatf("RO WRITE | WDATA=0x%08h DESIRED=0x%08h MIRRORED=0x%08h", wdata, des, mir), UVM_LOW)

                        // Read after write
                        do_read(regmodel.version, rdata);

                        des = regmodel.version.get();
                        mir = regmodel.version.get_mirrored_value();

                        `uvm_info(get_type_name(), $sformatf("READ AFTER WRITE | DUT=0x%08h DESIRED=0x%08h MIRRORED=0x%08h", rdata, des, mir), UVM_LOW)

                        // VERSION must remain fixed
                        if (rdata !== 32'h0001_0200)
                                `uvm_error(get_type_name(), $sformatf("VERSION changed after RO write! WDATA=0x%08h READ=0x%08h", wdata, rdata))

                        if (mir !== rdata)
                                `uvm_error(get_type_name(), $sformatf("Mirror mismatch! DUT=0x%08h MIRRORED=0x%08h", rdata, mir))

                        `uvm_info(get_type_name(),"---------------------------------------------------------------",UVM_LOW)
                end


                // 3. Check individual fields

                do_read(regmodel.version, rdata);

                  `uvm_info(get_type_name(), $sformatf("FIELD CHECK | RESERVED=0x%02h MAJOR=0x%02h MINOR=0x%02h PATCH=0x%02h ", rdata[31:24], rdata[23:16], rdata[15:8], rdata[7:0]), UVM_LOW)

                if (rdata[31:24] !== 8'h00)
                  `uvm_error(get_type_name(), $sformatf("RESERVED mismatch! Expected=0x00 Actual=0x%02h", rdata[31:24]))

                if (rdata[23:16] !== 8'h01)
                  `uvm_error(get_type_name(), $sformatf("MAJOR mismatch! Expected=0x01 Actual=0x%02h", rdata[23:16]))

                if (rdata[15:8] !== 8'h02)
                  `uvm_error(get_type_name(), $sformatf("MINOR mismatch! Expected=0x02 Actual=0x%02h", rdata[15:8]))

                if (rdata[7:0] !== 8'h00)
                  `uvm_error(get_type_name(), $sformatf("PATCH mismatch! Expected=0x00 Actual=0x%02h", rdata[7:0]))

                `uvm_info(get_type_name(), "================ VERSION CHECK END ==================", UVM_LOW)


                // VERSION is a constant (localparam) and has no actual RTL
                // so backdoor access is not applicable since no physical HDL path

        endtask
endclass



//switch_status_seq 0x08
class switch_status_seq extends top_reg_seq;
        `uvm_object_utils(switch_status_seq)

        function new(string name = "switch_status_seq");
                super.new(name);
        endfunction

        task body();
                uvm_reg_data_t rdata;
                uvm_reg_data_t wdata;
                        uvm_status_e status;

                `uvm_info(get_type_name(), "\n\n================ SWITCH_STATUS CHECK START ================\n\n", UVM_LOW)

                // 1. Initial Read read
                do_read(regmodel.switch_status, rdata);

                `uvm_info(get_type_name(), $sformatf("DEFAULT READ | DUT=0x%08h DESIRED=0x%08h MIRRORED=0x%08h", rdata, regmodel.switch_status.get(), regmodel.switch_status.get_mirrored_value()), UVM_LOW)

                //2. Random Write to RO
                repeat (3) begin
                        wdata = $urandom();

                        do_write(regmodel.switch_status, wdata);

                        `uvm_info(get_type_name(), $sformatf("RO WRITE | WDATA=0x%08h DESIRED=0x%08h MIRRORED=0x%08h", wdata, regmodel.switch_status.get(), regmodel.switch_status.get_mirrored_value()), UVM_LOW)

                        // Read after write
                        do_read(regmodel.switch_status, rdata);

                        `uvm_info(get_type_name(), $sformatf("READ AFTER WRITE | DUT=0x%08h DESIRED=0x%08h MIRRORED=0x%08h", rdata, regmodel.switch_status.get(), regmodel.switch_status.get_mirrored_value()), UVM_LOW)

                        if (rdata !== 32'h0000_00F9)
                                `uvm_error("SWITCH_STATUS", $sformatf("RO register changed! Expected=0x000000F9 Actual=0x%08h", rdata))

                        `uvm_info(get_type_name(),"---------------------------------------------------------------",UVM_LOW)
                end

                // Field checks
                if (rdata[17:16] !== 2'h0)
                        `uvm_error("SWITCH_STATUS", $sformatf("GEN_FSM mismatch: %0h", rdata[17:16]))

                if (rdata[9] !== 1'b0)
                        `uvm_error("SWITCH_STATUS", $sformatf("ERR_PENDING mismatch: %0b", rdata[9]))

                if (rdata[8] !== 1'b0)
                        `uvm_error("SWITCH_STATUS", $sformatf("GEN_RUNNING mismatch: %0b", rdata[8]))

                if (rdata[7:4] !== 4'hF)
                        `uvm_error("SWITCH_STATUS", $sformatf("PORT_ENABLED mismatch: %0h", rdata[7:4]))

                if (rdata[3] !== 1'b1)
                        `uvm_error("SWITCH_STATUS", $sformatf("LOCKED mismatch: %0b", rdata[3]))

                if (rdata[2] !== 1'b0)
                        `uvm_error("SWITCH_STATUS", $sformatf("SWITCH_ENABLED mismatch: %0b", rdata[2]))

                if (rdata[1] !== 1'b0)
                        `uvm_error("SWITCH_STATUS", $sformatf("BUSY mismatch: %0b", rdata[1]))

                if (rdata[0] !== 1'b1)
                        `uvm_error("SWITCH_STATUS", $sformatf("READY mismatch: %0b", rdata[0]))

                `uvm_info(get_type_name(), $sformatf("FIELD CHECK | GEN_FSM=0x%0h ERR_PENDING=%0b GEN_RUNNING=%0b PORT_ENABLED=0x%0h LOCKED=%0b SWITCH_ENABLED=%0b BUSY=%0b READY=%0b", rdata[17:16], rdata[9], rdata[8], rdata[7:4], rdata[3], rdata[2], rdata[1], rdata[0]), UVM_LOW)


                        // 5. Backdoor write and Frontdoor read
                // SWITCH_STATUS is a combinational RO register.
                                // Backdoor write is not retained because switch_status_q is continuously updated by always_comb.
                                // Current status gives 32'h0000_00F9, so frontdoor read returns F9.

                wdata = 32'hABCD_1234;

                        regmodel.switch_status.write(status,wdata,UVM_BACKDOOR);

                        `uvm_info("SEQ",$sformatf("BACKDOOR WRITE | DATA=%0h", wdata),UVM_LOW)

                // Read after write (backdoor write should update the register
                do_read(regmodel.switch_status, rdata);

                `uvm_info(get_type_name(), $sformatf("FRONTDOOR READ AFTER BACKDOOR WRITE | DUT=0x%08h DESIRED=0x%08h MIRRORED=0x%08h", rdata, regmodel.switch_status.get(), regmodel.switch_status.get_mirrored_value()), UVM_LOW)
                wdata = 32'h0001_0106;

                        regmodel.switch_status.write(status,wdata,UVM_BACKDOOR);

                        `uvm_info("SEQ",$sformatf("BACKDOOR WRITE | DATA=%0h", wdata),UVM_LOW)

                // Read after write (backdoor write should update the register
                do_read(regmodel.switch_status, rdata);

                `uvm_info(get_type_name(), $sformatf("FRONTDOOR READ AFTER BACKDOOR WRITE | DUT=0x%08h DESIRED=0x%08h MIRRORED=0x%08h", rdata, regmodel.switch_status.get(), regmodel.switch_status.get_mirrored_value()), UVM_LOW)

                wdata = 32'h0001_0156;

                        regmodel.switch_status.write(status,wdata,UVM_BACKDOOR);

                        `uvm_info("SEQ",$sformatf("BACKDOOR WRITE | DATA=%0h", wdata),UVM_LOW)

                // Read after write (backdoor write should update the register
                do_read(regmodel.switch_status, rdata);

                `uvm_info(get_type_name(), $sformatf("FRONTDOOR READ AFTER BACKDOOR WRITE | DUT=0x%08h DESIRED=0x%08h MIRRORED=0x%08h", rdata, regmodel.switch_status.get(), regmodel.switch_status.get_mirrored_value()), UVM_LOW)

                wdata = 32'h0002_0106;

                        regmodel.switch_status.write(status,wdata,UVM_BACKDOOR);

                        `uvm_info("SEQ",$sformatf("BACKDOOR WRITE | DATA=%0h", wdata),UVM_LOW)

                // Read after write (backdoor write should update the register
                do_read(regmodel.switch_status, rdata);

                `uvm_info(get_type_name(), $sformatf("FRONTDOOR READ AFTER BACKDOOR WRITE | DUT=0x%08h DESIRED=0x%08h MIRRORED=0x%08h", rdata, regmodel.switch_status.get(), regmodel.switch_status.get_mirrored_value()), UVM_LOW)

                wdata = 32'h0002_0156;

                        regmodel.switch_status.write(status,wdata,UVM_BACKDOOR);

                        `uvm_info("SEQ",$sformatf("BACKDOOR WRITE | DATA=%0h", wdata),UVM_LOW)

                // Read after write (backdoor write should update the register
                do_read(regmodel.switch_status, rdata);

                `uvm_info(get_type_name(), $sformatf("FRONTDOOR READ AFTER BACKDOOR WRITE | DUT=0x%08h DESIRED=0x%08h MIRRORED=0x%08h", rdata, regmodel.switch_status.get(), regmodel.switch_status.get_mirrored_value()), UVM_LOW)


                `uvm_info(get_type_name(), "\n\n================ SWITCH_STATUS CHECK END ==================\n\n", UVM_LOW)
        endtask

endclass



// port_status_seq 0x0c
class port_status_seq extends top_reg_seq;
  `uvm_object_utils(port_status_seq)

  function new(string name = "port_status_seq");
                super.new(name);
        endfunction

        task body();
                uvm_reg_data_t rdata;
                uvm_reg_data_t wdata;
                uvm_reg_data_t des;
                uvm_reg_data_t mir;
                        uvm_status_e status;


                if (regmodel == null)
                        `uvm_fatal("NO_REGMODEL", "regmodel not assigned")

                  `uvm_info(get_type_name(), "\n\n================ PORT_STATUS CHECK START ================\n\n", UVM_LOW)

                // 1. Initial read - check fixed VERSION value

                do_read(regmodel.port_status, rdata);

                des = regmodel.port_status.get();
                mir = regmodel.port_status.get_mirrored_value();

                `uvm_info(get_type_name(), $sformatf("DEFAULT READ | DUT=0x%08h DESIRED=0x%08h MIRRORED=0x%08h", rdata, des, mir), UVM_LOW)

                if (rdata !== 32'h0000_0000)
                  `uvm_error(get_type_name(), $sformatf("PORT_STATUS mismatch! Expected=0x00010200 Actual=0x%08h", rdata))

                if (mir !== rdata)
                        `uvm_error(get_type_name(), $sformatf("Mirror mismatch! DUT=0x%08h MIRRORED=0x%08h", rdata, mir))


                // 2. Write random values and check RO behavior

                repeat(`no_of_trans) begin

                        wdata = $urandom();

                        do_write(regmodel.port_status, wdata);

                        des = regmodel.port_status.get();
                        mir = regmodel.port_status.get_mirrored_value();

                        `uvm_info(get_type_name(), $sformatf("RO WRITE | WDATA=0x%08h DESIRED=0x%08h MIRRORED=0x%08h", wdata, des, mir), UVM_LOW)

                        // Read after write
                        do_read(regmodel.port_status, rdata);

                        des = regmodel.port_status.get();
                        mir = regmodel.port_status.get_mirrored_value();

                        `uvm_info(get_type_name(), $sformatf("READ AFTER WRITE | DUT=0x%08h DESIRED=0x%08h MIRRORED=0x%08h", rdata, des, mir), UVM_LOW)

                        // PORT_STATUS must remain fixed
                        if (rdata !== 32'h0000_0000)
                          `uvm_error(get_type_name(), $sformatf("PORT_STATUS changed after RO write! WDATA=0x%08h READ=0x%08h", wdata, rdata))

                        if (mir !== rdata)
                                `uvm_error(get_type_name(), $sformatf("Mirror mismatch! DUT=0x%08h MIRRORED=0x%08h", rdata, mir))

                        `uvm_info(get_type_name(),"---------------------------------------------------------------",UVM_LOW)
                end



                // 3. Check individual fields

                do_read(regmodel.port_status, rdata);

                  `uvm_info(get_type_name(), $sformatf("FIELD CHECK | PORT3_LEVEL=0x%02h PORT2_LEVEL=0x%02h PORT1_LEVEL=0x%02h PORT0_LEVEL=0x%02h ", rdata[31:24], rdata[23:16], rdata[15:8], rdata[7:0]), UVM_LOW)

                if (rdata[31:24] !== 8'h00)
                  `uvm_error(get_type_name(), $sformatf("PORT3_LEVEL mismatch! Expected=0x00 Actual=0x%02h", rdata[31:24]))

                if (rdata[23:16] !== 8'h00)
                  `uvm_error(get_type_name(), $sformatf("PORT2_LEVEL mismatch! Expected=0x01 Actual=0x%02h", rdata[23:16]))

                if (rdata[15:8] !== 8'h00)
                  `uvm_error(get_type_name(), $sformatf("PORT1_lEVEL mismatch! Expected=0x02 Actual=0x%02h", rdata[15:8]))

                if (rdata[7:0] !== 8'h00)
                  `uvm_error(get_type_name(), $sformatf("PORT0_LEVEL mismatch! Expected=0x00 Actual=0x%02h", rdata[7:0]))


                        // 4. Backdoor write and Frontdoor read


                wdata = 32'hABCD_1234;

                        regmodel.port_status.write(status,wdata,UVM_BACKDOOR);

                        `uvm_info("SEQ",$sformatf("BACKDOOR WRITE | DATA=%0h", wdata),UVM_LOW)

                // Read after write (backdoor write should update the register)
                do_read(regmodel.port_status, rdata);

                `uvm_info(get_type_name(), $sformatf("FRONTDOOR READ AFTER BACKDOOR WRITE | DUT=0x%08h DESIRED=0x%08h MIRRORED=0x%08h", rdata, regmodel.port_status.get(), regmodel.port_status.get_mirrored_value()), UVM_LOW)



                  `uvm_info(get_type_name(), "================ PORT_STATUS CHECK END ==================", UVM_LOW)
        endtask
endclass




class gen_status_seq extends top_reg_seq;
  `uvm_object_utils(gen_status_seq)

        function new(string name = "gen_status_seq");
                super.new(name);
        endfunction

        task body();
                uvm_reg_data_t rdata;
                uvm_reg_data_t wdata;
                uvm_reg_data_t des;
                uvm_reg_data_t mir;
                        uvm_status_e status;

                if (regmodel == null)
                        `uvm_fatal("NO_REGMODEL", "regmodel not assigned")

                  `uvm_info(get_type_name(), "\n\n================ GEN_STATUS CHECK START ================\n\n", UVM_LOW)

                // 1. Initial read - check fixed VERSION value

                do_read(regmodel.gen_status, rdata);

                des = regmodel.gen_status.get();
                mir = regmodel.gen_status.get_mirrored_value();

                `uvm_info(get_type_name(), $sformatf("DEFAULT READ | DUT=0x%08h DESIRED=0x%08h MIRRORED=0x%08h", rdata, des, mir), UVM_LOW)

                if (rdata !== 32'h0000_0000)
                  `uvm_error(get_type_name(), $sformatf("GEN_STATUS mismatch! Expected=0x00010200 Actual=0x%08h", rdata))

                if (mir !== rdata)
                        `uvm_error(get_type_name(), $sformatf("Mirror mismatch! DUT=0x%08h MIRRORED=0x%08h", rdata, mir))


                // 2. Write random values and check RO behavior

                repeat(`no_of_trans) begin

                        wdata = $urandom();

                        do_write(regmodel.gen_status, wdata);

                        des = regmodel.gen_status.get();
                        mir = regmodel.gen_status.get_mirrored_value();

                        `uvm_info(get_type_name(), $sformatf("RO WRITE | WDATA=0x%08h DESIRED=0x%08h MIRRORED=0x%08h", wdata, des, mir), UVM_LOW)

                        // Read after write
                        do_read(regmodel.gen_status, rdata);

                        des = regmodel.gen_status.get();
                        mir = regmodel.gen_status.get_mirrored_value();

                        `uvm_info(get_type_name(), $sformatf("READ AFTER WRITE | DUT=0x%08h DESIRED=0x%08h MIRRORED=0x%08h", rdata, des, mir), UVM_LOW)

                        // PORT_STATUS must remain fixed
                        if (rdata !== 32'h0000_0000)
                          `uvm_error(get_type_name(), $sformatf("GEN_STATUS changed after RO write! WDATA=0x%08h READ=0x%08h", wdata, rdata))

                        if (mir !== rdata)
                                `uvm_error(get_type_name(), $sformatf("Mirror mismatch! DUT=0x%08h MIRRORED=0x%08h", rdata, mir))

                        `uvm_info(get_type_name(),"---------------------------------------------------------------",UVM_LOW)
                end



                // 3. Check individual fields

                do_read(regmodel.gen_status, rdata);

                  `uvm_info(get_type_name(), $sformatf("FIELD CHECK | RESERVED_31_24=0x%02h REMAINING=0x%02h RESERVED_7_4=0x%02h FSM=0x%02h DONE=0x%02h RUNNING=0x%02h", rdata[31:24], rdata[23:8], rdata[7:4], rdata[3:2], rdata[1],rdata[0]), UVM_LOW)

                if (rdata[31:24] !== 8'h00)
                  `uvm_error(get_type_name(), $sformatf("RESERVED_31_24 mismatch! Expected=0x00 Actual=0x%02h", rdata[31:24]))

                if (rdata[23:8] !== 16'h0000)
                    `uvm_error(get_type_name(), $sformatf("REMAINING mismatch! Expected=0x01 Actual=0x%02h", rdata[23:8]))

                if (rdata[7:4] !== 4'h0)
                      `uvm_error(get_type_name(), $sformatf("RESERVED_7_4 mismatch! Expected=0x02 Actual=0x%02h", rdata[7:4]))

                if (rdata[3:2] !== 2'h0)
                      `uvm_error(get_type_name(), $sformatf("FSM mismatch! Expected=0x00 Actual=0x%02h", rdata[3:2]))

                if (rdata[1] !== 1'b0)
                      `uvm_error(get_type_name(), $sformatf("DONE mismatch! Expected=0x02 Actual=0x%02h", rdata[1]))

                if (rdata[0] !== 1'b0)
                      `uvm_error(get_type_name(), $sformatf("RUNNING mismatch! Expected=0x00 Actual=0x%02h", rdata[0]))



                        // 4. Backdoor write and Frontdoor read


                wdata = 32'hABCD_1234;

                        regmodel.gen_status.write(status,wdata,UVM_BACKDOOR);

                        `uvm_info("SEQ",$sformatf("BACKDOOR WRITE | DATA=%0h", wdata),UVM_LOW)

                // Read after write (backdoor write should update the register)
                  do_read(regmodel.gen_status, rdata);

                `uvm_info(get_type_name(), $sformatf("FRONTDOOR READ AFTER BACKDOOR WRITE | DUT=0x%08h DESIRED=0x%08h MIRRORED=0x%08h", rdata, regmodel.gen_status.get(), regmodel.gen_status.get_mirrored_value()), UVM_LOW)


                // GEN_STATUS is a combinational signal calculated from the generator status.
                                // It is not a physical storage register, so backdoor write will not retain
                                // the written value.


                `uvm_info(get_type_name(), "================ GEN_STATUS CHECK END ==================", UVM_LOW)

        endtask
endclass



// stat_rx_seq 0x14
class stat_rx_seq extends top_reg_seq;
        `uvm_object_utils(stat_rx_seq)

        function new(string name = "stat_rx_seq");
                super.new(name);
        endfunction

        task body();
                uvm_reg_data_t rdata;
                uvm_reg_data_t wdata;
                uvm_reg_data_t des;
                uvm_reg_data_t mir;
                        uvm_status_e status;

                if (regmodel == null)
                        `uvm_fatal("NO_REGMODEL", "regmodel not assigned")

                  `uvm_info(get_type_name(), "\n\n================ STAT_RX CHECK START ================\n\n", UVM_LOW)

                // 1. Initial read - check fixed VERSION value

                do_read(regmodel.stat_rx, rdata);

                des = regmodel.stat_rx.get();
                mir = regmodel.stat_rx.get_mirrored_value();

                `uvm_info(get_type_name(), $sformatf("DEFAULT READ | DUT=0x%08h DESIRED=0x%08h MIRRORED=0x%08h", rdata, des, mir), UVM_LOW)

                if (rdata !== 32'h0000_0000)
                  `uvm_error(get_type_name(), $sformatf("STAT_RX mismatch! Expected=0x00010200 Actual=0x%08h", rdata))

                if (mir !== rdata)
                        `uvm_error(get_type_name(), $sformatf("Mirror mismatch! DUT=0x%08h MIRRORED=0x%08h", rdata, mir))


                wdata = 16'h0000;

                do_write(regmodel.stat_rx, wdata);

                        des = regmodel.stat_rx.get();
                        mir = regmodel.stat_rx.get_mirrored_value();

                        `uvm_info(get_type_name(), $sformatf("RO WRITE | WDATA=0x%08h DESIRED=0x%08h MIRRORED=0x%08h", wdata, des, mir), UVM_LOW)

                        // Read after write
                        do_read(regmodel.stat_rx, rdata);

                        des = regmodel.stat_rx.get();
                        mir = regmodel.stat_rx.get_mirrored_value();

                        `uvm_info(get_type_name(), $sformatf("READ AFTER WRITE | DUT=0x%08h DESIRED=0x%08h MIRRORED=0x%08h", rdata, des, mir), UVM_LOW)

                        // STAT_RX must remain fixed
                        if (rdata !== 32'h0000_0000)
                          `uvm_error(get_type_name(), $sformatf("STAT_RX changed after RO write! WDATA=0x%08h READ=0x%08h", wdata, rdata))

                        if (mir !== rdata)
                                `uvm_error(get_type_name(), $sformatf("Mirror mismatch! DUT=0x%08h MIRRORED=0x%08h", rdata, mir))

                        `uvm_info(get_type_name(),"---------------------------------------------------------------",UVM_LOW)
                 wdata = 16'h0001;

                        do_write(regmodel.stat_rx, wdata);

                        des = regmodel.stat_rx.get();
                        mir = regmodel.stat_rx.get_mirrored_value();

                        `uvm_info(get_type_name(), $sformatf("RO WRITE | WDATA=0x%08h DESIRED=0x%08h MIRRORED=0x%08h", wdata, des, mir), UVM_LOW)

                        // Read after write
                        do_read(regmodel.stat_rx, rdata);

                        des = regmodel.stat_rx.get();
                        mir = regmodel.stat_rx.get_mirrored_value();

                        `uvm_info(get_type_name(), $sformatf("READ AFTER WRITE | DUT=0x%08h DESIRED=0x%08h MIRRORED=0x%08h", rdata, des, mir), UVM_LOW)

                        // STAT_RX must remain fixed
                        if (rdata !== 32'h0000_0000)
                          `uvm_error(get_type_name(), $sformatf("STAT_RX changed after RO write! WDATA=0x%08h READ=0x%08h", wdata, rdata))

                        if (mir !== rdata)
                                `uvm_error(get_type_name(), $sformatf("Mirror mismatch! DUT=0x%08h MIRRORED=0x%08h", rdata, mir))

                        `uvm_info(get_type_name(),"---------------------------------------------------------------",UVM_LOW)


                // 2. Write random values and check RO behavior

                repeat(`no_of_trans) begin

                        wdata = $urandom_range(0,16'hFFFF);

                        do_write(regmodel.stat_rx, wdata);

                        des = regmodel.stat_rx.get();
                        mir = regmodel.stat_rx.get_mirrored_value();

                        `uvm_info(get_type_name(), $sformatf("RO WRITE | WDATA=0x%08h DESIRED=0x%08h MIRRORED=0x%08h", wdata, des, mir), UVM_LOW)

                        // Read after write
                        do_read(regmodel.stat_rx, rdata);

                        des = regmodel.stat_rx.get();
                        mir = regmodel.stat_rx.get_mirrored_value();

                        `uvm_info(get_type_name(), $sformatf("READ AFTER WRITE | DUT=0x%08h DESIRED=0x%08h MIRRORED=0x%08h", rdata, des, mir), UVM_LOW)

                        // STAT_RX must remain fixed
                        if (rdata !== 32'h0000_0000)
                          `uvm_error(get_type_name(), $sformatf("STAT_RX changed after RO write! WDATA=0x%08h READ=0x%08h", wdata, rdata))

                        if (mir !== rdata)
                                `uvm_error(get_type_name(), $sformatf("Mirror mismatch! DUT=0x%08h MIRRORED=0x%08h", rdata, mir))

                        `uvm_info(get_type_name(),"---------------------------------------------------------------",UVM_LOW)
                end


                // 3. Check individual fields

                do_read(regmodel.stat_rx, rdata);

                  `uvm_info(get_type_name(), $sformatf("FIELD CHECK | RESERVED=0x%02h RX_PACKETS=0x%02h ", rdata[31:16], rdata[15:0]), UVM_LOW)

                if (rdata[31:16] !== 16'h0000)
                  `uvm_error(get_type_name(), $sformatf("RESERVED mismatch! Expected=0x00 Actual=0x%02h", rdata[31:16]))

                if (rdata[15:0] !== 16'h0000)
                  `uvm_error(get_type_name(), $sformatf("RX_PACKETS mismatch! Expected=0x01 Actual=0x%02h", rdata[15:0]))


                        // 4. Backdoor write and Frontdoor read


                wdata = 16'hABCD;

                        regmodel.stat_rx.write(status,wdata,UVM_BACKDOOR);

                        `uvm_info("SEQ",$sformatf("BACKDOOR WRITE | DATA=%0h", wdata),UVM_LOW)

                // Read after write (backdoor write should update the register)
                do_read(regmodel.stat_rx, rdata);

                `uvm_info(get_type_name(), $sformatf("FRONTDOOR READ AFTER BACKDOOR WRITE | DUT=0x%08h DESIRED=0x%08h MIRRORED=0x%08h", rdata, regmodel.stat_rx.get(), regmodel.stat_rx.get_mirrored_value()), UVM_LOW)

                                // Backdoor access is added to verify the internal STAT_DROP counter
                                // value and to check whether the RAL HDL path is configured correctly.
                                // Frontdoor access is used to verify the register through the APB interface.


                `uvm_info(get_type_name(), "================ STAT_RX CHECK END ==================", UVM_LOW)

        endtask
endclass


// stat_tx_seq 0x18
class stat_tx_seq extends top_reg_seq;
                `uvm_object_utils(stat_tx_seq)

                function new(string name = "stat_tx_seq");
                super.new(name);
        endfunction

        task body();
                uvm_reg_data_t rdata;
                uvm_reg_data_t wdata;
                uvm_reg_data_t des;
                uvm_reg_data_t mir;
                        uvm_status_e status;

                if (regmodel == null)
                        `uvm_fatal("NO_REGMODEL", "regmodel not assigned")

                  `uvm_info(get_type_name(), "\n\n================ STAT_TX CHECK START ================\n\n", UVM_LOW)

                // 1. Initial read - check fixed VERSION value

                do_read(regmodel.stat_tx, rdata);

                des = regmodel.stat_tx.get();
                mir = regmodel.stat_tx.get_mirrored_value();

                `uvm_info(get_type_name(), $sformatf("DEFAULT READ | DUT=0x%08h DESIRED=0x%08h MIRRORED=0x%08h", rdata, des, mir), UVM_LOW)

                if (rdata !== 32'h0000_0000)
                  `uvm_error(get_type_name(), $sformatf("STAT_TX mismatch! Expected=0x00010200 Actual=0x%08h", rdata))

                if (mir !== rdata)
                        `uvm_error(get_type_name(), $sformatf("Mirror mismatch! DUT=0x%08h MIRRORED=0x%08h", rdata, mir))


                wdata = 16'h0001;

                        do_write(regmodel.stat_tx, wdata);

                        des = regmodel.stat_tx.get();
                        mir = regmodel.stat_tx.get_mirrored_value();

                        `uvm_info(get_type_name(), $sformatf("RO WRITE | WDATA=0x%08h DESIRED=0x%08h MIRRORED=0x%08h", wdata, des, mir), UVM_LOW)

                        // Read after write
                        do_read(regmodel.stat_tx, rdata);

                        des = regmodel.stat_tx.get();
                        mir = regmodel.stat_tx.get_mirrored_value();

                        `uvm_info(get_type_name(), $sformatf("READ AFTER WRITE | DUT=0x%08h DESIRED=0x%08h MIRRORED=0x%08h", rdata, des, mir), UVM_LOW)

                        // STAT_RX must remain fixed
                        if (rdata !== 32'h0000_0000)
                          `uvm_error(get_type_name(), $sformatf("STAT_TX changed after RO write! WDATA=0x%08h READ=0x%08h", wdata, rdata))

                        if (mir !== rdata)
                                `uvm_error(get_type_name(), $sformatf("Mirror mismatch! DUT=0x%08h MIRRORED=0x%08h", rdata, mir))

                        `uvm_info(get_type_name(),"---------------------------------------------------------------",UVM_LOW)

                // 2. Write random values and check RO behavior

                repeat(`no_of_trans) begin

                        wdata = $urandom();

                        do_write(regmodel.stat_tx, wdata);

                        des = regmodel.stat_tx.get();
                        mir = regmodel.stat_tx.get_mirrored_value();

                        `uvm_info(get_type_name(), $sformatf("RO WRITE | WDATA=0x%08h DESIRED=0x%08h MIRRORED=0x%08h", wdata, des, mir), UVM_LOW)

                        // Read after write
                        do_read(regmodel.stat_tx, rdata);

                        des = regmodel.stat_tx.get();
                        mir = regmodel.stat_tx.get_mirrored_value();

                        `uvm_info(get_type_name(), $sformatf("READ AFTER WRITE | DUT=0x%08h DESIRED=0x%08h MIRRORED=0x%08h", rdata, des, mir), UVM_LOW)

                        // PORT_STATUS must remain fixed
                        if (rdata !== 32'h0000_0000)
                          `uvm_error(get_type_name(), $sformatf("STAT_TX changed after RO write! WDATA=0x%08h READ=0x%08h", wdata, rdata))

                        if (mir !== rdata)
                                `uvm_error(get_type_name(), $sformatf("Mirror mismatch! DUT=0x%08h MIRRORED=0x%08h", rdata, mir))

                        `uvm_info(get_type_name(),"---------------------------------------------------------------",UVM_LOW)
                end



                // 3. Check individual fields

                do_read(regmodel.stat_tx, rdata);

                  `uvm_info(get_type_name(), $sformatf("FIELD CHECK | RESERVED=0x%02h TX_PACKETS=0x%02h ", rdata[31:16], rdata[15:0]), UVM_LOW)

                if (rdata[31:16] !== 16'h0000)
                  `uvm_error(get_type_name(), $sformatf("RESERVED mismatch! Expected=0x00 Actual=0x%02h", rdata[31:16]))

                if (rdata[15:0] !== 16'h0000)
                  `uvm_error(get_type_name(), $sformatf("TX_PACKETS mismatch! Expected=0x01 Actual=0x%02h", rdata[15:0]))


                        // 4. Backdoor write and Frontdoor read


                wdata = 16'hABCD;

                        regmodel.stat_tx.write(status,wdata,UVM_BACKDOOR);

                        `uvm_info("SEQ",$sformatf("BACKDOOR WRITE | DATA=%0h", wdata),UVM_LOW)

                // Read after write (backdoor write should update the register)
                do_read(regmodel.stat_tx, rdata);

                `uvm_info(get_type_name(), $sformatf("FRONTDOOR READ AFTER BACKDOOR WRITE | DUT=0x%08h DESIRED=0x%08h MIRRORED=0x%08h", rdata, regmodel.stat_tx.get(), regmodel.stat_tx.get_mirrored_value()), UVM_LOW)


                  `uvm_info(get_type_name(), "================ STAT_TX CHECK END ==================", UVM_LOW)

        endtask
endclass



// stat_drop_seq 0x1c
class stat_drop_seq extends top_reg_seq;
                `uvm_object_utils(stat_drop_seq)

                function new(string name = "stat_drop_seq");
                super.new(name);
        endfunction

        task body();
                uvm_reg_data_t rdata;
                uvm_reg_data_t wdata;
                uvm_reg_data_t des;
                uvm_reg_data_t mir;
                        uvm_status_e status;

                if (regmodel == null)
                        `uvm_fatal("NO_REGMODEL", "regmodel not assigned")

                  `uvm_info(get_type_name(), "\n\n================ STAT_DROP CHECK START ================\n\n", UVM_LOW)

                // 1. Initial read - check fixed VERSION value

                do_read(regmodel.stat_drop, rdata);

                des = regmodel.stat_drop.get();
                mir = regmodel.stat_drop.get_mirrored_value();

                `uvm_info(get_type_name(), $sformatf("DEFAULT READ | DUT=0x%08h DESIRED=0x%08h MIRRORED=0x%08h", rdata, des, mir), UVM_LOW)

                if (rdata !== 32'h0000_0000)
                  `uvm_error(get_type_name(), $sformatf("STAT_DROP mismatch! Expected=0x00010200 Actual=0x%08h", rdata))

                if (mir !== rdata)
                        `uvm_error(get_type_name(), $sformatf("Mirror mismatch! DUT=0x%08h MIRRORED=0x%08h", rdata, mir))


                wdata = 16'h0001;

                        do_write(regmodel.stat_drop, wdata);

                        des = regmodel.stat_drop.get();
                        mir = regmodel.stat_drop.get_mirrored_value();

                        `uvm_info(get_type_name(), $sformatf("RO WRITE | WDATA=0x%08h DESIRED=0x%08h MIRRORED=0x%08h", wdata, des, mir), UVM_LOW)

                        // Read after write
                        do_read(regmodel.stat_drop, rdata);

                        des = regmodel.stat_drop.get();
                        mir = regmodel.stat_drop.get_mirrored_value();

                        `uvm_info(get_type_name(), $sformatf("READ AFTER WRITE | DUT=0x%08h DESIRED=0x%08h MIRRORED=0x%08h", rdata, des, mir), UVM_LOW)

                        // STAT_RX must remain fixed
                        if (rdata !== 32'h0000_0000)
                          `uvm_error(get_type_name(), $sformatf("STAT_DROP changed after RO write! WDATA=0x%08h READ=0x%08h", wdata, rdata))

                        if (mir !== rdata)
                                `uvm_error(get_type_name(), $sformatf("Mirror mismatch! DUT=0x%08h MIRRORED=0x%08h", rdata, mir))

                        `uvm_info(get_type_name(),"---------------------------------------------------------------",UVM_LOW)

                // 2. Write random values and check RO behavior

                repeat(`no_of_trans) begin

                        wdata = $urandom();

                        do_write(regmodel.stat_drop, wdata);

                        des = regmodel.stat_drop.get();
                        mir = regmodel.stat_drop.get_mirrored_value();

                        `uvm_info(get_type_name(), $sformatf("RO WRITE | WDATA=0x%08h DESIRED=0x%08h MIRRORED=0x%08h", wdata, des, mir), UVM_LOW)

                        // Read after write
                        do_read(regmodel.stat_drop, rdata);

                        des = regmodel.stat_drop.get();
                        mir = regmodel.stat_drop.get_mirrored_value();

                        `uvm_info(get_type_name(), $sformatf("READ AFTER WRITE | DUT=0x%08h DESIRED=0x%08h MIRRORED=0x%08h", rdata, des, mir), UVM_LOW)

                        // PORT_STATUS must remain fixed
                        if (rdata !== 32'h0000_0000)
                          `uvm_error(get_type_name(), $sformatf("STAT_DROP changed after RO write! WDATA=0x%08h READ=0x%08h", wdata, rdata))

                        if (mir !== rdata)
                                `uvm_error(get_type_name(), $sformatf("Mirror mismatch! DUT=0x%08h MIRRORED=0x%08h", rdata, mir))

                        `uvm_info(get_type_name(),"---------------------------------------------------------------",UVM_LOW)
                end



                // 3. Check individual fields

                do_read(regmodel.stat_drop, rdata);

                `uvm_info(get_type_name(), $sformatf("FIELD CHECK | RESERVED=0x%02h DROPPED_PACKETS=0x%02h ", rdata[31:16], rdata[15:0]), UVM_LOW)

                if (rdata[31:16] !== 16'h0000)
                  `uvm_info(get_type_name(), $sformatf("FIELD CHECK | RESERVED=0x%02h DROPPED_PACKETS=0x%02h ", rdata[31:16], rdata[15:0]), UVM_LOW)

                if (rdata[31:16] !== 16'h0000)
                  `uvm_error(get_type_name(), $sformatf("RESERVED mismatch! Expected=0x00 Actual=0x%02h", rdata[31:16]))

                if (rdata[15:0] !== 16'h0000)
                  `uvm_error(get_type_name(), $sformatf("DROPPED_PACKETS mismatch! Expected=0x01 Actual=0x%02h", rdata[15:0]))


                        // 4. Backdoor write and Frontdoor read


                wdata = 16'hABCD;

                        regmodel.stat_drop.write(status,wdata,UVM_BACKDOOR);

                        `uvm_info("SEQ",$sformatf("BACKDOOR WRITE | DATA=%0h", wdata),UVM_LOW)

                // Read after write (backdoor write should update the register)
                  do_read(regmodel.stat_drop, rdata);

                `uvm_info(get_type_name(), $sformatf("FRONTDOOR READ AFTER BACKDOOR WRITE | DUT=0x%08h DESIRED=0x%08h MIRRORED=0x%08h", rdata, regmodel.stat_drop.get(), regmodel.stat_drop.get_mirrored_value()), UVM_LOW)

                                // Backdoor access is added to verify the internal STAT_DROP counter
                                // value and to check whether the RAL HDL path is configured correctly.
                                // Frontdoor access is used to verify the register through the APB interface.

                  `uvm_info(get_type_name(), "================ STAT_DROP CHECK END ==================", UVM_LOW)

        endtask
endclass



// switch_ctrl_seq 0x20
class switch_ctrl_seq extends top_reg_seq;
        `uvm_object_utils(switch_ctrl_seq)

        function new(string name = "switch_ctrl_seq");
                super.new(name);
        endfunction

        task body();

                uvm_reg_data_t rdata;
                uvm_reg_data_t wdata;
                uvm_reg_data_t des;
                uvm_reg_data_t mir;
                uvm_reg_data_t exp_data;
                uvm_status_e status;

                if (regmodel == null)
                `uvm_fatal("NO_REGMODEL", "regmodel not assigned")

                `uvm_info(get_type_name(),"================ SWITCH_CTRL CHECK START ================",UVM_LOW)

                // 1. Initial read - check reset value

                do_read(regmodel.switch_ctrl, rdata);

                des = regmodel.switch_ctrl.get();
                mir = regmodel.switch_ctrl.get_mirrored_value();

                `uvm_info("SEQ",$sformatf("RESET READ | DUT=%08h DESIRED=%08h MIRRORED=%08h",rdata, des, mir), UVM_LOW)

                if (rdata !== 32'h0000_0000)
                `uvm_error("SWITCH_CTRL",$sformatf("RESET VALUE ERROR | Expected=00000000 Got=%08h",rdata))

                if (mir !== rdata)
                `uvm_error("SWITCH_CTRL",$sformatf("RESET MIRROR MISMATCH | DUT=%08h MIRRORED=%08h",rdata, mir))


                // 2. Unlock DUT
                // LOCK address = 0x5C
                // Unlock key = A5A5_C3C3

                wdata = 32'hA5A5_C3C3;

                do_write(regmodel.lock, wdata);

                `uvm_info("SEQ", "DUT UNLOCK KEY WRITTEN", UVM_LOW)


                // 3. Read LOCK register
                // Expected = 0 because DUT is unlocked

                do_read(regmodel.lock, rdata);

                `uvm_info("SEQ",$sformatf("LOCK READ | DUT=%08h", rdata), UVM_LOW)

                if (rdata !== 32'h0000_0000)
                `uvm_error("LOCK",$sformatf("DUT NOT UNLOCKED | Expected=00000000 Got=%08h", rdata))

                // 4. SWITCH_CTRL random write/read test
                //
                // Bit 0    = ENABLE
                // Bit 1    = STAT_CLR pulse
                // Bit 2    = Reserved
                // Bit 3    = IRQ_GLOBAL_EN
                // Bits 31:4 = Reserved

                repeat (`no_of_trans) begin

                wdata = $urandom();

                exp_data = {28'h0, wdata[3], 2'b00, wdata[0]};

                // WRITE
                do_write(regmodel.switch_ctrl, wdata);

                des = regmodel.switch_ctrl.get();
                mir = regmodel.switch_ctrl.get_mirrored_value();

                `uvm_info("SEQ",$sformatf("WRITE | WDATA=%08h DESIRED=%08h MIRRORED=%08h",wdata, des, mir), UVM_LOW)

                        // READ AFTER WRITE
                do_read(regmodel.switch_ctrl, rdata);

                des = regmodel.switch_ctrl.get();
                mir = regmodel.switch_ctrl.get_mirrored_value();

                `uvm_info("SEQ",$sformatf("READ AFTER WRITE | DUT=%08h EXPECTED=%08h DESIRED=%08h MIRRORED=%08h", rdata, exp_data, des, mir), UVM_LOW)

                // Check ENABLE bit
                if (rdata[0] !== wdata[0])
                        `uvm_error("SWITCH_CTRL",$sformatf("ENABLE MISMATCH | Expected=%0b Got=%0b",wdata[0], rdata[0]))

                // Check IRQ_GLOBAL_EN bit
                if (rdata[3] !== wdata[3])
                                `uvm_error("SWITCH_CTRL",$sformatf("IRQ_GLOBAL_EN MISMATCH | Expected=%0b Got=%0b",wdata[3], rdata[3]))

                // Check reserved bits
                if ((rdata[31:4] !== 28'h0) || (rdata[2] !== 1'b0))
                        `uvm_error("SWITCH_CTRL",$sformatf("RESERVED BITS ERROR | DATA=%08h", rdata))

                // Check complete readback
                if (rdata !== exp_data)
                        `uvm_error("SWITCH_CTRL",$sformatf("READBACK MISMATCH | Expected=%08h Got=%08h",exp_data, rdata))
                else
                        `uvm_info("SWITCH_CTRL",$sformatf("READBACK PASS | Expected=%08h Got=%08h",exp_data, rdata), UVM_LOW)

                `uvm_info(get_type_name(),"---------------------------------------------------------------",UVM_LOW)
                end

                // 5. Backdoor write/read test

                wdata = 32'h0000_000F;

                regmodel.switch_ctrl.write(status, wdata, UVM_BACKDOOR);

                if (status != UVM_IS_OK)
                `uvm_error("SWITCH_CTRL", "Backdoor write failed")

                `uvm_info("SEQ",$sformatf("BACKDOOR WRITE | DATA=%08h", wdata),UVM_LOW)

                regmodel.switch_ctrl.read(status, rdata, UVM_BACKDOOR);

                if (status != UVM_IS_OK)
                        `uvm_error("SWITCH_CTRL", "Backdoor read failed")

                `uvm_info("SEQ",$sformatf("BACKDOOR READ | DATA=%08h", rdata),UVM_LOW)

            if (rdata !== 4'b1001)
                `uvm_error("SWITCH_CTRL",$sformatf("BACKDOOR MISMATCH | Expected=%08h Got=%08h", wdata, rdata))
                else
                `uvm_info("SWITCH_CTRL","BACKDOOR READ/WRITE PASS", UVM_LOW)


                `uvm_info(get_type_name(),"================ SWITCH_CTRL CHECK END ==================",UVM_LOW)

    endtask
endclass





//port_enable (0x24)
class port_enable_seq extends top_reg_seq;

        `uvm_object_utils(port_enable_seq)

        function new(string name = "port_enable_seq");
                super.new(name);
        endfunction


        task body();

            uvm_reg_data_t rdata;
            uvm_reg_data_t wdata;
            uvm_reg_data_t des;
            uvm_reg_data_t mir;

            uvm_status_e status;


                if (regmodel == null)
                `uvm_fatal("NO_REGMODEL","regmodel is not assigned")


                `uvm_info(get_type_name(),"================ PORT_ENABLE CHECK START ================",UVM_LOW)


                // 1. Read PORT_ENABLE after reset
                // Expected reset value = 0x0000000F

                do_read(regmodel.port_enable, rdata);

                des = regmodel.port_enable.get();
                mir = regmodel.port_enable.get_mirrored_value();

                `uvm_info("SEQ",$sformatf("DEFAULT READ | DUT=%0h DESIRED=%0h MIRRORED=%0h",rdata, des, mir),UVM_LOW)


                if (rdata !== 32'h0000_000F) begin
                `uvm_error("PORT_ENABLE",$sformatf("RESET VALUE ERROR | Expected=0000000F Got=%0h", rdata))
                end


                // 2. Unlock DUT
                // LOCK address = 0x5C
                // Unlock key = A5A5_C3C3

                wdata = 32'hA5A5_C3C3;

                do_write(regmodel.lock, wdata);

                `uvm_info("SEQ","DUT UNLOCK KEY WRITTEN",UVM_LOW)

                // 3. Read LOCK register

                do_read(regmodel.lock, rdata);

                `uvm_info("SEQ",$sformatf("LOCK READ | DUT=%0h", rdata),UVM_LOW)


                if (rdata !== 32'h0000_0000) begin
                `uvm_error("LOCK",$sformatf("DUT NOT UNLOCKED | Expected=0 Got=%0h",rdata))
                end


                // 4. PORT_ENABLE random write/read

                repeat (`no_of_trans) begin

                // Generate random data
                wdata = $urandom();

                // Only lower 4 bits are valid


                // WRITE

                do_write(regmodel.port_enable, wdata);

                des = regmodel.port_enable.get();
                mir = regmodel.port_enable.get_mirrored_value();

                `uvm_info("SEQ",$sformatf("WRITE | WDATA=%0h DESIRED=%0h MIRRORED=%0h", wdata, des, mir),UVM_LOW)

                    // READ AFTER WRITE

                do_read(regmodel.port_enable, rdata);

                    des = regmodel.port_enable.get();
                mir = regmodel.port_enable.get_mirrored_value();

                `uvm_info("SEQ",$sformatf("READ AFTER WRITE | DUT=%0h DESIRED=%0h MIRRORED=%0h",rdata, des, mir),UVM_LOW)


                // Check reserved bits

                if (rdata[31:4] !== 28'h0) begin
                        `uvm_error("PORT_ENABLE",$sformatf("Reserved bits are not zero | DATA=%0h",rdata))
                end


                // Check valid bits
                if (rdata[3:0] !== wdata[3:0]) begin
                        `uvm_error("PORT_ENABLE",$sformatf("DATA MISMATCH | Expected=%0h Got=%0h",wdata[3:0], rdata[3:0]))
                end
                else begin
                        `uvm_info("SEQ",$sformatf("PORT_ENABLE PASS | Expected=%0h Got=%0h",wdata[3:0], rdata[3:0]),UVM_LOW)
                end
                `uvm_info(get_type_name(), "---------------------------------------------------------------", UVM_LOW)
                end


                // 5. Backdoor write/read
                wdata = 32'hFFFF_AAAA;


                regmodel.port_enable.write(status,wdata,UVM_BACKDOOR);

                `uvm_info("SEQ",$sformatf("BACKDOOR WRITE | DATA=%0h", wdata),UVM_LOW)


                regmodel.port_enable.read(status,rdata,UVM_BACKDOOR );

                `uvm_info("SEQ",$sformatf("BACKDOOR READ AFTER WRITE | DATA=%0h", rdata), UVM_LOW)


            if (rdata !== wdata[3:0]) begin
                `uvm_error("PORT_ENABLE",$sformatf("BACKDOOR MISMATCH | Expected=%0h Got=%0h",wdata, rdata))
                end
                else begin
                `uvm_info("SEQ","BACKDOOR READ/WRITE PASS",UVM_LOW)
                end


                `uvm_info(get_type_name(),"================ PORT_ENABLE CHECK END ================",UVM_LOW)

    endtask

endclass



//fwd_enable (0x28)
class fwd_enable_seq extends top_reg_seq;

        `uvm_object_utils(fwd_enable_seq)

        function new(string name = "fwd_enable_seq");
                super.new(name);
        endfunction


        task body();

            uvm_reg_data_t rdata;
            uvm_reg_data_t wdata;
            uvm_reg_data_t des;
            uvm_reg_data_t mir;

            uvm_status_e status;


                if (regmodel == null)
                `uvm_fatal("NO_REGMODEL","regmodel is not assigned")


              `uvm_info(get_type_name(),"================ FWD_ENABLE CHECK START ================",UVM_LOW)


                // 1. Read PORT_ENABLE after reset

            do_read(regmodel.fwd_enable, rdata);

                des = regmodel.fwd_enable.get();
                mir = regmodel.fwd_enable.get_mirrored_value();

                `uvm_info("SEQ",$sformatf("DEFAULT READ | DUT=%0h DESIRED=%0h MIRRORED=%0h",rdata, des, mir),UVM_LOW)


                if (rdata !== 32'h0000_000F) begin
              `uvm_error("FWD_ENABLE",$sformatf("RESET VALUE ERROR | Expected=0000000F Got=%0h", rdata))
                end


                // 2. Unlock DUT
                // LOCK address = 0x5C
                // Unlock key = A5A5_C3C3

                wdata = 32'hA5A5_C3C3;

                do_write(regmodel.lock, wdata);

                `uvm_info("SEQ","DUT UNLOCK KEY WRITTEN",UVM_LOW)

                // 3. Read LOCK register
                // Expected = 0 because DUT is unlocked

                do_read(regmodel.lock, rdata);

                `uvm_info("SEQ",$sformatf("LOCK READ | DUT=%0h", rdata),UVM_LOW)


                if (rdata !== 32'h0000_0000) begin
                `uvm_error("LOCK",$sformatf("DUT NOT UNLOCKED | Expected=0 Got=%0h",rdata))
                end


                // 4. PORT_ENABLE random write/read

                repeat (`no_of_trans) begin

                // Generate random data
                wdata = $urandom();

                // Only lower 4 bits are valid


                // WRITE

                do_write(regmodel.fwd_enable, wdata);

                des = regmodel.fwd_enable.get();
                mir = regmodel.fwd_enable.get_mirrored_value();

                `uvm_info("SEQ",$sformatf("WRITE | WDATA=%0h DESIRED=%0h MIRRORED=%0h", wdata, des, mir),UVM_LOW)

                    // READ AFTER WRITE

                do_read(regmodel.fwd_enable, rdata);

                    des = regmodel.fwd_enable.get();
                mir = regmodel.fwd_enable.get_mirrored_value();

                `uvm_info("SEQ",$sformatf("READ AFTER WRITE | DUT=%0h DESIRED=%0h MIRRORED=%0h",rdata, des, mir),UVM_LOW)


                // Check reserved bits

                if (rdata[31:4] !== 28'h0) begin
                  `uvm_error("FWD_ENABLE",$sformatf("Reserved bits are not zero | DATA=%0h",rdata))
                end


                // Check valid bits
                if (rdata[3:0] !== wdata[3:0]) begin
                  `uvm_error("FWD_ENABLE",$sformatf("DATA MISMATCH | Expected=%0h Got=%0h",wdata[3:0], rdata[3:0]))
                end
                else begin
                        `uvm_info("SEQ",$sformatf("PORT_ENABLE PASS | Expected=%0h Got=%0h",wdata[3:0], rdata[3:0]),UVM_LOW)
                end
                `uvm_info(get_type_name(), "---------------------------------------------------------------", UVM_LOW)
                end


                // 5. Backdoor write/read

                wdata = 32'hFFFF_FFFF;


                regmodel.fwd_enable.write(status,wdata,UVM_BACKDOOR);

                `uvm_info("SEQ",$sformatf("BACKDOOR WRITE | DATA=%0h", wdata),UVM_LOW)


                regmodel.fwd_enable.read(status,rdata,UVM_BACKDOOR );

                `uvm_info("SEQ",$sformatf("BACKDOOR READ AFTER WRITE | DATA=%0h", rdata), UVM_LOW)


            if (rdata !== wdata[3:0]) begin
              `uvm_error("FWD_ENABLE",$sformatf("BACKDOOR MISMATCH | Expected=%0h Got=%0h",wdata, rdata))
                end
                else begin
                `uvm_info("SEQ","BACKDOOR READ/WRITE PASS",UVM_LOW)
                end


          `uvm_info(get_type_name(),"================ FWD_ENABLE CHECK END ================",UVM_LOW)

    endtask

endclass



// gen_ctrl_seq 0x2C
class gen_ctrl_seq extends top_reg_seq;
                `uvm_object_utils(gen_ctrl_seq)

        function new(string name = "gen_ctrl_seq");
                super.new(name);
        endfunction

        task body();

                uvm_reg_data_t rdata;
                uvm_reg_data_t wdata;
                uvm_reg_data_t des;
                uvm_reg_data_t mir;
                uvm_reg_data_t exp_data;
                uvm_status_e status;

                if (regmodel == null)
                `uvm_fatal("NO_REGMODEL", "regmodel not assigned")

            `uvm_info(get_type_name(),"================ GEN_CTRL CHECK START ================",UVM_LOW)

                // 1. Initial read - check reset value

                do_read(regmodel.gen_ctrl, rdata);

                des = regmodel.gen_ctrl.get();
                mir = regmodel.gen_ctrl.get_mirrored_value();

                `uvm_info("SEQ",$sformatf("RESET READ | DUT=%08h DESIRED=%08h MIRRORED=%08h",rdata, des, mir), UVM_LOW)

                if (rdata !== 32'h0000_0000)
                `uvm_error("GEN_CTRL",$sformatf("RESET VALUE ERROR | Expected=00000000 Got=%08h",rdata))

                if (mir !== rdata)
                `uvm_error("GEN_CTRL",$sformatf("RESET MIRROR MISMATCH | DUT=%08h MIRRORED=%08h",rdata, mir))


                // 2. Unlock DUT
                // LOCK address = 0x5C
                // Unlock key = A5A5_C3C3

                wdata = 32'hA5A5_C3C3;

                do_write(regmodel.lock, wdata);

                `uvm_info("SEQ", "DUT UNLOCK KEY WRITTEN", UVM_LOW)


                // 3. Read LOCK register

                do_read(regmodel.lock, rdata);

                `uvm_info("SEQ",$sformatf("LOCK READ | DUT=%08h", rdata), UVM_LOW)

                if (rdata !== 32'h0000_0000)
                `uvm_error("LOCK",$sformatf("DUT NOT UNLOCKED | Expected=00000000 Got=%08h", rdata))


                // 4. GEN_CTRL random write/read test
                // Bit 0    = ENABLE
                // Bit 1    = START
                // Bit 2    = STOP
                // Bit 3    = CONTINUOUS
                // Bits 31:4 = Reserved

                repeat (`no_of_trans) begin

                wdata = $urandom();

                exp_data = {28'h0, wdata[3], 2'b00, wdata[0]};

                // WRITE
                do_write(regmodel.gen_ctrl, wdata);

                des = regmodel.gen_ctrl.get();
                mir = regmodel.gen_ctrl.get_mirrored_value();

                `uvm_info("SEQ",$sformatf("WRITE | WDATA=%08h DESIRED=%08h MIRRORED=%08h",wdata, des, mir), UVM_LOW)

                        // READ AFTER WRITE
                do_read(regmodel.gen_ctrl, rdata);

                des = regmodel.gen_ctrl.get();
                mir = regmodel.gen_ctrl.get_mirrored_value();

                `uvm_info("SEQ",$sformatf("READ AFTER WRITE | DUT=%08h EXPECTED=%08h DESIRED=%08h MIRRORED=%08h", rdata, exp_data, des, mir), UVM_LOW)

                // Check ENABLE bit
                if (rdata[0] !== wdata[0])
                        `uvm_error("GEN_CTRL",$sformatf("ENABLE MISMATCH | Expected=%0b Got=%0b",wdata[0], rdata[0]))

                // Check CONTINUOUS bit
                if (rdata[3] !== wdata[3])
                        `uvm_error("GEN_CTRL",$sformatf("CONTINUOUS MISMATCH | Expected=%0b Got=%0b",wdata[3], rdata[3]))

                // Check reserved bits
                if ((rdata[31:4] !== 28'h0) || (rdata[2] !== 1'b0))
                        `uvm_error("GEN_CTRL",$sformatf("RESERVED BITS ERROR | DATA=%08h", rdata))

                // Check complete readback
                if (rdata !== exp_data)
                        `uvm_error("GEN_CTRL",$sformatf("READBACK MISMATCH | Expected=%08h Got=%08h",exp_data, rdata))
                else
                        `uvm_info("SWITCH_CTRL",$sformatf("READBACK PASS | Expected=%08h Got=%08h",exp_data, rdata), UVM_LOW)

                `uvm_info(get_type_name(),"---------------------------------------------------------------",UVM_LOW)
                end


                // 5. Backdoor write/read test

                wdata = 32'hFFFF_ABCF;

                regmodel.gen_ctrl.write(status, wdata, UVM_BACKDOOR);

                if (status != UVM_IS_OK)
                `uvm_error("GEN_CTRL", "Backdoor write failed")

                `uvm_info("SEQ",$sformatf("BACKDOOR WRITE | DATA=%08h", wdata),UVM_LOW)

                regmodel.gen_ctrl.read(status, rdata, UVM_BACKDOOR);

                if (status != UVM_IS_OK)
                `uvm_error("GEN_CTRL", "Backdoor read failed")

                `uvm_info("SEQ",$sformatf("BACKDOOR READ | DATA=%08h", rdata),UVM_LOW)

            if (rdata !== 4'b1001)
                `uvm_error("GEN_CTRL",$sformatf("BACKDOOR MISMATCH | Expected=%08h Got=%08h", wdata, rdata))
                else
                `uvm_info("GEN_CTRL","BACKDOOR READ/WRITE PASS", UVM_LOW)


              `uvm_info(get_type_name(),"================ GEN_CTRL CHECK END ==================",UVM_LOW)

    endtask
endclass


// gen_pkt_cfg_seq 0x30
class gen_pkt_cfg_seq extends top_reg_seq;
                `uvm_object_utils(gen_pkt_cfg_seq)

        function new(string name = "gen_pkt_cfg_seq");
                super.new(name);
        endfunction

        task body();

                uvm_reg_data_t rdata;
                uvm_reg_data_t wdata;
                uvm_reg_data_t des;
                uvm_reg_data_t mir;
                uvm_reg_data_t exp_data;
                uvm_status_e status;

                if (regmodel == null)
                `uvm_fatal("NO_REGMODEL", "regmodel not assigned")

              `uvm_info(get_type_name(),"================ GEN_PKT_CFG CHECK START ================",UVM_LOW)

                // 1. Initial read - check reset value

                do_read(regmodel.gen_pkt_cfg, rdata);

                des = regmodel.gen_pkt_cfg.get();
                mir = regmodel.gen_pkt_cfg.get_mirrored_value();

                `uvm_info("SEQ",$sformatf("RESET READ | DUT=%08h DESIRED=%08h MIRRORED=%08h",rdata, des, mir), UVM_LOW)

                if (rdata !== 32'h0000_0401)
                `uvm_error("GEN_PKT_CFG",$sformatf("RESET VALUE ERROR | Expected=00000401 Got=%08h",rdata))

                if (mir !== rdata)
                `uvm_error("GEN_PKT_CFG",$sformatf("RESET MIRROR MISMATCH | DUT=%08h MIRRORED=%08h",rdata, mir))


                // 2. Unlock DUT
                // LOCK address = 0x5C
                // Unlock key = A5A5_C3C3

                wdata = 32'hA5A5_C3C3;

                do_write(regmodel.lock, wdata);

                `uvm_info("SEQ", "DUT UNLOCK KEY WRITTEN", UVM_LOW)


                // 3. Read LOCK register
                // Expected = 0 because DUT is unlocked

                do_read(regmodel.lock, rdata);

                `uvm_info("SEQ",$sformatf("LOCK READ | DUT=%08h", rdata), UVM_LOW)

                if (rdata !== 32'h0000_0000)
                `uvm_error("LOCK",$sformatf("DUT NOT UNLOCKED | Expected=00000000 Got=%08h", rdata))


                // 4. GEN_PKT_CFG random write/read test
                //
            // Bit [23:16]    = SEED
            // Bit [15:8]    = LENGTH
            // Bit [3:2]    = SRC_PORT
            // Bit [1:0]    = DST_PORT


                repeat (`no_of_trans) begin

                wdata = $urandom();

                exp_data = {8'h00, wdata[23:16], (wdata[15:8] == 8'd0) ? 8'd1 : wdata[15:8], 4'h0, wdata[3:2], wdata[1:0]};

                // WRITE
                do_write(regmodel.gen_pkt_cfg, wdata);

                des = regmodel.gen_pkt_cfg.get();
                mir = regmodel.gen_pkt_cfg.get_mirrored_value();

                `uvm_info("SEQ",$sformatf("WRITE | WDATA=%08h DESIRED=%08h MIRRORED=%08h",wdata, des, mir), UVM_LOW)

                        // READ AFTER WRITE
                do_read(regmodel.gen_pkt_cfg, rdata);

                des = regmodel.gen_pkt_cfg.get();
                mir = regmodel.gen_pkt_cfg.get_mirrored_value();

                `uvm_info("SEQ",$sformatf("READ AFTER WRITE | DUT=%08h EXPECTED=%08h DESIRED=%08h MIRRORED=%08h", rdata, exp_data, des, mir), UVM_LOW)

                // Check SEED bit
                if (rdata[23:16] !== wdata[23:16])
                        `uvm_error("GEN_PKT_CFG",$sformatf("SEED MISMATCH | Expected=%0b Got=%0b",wdata[23:16], rdata[23:16]))

                // Check LENGTH bit
                if (rdata[15:8] !== wdata[15:8])
                    `uvm_error("GEN_PKT_CFG",$sformatf("LENGTH MISMATCH | Expected=%0b Got=%0b",wdata[15:8], rdata[15:8]))

                // Check SRC_PORT bit
                if (rdata[3:2] !== wdata[3:2])
                        `uvm_error("GEN_PKT_CFG",$sformatf("SRC_PORT MISMATCH | Expected=%0b Got=%0b",wdata[3:2], rdata[3:2]))

                // Check DST_PORT bit
                if (rdata[1:0] !== wdata[1:0])
                    `uvm_error("GEN_PKT_CFG",$sformatf("DST_PORT MISMATCH | Expected=%0b Got=%0b",wdata[1:0], rdata[1:0]))

                // Check reserved bits
                if ((rdata[31:24] !== 8'h00) || (rdata[7:4] !== 4'h0))
                    `uvm_error("GEN_PKT_CFG",$sformatf("RESERVED BITS ERROR | DATA=%08h", rdata))

                // Check complete readback
                if (rdata !== exp_data)
                        `uvm_error("GEN_PKT_CFG",$sformatf("READBACK MISMATCH | Expected=%08h Got=%08h",exp_data, rdata))
                else
                        `uvm_info("GEN_PKT_CFG",$sformatf("READBACK PASS | Expected=%08h Got=%08h",exp_data, rdata), UVM_LOW)

                `uvm_info(get_type_name(),"---------------------------------------------------------------",UVM_LOW)
                end

            // one more test to check LENGTH field behaviour
            wdata = 32'hFF12_00CF;
            exp_data = {8'h00, wdata[23:16], (wdata[15:8] == 8'd0) ? 8'd1 : wdata[15:8], 4'h0, wdata[3:2], wdata[1:0]};

              `uvm_info(get_type_name(),"-LENGTH FIELD CHECK-",UVM_LOW)

            // WRITE
            do_write(regmodel.gen_pkt_cfg, wdata);

            des = regmodel.gen_pkt_cfg.get();
            mir = regmodel.gen_pkt_cfg.get_mirrored_value();

            `uvm_info("SEQ",$sformatf("WRITE | WDATA=%08h DESIRED=%08h MIRRORED=%08h",wdata, des, mir), UVM_LOW)

            // READ AFTER WRITE
            do_read(regmodel.gen_pkt_cfg, rdata);

            des = regmodel.gen_pkt_cfg.get();
            mir = regmodel.gen_pkt_cfg.get_mirrored_value();

            `uvm_info("SEQ",$sformatf("READ AFTER WRITE | DUT=%08h EXPECTED=%08h DESIRED=%08h MIRRORED=%08h", rdata, exp_data, des, mir), UVM_LOW)

            // Check SEED bit
            if (rdata[23:16] !== wdata[23:16])
                `uvm_error("GEN_PKT_CFG",$sformatf("SEED MISMATCH | Expected=%0b Got=%0b",wdata[23:16], rdata[23:16]))

            // Check LENGTH bit
            if (rdata[15:8] !== 8'h1)
                `uvm_error("GEN_PKT_CFG",$sformatf("LENGTH MISMATCH | Expected=%0b Got=%0b",wdata[15:8], rdata[15:8]))

            // Check SRC_PORT bit
            if (rdata[3:2] !== wdata[3:2])
                `uvm_error("GEN_PKT_CFG",$sformatf("SRC_PORT MISMATCH | Expected=%0b Got=%0b",wdata[3:2], rdata[3:2]))

            // Check DST_PORT bit
            if (rdata[1:0] !== wdata[1:0])
                `uvm_error("GEN_PKT_CFG",$sformatf("DST_PORT MISMATCH | Expected=%0b Got=%0b",wdata[1:0], rdata[1:0]))

            // Check reserved bits
            if ((rdata[31:24] !== 8'h00) || (rdata[7:4] !== 4'h0))
                `uvm_error("GEN_PKT_CFG",$sformatf("RESERVED BITS ERROR | DATA=%08h", rdata))

            // Check complete readback
            if (rdata !== exp_data)
                `uvm_error("GEN_PKT_CFG",$sformatf("READBACK MISMATCH | Expected=%08h Got=%08h",exp_data, rdata))
            else
                `uvm_info("GEN_PKT_CFG",$sformatf("READBACK PASS | Expected=%08h Got=%08h",exp_data, rdata), UVM_LOW)

            `uvm_info(get_type_name(),"---------------------------------------------------------------",UVM_LOW)


                // 5. Backdoor write/read test

                wdata = 32'hAABB_ABCF;

                regmodel.gen_pkt_cfg.write(status, wdata, UVM_BACKDOOR);

                if (status != UVM_IS_OK)
                `uvm_error("GEN_PKT_CFG", "Backdoor write failed")

                `uvm_info("SEQ",$sformatf("BACKDOOR WRITE | DATA=%08h", wdata),UVM_LOW)
		regmodel.gen_pkt_cfg.read(status, rdata, UVM_BACKDOOR);

            if (rdata !== 32'h00BBAB0F)
                `uvm_error("GEN_PKT_CFG",$sformatf("BACKDOOR MISMATCH | Expected=%08h Got=%08h", wdata, rdata))
                else
                `uvm_info("GEN_PKT_CFG","BACKDOOR READ/WRITE PASS", UVM_LOW)


              `uvm_info(get_type_name(),"================ GEN_PKT_CFG CHECK END ==================",UVM_LOW)

    endtask
endclass


// gen_interval_seq 0x34
class gen_interval_seq extends top_reg_seq;
                `uvm_object_utils(gen_interval_seq)

                function new(string name = "gen_interval_seq");
                super.new(name);
        endfunction

        task body();

                uvm_reg_data_t rdata;
                uvm_reg_data_t wdata;
                uvm_reg_data_t des;
                uvm_reg_data_t mir;
                uvm_status_e status;

                if (regmodel == null)
                `uvm_fatal("NO_REGMODEL", "regmodel not assigned")

              `uvm_info(get_type_name(),"================ GEN_INTERVAL CHECK START ================",UVM_LOW)

                // 1. Initial read - check reset value

                do_read(regmodel.gen_interval, rdata);

                des = regmodel.gen_interval.get();
                mir = regmodel.gen_interval.get_mirrored_value();

                `uvm_info("SEQ",$sformatf("RESET READ | DUT=%08h DESIRED=%08h MIRRORED=%08h",rdata, des, mir), UVM_LOW)

            if (rdata !== 32'h0000_0002)
                `uvm_error("GEN_INTERVAL",$sformatf("RESET VALUE ERROR | Expected=00000401 Got=%08h",rdata))

                if (mir !== rdata)
                `uvm_error("GEN_INTERVAL",$sformatf("RESET MIRROR MISMATCH | DUT=%08h MIRRORED=%08h",rdata, mir))


                // 2. Unlock DUT
                // LOCK address = 0x5C
                // Unlock key = A5A5_C3C3

                wdata = 32'hA5A5_C3C3;

                do_write(regmodel.lock, wdata);

                `uvm_info("SEQ", "DUT UNLOCK KEY WRITTEN", UVM_LOW)


                // 3. Read LOCK register
                // Expected = 0 because DUT is unlocked

                do_read(regmodel.lock, rdata);

                `uvm_info("SEQ",$sformatf("LOCK READ | DUT=%08h", rdata), UVM_LOW)

                if (rdata !== 32'h0000_0000)
                `uvm_error("LOCK",$sformatf("DUT NOT UNLOCKED | Expected=00000000 Got=%08h", rdata))

                // 4. GEN_INTERVAL random write/read test
              // Bit [15:0] - written INTERVAL


                repeat (`no_of_trans) begin

                wdata = $urandom();


                // WRITE
                do_write(regmodel.gen_interval, wdata);

                des = regmodel.gen_interval.get();
                mir = regmodel.gen_interval.get_mirrored_value();

                `uvm_info("SEQ",$sformatf("WRITE | WDATA=%08h DESIRED=%08h MIRRORED=%08h",wdata, des, mir), UVM_LOW)

                        // READ AFTER WRITE
                do_read(regmodel.gen_interval, rdata);

                des = regmodel.gen_interval.get();
                mir = regmodel.gen_interval.get_mirrored_value();

                `uvm_info("SEQ",$sformatf("READ AFTER WRITE | DUT=%08h EXPECTED=%08h DESIRED=%08h MIRRORED=%08h", rdata, wdata[15:0], des, mir), UVM_LOW)

                // Check INTERVAL bit
                if (rdata[15:0] !== wdata[15:0])
                        `uvm_error("GEN_INTERVAL",$sformatf("INTERVAL MISMATCH | Expected=%0b Got=%0b",wdata[15:0], rdata[15:0]))



                // Check reserved bits
                if (rdata[31:16] !== 16'h0000)
                    `uvm_error("GEN_INTERVAL",$sformatf("RESERVED BITS ERROR | DATA=%08h", rdata))

                // Check complete readback
                if (rdata !== wdata[15:0])
                        `uvm_error("GEN_INTERVAL",$sformatf("READBACK MISMATCH | Expected=%08h Got=%08h",wdata, rdata))
                else
                  `uvm_info("GEN_INTERVAL",$sformatf("READBACK PASS | Expected=%08h Got=%08h",wdata[15:0], rdata), UVM_LOW)

                `uvm_info(get_type_name(),"---------------------------------------------------------------",UVM_LOW)
                end



                // 5. Backdoor write/read test

                wdata = 32'hAABB_ABCF;

                regmodel.gen_interval.write(status, wdata, UVM_BACKDOOR);

                if (status != UVM_IS_OK)
              `uvm_error("GEN_INTERVAL", "Backdoor write failed")

                `uvm_info("SEQ",$sformatf("BACKDOOR WRITE | DATA=%08h", wdata),UVM_LOW)

                regmodel.gen_interval.read(status, rdata, UVM_BACKDOOR);

                if (status != UVM_IS_OK)
                `uvm_error("GEN_INTERVAL", "Backdoor read failed")

                `uvm_info("SEQ",$sformatf("BACKDOOR READ | DATA=%08h", rdata),UVM_LOW)

            if (rdata !== wdata[15:0])
                `uvm_error("GEN_INTERVAL",$sformatf("BACKDOOR MISMATCH | Expected=%08h Got=%08h", wdata, rdata))
                else
                `uvm_info("GEN_INTERVAL","BACKDOOR READ/WRITE PASS", UVM_LOW)


              `uvm_info(get_type_name(),"================ GEN_PKT_CFG CHECK END ==================",UVM_LOW)

    endtask
endclass



// gen_count_seq 0x38
class gen_count_seq extends top_reg_seq;
  `uvm_object_utils(gen_count_seq)

  function new(string name = "gen_count_seq");
                super.new(name);
        endfunction

        task body();

                uvm_reg_data_t rdata;
                uvm_reg_data_t wdata;
                uvm_reg_data_t des;
                uvm_reg_data_t mir;
                uvm_status_e status;

                if (regmodel == null)
                `uvm_fatal("NO_REGMODEL", "regmodel not assigned")

            `uvm_info(get_type_name(),"================ GEN_COUNT CHECK START ================",UVM_LOW)

                // 1. Initial read - check reset value

                do_read(regmodel.gen_count, rdata);

                des = regmodel.gen_count.get();
                mir = regmodel.gen_count.get_mirrored_value();

                `uvm_info("SEQ",$sformatf("RESET READ | DUT=%08h DESIRED=%08h MIRRORED=%08h",rdata, des, mir), UVM_LOW)

          if (rdata !== 32'h0000_0004)
                `uvm_error("GEN_INTERVAL",$sformatf("RESET VALUE ERROR | Expected=00000401 Got=%08h",rdata))

                if (mir !== rdata)
                `uvm_error("GEN_INTERVAL",$sformatf("RESET MIRROR MISMATCH | DUT=%08h MIRRORED=%08h",rdata, mir))


                // 2. Unlock DUT
                // LOCK address = 0x5C
                // Unlock key = A5A5_C3C3

                wdata = 32'hA5A5_C3C3;

                do_write(regmodel.lock, wdata);

                `uvm_info("SEQ", "DUT UNLOCK KEY WRITTEN", UVM_LOW)


                // 3. Read LOCK register

                do_read(regmodel.lock, rdata);

                `uvm_info("SEQ",$sformatf("LOCK READ | DUT=%08h", rdata), UVM_LOW)

                if (rdata !== 32'h0000_0000)
                `uvm_error("LOCK",$sformatf("DUT NOT UNLOCKED | Expected=00000000 Got=%08h", rdata))


                // 4. GEN_INTERVAL random write/read test
                //
            // Bit [15:0] - written PACKET_COUNT


                repeat (`no_of_trans) begin

                wdata = $urandom();


                // WRITE
                do_write(regmodel.gen_count, wdata);

                des = regmodel.gen_count.get();
                mir = regmodel.gen_count.get_mirrored_value();

                `uvm_info("SEQ",$sformatf("WRITE | WDATA=%08h DESIRED=%08h MIRRORED=%08h",wdata, des, mir), UVM_LOW)

                        // READ AFTER WRITE
                do_read(regmodel.gen_count, rdata);

                des = regmodel.gen_count.get();
                mir = regmodel.gen_count.get_mirrored_value();

                `uvm_info("SEQ",$sformatf("READ AFTER WRITE | DUT=%08h EXPECTED=%08h DESIRED=%08h MIRRORED=%08h", rdata, wdata[15:0], des, mir), UVM_LOW)

                // Check INTERVAL bit
                if (rdata[15:0] !== wdata[15:0])
                    `uvm_error("GEN_COUNT",$sformatf("INTERVAL MISMATCH | Expected=%0b Got=%0b",wdata[15:0], rdata[15:0]))



                // Check reserved bits
                if (rdata[31:16] !== 16'h0000)
                    `uvm_error("GEN_COUNT",$sformatf("RESERVED BITS ERROR | DATA=%08h", rdata))

                // Check complete readback
                if (rdata !== wdata[15:0])
                        `uvm_error("GEN_COUNT",$sformatf("READBACK MISMATCH | Expected=%08h Got=%08h",wdata, rdata))
                else
                  `uvm_info("GEN_COUNT",$sformatf("READBACK PASS | Expected=%08h Got=%08h",wdata[15:0], rdata), UVM_LOW)

                `uvm_info(get_type_name(),"---------------------------------------------------------------",UVM_LOW)
                end



                // 5. Backdoor write/read test

                wdata = 32'hAABB_1277;

                regmodel.gen_count.write(status, wdata, UVM_BACKDOOR);

                if (status != UVM_IS_OK)
              `uvm_error("GEN_COUNT", "Backdoor write failed")

                `uvm_info("SEQ",$sformatf("BACKDOOR WRITE | DATA=%08h", wdata),UVM_LOW)

                regmodel.gen_count.read(status, rdata, UVM_BACKDOOR);

                if (status != UVM_IS_OK)
                `uvm_error("GEN_COUNT", "Backdoor read failed")

                `uvm_info("SEQ",$sformatf("BACKDOOR READ | DATA=%08h", rdata),UVM_LOW)

            if (rdata !== wdata[15:0])
                `uvm_error("GEN_COUNT",$sformatf("BACKDOOR MISMATCH | Expected=%08h Got=%08h", wdata, rdata))
                else
                `uvm_info("GEN_COUNT","BACKDOOR READ/WRITE PASS", UVM_LOW)


              `uvm_info(get_type_name(),"================ GEN_COUNT CHECK END ==================",UVM_LOW)

    endtask
endclass


// IRQ_STATUS - 0x3C
class irq_status_seq extends top_reg_seq;
        `uvm_object_utils(irq_status_seq)


        uvm_status_e status;
        uvm_reg_data_t rdata;

        function new(string name = "irq_status_seq");
                super.new(name);
        endfunction

        task body();

        if (regmodel == null) begin
                `uvm_fatal("IRQ_STATUS", "Register model handle is NULL")
        end

        `uvm_info("IRQ_STATUS","========== IRQ_STATUS CHECK START ==========", UVM_MEDIUM)

        // 1: Check reset value
        regmodel.irq_status.read(status, rdata, UVM_FRONTDOOR);

        `uvm_info("IRQ_STATUS",$sformatf("RESET READ | DUT=%08h", rdata), UVM_MEDIUM)

        if (rdata !== 32'h0000_0000) begin
                `uvm_error("IRQ_STATUS",$sformatf("RESET CHECK FAILED | Expected=00000000 Got=%08h",rdata))
        end

        // 2: Write zero to IRQ_STATUS
        regmodel.irq_status.write(status, 32'h0000_0000,UVM_FRONTDOOR);

        regmodel.irq_status.read(status, rdata, UVM_FRONTDOOR);

        `uvm_info("IRQ_STATUS",$sformatf("WRITE ZERO | DUT=%08h", rdata), UVM_MEDIUM)

        if (rdata !== 32'h0000_0000) begin
                `uvm_error("IRQ_STATUS",$sformatf("WRITE ZERO CHECK FAILED | Got=%08h", rdata))
        end

        // 3: Set SW_EVENT using IRQ_FORCE bit 7
        regmodel.irq_force.write(status, 32'h0000_0080,UVM_FRONTDOOR);

        regmodel.irq_status.read(status, rdata, UVM_FRONTDOOR);

        `uvm_info("IRQ_STATUS",$sformatf("AFTER IRQ_FORCE | DUT=%08h", rdata), UVM_MEDIUM)

        if (rdata[7] !== 1'b1) begin
                `uvm_error("IRQ_STATUS",$sformatf("IRQ_FORCE CHECK FAILED | Expected bit 7=1 Got=%08h",rdata))
        end

        // 4: Write zero to W1C status
        regmodel.irq_status.write(status, 32'h0000_0000,UVM_FRONTDOOR);

        regmodel.irq_status.read(status, rdata, UVM_FRONTDOOR);

        `uvm_info("IRQ_STATUS",$sformatf("AFTER WRITE ZERO TO W1C | DUT=%08h", rdata),UVM_MEDIUM)

        if (rdata[7] !== 1'b1) begin
                `uvm_error("IRQ_STATUS",$sformatf("W1C ZERO CHECK FAILED | Expected bit 7=1 Got=%08h",rdata))
        end
        else begin
                `uvm_info("IRQ_STATUS","PASS: Writing zero did not clear SW_EVENT", UVM_MEDIUM)
        end

        // 5: Write one to W1C bit 7
        regmodel.irq_status.write(status, 32'h0000_0080,UVM_FRONTDOOR);

        regmodel.irq_status.read(status, rdata, UVM_FRONTDOOR);

        `uvm_info("IRQ_STATUS",$sformatf("AFTER WRITE ONE TO W1C | DUT=%08h", rdata), UVM_MEDIUM)

        if (rdata[7] !== 1'b0) begin
                `uvm_error("IRQ_STATUS",$sformatf("W1C CLEAR CHECK FAILED | Expected bit 7=0 Got=%08h",rdata))
        end
        else begin
                `uvm_info("IRQ_STATUS","PASS: Writing one cleared SW_EVENT", UVM_MEDIUM)
        end

        //  6: Set SW_EVENT again and check backdoor
        regmodel.irq_force.write(status, 32'h0000_0080,UVM_FRONTDOOR);

        regmodel.irq_status.read(status, rdata, UVM_FRONTDOOR);

        `uvm_info("IRQ_STATUS",$sformatf("FRONTDOOR BEFORE BACKDOOR | DUT=%08h", rdata),UVM_MEDIUM)

        if (rdata[7] !== 1'b1) begin
                `uvm_error("IRQ_STATUS",$sformatf("FRONTDOOR PRECHECK FAILED | Expected bit 7=1 Got=%08h",rdata))
        end
        else begin
                regmodel.irq_status.read(status, rdata, UVM_BACKDOOR);

                `uvm_info("IRQ_STATUS",$sformatf("BACKDOOR READ | DATA=%08h", rdata), UVM_MEDIUM)

                if (rdata[7] !== 1'b1) begin
                        `uvm_error("IRQ_STATUS",$sformatf("BACKDOOR PATH CHECK FAILED | Expected bit 7=1 Got=%08h",rdata))
                end
                else begin
                        `uvm_info("IRQ_STATUS","PASS: Backdoor read detected SW_EVENT", UVM_MEDIUM)
                end
        end

        //  7: Clear SW_EVENT again
        regmodel.irq_status.write(status, 32'h0000_0080,UVM_FRONTDOOR);

        regmodel.irq_status.read(status, rdata, UVM_FRONTDOOR);

        `uvm_info("IRQ_STATUS",$sformatf("FINAL READ | DUT=%08h", rdata), UVM_MEDIUM)

        if (rdata[7] !== 1'b0) begin
                `uvm_error("IRQ_STATUS",$sformatf("FINAL CLEAR FAILED | Expected bit 7=0 Got=%08h",rdata))
        end
        else begin
                `uvm_info("IRQ_STATUS","PASS: SW_EVENT cleared successfully", UVM_MEDIUM)
        end

        `uvm_info("IRQ_STATUS","========== IRQ_STATUS CHECK END ==========", UVM_MEDIUM)

        endtask

endclass


//irq_enable(0x40)
class irq_enable_seq extends top_reg_seq;
                `uvm_object_utils(irq_enable_seq)

                function new(string name = "irq_enable_seq");
                super.new(name);
        endfunction

        task body();

                uvm_reg_data_t rdata;
                uvm_reg_data_t wdata;
                uvm_reg_data_t des;
                uvm_reg_data_t mir;
                uvm_status_e status;

                if (regmodel == null)
                `uvm_fatal("NO_REGMODEL", "regmodel not assigned")

            `uvm_info(get_type_name(),"================ IRQ_ENABLE CHECK START ================",UVM_LOW)

                // 1. Initial read - check reset value

            do_read(regmodel.irq_enable, rdata);

                des = regmodel.irq_enable.get();
                mir = regmodel.irq_enable.get_mirrored_value();

                `uvm_info("SEQ",$sformatf("RESET READ | DUT=%08h DESIRED=%08h MIRRORED=%08h",rdata, des, mir), UVM_LOW)

            if (rdata !== 32'h0000_0000)
                `uvm_error("IRQ_ENABLE",$sformatf("RESET VALUE ERROR | Expected=00000000 Got=%08h",rdata))

                if (mir !== rdata)
                `uvm_error("IRQ_ENABLE",$sformatf("RESET MIRROR MISMATCH | DUT=%08h MIRRORED=%08h",rdata, mir))

                // 2. Unlock DUT
                // LOCK address = 0x5C
                // Unlock key = A5A5_C3C3

                wdata = 32'hA5A5_C3C3;

                do_write(regmodel.lock, wdata);

                `uvm_info("SEQ", "DUT UNLOCK KEY WRITTEN", UVM_LOW)

                // 3. Read LOCK register

                do_read(regmodel.lock, rdata);

                `uvm_info("SEQ",$sformatf("LOCK READ | DUT=%08h", rdata), UVM_LOW)

                if (rdata !== 32'h0000_0000)
                `uvm_error("LOCK",$sformatf("DUT NOT UNLOCKED | Expected=00000000 Got=%08h", rdata))


                // 4. IRQ_ENABLE random write/read test
            // Bit [7:0] - written

                repeat (`no_of_trans) begin

                wdata = $urandom();


                // WRITE
                do_write(regmodel.irq_enable, wdata);

                des = regmodel.irq_enable.get();
                mir = regmodel.irq_enable.get_mirrored_value();

                `uvm_info("SEQ",$sformatf("WRITE | WDATA=%08h DESIRED=%08h MIRRORED=%08h",wdata, des, mir), UVM_LOW)

                        // READ AFTER WRITE
                do_read(regmodel.irq_enable, rdata);

                des = regmodel.irq_enable.get();
                mir = regmodel.irq_enable.get_mirrored_value();

                `uvm_info("SEQ",$sformatf("READ AFTER WRITE | DUT=%08h EXPECTED=%08h DESIRED=%08h MIRRORED=%08h", rdata, wdata[7:0], des, mir), UVM_LOW)

                // Check bit
                if (rdata[7:0] !== wdata[7:0])
                        `uvm_error("IRQ_ENABLE",$sformatf("IRQ_ENABLE MISMATCH | Expected=%0b Got=%0b",wdata[7:0], rdata[7:0]))



                // Check reserved bits
                if (rdata[31:8] !== 24'h000000)
                    `uvm_error("IRQ_ENABLE",$sformatf("RESERVED BITS ERROR | DATA=%08h", rdata))

                // Check complete readback
                if (rdata !== wdata[7:0])
                        `uvm_error("IRQ_ENABLE",$sformatf("READBACK MISMATCH | Expected=%08h Got=%08h",wdata, rdata))
                else
                        `uvm_info("IRQ_ENABLE",$sformatf("READBACK PASS | Expected=%08h Got=%08h",wdata[7:0], rdata), UVM_LOW)

                `uvm_info(get_type_name(),"---------------------------------------------------------------",UVM_LOW)
                end


                // 5. Backdoor write/read test

                wdata = 32'hAABB_127F;

                regmodel.irq_enable.write(status, wdata, UVM_BACKDOOR);

                if (status != UVM_IS_OK)
              `uvm_error("GEN_COUNT", "Backdoor write failed")

                `uvm_info("SEQ",$sformatf("BACKDOOR WRITE | DATA=%08h", wdata),UVM_LOW)

                regmodel.irq_enable.read(status, rdata, UVM_BACKDOOR);

                if (status != UVM_IS_OK)
                `uvm_error("IRQ_ENABLE", "Backdoor read failed")

                `uvm_info("SEQ",$sformatf("BACKDOOR READ | DATA=%08h", rdata),UVM_LOW)

            if (rdata !== wdata[7:0])
                `uvm_error("IRQ_ENABLE",$sformatf("BACKDOOR MISMATCH | Expected=%08h Got=%08h", wdata, rdata))
                else
                `uvm_info("IRQ_ENABLE","BACKDOOR READ/WRITE PASS", UVM_LOW)


              `uvm_info(get_type_name(),"================ IRQ_ENABLE CHECK END ==================",UVM_LOW)

    endtask
endclass


//irq_force(0x44)
class irq_force_seq extends top_reg_seq;
                `uvm_object_utils(irq_force_seq)

                function new(string name = "irq_force_seq");
                super.new(name);
        endfunction

        task body();

                uvm_reg_data_t rdata;
                uvm_reg_data_t wdata;
                uvm_reg_data_t des;
                uvm_reg_data_t mir;
                uvm_status_e status;

                if (regmodel == null)
                `uvm_fatal("NO_REGMODEL", "regmodel not assigned")

            `uvm_info(get_type_name(),"================ IRQ_FORCE CHECK START ================",UVM_LOW)

                // 1. Initial read - check reset value

            do_read(regmodel.irq_force, rdata);

                des = regmodel.irq_force.get();
                mir = regmodel.irq_force.get_mirrored_value();

                `uvm_info("SEQ",$sformatf("RESET READ | DUT=%08h DESIRED=%08h MIRRORED=%08h",rdata, des, mir), UVM_LOW)

            if (rdata !== 32'h0000_0000)
                `uvm_error("IRQ_FORCE",$sformatf("RESET VALUE ERROR | Expected=00000000 Got=%08h",rdata))

                //if (mir !== rdata)
                //      `uvm_error("IRQ_FORCE",$sformatf("RESET MIRROR MISMATCH | DUT=%08h MIRRORED=%08h",rdata, mir))


                //  IRQ_FORCE random write/read test
            // //no read back

                repeat (`no_of_trans) begin

                wdata = $urandom();


                // WRITE
                do_write(regmodel.irq_force, wdata);

                des = regmodel.irq_force.get();
                mir = regmodel.irq_force.get_mirrored_value();

                `uvm_info("SEQ",$sformatf("WRITE | WDATA=%08h DESIRED=%08h MIRRORED=%08h",wdata, des, mir), UVM_LOW)

                        // READ AFTER WRITE
                do_read(regmodel.irq_force, rdata);

                des = regmodel.irq_force.get();
                mir = regmodel.irq_force.get_mirrored_value();

                `uvm_info("SEQ",$sformatf("READ AFTER WRITE | DUT=%08h EXPECTED=32'h0 DESIRED=%08h MIRRORED=%08h", rdata, des, mir), UVM_LOW)



                // Check complete readback
                if (rdata !== 'h0)
                    `uvm_error("IRQ_FORCE",$sformatf("READBACK MISMATCH | Expected=32'h0 Got=%08h", rdata))
                else
                    `uvm_info("IRQ_FORCE",$sformatf("READBACK PASS | Expected=32'h0 Got=%032h", rdata), UVM_LOW)

                `uvm_info(get_type_name(),"---------------------------------------------------------------",UVM_LOW)
                end


                // 5. Backdoor write/read test

                wdata = 32'hAABB_1277;

                regmodel.irq_force.write(status, wdata, UVM_BACKDOOR);

                if (status != UVM_IS_OK)
              `uvm_error("IRQ_FORCE", "Backdoor write failed")

                `uvm_info("SEQ",$sformatf("BACKDOOR WRITE | DATA=%08h", wdata),UVM_LOW)

                regmodel.irq_force.read(status, rdata, UVM_BACKDOOR);

                if (status != UVM_IS_OK)
                `uvm_error("IRQ_FORCE", "Backdoor read failed")

                `uvm_info("SEQ",$sformatf("BACKDOOR READ | DATA=%08h", rdata),UVM_LOW)

                if (rdata !== 'h0)
                        `uvm_error("IRQ_FORCE",$sformatf("BACKDOOR MISMATCH | Expected=32'h0 Got=%08h", rdata))
                else
                        `uvm_info("IRQ_FORCE","BACKDOOR READ/WRITE PASS", UVM_LOW)

              `uvm_info(get_type_name(),"================ IRQ_FORCE CHECK END ==================",UVM_LOW)

    endtask
endclass


//error_status 0x48
class err_status_seq extends top_reg_seq;
        `uvm_object_utils(err_status_seq)

        function new(string name = "err_status_seq");
                super.new(name);
        endfunction

        task body();

                uvm_reg_data_t rdata;
                uvm_reg_data_t wdata;
                uvm_reg_data_t des;
                uvm_reg_data_t mir;

                if (regmodel == null)
                `uvm_fatal("NO_REGMODEL", "regmodel not assigned")

                `uvm_info(get_type_name(),"================ ERR_STATUS CHECK START ================",UVM_LOW)

                // 1. Initial read - check reset value

                        do_read(regmodel.err_status, rdata);

                des = regmodel.err_status.get();
                mir = regmodel.err_status.get_mirrored_value();

                `uvm_info("SEQ",$sformatf("RESET READ | DUT=%08h DESIRED=%08h MIRRORED=%08h",rdata, des, mir), UVM_LOW)

                if (rdata !== 32'h0000_0000)
                        `uvm_error("ERR_STATUS",$sformatf("RESET VALUE ERROR | Expected=00000000 Got=%08h",rdata))

                if (mir !== rdata)
                `uvm_error("ERR_STATUS",$sformatf("RESET MIRROR MISMATCH | DUT=%08h MIRRORED=%08h",rdata, mir))


                // 2. ERR_INJECT write - set all error status bits

                wdata = 32'h0000_00FF;

                do_write(regmodel.err_inject, wdata);

                `uvm_info("SEQ",$sformatf("ERR_INJECT WRITE | WDATA=%08h",wdata),UVM_LOW)

                // READ ERR_STATUS after injection

                do_read(regmodel.err_status, rdata);

                des = regmodel.err_status.get();
                mir = regmodel.err_status.get_mirrored_value();

                `uvm_info("SEQ",$sformatf("AFTER INJECTION | DUT=%08h EXPECTED=000000FF DESIRED=%08h MIRRORED=%08h",rdata, des, mir), UVM_LOW)

                if (rdata[7:0] !== 8'hFF)
                    `uvm_error("ERR_STATUS",$sformatf("INJECTION ERROR | Expected=000000FF Got=%08h",rdata))
                else
                    `uvm_info("ERR_STATUS","ALL ERROR BITS SET PASS",UVM_LOW)


                // 3. W1C write - clear selected bits
                //    Bits 6,4,2,0 are cleared by writing 8'h55

                wdata = 32'h0000_0055;

                do_write(regmodel.err_status, wdata);

                `uvm_info("SEQ",$sformatf("W1C WRITE | WDATA=%08h",wdata),UVM_LOW)

                // READ after W1C

                do_read(regmodel.err_status, rdata);

                des = regmodel.err_status.get();
                mir = regmodel.err_status.get_mirrored_value();

                `uvm_info("SEQ",$sformatf("W1C READ | DUT=%08h EXPECTED=000000AA DESIRED=%08h MIRRORED=%08h",rdata, des, mir), UVM_LOW)

                if (rdata[7:0] !== 8'hAA)
                    `uvm_error("ERR_STATUS",$sformatf("W1C ERROR | Expected=000000AA Got=%08h",rdata))
                else
                    `uvm_info("ERR_STATUS","W1C PARTIAL CLEAR PASS",UVM_LOW)

                // 4. W1C write - clear all remaining bits

                wdata = 32'h0000_00FF;

                do_write(regmodel.err_status, wdata);

                `uvm_info("SEQ",$sformatf("W1C CLEAR ALL | WDATA=%08h",wdata),UVM_LOW)

                // READ after clearing all bits

                do_read(regmodel.err_status, rdata);

                des = regmodel.err_status.get();
                mir = regmodel.err_status.get_mirrored_value();

                `uvm_info("SEQ",$sformatf("FINAL READ | DUT=%08h EXPECTED=00000000 DESIRED=%08h MIRRORED=%08h",rdata, des, mir), UVM_LOW)

                if (rdata[7:0] !== 8'h00)
                    `uvm_error("ERR_STATUS",$sformatf("FINAL CLEAR ERROR | Expected=00000000 Got=%08h",rdata))
                else
                    `uvm_info("ERR_STATUS","ALL ERROR BITS CLEARED PASS",UVM_LOW)


              `uvm_info(get_type_name(),"================ ERR_STATUS CHECK END ==================",UVM_LOW)

    endtask
endclass



//err_enable(0x4C)
class err_enable_seq extends top_reg_seq;
                `uvm_object_utils(err_enable_seq)

                function new(string name = "err_enable_seq");
                super.new(name);
        endfunction

        task body();

                uvm_reg_data_t rdata;
                uvm_reg_data_t wdata;
                uvm_reg_data_t des;
                uvm_reg_data_t mir;
                uvm_status_e status;

                if (regmodel == null)
                `uvm_fatal("NO_REGMODEL", "regmodel not assigned")

            `uvm_info(get_type_name(),"================ ERR_ENABLE CHECK START ================",UVM_LOW)

                // 1. Initial read - check reset value

            do_read(regmodel.err_enable, rdata);

                des = regmodel.err_enable.get();
                mir = regmodel.err_enable.get_mirrored_value();

                `uvm_info("SEQ",$sformatf("RESET READ | DUT=%08h DESIRED=%08h MIRRORED=%08h",rdata, des, mir), UVM_LOW)

            if (rdata !== 32'h0000_0000)
                `uvm_error("ERR_ENABLE",$sformatf("RESET VALUE ERROR | Expected=00000000 Got=%08h",rdata))

                if (mir !== rdata)
                `uvm_error("ERR_ENABLE",$sformatf("RESET MIRROR MISMATCH | DUT=%08h MIRRORED=%08h",rdata, mir))


                // 2. Unlock DUT
                // LOCK address = 0x5C
                // Unlock key = A5A5_C3C3

                wdata = 32'hA5A5_C3C3;

                do_write(regmodel.lock, wdata);

                `uvm_info("SEQ", "DUT UNLOCK KEY WRITTEN", UVM_LOW)


                // 3. Read LOCK register

                do_read(regmodel.lock, rdata);

                `uvm_info("SEQ",$sformatf("LOCK READ | DUT=%08h", rdata), UVM_LOW)

                if (rdata !== 32'h0000_0000)
                `uvm_error("LOCK",$sformatf("DUT NOT UNLOCKED | Expected=00000000 Got=%08h", rdata))

                // 4. ERR_ENABLE random write/read test
            // Bit [7:0] - written


                repeat (`no_of_trans) begin

                wdata = $urandom();

                // Expected readback:
                // Bit [7:0] = written  value
                // remaining Reserved, read as zero

                // WRITE
                do_write(regmodel.err_enable, wdata);

                des = regmodel.err_enable.get();
                mir = regmodel.err_enable.get_mirrored_value();

                `uvm_info("SEQ",$sformatf("WRITE | WDATA=%08h DESIRED=%08h MIRRORED=%08h",wdata, des, mir), UVM_LOW)

                        // READ AFTER WRITE
                do_read(regmodel.err_enable, rdata);

                des = regmodel.err_enable.get();
                mir = regmodel.err_enable.get_mirrored_value();

                `uvm_info("SEQ",$sformatf("READ AFTER WRITE | DUT=%08h EXPECTED=%08h DESIRED=%08h MIRRORED=%08h", rdata, wdata[7:0], des, mir), UVM_LOW)

                // Check bit
                if (rdata[7:0] !== wdata[7:0])
                        `uvm_error("IRQ_ENABLE",$sformatf("ERR_ENABLE MISMATCH | Expected=%0b Got=%0b",wdata[7:0], rdata[7:0]))



                // Check reserved bits
                if (rdata[31:8] !== 24'h000000)
                    `uvm_error("IRQ_ENABLE",$sformatf("RESERVED BITS ERROR | DATA=%08h", rdata))

                // Check complete readback
                if (rdata !== wdata[7:0])
                        `uvm_error("ERR_ENABLE",$sformatf("READBACK MISMATCH | Expected=%08h Got=%08h",wdata, rdata))
                else
                        `uvm_info("ERR_ENABLE",$sformatf("READBACK PASS | Expected=%08h Got=%08h",wdata[7:0], rdata), UVM_LOW)

                `uvm_info(get_type_name(),"---------------------------------------------------------------",UVM_LOW)
                end



                // 5. Backdoor write/read test

                wdata = 32'hAFFA_BBAB;

                regmodel.err_enable.write(status, wdata, UVM_BACKDOOR);

                if (status != UVM_IS_OK)
              `uvm_error("ERR_ENABLE", "Backdoor write failed")

                `uvm_info("SEQ",$sformatf("BACKDOOR WRITE | DATA=%08h", wdata),UVM_LOW)

                regmodel.err_enable.read(status, rdata, UVM_BACKDOOR);

                if (status != UVM_IS_OK)
                `uvm_error("ERR_ENABLE", "Backdoor read failed")

                `uvm_info("SEQ",$sformatf("BACKDOOR READ | DATA=%08h", rdata),UVM_LOW)

            if (rdata !== wdata[7:0])
                `uvm_error("ERR_ENABLE",$sformatf("BACKDOOR MISMATCH | Expected=%08h Got=%08h", wdata[7:0], rdata))
                else
                `uvm_info("ERR_ENABLE","BACKDOOR READ/WRITE PASS", UVM_LOW)


              `uvm_info(get_type_name(),"================ ERR_ENABLE CHECK END ==================",UVM_LOW)

    endtask
endclass




//err_inject(0x50)
class err_inject_seq extends top_reg_seq;
        `uvm_object_utils(err_inject_seq)

        function new(string name = "err_inject_seq");
                super.new(name);
        endfunction

        task body();

                uvm_reg_data_t rdata;
                uvm_reg_data_t wdata;
                uvm_reg_data_t des;
                uvm_reg_data_t mir;

                if (regmodel == null)
                `uvm_fatal("NO_REGMODEL", "regmodel not assigned")

               `uvm_info(get_type_name(),"================ ERR_INJECT CHECK START ================",UVM_LOW)

                // 1. Initial read - WO register should read as zero

               do_read(regmodel.err_inject, rdata);

               `uvm_info("SEQ",$sformatf("RESET READ | DUT=%08h EXPECTED=00000000",rdata), UVM_LOW)

               if (rdata !== 32'h0000_0000)
                        `uvm_error("ERR_INJECT",$sformatf("READ VALUE ERROR | Expected=00000000 Got=%08h",rdata))


                // 2. Inject BUS error
                //    Bit 0 sets BUS_ERROR and INJECTED

                wdata = 32'h0000_0001;

                do_write(regmodel.err_inject, wdata);

                `uvm_info("SEQ",$sformatf("BUS INJECTION | WDATA=%08h",wdata),UVM_LOW)

                do_read(regmodel.err_status, rdata);

                `uvm_info("SEQ",$sformatf("ERR_STATUS AFTER BUS | DUT=%08h EXPECTED BITS[7:0]=00000081",rdata),UVM_LOW)

                if ((rdata[7] !== 1'b1) || (rdata[0] !== 1'b1))
                    `uvm_error("ERR_INJECT",$sformatf("BUS INJECTION ERROR | ERR_STATUS=%08h",rdata))
                else
                    `uvm_info("ERR_INJECT","BUS INJECTION PASS",UVM_LOW)


                // 3. Clear ERR_STATUS before next injection

                do_write(regmodel.err_status, 32'h0000_00FF);


                // 4. Inject all error types
                //    Bits 7:0 set all error flags

                wdata = 32'h0000_00FF;

                do_write(regmodel.err_inject, wdata);

                `uvm_info("SEQ",$sformatf("ALL ERROR INJECTION | WDATA=%08h",wdata),UVM_LOW)

                do_read(regmodel.err_status, rdata);

                `uvm_info("SEQ",$sformatf("ERR_STATUS AFTER ALL INJECTIONS | DUT=%08h EXPECTED BITS[7:0]=11111111",rdata),UVM_LOW)

                if (rdata[7:0] !== 8'hFF)
                    `uvm_error("ERR_INJECT",$sformatf("ALL INJECTION ERROR | Expected=000000FF Got=%08h",rdata))
                else
                    `uvm_info("ERR_INJECT","ALL ERROR INJECTION PASS",UVM_LOW)


                // 5. CLEAR_COUNT test
                //    Bit 31 clears ERR_COUNT and ERR_INFO

                wdata = 32'h8000_0000;

                do_write(regmodel.err_inject, wdata);

                `uvm_info("SEQ",$sformatf("CLEAR_COUNT WRITE | WDATA=%08h",wdata),UVM_LOW)

                // Read ERR_COUNT after clear

                do_read(regmodel.err_count, rdata);

                `uvm_info("SEQ",$sformatf("ERR_COUNT AFTER CLEAR | DUT=%08h EXPECTED=00000000",rdata),UVM_LOW)

                if (rdata !== 32'h0000_0000)
                    `uvm_error("ERR_INJECT",$sformatf("ERR_COUNT CLEAR ERROR | Expected=00000000 Got=%08h",rdata))
                else
                    `uvm_info("ERR_INJECT","ERR_COUNT CLEAR PASS",UVM_LOW)


                // 6. Check WO read value after writes

                do_read(regmodel.err_inject, rdata);

                `uvm_info("SEQ",$sformatf("READ AFTER WRITE | DUT=%08h EXPECTED=00000000",rdata),UVM_LOW)

                if (rdata !== 32'h0000_0000)
                    `uvm_error("ERR_INJECT",$sformatf("WO READBACK ERROR | Expected=00000000 Got=%08h",rdata))
                else
                    `uvm_info("ERR_INJECT","WO READ VALUE PASS",UVM_LOW)


              `uvm_info(get_type_name(),"================ ERR_INJECT CHECK END ==================",UVM_LOW)

    endtask
endclass


//err_count(0x54)
class err_count_seq extends top_reg_seq;
       `uvm_object_utils(err_count_seq)

        function new(string name = "err_count_seq");
                super.new(name);
        endfunction

        task body();

                uvm_reg_data_t rdata;
                uvm_reg_data_t wdata;
                uvm_reg_data_t bdata;
                uvm_reg_data_t des;
                uvm_reg_data_t mir;
                uvm_status_e status;

                if (regmodel == null)
                `uvm_fatal("NO_REGMODEL", "regmodel not assigned")

               `uvm_info(get_type_name(),"================ ERR_COUNT CHECK START ================",UVM_LOW)

                // 1. Initial read - check reset value

                do_read(regmodel.err_count, rdata);

                des = regmodel.err_count.get();
                mir = regmodel.err_count.get_mirrored_value();

                `uvm_info("SEQ",$sformatf("RESET READ | DUT=%08h DESIRED=%08h MIRRORED=%08h",rdata, des, mir), UVM_LOW)

                if (rdata !== 32'h0000_0000)
                        `uvm_error("ERR_COUNT",$sformatf("RESET VALUE ERROR | Expected=00000000 Got=%08h",rdata))

                // BACKDOOR READ

                regmodel.err_count.read(status, bdata, UVM_BACKDOOR);

                if (status != UVM_IS_OK)
                    `uvm_error("ERR_COUNT","RESET BACKDOOR READ FAILED")

                `uvm_info("SEQ",$sformatf("RESET BACKDOOR READ | DATA=%08h",bdata),UVM_LOW)

                if (bdata[15:0] !== rdata[15:0])
                    `uvm_error("ERR_COUNT",$sformatf("RESET BACKDOOR MISMATCH | FRONTDOOR=%08h BACKDOOR=%08h",rdata,bdata))


                // 2. Inject one error bit

                wdata = 32'h0000_0001;

                do_write(regmodel.err_inject, wdata);

                `uvm_info("SEQ",$sformatf("ERR_INJECT WRITE | WDATA=%08h",wdata),UVM_LOW)

                // FRONTDOOR READ

                do_read(regmodel.err_count, rdata);

                `uvm_info("SEQ",$sformatf("AFTER INJECTION | FRONTDOOR=%08h",rdata),UVM_LOW)

                if (rdata[15:0] == 16'h0000)
                    `uvm_error("ERR_COUNT","ERROR COUNT DID NOT INCREASE")
                else
                    `uvm_info("ERR_COUNT","ERROR COUNT INCREMENT PASS",UVM_LOW)

                // BACKDOOR READ

                regmodel.err_count.read(status, bdata, UVM_BACKDOOR);

                if (status != UVM_IS_OK)
                    `uvm_error("ERR_COUNT","BACKDOOR READ FAILED AFTER INJECTION")

                `uvm_info("SEQ",$sformatf("BACKDOOR READ | DATA=%08h",bdata),UVM_LOW)

                if (bdata[15:0] !== rdata[15:0])
                    `uvm_error("ERR_COUNT",$sformatf("INJECTION BACKDOOR MISMATCH | FRONTDOOR=%08h BACKDOOR=%08h",rdata,bdata))
                else
                    `uvm_info("ERR_COUNT","INJECTION FRONTDOOR/BACKDOOR MATCH PASS",UVM_LOW)


                // 3. Inject multiple error bits

                wdata = 32'h0000_000F;

                do_write(regmodel.err_inject, wdata);

                `uvm_info("SEQ",$sformatf("MULTIPLE ERROR INJECTION | WDATA=%08h",wdata),UVM_LOW)

                do_read(regmodel.err_count, rdata);

                `uvm_info("SEQ",$sformatf("MULTIPLE INJECTION READ | FRONTDOOR=%08h",rdata),UVM_LOW)

                if (rdata[15:0] <= 16'h0001)
                    `uvm_error("ERR_COUNT","ERROR COUNT DID NOT INCREASE FOR MULTIPLE INJECTIONS")
                else
                    `uvm_info("ERR_COUNT","MULTIPLE ERROR COUNT PASS",UVM_LOW)

                // BACKDOOR READ

                regmodel.err_count.read(status, bdata, UVM_BACKDOOR);

                if (status != UVM_IS_OK)
                    `uvm_error("ERR_COUNT","BACKDOOR READ FAILED AFTER MULTIPLE INJECTIONS")

                `uvm_info("SEQ",$sformatf("MULTIPLE INJECTION BACKDOOR | DATA=%08h",bdata),UVM_LOW)

                if (bdata[15:0] !== rdata[15:0])
                    `uvm_error("ERR_COUNT",$sformatf("MULTIPLE INJECTION BACKDOOR MISMATCH | FRONTDOOR=%08h BACKDOOR=%08h",rdata,bdata))


                // 4. CLEAR_COUNT - clear ERR_COUNT and ERR_INFO

                wdata = 32'h8000_0000;

                do_write(regmodel.err_inject, wdata);

                `uvm_info("SEQ",$sformatf("CLEAR_COUNT WRITE | WDATA=%08h",wdata),UVM_LOW)

                // FRONTDOOR READ AFTER CLEAR

                do_read(regmodel.err_count, rdata);

                `uvm_info("SEQ",$sformatf("AFTER CLEAR | FRONTDOOR=%08h EXPECTED=00000000",rdata),UVM_LOW)

                if (rdata[15:0] !== 16'h0000)
                    `uvm_error("ERR_COUNT",$sformatf("CLEAR COUNT ERROR | Expected=00000000 Got=%08h",rdata))
                else
                    `uvm_info("ERR_COUNT","CLEAR COUNT PASS",UVM_LOW)

                // BACKDOOR READ AFTER CLEAR

                regmodel.err_count.read(status, bdata, UVM_BACKDOOR);

                if (status != UVM_IS_OK)
                    `uvm_error("ERR_COUNT","BACKDOOR READ FAILED AFTER CLEAR")

                `uvm_info("SEQ",$sformatf("CLEAR BACKDOOR READ | DATA=%08h",bdata),UVM_LOW)

                if (bdata[15:0] !== 16'h0000)
                    `uvm_error("ERR_COUNT",$sformatf("CLEAR BACKDOOR MISMATCH | Expected=0000 Got=%08h",bdata))
                else
                    `uvm_info("ERR_COUNT","CLEAR FRONTDOOR/BACKDOOR CHECK PASS",UVM_LOW)


                // 5. Check reserved bits read as zero

                if (rdata[31:16] !== 16'h0000)
                    `uvm_error("ERR_COUNT",$sformatf("RESERVED BITS ERROR | Got=%08h",rdata))
                else
                    `uvm_info("ERR_COUNT","RESERVED BITS READ ZERO PASS",UVM_LOW)


              `uvm_info(get_type_name(),"================ ERR_COUNT CHECK END ==================",UVM_LOW)

    endtask
endclass




//err_info (0x58)
class err_info_seq extends top_reg_seq;
       `uvm_object_utils(err_info_seq)

        function new(string name = "err_info_seq");
                super.new(name);
        endfunction

        task body();

                uvm_reg_data_t rdata;
                uvm_reg_data_t wdata;
                uvm_reg_data_t bdata;
                uvm_reg_data_t des;
                uvm_reg_data_t mir;
                uvm_status_e status;

                if (regmodel == null)
                        `uvm_fatal("NO_REGMODEL", "regmodel not assigned")

                `uvm_info(get_type_name(),"================ ERR_INFO CHECK START ================",UVM_LOW)

                // 1. Initial read - check reset value
                do_read(regmodel.err_info, rdata);

                des = regmodel.err_info.get();
                mir = regmodel.err_info.get_mirrored_value();

                `uvm_info("SEQ",$sformatf("RESET READ | DUT=%08h DESIRED=%08h MIRRORED=%08h",rdata, des, mir),UVM_LOW)

                if (rdata !== 32'h0000_0000)
                    `uvm_error("ERR_INFO",$sformatf("RESET VALUE ERROR | Expected=00000000 Got=%08h",rdata))

                // BACKDOOR READ
                regmodel.err_info.read(status, bdata, UVM_BACKDOOR);

                if (status != UVM_IS_OK)
                    `uvm_error("ERR_INFO","RESET BACKDOOR READ FAILED")

                `uvm_info("SEQ",$sformatf("RESET BACKDOOR READ | DATA=%08h",bdata),UVM_LOW)

                if (bdata !== rdata)
                    `uvm_error("ERR_INFO",$sformatf("RESET BACKDOOR MISMATCH | FRONTDOOR=%08h BACKDOOR=%08h",rdata,bdata))
                else
                    `uvm_info("ERR_INFO","RESET FRONTDOOR/BACKDOOR MATCH PASS",UVM_LOW)

                // 2. Inject one error bit - BUS error (bit 0)
                wdata = 32'h0000_0001;
                do_write(regmodel.err_inject, wdata);

                `uvm_info("SEQ",$sformatf("ERR_INJECT WRITE | WDATA=%08h",wdata),UVM_LOW)

                // FRONTDOOR READ AFTER INJECTION
                do_read(regmodel.err_info, rdata);

                `uvm_info("SEQ",$sformatf("AFTER INJECTION | FRONTDOOR=%0h",rdata),UVM_LOW)

                // SOURCE = 1 for injection
                if (rdata[15:8] !== 8'h01)
                    `uvm_error("ERR_INFO",$sformatf("SOURCE ERROR | Expected=01 Got=%02h",rdata[15:8]))
                else
                    `uvm_info("ERR_INFO","SOURCE INJECTION CHECK PASS",UVM_LOW)

                // LAST_CODE = 0 for error bit 0
                if (rdata[7:0] !== 8'h00)
                    `uvm_error("ERR_INFO",$sformatf("LAST_CODE ERROR | Expected=00 Got=%02h",rdata[7:0]))
                else
                    `uvm_info("ERR_INFO","LAST_CODE CHECK PASS",UVM_LOW)

                // Reserved bits [19:18] should read zero
                if (rdata[19:18] !== 2'b00)
                    `uvm_error("ERR_INFO",$sformatf("RESERVED BITS ERROR | Got=%02b",rdata[19:18]))
                else
                    `uvm_info("ERR_INFO","RESERVED BITS READ ZERO PASS",UVM_LOW)

                // BACKDOOR READ AFTER INJECTION
                regmodel.err_info.read(status, bdata, UVM_BACKDOOR);

                if (status != UVM_IS_OK)
                    `uvm_error("ERR_INFO","BACKDOOR READ FAILED AFTER INJECTION")

                `uvm_info("SEQ",$sformatf("BACKDOOR READ | DATA=%08h",bdata),UVM_LOW)

                if (bdata !== rdata)
                    `uvm_error("ERR_INFO",$sformatf("INJECTION BACKDOOR MISMATCH | FRONTDOOR=%08h BACKDOOR=%08h",rdata,bdata))
                else
                    `uvm_info("ERR_INFO","INJECTION FRONTDOOR/BACKDOOR MATCH PASS",UVM_LOW)

                // 3. Inject multiple error bits - bits 0 to 3
                // Lowest set bit is bit 0, so LAST_CODE should be 0
                wdata = 32'h0000_000F;
                do_write(regmodel.err_inject, wdata);

                `uvm_info("SEQ",$sformatf("MULTIPLE ERROR INJECTION | WDATA=%08h",wdata),UVM_LOW)

                // FRONTDOOR READ
                do_read(regmodel.err_info, rdata);

                `uvm_info("SEQ",$sformatf("MULTIPLE INJECTION READ | FRONTDOOR=%08h",rdata),UVM_LOW)

                if (rdata[15:8] !== 8'h01)
                    `uvm_error("ERR_INFO",$sformatf("MULTIPLE INJECTION SOURCE ERROR | Expected=01 Got=%02h",rdata[15:8]))

                if (rdata[7:0] !== 8'h00)
                    `uvm_error("ERR_INFO",$sformatf("MULTIPLE INJECTION LAST_CODE ERROR | Expected=00 Got=%02h",rdata[7:0]))
                else
                    `uvm_info("ERR_INFO","MULTIPLE INJECTION LAST_CODE CHECK PASS",UVM_LOW)

                // BACKDOOR READ
                regmodel.err_info.read(status, bdata, UVM_BACKDOOR);

                if (status != UVM_IS_OK)
                    `uvm_error("ERR_INFO","BACKDOOR READ FAILED AFTER MULTIPLE INJECTIONS")

                `uvm_info("SEQ",$sformatf("MULTIPLE INJECTION BACKDOOR | DATA=%08h",bdata),UVM_LOW)

                if (bdata !== rdata)
                    `uvm_error("ERR_INFO",$sformatf("MULTIPLE INJECTION BACKDOOR MISMATCH | FRONTDOOR=%08h BACKDOOR=%08h",rdata,bdata))
                else
                    `uvm_info("ERR_INFO","MULTIPLE INJECTION FRONTDOOR/BACKDOOR MATCH PASS",UVM_LOW)

                // 4. Clear ERR_INFO using CLEAR_COUNT
                wdata = 32'h8000_0000;
                do_write(regmodel.err_inject, wdata);

                `uvm_info("SEQ",$sformatf("CLEAR_COUNT WRITE | WDATA=%08h",wdata),UVM_LOW)

                // FRONTDOOR READ AFTER CLEAR
                do_read(regmodel.err_info, rdata);

                `uvm_info("SEQ",$sformatf("AFTER CLEAR | FRONTDOOR=%08h",rdata),UVM_LOW)

                if (rdata !== 32'h0000_0000)
                    `uvm_error("ERR_INFO",$sformatf("CLEAR ERR_INFO ERROR | Expected=00000000 Got=%08h",rdata))
                else
                    `uvm_info("ERR_INFO","CLEAR ERR_INFO PASS",UVM_LOW)

                // BACKDOOR READ AFTER CLEAR
                regmodel.err_info.read(status, bdata, UVM_BACKDOOR);

                if (status != UVM_IS_OK)
                    `uvm_error("ERR_INFO","BACKDOOR READ FAILED AFTER CLEAR")

                `uvm_info("SEQ",$sformatf("CLEAR BACKDOOR READ | DATA=%08h",bdata),UVM_LOW)

                if (bdata !== 32'h0000_0000)
                    `uvm_error("ERR_INFO",$sformatf("CLEAR BACKDOOR MISMATCH | Expected=00000000 Got=%08h",bdata))
                else
                    `uvm_info("ERR_INFO","CLEAR FRONTDOOR/BACKDOOR CHECK PASS",UVM_LOW)

                `uvm_info(get_type_name(),"================ ERR_INFO CHECK END ==================",UVM_LOW)

        endtask
endclass



// LOCK (0x5C)
class lock_seq extends top_reg_seq;
        `uvm_object_utils(lock_seq)

        function new(string name = "lock_seq");
                super.new(name);
        endfunction

        task body();

                uvm_reg_data_t rdata;
                uvm_reg_data_t bdata;
                uvm_reg_data_t wdata;
                uvm_status_e status;

                if (regmodel == null)
                `uvm_fatal("NO_REGMODEL", "regmodel not assigned")

                `uvm_info(get_type_name(),"================ LOCK CHECK START ================",UVM_LOW)

                // 1. Check reset value: LOCKED = 1
                do_read(regmodel.lock, rdata);

                if (rdata !== 32'h0000_0001)
                `uvm_error("LOCK",$sformatf("RESET VALUE ERROR | Expected=00000001 Got=%08h",rdata))
                else
                `uvm_info("LOCK", "RESET VALUE CHECK PASS", UVM_LOW)

                // Backdoor read after reset
                regmodel.lock.read(status, bdata, UVM_BACKDOOR);

                if (status != UVM_IS_OK)
                `uvm_error("LOCK", "BACKDOOR READ FAILED")
                else if (bdata[0] !== rdata[0])
                `uvm_error("LOCK", $sformatf("RESET BACKDOOR MISMATCH | FD=%08h BD=%08h",rdata, bdata))
                else
                `uvm_info("LOCK", "RESET FRONTDOOR/BACKDOOR MATCH PASS", UVM_LOW)

                // 2. Write the correct key to unlock
                wdata = 32'hA5A5_C3C3;
                do_write(regmodel.lock, wdata);

                `uvm_info("LOCK",$sformatf("CORRECT KEY WRITTEN | WDATA=%08h", wdata),UVM_LOW)

                // Read status: LOCKED must be 0
                do_read(regmodel.lock, rdata);

                if (rdata !== 32'h0000_0000)
                `uvm_error("LOCK",$sformatf("UNLOCK FAILED | Expected=00000000 Got=%08h",rdata))
                else
                `uvm_info("LOCK", "UNLOCK CHECK PASS", UVM_LOW)

                // Backdoor read after unlock
                regmodel.lock.read(status, bdata, UVM_BACKDOOR);

                if (status != UVM_IS_OK)
                `uvm_error("LOCK", "BACKDOOR READ FAILED AFTER UNLOCK")
                else if (bdata[0] !== rdata[0])
                `uvm_error("LOCK",$sformatf("UNLOCK BACKDOOR MISMATCH | FD=%08h BD=%08h",rdata, bdata))
                else
                `uvm_info("LOCK", "UNLOCK FRONTDOOR/BACKDOOR MATCH PASS", UVM_LOW)

                // 3. Write an incorrect key to lock again
                wdata = 32'h0000_0000;
                do_write(regmodel.lock, wdata);

                `uvm_info("LOCK",$sformatf("INCORRECT KEY WRITTEN | WDATA=%08h", wdata), UVM_LOW)

                // Read status: LOCKED must be 1
                do_read(regmodel.lock, rdata);

                if (rdata !== 32'h0000_0001)
                `uvm_error("LOCK", $sformatf("LOCK FAILED | Expected=00000001 Got=%08h", rdata))
                else
                `uvm_info("LOCK", "LOCK CHECK PASS", UVM_LOW)

                // Backdoor read after locking
                regmodel.lock.read(status, bdata, UVM_BACKDOOR);

                if (status != UVM_IS_OK)
                `uvm_error("LOCK", "BACKDOOR READ FAILED AFTER LOCK")
                else if (bdata[0] !== rdata[0])
                `uvm_error("LOCK", $sformatf("LOCK BACKDOOR MISMATCH | FD=%08h BD=%08h",rdata, bdata))
                else
                `uvm_info("LOCK", "LOCK FRONTDOOR/BACKDOOR MATCH PASS", UVM_LOW)

                `uvm_info(get_type_name(), "================ LOCK CHECK END ==================",UVM_LOW)

        endtask
endclass


// SOFT_RESET (0x60)
class soft_reset_seq extends top_reg_seq;
                `uvm_object_utils(soft_reset_seq)

        function new(string name = "soft_reset_seq");
                super.new(name);
        endfunction

        task body();

                uvm_reg_data_t rdata;
                uvm_status_e status;

                if (regmodel == null)
                `uvm_fatal("NO_REGMODEL", "regmodel not assigned")

                `uvm_info(get_type_name(), "=============== SOFT_RESET CHECK START ===============",UVM_LOW)

                // 1. Read reset value - should always be zero
                do_read(regmodel.soft_reset, rdata);

                if (rdata !== 32'h0000_0000)
                `uvm_error("SOFT_RESET",$sformatf("RESET READ ERROR | Expected=00000000 Got=%08h", rdata))
                else
                `uvm_info("SOFT_RESET", "RESET READ CHECK PASS", UVM_LOW)

                // 2. Write 1 to trigger soft reset
                do_write(regmodel.soft_reset, 32'h0000_0001);

                `uvm_info("SOFT_RESET", "SOFT RESET PULSE WRITTEN", UVM_LOW)

                // 3. Read SOFT_RESET - should still return zero
                do_read(regmodel.soft_reset, rdata);

                if (rdata !== 32'h0000_0000)
                `uvm_error("SOFT_RESET",$sformatf("READ AFTER RESET ERROR | Expected=00000000 Got=%08h", rdata))
                else
                `uvm_info("SOFT_RESET", "READ AFTER RESET CHECK PASS", UVM_LOW)

                // 4. Write zero - should have no effect
                do_write(regmodel.soft_reset, 32'h0000_0000);

                do_read(regmodel.soft_reset, rdata);

                if (rdata !== 32'h0000_0000)
                `uvm_error("SOFT_RESET", $sformatf("WRITE ZERO CHECK FAILED | Got=%08h", rdata))
                else
                `uvm_info("SOFT_RESET", "WRITE ZERO CHECK PASS", UVM_LOW)

                `uvm_info(get_type_name(), "=============== SOFT_RESET CHECK END ===============", UVM_LOW)

        endtask
endclass



//regression
class all_reg_regression_seq extends top_reg_seq;
    `uvm_object_utils(all_reg_regression_seq)


    irq_status_seq seq16;
    irq_force_seq seq18;
    lock_seq seq24;
    device_id_seq seq1;
    version_seq seq2;
    switch_status_seq seq3;
    port_status_seq seq4;
    gen_status_seq seq5;
    stat_rx_seq seq6;
    stat_tx_seq seq7;
    stat_drop_seq seq8;
    switch_ctrl_seq seq9;
    port_enable_seq seq10;
    fwd_enable_seq seq11;
    gen_ctrl_seq seq12;
    gen_pkt_cfg_seq seq13;
    gen_interval_seq seq14;
    gen_count_seq seq15;
    irq_enable_seq seq17;
    err_status_seq seq19;
    err_enable_seq seq20;
    err_inject_seq seq21;
    err_count_seq seq22;
    err_info_seq seq23;
    soft_reset_seq seq25;
    all_reg_reset_seq seq26;
    gen_four_packets_seq seq27;
    clear_sticky_status_seq seq28;
    apply_reset_seq seq29;
    dest_drop_seq seq30;

    function new(string name = "all_reg_regression_seq");
        super.new(name);
    endfunction

    task body();

        if (regmodel == null)
            `uvm_fatal("NO_REGMODEL", "regmodel not assigned")

        `uvm_info(get_type_name(),"========== ALL REGISTER REGRESSION START ==========", UVM_LOW)

        seq26 = all_reg_reset_seq::type_id::create("seq22");
        seq26.regmodel = regmodel;
        seq26.start(m_sequencer);

        seq28 = clear_sticky_status_seq::type_id::create("seq25");
        seq28.regmodel = regmodel;
        seq28.start(m_sequencer);

        seq16 = irq_status_seq::type_id::create("seq16");
        seq16.regmodel = regmodel;
        seq16.start(m_sequencer);

        seq18 = irq_force_seq::type_id::create("seq18");
        seq18.regmodel = regmodel;
        seq18.start(m_sequencer);

        seq24 = lock_seq::type_id::create("seq24");
        seq24.regmodel = regmodel;
        seq24.start(m_sequencer);

        seq1 = device_id_seq::type_id::create("seq1");
        seq1.regmodel = regmodel;
        seq1.start(m_sequencer);

        seq2 = version_seq::type_id::create("seq2");
        seq2.regmodel = regmodel;
        seq2.start(m_sequencer);

        seq3 = switch_status_seq::type_id::create("seq3");
        seq3.regmodel = regmodel;
        seq3.start(m_sequencer);

        seq4 = port_status_seq::type_id::create("seq4");
        seq4.regmodel = regmodel;
        seq4.start(m_sequencer);

        seq5 = gen_status_seq::type_id::create("seq5");
        seq5.regmodel = regmodel;
        seq5.start(m_sequencer);

        seq6 = stat_rx_seq::type_id::create("seq6");
        seq6.regmodel = regmodel;
        seq6.start(m_sequencer);

        seq7 = stat_tx_seq::type_id::create("seq7");
        seq7.regmodel = regmodel;
        seq7.start(m_sequencer);
        
        seq10 = port_enable_seq::type_id::create("seq10");
        seq10.regmodel = regmodel;
        seq10.start(m_sequencer);

        seq11 = fwd_enable_seq::type_id::create("seq11");
        seq11.regmodel = regmodel;
        seq11.start(m_sequencer);

        seq13 = gen_pkt_cfg_seq::type_id::create("seq13");
        seq13.regmodel = regmodel;
        seq13.start(m_sequencer);

        seq14 = gen_interval_seq::type_id::create("seq14");
        seq14.regmodel = regmodel;
        seq14.start(m_sequencer);

        seq15 = gen_count_seq::type_id::create("seq15");
        seq15.regmodel = regmodel;
        seq15.start(m_sequencer);

        seq17 = irq_enable_seq::type_id::create("seq17");
        seq17.regmodel = regmodel;
        seq17.start(m_sequencer);

        seq19 = err_status_seq::type_id::create("seq19");
        seq19.regmodel = regmodel;
        seq19.start(m_sequencer);

        seq20 = err_enable_seq::type_id::create("seq20");
        seq20.regmodel = regmodel;
        seq20.start(m_sequencer);

        seq21 = err_inject_seq::type_id::create("seq21");
        seq21.regmodel = regmodel;
        seq21.start(m_sequencer);

        seq22 = err_count_seq::type_id::create("seq22");
        seq22.regmodel = regmodel;
        seq22.start(m_sequencer);

        seq23 = err_info_seq::type_id::create("seq23");
        seq23.regmodel = regmodel;
        seq23.start(m_sequencer);

        seq25 = soft_reset_seq::type_id::create("seq25");
        seq25.regmodel = regmodel;
        seq25.start(m_sequencer);

        seq27 = gen_four_packets_seq::type_id::create("seq23");
        seq27.regmodel = regmodel;
        seq27.start(m_sequencer);

        seq29 = apply_reset_seq::type_id::create("seq23");
        seq29.regmodel = regmodel;
        seq29.start(m_sequencer);

        seq30 = dest_drop_seq::type_id::create("seq25");
        seq30.regmodel = regmodel;
        seq30.start(m_sequencer);

        seq29.start(m_sequencer);

        seq8 = stat_drop_seq::type_id::create("seq8");
        seq8.regmodel = regmodel;
        seq8.start(m_sequencer);

        seq9 = switch_ctrl_seq::type_id::create("seq9");
        seq9.regmodel = regmodel;
        seq9.start(m_sequencer);

        seq12 = gen_ctrl_seq::type_id::create("seq12");
        seq12.regmodel = regmodel;
        seq12.start(m_sequencer);

        `uvm_info(get_type_name(), "========== ALL REGISTER REGRESSION END ==========", UVM_LOW)

    endtask
endclass

                                                                                          
