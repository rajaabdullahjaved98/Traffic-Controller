module TrafficControl(
    input wire reset,
    input wire clk,
    output wire l1_green,
    output wire l1_yellow,
    output wire l1_red,
    output wire l2_green,
    output wire l2_yellow,
    output wire l2_red,
    output wire l3_green,
    output wire l3_yellow,
    output wire l3_red,
    output wire l4_green,
    output wire l4_yellow,
    output wire l4_red
);

reg [3:0] state;
reg [4:0] counter;

parameter L1_G = 4'b0000;
parameter L1_Y = 4'b0001;
parameter L1_R = 4'b0010;
parameter L2_G = 4'b0011;
parameter L2_Y = 4'b0100;
parameter L2_R = 4'b0101;
parameter L3_G = 4'b0110;
parameter L3_Y = 4'b0111;
parameter L3_R = 4'b1000;
parameter L4_G = 4'b1001;
parameter L4_Y = 4'b1010;
parameter L4_R = 4'b1011;

always @(posedge clk or posedge reset) begin
    if (reset) begin
        state <= L1_R;
        counter <= 0;
    end else begin
        case (state)
            L1_G:
                if (counter < 30) begin
                    state <= L1_G;
                    counter <= counter + 1;
                end else begin
                    state <= L1_Y;
                    counter <= 0;
                end
            L1_Y:
                if (counter < 5) begin
                    state <= L1_Y;
                    counter <= counter + 1;
                end else begin
                    state <= L1_R;
                    counter <= 0;
                end
            L1_R:
                if (counter < 5) begin
                    state <= L1_R;
                    counter <= counter + 1;
                end else begin
                    state <= L2_G;
                    counter <= 0;
                end
            L2_G:
                if (counter < 20) begin
                    state <= L2_G;
                    counter <= counter + 1;
                end else begin
                    state <= L2_Y;
                    counter <= 0;
                end
            L2_Y:
                if (counter < 5) begin
                    state <= L2_Y;
                    counter <= counter + 1;
                end else begin
                    state <= L2_R;
                    counter <= 0;
                end
            L2_R:
                if (counter < 5) begin
                    state <= L2_R;
                    counter <= counter + 1;
                end else begin
                    state <= L3_G;
                    counter <= 0;
                end
            L3_G:
                if (counter < 30) begin
                    state <= L3_G;
                    counter <= counter + 1;
                end else begin
                    state <= L3_Y;
                    counter <= 0;
                end
            L3_Y:
                if (counter < 5) begin
                    state <= L3_Y;
                    counter <= counter + 1;
                end else begin
                    state <= L3_R;
                    counter <= 0;
                end
            L3_R:
                if (counter < 5) begin
                    state <= L3_R;
                    counter <= counter + 1;
                end else begin
                    state <= L4_G;
                    counter <= 0;
                end
            L4_G:
                if (counter < 20) begin
                    state <= L4_G;
                    counter <= counter + 1;
                end else begin
                    state <= L4_Y;
                    counter <= 0;
                end
            L4_Y:
                if (counter < 5) begin
                    state <= L4_Y;
                    counter <= counter + 1;
                end else begin
                    state <= L4_R;
                    counter <= 0;
                end
            L4_R:
                if (counter < 5) begin
                    state <= L4_R;
                    counter <= counter + 1;
                end else begin
                    state <= L1_G;
                    counter <= 0;
                end
        endcase
    end
end

assign l1_green = (state == L1_G);
assign l1_yellow = (state == L1_Y);
assign l1_red = (state == L1_R);
assign l2_green = (state == L2_G);
assign l2_yellow = (state == L2_Y);
assign l2_red = (state == L2_R);
assign l3_green = (state == L3_G);
assign l3_yellow = (state == L3_Y);
assign l3_red = (state == L3_R);
assign l4_green = (state == L4_G);
assign l4_yellow = (state == L4_Y);
assign l4_red = (state == L4_R);

endmodule

module TrafficControlTestbench;

reg reset;
reg clk;
wire l1_green;
wire l1_yellow;
wire l1_red;
wire l2_green;
wire l2_yellow;
wire l2_red;
wire l3_green;
wire l3_yellow;
wire l3_red;
wire l4_green;
wire l4_yellow;
wire l4_red;

TrafficControl dut(
    .reset(reset),
    .clk(clk),
    .l1_green(l1_green),
    .l1_yellow(l1_yellow),
    .l1_red(l1_red),
    .l2_green(l2_green),
    .l2_yellow(l2_yellow),
    .l2_red(l2_red),
    .l3_green(l3_green),
    .l3_yellow(l3_yellow),
    .l3_red(l3_red),
    .l4_green(l4_green),
    .l4_yellow(l4_yellow),
    .l4_red(l4_red)
);

initial begin
  $dumpfile("dump.vcd");
  $dumpvars(0,dut);
    reset = 1;
    clk = 0;
    #10;
    reset = 0;
    #100;
    $finish;
end

always begin
    #5;
    clk = ~clk;
end

endmodule

