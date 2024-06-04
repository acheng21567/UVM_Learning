class my_test_type_da3 extends my_test;

    `uvm_component_utils(my_test_type_da3)

    function new(string name = "", uvm_component parent);
        super.new(name, parent);
    endfunction

    virtual function void build_phase(uvm_phase phase);
        super.build_phase(phase);
        
        // Replace my_transaction with my_transaction_da3
        set_type_override_by_type(my_transaction::get_type(), my_transaction_da3::get_type());

        set_type_override_by_type(my_driver::get_type(), my_driver_count::get_type());
    endfunction

    virtual function void report_phase(uvm_phase phase);
        super.report_phase(phase);
        factory.print();
    endfunction
endclass