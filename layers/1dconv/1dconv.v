module convLayer(
  /*input port declarations*/
  input clk_PL,
  input clk_ALU,
  input wire [15:0] in15,
  input wire [15:0] in14,
  input wire [15:0] in13,
  input wire [15:0] in12,
  input wire [15:0] in11,
  input wire [15:0] in10,
  input wire [15:0] in9,
  input wire [15:0] in8,
  input wire [15:0] in7,
  input wire [15:0] in6,
  input wire [15:0] in5,
  input wire [15:0] in4,
  input wire [15:0] in3,
  input wire [15:0] in2,
  input wire [15:0] in1,
  input wire [15:0] in0,
  input wire [15:0] biasIn,
  input wire [15:0] weightIn,

  /*output port declarations*/
  output wire [15:0] out15,
  output wire [15:0] out14,
  output wire [15:0] out13,
  output wire [15:0] out12,
  output wire [15:0] out11,
  output wire [15:0] out10,
  output wire [15:0] out9,
  output wire [15:0] out8,
  output wire [15:0] out7,
  output wire [15:0] out6,
  output wire [15:0] out5,
  output wire [15:0] out4,
  output wire [15:0] out3,
  output wire [15:0] out2,
  output wire [15:0] out1,
  output wire [15:0] out0
);

  wire [15:0] multOut15,multOut14,multOut13,multOut12,multOut11,multOut10,multOut9,multOut8,multOut7,
                multOut6,multOut5,multOut4,multOut3,multOut2,multOut1,multOut0;

  wire [15:0] addOut15,addOut14,addOut13,addOut12,addOut11,addOut10,addOut9,addOut8,addOut7,addOut6,
                addOut5,addOut4,addOut3,addOut2,addOut1,addOut0;

  reg [7:0] indexInReg;
  reg [15:0] out15Reg,out14Reg,out13Reg,out12Reg,out11Reg,out10Reg,out9Reg,out8Reg,out7Reg,out6Reg,out5Reg,out4Reg,out3Reg,out2Reg,out1Reg,out0Reg;
  reg [15:0] rlu15Reg,rlu14Reg,rlu13Reg,rlu12Reg,rlu11Reg,rlu10Reg,rlu9Reg,rlu8Reg,rlu7Reg,rlu6Reg,rlu5Reg,rlu4Reg,rlu3Reg,rlu2Reg,rlu1Reg,rlu0Reg;
  reg [15:0] mult15Reg,mult14Reg,mult13Reg,mult12Reg,mult11Reg,mult10Reg,mult9Reg,mult8Reg,mult7Reg,mult6Reg,mult5Reg,mult4Reg,mult3Reg,mult2Reg,mult1Reg,mult0Reg;
  reg [15:0] weight, bias;
  reg [15:0] aluRegOut15,aluRegOut14,aluRegOut13,aluRegOut12,aluRegOut11,aluRegOut10,aluRegOut9,aluRegOut8,aluRegOut7,aluRegOut6,aluRegOut5,aluRegOut4,aluRegOut3,aluRegOut2,aluRegOut1,aluRegOut0;

  wire ready15,ready14,ready13,ready12,ready11,ready10,ready9,ready8,ready7,ready6,ready5,ready4,ready3,ready2,ready1,ready0;

  /*Input Stage*/
  always @(posedge clk_PL)begin
    mult15Reg <= #1 in15;
    mult14Reg <= #1 in14;
    mult13Reg <= #1 in13;
    mult12Reg <= #1 in12;
    mult11Reg <= #1 in11;
    mult10Reg <= #1 in10;
    mult9Reg <= #1 in9;
    mult8Reg <= #1 in8;
    mult7Reg <= #1 in7;
    mult6Reg <= #1 in6;
    mult5Reg <= #1 in5;
    mult4Reg <= #1 in4;
    mult3Reg <= #1 in3;
    mult2Reg <= #1 in2;
    mult1Reg <= #1 in1;
    mult0Reg <= #1 in0;

    bias <= #1 biasIn;
    weight <= #1 weightIn;
  end





  /*16 bfloat16 multipliers to multiply weight and input pixel*/
  bfloat16_mult mult15(clk_ALU,mult15Reg,weight,multOut15);
  bfloat16_mult mult14(clk_ALU,mult14Reg,weight,multOut14);
  bfloat16_mult mult13(clk_ALU,mult13Reg,weight,multOut13);
  bfloat16_mult mult12(clk_ALU,mult12Reg,weight,multOut12);
  bfloat16_mult mult11(clk_ALU,mult11Reg,weight,multOut11);
  bfloat16_mult mult10(clk_ALU,mult10Reg,weight,multOut10);
  bfloat16_mult mult9(clk_ALU,mult9Reg,weight,multOut9);
  bfloat16_mult mult8(clk_ALU,mult8Reg,weight,multOut8);
  bfloat16_mult mult7(clk_ALU,mult7Reg,weight,multOut7);
  bfloat16_mult mult6(clk_ALU,mult6Reg,weight,multOut6);
  bfloat16_mult mult5(clk_ALU,mult5Reg,weight,multOut5);
  bfloat16_mult mult4(clk_ALU,mult4Reg,weight,multOut4);
  bfloat16_mult mult3(clk_ALU,mult3Reg,weight,multOut3);
  bfloat16_mult mult2(clk_ALU,mult2Reg,weight,multOut2);
  bfloat16_mult mult1(clk_ALU,mult1Reg,weight,multOut1);
  bfloat16_mult mult0(clk_ALU,mult0Reg,weight,multOut0);

  /*Mult and Adder in different pipeline stages*/
  always @(posedge clk_PL)begin
    aluRegOut15 <= #1 multOut15;
    aluRegOut14 <= #1 multOut14;
    aluRegOut13 <= #1 multOut13;
    aluRegOut12 <= #1 multOut12;
    aluRegOut11 <= #1 multOut11;
    aluRegOut10 <= #1 multOut10;
    aluRegOut9 <= #1 multOut9;
    aluRegOut8 <= #1 multOut8;
    aluRegOut7 <= #1 multOut7;
    aluRegOut6 <= #1 multOut6;
    aluRegOut5 <= #1 multOut5;
    aluRegOut4 <= #1 multOut4;
    aluRegOut3 <= #1 multOut3;
    aluRegOut2 <= #1 multOut2;
    aluRegOut1 <= #1 multOut1;
    aluRegOut0 <= #1 multOut0;
  end

  /*16 bfloat16 adders to add output from multiplier and bias*/
  bfloat16_add addr15(clk_ALU,multOut15,bias,addOut15);
  bfloat16_add addr14(clk_ALU,multOut14,bias,addOut14);
  bfloat16_add addr13(clk_ALU,multOut13,bias,addOut13);
  bfloat16_add addr12(clk_ALU,multOut12,bias,addOut12);
  bfloat16_add addr11(clk_ALU,multOut11,bias,addOut11);
  bfloat16_add addr10(clk_ALU,multOut10,bias,addOut10);
  bfloat16_add addr9(clk_ALU,multOut9,bias,addOut9);
  bfloat16_add addr8(clk_ALU,multOut8,bias,addOut8);
  bfloat16_add addr7(clk_ALU,multOut7,bias,addOut7);
  bfloat16_add addr6(clk_ALU,multOut6,bias,addOut6);
  bfloat16_add addr5(clk_ALU,multOut5,bias,addOut5);
  bfloat16_add addr4(clk_ALU,multOut4,bias,addOut4);
  bfloat16_add addr3(clk_ALU,multOut3,bias,addOut3);
  bfloat16_add addr2(clk_ALU,multOut2,bias,addOut2);
  bfloat16_add addr1(clk_ALU,multOut1,bias,addOut1);
  bfloat16_add addr0(clk_ALU,multOut0,bias,addOut0);




  always @(*)begin //RLU operation
      //if MSB is 1 (value is negative) set to 0
      rlu15Reg = addOut15;
      rlu14Reg = addOut14;
      rlu13Reg = addOut13;
      rlu12Reg = addOut12;
      rlu11Reg = addOut11;
      rlu10Reg = addOut10;
      rlu9Reg = addOut9;
      rlu8Reg = addOut8;
      rlu7Reg = addOut7;
      rlu6Reg = addOut6;
      rlu5Reg = addOut5;
      rlu4Reg = addOut4;
      rlu3Reg = addOut3;
      rlu2Reg = addOut2;
      rlu1Reg = addOut1;
      rlu0Reg = addOut0;

      if(rlu15Reg[15] == 1'b1)
          rlu15Reg = 16'd0;
      if(rlu14Reg[15] == 1'b1)
          rlu14Reg = 16'd0;
      if(rlu13Reg[15] == 1'b1)
          rlu13Reg = 16'd0;
      if(rlu12Reg[15] == 1'b1)
          rlu12Reg = 16'd0;
      if(rlu11Reg[15] == 1'b1)
          rlu11Reg = 16'd0;
      if(rlu10Reg[15] == 1'b1)
          rlu10Reg = 16'd0;
      if(rlu9Reg[15] == 1'b1)
          rlu9Reg = 16'd0;
      if(rlu8Reg[15] == 1'b1)
          rlu8Reg = 16'd0;
      if(rlu7Reg[15] == 1'b1)
          rlu7Reg = 16'd0;
      if(rlu6Reg[15] == 1'b1)
          rlu6Reg = 16'd0;
      if(rlu5Reg[15] == 1'b1)
          rlu5Reg = 16'd0;
      if(rlu4Reg[15] == 1'b1)
          rlu4Reg = 16'd0;
      if(rlu3Reg[15] == 1'b1)
          rlu3Reg = 16'd0;
      if(rlu2Reg[15] == 1'b1)
          rlu2Reg = 16'd0;
      if(rlu1Reg[15] == 1'b1)
          rlu1Reg = 16'd0;
      if(rlu0Reg[15] == 1'b1)
          rlu0Reg = 16'd0;

  end

  /*
      At posedge of pipeline clk
      the 16 outputs of module changes
      to the correct values for filter/bias
      at the specified index
  */
  always @(posedge clk_PL)begin
      out15Reg <= #1 rlu15Reg;
      out14Reg <= #1 rlu14Reg;
      out13Reg <= #1 rlu13Reg;
      out12Reg <= #1 rlu12Reg;
      out11Reg <= #1 rlu11Reg;
      out10Reg <= #1 rlu10Reg;
      out9Reg <= #1 rlu9Reg;
      out8Reg <= #1 rlu8Reg;
      out7Reg <= #1 rlu7Reg;
      out6Reg <= #1 rlu6Reg;
      out5Reg <= #1 rlu5Reg;
      out4Reg <= #1 rlu4Reg;
      out3Reg <= #1 rlu3Reg;
      out2Reg <= #1 rlu2Reg;
      out1Reg <= #1 rlu1Reg;
      out0Reg <= #1 rlu0Reg;
  end

  assign out15 = out15Reg;
  assign out14 = out14Reg;
  assign out13 = out13Reg;
  assign out12 = out12Reg;
  assign out11 = out11Reg;
  assign out10 = out10Reg;
  assign out9 = out9Reg;
  assign out8 = out8Reg;
  assign out7 = out7Reg;
  assign out6 = out6Reg;
  assign out5 = out5Reg;
  assign out4 = out4Reg;
  assign out3 = out3Reg;
  assign out2 = out2Reg;
  assign out1 = out1Reg;
  assign out0 = out0Reg;

endmodule
