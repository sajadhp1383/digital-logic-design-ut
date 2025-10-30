`timescale 1ns/1ns

module myNAND(input a,b,output w);
	supply1 vdd;
	supply0 gnd;
	wire j;
	pmos #(4,7,9) T1(w,vdd,a),T2(w,vdd,b);
	nmos #(3,5,7) T3(j,gnd,b),T4(w,j,a);
endmodule
