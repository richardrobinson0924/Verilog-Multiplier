// Multiplies an n-bit `x` by a single bit `y`
module multi_and(x, y, s);
  parameter integer n = 8;

  input [n-1:0] x;
  input y;
  output [n-1:0] s;

  genvar i;
  generate
    for (i = 0; i <= n - 1; i = i + 1) begin
      and a(s[i], x[i], y);
    end
  endgenerate

endmodule

module copy (input i, output o);
  assign o = i;
endmodule // copy

// ripple carry adder for 2 n-bit numbers
module addern (carryin, X, Y, S, carryout);
  parameter integer n = 8;

  input carryin;
  input [n-1:0] X, Y;

  output [n-1:0] S;
  output carryout;

  wire [n:0] C;
  genvar i;
  assign C[0] = carryin;
  assign carryout = C[n];

  generate
    for (i = 0; i <= n - 1; i = i + 1) begin
      full_adder fa(C[i], X[i], Y[i], S[i], C[i+1]);
    end
  endgenerate

endmodule // addern

module full_adder (input Cin, x, y, output s, Cout);
  assign s = x ^ y ^ Cin;
  assign Cout = (x & y) | (x & Cin) | (y & Cin);
endmodule // full_adder
