module serram_combMem_1_DebugHarness_UNIQUIFIED(	// @[Decoupled.scala:273:95]
  input         R0_addr,
                R0_en,
                R0_clk,
                W0_addr,
                W0_en,
                W0_clk,
  input  [77:0] W0_data,
  output [77:0] R0_data
);

  reg [77:0] Memory[0:1];	// @[Decoupled.scala:273:95]
  always @(posedge W0_clk) begin	// @[Decoupled.scala:273:95]
    if (W0_en)	// @[Decoupled.scala:273:95]
      Memory[W0_addr] <= W0_data;	// @[Decoupled.scala:273:95]
  end // always @(posedge)
  `ifndef SYNTHESIS	// @[Decoupled.scala:273:95]
    `ifdef RANDOMIZE_MEM_INIT	// @[Decoupled.scala:273:95]
      integer initvar;	// @[Decoupled.scala:273:95]
      reg [95:0] _RANDOM_MEM;	// @[Decoupled.scala:273:95]
    `endif // RANDOMIZE_MEM_INIT
    initial begin	// @[Decoupled.scala:273:95]
      `INIT_RANDOM_PROLOG_	// @[Decoupled.scala:273:95]
      `ifdef RANDOMIZE_MEM_INIT	// @[Decoupled.scala:273:95]
        for (initvar = 0; initvar < 2; initvar = initvar + 1) begin
          _RANDOM_MEM = {{`RANDOM}, {`RANDOM}, {`RANDOM}};
          Memory[initvar] = _RANDOM_MEM[77:0];
        end	// @[Decoupled.scala:273:95]
      `endif // RANDOMIZE_MEM_INIT
    end // initial
  `endif // not def SYNTHESIS
  assign R0_data = R0_en ? Memory[R0_addr] : 78'bx;	// @[Decoupled.scala:273:95]
endmodule

