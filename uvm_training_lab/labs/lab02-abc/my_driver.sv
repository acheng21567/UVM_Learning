class my_driver extends uvm_driver #(my_transaction);

    `uvm_component_utils(my_driver)

    function new(string name = "my_driver", uvm_component parent);
        super.new(name, parent);
    endfunction

    /**
     * Lab02-a - Will display with raise and drop
     */
    virtual task reset_phase(uvm_phase phase);
        phase.raise_objection(this);
        #100;
        `uvm_info("DRV_RESET_PHASE", "Now driver reset the DUT...", UVM_MEDIUM)
        phase.drop_objection(this);
    endtask

    /**
     * Lab02-b - Will not display
     */
    // virtual task reset_phase(uvm_phase phase);
    //     #100;
    //     phase.raise_objection(this);
    //     #100;
    //     `uvm_info("DRV_RESET_PHASE", "Now driver reset the DUT...", UVM_MEDIUM)
    //     phase.drop_objection(this);
    // endtask

    /**
     * Lab02-c - Will display reset but not configure phase
     *           Never exit reset phase so simulation does not stop
     */
    // virtual task reset_phase(uvm_phase phase);
    //     #100;
    //     phase.raise_objection(this);
    //     #100;
    //     `uvm_info("DRV_RESET_PHASE", "Now driver reset the DUT...", UVM_MEDIUM)
    // endtask

    virtual task configure_phase(uvm_phase phase);
        phase.raise_objection(this);
        #100;
        `uvm_info("DRV_CONFIGURE_PHASE", "Now driver config the DUT...", UVM_MEDIUM)
        phase.drop_objection(this);
    endtask

    virtual task run_phase(uvm_phase phase);
        #3000;
        forever begin
            seq_item_port.get_next_item(req);
            `uvm_info("DRV_RUN_PHASE", req.sprint(), UVM_MEDIUM)
            #100;
            seq_item_port.item_done();
        end
    endtask
 
endclass