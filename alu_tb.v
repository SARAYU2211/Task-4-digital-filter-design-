module testbench_fir;

    reg clk, reset;
    reg signed [7:0] x_in;
    wire signed [17:0] y_out;

    fir_filter uut (
        .clk(clk),
        .reset(reset),
        .x_in(x_in),
        .y_out(y_out)
    );

    // Clock generation
    initial begin
        clk = 0;
        forever #5 clk = ~clk;
    end

    // Stimulus
    initial begin
        reset = 1; x_in = 0;
        #12; reset = 0;

        // Apply sample inputs
        #10 x_in = 8'd10;
        #10 x_in = 8'd20;
        #10 x_in = 8'd30;
        #10 x_in = 8'd40;
        #10 x_in = 8'd0;
        #10 x_in = 8'd0;
        #40;
        $finish;
    end

    // Monitor output
    initial begin
        $monitor("Time=%0t | x_in=%d | y_out=%d", $time, x_in, y_out);
    end

endmodule
