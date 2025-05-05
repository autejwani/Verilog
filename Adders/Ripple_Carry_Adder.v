module Ripple_Carry_Adder (
    input [3:0] a,    // 4-bit input A
    input [3:0] b,    // 4-bit input B
    input cin,        // carry-in
    output [3:0] sum, // 4-bit sum
    output cout       // Final carry-out
);
    wire [2:0] carry; // Internal carry wires
  
    full_adder fa0(a[0], b[0], cin,     sum[0], carry[0]);
    full_adder fa1(a[1], b[1], carry[0], sum[1], carry[1]);
    full_adder fa2(a[2], b[2], carry[1], sum[2], carry[2]);
    full_adder fa3(a[3], b[3], carry[2], sum[3], cout);
endmodule

module full_adder (
    input a,          // 1-bit input A
    input b,          // 1-bit input B
    input cin,        // Carry-in
    output sum,       // Sum
    output cout       // Carry-out
);
    assign sum = a ^ b ^ cin;               // Sum = A XOR B XOR Cin
    assign cout = (a & b) | (b & cin) | (a & cin); // Carry-out
endmodule
