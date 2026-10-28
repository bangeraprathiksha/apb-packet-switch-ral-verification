class reg_seq_item extends uvm_sequence_item;
        `uvm_object_utils(reg_seq_item)

        bit presetn;
        bit psel;
        bit penable;
        bit pwrite;
        bit [15:0] paddr;
        bit[31:0] pwdata;
        bit[31:0] prdata;
        bit pready;
        bit pslverr;
        bit irq;

        function new(string name = "reg_seq_item");
                super.new(name);
        endfunction
endclass
