// test bench
module test_bench ();
  reg [7:0] x, y;
  reg [15:0] expected;
  wire [15:0] z, c;

  multipliern m(x, y, z);

  integer i, j, a, b;

  initial begin
    a = 0;
    b = 0;
    for (i = 0; i < 256; i++) begin
      for (j = 0; j < 256; j++) begin
        x = i;
        y = j;

        expected = x * y;

        #1;
        if (z !== expected) begin
          $display("FAIL: %d * %d = %d | %d\t(%b * %b = %b | %b)", x, y, z, expected, x, y, z, expected);
          a = a + 1;
        end else begin
          b = b + 1;
        end
      end
    end

    $display("\n# PASSED: %d\t FAILED: %d", b, a);

    $finish;
  end

endmodule // test_bench
