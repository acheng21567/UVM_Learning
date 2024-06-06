class my_scoreboard extends uvm_scoreboard;

    // Other declaration ...

    reg_model_c reg_model;

    virtual task run_phase(uvm_phase phase);
        // Other code ...

        uvm_status_e status;
        uvm_reg_data_t value;

        forever begin
            // Other code ...
            reg_model.config_reg.write(status, value, UVM_FROOTDOOR); // Use API to write to reg
            // Other code ...
            reg_model.config_reg.read(status, value, UVM_FROOTDOOR); // Use API to read from reg
            // Other code ...
        end

    endtask

    // Other code ...

endclass