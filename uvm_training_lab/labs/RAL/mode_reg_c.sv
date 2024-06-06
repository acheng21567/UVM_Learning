class mode_reg_c extends uvm_reg;

    rand uvm_reg_field data;

    virtual function void build();

        data = uvm_reg_field::type_id::create("data");
        data.configure(this, 8, 0, "RW", 0, 'h0, 1, 1, 1);

    endfunction

    `uvm_object_utils(mode_reg_c)

    function new(string name = "mode_reg_c");
        super.new(name, 8, UVM_NO_COVERAGE);
    endfunction

endclass