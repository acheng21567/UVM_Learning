class my_reference_model extends uvm_component;

    `uvm_component_utils(my_reference_model)

    // Use put mode, since reference model is consumer, use import
    uvm_blocking_put_imp#(my_transaction, my_reference_model) i_m2r_imp;

    function new(string name = "", uvm_component parent);
        super.new(name, parent);
        this.i_m2r_imp = new("i_m2r_imp", this);
    endfunction

    // Override put method
    task put(my_transaction tr);
        `uvm_info("REF_REPORT", {"\n", "master agent have sent a transaction: \n", tr.sprint()}, UVM_MEDIUM)
    endtask

endclass