module setting(
    input clk,
    input rst,
    input fanclk,
    output reg[15:0] led 
);
    reg[8:0] deg_count,nxt_degcount;
    always@(posedge clk)begin
        if(rst)begin
            deg_count<=9'd360; 
        end else begin
            deg_count<=nxt_degcount; 
        end
    end
    
    always @(*) begin
        if(fanclk) begin
            if (deg_count) begin
                if (deg_count>1) begin
                    nxt_degcount=deg_count-1; 
                end else begin
                    nxt_degcount=9'd360;
                end
            end
        end else begin
            nxt_degcount=deg_count; 
        end

        if (deg_count==9'd360) begin
            led={16{1'b1}};
        end else begin
            led[15:0]=0; 
        end
    end
endmodule // steeing