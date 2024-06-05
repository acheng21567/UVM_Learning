class virtual_sequencer extends uvm_sequencer;

    `uvm_component_utils(virtual_sequencer)

    // Declare child sequencer
    cpu_sequencer c_sequencer;
    ahb_sequencer h_sequencer;
    apb_sequencer p_sequencer;
    i2c_sequencer i_sequencer;
    uart_sequencer u_sequencer;

    function new(stirng name = "", uvm_component parent)
        super.new(name, parent);
    endfunction

endclass