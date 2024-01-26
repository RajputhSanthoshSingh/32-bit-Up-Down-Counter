module clock_divider(CLK,RST,clock);
input CLK,RST;
output [6:0] clock;
wire clk_1Mhz,clk_100Khz,clk_10Khz,clk_1Khz,clk_100hz,clk_10hz,clk_1hz;

assign clock = {clk_1Mhz,clk_100Khz,clk_10Khz,clk_1Khz,clk_100hz,clk_10hz,clk_1hz};

divide_by_50 d6(clk_1Mhz,CLK,RST);
divide_by_10 d5(clk_100Khz,clk_1Mhz,RST);
divide_by_10 d4(clk_10Khz,clk_100Khz,RST);
divide_by_10 d3(clk_1Khz,clk_10Khz,RST);
divide_by_10 d2(clk_100hz,clk_1Khz,RST);
divide_by_10 d1(clk_10hz,clk_100hz,RST);
divide_by_10 d0(clk_1hz,clk_10hz,RST);
endmodule
