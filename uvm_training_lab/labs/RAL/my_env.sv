class my_env extends uvm_env;

    // Other declaration ...

    // Declare reg_model and adapter
    reg_model_c reg_model;
    my_adapter reg_adapter;

    virtual function void build_phase(uvm_phase phase);
        // Other code ...

        reg_model = reg_model_c::type_id::create("reg_model", this);
        reg_model.configure(null, "tb.dut");
        reg_model.build();
        reg_model.lock();
        reg_model.reset();

        reg_adapter = my_adapter::type_id::create("reg_adapter", this);

        // Other code ...
    endfunction

    virtual function void connect_phase(uvm_phase phase);
        // Other code ...

        reg_model.default_map.set_sequencer(agent.sequencer, reg_adapter); // Connect sequencer with adapter
        reg_model.default_map.set_auto_predict(1);

        scoreboard.reg_model = reg_model;

        // Other code ...
    endfunction

endclass