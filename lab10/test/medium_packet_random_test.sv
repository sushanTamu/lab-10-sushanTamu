///////////////////////////////////////////////////////////////////////////
// Texas A&M University
// CSCE 616 Hardware Design Verification
// Created by  : Prof. Quinn and Saumil Gogri
///////////////////////////////////////////////////////////////////////////


class medium_packet_random_test extends base_test;

	`uvm_component_utils(medium_packet_random_test)

	function new (string name, uvm_component parent);
		super.new(name, parent);
	endfunction : new

	function void build_phase(uvm_phase phase);
		uvm_config_wrapper::set(this,"tb.vsequencer.run_phase", "default_sequence", medium_packet_random_vsequence::type_id::get());
		super.build_phase(phase);
	endfunction : build_phase

	task run_phase(uvm_phase phase);
		super.run_phase(phase);
		`uvm_info(get_type_name(),"Starting medium_packet random test",UVM_NONE)
	endtask : run_phase

endclass : medium_packet_random_test



///////////////////////////// VIRTUAL SEQUENCE ///////////////////////////


class medium_packet_random_vsequence extends htax_base_vseq;

  `uvm_object_utils(medium_packet_random_vsequence)

  rand int port;

  function new (string name = "medium_packet_random_vsequence");
    super.new(name);
  endfunction : new

  task body();
    repeat(100) begin
			`uvm_do_on_with(req, p_sequencer.htax_seqr[0], {req.length inside {[15:40]};})
			`uvm_do_on_with(req, p_sequencer.htax_seqr[1], {req.length inside {[15:40]};})
			`uvm_do_on_with(req, p_sequencer.htax_seqr[2], {req.length inside {[15:40]};})
			`uvm_do_on_with(req, p_sequencer.htax_seqr[3], {req.length inside {[15:40]};})
    end

  endtask : body

endclass : medium_packet_random_vsequence
