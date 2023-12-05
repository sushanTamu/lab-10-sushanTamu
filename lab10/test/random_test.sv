///////////////////////////////////////////////////////////////////////////
// Texas A&M University
// CSCE 616 Hardware Design Verification
// Created by  : Prof. Quinn and Saumil Gogri
///////////////////////////////////////////////////////////////////////////


class random_test extends base_test;

	`uvm_component_utils(random_test)

	function new (string name, uvm_component parent);
		super.new(name, parent);
	endfunction : new

	function void build_phase(uvm_phase phase);
		uvm_config_wrapper::set(this,"tb.vsequencer.run_phase", "default_sequence", random_vsequence::type_id::get());
		super.build_phase(phase);
	endfunction : build_phase

	task run_phase(uvm_phase phase);
		super.run_phase(phase);
		`uvm_info(get_type_name(),"Starting random test",UVM_NONE)
	endtask : run_phase

endclass : random_test



///////////////////////////// VIRTUAL SEQUENCE ///////////////////////////


class random_vsequence extends htax_base_vseq;

  `uvm_object_utils(random_vsequence)

 	htax_packet_c pkt0;
	htax_packet_c pkt1;
	htax_packet_c pkt2;
	htax_packet_c pkt3;

  function new (string name = "random_vsequence");
    super.new(name);
	pkt0 = new();
	pkt1 = new();
	pkt2 = new();
	pkt3 = new();
  endfunction : new


  task body();
		// Exectuing 10 TXNs on fixed port {0,1,2,3} 
	repeat(100) begin
			fork
				`uvm_do_on_with(pkt0, p_sequencer.htax_seqr[0], {pkt0.dest_port==0; pkt0.length inside {[10:16]}; pkt0.delay < 3;})
				`uvm_do_on_with(pkt1, p_sequencer.htax_seqr[1], {pkt1.dest_port==1; pkt1.length inside {[10:16]}; pkt1.delay < 3;})
				`uvm_do_on_with(pkt2, p_sequencer.htax_seqr[2], {pkt2.dest_port==2; pkt2.length inside {[10:16]}; pkt2.delay < 3;})
				`uvm_do_on_with(pkt3, p_sequencer.htax_seqr[3], {pkt3.dest_port==3; pkt3.length inside {[10:16]}; pkt3.delay < 3;})
			join
	end
  endtask : body

endclass : random_vsequence
