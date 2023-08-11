//plug pmod-led on PMOD2

module led (
    input CLK,
    output reg [7:0] LED
);

  reg [25:0] counter;
  wire lclk = counter[21];

  initial begin
    LED = 8'b11111110;
    counter = 26'b0;
  end

  always @(posedge CLK) begin
    counter <= counter + 1;
  end

  always @(posedge lclk) begin
    LED <= {LED[6:0], LED[7]};
  end


endmodule