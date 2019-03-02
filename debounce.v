module debunce(clk,unde,debunced);
    input clk,unde;
    output debunced;
    reg[3:0] tmp;
    always @(posedge clk) begin
        tmp[3:1]<=tmp[2:0];
        tmp[0]<=unde;
    end
    assign debunced=((tmp==4'b1111)?1'b1:1'b0);
endmodule // debunce