module array_multiplier (
    input  [3:0] A,
    input  [3:0] B,
    output [7:0] P
);
    wire [3:0] s1, s2, s3, s4;
    wire [3:0] c1, c2, c3, c4;
    wire [1:0] ha_s, ha_c;
    wire [1:0] fa_s, fa_c;

    // Row 1: A * B[0]
    assign P[0] = A[0] & B[0];
    arrayblock ab10 (.a(A[1]), .b(B[0]), .s_in(1'b0), .c_in(1'b0), .s_out(s1[0]), .c_out(c1[0]));
    arrayblock ab11 (.a(A[2]), .b(B[0]), .s_in(1'b0), .c_in(c1[0]), .s_out(s1[1]), .c_out(c1[1]));
    arrayblock ab12 (.a(A[3]), .b(B[0]), .s_in(1'b0), .c_in(c1[1]), .s_out(s1[2]), .c_out(c1[2]));

    // Row 2: A * B[1]
    arrayblock ab20 (.a(A[0]), .b(B[1]), .s_in(s1[0]), .c_in(1'b0), .s_out(P[1]), .c_out(c2[0]));
    arrayblock ab21 (.a(A[1]), .b(B[1]), .s_in(s1[1]), .c_in(c2[0]), .s_out(s2[0]), .c_out(c2[1]));
    arrayblock ab22 (.a(A[2]), .b(B[1]), .s_in(s1[2]), .c_in(c2[1]), .s_out(s2[1]), .c_out(c2[2]));
    arrayblock ab23 (.a(A[3]), .b(B[1]), .s_in(c1[2]), .c_in(c2[2]), .s_out(s2[2]), .c_out(c2[3]));

    // Row 3: A * B[2]
    arrayblock ab30 (.a(A[0]), .b(B[2]), .s_in(s2[0]), .c_in(1'b0), .s_out(P[2]), .c_out(c3[0]));
    arrayblock ab31 (.a(A[1]), .b(B[2]), .s_in(s2[1]), .c_in(c3[0]), .s_out(s3[0]), .c_out(c3[1]));
    arrayblock ab32 (.a(A[2]), .b(B[2]), .s_in(s2[2]), .c_in(c3[1]), .s_out(s3[1]), .c_out(c3[2]));
    arrayblock ab33 (.a(A[3]), .b(B[2]), .s_in(c2[3]), .c_in(c3[2]), .s_out(s3[2]), .c_out(c3[3]));

    // Row 4: A * B[3]
    arrayblock ab40 (.a(A[0]), .b(B[3]), .s_in(s3[0]), .c_in(1'b0), .s_out(P[3]), .c_out(c4[0]));
    arrayblock ab41 (.a(A[1]), .b(B[3]), .s_in(s3[1]), .c_in(c4[0]), .s_out(s4[0]), .c_out(c4[1]));
    arrayblock ab42 (.a(A[2]), .b(B[3]), .s_in(s3[2]), .c_in(c4[1]), .s_out(s4[1]), .c_out(c4[2]));
    arrayblock ab43 (.a(A[3]), .b(B[3]), .s_in(c3[3]), .c_in(c4[2]), .s_out(s4[2]), .c_out(c4[3]));

    // Final row of adders (2 half adders, 2 full adders)
    half_adder ha0 (.a(s4[0]), .b(c3[0]), .sum(P[4]), .carry(ha_c[0]));
    full_adder fa0 (.a(s4[1]), .b(c4[3]), .cin(ha_c[0]), .sum(P[5]), .carry(fa_c[0]));
    full_adder fa1 (.a(s4[2]), .b(c4[3]), .cin(fa_c[0]), .sum(P[6]), .carry(fa_c[1]));
    half_adder ha1 (.a(c4[3]), .b(fa_c[1]), .sum(P[7]), .carry(ha_c[1])); // final carry ignored

endmodule

//======================== Submodules ===========================//

// arrayblock: 1-bit partial product and 3-input addition
module arrayblock(a, b, s_in, c_in, s_out, c_out);
input a, b, s_in, c_in;
output s_out, c_out;
wire p;
assign p = a&b;
assign (c_out, s_out} = p+s_in+c_in;
endmodule

// half adder: 2-input adder
module half_adder (
    input a,
    input b,
    output sum,
    output carry
);
    assign sum = a ^ b;
    assign carry = a & b;
endmodule

// full adder: 3-input adder
module full_adder (
    input a,
    input b,
    input cin,
    output sum,
    output carry
);
    assign sum = a ^ b ^ cin;
    assign carry = (a & b) | (a & cin) | (b & cin);
endmodule


