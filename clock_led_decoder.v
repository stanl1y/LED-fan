module clock_led_decoder(
    input wire [3:0] hour,
    input wire [5:0] min,
    input wire [5:0] sec,
    input wire clk,
    input wire rst,
    input wire[511:0] key_down,
    input wire been_ready,
    input wire fanclk,
    output reg[15:0] led
);
    //this is the led table, each bit stands for the led is going to be light or dark per degree
    //there is only 12,3,6,9

    reg[9:0]  three_15=10'b1111111111;//3
    reg[9:0]  three_14=10'b1111111111;//3
    reg[9:0]  three_13=10'b1111111111;//3
    reg[9:0]  three_12=10'b1100110011;//3
    reg[9:0]  three_11=10'b1100110011;//3
    reg[9:0]  three_10=10'b1100110011;//3
    reg[9:0]  three_09=10'b1100110011;//3

    reg[9:0]  six_15=10'b1111111111;//6
    reg[9:0]  six_14=10'b1110000111;//6
    reg[9:0]  six_13=10'b1110000111;//6
    reg[9:0]  six_12=10'b1111111111;//6
    reg[9:0]  six_11=10'b0000000111;//6
    reg[9:0]  six_10=10'b0000000111;//6
    reg[9:0]  six_09=10'b1111111111;//6

    reg[9:0]  nine_15=10'b0000111111;//9
    reg[9:0]  nine_14=10'b0000111111;//9
    reg[9:0]  nine_13=10'b0001100011;//9
    reg[9:0]  nine_12=10'b0001100011;//9
    reg[9:0]  nine_11=10'b1111111111;//9
    reg[9:0]  nine_10=10'b1111111111;//9
    reg[9:0]  nine_09=10'b1111111111;//9

    reg[9:0]  twelve_15=10'b1100111111;//12
    reg[9:0]  twelve_14=10'b1100000011;//12
    reg[9:0]  twelve_13=10'b1100000011;//12
    reg[9:0]  twelve_12=10'b1100111111;//12
    reg[9:0]  twelve_11=10'b1100110000;//12
    reg[9:0]  twelve_10=10'b1100110000;//12
    reg[9:0]  twelve_09=10'b1100111111;//12

    reg[9:0] deg_counter,nxt_degcounter;
    always @(posedge clk) begin
        if (rst) begin
            deg_counter<=10'd360;///////
        end else begin
            deg_counter<=nxt_degcounter;
        end
    end

    always @(*) begin
        led[8:0]=9'b0;
        //counting the degree
        if(fanclk)begin
            if(deg_counter!=1)begin
                nxt_degcounter=deg_counter-1;
            end else begin
                nxt_degcounter=10'd360;///////
            end
        end else begin
            nxt_degcounter=deg_counter;
        end
        //////////////counting the degree
        
        //the clock
        if ((360>=deg_counter&&deg_counter>345)||(15>=deg_counter)) begin//12
            if (15>=deg_counter) begin
                led[15:9]={twelve_15[(9'd15-deg_counter)/3],twelve_14[(9'd15-deg_counter)/3],twelve_13[(9'd15-deg_counter)/3],twelve_12[(9'd15-deg_counter)/3],twelve_11[(9'd15-deg_counter)/3],twelve_10[(9'd15-deg_counter)/3],twelve_09[(9'd15-deg_counter)/3]};
            end else begin//deg_counter>345
                led[15:9]={twelve_15[5+(9'd360-deg_counter)/3],twelve_14[5+(9'd360-deg_counter)/3],twelve_13[5+(9'd360-deg_counter)/3],twelve_12[5+(9'd360-deg_counter)/3],twelve_11[5+(9'd360-deg_counter)/3],twelve_10[5+(9'd360-deg_counter)/3],twelve_09[5+(9'd360-deg_counter)/3]};
            end
            led[8]=1;
        end else if(285>=deg_counter&&deg_counter>255)begin//9
            led[8]=0;
            led[15:9]={nine_15[(9'd285-deg_counter)/3],nine_14[(9'd285-deg_counter)/3],nine_13[(9'd285-deg_counter)/3],nine_12[(9'd285-deg_counter)/3],nine_11[(9'd285-deg_counter)/3],nine_10[(9'd285-deg_counter)/3],nine_09[(9'd285-deg_counter)/3]};
        end else if(195>=deg_counter&&deg_counter>165)begin//6
            led[8]=0;
            led[15:9]={six_15[(9'd195-deg_counter)/3],six_14[(9'd195-deg_counter)/3],six_13[(9'd195-deg_counter)/3],six_12[(9'd195-deg_counter)/3],six_11[(9'd195-deg_counter)/3],six_10[(9'd195-deg_counter)/3],six_09[(9'd195-deg_counter)/3]};
        end else if(105>=deg_counter&&deg_counter>75)begin//3
            led[8]=0;
            led[15:9]={
                three_15[(9'd105-deg_counter)/3],
                three_14[(9'd105-deg_counter)/3],
                three_13[(9'd105-deg_counter)/3],
                three_12[(9'd105-deg_counter)/3],
                three_11[(9'd105-deg_counter)/3],
                three_10[(9'd105-deg_counter)/3],
                three_09[(9'd105-deg_counter)/3]
            };
        end else if(deg_counter==9'd30||deg_counter==9'd60||deg_counter==9'd120||deg_counter==9'd150||deg_counter==9'd210||deg_counter==9'd240||deg_counter==9'd300||deg_counter==9'd330) begin//the other number
            led[8]=0;
            led[15:9]={7'b1111000};
        end else begin
            led[8]=0;
            led[15:9]=7'b0;
        end
        //////////////the clock

        //the clock pointer
        if((hour*30+min/2+1)>=deg_counter&&deg_counter>=(hour*30+min/2-1)||(min*6+1)>=deg_counter&&deg_counter>=(min*6-1)||(sec*6+1)>=deg_counter&&deg_counter>=(sec*6-1))begin
            if((hour*30+min/2+1)>=deg_counter&&deg_counter>=(hour*30+min/2-1)) begin//hour pointer
                led[7:0]=8'b00000111;
            end else if((min*6+1)>=deg_counter&&deg_counter>=(min*6-1)) begin
                led[7:0]=8'b00011111; 
            end else if((sec*6+1)>=deg_counter&&deg_counter>=(sec*6-1)) begin
                led[7:0]=8'b11111111; 
            end else begin
                led[7:0]=8'b0;
            end
        end else begin
            led[7:0]=8'b0;
        end
        ////////////the clock pointer
    end
endmodule // clock_led_decoder

