module top_tb;

    logic clk_100MHz;
    logic reset_n;
    logic miso;
    logic [6:0] seg;
    logic [3:0] digit;
    logic sclk;
    logic cs_n;

    // Clock generation
    initial clk_100MHz = 0;
    always #5 clk_100MHz = ~clk_100MHz; // 100 MHz clock

    // Reset signal
    initial begin
        reset_n = 0;
        #50 reset_n = 1; // Release reset after 50 ns
    end

    // Instantiate the top module
    top uut (
        .clk_100MHz(clk_100MHz),
        .reset_n(reset_n),
        .miso(miso),
        .seg(seg),
        .digit(digit),
        .sclk(sclk),
        .cs_n(cs_n)
    );

    // SPI simulation
    initial begin
        miso = 0;
        // Provide a known SPI data pattern (e.g., 16'b0000_1100_1010_0000)
        #1000 miso = 1; // Simulate SPI behavior here
    end

    // Monitor signals
    initial begin
        $monitor("Time: %0t | seg: %b | digit: %b | sclk: %b | cs_n: %b", $time, seg, digit, sclk, cs_n);
    end

endmodule
