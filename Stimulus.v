module Stimulus;
  
  //module HazardRecognizer (isThereHazard, start);
  reg start;
  wire isThereHazard;
  
  HazardRecognizer myHazardRecognizer (isThereHazard, start);
  
  initial begin
        start = 0;
    #10 start = 1;
  end
  
endmodule
