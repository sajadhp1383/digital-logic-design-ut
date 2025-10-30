`timescale 1ns/1ns 

module AdderTB();
	logic a=0,b=0,c=0;
	wire w1,w2;
	Adder3 adder(a,b,c,w1,w2);
	initial begin
	#200 a=1;
	#200 b=1;
	#200 c=1;
	#400 $stop;
	end
endmodule
