// Generated by CIRCT unknown git version
// Standard header to adapt well known macros to our needs.
`ifndef RANDOMIZE
  `ifdef RANDOMIZE_REG_INIT
    `define RANDOMIZE
  `endif // RANDOMIZE_REG_INIT
`endif // not def RANDOMIZE
`ifndef RANDOMIZE
  `ifdef RANDOMIZE_MEM_INIT
    `define RANDOMIZE
  `endif // RANDOMIZE_MEM_INIT
`endif // not def RANDOMIZE

// RANDOM may be set to an expression that produces a 32-bit random unsigned value.
`ifndef RANDOM
  `define RANDOM $random
`endif // not def RANDOM

// Users can define 'PRINTF_COND' to add an extra gate to prints.
`ifndef PRINTF_COND_
  `ifdef PRINTF_COND
    `define PRINTF_COND_ (`PRINTF_COND)
  `else  // PRINTF_COND
    `define PRINTF_COND_ 1
  `endif // PRINTF_COND
`endif // not def PRINTF_COND_

// Users can define 'ASSERT_VERBOSE_COND' to add an extra gate to assert error printing.
`ifndef ASSERT_VERBOSE_COND_
  `ifdef ASSERT_VERBOSE_COND
    `define ASSERT_VERBOSE_COND_ (`ASSERT_VERBOSE_COND)
  `else  // ASSERT_VERBOSE_COND
    `define ASSERT_VERBOSE_COND_ 1
  `endif // ASSERT_VERBOSE_COND
`endif // not def ASSERT_VERBOSE_COND_

// Users can define 'STOP_COND' to add an extra gate to stop conditions.
`ifndef STOP_COND_
  `ifdef STOP_COND
    `define STOP_COND_ (`STOP_COND)
  `else  // STOP_COND
    `define STOP_COND_ 1
  `endif // STOP_COND
`endif // not def STOP_COND_

// Users can define INIT_RANDOM as general code that gets injected into the
// initializer block for modules with registers.
`ifndef INIT_RANDOM
  `define INIT_RANDOM
`endif // not def INIT_RANDOM

// If using random initialization, you can also define RANDOMIZE_DELAY to
// customize the delay used, otherwise 0.002 is used.
`ifndef RANDOMIZE_DELAY
  `define RANDOMIZE_DELAY 0.002
`endif // not def RANDOMIZE_DELAY

// Define INIT_RANDOM_PROLOG_ for use in our modules below.
`ifndef INIT_RANDOM_PROLOG_
  `ifdef RANDOMIZE
    `ifdef VERILATOR
      `define INIT_RANDOM_PROLOG_ `INIT_RANDOM
    `else  // VERILATOR
      `define INIT_RANDOM_PROLOG_ `INIT_RANDOM #`RANDOMIZE_DELAY begin end
    `endif // VERILATOR
  `else  // RANDOMIZE
    `define INIT_RANDOM_PROLOG_
  `endif // RANDOMIZE
`endif // not def INIT_RANDOM_PROLOG_

module UARTTx(
  input         clock,
                reset,
                io_en,
                io_in_valid,
  input  [7:0]  io_in_bits,
  input  [15:0] io_div,
  input         io_nstop,
  output        io_in_ready,
                io_out
);

  reg  [15:0] prescaler;	// @[UARTTx.scala:53:26]
  reg  [3:0]  counter;	// @[UARTTx.scala:58:24]
  reg  [8:0]  shifter;	// @[UARTTx.scala:59:20]
  reg         out;	// @[UARTTx.scala:60:20]
  wire        _io_in_ready_output = io_en & ~(|counter);	// @[UARTTx.scala:58:24, :66:23, :67:{24,27}]
  wire        _T_4 = _io_in_ready_output & io_in_valid;	// @[Decoupled.scala:51:35, UARTTx.scala:67:24]
  wire        pulse = prescaler == 16'h0;	// @[UARTTx.scala:53:26, :54:26]
  wire        _T_5 = _T_4;	// @[Decoupled.scala:51:35, PlusArg.scala:80:11, UARTTx.scala:63:90, :72:20]
  wire        _T_6 = pulse & (|counter);	// @[UARTTx.scala:54:26, :58:24, :66:23, :95:15]
  always @(posedge clock) begin
    if (reset) begin
      prescaler <= 16'h0;	// @[UARTTx.scala:53:26]
      counter <= 4'h0;	// @[UARTTx.scala:58:24]
      out <= 1'h1;	// @[UARTTx.scala:60:20]
    end
    else begin
      if (|counter) begin	// @[UARTTx.scala:58:24, :66:23]
        if (pulse)	// @[UARTTx.scala:54:26]
          prescaler <= io_div;	// @[UARTTx.scala:53:26]
        else	// @[UARTTx.scala:54:26]
          prescaler <= prescaler - 16'h1;	// @[UARTTx.scala:53:26, :93:78]
      end
      if (_T_6) begin	// @[UARTTx.scala:95:15]
        counter <= counter - 4'h1;	// @[UARTTx.scala:58:24, :96:24]
        out <= shifter[0];	// @[UARTTx.scala:59:20, :60:20, :98:19]
      end
      else if (_T_5)	// @[UARTTx.scala:72:20]
        counter <= (io_nstop ? 4'h0 : 4'hA) | (io_nstop ? 4'hB : 4'h0);	// @[Mux.scala:27:73, UARTTx.scala:58:24]
    end
    if (_T_6)	// @[UARTTx.scala:95:15]
      shifter <= {1'h1, shifter[8:1]};	// @[Cat.scala:33:92, UARTTx.scala:59:20, :60:20, :97:38]
    else if (_T_5)	// @[UARTTx.scala:72:20]
      shifter <= {io_in_bits, 1'h0};	// @[UARTTx.scala:54:26, :59:20, :87:15]
  end // always @(posedge)
  assign io_in_ready = _io_in_ready_output;	// @[UARTTx.scala:67:24]
  assign io_out = out;	// @[UARTTx.scala:60:20]
endmodule

