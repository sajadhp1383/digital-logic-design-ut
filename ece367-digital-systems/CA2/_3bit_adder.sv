`timescale 1ns/1ns 

module _3bit_adder_TB();
	reg [2:0]a=2'b000,b=2'b000;
    reg cin=0;
	wire [2:0]sum;
    wire cout;
    three_bit_adder adder(.a(a), .b(b), .cin(cin), .sum(sum), .cout(cout));
    initial begin
        #200 a[0] = 1;
        #200 a[1] = 1;
        #200 a[2] = 1;
        #200 b[0] = 1;
        #200 b[1] = 1;
        #200 b[2] = 1;
        #200 cin = 1;
        #400 $stop; 
    end
endmodule