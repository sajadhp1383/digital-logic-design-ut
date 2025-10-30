`timescale 1ns/1ns 

module _1bit_adder_TB();
	reg a=0,b=0,c=0;
	wire sum,cout;
	fulladder adder(a,b,c,sum,cout);
	initial begin
	#200 a=1;
	#200 b=1;
	#200 c=1;
	#400 $stop;
	end
endmodule
