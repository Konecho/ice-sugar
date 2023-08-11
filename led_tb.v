`timescale 1ns / 1ns
module led_tb ();
  reg CLK;
  wire [7:0] LED;
  led THELED (
      .CLK(CLK),
      .LED(LED)
  );
  always begin
    #10 CLK = 0;
    #10 CLK = 1;
  end
  initial begin
    $dumpfile("wave.vcd");
    $dumpvars;
  end
  initial #10000 $finish;
endmodule
