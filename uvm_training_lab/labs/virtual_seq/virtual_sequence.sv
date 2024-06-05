class virtual_sequence extends uvm_sequnece;

    `uvm_object_utils(virtual_sequence)

    virtual_sequencer v_seqr;

    cpu_sequence_test cpu_sequence;
    ahb_sequence_test ahb_sequence;
    apb_sequence_test apb_sequence;
    i2c_sequence_test i2c_sequence;
    uart_sequence_test uart_sequence;

    function new(string name = "virtual_sequence");
        super.new(name);
    endfunction

    task body();
        // Previous code ...

        // Instantiate sequence object
        cpu_sequence = cpu_sequence_test::type_id::create("cpu_sequence");
        ahb_sequence = ahb_sequence_test::type_id::create("ahb_sequence");
        apb_sequence = apb_sequence_test::type_id::create("apb_sequence");
        i2c_sequence = i2c_sequence_test::type_id::create("i2c_sequence");
        uart_sequence = uart_sequence_test::type_id::create("uart_sequence");

        // Copy m_sequencer to v_seqr
        if(!$cast(v_seqr, m_sequencer)) begin
            `uvm_fatal("mismatch", "Virtual sequencer mismatch!!!")
        end

        cpu_sequence.start(v_seqr.c_sequencer);
        ahb_sequence.start(v_seqr.h_sequencer);
        apb_sequence.start(v_seqr.p_sequencer);
        fork
            i2c_sequence.start(v_seqr.i_sequencer);
            uart_sequence.start(v_seqr.u_sequencer);    
        join

        // End code ...
    endtask

endclass