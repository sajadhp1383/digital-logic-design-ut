`timescale 1ns/1ns

module divider (input logic [15:0] A, B, input  clk, rst, start, output logic [15:0] R2, Q, output logic err,ready);
    logic [3:0] countOut;
    logic [15:0] subOut, Qout, Rout, Aout, absA, absB, R;
    logic LdA, siO2, siO1, si1, Qld, Rld, Qshift, Rshift, iz1, iz2, co, enC, izC;
    wire sb, si2, enMux;
    wire [15:0] Rpl, Qpl;
    logic [1:0] ps, ns;

    parameter [1:0] Idle = 2'b00, Get_ready = 2'b01, Load = 2'b10, Calculating = 2'b11;

    always @(posedge clk or posedge rst) begin
        if (rst) ps <= Idle;
        else ps <= ns;
    end

    assign absA = A[15] ? (~A+1) : A;
    assign absB = B[15] ? (~B+1) : B;


    assign Qpl = absB;
    assign sb = subOut[15];
    assign si2 = siO1;
    assign Rpl = subOut;
    assign enMux = sb;
    assign subOut = {R[14:0], Q[15]} - Aout;
    
    always @(co, sb, start, enMux, ns, ps) begin
        {LdA, Qld, Rld, Qshift, Rshift, iz1, iz2, enC, izC,ready} <= 10'b0;
        case (ps)
            Idle: begin
                ready <= 1'b1;
                ns <= (start) ? Get_ready : Idle;
            end
            Get_ready: begin
                ns <= (start) ? Get_ready : Load;
            end
            Load: begin
                LdA <= 1'b1;
                Qld <= 1'b1;
                iz2 <= 1'b1;
                iz1 <= 1'b1;
                
                ns <= Calculating;
            end
            Calculating: begin
                enC <= 1'b1;
                Qshift <= 1'b1;
                si1 <= enMux ? 1'b0 : 1'b1;
                Rshift <= sb ? 1'b1 : 1'b0;
                Rld <= (~sb) ? 1'b1 : 1'b0;
                ns <= (co) ? Idle : Calculating;
            end
            default: ns = Idle;
        endcase
    end

    assign co = &countOut;
    always @(posedge clk or posedge rst) begin
        if (rst) countOut <= 4'b0000;
        else if (izC) countOut <= 4'b0000;
        else if (enC) countOut <= countOut + 1;
        else countOut <= countOut;
    end

    always @(posedge clk , posedge rst ) begin
        if (rst) Aout <= 16'b0;
        else Aout <= (LdA) ?  absA : Aout;
    end    
    always@(posedge clk , posedge rst ) begin
        if (rst) Rout <= 16'b0;
        else Rout <= iz2 ? 16'b0 : Rld ? subOut : Rshift ? {Rout[14:0], Qout[15]} : R;
    end
    always@(posedge clk , posedge rst ) begin
        if (rst) Qout <= 16'b0;
        else Qout <= iz1 ? absB : Qshift ? {Q[14:0], enMux ? 1'b0 : 1'b1 } : Qout;
    end
    always@(posedge clk, posedge rst) begin
        if (rst) err <= 1'b0;
        else err <= (A == 16'b0);
    end
     
    assign Q = Qout;
    assign R = Rout;
    assign R2 = (A[15]) ? (~R + 1) : R;

endmodule
