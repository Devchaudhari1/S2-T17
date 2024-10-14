# S2-T17 </br>Digital dart board game with speed controller and scoreboard
<!-- First Section -->
## Team Details
S2 T17
<details>
  <summary>Detail</summary>

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
 1. Motivation: A dart board game is not only a fun way to pass the time but also serves
as an engaging tool to develop various skills in individuals. The implementation of a Finite
State Machine (FSM)1 in the digital dart game serves as a robust framework to manage the
various states of gameplay efficiently. This game emphasizes precision and timing, making
it an excellent way to enhance focus and hand-eye coordination2. Through this project, we
aim to create a digital version of the classic dart game using innovative digital circuits. By
incorporating features like speed control and a dynamic scoreboard, players can easily track
their scores while experiencing a customizable level of challenge as the game progresses. This
adaptability adds an exciting layer of suspense and engagement to each round!</br>
2. Problem Statement:</br>
• The system must accept input signals that accurately represent dart throws on a virtual
dartboard.</br>
• The dartboard must feature a sufficiently large number of distinct target regions, with
the bullseye being the most challenging to hit.</br>
• Additionally, the game should introduce variations to increase difficulty, ensuring a stim-
ulating experience for players.</br>
• The scoreboard must effectively record game points over a wide range, avoiding overflow
to accommodate prolonged game play .</br>
• The overall objective is to develop a digital dart game that is both entertaining and
capable of accommodating multiple players while providing an intuitive and responsive
game play experience.</br>
3. Features:</br>• The dartboard utilizes an input signal from a dart throw, represented as a time-varying
pointer that periodically navigates among four concentric target regions, illuminated by
LEDs to indicate the pointer’s position.</br>
• The scoreboard can accurately record at least 20 throws without risk of overflow, ensuring
comprehensive tracking of player performance.</br>
• The dartboard includes a variable speed controller, allowing players to adjust the speed
at which the pointer changes position, enhancing the challenge.</br>
• The game is designed for up to three players, promoting friendly competition and social
interaction.</br>
• Penalty will be imposed on the player if the throw time limit is exceeded.</br>
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

  >![S2_T17mainModule](https://github.com/user-attachments/assets/b9357933-9df0-4d41-a17d-bcc7260730eb)
  PRBS Flux Module
  >![S2_T17_PRBSflux](https://github.com/user-attachments/assets/a9527ad6-64ba-48e7-8829-2cc91ac879ce)
  
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

module digital_dart_game (
    input clk,
    input reset,
    input throw_button,
    output [2:0] player_id,
    output [4:0] score_display,
    output [4:0] final_score
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
    wire [4:0] sum1, sum2, total_score;
    assign sum1 = player_score[0] + player_score[1]; // Sum of scores of Player 1 and Player 2
    assign sum2 = sum1 + player_score[2];            // Sum of Player 1, Player 2, and Player 3
    assign total_score = (sum2 > 0) ? sum2 : 1;      // Ensure non-zero final score if sum is zero

    // Assign output signals
    assign player_id = player_turn + 1;
    assign score_display = player_score[player_turn];
    assign final_score = total_score;

endmodule


 Verilog testbench code 

`include "S2_T17.v"
module tb_digital_dart_game;
    reg clk;
    reg reset;
    reg throw_button;
    wire [2:0] player_id;
    wire [4:0] score_display;
    wire [4:0] final_score;

    // Instantiate the game module
    digital_dart_game uut (
        .clk(clk),
        .reset(reset),
        .throw_button(throw_button),
        .player_id(player_id),
        .score_display(score_display),
        .final_score(final_score)
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
        $monitor("Time: %0t | Player ID: %0d | Player Score: %0d | Final Score: %0d",
                 $time, player_id, score_display, final_score);
    end
endmodule
</details>


<!--Sixth Section-->
## References
<details>
 <summary>Detail</summary>

1. [Digital anti-windup PI controllers for variable-speed motor drives using FPGA and stochastic theory](https://ieeexplore.ieee.org/document/1640711) by Zhang, Dai; Li, Hui; Collins, Emmanuel G. Published in *IEEE Transactions on Power Electronics*, Volume 21, Issue 5, Pages 1496–1501, Year 2006.

2. [Real-time digital hardware simulation of power electronics and drives](https://ieeexplore.ieee.org/document/4130508) by Parma, Gustavo G; Dinavahi, Venkata. Published in *IEEE Transactions on Power Delivery*, Volume 22, Issue 2, Pages 1235–1246, Year 2007.
</details>
