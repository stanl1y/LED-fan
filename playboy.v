module playboy(rst,clk,led,fanclk);
input rst,clk,fanclk;
output [15:0]led;

reg [8:0]deg_counter,nxtdeg_counter;
reg [15:0]led;
wire [15:0]dance1led,dance2led,walk1led,walk2led,walk3led,walk4led,walk5led,walk6led,walk7led,walk8led;
wire change,change2;
reg [3:0]state,nxtstate;
reg [9:0]change_counter,nxtchange;
parameter dance_1 = 0;
parameter dance_2 = 1;
parameter walk_1 = 2;
parameter walk_2 = 3;
parameter walk_3 = 4;
parameter walk_4 = 5;
parameter walk_5 = 6;
parameter walk_6 = 7;
parameter walk_7 = 8;
parameter walk_8 = 9;

 dance1  d1(
   .clk(clk),
   .rst(rst),
   .fanclk(fanclk),
   .led(dance1led)
); 
 dance2  d2(
  .clk(clk),
  .rst(rst),
  .fanclk(fanclk),
  .led(dance2led)
); 
 walk1  w1(
  .clk(clk),
  .rst(rst),
  .fanclk(fanclk),
  .led(walk1led)
); 
 walk2  w2(
  .clk(clk),
  .rst(rst),
  .fanclk(fanclk),
  .led(walk2led)
); 
walk3  w3(
  .clk(clk),
  .rst(rst),
  .fanclk(fanclk),
  .led(walk3led)
);
walk4  w4(
  .clk(clk),
  .rst(rst),
  .fanclk(fanclk),
  .led(walk4led)
);
walk5  w5(
  .clk(clk),
  .rst(rst),
  .fanclk(fanclk),
  .led(walk5led)
);
walk6  w6(
  .clk(clk),
  .rst(rst),
  .fanclk(fanclk),
  .led(walk6led)
);
walk7  w7(
  .clk(clk),
  .rst(rst),
  .fanclk(fanclk),
  .led(walk7led)
);
walk8  w8(
  .clk(clk),
  .rst(rst),
  .fanclk(fanclk),
  .led(walk8led)
);
clk_divider_05s bobo(clk,rst,change);
clk_divider_02s bobo2(clk,rst,change2);

always@(posedge clk)begin
if(rst)begin
change_counter<=0;
state<=dance_1;
end else begin
change_counter<=nxtchange;
state<=nxtstate;
end
end

always@(*)begin
case(state)
    dance_1:begin
    led=dance1led;
    if(change)begin
    if(change_counter==20)begin
    nxtchange=0;
    nxtstate=walk_1;//////////////////////////////
    end else begin
    nxtchange=change_counter+1;
    nxtstate=dance_2;
    end
    end else begin
    nxtchange=change_counter;
    nxtstate=state;
    end
  
    end
    
    dance_2:begin
    led=dance2led;
    if(change)begin
    if(change_counter==20)begin
    nxtchange=0;
    nxtstate=walk_1;///////////////////////////////////
    end else begin
    nxtchange=change_counter+1;
    nxtstate=dance_1;
    end
    end else begin
    nxtchange=change_counter;
    nxtstate=state;
    end
    end
    walk_1:begin
     led=walk1led;
     if(change2)begin
     if(change_counter==5)begin
     nxtchange=0;
     nxtstate=walk_2;//////////////////////////////
     end else begin
     nxtchange=change_counter+1;
     nxtstate=state;
     end
     end else begin
     nxtchange=change_counter;
     nxtstate=state;
     end
   
    end
    walk_2:begin
     led=walk2led;
       if(change2)begin
       nxtchange=0;
       nxtstate=walk_3;
       end else begin
       nxtchange=change_counter;
       nxtstate=state;
       end
    end
    
     walk_3:begin
        led=walk3led;
          if(change2)begin
          nxtchange=0;
          nxtstate=walk_4;
          end else begin
          nxtchange=change_counter;
          nxtstate=state;
          end
       end
       
       walk_4:begin
       led=walk4led;
         if(change2)begin
         nxtchange=0;
         nxtstate=walk_5;
         end else begin
         nxtchange=change_counter;
         nxtstate=state;
         end
      end
       walk_5:begin
          led=walk5led;
          if(change2)begin
          if(change_counter==5)begin
          nxtchange=0;
          nxtstate=walk_6;//////////////////////////////
          end else begin
          nxtchange=change_counter+1;
          nxtstate=state;
          end
          end else begin
          nxtchange=change_counter;
          nxtstate=state;
          end
        
         end
          walk_6:begin
               led=walk6led;
                 if(change2)begin
                 nxtchange=0;
                 nxtstate=walk_7;
                 end else begin
                 nxtchange=change_counter;
                 nxtstate=state;
                 end
              end
              
          walk_7:begin
             led=walk7led;
               if(change2)begin
               nxtchange=0;
               nxtstate=walk_8;
               end else begin
               nxtchange=change_counter;
               nxtstate=state;
               end
            end
            walk_8:begin
           led=walk8led;
             if(change2)begin
             nxtchange=0;
             nxtstate=walk_1;
             end else begin
             nxtchange=change_counter;
             nxtstate=state;
             end
          end
   

endcase


end

endmodule

module clk_divider_05s(clk,rst,sec);
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
        nxttmp=(tmp==27'd50000000-1)?0:tmp+1;
        nxt_sec=(tmp==((27'd50000000)/2))?1:0;
    end
endmodule

module clk_divider_02s(clk,rst,sec);
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
        nxttmp=(tmp==27'd20000000-1)?0:tmp+1;
        nxt_sec=(tmp==((27'd20000000)/2))?1:0;
    end
endmodule
