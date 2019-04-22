`include "./adder_comb/bfloat16_adder.v"
`include "./multiplier_comb/bfloat16_mult.v"

module dotprod(clk, horz, vert, out, mult_out_r);

/* 
===========================================================
			   I/O
===========================================================
*/

parameter vec_length = 10;
parameter bit_length = vec_length * 16;

input clk;
input wire [0:bit_length - 1] horz;
input wire [0:bit_length - 1] vert;
output reg [0:15] out;

/* 
===========================================================
			MULT LAYER
===========================================================
*/

reg  [0:bit_length - 1] horz_r;
reg  [0:bit_length - 1] vert_r;
wire [0:bit_length - 1] horz_1;
wire [0:bit_length - 1] vert_1;

wire [0:bit_length - 1] mult_out;
output reg  [0:bit_length - 1] mult_out_r; //temp output for debug

genvar i;
generate
	
	for (i=0; i < vec_length; i=i+1) begin : MULTLayer
		bfloat16_mult bfloat16_mult_inst(
			.clk(clk),
			.a(horz_1[i*16 : (i+1) * 16 - 1]),
			.b(vert_1[i*16 : (i+1) * 16 - 1]),
			.out(mult_out[i*16 : (i+1) * 16 - 1])
		);
	end
	
endgenerate

/* 
===========================================================
 	         	ADD LAYER
===========================================================
*/

//wire [0 : (4*(vec_length - 1)) * 16 - 1] adder_tree_wires;
//reg  [0 : (vec_length - 1) * 16 -1     ] adder_tree


/* 
===========================================================
			PIPELINE
===========================================================
*/

assign horz_1 = horz_r;
assign vert_1 = vert_r;

always @(posedge clk) begin

horz_r <= horz;
vert_r <= vert;

mult_out_r <= mult_out;


end

endmodule


