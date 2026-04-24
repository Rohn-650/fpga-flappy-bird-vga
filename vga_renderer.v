module vga_renderer (
    input  wire clk25,
    input  wire [9:0] bird_y,
    input  wire [9:0] pipe_x,
    input  wire [9:0] gap_y,
    input  wire pipe_style,
    input  wire game_over,
    output reg hsync, output reg vsync,
    output reg [3:0] r, g, b
);

    reg [9:0] h_cnt = 0; 
    reg [9:0] v_cnt = 0;

    always @(posedge clk25) begin
        if (h_cnt == 799) begin 
            h_cnt <= 0; 
            v_cnt <= (v_cnt == 524) ? 0 : v_cnt + 1; 
        end else h_cnt <= h_cnt + 1;
    end

    wire active = (h_cnt < 640 && v_cnt < 480);

    always @(posedge clk25) begin
        vsync <= ~(v_cnt >= 490 && v_cnt < 492);
        hsync <= ~(h_cnt >= 656 && h_cnt < 752);
    end

    // ===============================
    // BIRD SHAPE (body + eye)
    // ===============================
    wire bird_body = (h_cnt >= 100 && h_cnt < 116 &&
                      v_cnt >= bird_y && v_cnt < bird_y + 16);

    wire bird_eye = (h_cnt >= 110 && h_cnt < 114 &&
                     v_cnt >= bird_y + 4 && v_cnt < bird_y + 8);

    // ===============================
    // PIPE BODY
    // ===============================
    wire pipe_main = (h_cnt >= pipe_x && h_cnt < pipe_x + 40) &&
                     (v_cnt < gap_y || v_cnt > gap_y + 130);

    // pipe caps (top + bottom)
    wire pipe_cap_top = (h_cnt >= pipe_x - 4 && h_cnt < pipe_x + 44 &&
                         v_cnt >= gap_y - 10 && v_cnt < gap_y);

    wire pipe_cap_bot = (h_cnt >= pipe_x - 4 && h_cnt < pipe_x + 44 &&
                         v_cnt >= gap_y + 130 && v_cnt < gap_y + 140);

    // optional alternate style (thin pipe)
    wire pipe_alt = pipe_style &&
                    (h_cnt >= pipe_x + 10 && h_cnt < pipe_x + 30) &&
                    (v_cnt < gap_y || v_cnt > gap_y + 130);

    // ===============================
    // GROUND
    // ===============================
    wire ground = (v_cnt > 460);

    // ===============================
    // COLOR OUTPUT
    // ===============================
    always @(posedge clk25) begin
        if (!active)
            {r,g,b} <= 12'h000;

        else if (ground)
            {r,g,b} <= 12'h840;   // brown ground

        else if (bird_eye)
            {r,g,b} <= 12'hFFF;   // white eye

        else if (bird_body)
            {r,g,b} <= game_over ? 12'hF00 : 12'hFF0;

        else if (pipe_cap_top || pipe_cap_bot)
            {r,g,b} <= 12'h0A0;   // darker cap

        else if (pipe_style ? pipe_alt : pipe_main)
            {r,g,b} <= 12'h0F0;

        else
            {r,g,b} <= 12'h0BF;   // sky

    end
endmodule