module HazardRecognizer (isThereHazard, start);
  
  parameter M = 3;
  parameter N = 8;  //N = 2^M;
  
  output reg isThereHazard = 0;
  reg [M - 1 : 0] cCinputs = 0;
  wire cCOutput;
  input start;
  time  t0, t1;
  reg [M - 1 : 0] grayCodes [0 : 2 * N - 2];
  reg [M - 1 : 0] gray_code = 0;
  reg [M - 1 : 0] tog = 0;
  integer i, j, k;
  reg eliminateRace = 0;
  reg eliminateRace1 = 0;
  
  //CombinatorialCircuit myCombinatorialCircuit (cCOutput, cCinputs);
  CombinatorialCircuit2 myCombinatorialCircuit2 (cCOutput, cCinputs);
  
  initial begin
    grayCodes[0] = 0;
    for (k = 1; k < N; k = k + 1) begin
      tog = gray_code;
      for (i=0; i<=M-1; i=i+1) begin
        tog[i] = 1'b0;
        for (j=i; j<=M-1; j=j+1) begin
         tog[i] = tog[i] ^^ gray_code[j];
        end 
        tog[i] = !tog[i];
        for (j=0; j<=i-1; j=j+1) begin
         tog[i] = tog[i] && !tog[j];
        end
      end
      tog[M-1] = 1'b1;
      for (j=0; j<=M-2; j=j+1) begin
        tog[M-1] = tog[M-1] && !tog[j];
      end
      gray_code = gray_code ^ tog;
      grayCodes[k] = gray_code;
    end
    eliminateRace = 1;
  end
  
  //
  initial wait (eliminateRace)  begin
    gray_code = 0;
    grayCodes[2 * N - 2] = 0;
    for (k = 2 * N - 3; k >= N; k = k - 1) begin
      tog = gray_code;
      for (i=0; i<=M-1; i=i+1) begin
        tog[i] = 1'b0;
        for (j=i; j<=M-1; j=j+1) begin
         tog[i] = tog[i] ^^ gray_code[j];
        end 
        tog[i] = !tog[i];
        for (j=0; j<=i-1; j=j+1) begin
         tog[i] = tog[i] && !tog[j];
        end
      end
      tog[M-1] = 1'b1;
      for (j=0; j<=M-2; j=j+1) begin
        tog[M-1] = tog[M-1] && !tog[j];
      end
      gray_code = gray_code ^ tog;
      grayCodes[k] = gray_code;
    end
    eliminateRace1 = 1;
  end
  
  initial wait(eliminateRace1) begin 
    for (i = 0; i <= 2 * N - 2; i = i + 1)
      #5  cCinputs = grayCodes[i];
  end
  
  //initial
    //$monitor (grayCodes[0], grayCodes[1], grayCodes[2], grayCodes[3], grayCodes[4], grayCodes[5], grayCodes[6], grayCodes[7], grayCodes[8], grayCodes[9], grayCodes[10], grayCodes[11], grayCodes[12], grayCodes[13], grayCodes[14]);
  
  
  always  @(posedge cCOutput)
    t0 = $time;
    
  always  @(negedge cCOutput)
    t1 = $time;
    
  always  @(t0, t1)
    if (t0 == t1)
      isThereHazard = 1;
  
endmodule