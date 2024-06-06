class config_reg_c extends uvm_reg;

    // Declare four fields in config_reg
    rand uvm_reg_field f1;
    rand uvm_reg_field f2;
    rand uvm_reg_field f3;
    rand uvm_reg_field f4;

    virtual function void build();

        // Instantiate four fields
        f1 = uvm_reg_field::type_id::create("f1");
        f2 = uvm_reg_field::type_id::create("f2");
        f3 = uvm_reg_field::type_id::create("f3");
        f4 = uvm_reg_field::type_id::create("f4");

        // configure(which reg, bit width, LSB position, access attribute, reset val, can be reset, can be randomized, can be access solely)
        f1.configure(this, 1, 0, "RW", 0, 'h0, 1, 1, 1);
        f2.configure(this, 1, 1, "RO", 0, 'h0, 1, 1, 1);
        f3.configure(this, 5, 2, "RW", 0, 'h0, 1, 1, 1);
        f4.configure(this, 1, 7, "RW", 0, 'h0, 1, 1, 1);

    endfunction

    `uvm_object_utils(config_reg_c)

    function new(string name = "config_reg_c");
        // super.new(name, total bit width, coverage)
        super.new(name, 8, UVM_NO_COVERAGE);
    endfunction

endclass