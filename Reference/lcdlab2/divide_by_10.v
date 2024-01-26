module divide_by_10(Q,CLK,RST);
input CLK, RST;
output Q;
reg Q;
reg [2:0] count;
always @ (posedge CLK or negedge RST)
	begin
		if (~RST)
			begin
				Q <= 1'b0;
				count <= 3'b000;
			end
		else if (count < 4)
			begin 
			 	count <= count+1'b1;
			end
		else 
			begin
				count <= 3'b000;
				Q <= ~Q;
			end
	end
endmodule
