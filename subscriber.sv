class subscriber extends uvm_component;
        `uvm_component_utils(subscriber)

        uvm_analysis_imp #(reg_seq_item, subscriber) subscrb_port;

        reg_seq_item cov_item;
        real item_cov;

        covergroup cg;
                option.per_instance = 1;
                presetn_cp : coverpoint cov_item.presetn{
                        bins rst_bin = {0};
                }
                pwrite_cp : coverpoint cov_item.pwrite{
                        bins wr_en_bin[] = {0, 1};
                }
                psel_cp : coverpoint cov_item.psel{
                        bins psel_bin = {0};
                }
                penable_cp : coverpoint cov_item.penable{
                        bins penable_bin = {[0:$]};
                }
                pwdata_cp : coverpoint cov_item.pwdata{
                        bins pwdata_bin = {[0:$]};
                }
                prdata_cp : coverpoint cov_item.prdata{
                        bins prdata_bin = {[0:$]};
                }
                paddr_cp : coverpoint cov_item.paddr{
                        bins addr_bin = {[0:$]};
                }
        endgroup

        function new(string name = "subscriber", uvm_component parent);
                super.new(name, parent);
                cg = new();
                subscrb_port = new("subscrb_port", this);
        endfunction


        function void write(reg_seq_item t);
                cov_item = t;
                cg.sample();
        endfunction

        function void extract_phase(uvm_phase phase);
                super.extract_phase(phase);
                item_cov = cg.get_coverage();
        endfunction

        function void report_phase(uvm_phase phase);
                super.report_phase(phase);
                `uvm_info(get_type_name, $sformatf(" Coverage ------> %0.2f%%,", item_cov), UVM_MEDIUM);
        endfunction

endclass
