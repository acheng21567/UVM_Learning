class my_adapter extends uvm_reg_adapter;

    `uvm_object_utils(my_adapter)

    function new(string name = "my_adapter");
        super.new(name);
    endfunction

    // Convert a reg_model transaction to transaction that accepted by sequencer
    function uvm_sequence_item reg2bus(const reg uvm_reg_bus_op rw);

        cpu_trans cpu_tr;
        cpu_tr = cpu_trans::type_id::create("cpu_tr");
        cpu_tr.addr = rw.addr;
        cpu_tr.acc = (rw.kind == UVM_READ) ? CPU_R : CPU_W;
        if(cpu_tr.acc == CPU_R)
            cpu_tr.data = rw.data;
        return cpu_tr;

    endfunction

    // Convert transaction that accepted by sequencer to a reg_model transaction
    function void bus2reg(uvm_sequence_item bus_item, ref uvm_reg_bus_op rw);

        cpu_trans cpu_tr;
        if(!$cast(cpu_tr, bus_item)) begin
            `uvm_fatal("ADAPTER", "The bus_item type not correct!!!")
            return;
        end

        rw.kind = (cpu_tr.acc == CPU_R) ? UVM_READ : UVM_WRITE;
        rw.addr = cpu_tr.addr;
        rw.byte_en = 0;
        rw.data = cpu_tr.data;
        rw.status = UVM_IS_OK;

    endfunction

endclass