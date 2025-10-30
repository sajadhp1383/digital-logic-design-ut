`timescale 1ns/1ns

module _63input_counter_TB();

    reg [62:0] a;
    wire [5:0] w;

    _63input_counter uut (
        .a(a),
        .w(w)
    );

    initial begin

        // Test case 1: All inputs are 0
        a = 63'b0;
        #1000;

        // Test case 2: All inputs are 1
        a = 63'b1_1111_1111_1111_1111_1111_1111_1111_1111_1111_1111_1111_1111_1111_1111_1111_1111_1111;
        #1000;

        // Test case 3: Half inputs are 1
        a = 63'b0_1111_1111_1111_1111_1111_1111_1111_1111_0000_0000_0000_0000_0000_0000_0000_0000;
        #1000;

        // Test case 4: Random pattern
        a = 63'b1_0101_0101_0101_0101_0101_0101_0101_0101_0101_0101_0101_0101_0101_0101_0101;
        #1000;

        // Test case 5: Another random pattern
        a = 63'b1_0011_0110_1001_1110_1101_0111_1010_1111_0000_1100_1010_0111_1000_0110_1101;
        #1000;

        $stop;
    end

endmodule
