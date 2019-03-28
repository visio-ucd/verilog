module bfloat_man_mult(a, b, out);
  input [8:0] a;
  input [8:0] b;
  output [15:0] out;
  wire [9:0] pp0, pp1, pp2, pp3, pp4;
  wire cout0, cout1, cout2, cout3, cout4, cout5, cout6, cout7, cout8;
  wire dump0, dump1;
  wire [15:0] row0, row1, row2;
  wire [15:0] intermediate_out;

  booth_encoding b0(.a(a), .encoding({b[1:0],1'b0}), .pp(pp0));
  booth_encoding b1(.a(a), .encoding(b[3:1]), .pp(pp1));
  booth_encoding b2(.a(a), .encoding(b[5:3]), .pp(pp2));
  booth_encoding b3(.a(a), .encoding(b[7:5]), .pp(pp3));
  booth_encoding b4(.a(a), .encoding({1'b0, b[8:7]}), .pp(pp4));

  adder32 a32_0(.a(pp0[4]), .b(pp1[2]), .cin(pp2[0]), .cout(row0[5]), .sum(row0[4]));
  adder32 a32_1(.a(pp0[5]), .b(pp1[3]), .cin(pp2[1]), .cout(row0[6]), .sum(row1[5]));
  adder42 a42_0(.a(pp0[6]), .b(pp1[4]), .c(pp2[2]), .d(pp3[0]), .cin(1'b0), .carry(row0[7]), .sum(row1[6]), .cout(cout0));
  adder42 a42_1(.a(pp0[7]), .b(pp1[5]), .c(pp2[3]), .d(pp3[1]), .cin(cout0), .carry(row0[8]), .sum(row1[7]), .cout(cout1));
  adder42 a42_2(.a(pp0[8]), .b(pp1[6]), .c(pp2[4]), .d(pp3[2]), .cin(cout1), .carry(row0[9]), .sum(row1[8]), .cout(cout2));
  adder42 a42_3(.a(pp0[9]), .b(pp1[7]), .c(pp2[5]), .d(pp3[3]), .cin(cout2), .carry(row0[10]), .sum(row1[9]), .cout(cout3));
  adder42 a42_4(.a(pp0[9]), .b(pp1[8]), .c(pp2[6]), .d(pp3[4]), .cin(cout3), .carry(row0[11]), .sum(row1[10]), .cout(cout4));
  adder42 a42_5(.a(pp0[9]), .b(pp1[9]), .c(pp2[7]), .d(pp3[5]), .cin(cout4), .carry(row0[12]), .sum(row1[11]), .cout(cout5));
  adder42 a42_6(.a(pp0[9]), .b(pp1[9]), .c(pp2[8]), .d(pp3[6]), .cin(cout5), .carry(row0[13]), .sum(row1[12]), .cout(cout6));
  adder42 a42_7(.a(pp0[9]), .b(pp1[9]), .c(pp2[9]), .d(pp3[7]), .cin(cout6), .carry(row0[14]), .sum(row1[13]), .cout(cout7));
  adder42 a42_8(.a(pp0[9]), .b(pp1[9]), .c(pp2[9]), .d(pp3[8]), .cin(cout7), .carry(row0[15]), .sum(row1[14]), .cout(cout8));
  adder42 a42_9(.a(pp0[9]), .b(pp1[9]), .c(pp2[9]), .d(pp3[9]), .cin(cout8), .carry(dump0), .sum(row1[15]), .cout(dump1));

  assign row0[3:0] = pp0[3:0];
  assign row1[4:0] = {1'b0, pp1[1:0], 2'b00};
  assign row2 = {pp4[7:0], 8'b0000_0000};
  assign intermediate_out = row1 + row0;
  assign out = intermediate_out + row2;
endmodule
