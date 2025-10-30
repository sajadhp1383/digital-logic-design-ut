`timescale 1ns/1ns

module tb_divider;
    reg [15:0] A, B;
    reg clk, rst, start;
    wire [15:0] R2, Q;
    wire err;
    wire ready;

    divider uut (A, B, clk, rst, start, R2, Q, err,ready);

    initial begin
        forever #100 clk = ~clk;
    end

    initial begin
        clk = 0;
        rst = 1;
        start = 0;
        A = 16'd0;
        B = 16'd0;
        #200 rst = 0;
        #200;   
        @(posedge clk) begin
            B = 251;
            A = -51;
            start = 1;
        end
        @(posedge clk) begin
            start = 0;
        end
        #10000;
        $stop;
    end
endmodule

