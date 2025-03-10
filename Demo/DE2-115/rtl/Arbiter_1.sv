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

module Arbiter_1(
  input         io_in_0_valid,
  input  [39:0] io_in_0_bits_addr,
  input  [8:0]  io_in_0_bits_tag,
  input  [4:0]  io_in_0_bits_cmd,
  input  [1:0]  io_in_0_bits_size,
  input         io_in_0_bits_signed,
  input  [1:0]  io_in_0_bits_dprv,
  input         io_in_0_bits_dv,
                io_in_0_bits_phys,
                io_in_0_bits_no_alloc,
                io_in_0_bits_no_xcpt,
  input  [63:0] io_in_0_bits_data,
  input  [7:0]  io_in_0_bits_mask,
  input         io_out_ready,
  output        io_in_0_ready,
                io_out_valid,
  output [39:0] io_out_bits_addr,
  output [8:0]  io_out_bits_tag,
  output [4:0]  io_out_bits_cmd,
  output [1:0]  io_out_bits_size,
  output        io_out_bits_signed,
  output [1:0]  io_out_bits_dprv,
  output        io_out_bits_dv,
                io_out_bits_phys,
                io_out_bits_no_alloc,
                io_out_bits_no_xcpt,
  output [63:0] io_out_bits_data,
  output [7:0]  io_out_bits_mask
);

  assign io_in_0_ready = io_out_ready;
  assign io_out_valid = io_in_0_valid;
  assign io_out_bits_addr = io_in_0_valid ? io_in_0_bits_addr : 40'h0;	// @[Arbiter.scala:136:15, :138:26, :140:19]
  assign io_out_bits_tag = io_in_0_valid ? io_in_0_bits_tag : 9'h0;	// @[Arbiter.scala:136:15, :138:26, :140:19]
  assign io_out_bits_cmd = io_in_0_valid ? io_in_0_bits_cmd : 5'h0;	// @[Arbiter.scala:136:15, :138:26, :140:19]
  assign io_out_bits_size = io_in_0_valid ? io_in_0_bits_size : 2'h0;	// @[Arbiter.scala:136:15, :138:26, :140:19]
  assign io_out_bits_signed = io_in_0_valid & io_in_0_bits_signed;	// @[Arbiter.scala:136:15, :138:26, :140:19]
  assign io_out_bits_dprv = io_in_0_valid ? io_in_0_bits_dprv : 2'h0;	// @[Arbiter.scala:136:15, :138:26, :140:19]
  assign io_out_bits_dv = io_in_0_valid & io_in_0_bits_dv;	// @[Arbiter.scala:136:15, :138:26, :140:19]
  assign io_out_bits_phys = io_in_0_valid & io_in_0_bits_phys;	// @[Arbiter.scala:136:15, :138:26, :140:19]
  assign io_out_bits_no_alloc = io_in_0_valid & io_in_0_bits_no_alloc;	// @[Arbiter.scala:136:15, :138:26, :140:19]
  assign io_out_bits_no_xcpt = io_in_0_valid & io_in_0_bits_no_xcpt;	// @[Arbiter.scala:136:15, :138:26, :140:19]
  assign io_out_bits_data = io_in_0_valid ? io_in_0_bits_data : 64'h0;	// @[Arbiter.scala:136:15, :138:26, :140:19]
  assign io_out_bits_mask = io_in_0_valid ? io_in_0_bits_mask : 8'h0;	// @[Arbiter.scala:136:15, :138:26, :140:19]
endmodule

