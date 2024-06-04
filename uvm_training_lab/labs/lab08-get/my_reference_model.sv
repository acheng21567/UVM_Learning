class my_reference_model extends uvm_component;

    `uvm_component_utils(my_reference_model)

    // Use get mode, since reference model is consumer, use port
    uvm_blocking_get_port#(my_transaction) i_m2r_port;

    function new(string name = "", uvm_component parent);
        super.new(name, parent);
        this.i_m2r_port = new("i_m2r_port", this);
    endfunction

    virtual task run_phase(uvm_phase phase);
        `uvm_info("REF_MODEL_RUN", "Reference model running!", UVM_MEDIUM)
        forever begin
            my_transaction item;
            i_m2r_port.get(item);
            `uvm_info("REF_REPORT", {"\n", "master agent have sent a transaction\n", item.sprint()}, UVM_MEDIUM)
        end
    endtask
endclass