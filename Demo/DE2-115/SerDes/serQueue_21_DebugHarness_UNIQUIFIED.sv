module serQueue_21_DebugHarness_UNIQUIFIED(
  input         clock,
                reset,
                io_enq_valid,
  input  [2:0]  io_enq_bits_opcode,
                io_enq_bits_param,
  input  [3:0]  io_enq_bits_size,
  input         io_enq_bits_source,
  input  [31:0] io_enq_bits_address,
  input  [7:0]  io_enq_bits_mask,
  input  [63:0] io_enq_bits_data,
  input         io_deq_ready,
  output        io_enq_ready,
                io_deq_valid,
  output [2:0]  io_deq_bits_opcode,
                io_deq_bits_param,
  output [3:0]  io_deq_bits_size,
  output        io_deq_bits_source,
  output [31:0] io_deq_bits_address,
  output [7:0]  io_deq_bits_mask,
  output [63:0] io_deq_bits_data,
  output        io_deq_bits_corrupt
);

  wire [115:0] _ram_ext_R0_data;	// @[Decoupled.scala:273:95]
  reg          enq_ptr_value;	// @[Counter.scala:61:40]
  reg          deq_ptr_value;	// @[Counter.scala:61:40]
  reg          maybe_full;	// @[Decoupled.scala:276:27]
  wire         ptr_match = enq_ptr_value == deq_ptr_value;	// @[Counter.scala:61:40, Decoupled.scala:277:33]
  wire         empty = ptr_match & ~maybe_full;	// @[Decoupled.scala:276:27, :277:33, :278:{25,28}]
  wire         full = ptr_match & maybe_full;	// @[Decoupled.scala:276:27, :277:33, :279:24]
  wire         do_enq = ~full & io_enq_valid;	// @[Decoupled.scala:51:35, :279:24, :303:19]
  wire         do_deq = io_deq_ready & ~empty;	// @[Decoupled.scala:51:35, :278:25, :302:19]
  always @(posedge clock) begin
    if (reset) begin
      enq_ptr_value <= 1'h0;	// @[Counter.scala:61:40]
      deq_ptr_value <= 1'h0;	// @[Counter.scala:61:40]
      maybe_full <= 1'h0;	// @[Decoupled.scala:276:27]
    end
    else begin
      if (do_enq)	// @[Decoupled.scala:51:35]
        enq_ptr_value <= enq_ptr_value - 1'h1;	// @[Counter.scala:61:40, :77:24]
      if (do_deq)	// @[Decoupled.scala:51:35]
        deq_ptr_value <= deq_ptr_value - 1'h1;	// @[Counter.scala:61:40, :77:24]
      if (do_enq != do_deq)	// @[Decoupled.scala:51:35, :293:15]
        maybe_full <= do_enq;	// @[Decoupled.scala:51:35, :276:27]
    end
  end // always @(posedge)
  `ifndef SYNTHESIS
    `ifdef FIRRTL_BEFORE_INITIAL
      `FIRRTL_BEFORE_INITIAL
    `endif // FIRRTL_BEFORE_INITIAL
    logic [31:0] _RANDOM_0;
    initial begin
      `ifdef INIT_RANDOM_PROLOG_
        `INIT_RANDOM_PROLOG_
      `endif // INIT_RANDOM_PROLOG_
      `ifdef RANDOMIZE_REG_INIT
        _RANDOM_0 = `RANDOM;
        enq_ptr_value = _RANDOM_0[0];	// @[Counter.scala:61:40]
        deq_ptr_value = _RANDOM_0[1];	// @[Counter.scala:61:40]
        maybe_full = _RANDOM_0[2];	// @[Counter.scala:61:40, Decoupled.scala:276:27]
      `endif // RANDOMIZE_REG_INIT
    end // initial
    `ifdef FIRRTL_AFTER_INITIAL
      `FIRRTL_AFTER_INITIAL
    `endif // FIRRTL_AFTER_INITIAL
  `endif // not def SYNTHESIS
  serram_combMem_10_DebugHarness_UNIQUIFIED ram_ext (	// @[Decoupled.scala:273:95]
    .R0_addr (deq_ptr_value),	// @[Counter.scala:61:40]
    .R0_en   (1'h1),
    .R0_clk  (clock),
    .W0_addr (enq_ptr_value),	// @[Counter.scala:61:40]
    .W0_en   (do_enq),	// @[Decoupled.scala:51:35]
    .W0_clk  (clock),
    .W0_data ({1'h0, io_enq_bits_data, io_enq_bits_mask, io_enq_bits_address, io_enq_bits_source, io_enq_bits_size, io_enq_bits_param, io_enq_bits_opcode}),	// @[Decoupled.scala:273:95]
    .R0_data (_ram_ext_R0_data)
  );
  assign io_enq_ready = ~full;	// @[Decoupled.scala:279:24, :303:19]
  assign io_deq_valid = ~empty;	// @[Decoupled.scala:278:25, :302:19]
  assign io_deq_bits_opcode = _ram_ext_R0_data[2:0];	// @[Decoupled.scala:273:95]
  assign io_deq_bits_param = _ram_ext_R0_data[5:3];	// @[Decoupled.scala:273:95]
  assign io_deq_bits_size = _ram_ext_R0_data[9:6];	// @[Decoupled.scala:273:95]
  assign io_deq_bits_source = _ram_ext_R0_data[10];	// @[Decoupled.scala:273:95]
  assign io_deq_bits_address = _ram_ext_R0_data[42:11];	// @[Decoupled.scala:273:95]
  assign io_deq_bits_mask = _ram_ext_R0_data[50:43];	// @[Decoupled.scala:273:95]
  assign io_deq_bits_data = _ram_ext_R0_data[114:51];	// @[Decoupled.scala:273:95]
  assign io_deq_bits_corrupt = _ram_ext_R0_data[115];	// @[Decoupled.scala:273:95]
endmodule

