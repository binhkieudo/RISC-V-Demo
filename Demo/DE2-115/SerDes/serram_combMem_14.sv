module serram_combMem_14(	// @[Decoupled.scala:273:95]
  input          R0_addr,
                 R0_en,
                 R0_clk,
                 W0_addr,
                 W0_en,
                 W0_clk,
  input  [122:0] W0_data,
  output [122:0] R0_data
);

  reg [122:0] Memory[0:1];	// @[Decoupled.scala:273:95]
  always @(posedge W0_clk) begin	// @[Decoupled.scala:273:95]
    if (W0_en)	// @[Decoupled.scala:273:95]
      Memory[W0_addr] <= W0_data;	// @[Decoupled.scala:273:95]
  end // always @(posedge)
  `ifndef SYNTHESIS	// @[Decoupled.scala:273:95]
    `ifdef RANDOMIZE_MEM_INIT	// @[Decoupled.scala:273:95]
      integer initvar;	// @[Decoupled.scala:273:95]
      reg [127:0] _RANDOM_MEM;	// @[Decoupled.scala:273:95]
    `endif // RANDOMIZE_MEM_INIT
    initial begin	// @[Decoupled.scala:273:95]
      `INIT_RANDOM_PROLOG_	// @[Decoupled.scala:273:95]
      `ifdef RANDOMIZE_MEM_INIT	// @[Decoupled.scala:273:95]
        for (initvar = 0; initvar < 2; initvar = initvar + 1) begin
          _RANDOM_MEM = {{`RANDOM}, {`RANDOM}, {`RANDOM}, {`RANDOM}};
          Memory[initvar] = _RANDOM_MEM[122:0];
        end	// @[Decoupled.scala:273:95]
      `endif // RANDOMIZE_MEM_INIT
    end // initial
  `endif // not def SYNTHESIS
  assign R0_data = R0_en ? Memory[R0_addr] : 123'bx;	// @[Decoupled.scala:273:95]
endmodule

