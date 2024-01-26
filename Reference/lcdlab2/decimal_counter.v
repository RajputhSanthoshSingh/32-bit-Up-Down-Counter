module decimal_counter(A,OVERFLOW,CLK,RST);
input CLK, RST;
output OVERFLOW;
output [3:0] A;
reg OVERFLOW;
reg [3:0] A;
always @ (posedge CLK or negedge RST)
if (~RST) begin
	OVERFLOW <= 1'b0;
	A <= 4'b0000;
end
else if (A<9) begin
	A <= A + 1'b1;
	OVERFLOW <= 1'b0;
end
else begin
	A <= 4'b0000;
	OVERFLOW <= 1'b1;
end
endmodule
