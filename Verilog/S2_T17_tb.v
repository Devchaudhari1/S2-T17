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
