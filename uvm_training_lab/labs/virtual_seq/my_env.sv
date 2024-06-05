class my_env extends uvm_env;

    // Declare virtual sequencer
    virtual_sequencer v_seqr;

    // Other declaration ...

    virtual function void build_phase(uvm_phase phase);
        super.build_phase(phase);
        // Other code ...

        // Instantiate virtual sequencer
        v_seqr = virtual_sequencer::type_id::create("v_seqr", this);
    endfunction

    vitrual function void connect_phase(uvm_phase phase);
        // Connect sequencers in virtual sequencer with sequencers in agent
        v_seqr.c_sequencer = CPU_agent.c_sequencer;
        v_seqr.h_sequencer = AHB_agent.h_sequencer;
        v_seqr.p_sequencer = APB_agent.p_sequencer;
        v_seqr.i_sequencer = I2C_agent.i_sequencer;
        v_seqr.u_sequencer = UART_agent.u_sequencer;

        // Other code ...

    endfunction

endclass