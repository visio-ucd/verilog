`include "../dotprod_comb/dotprod_comb.v"

module fullyconnected(clk, matrix, in_vector, out_vector);

/*
===========================================================
I/O
===========================================================
*/

/* Visualization

     n             1       1
 -       -         -       -
|         |       | |     | |
|         | m  o  | | n = | | m
|         |       | |     | |
 -       -         _       -

*/

parameter m = 4; 
parameter n = 2;
parameter n_leftover = n % 2;
parameter m_leftover = m % 2;
parameter num_dotprod = 2;

input clk;
input wire [0 : m * n * 16 - 1] matrix;
input wire [0 : n * 16 - 1    ] in_vector;
output reg [0 : m * 16 - 1    ] out_vector;

/*
===========================================================
Instantiate dotprod modules
===========================================================
*/
wire [0 : n * 16 - 1] dotprod_horz_wires;
wire [0 : n * 16 - 1] dotprod_vert_wires;
wire [0 : n * 16 - 1] dotprod_out_wires;
reg  [0 : n * 16 - 1] dotprod_horz_regs;
reg  [0 : n * 16 - 1] dotprod_vert_regs;
reg  [0 : n * 16 - 1] dotprod_out_regs;

assign dotprod_horz_wires = dotprod_horz_regs;
assign dotprod_vert_wires = dotprod_vert_regs;
assign dotprod_out_wires  = dotprod_out_regs;


genvar i;
generate 

	for (i=0; i < num_dotprod; i=i+1) begin : Dotprod
		dotprod_com dotprod_com_inst(
			.clk(clk),
			.horz(dotprod_horz_wires[i * n * 16 : (i + 1) * n * 16 - 1]),
			.vert(dotprod_vert_wires[i * n * 16 : (i + 1) * n * 16 - 1]),
			.out(dotprod_out_wires  [i * n * 16 : (i + 1) * n * 16 - 1])			
		);
		end

endgenerate

/*
===========================================================
PIPELINE
===========================================================
*/

always @(posedge clk) begin
	
end

endmodule
