class my_test extends uvm_test;

    // Other code ...

    virtual task run_phase(uvm_phase phase);
        // Declare and instantiate virtual sequence object
        virtual_sequence v_seq; 
        v_seq = virtual_sequence::type_id::create("v_seq");

        phase.raise_objection(this);
        // Start sequence
        v_seq.start(m_env.v_seqr);

        phase.drop_objection(this);

    endtask

    // Other code ...

endclass