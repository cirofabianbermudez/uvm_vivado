module inverter(
  input  logic x,
  output logic zn
);

  assign zn = ~x;

endmodule
