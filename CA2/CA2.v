`timescale 1ns/1ns

module MAJ(input  a,b,c,output w);
	assign #(35,36) w=((b&c) | (a&c) | (a&b));
endmodule

module ODD3(input a,b,c,output w);
	assign #(28,27) w= a^b^c;
endmodule


module fulladder(input a,b,cin,output sum,cout);
	ODD3 odd(a,b,cin,sum);
	MAJ maj(a,b,cin,cout);
endmodule

module two_bit_adder(input [1:0]a,b,input cin,output [1:0]sum,output cout);
	wire c1;
	fulladder F1(a[0],b[0],cin,sum[0],c1);
	fulladder F2(a[1],b[1],c1,sum[1],cout);
endmodule

module three_bit_adder(input [2:0]a,b,input cin, output [2:0]sum,output cout);
	wire c1;
	two_bit_adder T1(a[1:0],b[1:0],cin,sum[1:0],c1);
	fulladder F1(a[2],b[2],c1,sum[2],cout);
endmodule

module four_bit_adder(input [3:0]a,b,input cin, output [3:0]sum,output cout);
	wire c1;
	two_bit_adder T1(a[1:0],b[1:0],cin,sum[1:0],c1);
	two_bit_adder T2(a[3:2],b[3:2],c1,sum[3:2],cout);
endmodule

module five_bit_adder(input [4:0]a,b,input cin, output [4:0]sum,output cout);
	wire c1;
	three_bit_adder T1(a[2:0],b[2:0],cin,sum[2:0],c1);
	two_bit_adder T2(a[4:3],b[4:3],c1,sum[4:3],cout);	
endmodule

module _63input_counter(input [62:0]a,output[5:0] w);
	wire [31:0]_1bit_adder_output;
	wire [23:0]_2bit_adder_output;
	wire [15:0]_3bit_adder_output;
	wire [9:0]_4bit_adder_output;

	fulladder FA1(a[0],a[1],a[2],_1bit_adder_output[0],_1bit_adder_output[1]);
	fulladder FA2(a[3],a[4],a[5],_1bit_adder_output[2],_1bit_adder_output[3]);
	two_bit_adder Tw1(_1bit_adder_output[1:0],_1bit_adder_output[3:2],a[6],_2bit_adder_output[1:0],_2bit_adder_output[2]);

	fulladder FA3(a[7],a[8],a[9],_1bit_adder_output[4],_1bit_adder_output[5]);
	fulladder FA4(a[10],a[11],a[12],_1bit_adder_output[6],_1bit_adder_output[7]);
	two_bit_adder Tw2(_1bit_adder_output[5:4],_1bit_adder_output[7:6],a[13],_2bit_adder_output[4:3],_2bit_adder_output[5]);

	three_bit_adder Th1(_2bit_adder_output[2:0],_2bit_adder_output[5:3],a[14],_3bit_adder_output[2:0],_3bit_adder_output[3]);

	fulladder FA5(a[15],a[16],a[17],_1bit_adder_output[8],_1bit_adder_output[9]);
	fulladder FA6(a[18],a[19],a[20],_1bit_adder_output[10],_1bit_adder_output[11]);
	two_bit_adder Tw3(_1bit_adder_output[9:8],_1bit_adder_output[11:10],a[21],_2bit_adder_output[7:6],_2bit_adder_output[8]);

	fulladder FA7(a[22],a[23],a[24],_1bit_adder_output[12],_1bit_adder_output[13]);
	fulladder FA8(a[25],a[26],a[27],_1bit_adder_output[14],_1bit_adder_output[15]);
	two_bit_adder Tw4(_1bit_adder_output[13:12],_1bit_adder_output[15:14],a[28],_2bit_adder_output[10:9],_2bit_adder_output[11]);

	three_bit_adder Th2(_2bit_adder_output[8:6],_2bit_adder_output[11:9],a[29],_3bit_adder_output[6:4],_3bit_adder_output[7]);

	four_bit_adder Fo1(_3bit_adder_output[3:0],_3bit_adder_output[7:4],a[30],_4bit_adder_output[3:0],_4bit_adder_output[4]);


	fulladder FA9(a[31],a[32],a[33],_1bit_adder_output[16],_1bit_adder_output[17]);
	fulladder FA10(a[34],a[35],a[36],_1bit_adder_output[18],_1bit_adder_output[19]);
	two_bit_adder Tw5(_1bit_adder_output[17:16],_1bit_adder_output[19:18],a[37],_2bit_adder_output[13:12],_2bit_adder_output[14]);

	fulladder FA11(a[38],a[39],a[40],_1bit_adder_output[20],_1bit_adder_output[21]);
	fulladder FA12(a[41],a[42],a[43],_1bit_adder_output[22],_1bit_adder_output[23]);
	two_bit_adder Tw6(_1bit_adder_output[21:20],_1bit_adder_output[23:22],a[44],_2bit_adder_output[16:15],_2bit_adder_output[17]);

	three_bit_adder Th3(_2bit_adder_output[14:12],_2bit_adder_output[17:15],a[45],_3bit_adder_output[10:8],_3bit_adder_output[11]);

	fulladder FA13(a[46],a[47],a[48],_1bit_adder_output[24],_1bit_adder_output[25]);
	fulladder FA14(a[49],a[50],a[51],_1bit_adder_output[26],_1bit_adder_output[27]);
	two_bit_adder Tw7(_1bit_adder_output[25:24],_1bit_adder_output[27:26],a[52],_2bit_adder_output[19:18],_2bit_adder_output[20]);

	fulladder FA15(a[53],a[54],a[55],_1bit_adder_output[28],_1bit_adder_output[29]);
	fulladder FA16(a[56],a[57],a[58],_1bit_adder_output[30],_1bit_adder_output[31]);
	two_bit_adder Tw8(_1bit_adder_output[29:28],_1bit_adder_output[31:30],a[59],_2bit_adder_output[22:21],_2bit_adder_output[23]);

	three_bit_adder Th4(_2bit_adder_output[20:17],_2bit_adder_output[23:21],a[60],_3bit_adder_output[14:12],_3bit_adder_output[15]);

	four_bit_adder Fo2(_3bit_adder_output[11:8],_3bit_adder_output[15:12],a[61],_4bit_adder_output[8:5],_4bit_adder_output[9]);

	five_bit_adder Fi1(_4bit_adder_output[4:0],_4bit_adder_output[9:5],a[62],w[4:0],w[5]);

endmodule

