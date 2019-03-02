module smile(rst,clk,led,fanclk);
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
/*

if(deg_counter<=30&&deg_counter>=40)begin//left eye
led[8:0]={9'b110000000};

end else if(deg_counter<=320&&deg_counter>=310)begin //right eye
led[8:0]={9'b110000000};
end else if(deg_counter<=225&&deg_counter>=135) begin//mouth
led[8:0]={9'b110000000};
end else begin
led[8:0]={9'b000000000};
end
if (deg_counter<=200&&deg_counter>=180)begin
led[15:9]={7'b0000111};
end else begin
led[15:9]={7'b0000000};
end*/

led[15:7]=9'b0;
led[1:0]=2'b0;

if(170<=deg_counter&&deg_counter<=190)begin//led 2
led[2]={1'b1};
end else begin
led[2]={1'b0};
end

if(311<=deg_counter&&deg_counter<=314)begin//led 6
led[6]={1'b1};
end else if(46<=deg_counter&&deg_counter<=51)begin
led[6]={1'b1};
end else if(170<=deg_counter&&deg_counter<=190)begin
led[6]={1'b1};
end else begin
led[6]={1'b0};
end

if(305<=deg_counter&&deg_counter<=320)begin//led 5
led[5]={1'b1};
end else if(40<=deg_counter&&deg_counter<=55)begin
led[5]={1'b1};
end else if(190<=deg_counter&&deg_counter<=210)begin
led[5]={1'b1};
end else if(150<=deg_counter&&deg_counter<=170)begin
led[5]={1'b1};
end else begin
led[5]={1'b0};
end



if(310<=deg_counter&&deg_counter<=315)begin//led 4
led[4]={1'b1};
end else if(45<=deg_counter&&deg_counter<=50)begin
led[4]={1'b1};
end else if(210<=deg_counter&&deg_counter<=230)begin
led[4]={1'b1};
end else if(130<=deg_counter&&deg_counter<=150)begin
led[4]={1'b1};
end else begin
led[4]=1'b0;
end


if(190<=deg_counter&&deg_counter<=210)begin//led 3
led[3]={1'b1};
end else if(150<=deg_counter&&deg_counter<=170)begin
led[3]={1'b1};
end else begin
led[3]={1'b0};
end

end
endmodule