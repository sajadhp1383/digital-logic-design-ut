`timescale 1ns/1ns 

module _4bit_adder_TB();
	reg [3:0]a=2'b0000,b=2'b0000;
    reg cin=0;
	wire [3:0]sum;
    wire cout;
    four_bit_adder adder(.a(a), .b(b), .cin(cin), .sum(sum), .cout(cout));
    initial begin
        #300 a[0] = 1;
        #300 a[1] = 1;
        #300 a[2] = 1;
        #300 a[3] = 1;
        #300 b[0] = 1;
        #300 b[1] = 1;
        #300 b[2] = 1;
        #300 b[3] = 1;
        #300 cin = 1;
        #500 $stop; 
    end
endmodule