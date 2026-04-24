
module bird_top (
    input  wire clk,
    input  wire reset_hw,
    input  wire btn_restart,
    input  wire btn_jump,
    output wire hsync,
    output wire vsync,
    output wire [3:0] r, g, b,
    output wire [7:0] LED
);

    wire clk25, locked;

    clk_wiz_0 clk_gen_inst (
        .clk_in1(clk),
        .reset(reset_hw),
        .clk_out1(clk25), 
        .locked(locked)
    );

    wire system_reset = reset_hw || !locked;
    wire game_reset = system_reset || btn_restart;

    // 60 Hz tick
    reg [19:0] counter = 0;
    reg update_tick = 0;

    always @(posedge clk25) begin
        if (counter == 416666) begin
            counter <= 0;
            update_tick <= 1;
        end else begin
            counter <= counter + 1;
            update_tick <= 0;
        end
    end

    // button sync
    reg [2:0] jump_sync;
    reg jump_latch;

    always @(posedge clk25 or posedge game_reset) begin
        if (game_reset) begin
            jump_sync <= 0;
            jump_latch <= 0;
        end else begin
            jump_sync <= {jump_sync[1:0], btn_jump};

            if (jump_sync[2:1] == 2'b01)
                jump_latch <= 1;

            if (update_tick)
                jump_latch <= 0;
        end
    end

    assign LED[0] = btn_jump;
    assign LED[7:1] = 0;

    wire [9:0] bird_y, pipe_x, gap_y;
    wire game_over;
    wire pipe_style;

    game_physics physics_inst (
        .clk(clk25),
        .update_tick(update_tick),
        .reset(game_reset),
        .jump_req(jump_latch),
        .bird_y(bird_y),
        .pipe_x(pipe_x),
        .gap_y(gap_y),
        .game_over(game_over),
        .pipe_style(pipe_style)
    );

    vga_renderer renderer_inst (
        .clk25(clk25),
        .bird_y(bird_y),
        .pipe_x(pipe_x),
        .gap_y(gap_y),
        .pipe_style(pipe_style),
        .game_over(game_over),
        .hsync(hsync),
        .vsync(vsync),
        .r(r), .g(g), .b(b)
    );

endmodule
