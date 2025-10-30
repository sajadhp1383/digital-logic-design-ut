`timescale 1ns/1ns 

module _2bit_adder_TB();
	reg [1:0]a=2'b00,b=2'b00;
    reg cin=0;
	wire [1:0]sum;
    wire cout;
    two_bit_adder adder(.a(a), .b(b), .cin(cin), .sum(sum), .cout(cout));
    initial begin
        #200 a[0] = 1;
        #200 a[1] = 1;
        #200 b[0] = 1;
        #200 b[1] = 1;
        #200 cin = 1;
        #400 $stop; 
    end
endmodule
