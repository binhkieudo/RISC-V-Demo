`timescale 1ns/1ps

module fifo_bb #(
    parameter DEPTH = 16,
    parameter WIDTH = 64
)
(
    input   iclk,
    input   irstn,
    input   iwren,
    input   irden,
    input   [WIDTH-1:0] din,
    output  [WIDTH-1:0] dout,
    output  empty,
    output  full
);

    reg [$clog2(DEPTH)-1:0] wptr, nwptr;
    reg [$clog2(DEPTH)-1:0] rptr;

    reg [WIDTH-1:0] fifo [0:DEPTH-1];

    reg [WIDTH-1:0] rdout;

    reg [14:0] counter;
    reg [1:0]  stcount;

    always @(posedge iclk) begin
        if (!irstn) begin
            counter <= 0;
            stcount <= 2'b00;
        end
        else begin
            if (iwren && !full) stcount <= 2'b01;
            else if (stcount == 2'b01) stcount <= 2'b10;
            else if (counter[14]) stcount <= 2'b11;
            else if (stcount == 2'b11) stcount <= 2'b00;

            if (stcount == 2'b10) counter <= counter + 1'b1;
            else counter <= 0;

        end
    end

    always @(posedge iclk) begin
        if (!irstn) begin
            wptr <= 0;
            nwptr <= 1;
        end else begin
            if (iwren && !full) begin
                fifo[wptr] <= din;
                wptr <= nwptr;
                nwptr <= nwptr + 1'b1;
            end
        end
    end

    always @(posedge iclk) begin
        if (!irstn) begin
            rptr <= 0;
        end
        else begin
            if ((irden || (stcount == 2'b11)) && !empty) begin
                rdout <= fifo[rptr];
                rptr  <= rptr + 1'b1;
            end
        end
    end

    assign dout  = rdout;
    assign empty = wptr == rptr;
    assign full  = nwptr == rptr;

endmodule
