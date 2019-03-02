module dim(
    input clk,
    input rst,
    input [15:0]faceled,
    output reg[15:0] led
);
    wire sec0_1;
    clk_divider_01s m1(clk,rst,sec0_1);
    reg[5:0] bounder,nxtbounder;
    reg[5:0] counter,nxtcounter;
    reg countstate,nxtcounter_state;
    parameter upper_bound = 30;
    parameter lower_bound = 0;
    parameter counterup = 1;
    parameter counterdown = 0;
    always@(posedge clk)begin
        if (rst) begin
            bounder<=lower_bound;     
            counter<=lower_bound;     
            countstate<=counterup;
        end else begin
            bounder<=nxtbounder;
            counter<=nxtcounter;
            countstate<=nxtcounter_state;
        end
    end
    always @(*) begin
        case (countstate)
            counterup:begin
                if (sec0_1) begin
                    if(bounder<upper_bound-1)begin
                        nxtbounder=bounder+1; 
                        nxtcounter_state=countstate;
                    end else begin
                        nxtbounder=bounder+1;
                        nxtcounter_state=counterdown;
                    end
                end else begin
                    nxtbounder=bounder;
                    nxtcounter_state=countstate;
                end
            end
            counterdown:begin
                if (sec0_1) begin//0<=bounder<50
                    if(bounder>lower_bound+1)begin
                        nxtbounder=bounder-1;
                        nxtcounter_state=countstate;
                    end else begin
                        nxtbounder=bounder-1;
                        nxtcounter_state=counterup;
                    end
                end else begin
                    nxtbounder=bounder;
                    nxtcounter_state=countstate;
                end
            end
            default:begin
                nxtbounder=bounder;
                nxtcounter_state=countstate;
            end
        endcase
        
        if (counter<upper_bound) begin
            nxtcounter=counter+1;
        end else begin
            nxtcounter=lower_bound; 
        end
        
        if (counter<=bounder) begin//////
            led=faceled;
        end else begin
            led=16'b0;
        end
    end
endmodule // dim

module clk_divider_01s(clk,rst,sec);
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
        nxttmp=(tmp==27'd5000000-1)?0:tmp+1;
        nxt_sec=(tmp==((27'd5000000)/2))?1:0;
    end
endmodule