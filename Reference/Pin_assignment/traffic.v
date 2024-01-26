module traffic(clk,rst,HEX0,HEX1,z);
input clk,rst;
output reg [6:0] HEX0,HEX1;
output reg [2:0] z;
reg [3:0] count0,count1;
reg clk1;
reg [24:0] clkdiv;
reg [4:0] count;
parameter S0=2'b00;
parameter S1=2'b01;
parameter S2=2'b10;
parameter delay1=5'b01010;
parameter delay2=5'b10100;
parameter delay3=5'b11110; // delays
reg [1:0] state;
parameter x0=7'b1000000;
parameter x1=7'b1111001;
parameter x2=7'b0100100;
parameter x3=7'b0110000;
parameter x4=7'b0011001;
parameter x5=7'b0010010;
parameter x6=7'b0000010;
parameter x7=7'b1111000;
parameter x8=7'b0;
parameter x9=7'b0011000;

always @(posedge clk)
begin
if (clkdiv==25'b1011_0111_0001_1011_0000_0000_0)
begin
if(rst)
clk1<=1'b0;
else 
clk1=~clk1;
clkdiv<=25'b0;
end
else
clkdiv<=clkdiv+1'b1;
end

always @(posedge clk1)
begin
if(rst)
count0<=4'b0;
else if(count0<4'b1010)
count0<=count0+1'b1;
else
count0<=4'b0;
end

always@(count0)
begin
if(rst)
count1<=4'b0;
else if(count0==4'b1001)
count1<=count1+1'b1;
else if(count1==4'b0110)
count1<=4'b0;
end
always @(count0)
begin
if(count0==4'b0)
HEX0<=x0;
else if(count0==4'b0001)
HEX0<=x1;
else if(count0==4'b0010)
HEX0<=x2;
else if(count0==4'b0011)
HEX0<=x3;
else if(count0==4'b0100)
HEX0<=x4;
else if(count0==4'b0101)
HEX0<=x5;
else if(count0==4'b0110)
HEX0<=x6;
else if(count0==4'b0111)
HEX0<=x7;
else if(count0==4'b1000)
HEX0<=x8;
else if(count0==4'b1001)
HEX0<=x9;
end
always @(count1)
begin
if(count1==4'b0)
HEX1<=x0;
else if(count1==4'b0001)
HEX1<=x1;
else if(count1==4'b0010)
HEX1<=x2;
else if(count1==4'b0011)
HEX1<=x3;
else if(count1==4'b0100)
HEX1<=x4;
else if(count1==4'b0101)
HEX1<=x5;
else if(count1==4'b0110)
HEX1<=x6;
end
always @(posedge clk,posedge rst)
begin
if (rst)
begin
state<=S0;
count<=5'b0;
end
else
case(state)
S0:if(count < delay1)
begin
state<=S0;
count<=count+1'b1;
end
else
begin
state<=S1;
count<=5'b0;
end
S1:if(count<delay2)
begin
state<=S1;
count<=count+1'b1;
end
else
begin
state<= S2;
count<=5'b0;
end
S2:if(count<delay3)
begin
state<=S2;
count<=count+1'b1;
end
else
begin
state<=S0;
count<=5'b0;
end
endcase
end

always @(*)
begin
case(state)
S0:z=3'b001;
S1:z=3'b010;
S2:z=3'b100;
endcase
end
endmodule