`include "./adder_comb/bfloat16_adder.v"
`include "./multiplier_comb/bfloat16_mult.v"

module dotprod_comb(clk, horz, vert, out);

/*
===========================================================
I/O
===========================================================
*/

//CAUTION: this should be 2^x for x be natural number
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

// connect wires to multiplier
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

/* Visualization, indexing from left to right, top to bottom

adder_tree_regs

 -
| |\
| | \  adder_tree_Wires
|_|  \
      \
       \
			( + ) ------> adder_output_wires
		 /
      /
 -   /
| | /
| |/
|_|

*/

// there are n - 1 adder, with 2 regs attached at the output
// each reg is 16 bits wide
reg  [0 : 2 * (vec_length - 1) * 16 - 1] adder_tree_regs;

// each wire attach to 1 adder_tree_reg
wire [0 : 2 * (vec_length - 1) * 16 - 1] adder_tree_wires;

// each adder has 16 bit bus output
wire [0 :     (vec_length - 1) * 16 - 1] adder_output_wires;

// connect wires to adder
genvar j;
generate

	for (j=0; j < vec_length - 1; j=j+1) begin : ADDLayer
		bfloat16_adder bfloat16_adder_inst(
			.clk(clk),
			.a(adder_tree_wires[j*32 : j*32 + 15]),
			.b(adder_tree_wires[j*32 + 16 : j*32 + 31]),
			.out(adder_output_wires[j*16 : (j+1) * 16 - 1])
		);
	end

endgenerate

/*
===========================================================
PIPELINE
===========================================================
*/

// attach mult registers to multiplier module
assign horz_1 = horz_r;
assign vert_1 = vert_r;

// attach adder_tree_reg to adder
assign adder_tree_wires = adder_tree_regs;

// attach output adder_tree_wires to next layer adder_tree_regs
genvar k;
generate
	for (k=0; k< vec_length - 2; k=k+1) begin : TreeConnection
		always @(posedge clk) begin
				adder_tree_regs[bit_length + k*16 :  bit_length + (k+1) * 16 - 1] <= adder_output_wires[k*16 : (k+1) * 16 - 1];
		end
	end
endgenerate

always @(posedge clk) begin

	// transfer input to mult registers
	horz_r <= horz;
	vert_r <= vert;

	// attach first layer of adder tree register to mult output
	adder_tree_regs[0:bit_length - 1] <= mult_out;

	// attach adder tree output to module output
	out <= adder_output_wires[ (vec_length - 2) * 16 : (vec_length - 1) * 16 - 1];

end

endmodule
