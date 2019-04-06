module bfloat16_adder(clk, a, b, out);
  input clk;
  input [15:0] a;
  input [15:0] b;
  output reg [15:0] out;
  reg [15:0] a_r, b_r;
  reg [15:0] out_c;
  wire a_s, b_s;
  reg [7:0] a_m, b_m;
  reg [7:0] a_m_next, b_m_next;
  wire [9:0] a_e, b_e;
  reg [9:0] holder_e;
  reg [8:0] result;
  reg [6:0] out_m;
  reg [7:0] out_e;
  wire [9:0] diff_e, neg_diff_e;

  assign a_s = a_r[15];
  assign b_s = b_r[15];
  assign a_e = {2'b00, a_r[14:7]} + 10'b1110000001;
  assign b_e = {2'b00, b_r[14:7]} + 10'b1110000001;
  assign diff_e = a_e + ~(b_e) + 10'b0000_0000_01;
  assign neg_diff_e = ~(diff_e) + 10'b0000_0000_01;

  always  @(*) begin
    // if not denormal, add implicit 1
    if(a_e != 10'b1110000001) begin
      a_m = {1'b1, a_r[6:0]};
    end
    else begin
      a_m = {a_r[6:0], 1'b0};
    end
    if(b_e != 10'b1110000001) begin
      b_m = {1'b1, b_r[6:0]};
    end
    else begin
      b_m = {b_r[6:0], 1'b0};
    end
    // if a_exp is greater, shift b_exp
    if(diff_e[9] == 1'b0) begin
      b_m_next = b_m >> diff_e;
      a_m_next = a_m;
      holder_e = a_e + 10'b000111_1111;
    end
    // if b_exp is greater, shift a_exp
    else if(diff_e[9] == 1'b1) begin
      a_m_next = a_m >> neg_diff_e;
      b_m_next = b_m;
      holder_e = b_e + 10'b000111_1111;
    end
    // if signs are equal, add
    // if(a_s == b_s) begin
    //   result = a_m_next + b_m_next;
    //   out_c[15] = a_s;
    // end
    // // if signs are not equal, determine which man is larger
    // else if((a_s == 1'b1) && (b_s == 1'b0)) begin
    //   if(a_m_next > b_m_next) begin
    //     result = a_m_next - b_m_next;
    //     out_c[15] = 1'b1;
    //   end
    //   else begin
    //     result = b_m_next - a_m_next;
    //     out_c[15] = 1'b0;
    //   end
    // end
    // else if ((b_s == 1'b1) && (a_s == 1'b0)) begin
    //   if(b_m_next > a_m_next) begin
    //     result = b_m_next - a_m_next;
    //     out_c[15] = 1'b1;
    //   end
    //   else begin
    //     result = a_m_next - b_m_next;
    //     out_c[15] = 1'b0;
    //   end
    // end

    if(a_s == b_s) begin
      result = {1'b0, a_m_next} + {1'b0, b_m_next};
      out_c[15] = a_s;
    end
    // if signs are not equal, determine which man is larger
    else if((a_s == 1'b1) && (b_s == 1'b0)) begin
      if({1'b0, a_m_next} > {1'b0, b_m_next}) begin
        result = {1'b0, a_m_next} - {1'b0, b_m_next};
        out_c[15] = 1'b1;
      end
      else begin
        result = {1'b0, b_m_next} - {1'b0, a_m_next};
        out_c[15] = 1'b0;
      end
    end
    else if ((b_s == 1'b1) && (a_s == 1'b0)) begin
      if({1'b0, b_m_next} > {1'b0, a_m_next}) begin
        result = {1'b0, b_m_next} - {1'b0, a_m_next};
        out_c[15] = 1'b1;
      end
      else begin
        result = {1'b0, a_m_next} - {1'b0, b_m_next};
        out_c[15] = 1'b0;
      end
    end

    // if((result[8:7] == 2'b11) || (result[8:7] == 2'b10)) begin
    //   out_m = result[7:1];
    //   out_e = holder_e[7:0] + 8'b0000_0001;
    // end
    // else if(result[8:7] == 2'b01) begin
    //   out_m = result[6:0];
    //   out_e = holder_e[7:0];
    // end
    // else if(result[8:7] == 2'b00) begin
    //   out_m = result[6:0];
    //   out_e = holder_e[7:0];
    // end

    //normalize mantissa
    casez(result) 
      9'b1????????: begin
        out_m = result[7:1];
        out_e = holder_e[7:0] + 8'b0000_0001;
      end
      9'b01???????: begin
        out_m = result[6:0];
        out_e = holder_e[7:0];

      end
      9'b001??????: begin
        out_m = {result[5:0], 1'b0};
        out_e = holder_e[7:0] - 8'd1;
        if(holder_e < 10'd1) begin
          result = result << holder_e;
          holder_e = 10'd0;
        end

      end
      9'b0001?????: begin
        out_m = {result[4:0], 2'b00};
        out_e = holder_e[7:0] - 8'd2;
        if(holder_e < 10'd2) begin
          result = result << holder_e;
          holder_e = 10'd0;
        end

      end
      9'b00001????: begin
        out_m = {result[3:0], 3'b000};
        out_e = holder_e[7:0] - 8'd3;
        if(holder_e < 10'd3) begin
          result = result << holder_e;
          holder_e = 10'd0;
        end
      end
      9'b000001???: begin
        out_m = {result[2:0], 4'b0000};
        out_e = holder_e[7:0] - 8'd4;
        if(holder_e < 10'd4) begin
          result = result << holder_e;
          holder_e = 10'd0;
        end
      end
      9'b0000001??: begin
        out_m = {result[1:0], 5'b00000};
        out_e = holder_e[7:0] - 8'd5;
        if(holder_e < 10'd5) begin
          result = result << holder_e;
          holder_e = 10'd0;
        end
      end
      9'b00000001?: begin
        out_m = {result[0], 6'b000000};
        out_e = holder_e[7:0] - 8'd6;
        if(holder_e < 10'd6) begin
          result = result << holder_e;
          holder_e = 10'd0;
        end
      end
      9'b000000001: begin
        out_m = 7'b0000000;
        out_e = holder_e[7:0] - 8'd7;
        if(holder_e < 10'd7) begin
          result = result << holder_e;
          holder_e = 10'd0;
        end
      end
      9'b000000000: begin
        out_m = 7'b0000000;
        out_e = 8'b0000_0000;
      end
    endcase

    if(holder_e == 10'd0) begin
      out_m = result[7:1];
      out_e = 8'd0;
    end

    // if infinity or NaN, return 16 ones
    if((a_e == 10'b0010000000) || (b_e == 10'b0010000000)) begin
      out_c[15] = 1'b1;
      out_c[14:7] = 8'hFF;
      out_c[6:0] = 7'h7F;
    end
    // if both a and b are 0, return 0
    else if((a_e == 10'b1110000001) && (b_e == 10'b1110000001) && (a_m == 0) && (b_m == 0)) begin
      out_c[15] = 1'b0;
      out_c[14:7] = 8'h00;
      out_c[6:0] = 7'h00;
    end
    // if a = 0 and b != 0, return b
    else if((a_e == 10'b1110000001) && (a_m == 0)) begin
      out_c[15] = b_r[15];
      out_c[14:7] = b_r[14:7];
      out_c[6:0] = b_r[6:0];
    end
    // if b = 0 and a != 0, return a
    else if((b_e == 10'b1110000001) && (b_m == 0)) begin
      out_c[15] = a_r[15];
      out_c[14:7] = a_r[14:7];
      out_c[6:0] = a_r[6:0];
    end
    // 0x01 - 0xFE exponents
    else begin
      out_c[14:7] = out_e;
      out_c[6:0] = out_m;
    end
  end

  always @(posedge clk) begin
    a_r <= a;
    b_r <= b;
    out <= out_c;
  end
endmodule
