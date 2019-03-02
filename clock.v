module clock(
    input wire clk,
    input wire rst,
    input wire[4:0] state,
    input wire[511:0] key_down,
    input wire been_ready,
    input wire fanclk,
    output wire[15:0] led,
    output wire[3:0] clockstate_led
);
    reg[3:0] hour,nxthour;
    reg[5:0] min,nxtmin,sec,nxtsec;
    reg[2:0] clkstate,nxtclkstate;
    clock_led_decoder m2(
        .hour(hour),
        .min(min),
        .sec(sec),
        .clk(clk),
        .rst(rst),
        .key_down(key_down),
        .been_ready(been_ready),
        .fanclk(fanclk),
        .led(led)
    );
    parameter running = 0;
    parameter rsthour = 1;
    parameter rstmin = 2;
    parameter rstsec = 3;
    wire onesec;
    assign clockstate_led=((clkstate==running)?4'b0001:((clkstate==rsthour)?4'b0010:((clkstate==rstmin)?4'b0100:((clkstate==rstsec)?4'b1000:4'b0000))));
    clk_divider m1(clk,rst,onesec);
    always @(posedge clk) begin
        if (rst||(state==1&&been_ready&&key_down[9'h2d])) begin//press "r" to reset
            hour<=0;
            min<=0;
            sec<=0;
            clkstate<=rsthour;
        end else begin
            hour<=nxthour;
            min<=nxtmin;
            sec<=nxtsec;
            clkstate<=nxtclkstate;
        end
    end
    always @(*) begin
        case (clkstate)
            running:begin
                if (onesec) begin
                    if (sec!=6'd59) begin
                        nxthour=hour;
                        nxtmin=min;
                        nxtsec=sec+1;
                    end else begin
                        nxtsec=0;
                        if(min!=6'd59)begin
                            nxtmin=min+1;
                            nxthour=hour; 
                        end else begin
                            nxtmin=0;
                            if(hour!=4'd11) begin
                                nxthour=hour+1; 
                            end else begin
                                nxthour=0; 
                            end
                        end
                    end
                end else begin
                    nxtsec=sec;
                    nxtmin=min;
                    nxthour=hour;
                end
                if (state==1&&been_ready&&key_down[9'h2d]) begin//r
                    nxtclkstate=rsthour;
                end else begin
                    nxtclkstate=running;
                end
            end 

            rsthour: begin
                nxtmin=min;
                nxtsec=sec;
                if(state==1&&been_ready&&(key_down[9'h5A]||key_down[{1'b1,8'h5A}]||key_down[9'h29]))begin//enter
                    nxtclkstate=rstmin;
                end else begin
                    nxtclkstate=rsthour;
                end
                if (state==1&&been_ready&&(key_down[9'h16]||key_down[9'h69])) begin//1
                    if(hour==0)begin
                        nxthour=1; 
                    end else begin
                        if(hour==1) begin
                            nxthour=4'd11; 
                        end else begin
                            nxthour=hour; 
                        end
                    end
                end else if (state==1&&been_ready&&(key_down[9'h1e]||key_down[9'h72])) begin//2
                    if(hour==0)begin
                        nxthour=4'd2; 
                    end else begin
                        if(hour==1) begin
                            nxthour=4'd0; 
                        end else begin
                            nxthour=hour; 
                        end
                    end
                end else begin
                    nxthour=hour;
                end

                if (state==1&&been_ready) begin
                    if(key_down[9'h26]||key_down[9'h7A])begin//3
                        nxthour=4'd3;
                    end else if(key_down[9'h25]||key_down[9'h7B])begin//4
                        nxthour=4'd4;
                    end else if(key_down[9'h2E]||key_down[9'h73])begin//5
                        nxthour=4'd5;
                    end else if(key_down[9'h36]||key_down[9'h74])begin//6
                        nxthour=4'd6;
                    end else if(key_down[9'h6C]||key_down[9'h3D])begin//7
                        nxthour=4'd7;
                    end else if(key_down[9'h3E]||key_down[9'h75])begin//8
                        nxthour=4'd8;
                    end else if(key_down[9'h46]||key_down[9'h7D])begin//9
                        nxthour=4'd9;
                    end else if(key_down[9'h45]||key_down[9'h70])begin//0
                        if (hour==1) begin
                            nxthour=4'd10;
                        end else begin
                            nxthour=0;
                        end
                    end else begin
                        nxthour=hour;
                    end
                end else begin
                    nxthour=hour;
                end
            end

            rstmin:begin
                nxthour=hour;
                nxtsec=sec;
                if (been_ready&&state==1) begin
                    if((key_down[9'h5a]||key_down[{1'h1,8'h5a}]||key_down[9'h29]))begin//enter
                        nxtclkstate=rstsec;
                    end else begin
                        nxtclkstate=rstmin;
                    end
                    if(key_down[9'h16]||key_down[9'h69])begin//1
                        if(min==0)begin
                            nxtmin=1; 
                        end else begin
                            if(min<6)begin
                                nxtmin=6'd10*min+1;
                            end else begin
                                nxtmin=min; 
                            end
                        end
                    end else if(key_down[9'h1e]||key_down[9'h72])begin//2
                        if(min==0)begin
                            nxtmin=2; 
                        end else begin
                            if(min<6)begin
                                nxtmin=6'd10*min+2;
                            end else begin
                                nxtmin=min; 
                            end
                        end
                    end else if(key_down[9'h26]||key_down[9'h7A])begin//3
                        if(min==0)begin
                            nxtmin=3; 
                        end else begin
                            if(min<6)begin
                                nxtmin=6'd10*min+3;
                            end else begin
                                nxtmin=min; 
                            end
                        end
                    end else if(key_down[9'h25]||key_down[9'h7B])begin//4
                        if(min==0)begin
                            nxtmin=4; 
                        end else begin
                            if(min<6)begin
                                nxtmin=6'd10*min+4;
                            end else begin
                                nxtmin=min; 
                            end
                        end
                    end else if(key_down[9'h2E]||key_down[9'h73])begin//5
                        if(min==0)begin
                            nxtmin=5; 
                        end else begin
                            if(min<6)begin
                                nxtmin=6'd10*min+5;
                            end else begin
                                nxtmin=min; 
                            end
                        end
                    end else if(key_down[9'h36]||key_down[9'h74])begin//6
                        if(min==0)begin
                            nxtmin=6; 
                        end else begin
                            if(min<6)begin
                                nxtmin=6'd10*min+6;
                            end else begin
                                nxtmin=min; 
                            end
                        end
                    end else if(key_down[9'h6C]||key_down[9'h3D])begin//7
                        if(min==0)begin
                            nxtmin=7; 
                        end else begin
                            if(min<6)begin
                                nxtmin=6'd10*min+7;
                            end else begin
                                nxtmin=min; 
                            end
                        end
                    end else if(key_down[9'h3E]||key_down[9'h75])begin//8
                        if(min==0)begin
                            nxtmin=8; 
                        end else begin
                            if(min<6)begin
                                nxtmin=6'd10*min+8;
                            end else begin
                                nxtmin=min; 
                            end
                        end
                    end else if(key_down[9'h46]||key_down[9'h7D])begin//9
                        if(min==0)begin
                            nxtmin=9; 
                        end else begin
                            if(min<6)begin
                                nxtmin=6'd10*min+9;
                            end else begin
                                nxtmin=min; 
                            end
                        end
                    end else if(key_down[9'h45]||key_down[9'h70])begin//0
                        if(min<6)begin
                            nxtmin=6'd10*min;
                        end else begin
                            nxtmin=min; 
                        end
                    end else begin
                        nxtmin=min; 
                    end
                end else begin
                    nxtmin=min; 
                end
            end

            rstsec:begin
                nxthour=hour;
                nxtmin=min;
                if (been_ready&&state==1) begin
                    if((key_down[9'h5a]||key_down[{1'h1,8'h5a}]||key_down[9'h29]))begin//enter
                        nxtclkstate=running;
                    end else begin
                        nxtclkstate=rstsec;
                    end
                    if(key_down[9'h16]||key_down[9'h69])begin//1
                        if(sec==0)begin
                            nxtsec=1; 
                        end else begin
                            if(sec<6)begin
                                nxtsec=6'd10*sec+1;
                            end else begin
                                nxtsec=sec; 
                            end
                        end
                    end else if(key_down[9'h1e]||key_down[9'h72])begin//2
                        if(sec==0)begin
                            nxtsec=2; 
                        end else begin
                            if(sec<6)begin
                                nxtsec=6'd10*sec+2;
                            end else begin
                                nxtsec=sec; 
                            end
                        end
                    end else if(key_down[9'h26]||key_down[9'h7A])begin//3
                        if(sec==0)begin
                            nxtsec=3; 
                        end else begin
                            if(sec<6)begin
                                nxtsec=6'd10*sec+3;
                            end else begin
                                nxtsec=sec; 
                            end
                        end
                    end else if(key_down[9'h25]||key_down[9'h7B])begin//4
                        if(sec==0)begin
                            nxtsec=4; 
                        end else begin
                            if(sec<6)begin
                                nxtsec=6'd10*sec+4;
                            end else begin
                                nxtsec=sec; 
                            end
                        end
                    end else if(key_down[9'h2E]||key_down[9'h73])begin//5
                        if(sec==0)begin
                            nxtsec=5; 
                        end else begin
                            if(sec<6)begin
                                nxtsec=6'd10*sec+5;
                            end else begin
                                nxtsec=sec; 
                            end
                        end
                    end else if(key_down[9'h36]||key_down[9'h74])begin//6
                        if(sec==0)begin
                            nxtsec=6; 
                        end else begin
                            if(sec<6)begin
                                nxtsec=6'd10*sec+6;
                            end else begin
                                nxtsec=sec; 
                            end
                        end
                    end else if(key_down[9'h6C]||key_down[9'h3D])begin//7
                        if(sec==0)begin
                            nxtsec=7; 
                        end else begin
                            if(sec<6)begin
                                nxtsec=6'd10*sec+7;
                            end else begin
                                nxtsec=sec; 
                            end
                        end
                    end else if(key_down[9'h3E]||key_down[9'h75])begin//8
                        if(sec==0)begin
                            nxtsec=8; 
                        end else begin
                            if(sec<6)begin
                                nxtsec=6'd10*sec+8;
                            end else begin
                                nxtsec=sec; 
                            end
                        end
                    end else if(key_down[9'h46]||key_down[9'h7D])begin//9
                        if(sec==0)begin
                            nxtsec=9; 
                        end else begin
                            if(sec<6)begin
                                nxtsec=6'd10*sec+9;
                            end else begin
                                nxtsec=sec; 
                            end
                        end
                    end else if(key_down[9'h45]||key_down[9'h70])begin//0
                        if(sec<6)begin
                            nxtsec=6'd10*sec;
                        end else begin
                            nxtsec=sec; 
                        end
                    end else begin
                        nxtsec=sec; 
                    end
                end else begin
                    nxtsec=sec; 
                end
            end
            default: begin
                nxthour=hour;
                nxtmin=min;
                nxtsec=sec;
                nxtclkstate=clkstate; 
            end
        endcase
    end
endmodule // clock

module clk_divider(clk,rst,sec);
    input clk,rst;
    output sec;
    reg[27-1:0] tmp,nxttmp;
    reg sec,nxt_sec;
    always @(posedge clk) begin
        if(rst)begin
            sec<=1'b0;
            tmp<=1'b0;
        end else begin
            sec<=nxt_sec;
            tmp<=nxttmp;
        end
    end
    always@(*)begin
        nxttmp=(tmp==27'd100000000-1)?0:tmp+1;
        nxt_sec=(tmp==((27'd100000000)/2))?1:0;
    end
endmodule 