`timescale 1ns / 1ps

module seg7_control (
    input  logic clk_100MHz,     // System clock
    input  logic reset_n,        // Active low reset
    input  logic [7:0] rec_data, // Input data to display (0-255)light intensity
    output logic [6:0] seg,      // Seven-segment display segments
    output logic [3:0] digit     // Digit select (anode control)
);

    // Digit values (hundreds, tens, ones)
    logic [3:0] x_100, x_10, x_1;
    logic [6:0] seg_raw;

    // Compute hundreds, tens, and ones digits
    always_comb begin
        x_100 = (rec_data / 100) % 10; // Compute hundreds digit
        x_10  = (rec_data / 10) % 10;  // Compute tens digit
        x_1   = rec_data % 10;         // Compute ones digit
    end

    // Parameters for segment patterns (Active LOW)
    parameter logic [6:0] ZERO  = 7'b0000001;  // 0
    parameter logic [6:0] ONE   = 7'b1001111;  // 1
    parameter logic [6:0] TWO   = 7'b0010010;  // 2 
    parameter logic [6:0] THREE = 7'b0000110;  // 3
    parameter logic [6:0] FOUR  = 7'b1001100;  // 4
    parameter logic [6:0] FIVE  = 7'b0100100;  // 5
    parameter logic [6:0] SIX   = 7'b0100000;  // 6
    parameter logic [6:0] SEVEN = 7'b0001111;  // 7
    parameter logic [6:0] EIGHT = 7'b0000000;  // 8
    parameter logic [6:0] NINE  = 7'b0000100;  // 9
    parameter logic [6:0] BLANK = 7'b1111111; // Blank display (all segments off)

    // To select each digit in turn
    logic [1:0] digit_select;     // 2-bit counter for selecting each of 4 digits
    logic [17:0] digit_timer;     // Counter for digit refresh

// Digit refresh logic with longer blanking phase
always_ff @(posedge clk_100MHz or posedge reset_n) begin
    if (reset_n) begin
        digit_select <= 2'b00;
        digit_timer <= 18'd0;
    end else begin
        if (digit_timer == 18'd149_999) begin   // 1.5ms total: 1ms active + 0.5ms blanking
            digit_timer <= 18'd0;
            digit_select <= digit_select + 1;
        end else begin
            digit_timer <= digit_timer + 1;
        end
    end
end

// Logic for digit enable with extended blanking phase
always_comb begin
    if (digit_timer < 17'd99_999) begin // Active phase: First 1ms
        case (digit_select)
            2'b00 : digit = 4'b1110; // Enable ones digit
            2'b01 : digit = 4'b1101; // Enable tens digit
            2'b10 : digit = 4'b1011; // Enable hundreds digit
            2'b11 : digit = 4'b0111; // Enable thousands digit (not used)
            default: digit = 4'b1111; // Safety: All off
        endcase
    end else begin
        digit = 4'b1111; // Blanking phase: Turn off all digits
    end
end


    // Segment selection logic
    always_comb begin
        if (reset_n) begin
            seg_raw = BLANK; // Blank display during reset
        end else begin
            case (digit_select)
                2'b00: case (x_1) // Ones digit
                    4'd0: seg_raw = ZERO;
                    4'd1: seg_raw = ONE;
                    4'd2: seg_raw = TWO;
                    4'd3: seg_raw = THREE;
                    4'd4: seg_raw = FOUR;
                    4'd5: seg_raw = FIVE;
                    4'd6: seg_raw = SIX;
                    4'd7: seg_raw = SEVEN;
                    4'd8: seg_raw = EIGHT;
                    4'd9: seg_raw = NINE;
                    default: seg_raw = BLANK;
                endcase
                2'b01: case (x_10) // Tens digit
                    4'd0: seg_raw = ZERO;
                    4'd1: seg_raw = ONE;
                    4'd2: seg_raw = TWO;
                    4'd3: seg_raw = THREE;
                    4'd4: seg_raw = FOUR;
                    4'd5: seg_raw = FIVE;
                    4'd6: seg_raw = SIX;
                    4'd7: seg_raw = SEVEN;
                    4'd8: seg_raw = EIGHT;
                    4'd9: seg_raw = NINE;
                    default: seg_raw = BLANK;
                endcase
                2'b10: case (x_100) // Hundreds digit
                    4'd0: seg_raw = ZERO;
                    4'd1: seg_raw = ONE;
                    4'd2: seg_raw = TWO;
                    4'd3: seg_raw = THREE;
                    4'd4: seg_raw = FOUR;
                    4'd5: seg_raw = FIVE;
                    4'd6: seg_raw = SIX;
                    4'd7: seg_raw = SEVEN;
                    4'd8: seg_raw = EIGHT;
                    4'd9: seg_raw = NINE;
                    default: seg_raw = BLANK;
                endcase
                default: seg_raw = BLANK;
            endcase
        end
    end

    assign seg = seg_raw; // Display the current digit when PWM is on

endmodule