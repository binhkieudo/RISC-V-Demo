// See LICENSE for license details

`timescale 1ns/1ps

module GenericDigitalInIOCell(
    input pad,
    output i,
    input ie
);

    assign i = ie ? pad : 1'b0;

endmodule

module GenericDigitalOutIOCell(
    output pad,
    input o,
    input oe
);

    assign pad = oe ? o : 1'bz;

endmodule
