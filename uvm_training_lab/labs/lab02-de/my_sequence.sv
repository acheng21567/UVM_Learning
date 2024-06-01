class my_sequence extends uvm_sequence #(my_transaction);

    `uvm_object_utils(my_sequence)

    function new(string name = "my_sequence");
        super.new(name);
    endfunction

    virtual task body();

        // uvm_phase starting_phase = get_starting_phase(); // Add by me
        if(starting_phase != null)
            starting_phase.raise_objection(this);

        repeat(10) begin
            `uvm_do(req)
        end

        #100;
        if(starting_phase != null)
            starting_phase.drop_objection(this);
    endtask
endclass