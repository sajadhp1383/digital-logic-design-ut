`timescale 1ns/1ns

module harmonic_sum_TB();
    logic [3:0] n = 4'b0;
    logic clk = 0, reset = 0;
    logic [18:0] data;

    harmonic_sum harmonic (.clk(clk), .reset(reset), .n(n), .sum(data));

    // Clock generation
    always begin
        #5 clk = ~clk; // 10ns clock period (100MHz clock)
    end

    // Testbench procedure
    initial begin
        // Initial conditions
        reset = 1;
        #20; // Wait for 20ns
        reset = 0;
        #30;

        // Test cases
        n = 4'b0001;
        #100; // Wait for 40ns
        n = 4'b0010;
        #100;
        n = 4'b0011;
        #100;
        n = 4'b0100;
        #100;

        // Finish simulation
        $stop;
    end
endmodule
