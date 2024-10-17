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