`timescale 1ns / 1ps

module top (
    input  logic        clk_100MHz, // System clock
    input  logic        reset_n,    // Active low reset
    output logic [0:6]  seg,        // Seven-segment display segments
    output logic [3:0]  digit,      // Digit select (anode control)
    output logic        sclk,       // SPI clock
    input  logic        miso,       // SPI MISO
    output logic        cs_n        // SPI chip select
);

    // Internal Signals
    logic spi_start, spi_done;
    logic [15:0] light_data;
    logic pwm_out;

    // SPI Master (reads light intensity from Pmod ALS)
    spi_master spi_inst (
        .clk_100MHz(clk_100MHz),
        .reset_n(reset_n),
        .spi_start(spi_start),
        .miso(miso),
        .spi_done(spi_done), //output
        .sclk(sclk), //output
        .cs_n(cs_n),  //output
        .light_intensity(light_data) // output Captures light intensity data
    );

    // Seven-Segment Display Control
    seg7_control seg7_inst (
        .clk_100MHz(clk_100MHz),   //input
        .reset_n(reset_n),            //input
        .rec_data(light_data[7:0]), // inputUse LSB of light data for display
        .seg(seg),                  // Output to seven-segment segments
        .digit(digit)               // Output to anodes (digit select)
    );

    // SPI Control Logic
logic spi_start_reg;  // Internal register for spi_start
logic spi_init;       // Initialization flag to start the first transaction

always_ff @(posedge clk_100MHz or posedge reset_n) begin
    if (reset_n) begin
        spi_start_reg <= 0;
        spi_init <= 1; // Set initialization flag on reset
    end else if (spi_done) begin
        spi_start_reg <= 1; // Trigger SPI start after a completed transaction
        spi_init <= 0; // Clear initialization flag
    end else begin
        spi_start_reg <= 0;
    end
end

assign spi_start = spi_start_reg || spi_init; // Start SPI if init is high or after spi_done


endmodule
