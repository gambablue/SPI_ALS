`timescale 1ns / 1ps

module pwm_generator (
    input  logic        clk_100MHz,        // System clock
    input  logic        reset_n,    // Active low reset
    input  logic [7:0] duty_cycle, // PWM duty cycle (light intensity)
    output logic        pwm_out     // PWM output
);

    logic [7:0] counter; // Counter for PWM generation

    always_ff @(posedge clk_100MHz or posedge reset_n) begin
        if (reset_n) begin
            counter <= 0;
            pwm_out <= 0;
        end else begin
            counter <= counter + 1;
            pwm_out <= (counter < duty_cycle) ? 1 : 0; // Adjust brightness
        end
    end
endmodule

