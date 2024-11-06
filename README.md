# </br>Digital dart board game with speed controller and scoreboard
<!-- First Section -->
## Team Details

<details>
  <summary>Detail</summary>

  >S2 T17

  > Semester: 3rd Sem B. Tech. CSE

  > Section: S2

  > Member-1:Dev Chaudhari , 231CS221 ,devchaudhari.231cs221@nitk.edu.in

  > member-2:Himanshu Bande, 231CS225 ,himanshubande.231cs225@nitk.edu.in

  > Member-3:Aryan         , 231CS213 ,aryan.231cs213@nitk.edu.in
</details>

<!-- Second Section -->
## Abstract
<details>
  <summary>Detail</summary>
  


## 1. Motivation

A dartboard game is not only a fun way to pass the time but also serves as an engaging tool to develop various skills in individuals. The implementation of a Finite State Machine (FSM) in the digital dart game provides a robust framework to manage the various states of gameplay efficiently. This game emphasizes precision and timing, making it an excellent way to enhance focus and hand-eye coordination. </br></br>Through this project, we aim to create a digital version of the classic dart game using innovative digital circuits. By incorporating features like speed control and a dynamic scoreboard, players can easily track their scores while experiencing a customizable level of challenge as the game progresses. This adaptability adds an exciting layer of suspense and engagement to each round!

---

## 2. Problem Statement

- The system must accept input signals that accurately represent dart throws on a virtual dartboard.
- The dartboard must feature a sufficiently large number of distinct target regions, with the bullseye being the most challenging to hit.
- Additionally, the game should introduce variations to increase difficulty, ensuring a stimulating experience for players.
- The scoreboard must effectively record game points over a wide range, avoiding overflow to accommodate prolonged gameplay.
- The overall objective is to develop a digital dart game that is both entertaining and capable of accommodating multiple players while providing an intuitive and responsive gameplay experience.

---

## 3. Features

- The dartboard utilizes an input signal from a dart throw, represented as a time-varying pointer that periodically navigates among four concentric target regions, illuminated by LEDs to indicate the pointer’s position.
- The scoreboard can accurately record at least 20 throws without risk of overflow, ensuring comprehensive tracking of player performance.
- The dartboard includes a variable speed controller, allowing players to adjust the speed at which the pointer changes position, enhancing the challenge.
- The game is designed for up to three players, promoting friendly competition and social interaction.
- A penalty will be imposed on the player if the throw time limit is exceeded.


Feel free to let me know if you need any further modifications!
</details>

