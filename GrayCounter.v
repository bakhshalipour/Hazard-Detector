module GrayCounter (clk, enable, gray_code);
  
  parameter M = 3;
  
  input clk, enable;
  output reg [M - 1 : 0] gray_code;
  reg [M - 1 : 0] tog;
  integer i, j;
  
  initial begin
    gray_code = 0;
    tog = 0;
  end

  always @(posedge clk or enable) begin
    if (enable) begin
   tog = gray_code;
   for (i=0; i<=M-1; i=i+1) begin
    tog[i] = 1'b0;
    for (j=i; j<=M-1; j=j+1) begin
     tog[i] = tog[i] ^^ gray_code[j];
    end //j loop
    tog[i] = !tog[i];
    for (j=0; j<=i-1; j=j+1) begin
     tog[i] = tog[i] && !tog[j];
    end //j loop
   end //i loop
   tog[M-1] = 1'b1;
   for (j=0; j<=M-2; j=j+1) begin
    tog[M-1] = tog[M-1] && !tog[j];

   end //j loop;
   gray_code <= gray_code ^ tog;
     
 end
 end
   
endmodule