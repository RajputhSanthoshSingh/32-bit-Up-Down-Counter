' timescale 1ns/1ns

module counter (
  input wire clk, rst,
  input wire up, ctrl,// User-defined input: 1 for up, 0 for down
  output reg [31:0] counter
);

  always @(posedge clk or posedge rst) begin
    if (rst) begin
      counter <= 32'b0; // Reset the counter to 0 on a positive edge of the reset signal
    end
    else begin
      if (up == 1'b1) begin
		if(ctrl == 1'b1)
		begin
		counter <= counter;
		end
		else if (counter != 32'hFFFFFFFF) begin
          counter <= counter + 1; // Increment the counter if counting up and not at the maximum value
        end
        else begin
          counter <= 32'b0; // Wrap-around to 0 if counting up and reaching the maximum value
        end
      end
      else begin
        if(up == 1'b0)
	begin
	if(ctrl == 1'b1)
	begin
	counter <= counter;
	end
	else
	if (counter != 32'b0) begin
          counter <= counter - 1; // Decrement the counter if counting down and not at 0
        end
        else if (up == 1'b0) begin
          counter <= counter - 1;
        end
        else begin
          counter <= counter; // Wrap-around to maximum if counting down and reaching 0
        end
      end
    end
  end
end
endmodule


module up_down_counter_tb();

  reg clk, reset;
  wire [31:0] counter;
  reg up;

  counter uut (.clk(clk),.reset(reset),.counter(counter),.up(up));

  // Clock generation
  always #5 clk = ~clk; // Toggle the clock every 5 time units

  initial begin
    $monitor($time, " up = %b counter = %b", up, counter); // Display simulation time, up signal, and counter value
  end

  initial begin
    reset = 1; // Initialize reset to 1
    clk = 0;   // Initialize clock to 0
    #10 reset = 0; // Release reset after 10 time units
    #10 up=1;      // Set the up signal to 1 after 10 time units
    #50 up=0;      // Set the up signal to 0 after 50 time units
    #200 up = 1;   // Set the up signal to 1 after 200 time units

    //$stop; // Stop simulation after a certain time
  end

endmodule
