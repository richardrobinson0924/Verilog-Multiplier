// multiplies 2 n-bit numbers `m` and `q` into their `n * 2` bit product `s`
module multipliern (m, q, s);
  parameter integer n = 8;

  input [n-1:0] m, q;
  output [n*2-1:0] s;

  wire [n-1:0] b;
  wire [n*n-1:0] t, u; // results of ands, adders

  wire [n-1:0] c; // carry

  genvar i;
  generate
    for (i = 0; i < n; i = i + 1) begin
      multi_and ma(m, q[i], t[n*i+(n-1) : n*i]);
    end
  endgenerate

  assign s[0] = t[0];
  assign c[0] = 1'b0;
  assign u[n-1:1] = t[n-1:1];

  genvar j;
  generate
    for (j = 0; j < n - 1; j = j + 1) begin
      addern a(
        1'b0, // carryin
        t[(j*n)+(2*n)-1 : (j*n)+n], // X
        {c[j], u[n*j+(n-1) : n*j+1]}, // Y
        u[(j*n)+(2*n)-1 : (j*n)+n], // S
        c[j+1] // carryout
      );

      copy c(u[j*n+n], s[j+1]);
    end
  endgenerate

  assign s[n*2-2 : n-1] = u[n*n-1 : n*n-1-n+1];
  assign s[n*2-1] = c[n-1];
endmodule // multipliern
