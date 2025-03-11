module serRepeater_8(
  input         clock,
                reset,
                io_repeat,
                io_enq_valid,
  input  [2:0]  io_enq_bits_opcode,
                io_enq_bits_param,
                io_enq_bits_size,
  input  [6:0]  io_enq_bits_source,
  input  [30:0] io_enq_bits_address,
  input  [7:0]  io_enq_bits_mask,
  input         io_enq_bits_corrupt,
                io_deq_ready,
  output        io_full,
                io_enq_ready,
                io_deq_valid,
  output [2:0]  io_deq_bits_opcode,
                io_deq_bits_param,
                io_deq_bits_size,
  output [6:0]  io_deq_bits_source,
  output [30:0] io_deq_bits_address,
  output [7:0]  io_deq_bits_mask,
  output        io_deq_bits_corrupt
);

  reg         full;	// @[Repeater.scala:19:21]
  reg  [2:0]  saved_opcode;	// @[Repeater.scala:20:18]
  reg  [2:0]  saved_param;	// @[Repeater.scala:20:18]
  reg  [2:0]  saved_size;	// @[Repeater.scala:20:18]
  reg  [6:0]  saved_source;	// @[Repeater.scala:20:18]
  reg  [30:0] saved_address;	// @[Repeater.scala:20:18]
  reg  [7:0]  saved_mask;	// @[Repeater.scala:20:18]
  reg         saved_corrupt;	// @[Repeater.scala:20:18]
  wire        _io_deq_valid_output = io_enq_valid | full;	// @[Repeater.scala:19:21, :23:32]
  wire        _io_enq_ready_output = io_deq_ready & ~full;	// @[Repeater.scala:19:21, :24:{32,35}]
  wire        _T_1 = _io_enq_ready_output & io_enq_valid & io_repeat;	// @[Repeater.scala:24:32, :28:23]
  always @(posedge clock) begin
    if (reset)
      full <= 1'h0;	// @[Repeater.scala:19:21]
    else
      full <= ~(io_deq_ready & _io_deq_valid_output & ~io_repeat) & (_T_1 | full);	// @[Repeater.scala:19:21, :23:32, :28:{23,38,45}, :29:{23,26,38,45}]
    if (_T_1) begin	// @[Repeater.scala:28:23]
      saved_opcode <= io_enq_bits_opcode;	// @[Repeater.scala:20:18]
      saved_param <= io_enq_bits_param;	// @[Repeater.scala:20:18]
      saved_size <= io_enq_bits_size;	// @[Repeater.scala:20:18]
      saved_source <= io_enq_bits_source;	// @[Repeater.scala:20:18]
      saved_address <= io_enq_bits_address;	// @[Repeater.scala:20:18]
      saved_mask <= io_enq_bits_mask;	// @[Repeater.scala:20:18]
      saved_corrupt <= io_enq_bits_corrupt;	// @[Repeater.scala:20:18]
    end
  end // always @(posedge)
  `ifndef SYNTHESIS
    `ifdef FIRRTL_BEFORE_INITIAL
      `FIRRTL_BEFORE_INITIAL
    `endif // FIRRTL_BEFORE_INITIAL
    logic [31:0] _RANDOM_0;
    logic [31:0] _RANDOM_1;
    logic [31:0] _RANDOM_2;
    logic [31:0] _RANDOM_3;
    initial begin
      `ifdef INIT_RANDOM_PROLOG_
        `INIT_RANDOM_PROLOG_
      `endif // INIT_RANDOM_PROLOG_
      `ifdef RANDOMIZE_REG_INIT
        _RANDOM_0 = `RANDOM;
        _RANDOM_1 = `RANDOM;
        _RANDOM_2 = `RANDOM;
        _RANDOM_3 = `RANDOM;
        full = _RANDOM_0[0];	// @[Repeater.scala:19:21]
        saved_opcode = _RANDOM_0[3:1];	// @[Repeater.scala:19:21, :20:18]
        saved_param = _RANDOM_0[6:4];	// @[Repeater.scala:19:21, :20:18]
        saved_size = _RANDOM_0[9:7];	// @[Repeater.scala:19:21, :20:18]
        saved_source = _RANDOM_0[16:10];	// @[Repeater.scala:19:21, :20:18]
        saved_address = {_RANDOM_0[31:17], _RANDOM_1[15:0]};	// @[Repeater.scala:19:21, :20:18]
        saved_mask = _RANDOM_1[23:16];	// @[Repeater.scala:20:18]
        saved_corrupt = _RANDOM_3[24];	// @[Repeater.scala:20:18]
      `endif // RANDOMIZE_REG_INIT
    end // initial
    `ifdef FIRRTL_AFTER_INITIAL
      `FIRRTL_AFTER_INITIAL
    `endif // FIRRTL_AFTER_INITIAL
  `endif // not def SYNTHESIS
  assign io_full = full;	// @[Repeater.scala:19:21]
  assign io_enq_ready = _io_enq_ready_output;	// @[Repeater.scala:24:32]
  assign io_deq_valid = _io_deq_valid_output;	// @[Repeater.scala:23:32]
  assign io_deq_bits_opcode = full ? saved_opcode : io_enq_bits_opcode;	// @[Repeater.scala:19:21, :20:18, :25:21]
  assign io_deq_bits_param = full ? saved_param : io_enq_bits_param;	// @[Repeater.scala:19:21, :20:18, :25:21]
  assign io_deq_bits_size = full ? saved_size : io_enq_bits_size;	// @[Repeater.scala:19:21, :20:18, :25:21]
  assign io_deq_bits_source = full ? saved_source : io_enq_bits_source;	// @[Repeater.scala:19:21, :20:18, :25:21]
  assign io_deq_bits_address = full ? saved_address : io_enq_bits_address;	// @[Repeater.scala:19:21, :20:18, :25:21]
  assign io_deq_bits_mask = full ? saved_mask : io_enq_bits_mask;	// @[Repeater.scala:19:21, :20:18, :25:21]
  assign io_deq_bits_corrupt = full ? saved_corrupt : io_enq_bits_corrupt;	// @[Repeater.scala:19:21, :20:18, :25:21]
endmodule

