module showoff(
    input wire clk,
    input wire rst,
    input wire[4:0] state,
    input wire fanclk,
    output reg[15:0] led
);
    parameter state0 = 0;
    parameter state1 = 1;
    parameter state2 = 2;
    parameter state3 = 3;
    parameter state4 = 4;
    reg[3:0] showoff_state,nxtshowoff_state;
    reg[6:0] timer,nxttimer,tmp,nxttmp;//127s
    wire[15:0] dimled,smileled,dimsmileled,cuteled,playboyled;
    wire sec;
    clk_divider_1s m1(clk,rst,sec);
    dim dim1(
        .clk(clk),
        .rst(rst),
        .faceled({16{1'b1}}),
        .led(dimled)
    );
    dim dimsmile(
        .clk(clk),
        .rst(rst),
        .faceled(smileled),
        .led(dimsmileled)
    );
    smile m3(
        .clk(clk),
        .rst(rst),
        .fanclk(fanclk),
        .led(smileled)
    );
     cute  m4(
        .clk(clk),
        .rst(rst),
        .fanclk(fanclk),
        .led(cuteled)
    );    
    playboy  m5(
        .clk(clk),
        .rst(rst),
        .fanclk(fanclk),
        .led(playboyled)
    );    
    always @(posedge clk) begin
        if (rst) begin
            showoff_state<=state0;
            timer<=0;
            tmp<=0;
        end else begin
            showoff_state<=nxtshowoff_state;
            timer<=nxttimer;
            tmp<=nxttmp;
        end
    end
    always @(*) begin
        
        case (showoff_state)
            state0: begin
                led=dimled;
                nxttmp=tmp;
                if (timer==10) begin
                    if(sec)begin
                    nxttimer=0;
                    nxtshowoff_state=state1;
                    end else begin
                    nxttimer=timer;
                    nxtshowoff_state=showoff_state;
                    end
                end else begin
                if(sec)begin
                    nxttimer=timer+1;
                    nxtshowoff_state=showoff_state;
                end else begin
                    nxttimer=timer;
                    nxtshowoff_state=showoff_state;
                end
                    
                end
            end
            state1:begin
                led=dimsmileled;
                nxttmp=tmp;
               if (timer==10) begin
                    if(sec)begin
                    nxttimer=0;
                    nxtshowoff_state=state2;
                    end else begin
                    nxttimer=timer;
                    nxtshowoff_state=showoff_state;
                    end
                end else begin
                if(sec)begin
                    nxttimer=timer+1;
                    nxtshowoff_state=showoff_state;
                end else begin
                    nxttimer=timer;
                    nxtshowoff_state=showoff_state;
                end
                    
                end
                
                
            end
            state2:begin //smille 
                led=smileled;
                if(sec)begin
                    if(tmp==10)begin
                        nxtshowoff_state=state4;
                        nxttmp=0;
                        nxttimer=0;
                    end else begin
                        nxtshowoff_state=state3;
                        nxttmp=tmp+1;
                        nxttimer=0;
                    end
                end else begin
                    nxttmp=tmp;
                    nxtshowoff_state=showoff_state;
                    nxttimer=timer;
                end
            end
            state3:begin    //cute
                led=cuteled;
                if(sec)begin
                    if(tmp==10)begin
                        nxtshowoff_state=state4;
                        nxttimer=0;
                        nxttmp=0;
                    end else begin
                        nxtshowoff_state=state2;
                        nxttimer=0;
                        nxttmp=tmp+1;
                    end
                end else begin
                    nxtshowoff_state=showoff_state;
                    nxttimer=timer;
                    nxttmp=tmp;
                end
            end
            state4:begin
                nxtshowoff_state=state4;
                led=playboyled;
                nxttmp=tmp;
                nxttimer=timer;
            end
        endcase
    end
endmodule // showoff

module clk_divider_1s(clk,rst,sec);
    input clk,rst;
    output sec;
    reg[27-1:0] tmp,nxttmp;
    reg sec,nxt_sec;
    always @(posedge clk) begin
        if (rst) begin
            sec<=0;
            tmp<=0;
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