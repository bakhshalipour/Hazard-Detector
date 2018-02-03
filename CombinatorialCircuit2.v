module CombinatorialCircuit2 (circuitOutput, circuitInputs);
  
  parameter M = 3;
  
  output reg circuitOutput;
  input [M - 1 : 0] circuitInputs;
  reg w0, w1, w2;
  
  always  @(circuitInputs or w0 or w1 or w2)  begin
    w0 <= ~ circuitInputs[1];
    w1 <= circuitInputs[0] && w0;
    w2 <= circuitInputs[2] && circuitInputs[1];
    circuitOutput <= w1 || w2;
  end
  
endmodule
