module CombinatorialCircuit (circuitOutput, circuitInputs);
  
  parameter M = 1;
  
  output reg circuitOutput;
  input [M - 1 : 0] circuitInputs;
  reg w0;
  
  always  @(circuitInputs or w0)  begin
    w0 <= ~ circuitInputs[0];
    circuitOutput <= circuitInputs[0] && w0;
  end
  
endmodule