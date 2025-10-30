`timescale 1ns/1ns

module Adder3(input a,b,c,output w1,w2);
	Odd3 odd(a,b,c,w1);
	Maj3 maj(a,b,c,w2);
endmodule
