`timescale 1ns / 1ps
module spi_master #(
    parameter DATA_WIDTH = 16 // 16-bit data for ALS
) (
    input  logic        clk_100MHz,         // System clock
    input  logic        reset_n,           // Active low reset
    input  logic        spi_start,         // Signal to start SPI transfer
    input  logic        miso,              // Master-In-Slave-Out
    output logic        spi_done,          // Signal to indicate transfer done
    output logic        sclk,              // SPI clock
    output logic        cs_n,              // Chip select (active low)
    output logic [7:0] light_intensity     // Received data
);

    // Clock Divider (1 MHz SPI Clock)
    logic clk_div;
    logic [$clog2(50)-1:0] clk_count;

    always_ff @(posedge clk_100MHz or posedge reset_n) begin
        if (reset_n) begin
            clk_count <= 0;
            clk_div <= 1; // Idle high for CPOL = 1
        end else begin
            if (clk_count == 49) begin
                clk_div <= ~clk_div;   // Toggle clock
                clk_count <= 0;
            end else begin
                clk_count <= clk_count + 1;
            end
        end
    end

    assign sclk = clk_div; // Assign the divided clock to SCLK

    // SPI Transfer Logic
    logic [DATA_WIDTH-1:0] data_reg;
    logic [4:0] bit_cnt;
    logic transfer_active;
    logic [3:0] cs_delay_cnt;

    always_ff @(posedge clk_div or posedge reset_n) begin // Sample on rising edge for Mode 3
    if (reset_n) begin
        cs_delay_cnt <= 0;
        cs_n <= 1;             // Deactivate chip select
        bit_cnt <= 0;          // Reset bit counter
        transfer_active <= 0;  // Transfer inactive
        spi_done <= 0;         // Transfer not done
        data_reg <= 0;         // Clear data register
        light_intensity <= 8'hCF; // Default intensity
    end else begin
        if (spi_start && !transfer_active) begin
            if (cs_delay_cnt == 4) begin
                cs_n <= 0; // Activate chip select
                transfer_active <= 1;
                bit_cnt <= 0;
                spi_done <= 0;
            end else begin
                cs_delay_cnt <= cs_delay_cnt + 1;
            end
        end else if (transfer_active) begin
            // The key difference is here!
            if (!cs_n && bit_cnt < DATA_WIDTH) begin
                data_reg <= {data_reg[DATA_WIDTH-2:0], miso}; // Sample MISO on rising edge
                bit_cnt <= bit_cnt + 1;
            end

            if (bit_cnt == DATA_WIDTH - 1) begin
                transfer_active <= 0;
                cs_n <= 1;                 // Deactivate chip select
                spi_done <= 1;             // Indicate transfer done
                light_intensity <= data_reg[11:4]; // Extract meaningful ADC data
            end
        end else begin
            spi_done <= 0; // Clear done flag
        end
    end
end

endmodule
