class my_test extends uvm_test;

    `uvm_component_utils(my_test)

    my_env m_env;
    env_config m_env_cfg;

    // Use configuration object instead of setting three variables
    uvm_sequence_library_cfg my_seqlib_cfg;

    function new(string name = "", uvm_component parent);
        super.new(name, parent);
        m_env_cfg = new("m_env_cfg");
    endfunction

    virtual function void build_phase(uvm_phase phase);
        super.build_phase(phase);
        m_env = my_env::type_id::create("m_env", this);

        // Implement sequence_library in component
        uvm_config_db#(uvm_object_wrapper)::set(
            this, "*.m_seqr.run_phase", "default_sequence", my_sequence_lib::get_type()
        );

        // Use configuration object instead of setting three variables
        my_seqlib_cfg = new("my_seqlib_cfg", UVM_SEQ_LIB_ITEM, 20, 40);
        uvm_config_db#(uvm_sequence_library_cfg)::set(
            this, "*.m_seqr.run_phase", "default_sequence.config", my_seqlib_cfg
        );

        // // Configure selection mode, create item, not sequence
        // uvm_config_db#(uvm_sequence_lib_mode)::set(
        //     this, "*.m_seqr.run_phase", "default_sequence.selection_mode", UVM_SEQ_LIB_ITEM
        // );

        // // Configure minimum random count, create at least 20
        // uvm_config_db#(int unsigned)::set(
        //     this, "*.m_seqr.run_phase", "default_sequence.min_random_count", 20
        // );

        // // Configure maximum random count, create at most 40
        // uvm_config_db#(int unsigned)::set(
        //     this, "*.m_seqr.run_phase", "default_sequence.max_random_count", 40
        // );


        uvm_config_db#(int)::set(this, "*.m_seqr", "item_num", 20);
 
        m_env_cfg.is_coverage = 1;
        m_env_cfg.is_check    = 1;
        m_env_cfg.m_agent_cfg.is_active = UVM_ACTIVE;
        m_env_cfg.m_agent_cfg.pad_cycles  = 10;

        if(!uvm_config_db#(virtual dut_interface)::get(
            this, "", "top_if", m_env_cfg.m_agent_cfg.m_vif
        )) begin
            `uvm_fatal("CONFIG_ERROR", "test can not get the interface!!!")
        end

        uvm_config_db#(env_config)::set(this, "m_env", "env_cfg", m_env_cfg);
    endfunction

    virtual function void start_of_simulation_phase(uvm_phase phase);
        super.start_of_simulation_phase(phase);
        uvm_top.print_topology(uvm_default_tree_printer);
    endfunction

    // virtual task run_phase(uvm_phase phase);
    //     // Implement my_sequence ourselves
    //     my_sequence m_seq;
    //     m_seq = my_sequence::type_id::create("m_seq");
    //     phase.raise_objection(this);
    //     m_seq.start(m_env.m_agent.m_seqr);
    //     phase.drop_objection(this);
    // endtask
endclass