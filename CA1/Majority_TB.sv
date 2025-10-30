`timescale 1ns/1ns

module Majority_TB();
	logic a=0,b=1,c=0;
	wire w1,w2,w3;
	Maj1 majority1(a,b,c,w1);
	Maj2 majority2(a,b,c,w2);
	Maj3 majority3(a,b,c,w3);
	initial begin
	#50 a=1;
	#50 a=0;
	#50 b=0;
	#50 b=1;	
	#50 c=1;
	#50 c=0;
	#50 $stop;
	end
endmodule


