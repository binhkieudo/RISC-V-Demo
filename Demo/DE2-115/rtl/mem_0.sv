module mem_0(	// @[DescribedSRAM.scala:17:26]
  input  [8:0]  RW0_addr,
  input         RW0_en,
                RW0_clk,
                RW0_wmode,
  input  [63:0] RW0_wdata,
  input  [7:0]  RW0_wmask,
  output [63:0] RW0_rdata
);

  wire rstn = !(RW0_addr[8] & RW0_en);
  wire [31:0] sha3_rdata;
  wire [31:0] sha3_wdata = &RW0_wmask[7:4] ? RW0_wdata[63:32]: RW0_wdata[31:0];
   
  sha3 sha3 (
      .clk        (RW0_clk        ),
      .reset_n    (rstn           ),
      .cs         (1'b1           ),
      .we         (RW0_wmode      ),
      .address    (RW0_addr[7:0]  ),
      .write_data (sha3_wdata     ),
      .read_data  (sha3_rdata     )
  );
  
    assign RW0_rdata = sha3_rdata;
  
endmodule

