`timescale 1ns/1ns

`timescale 1ns/1ns

module ClockedSRLatch(input reset, input set, input clk, output Q, output y);
    wire set_and_clk, reset_and_clk;
    or #7 Or1(reset_and_clk, reset, clk);
    or #7 Or2(set_and_clk, set, clk);
    nand #7 Nand1(Q, set_and_clk, y);
    nand #7 Nand2(y, reset_and_clk, Q);
endmodule



module ClockedDLatch(input data, input clk, output Q, output y);
    wire not_data, nand_s, nand_r;
    not #7 not1(not_data, data);
    nand #7 nand1(nand_r, not_data, clk);
    nand #7 nand2(nand_s, data, clk);
    nand #7 nand3(Q, nand_s, y);
    nand #7 nand4(y, nand_r, Q);
endmodule


module ClockedDLatchWithRes(input data, input reset, input clk, output Q, output y);
    wire not_data, nor_data_reset;
    not #7 not1(not_data, data);
    nor #7 nor1(nor_data_reset, reset, not_data);
    ClockedDLatch latch_instance(nor_data_reset, clk, Q, y);
endmodule

module EightBitRegister(input [7:0] data, input reset, input clk, output [7:0] Q);
    genvar i;
    generate
        for (i = 0; i < 8; i = i + 1) begin
            ClockedDLatchWithRes latch(data[i], reset, clk, Q[i], );
        end
    endgenerate
endmodule


module EightBitAdder(input [7:0] A, input [7:0] B, output [7:0] sum, output carry_out);
    assign #(34, 37) {carry_out, sum} = A + B;
endmodule


module SequenceAdder(input [7:0] A, input reset, input clk, output [7:0] sum);
    wire carry_out;
    wire [7:0] intermediate_sum;
    EightBitAdder adder(A, sum, intermediate_sum, carry_out);
    EightBitRegister reg_instance(intermediate_sum, reset, clk, sum);
endmodule



module DFFEightBitRegister(input [7:0] data, input reset, input clk, output [7:0] Q);
    genvar i;
    generate
        for (i = 0; i < 8; i = i + 1) begin
            DFF dff_instance(data[i], reset, clk, Q[i]);
        end
    endgenerate
endmodule

module DFFSequenceAdder(input [7:0] A, input reset, input clk, output [7:0] sum);
    wire carry_out;
    wire [7:0] intermediate_sum;
    EightBitAdder adder(A, sum, intermediate_sum, carry_out);
    DFFEightBitRegister reg_instance(intermediate_sum, reset, clk, sum);
endmodule




