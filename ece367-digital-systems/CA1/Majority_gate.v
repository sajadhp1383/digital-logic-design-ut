`timescale 1ns/1ns

module Maj1(input a,b,c,output w);
	supply1 vdd;
	supply0 gnd;
	wire i,j,k,l,m,y;
	pmos #(4,7,9) T1(i,vdd,a),T2(i,vdd,c),T3(j,i,a),T4(j,i,b),T5(y,j,b),T6(y,j,c),T7(w,vdd,y);
	nmos #(3,5,7) T8(k,gnd,b),T9(y,k,a),T10(l,gnd,c),T11(y,l,b),T12(m,gnd,c),T13(y,m,a),T14(w,gnd,y);
endmodule

module Maj2(input a,b,c,output w);
	wire i,j,k,l,m;
	myNAND G1(a,b,i),G2(b,c,j),G3(c,a,k),G4(i,j,l),G5(m,k,w);
	myNOT G6(l,m);
endmodule

module Maj3(input  a,b,c,output w);
	assign #(34,23) w=((a&b) | (c&b) | (b&a));
endmodule