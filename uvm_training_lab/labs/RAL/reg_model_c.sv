class reg_model_c extends uvm_reg_block;

    rand config_reg_c config_reg;
    rand mode_reg_c mode_reg;
    data_mem_c data_mem;

    virtual function void build();

        config_reg = config_reg_c::type_id::create("config_reg", get_full_name());
        // configure(in which reg_blcok, in which reg_page, HDL path for backdoor)
        config_reg.configure(this, null, "config_reg");
        config_reg.build();

        mode_reg = mode_reg_c::type_id::create("mode_reg", get_full_name());
        mode_reg.configure(this, null, "mode_reg");
        mode_reg.build();


        data_mem = data_mem_c::type_id::create("data_mem", get_full_name());
        data_mem.configure(this, "data_mem");

        // create_map(name, base address, width in byte, endian mode)
        default_map = create_map("default_map", 0, 1, UVM_LITTLE_ENDIAN);
        // add_reg(reg name, shift address, access attribute)
        default_map.add_reg(config_reg, 'h001C, "RW");
        default_map.add_reg(mode_reg, 'h002D, "RW");
        default_map.add_mem(data_mem, 'h1000);

    endfunction

    `uvm_object_utils(reg_model_c)

    function new(name = "reg_model_c");
        super.new(name, UVM_NO_COVERAGE)
    endfunction

endclass