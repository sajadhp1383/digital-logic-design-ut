`timescale 1ns/1ns

module Odd3_TB();
	logic a=0,b=1,c=0;
	wire w;
	Odd3 odd(a,b,c,w);
	initial begin
	#200 a=1;
	#200 b=0;
	#200 c=1;
	#200 $stop;
	end
endmodule
	


