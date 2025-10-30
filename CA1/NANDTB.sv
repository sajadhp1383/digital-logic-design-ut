


`timescale 1ns/1ns

module NANDTB();
	logic aa=1,bb=1;
	wire w1,w2;
	myNAND nand1(aa,bb,w1);
	nand #(14,10) nand2(w2,aa,bb);
	initial begin
	#42 bb=0;
	#42 bb=1;
	#42 aa=0;
	#42 aa=1;
	#42 $stop;
	end
endmodule


