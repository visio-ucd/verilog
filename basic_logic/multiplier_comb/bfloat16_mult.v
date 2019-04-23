module bfloat16_mult(clk, a, b, out, out_c, exp, a_e, b_e, neg_shift, man);
  input clk;
  input [15:0] a;
  input [15:0] b;
  output reg [15:0] out;
  reg [15:0] out_c;
  wire [15:0] man_mult_out;
  reg [15:0] man;
  reg [3:0] shift;
  reg [9:0] neg_shift;
  reg [9:0] a_e, b_e;
  reg [9:0] exp;
  reg [15:0] a_r, b_r;

  //PARAMETER DECLARATIONS
  parameter NAN = 15'b1111_1111_0000_001;
  parameter INF = 15'b1111_1111_0000_000;
  parameter ZERO = 15'b0000_0000_0000_000;

  //bfloat_man_mult m0(.a({2'b01, a_r[6:0]}), .b({2'b01, b_r[6:0]}), .out(man_mult_out));
  assign man_mult_out = {2'b01, a_r[6:0]} * {2'b01, b_r[6:0]};

  always @(man_mult_out) begin
    casez(man_mult_out)
      16'b1???????????????: shift = 4'd00;
      16'b01??????????????: shift = 4'd01;
      16'b001?????????????: shift = 4'd02;
      16'b0001????????????: shift = 4'd03;
      16'b00001???????????: shift = 4'd04;
      16'b000001??????????: shift = 4'd05;
      16'b0000001?????????: shift = 4'd06;
      16'b00000001????????: shift = 4'd07;
      16'b000000001???????: shift = 4'd08;
      16'b0000000001??????: shift = 4'd09;
      16'b00000000001?????: shift = 4'd10;
      16'b000000000001????: shift = 4'd11;
      16'b0000000000001???: shift = 4'd12;
      16'b00000000000001??: shift = 4'd13;
      16'b000000000000001?: shift = 4'd14;
      16'b0000000000000001: shift = 4'd15;
      default: shift = 4'd00;
    endcase
  end

  // assign a_e = {2'b00, a_r[14:7]} + 10'b1110000001; // -127
  // assign b_e = {2'b00, b_r[14:7]} + 10'b1110000001; // -127
  // assign out_c[15] = a_r[15] ^ b_r[15];
  // assign man = man_mult_out << shift;
  // assign out_c[6:0] = man[14:8];
  // assign neg_shift = ~({6'b000000, shift}) + 1'b1;
  // assign exp = a_e + b_e + 10'b0010000000 + neg_shift;
  // assign out_c[14:7] = exp[7:0];

always @ (*) begin
    a_e = {2'b00, a_r[14:7]} + 10'b1110000001; // -127
    b_e = {2'b00, b_r[14:7]} + 10'b1110000001; // -127
	out_c[15] =  a_r[15] ^ b_r[15];
    man = man_mult_out << shift;
	neg_shift = ~({6'b000000, shift}) + 1'b1;
    exp = a_e + b_e + 10'b0010000000 + neg_shift;
	
	//overflow
	if (exp[9:8] == 2'b01) 
	   out_c[14:0] = 15'b1111_1111_0000_000;
	//underflow
	else if (exp [9:8] == 2'b11)
		out_c[14:0] = 15'b0000_0000_0000_000;
	//result is inf
	else if (exp[9:0] == 10'b00_1111_1111)
		out_c[14:0] = 15'b1111_1111_0000_000;
	//normal
	else
		out_c[14:0] = {exp[7:0], man[14:8]};	

	//zero 
	if (a_r[14:0] == ZERO || b_r[14:0] == ZERO) begin
		out_c[14:0] = ZERO;
  end

	//input is inf 
	if(a_r[14:0] == INF || b_r[14:0]  == INF) begin
    if(a_r[14:0] == ZERO || b_r[14:0] == ZERO) begin
      //inf * zero = NaN
      out_c[14:0] = NAN;
    end
    else begin
      //inf * normal = inf
      out_c[14:0] = INF;
    end
  end

  //NaN
  if (a_r[14:7] == 8'b1111_1111 && a_r[6:0] != 7'b0000_000 ||
      b_r[14:7] == 8'b1111_1111 && b_r[6:0] != 7'b0000_000) begin
    out_c[14:0] = NAN;
  end
end

  always @(posedge clk) begin
    a_r <= a;
    b_r <= b;
    out <= out_c;
  end
endmodule