<!-- Third Section -->
## Working
<details>
  <summary>Detail</summary>

  > ![image](https://github.com/Devchaudhari1/S2-T17/blob/main/Digital%20dartboard%20game%20modularized.drawio.png)
</details>

<!-- Fourth Section -->
## Logisim Circuit Diagram
<details>
  <summary>Detail</summary>

  Working Instructions
  >![S2_T17](https://github.com/user-attachments/assets/907e8224-7826-4289-886b-4003ec9c9218)
  
Main Module

  >![Maindigitaldartgame](https://github.com/user-attachments/assets/16a7bc57-4218-4f0d-aa8a-b614f975afd8)

  PRBS Flux Module
  >
  ![PRBS Flux](https://github.com/user-attachments/assets/575946f7-9059-4f13-b150-0e8fa9f82b0a)
Final Score Comparator
  >![Final Score Comparator](https://github.com/user-attachments/assets/7a6e533e-e9ea-42f4-aa6e-1d4baf31d736)

  Truth Table For Points Awarded Per Throw

  > ![S2_T17_truthtable](https://github.com/user-attachments/assets/e097b109-b863-4d5a-9b9c-c8e492875117)

   State Equations For Concentric Circles Lit By LEDs
  >![S2_T17_stateEquation](https://github.com/user-attachments/assets/e9f7804b-ed91-4b0f-a9e4-05b82f8c3b84)
  >![S2_T17_stateEquationfootnote](https://github.com/user-attachments/assets/9e5105a2-dda6-4ca2-baa4-bbf8127eefd0)


</details>

<!-- Fifth Section -->
## Verilog Code
<details>
  <summary>Detail</summary>
Verilog main module code :
<code>
module digital_dart_game (
    input clk,
    input reset,
    input throw_button,
    output [2:0] player_id,
    output [4:0] score_display,
    output [4:0] final_score,
    output [4:0] winner
);
wire [4:0] circle_points;  // Randomly generated points for each throw
reg [4:0] player_score[0:2]; // Array to store total scores for Player 1, 2, 3
reg [2:0] player_turn;      // Current player's turn (0 for Player 1, 1 for Player 2, 2 for Player 3)
reg [2:0] throw_count;      // Throw count for each player
reg [4:0] prbs;             // PRBS for generating random values

// Random number generator using LFSR for circle points
always @(posedge clk or posedge reset) begin
    if (reset)
        prbs <= 5'b10101;  // Initialize PRBS with a seed value
    else
        prbs <= {prbs[3:0], prbs[4] ^ prbs[2]};  // Generate new PRBS value
end

// Circle points assignment based on PRBS value using gates
assign circle_points = (prbs[2:0] == 3'b000) ? 5 :
                       (prbs[2:0] == 3'b001) ? 4 :
                       (prbs[2:0] == 3'b010) ? 3 :
                       (prbs[2:0] == 3'b011) ? 2 :
                       (prbs[2:0] == 3'b100) ? 1 : 0;

// Logic for scoring and changing turns using gates
always @(posedge clk or posedge reset) begin
    if (reset) begin
        player_score[0] <= 0;
        player_score[1] <= 0;
        player_score[2] <= 0;
        player_turn <= 0;
        throw_count <= 0;
    end else if (throw_button) begin
        // Add points to the current player's score
        player_score[player_turn] <= player_score[player_turn] + circle_points;
        throw_count <= throw_count + 1;

        // Change player's turn after 5 throws
        if (throw_count == 4) begin
            throw_count <= 0;
            player_turn <= player_turn + 1;
        end

        // Reset to Player 1 after Player 3's turn
        if (player_turn == 3)
            player_turn <= 0;
    end
end

// Calculate the final score as the sum of all player scores
wire [4:0] sum1, sum2, total_score, winner;
assign sum1 = player_score[0] + player_score[1]; // Sum of scores of Player 1 and Player 2
assign sum2 = sum1 + player_score[2];            // Sum of Player 1, Player 2, and Player 3
assign total_score = (player_score[0] > player_score[1]) ? player_score[0] : (player_score[1]>player_score[2])?player_score[1] : player_score[2];      // Ensure non-zero final score if sum is zero
assign winner = (player_score[0] > player_score[1]) ? 1 : (player_score[1]>player_score[2])?2 : 3;  
// Assign output signals
assign player_id = player_turn + 1;
assign score_display = player_score[player_turn];
assign final_score = total_score;
    
  

endmodule
</code>


 Verilog testbench code 
<code>
`include "S2_T17.v"
module tb_digital_dart_game;
reg clk;
reg reset;
reg throw_button;
wire [2:0] player_id;
wire [4:0] score_display;
wire [4:0] winning_score;
wire [4:0] winner;

// Instantiate the game module
digital_dart_game uut (
    .clk(clk),
    .reset(reset),
    .throw_button(throw_button),
    .player_id(player_id),
    .score_display(score_display),
    .final_score(winning_score),.winner(winner)
);

// Clock generation
initial begin
    clk = 0;
    forever #5 clk = ~clk; // 10 time units period
end

// Simulation logic
initial begin
    // Reset and initialize
    reset = 1;
    throw_button = 0;
    #10 reset = 0;

    // Simulate throws for each player
    repeat (3) begin
        for (integer i = 0; i < 5; i = i + 1) begin
            throw_button = 1;
            #10 throw_button = 0;
            #20;
        end
    end

    // End simulation
    #100;
    $finish;
end

// Monitor the outputs
initial begin
    $monitor("Time: %0t | Player ID: %0d | Player Score: %0d | Winning Score: %0d | Winner: %0d",
             $time, player_id, score_display, winning_score,winner);
end

    
  

endmodule
</code>
</details>
<!-- Fifth Section --> 

## Hardware Implementation       


<details>
  <summary><strong>Salient Features</strong></summary><br>

  <summary><strong>PRBS Generator for Dartboard Patterns</strong></summary><br>

  The project involves the implementation of a **Pseudo-Random Bit Sequence (PRBS)** generator using **7474 D-type flip-flops** and **7486 XOR gates**. The PRBS generator produces a 15-bit sequence that controls the **dartboard patterns** displayed on a series of LEDs. The design employs a **Linear Feedback Shift Register (LFSR)** configuration, where the flip-flops store and shift binary data, and the XOR gates provide feedback to generate the random sequence. This sequence is then used to control the dynamic lighting of the dartboard, simulating random dart throws.

  The PRBS generator is initialized with a **seed value of 1**, which is set by selecting the **3rd** and **4th bits** of the sequence. This seed ensures that the sequence begins with a known state, from which the pseudo-random pattern evolves, providing consistent and predictable random behavior for the dartboard display.

  This implementation showcases the use of basic digital logic components to generate pseudo-random sequences, offering a cost-effective and reliable solution for creating random patterns in visual applications such as a dartboard simulation.


  <summary><strong>5-Bit BCD Address Logic Using 7483 ICs</strong></summary><br>

  The project utilizes a **5-bit BCD address** generated and maintained using **three 7483 4-bit binary full adder ICs**. Each IC handles the addition of BCD digits, ensuring the address remains within the valid range of 0 to 31 (decimal). The first two ICs handle the primary 4-bit BCD values, while the third IC manages carry propagation and overflow. This logic guarantees that the system can dynamically generate addresses for controlling various dartboard patterns.

  The carry-out from one IC feeds into the next, allowing for accurate address calculation and sequencing across the 5-bit range. This efficient address logic ensures smooth and reliable dartboard pattern control.

  <summary><strong>Visuals of Implementation</strong></summary><br>

 
https://github.com/Devchaudhari1/S2-T17/blob/main/Snapshots/PRBS%20Module(hardware).png

 
https://github.com/Devchaudhari1/S2-T17/blob/main/Snapshots/5%20bit%20bcd%20adder(hardware).png 

https://github.com/Devchaudhari1/S2-T17/blob/main/Snapshots/Achievement%20Unlocked%20Module(hardware).png    


</details>


<!--Sixth Section-->
## References
<details>
 <summary>Detail</summary>

1. [Digital anti-windup PI controllers for variable-speed motor drives using FPGA and stochastic theory](https://ieeexplore.ieee.org/document/1640711) by Zhang, Dai; Li, Hui; Collins, Emmanuel G. Published in *IEEE Transactions on Power Electronics*, Volume 21, Issue 5, Pages 1496–1501, Year 2006.

2. [Real-time digital hardware simulation of power electronics and drives](https://ieeexplore.ieee.org/document/4130508) by Parma, Gustavo G; Dinavahi, Venkata. Published in *IEEE Transactions on Power Delivery*, Volume 22, Issue 2, Pages 1235–1246, Year 2007.
</details>
