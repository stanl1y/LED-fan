module output_generater(
    input wire[4:0] state,
    input wire[511:0] key_down,
    input wire[8:0] last_change,
    input wire been_ready,
    input wire clk,
    input wire rst,
    output reg [15:0] led,
    output wire[3:0] clockstate_led
);
    wire[15:0] word_led,clock_led,showoff_led,setting_led;
    parameter word_p = 0;
    parameter clock_p = 1;
    parameter showoff_p = 2;
    parameter setting_p = 3;
    //use+,-to control the frequency,in the begining the frequency is (0.00011s/degree)
    reg [26:0] freq,nxtfreq;
    always @(posedge clk) begin
        if (rst) begin
            freq<=27'd21600;
        end else begin
            freq<=nxtfreq; 
        end
    end
    always @(*) begin
        if (been_ready&&key_down[9'h55]) begin//+
            nxtfreq=freq-27'd100;
        end else if (been_ready&&key_down[9'h4E]) begin//-
            nxtfreq=freq+27'd100;
        end else if (been_ready&&key_down[9'h79]) begin
            nxtfreq=freq-27'd10; 
        end else if(been_ready&&key_down[9'h7B]) begin
            nxtfreq=freq+27'd10;
        end else if(been_ready&&key_down[9'h7C]) begin
            nxtfreq=freq<<1;
        end else if(been_ready&&(key_down[{1'b1,8'h4A}]||key_down[9'h4A])) begin
            nxtfreq=freq>>1;
        end else begin
            nxtfreq=freq; 
        end 
    end
    ///////////////
    wire fanclk;
    fan_clk fc(
        .clk(clk),
        .rst(rst),
        .freq(freq),
        .fanclk(fanclk)
    );

    clock m1(
        .clk(clk),
        .rst(rst),
        .state(state),
        .key_down(key_down),
        .been_ready(been_ready),
        .fanclk(fanclk),
        .led(clock_led),
        .clockstate_led(clockstate_led)
    );

    word m2(
        .clk(clk),
        .rst(rst),
        .key_down(key_down),
        .been_ready(been_ready),
        .last_change(last_change),
        .state(state),
        .fanclk(fanclk),
        .led(word_led)
    );
    showoff m3(
        .clk(clk),
        .rst(rst),
        .state(state),
        .fanclk(fanclk),
        .led(showoff_led)
    );

    setting m4(
        .clk(clk),
        .rst(rst),
        .fanclk(fanclk),
        .led(setting_led)
    );
    always@(*)begin
        case (state)
            word_p:begin
                led=word_led;
            end
            clock_p:begin
                led=clock_led;
            end
            showoff_p:begin
                led=showoff_led;
            end
            setting_p:begin
                led=setting_led;
            end
            default:led={16{1'b1}};
        endcase
    end
    
endmodule 

module fan_clk(
    input wire clk,
    input wire rst,
    input wire[26:0] freq,
    output wire fanclk
);
    reg[26:0] count,nxtcount;
    always @(posedge clk) begin
        if (rst) begin
            count<=0; 
        end else begin
            count<=nxtcount; 
        end
    end

    always @(*) begin
        if (count<freq-1) begin
            nxtcount=count+1; 
        end else begin
            nxtcount=0;
        end
    end
    assign fanclk=(count==0)?1:0;
endmodule // fan_clk