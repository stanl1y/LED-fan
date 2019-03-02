module top(
    input clk,
    input rst,
    inout wire PS2_DATA,
    inout wire PS2_CLK,
    output wire[15:0] led
);
    wire [8:0] last_change;
    wire [511:0] key_down;
    wire been_ready;
    wire o_rst,de_rst;
    wire [4:0] state;
    wire [3:0] clockstate_led;
    debunce m1(clk,rst,de_rst);
    one_pulse m2(clk,de_rst,o_rst);
    KeyboardDecoder key_de (
      .key_down(key_down),
      .last_change(last_change),
      .key_valid(been_ready),
      .PS2_DATA(PS2_DATA),
      .PS2_CLK(PS2_CLK),
      .rst(o_rst),
      .clk(clk)
    );
    state_selector sta_sel(
        .key_down(key_down),
        .been_ready(been_ready),
        .clk(clk),
        .rst(o_rst),
        .state(state)
    );
    output_generater out_gen(
    .state(state),
    .key_down(key_down),
    .been_ready(been_ready),
    .last_change(last_change),
    .clk(clk),
    .rst(o_rst),
    .led(led),
    .clockstate_led(clockstate_led)
    );
endmodule // 