module comparator_4bit (
input [3:0] A,
input [3:0] B,
output A_greater,
output A_equal,
output A_less
);
wire E0, E1, E2, E3;
// Bitwise equality (without XOR)
assign E0 = (A[0] & B[0]) | (~A[0] & ~B[0]);
assign E1 = (A[1] & B[1]) | (~A[1] & ~B[1]);
assign E2 = (A[2] & B[2]) | (~A[2] & ~B[2]);
assign E3 = (A[3] & B[3]) | (~A[3] & ~B[3]);
assign A_equal = E3 & E2 & E1 & E0;
wire G3, G2, G1, G0;
assign G3 = A[3] & ~B[3];
assign G2 = A[2] & ~B[2] & E3;
assign G1 = A[1] & ~B[1] & E3 & E2;
assign G0 = A[0] & ~B[0] & E3 & E2 & E1;
assign A_greater = G3 | G2 | G1 | G0;
wire L3, L2, L1, L0;
assign L3 = ~A[3] & B[3];
assign L2 = ~A[2] & B[2] & E3;
assign L1 = ~A[1] & B[1] & E3 & E2;
assign L0 = ~A[0] & B[0] & E3 & E2 & E1;
assign A_less = L3 | L2 | L1 | L0;
endmodule



//test_bench

`timescale 1ns/1ps
module tb_comparator;
reg [3:0] A, B;
wire A_greater, A_equal, A_less;
// Instantiate the comparator module
comparator_4bit uut (
.A(A),
.B(B),
.A_greater(A_greater),
.A_equal(A_equal),
.A_less(A_less)
);
// VCD file for waveform
initial begin
$dumpfile("dump.vcd");
$dumpvars(0, tb_comparator);
end
// Apply stimulus
initial begin
A = 4'b0000; B = 4'b0000; #10;
A = 4'b0101; B = 4'b0011; #10;
A = 4'b1000; B = 4'b1000; #10;
A = 4'b0010; B = 4'b1110; #10;
A = 4'b1111; B = 4'b0001; #10;
$finish;
end
endmodule
10