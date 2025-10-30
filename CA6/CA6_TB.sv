`timescale 1ns/1ns

module testbench;

  logic clk;
  logic rst;
  logic dataready;
  logic [7:0] Data_in;
  logic receiveData;

  logic [7:0] Data_out;
  logic OutBuffFull;
  logic error;
  logic readyToAccept;

  eightBusInterface uut (
      .clk(clk),
      .rst(rst),
      .dataReady(dataready),
      .receiveData(receiveData),
      .eightBitInp(Data_in),
      .readyToAccept(readyToAccept),
      .OutBuffFull(OutBuffFull),
      .error(error),
      .eightBitOut(Data_out)
  );

  always #5 clk = ~clk;

  initial begin
      clk = 0;
      rst = 0;
      dataready = 0;
      receiveData = 0;

      #6; rst = 1; #6; rst = 0;
      
    
      #20;
      dataready = 1;
      Data_in = 8'd52;
      #20;
      dataready = 0;

      #20;
      dataready = 1;
      Data_in = 8'b0;
      #10;
      dataready = 0;

      #20;
      dataready = 1;
      Data_in = 8'd5;
      #10;
      dataready = 0;

      #20;
      dataready = 1;
      Data_in = 8'd0;
      #10;
      dataready = 0;

      #200;

      #200;
      #20 receiveData = 1;
      #10 receiveData = 0;
      #20 receiveData = 1;
      #10 receiveData = 0;
      #20 receiveData = 1;
      #10 receiveData = 0;
      #20 receiveData = 1;
      #10 receiveData = 0;
      #200;
      $stop;
  end
endmodule

