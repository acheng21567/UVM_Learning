class my_sequence extends uvm_sequence #(my_transaction);

    `uvm_object_utils(my_sequence)

    int item_num = 10;
    function new(string name = "my_sequence");
        super.new(name);
    endfunction

    function void pre_randomize();
        uvm_config_db#(int)::get(m_sequencer, "", "item_num", item_num);
    endfunction

    virtual task body();
        if(starting_phase != null)
            starting_phase.raise_objection(this);

        repeat(item_num) begin
            `uvm_do(req)
        end

        #100;
        if(starting_phase != null)
            starting_phase.drop_objection(this);
    endtask
endclass