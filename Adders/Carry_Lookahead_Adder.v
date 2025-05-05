module Carry_Lookahead_Adder (
  input [3:0] a,    // 4-bit input a
  input [3:0] b,    // 4-bit input b
    input cin,        // carry-in
    output [3:0] sum, // 4-bit sum
    output cout       // carry-out
);
    wire [3:0] G; // Carry Generate: G[i] = a[i] & b[i]
    wire [3:0] P; // Carry Propagate: P[i] = a[i] ^ b[i]
    wire [3:0] C; // Carry-out

    // Generate and Propagate calculations
    assign G = a & b;        // Generate: a AND b
    assign P = a ^ b;        // Propagate: a XOR b

    // Carry Lookahead Logic
    assign C[0] = cin;                             // First carry-in is external
    assign C[1] = G[0] | (P[0] & C[0]);            // C1 = G0 + P0·C0
    assign C[2] = G[1] | (P[1] & C[1]);            // C2 = G1 + P1·C1
    assign C[3] = G[2] | (P[2] & C[2]);            // C3 = G2 + P2·C2
    assign cout  = G[3] | (P[3] & C[3]);           // Final carry-out

    // Sum calculation
    assign sum = P ^ C; // sum[i] = a[i] ^ b[i] ^ c[i]
endmodule
