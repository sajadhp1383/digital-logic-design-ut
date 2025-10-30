`timescale 1ns/1ns
module NotTB();
	logic aa=0;
	wire ww;
	myNOT not1(aa,ww);
	initial begin
	#20 aa=1;
	#30 aa=0;
	#30 $stop;
	end
endmodule
