`timescale 1ns/1ns 

module _5bit_adder_TB();
	reg [4:0]a=2'b00000,b=2'b00000;
    reg cin=0;
	wire [4:0]sum;
    wire cout;
    five_bit_adder adder(.a(a), .b(b), .cin(cin), .sum(sum), .cout(cout));
    initial begin
        #400 a[0] = 1;
        #400 a[1] = 1;
        #400 a[2] = 1;
        #400 a[3] = 1;
        #400 a[4] = 1;
        #400 b[0] = 1;
        #400 b[1] = 1;
        #400 b[2] = 1;
        #400 b[3] = 1;
        #400 b[4] = 1;
        #400 cin = 1;
        #500 $stop; 
    end
endmodule