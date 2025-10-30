`timescale 1ns/1ns

`timescale 1ns/1ns

module TBClockedSRLatch();
    logic set = 1, reset = 1, clk = 0;
    ClockedSRLatch latch_instance(reset, set, clk, q, y);
    always begin
        clk = ~clk;
        #10;
    end
    initial begin
        #100
        #50 set = 0;
        #100
        #50 set = 1;
        #100
        #50 set = 0;
        #100
        #50 set = 1;
        #100
        #50 reset = 0;
        #100
        #50 reset = 1;
        #100
        #50 set = 0;
        #100
        #50 set = 1;
        #100
        #50 set = 0;
        #100
        #50 set = 1;
        #100
        #50 reset = 0;
        #100
        #50 reset = 1;
        #100 $stop;
    end
endmodule

module TBClockedDLatch();
    logic data = 1;
    logic Q = 0, clk = 0, y = 1;
    ClockedDLatch latch_instance(data, clk, Q, y);
    always begin
        clk = ~clk;
        #10;
    end
    initial begin
        #50
        #50 data = 0;
        #100
        #50 data = 1;
        #100
        #50 data = 0;
        #100
        #50 data = 0;
        #100
        #50 data = 1;
        #100
        #50 data = 0;
        #100
        #50 data = 1;
        #100 $stop;
    end
endmodule


module TBEightBitRegister();
    logic clk = 1, reset = 0;
    logic [7:0] data, Q;
    EightBitRegister reg_instance(data, reset, clk, Q);
    always begin
        clk = ~clk;
        #10;
    end
    initial begin
        #100
        #50 data = 8'b00000000;
        #100
        #50 data = 8'b00000001;
        #100
        #50 data = 8'b00000101;
        #100
        #50 reset = 1;
        #100
        #50 data = 8'b00100101;
        #100
        #50 data = 8'b00110101;
        #100
        #100
        #50 data = 8'b00110100;
        #100 $stop;
    end
endmodule

module TBEightBitAdder();
    logic carry_out;
    logic [7:0] A, B, sum;
    EightBitAdder adder_instance(A, B, sum, carry_out);
    initial begin
        #100
        #50 A = 8'b10000001;
        #100
        #50 B = 8'b00000001;
        #200
        #50 A = 8'b00000010;
        #200
        #50 B = 8'b00100001;
        #100 $stop;
    end
endmodule

module TBSequenceAdder();
    logic reset = 0, clk = 0;
    logic [7:0] A, sum;
    SequenceAdder adder_instance(A, reset, clk, sum);
    always begin
        clk = ~clk;
        #200;
    end
    initial begin
        reset = 1;
        A = 8'b00000000;
        #100
        reset = 0;
        #100
        #100
        #50 A = 8'b00000001;
        #200
        #200
        #50 A = 8'b00000011;
        #200
        #50 A = 8'b00110011;
        #200
        #50 reset = 1;
        #200
        #50 A = 8'b11111111;
        #100 $stop;
    end
endmodule

module TBDFlipFlop();
    logic data = 0;
    logic Q = 0, clk = 1, reset = 0;
    DFF dff_instance(data, clk, reset, Q);
    always begin
        clk = ~clk;
        #10;
    end
    initial begin
        #50
        #50 data = 1;
        #100
        #50 data = 0;
        #100
        #50 data = 1;
        #100
        #50 data = 0;
        #100
        #50 reset = 1;
        #100
        #50 data = 1;
        #100
        #50 data = 0;
        #100
        #50 reset = 0;
        #100
        #50 data = 1;
        #100
        #50 data = 0;
        #100 $stop;
    end
endmodule

module TBDFFSequenceAdder();
    logic reset = 0, clk = 0;
    logic [7:0] data_in, result;
    DFFSequenceAdder adder_instance(data_in, reset, clk, result);
    always begin
        clk = ~clk;
        #200;
    end
    initial begin
        reset = 1;
        data_in = 8'b00000000;
        #100
        reset = 0;
        #100
        #100
        #50 data_in = 8'b00000001;
        #200
        #200
        #50 data_in = 8'b00000011;
        #200
        #50 data_in = 8'b00110011;
        #200
        #50 reset = 1;
        #200
        #50 data_in = 8'b11111111;
        #100 $stop;
    end
endmodule
