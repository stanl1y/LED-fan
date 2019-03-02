module cute(rst,clk,led,fanclk);
input rst,clk,fanclk;
output [15:0]led;

reg [8:0]deg_counter,nxtdeg_counter;
reg [15:0]led;


always@(posedge clk)begin
if(rst)begin
deg_counter<=360;
end else begin
deg_counter<=nxtdeg_counter;

end


end

always@(*)begin
if(fanclk)begin
if(deg_counter!=1)nxtdeg_counter=deg_counter-1;
else nxtdeg_counter=360;
end else begin
nxtdeg_counter=deg_counter;
end



led[1:0]=2'b0;

if(170<=deg_counter&&deg_counter<=190)begin//led 2  ok
led[2]={1'b1};
end else begin
led[2]={1'b0};
end






if(165<=deg_counter&&deg_counter<=170)begin//led 3 ok
led[3]={1'b1};
end else if(190<=deg_counter&&deg_counter<=205)begin
led[3]={1'b1};
end else begin
led[3]={1'b0};
end



if(170<=deg_counter&&deg_counter<=190)begin//led 6
led[6]={1'b1};
end else if(59<=deg_counter&&deg_counter<=61)begin
led[6]={1'b1};
end else if(299<=deg_counter&&deg_counter<=301)begin
led[6]={1'b1};
end else begin
led[6]={1'b0};
end

if(165<=deg_counter&&deg_counter<=170)begin//led 5 ok
led[5]={1'b1};
end  else if(190<=deg_counter&&deg_counter<=202) begin
led[5]={1'b1};
end else if(52<=deg_counter&&deg_counter<=54)begin
led[5]={1'b1};
end else if(306<=deg_counter&&deg_counter<=308)begin
led[5]={1'b1};
end else begin
led[5]={1'b0};
end

if(185<=deg_counter&&deg_counter<=200)begin//led 4 ok
led[4]={1'b1};
end else if(44<=deg_counter&&deg_counter<=46)begin
led[4]={1'b1};
end else if(314<=deg_counter&&deg_counter<=316)begin
led[4]={1'b1};
end else begin
led[4]={1'b0};
end

if(269<=deg_counter&&deg_counter<=271)begin
led[15:7]={9'b001010100};
end else if(89<=deg_counter&&deg_counter<=91)begin
led[15:7]={9'b001010100};
end else begin
led[15:7]=9'b0;
end

end

endmodule
