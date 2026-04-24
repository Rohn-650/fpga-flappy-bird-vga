module game_physics (
    input  wire clk,
    input  wire update_tick,
    input  wire reset,
    input  wire jump_req,
    output reg [9:0] bird_y,
    output reg [9:0] pipe_x,
    output reg [9:0] gap_y,
    output reg game_over,
    output reg pipe_style   // NEW
);

    reg [15:0] bird_y_fixed;
    reg signed [15:0] velocity;
    reg [15:0] lfsr;

    always @(posedge clk or posedge reset) begin
        if (reset) begin
            bird_y_fixed <= 240 << 6;
            pipe_x <= 640;
            velocity <= 0;
            game_over <= 0;
            gap_y <= 150;
            lfsr <= 16'hACE1;
            pipe_style <= 0;
        end 
        else if (update_tick && !game_over) begin

            // random
            lfsr <= {lfsr[14:0], lfsr[15] ^ lfsr[13]};

            // physics
            if (jump_req)
                velocity <= -400;
            else
                velocity <= velocity + 15;

            bird_y_fixed <= bird_y_fixed + velocity;
            bird_y <= bird_y_fixed[15:6];

            // pipes
            if (pipe_x < 4) begin
                pipe_x <= 640;
                gap_y <= 60 + (lfsr[7:0] % 180);
                pipe_style <= lfsr[8];   // random style
            end else begin
                pipe_x <= pipe_x - 4;
            end

            // collision
            if (bird_y > 470 || bird_y < 5)
                game_over <= 1;

            if (pipe_x < 116 && pipe_x + 40 > 100) begin
                if (bird_y < gap_y || bird_y + 16 > gap_y + 130)
                    game_over <= 1;
            end
        end
    end
endmodule