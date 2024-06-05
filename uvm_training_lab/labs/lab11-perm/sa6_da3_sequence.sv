class sa6_da3_sequence extends my_sequence;

    `uvm_object_utils(sa6_da3_sequence)

    // Add to sequence library permanently
    `uvm_add_to_seq_lib(sa6_da3_sequence, my_sequence_lib)

    int item_num = 10;
    function new(string name = "sa6_da3_sequence");
        super.new(name);
    endfunction

    function void pre_randomize();
        uvm_config_db#(int)::get(m_sequencer, "", "item_num", item_num);
    endfunction

    virtual task body();
        my_transaction tr;
        if(starting_phase != null)
            starting_phase.raise_objection(this);

        repeat(item_num) begin
            // Equivalent to `uvm_do(req)
            tr = my_transaction::type_id::create("tr");
            start_item(tr);
            tr.randomize() with {(tr.sa == 6) && (tr.da == 3);};
            finish_item(tr);

            get_response(rsp);
            `uvm_info("SA6_DA3_SEQ", {"\n", "Sequence get the resposne: \n", rsp.sprint()}, UVM_MEDIUM)
        end

        #100;
        if(starting_phase != null)
            starting_phase.drop_objection(this);
    endtask
endclass