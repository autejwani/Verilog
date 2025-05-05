module Combinational_Array_Multiplier (
    input  [3:0] a,
    input  [3:0] b,
    output [7:0] product
);
    wire [2:0] c1, c2, c3, c4, c5, c6, c7, c8, c9;
    wire [3:0] s1, s2, s3;
    wire [2:0] s4, s5;
    wire [1:0] s6;
    wire s7;

    // Row 0 (no carry in or sum in)
    assign product[0] = a[0] & b[0];

    arrayblock ab1_1 (.a(a[1]), .b(b[0]), .s_in(1'b0), .c_in(1'b0), .s_out(s1[0]), .c_out(c1[0]));
    arrayblock ab1_2 (.a(a[2]), .b(b[0]), .s_in(1'b0), .c_in(c1[0]), .s_out(s1[1]), .c_out(c1[1]));
    arrayblock ab1_3 (.a(a[3]), .b(b[0]), .s_in(1'b0), .c_in(c1[1]), .s_out(s1[2]), .c_out(c1[2]));

    // Row 1
    arrayblock ab2_1 (.a(a[0]), .b(b[1]), .s_in(s1[0]), .c_in(1'b0), .s_out(product[1]), .c_out(c2[0]));
    arrayblock ab2_2 (.a(a[1]), .b(b[1]), .s_in(s1[1]), .c_in(c2[0]), .s_out(s2[0]), .c_out(c2[1]));
    arrayblock ab2_3 (.a(a[2]), .b(b[1]), .s_in(s1[2]), .c_in(c2[1]), .s_out(s2[1]), .c_out(c2[2]));
    arrayblock ab2_4 (.a(a[3]), .b(b[1]), .s_in(1'b0), .c_in(c2[2]), .s_out(s2[2]), .c_out(c2[3]));

    // Row 2
    arrayblock ab3_1 (.a(a[0]), .b(b[2]), .s_in(s2[0]), .c_in(1'b0), .s_out(product[2]), .c_out(c3[0]));
    arrayblock ab3_2 (.a(a[1]), .b(b[2]), .s_in(s2[1]), .c_in(c3[0]), .s_out(s3[0]), .c_out(c3[1]));
    arrayblock ab3_3 (.a(a[2]), .b(b[2]), .s_in(s2[2]), .c_in(c3[1]), .s_out(s3[1]), .c_out(c3[2]));
    arrayblock ab3_4 (.a(a[3]), .b(b[2]), .s_in(c2[3]), .c_in(c3[2]), .s_out(s3[2]), .c_out(c3[3]));

    // Row 3
    arrayblock ab4_1 (.a(a[0]), .b(b[3]), .s_in(s3[0]), .c_in(1'b0), .s_out(product[3]), .c_out(c4[0]));
    arrayblock ab4_2 (.a(a[1]), .b(b[3]), .s_in(s3[1]), .c_in(c4[0]), .s_out(s4[0]), .c_out(c4[1]));
    arrayblock ab4_3 (.a(a[2]), .b(b[3]), .s_in(s3[2]), .c_in(c4[1]), .s_out(s4[1]), .c_out(c4[2]));
    arrayblock ab4_4 (.a(a[3]), .b(b[3]), .s_in(c3[3]), .c_in(c4[2]), .s_out(s4[2]), .c_out(c4[3]));

    // Final addition (carry propagation to last bits)
    assign product[4] = s4[0];
    assign product[5] = s4[1];
    assign product[6] = s4[2];
    assign product[7] = c4[3];

endmodule

module arrayblock(a, b, s_in, c_in, s_out, c_out);
  input a, b, s_in, c_in;
  output s_out, c_out;
  wire p;
  assign p = a&b;
  assign (c_out, s_out} = p+s_in+c_in;
endmodule

