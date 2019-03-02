module state_selector(
    input wire[511:0] key_down,
    input wire been_ready,
    input wire clk,
    input wire rst,
    output reg[4:0] state
);
    parameter word = 0;
    parameter clock = 1;
    parameter showoff = 2;
    parameter setting = 3;
    reg [4:0] nxtstate;
    always @(posedge clk) begin
        if(rst)begin
            state<=showoff;
        end else begin
            state<=nxtstate; 
        end
    end
    always @(*) begin
        if(been_ready)  begin
            case (state)
                word: begin
                    if (key_down[9'h76]) begin
                        nxtstate=showoff;
                    end else begin
                        nxtstate=state; 
                    end
                end
                clock: begin
                    if (key_down[9'h76]) begin
                        nxtstate=showoff;
                    end else begin
                        nxtstate=state; 
                    end
                end
                setting: begin
                    if (key_down[9'h76]) begin
                        nxtstate=showoff;
                    end else begin
                        nxtstate=state; 
                    end
                end
                showoff: begin
                    if (key_down[9'h16]||key_down[9'h69]) begin//1 word
                        nxtstate=word;
                    end else if(key_down[9'h1E]||key_down[9'h72]) begin//2
                        nxtstate=clock;
                    end else if (key_down[9'h1B]) begin//S
                        nxtstate=setting;
                    end else begin
                        nxtstate=state; 
                    end
                end
            endcase
        end else begin
            nxtstate=state; 
        end
    end
endmodule // state_selector