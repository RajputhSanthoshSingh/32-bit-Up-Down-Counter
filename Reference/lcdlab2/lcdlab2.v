module lcdlab2(
  input CLOCK_50,	//	50 MHz clock
  input [3:0] KEY,      //	Pushbutton[3:0]
  input [17:0] SW,	//	Toggle Switch[17:0]
  output [6:0]	HEX0,HEX1,HEX2,HEX3,HEX4,HEX5,HEX6,HEX7,  // Seven Segment Digits
  output [8:0] LEDG,  //	LED Green
  output [17:0] LEDR,  //	LED Red
  inout [35:0] GPIO_0,GPIO_1,	//	GPIO Connections
//	LCD Module 16X2
  output LCD_ON,	// LCD Power ON/OFF
  output LCD_BLON,	// LCD Back Light ON/OFF
  output LCD_RW,	// LCD Read/Write Select, 0 = Write, 1 = Read
  output LCD_EN,	// LCD Enable
  output LCD_RS,	// LCD Command/Data Select, 0 = Command, 1 = Data
  inout [7:0] LCD_DATA	// LCD Data bus 8 bits
);

//	All inout port turn to tri-state
assign	GPIO_0		=	36'hzzzzzzzzz;
assign	GPIO_1		=	36'hzzzzzzzzz;


// reset delay gives some time for peripherals to initialize
wire DLY_RST;
Reset_Delay r0(	.iCLK(CLOCK_50),.oRESET(DLY_RST) );

// Send switches to red leds 
assign LEDR = SW;
assign LEDG[8:0] = 9'h000;

// blank unused 7-segment digits
assign HEX0 = 7'b111_1111;
assign HEX1 = 7'b111_1111;
assign HEX2 = 7'b111_1111;
assign HEX3 = 7'b111_1111;
assign HEX4 = 7'b111_1111;
assign HEX5 = 7'b111_1111;
assign HEX6 = 7'b111_1111;
assign HEX7 = 7'b111_1111;

// Setup clock divider
wire [6:0] myclock;
wire RST;
assign RST = KEY[0];
clock_divider cdiv(CLOCK_50,RST,myclock);

// state variable

reg timer_state;

// set up counters
wire [3:0] digit3, digit2, digit1, digit0;
wire [3:0] ovr;

wire clock, reset, pulse;
assign clock = (timer_state? myclock[0]: 1'b0);

assign reset = (~pulse & RST);

decimal_counter count0(digit0,ovr[0],clock,reset);
decimal_counter count1(digit1,ovr[1],ovr[0],reset);
decimal_counter count2(digit2,ovr[2],ovr[1],reset);
decimal_counter count3(digit3,ovr[3],ovr[2],reset);

// use one-pulse to trigger reset

oneshot pulser1(
.pulse_out(pulse),
.trigger_in(timer_state),
.clk(CLOCK_50)
);

wire lcd_start;
oneshot pulser2(
.pulse_out(lcd_start),
.trigger_in(myclock[0]),
.clk(CLOCK_50)
);

always @ (negedge KEY[3] or negedge RST)
begin
	if (!RST) timer_state <= 1'b0;
	else timer_state <= ~timer_state;
end


//	Internal Wires/Registers
reg	[5:0]	LUT_INDEX;
reg	[8:0]	LUT_DATA;
reg	[5:0]	mLCD_ST;
reg	[17:0]	mDLY;
reg		mLCD_Start;
reg	[7:0]	mLCD_DATA;
reg		mLCD_RS;
wire		mLCD_Done;

parameter LINE1 = 5;
parameter LUT_SIZE = LINE1+5;

always
begin
	case(LUT_INDEX)
	0:	LUT_DATA	<=	9'h038;
	1:	LUT_DATA	<=	9'h00C;
	2:	LUT_DATA	<=	9'h001;
	3:	LUT_DATA	<=	9'h006;
	4:	LUT_DATA	<=	9'h080;
	//	Line 1
	LINE1+0:	LUT_DATA	<=	9'h120;	// blanks	
	LINE1+1:	LUT_DATA	<=	9'h120;
	LINE1+2:	LUT_DATA	<=	{5'h13,digit3};
	LINE1+3:	LUT_DATA	<=	{5'h13,digit2};
	LINE1+4:	LUT_DATA	<=	{5'h13,digit1};
	LINE1+5:	LUT_DATA	<=	{5'h13,digit0};
	default:		
		LUT_DATA	<=	9'dx ;
	endcase
end

// turn LCD ON
assign	LCD_ON		=	1'b1;
assign	LCD_BLON	=	1'b1;


always@(posedge CLOCK_50 or negedge DLY_RST or posedge lcd_start)
begin
	if(!DLY_RST || lcd_start)
	begin
		LUT_INDEX	<=	0;
		mLCD_ST		<=	0;
		mDLY		<=	0;
		mLCD_Start	<=	0;
		mLCD_DATA	<=	0;
		mLCD_RS		<=	0;
	end
	else
		begin
		case(mLCD_ST)
		0:	begin
				mLCD_DATA	<=	LUT_DATA[7:0];
				mLCD_RS		<=	LUT_DATA[8];
				mLCD_Start	<=	1;
				mLCD_ST		<=	1;
			end
		1:	begin
				if(mLCD_Done)
				begin
					mLCD_Start	<=	0;
					mLCD_ST		<=	2;					
				end
			end
		2:	begin
				if(mDLY<18'h3FFFE)
				mDLY	<=	mDLY + 1'b1;
				else
				begin
					mDLY	<=	0;
					mLCD_ST	<=	3;
				end
			end
		3:	begin				
				if (LUT_INDEX<LUT_SIZE) begin
					mLCD_ST <= 0;
					LUT_INDEX <= LUT_INDEX + 1'b1;
				end
			end
		endcase
	end
end


LCD_Controller u0(
//    Host Side
.iDATA(mLCD_DATA),
.iRS(mLCD_RS),
.iStart(mLCD_Start),
.oDone(mLCD_Done),
.iCLK(CLOCK_50),
.iRST_N(DLY_RST),
//    LCD Interface
.LCD_DATA(LCD_DATA),
.LCD_RW(LCD_RW),
.LCD_EN(LCD_EN),
.LCD_RS(LCD_RS)    );
endmodule