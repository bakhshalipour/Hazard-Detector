# Hazard-Detector

If several paths from the inputs to the output of a combinational circuit have different delays, unwanted switching changes may arise in the output. This problem is known as [Hazard](https://www.allaboutcircuits.com/technical-articles/hazards-in-combinational-logic/) in combinational circuits. Hazards are challenging in the verification of digital systems. 

This project aims to identify Hazards of a given logic, using a simple and high-level simulation-based approach. The program takes a circuit (described in any HDL) as input and after simulating the logic (using any HDL simulator) identifies that whether the circuit has Hazard or not. The below figure depicts the overview of this project.

![alt text](https://github.com/bakhshalipour/Hazard-Detector/blob/master/hazard-detector-high-level.png)

### How Does It Work?
The main idea is that to simulate the circuit *without timing parameters*. Doing so, the effects of inputs changes immediately appear in the output. In this situation, the *HazardRecognizer* module applies an M-bit [Gray code](https://en.wikipedia.org/wiki/Gray_code) and records the *absolute time* of *1->0* and *0->1* events at the output. If the *absolute time* of a *1->0* event is equal to that of *0->1* event, it means that the circuit has Hazard.

### Usage
Define your circuit and create an instance from that in *HazardRecognizer.v*. Then run the following command.

    $ ./Simulate.do
    
### Acknowledgment
The implementation of the Gray code is obtained from [online resources](http://computer-programming-forum.com/41-verilog/91272a60bbc35911.htm).
