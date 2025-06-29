module fir_filter #(
    parameter N = 4,                  // Number of taps
    parameter WIDTH = 8,              // Input/coeff width
    parameter COEFF0 = 8'd2,          // Example coefficients
    parameter COEFF1 = 8'd1,
    parameter COEFF2 = 8'd1,
    parameter COEFF3 = 8'd2
) (
    input clk,
    input reset,
    input signed [WIDTH-1:0] x_in,
    output reg signed [2*WIDTH+1:0] y_out
);

    reg signed [WIDTH-1:0] shift_reg [0:N-1];
    integer i;

    // Shift register for input samples
    always @(posedge clk or posedge reset) begin
        if (reset) begin
            for (i=0; i<N; i=i+1)
                shift_reg[i] <= 0;
        end else begin
            shift_reg[0] <= x_in;
            for (i=1; i<N; i=i+1)
                shift_reg[i] <= shift_reg[i-1];
        end
    end

    // FIR computation
    always @(posedge clk or posedge reset) begin
        if (reset) begin
            y_out <= 0;
        end else begin
            y_out <= COEFF0*shift_reg[0] + COEFF1*shift_reg[1] +
                     COEFF2*shift_reg[2] + COEFF3*shift_reg[3];
        end
    end

endmodule
