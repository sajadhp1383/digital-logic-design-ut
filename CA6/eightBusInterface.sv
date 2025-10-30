`timescale 1ns/1ns

module inputWrapper(input logic dataReady, clk, rst, readyForInput,
                    input logic [7:0] eightBitInp,
                    output logic [15:0] A, B,
                    output logic readyToAccept, start);

    parameter [1:0] Idle = 2'b00, Init = 2'b01, ReceivingData = 2'b10, WaitForNext = 2'b11;

    logic initC, inc, cco, load0, load1, load2, load3, loadEn;
    logic [1:0] ns, ps;
    logic [1:0] counterOutput;

    always @ (posedge clk, posedge rst) begin
        if (rst) ps <= Idle;
        else ps <= ns;
    end

    assign load0 = (loadEn == 1 & counterOutput == 2'b00) ? 1 : 0;
    assign load1 = (loadEn == 1 & counterOutput == 2'b01) ? 1 : 0;
    assign load2 = (loadEn == 1 & counterOutput == 2'b10) ? 1 : 0;
    assign load3 = (loadEn == 1 & counterOutput == 2'b11) ? 1 : 0;

    always @(cco, dataReady, readyForInput, ps) begin
        {initC, inc, loadEn, start, readyToAccept} <= 5'b0;
        case (ps)
            Idle : ns <= dataReady ? Init : Idle;
            Init : begin
                loadEn <= 1'b1;
                initC <= 1'b1;
                ns <= ReceivingData;
            end
            ReceivingData : begin
                readyToAccept <= 1'b1;
                loadEn <= 1'b1;
                ns <= dataReady ? ReceivingData : WaitForNext;
            end
            WaitForNext : begin
                start <= (cco & readyForInput) ? 1 : 0;
                inc <= (~cco & dataReady) ? 1 : 0;
                ns <= (~dataReady & ~cco) ? WaitForNext : (dataReady & ~cco) ? ReceivingData : Idle;
            end
            default: ns <= Idle;
        endcase
    end

    assign cco = &counterOutput;
    always @ (posedge clk, posedge rst) begin
        if (rst) counterOutput <= 2'b00;
        else if(initC) counterOutput <= 2'b00;
        else if(inc) counterOutput <= counterOutput + 1;
        else counterOutput <= counterOutput;
    end

    always @ (posedge clk, posedge rst) begin
        if (rst) A[7:0] <= 8'b0;
        else if(load0) A[7:0] <= eightBitInp;
        else A[7:0] <= A[7:0];
    end

    always @ (posedge clk, posedge rst) begin
        if (rst) A[15:8] <= 8'b0;
        else if(load1) A[15:8] <= eightBitInp;
        else A[15:8] <= A[15:8];
    end

    always @ (posedge clk, posedge rst) begin
        if (rst) B[7:0] <= 8'b0;
        else if(load2) B[7:0] <= eightBitInp;
        else B[7:0] <= B[7:0];
    end

    always @ (posedge clk, posedge rst) begin
        if (rst) B[15:8] <= 8'b0;
        else if(load3) B[15:8] <= eightBitInp;
        else B[15:8] <= B[15:8];
    end
endmodule


module outputWrapper(input logic clk, rst, ready, receiveData,
                    input logic [15:0] Q, R,
                    output logic readyForInput, OutBuffFull,
                    output logic [7:0] eightBitOut);

    logic [1:0] ns, ps, counterOutput;
    logic initC, inc, cco, load;
    logic [15:0] Q_reg, R_reg;

    parameter [1:0] Idle = 2'b00, Loading = 2'b01, ReceivingData = 2'b10, WaitForNext = 2'b11;

    always @ (posedge clk, posedge rst) begin
        if(rst) ps <= Idle;
        else ps <= ns;
    end


    always @(ready, ps, cco, receiveData) begin
        {inc, initC, readyForInput, load, OutBuffFull} <= 5'b0;

        case (ps)
            Idle :  begin
                readyForInput <= 1'b1;
                ns <= ready ? Loading : Idle;
            end
            Loading : begin
                load <= 1'b1;
                initC <= 1'b1;
                ns <= ReceivingData;
            end
            ReceivingData : begin
                OutBuffFull <= 1'b1;
                ns <= receiveData ? WaitForNext : ReceivingData;
            end
            WaitForNext : begin
                inc <= (~cco & ~receiveData) ? 1'b1 : 1'b0;
                ns <= cco ? Idle : (~cco & ~receiveData) ? ReceivingData : WaitForNext;
            end
        default : ns <= Idle;
    endcase
    end

    assign cco = &counterOutput;
    always @ (posedge clk, posedge rst) begin
        if (rst) counterOutput <= 2'b0;
        else if(initC) counterOutput <= 2'b0;
        else if(inc) counterOutput <= counterOutput + 1;
        else counterOutput <= counterOutput;
    end

    always @(posedge clk, posedge rst) begin
        if (rst) begin
            Q_reg <= 16'b0;
            R_reg <= 16'b0;
        end
        else if (load) begin
            Q_reg <= Q;
            R_reg <= R;
        end
    end

    assign eightBitOut = (counterOutput == 2'b00) ? Q_reg[7:0] : (counterOutput == 2'b01) ? Q_reg[15:8] :(counterOutput == 2'b10) ? R_reg[7:0] : (counterOutput == 2'b11) ? R_reg[15:8] : 8'bz;


endmodule


module divider (input logic [15:0] A, B, input  clk, rst, start, output logic [15:0] R2, Q, output logic ready, err);
    logic [3:0] countOut;
    logic [15:0] subOut, out1, out2, rA, absA, absB, R;
    logic LdA, siO2, siO1, si1, load1, load2, Lsh1, Lsh2, iz1, iz2, co, enC, izC;
    wire sb, si2, enMux;
    wire [15:0] pl2, pl1;
    logic [1:0] ps, ns;

    parameter [1:0] Idle = 2'b00, Starting = 2'b01, Load = 2'b10, Process = 2'b11;

    always @(posedge clk or posedge rst) begin
        if (rst) ps <= Idle;
        else ps <= ns;
    end

    assign absA = A[15] ? (~A+1) : A;
    assign absB = B[15] ? (~B+1) : B;


    assign pl1 = absB;
    assign sb = subOut[15];
    assign si2 = siO1;
    assign pl2 = subOut;
    assign enMux = sb;
    assign subOut = {R[14:0], Q[15]} - rA;
    
    always @(co, sb, start, enMux, ns, ps) begin
        {LdA, load1, load2, Lsh1, Lsh2, iz1, iz2, enC, izC, ready} <= 10'b0;
        case (ps)
            Idle: begin
                ns <= (start) ? Starting : Idle;
            end
            Starting: begin
                ns <= (start) ? Starting : Load;
            end
            Load: begin
                LdA <= 1'b1;
                load1 <= 1'b1;
                iz2 <= 1'b1;
                iz1 <= 1'b1;
                ns <= Process;
            end
            Process: begin
                enC <= 1'b1;
                Lsh1 <= 1'b1;
                si1 <= enMux ? 1'b0 : 1'b1;
                Lsh2 <= sb ? 1'b1 : 1'b0;
                load2 <= (~sb) ? 1'b1 : 1'b0;
                ns <= (co & ~err) ? Idle : Process;
                ready <= (co & ~err) ? 1 : 0;
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
        if (rst) rA <= 16'b0;
        else rA <= (LdA) ?  absA : rA;
    end    
    always@(posedge clk , posedge rst ) begin
        if (rst) out2 <= 16'b0;
        else out2 <= iz2 ? 16'b0 : load2 ? subOut : Lsh2 ? {out2[14:0], out1[15]} : R;
    end
    always@(posedge clk , posedge rst ) begin
        if (rst) out1 <= 16'b0;
        else out1 <= iz1 ? absB : Lsh1 ? {Q[14:0], enMux ? 1'b0 : 1'b1 } : out1;
    end
    always@(posedge clk, posedge rst) begin
        if (rst) err <= 1'b0;
        else err <= (A == 16'b0) ? 1'b1 : 1'b0;
    end
     
    assign Q = out1;
    assign R = out2;
    assign R2 = (A[15]) ? (~R + 1) : R;

endmodule


module eightBusInterface(input logic clk, rst, dataReady, receiveData,
                        input logic [7:0] eightBitInp,
                        output logic readyToAccept, OutBuffFull, error,
                        output logic [7:0]eightBitOut);

    logic ready, start, readyForInput;
    logic [15:0] A, B, Q, R;

    inputWrapper myInputWrapper(dataReady, clk, rst, readyForInput, eightBitInp, A, B, readyToAccept, start);
    divider myDivider(B, A, clk, rst, start, R, Q, ready, error);
    outputWrapper myOutputWrapper(clk, rst, ready, receiveData, Q, R, readyForInput, OutBuffFull, eightBitOut);

endmodule