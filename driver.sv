class driver extends uvm_driver #(reg_seq_item);
        `uvm_component_utils(driver)

        virtual intf vif;
        reg_seq_item req;

        function new(string name = "driver", uvm_component parent=null);
                super.new(name, parent);
        endfunction

        function void build_phase(uvm_phase phase);
                super.build_phase(phase);
                if (!uvm_config_db#(virtual intf)::get(this,"","vif",vif))
                  `uvm_fatal("DRV","Failed to get virtual interface")
        endfunction

        task run_phase(uvm_phase phase);
                req = reg_seq_item::type_id::create("req");
                reset_dut();
                forever begin
                        seq_item_port.get_next_item(req);
                      drive(req);
                      seq_item_port.item_done();
                 end
        endtask


        task reset_dut();

        // Assert reset
        vif.presetn = 1'b0;

        vif.psel = 1'b0;
        vif.penable = 1'b0;
        vif.pwrite = 1'b0;
        vif.paddr = 16'h0000;
        vif.pwdata = 32'h0000_0000;

        `uvm_info("DRV", "System Reset activated", UVM_NONE);

        repeat (5) @(posedge vif.pclk);

        // Release reset
        vif.presetn = 1'b1;

        `uvm_info("DRV", "System Reset deactivated", UVM_NONE);

        // Give one clock after reset
        @(posedge vif.pclk);

        endtask

        task drive(reg_seq_item req);

        // SETUP PHASE
        @(posedge vif.pclk);
        vif.psel <= 1'b1;
        vif.penable <= 1'b0;
        vif.pwrite <= req.pwrite;
        vif.paddr <= req.paddr;

        if (req.pwrite)
                vif.pwdata <= req.pwdata;

        // ACCESS PHASE
        @(posedge vif.pclk);
        vif.penable <= 1'b1;

        // Wait for access completion
        @(negedge vif.pclk);

        if (vif.pready) begin
                if (!req.pwrite) begin
                req.prdata = vif.prdata;
                        `uvm_info("DRV",$sformatf("READ addr=%0h prdata=%0h psel=%0b ",req.paddr, req.prdata, vif.psel),UVM_LOW)
                end
                else begin
                `uvm_info("DRV",$sformatf("WRITE addr=%0h pwdata=%0h", req.paddr, req.pwdata),UVM_LOW)
                end
        end

        // IDLE
        @(posedge vif.pclk);
        vif.psel    <= 1'b0;
        vif.penable <= 1'b0;

        endtask
endclass
