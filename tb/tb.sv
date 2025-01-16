module tb;

  logic in = 1'b0;
  logic out;
  
  // DUT Instantiation
  inverter dut (
    .x(in),
    .zn(out)
  );

  initial begin
    $timeformat(-9, 0, "ns", 10);
    $display("Begin simulation");
    #10ns; in = 'b1;
    #10ns; in = 'b0;
    #10ns; in = 'b1;
    #10ns; in = 'b0;
    #10ns; in = 'b0;
    #10ns; in = 'b1;
    #10ns; in = 'b1;
    #10ns; in = 'b1;
    #10ns; in = 'b0;
    #10ns; in = 'b0;
    #10ns;
    $display("End simulation");
    $finish;
  end

endmodule : tb
