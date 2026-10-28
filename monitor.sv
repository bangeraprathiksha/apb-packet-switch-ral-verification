class monitor extends uvm_monitor;
        `uvm_component_utils(monitor)

        uvm_analysis_port #(reg_seq_item) ap_mon;

        virtual intf vif;

        function new(string name = "monitor", uvm_component parent);
                super.new(name, parent);
        endfunction

        function void build_phase(uvm_phase phase);
                super.build_phase(phase);
                ap_mon = new("ap_mon", this);
                if (!uvm_config_db#(virtual intf)::get(this, "", "vif", vif))
                        `uvm_fatal("MON", "Failed to fetch interface")
        endfunction


        task run_phase(uvm_phase phase);

                reg_seq_item req;

                forever begin
                        @(negedge vif.pclk);
                        if (vif.psel && vif.penable && vif.pready) begin
                        req = reg_seq_item::type_id::create("req");
                        req.pwrite = vif.pwrite;
                        req.paddr  = vif.paddr;
                        if (vif.pwrite) begin
                                req.pwdata = vif.pwdata;
                                `uvm_info("MON", $sformatf("WRITE addr=%0h data=%0h", vif.paddr, vif.pwdata), UVM_LOW)
                        end
                        else begin
                                req.prdata = vif.prdata;
                                `uvm_info("MON", $sformatf("READ addr=%0h data=%0h",vif.paddr, vif.prdata),UVM_LOW)
                        end
                        ap_mon.write(req);
                        end

                end
                endtask

endclass
