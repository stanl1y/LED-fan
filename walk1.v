module walk1(rst,clk,led,fanclk);
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

    led[15:10]=6'b0;

///////////////////
    if((deg_counter==160)||(deg_counter==200)||(deg_counter==360))begin//led 0~2
        led[2:0]={3'b111};
    end else begin
        led[2:0]=3'b0;
    end

    if((deg_counter==160)||(deg_counter==200)||(deg_counter==360)||(deg_counter==335)||(deg_counter==25))begin//led 3
        led[3]={1'b1};
    end else begin
        led[3]=1'b0;
    end
//////////////
    if((deg_counter==160)||(deg_counter==200)||(deg_counter==320)||(deg_counter==40))begin//led 4
    led[4]={1'b1};
    end else if(deg_counter>=350||deg_counter<=10)begin
    led[4]={1'b1};
    end else begin
    led[4]=1'b0;
    end

    if((deg_counter==160)||(deg_counter==200)||(deg_counter==310)||(deg_counter==50))begin//led 5
    led[5]={1'b1};
    end else if(deg_counter>=345||deg_counter<=15)begin
    led[5]={1'b1};
    end else begin
    led[5]=1'b0;
    end

    if((deg_counter==160)||(deg_counter==200)||(deg_counter==303)||(deg_counter==57))begin//led 6
    led[6]={1'b1};
    end else if(deg_counter>=345||deg_counter<=15)begin
    led[6]={1'b1};
    end else begin
    led[6]=1'b0;
    end


    /*if((deg_counter==160)||(deg_counter==200)||(deg_counter==300)||(deg_counter==60))begin//led 7!!!!!!!!!!!!--->15
    led[15]={1'b1};
    end else if(deg_counter>=345||deg_counter<=15)begin
    led[15]={1'b1};
    end else begin
    led[15]=1'b0;
    end*/

    if(deg_counter>=350||deg_counter<=10)begin//led 8
    led[8]={1'b1};
    end else if(deg_counter>=200&&deg_counter<=205)begin
    led[8]={1'b1};
    end else if(deg_counter>=155&&deg_counter<=160)begin
    led[8]={1'b1};
    end else if(deg_counter>=298&&deg_counter<=304)begin
    led[8]={1'b1};
    end else if(deg_counter>=56&&deg_counter<=62)begin
    led[8]={1'b1};
    end else begin
    led[8]=1'b0;
    end
//////////////
    if(deg_counter==300)begin//ball on right hand
        led[9]={1'b1};
    end else begin
        led[9]=1'b0;
    end
//////////////



    end
endmodule
