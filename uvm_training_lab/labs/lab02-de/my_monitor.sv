class my_monitor extends uvm_monitor;

    `uvm_component_utils(my_monitor)

    function new(string name = "", uvm_component parent);
        super.new(name, parent);
    endfunction

    /**
     * Lab02-d - #50 Will display since my_driver has raise and drop
                 but #150 will not since #100 reset_phase exits
     */
    vitrual task reset_phase(uvm_phase phase);
        #50;        // Will display
        // #150;    // Will not display
        `uvm_info("MON_RESET_PHASE", "Now Monitor reset_phase running!", UVM_MEDIUM)
    endtask

    /**
     * Lab02-e - Will display with raise and drop
     */
    vitrual task reset_phase(uvm_phase phase);
        phase.raise_objection(this);
        #150;
        `uvm_info("MON_RESET_PHASE", "Now Monitor reset_phase running!", UVM_MEDIUM)
        phase.drop_objection(this);
    endtask

    virtual task run_phase(uvm_phase phase);
        forever begin
            `uvm_info("MON_RUN_PHASE", "Monitor run!", UVM_MEDIUM)
            #100;
        end
    endtask
    
endclass