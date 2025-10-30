`timescale 1ns/1ns
module Odd3(input a,b,c,output w);
	assign #65 w= a^b^c;
endmodule
