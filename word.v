module word(
    input wire clk,
    input wire rst,
    input wire[511:0] key_down,
    input wire[8:0] last_change,
    input wire been_ready,
    input wire[4:0] state,
    input wire fanclk,
    output reg[15:0] led
);
    reg [8:0]alp[14:0];
    reg[3:0] num,nxtnum;
    parameter key_state = 0;
    parameter show_state = 1;
    reg[1:0] word_state,nxt_wordstate;
    always @(posedge clk) begin
        if(rst||(state==0&&been_ready&&key_down[9'h66])) begin//press "backspace" to reset
            word_state<=key_state;
            num<=0;
        end else begin
            word_state<=nxt_wordstate; 
            num<=nxtnum;
        end
    end

    always @(*) begin
        case (word_state)
            key_state: begin
                if(state==0)begin
                    if(num<4'd15)begin
                        if (been_ready) begin
                            if (key_down[9'h5a]||key_down[{1'b1,8'h5a}]) begin//enter
                                nxt_wordstate=show_state;
                                nxtnum=num;
                            end else begin
                                if(key_down[9'h29]||key_down[9'h1c]||key_down[9'h32]||key_down[9'h21]||key_down[9'h23]||key_down[9'h24]||key_down[9'h2b]||key_down[9'h34]||key_down[9'h33]||key_down[9'h43]||key_down[9'h3b]||key_down[9'h42]||key_down[9'h4b]||key_down[9'h3a]||key_down[9'h31]||key_down[9'h44]||key_down[9'h4d]||key_down[9'h15]||key_down[9'h2d]||key_down[9'h1b]||key_down[9'h2c]||key_down[9'h3c]||key_down[9'h2a]||key_down[9'h1d]||key_down[9'h22]||key_down[9'h35]||key_down[9'h1a]) begin
                                    nxtnum=num+1;
                                    nxt_wordstate=word_state;
                                    alp[num]=last_change;
                                end else begin
                                    nxtnum=num;
                                    nxt_wordstate=word_state; 
                                end
                            end
                        end else begin
                            nxtnum=num;
                            nxt_wordstate=word_state;
                        end
                    end else begin
                        nxt_wordstate=show_state;
                        nxtnum=num;
                    end
                end else begin
                    nxtnum=num;
                    nxt_wordstate=word_state;
                end
            end

            show_state: begin//add something
                nxtnum=num;
                nxt_wordstate=word_state;
            end

            default: begin
                nxtnum=num;
                nxt_wordstate=word_state;
            end
        endcase 
    end

    ////////////////////
    //word_decoder
    reg[9:0]  a_15=10'b0001111000;
    reg[9:0]  a_14=10'b0011001100;
    reg[9:0]  a_13=10'b0110000110;
    reg[9:0]  a_12=10'b0110000110;
    reg[9:0]  a_11=10'b1111111111;
    reg[9:0]  a_10=10'b1100000011;
    reg[9:0]  a_09=10'b1100000011;

    reg[9:0]  b_15=10'b1111111110;
    reg[9:0]  b_14=10'b1100000111;
    reg[9:0]  b_13=10'b1100001110;
    reg[9:0]  b_12=10'b1111111100;
    reg[9:0]  b_11=10'b1100001110;
    reg[9:0]  b_10=10'b1100000111;
    reg[9:0]  b_09=10'b1111111110;

    reg[9:0]  c_15=10'b0011111110;
    reg[9:0]  c_14=10'b0111000111;
    reg[9:0]  c_13=10'b1110000000;
    reg[9:0]  c_12=10'b1100000000;
    reg[9:0]  c_11=10'b1110000000;
    reg[9:0]  c_10=10'b0111000111;
    reg[9:0]  c_09=10'b0011111110;

    reg[9:0]  d_15=10'b1111110000;
    reg[9:0]  d_14=10'b1100011100;
    reg[9:0]  d_13=10'b1100000110;
    reg[9:0]  d_12=10'b1100000011;
    reg[9:0]  d_11=10'b1100000110;
    reg[9:0]  d_10=10'b1100011100;
    reg[9:0]  d_09=10'b1111110000;

    reg[9:0]  e_15=10'b1111111111;
    reg[9:0]  e_14=10'b1100000000;
    reg[9:0]  e_13=10'b1100000000;
    reg[9:0]  e_12=10'b1111111111;
    reg[9:0]  e_11=10'b1100000000;
    reg[9:0]  e_10=10'b1100000000;
    reg[9:0]  e_09=10'b1111111111;

    reg[9:0]  f_15=10'b1111111111;
    reg[9:0]  f_14=10'b1100000000;
    reg[9:0]  f_13=10'b1100000000;
    reg[9:0]  f_12=10'b1111111111;
    reg[9:0]  f_11=10'b1100000000;
    reg[9:0]  f_10=10'b1100000000;
    reg[9:0]  f_09=10'b1100000000;

    reg[9:0]  g_15=10'b0111111111;
    reg[9:0]  g_14=10'b1110000110;
    reg[9:0]  g_13=10'b0111111110;
    reg[9:0]  g_12=10'b0011000000;
    reg[9:0]  g_11=10'b1111111111;
    reg[9:0]  g_10=10'b1110000111;
    reg[9:0]  g_09=10'b0111111111;

    reg[9:0]  h_15=10'b1100000011;
    reg[9:0]  h_14=10'b1100000011;
    reg[9:0]  h_13=10'b1110000111;
    reg[9:0]  h_12=10'b1111111111;
    reg[9:0]  h_11=10'b1110000111;
    reg[9:0]  h_10=10'b1100000011;
    reg[9:0]  h_09=10'b1100000011;

    reg[9:0]  i_15=10'b1111111111;
    reg[9:0]  i_14=10'b1111111111;
    reg[9:0]  i_13=10'b0000110000;
    reg[9:0]  i_12=10'b0000110000;
    reg[9:0]  i_11=10'b0000110000;
    reg[9:0]  i_10=10'b1111111111;
    reg[9:0]  i_09=10'b1111111111;

    reg[9:0]  j_15=10'b1111111111;
    reg[9:0]  j_14=10'b1111111111;
    reg[9:0]  j_13=10'b0000011000;
    reg[9:0]  j_12=10'b0000011000;
    reg[9:0]  j_11=10'b0000011000;
    reg[9:0]  j_10=10'b1110011000;
    reg[9:0]  j_09=10'b0111110000;

    reg[9:0]  k_15=10'b1100000111;
    reg[9:0]  k_14=10'b1100001110;
    reg[9:0]  k_13=10'b1100111000;
    reg[9:0]  k_12=10'b1111100000;
    reg[9:0]  k_11=10'b1100111000;
    reg[9:0]  k_10=10'b1100001110;
    reg[9:0]  k_09=10'b1100000111;

    reg[9:0]  l_15=10'b1100000000;
    reg[9:0]  l_14=10'b1100000000;
    reg[9:0]  l_13=10'b1100000000;
    reg[9:0]  l_12=10'b1100000000;
    reg[9:0]  l_11=10'b1100000000;
    reg[9:0]  l_10=10'b1111111111;
    reg[9:0]  l_09=10'b1111111111;

    reg[9:0]  m_15=10'b1100000011;
    reg[9:0]  m_14=10'b1111001111;
    reg[9:0]  m_13=10'b1101111011;
    reg[9:0]  m_12=10'b1100110011;
    reg[9:0]  m_11=10'b1100000011;
    reg[9:0]  m_10=10'b1100000011;
    reg[9:0]  m_09=10'b1100000011;

    reg[9:0]  n_15=10'b1110000011;
    reg[9:0]  n_14=10'b1111000011;
    reg[9:0]  n_13=10'b1101100011;
    reg[9:0]  n_12=10'b1100110011;
    reg[9:0]  n_11=10'b1100011011;
    reg[9:0]  n_10=10'b1100001111;
    reg[9:0]  n_09=10'b1100000111;

    reg[9:0]  o_15=10'b0011111100;
    reg[9:0]  o_14=10'b0110000110;
    reg[9:0]  o_13=10'b1110000111;
    reg[9:0]  o_12=10'b1100000011;
    reg[9:0]  o_11=10'b1110000111;
    reg[9:0]  o_10=10'b0110000110;
    reg[9:0]  o_09=10'b0011111100;

    reg[9:0]  p_15=10'b1111111100;
    reg[9:0]  p_14=10'b1100001110;
    reg[9:0]  p_13=10'b1100000011;
    reg[9:0]  p_12=10'b1100001110;
    reg[9:0]  p_11=10'b1111111100;
    reg[9:0]  p_10=10'b1100000000;
    reg[9:0]  p_09=10'b1100000000;

    reg[9:0]  q_15=10'b0011111100;
    reg[9:0]  q_14=10'b0110000110;
    reg[9:0]  q_13=10'b1110000111;
    reg[9:0]  q_12=10'b1100000011;
    reg[9:0]  q_11=10'b1110110111;
    reg[9:0]  q_10=10'b0110011110;
    reg[9:0]  q_09=10'b0011111011;

    reg[9:0]  r_15=10'b1111111100;
    reg[9:0]  r_14=10'b1100000111;
    reg[9:0]  r_13=10'b1100000111;
    reg[9:0]  r_12=10'b1111111100;
    reg[9:0]  r_11=10'b1100011000;
    reg[9:0]  r_10=10'b1100001100;
    reg[9:0]  r_09=10'b1100000110;

    reg[9:0]  s_15=10'b0011111100;
    reg[9:0]  s_14=10'b0111000111;
    reg[9:0]  s_13=10'b1111000000;
    reg[9:0]  s_12=10'b0011110000;
    reg[9:0]  s_11=10'b00001110000;
    reg[9:0]  s_10=10'b1110001110;
    reg[9:0]  s_09=10'b00111111000;

    reg[9:0]  t_15=10'b1111111111;
    reg[9:0]  t_14=10'b1111111111;
    reg[9:0]  t_13=10'b0000110000;
    reg[9:0]  t_12=10'b0000110000;
    reg[9:0]  t_11=10'b0000110000;
    reg[9:0]  t_10=10'b0000110000;
    reg[9:0]  t_09=10'b0000110000;

    reg[9:0]  u_15=10'b1100000011;
    reg[9:0]  u_14=10'b1100000011;
    reg[9:0]  u_13=10'b1100000011;
    reg[9:0]  u_12=10'b1100000011;
    reg[9:0]  u_11=10'b1100000011;
    reg[9:0]  u_10=10'b1110000111;
    reg[9:0]  u_09=10'b0111111110;

    reg[9:0]  v_15=10'b1100000011;
    reg[9:0]  v_14=10'b1100000011;
    reg[9:0]  v_13=10'b0110000110;
    reg[9:0]  v_12=10'b0110000110;
    reg[9:0]  v_11=10'b0011001100;
    reg[9:0]  v_10=10'b0011001100;
    reg[9:0]  v_09=10'b0001111000;

    reg[9:0]  w_15=10'b1100110011;
    reg[9:0]  w_14=10'b1100110011;
    reg[9:0]  w_13=10'b1100110011;
    reg[9:0]  w_12=10'b1100110011;
    reg[9:0]  w_11=10'b1100110011;
    reg[9:0]  w_10=10'b0111111110;
    reg[9:0]  w_09=10'b0011001100;

    reg[9:0]  x_15=10'b1100000011;
    reg[9:0]  x_14=10'b0110000110;
    reg[9:0]  x_13=10'b0011001100;
    reg[9:0]  x_12=10'b0001111000;
    reg[9:0]  x_11=10'b0001111000;
    reg[9:0]  x_10=10'b0011001100;
    reg[9:0]  x_09=10'b1110000111;

    reg[9:0]  y_15=10'b1100000011;
    reg[9:0]  y_14=10'b1100000011;
    reg[9:0]  y_13=10'b0110000110;
    reg[9:0]  y_12=10'b0011111100;
    reg[9:0]  y_11=10'b0000110000;
    reg[9:0]  y_10=10'b0000110000;
    reg[9:0]  y_09=10'b0000110000;

    reg[9:0]  z_15=10'b1111111111;
    reg[9:0]  z_14=10'b1111111111;
    reg[9:0]  z_13=10'b0000000110;
    reg[9:0]  z_12=10'b0000011100;
    reg[9:0]  z_11=10'b0001110000;
    reg[9:0]  z_10=10'b1111111111;
    reg[9:0]  z_09=10'b1111111111;

    reg[9:0]  spa_15=10'b0000000000;
    reg[9:0]  spa_14=10'b0000000000;
    reg[9:0]  spa_13=10'b0000000000;
    reg[9:0]  spa_12=10'b0000000000;
    reg[9:0]  spa_11=10'b0000000000;
    reg[9:0]  spa_10=10'b0000000000;
    reg[9:0]  spa_09=10'b0000000000;

    reg[9:0] deg_counter,nxt_degcounter;
    reg[9:0] bias,nxtbias;
    wire sec01;
    clk_divider_01 m1(clk,rst,sec01);

    always @(posedge clk) begin
        if (rst) begin
            deg_counter<=10'd90;///////
            bias<=0;
        end else begin
            deg_counter<=nxt_degcounter;
            bias<=nxtbias;
        end
    end

    always @(*) begin
        if(fanclk)begin
            if(deg_counter!=10'd359)begin
                nxt_degcounter=deg_counter+1;
            end else begin
                nxt_degcounter=10'd0;///////
            end
        end else begin
            nxt_degcounter=deg_counter;
        end

        if (sec01) begin
            if ((bias<num*(10'd35)+10'd180)&&num!=0) begin
                nxtbias=bias+1;
            end else begin
                nxtbias=0; 
            end
        end else begin
            nxtbias=bias;
        end

        if(10'd180>=deg_counter&&deg_counter>=0)begin
            if(bias>=deg_counter)begin
                if (((bias-deg_counter)/35<=num-1)&&num!=0) begin
                    case (alp[((bias-deg_counter)/10'd35)])
                        9'h1c: begin//a
                            if((35-(bias-deg_counter)+(((bias-deg_counter)/35)*35))>=30)begin
                                led[15:9]=0;
                            end else begin
                                led[15:9]={
                                    a_15[(34-((bias-deg_counter)-(((bias-deg_counter)/35)*35)))/3],//34-(bias-deg_counter)%35
                                    a_14[(34-((bias-deg_counter)-(((bias-deg_counter)/35)*35)))/3],
                                    a_13[(34-((bias-deg_counter)-(((bias-deg_counter)/35)*35)))/3],
                                    a_12[(34-((bias-deg_counter)-(((bias-deg_counter)/35)*35)))/3],
                                    a_11[(34-((bias-deg_counter)-(((bias-deg_counter)/35)*35)))/3],
                                    a_10[(34-((bias-deg_counter)-(((bias-deg_counter)/35)*35)))/3],
                                    a_09[(34-((bias-deg_counter)-(((bias-deg_counter)/35)*35)))/3]
                                };
                            end
                        end
                        9'h32: begin//b
                            if((35-(bias-deg_counter)+(((bias-deg_counter)/35)*35))>=30)begin
                                led[15:9]=0; 
                            end else begin
                                led[15:9]={
                                    b_15[(34-((bias-deg_counter)-(((bias-deg_counter)/35)*35)))/3],//34-(bias-deg_counter)%35
                                    b_14[(34-((bias-deg_counter)-(((bias-deg_counter)/35)*35)))/3],
                                    b_13[(34-((bias-deg_counter)-(((bias-deg_counter)/35)*35)))/3],
                                    b_12[(34-((bias-deg_counter)-(((bias-deg_counter)/35)*35)))/3],
                                    b_11[(34-((bias-deg_counter)-(((bias-deg_counter)/35)*35)))/3],
                                    b_10[(34-((bias-deg_counter)-(((bias-deg_counter)/35)*35)))/3],
                                    b_09[(34-((bias-deg_counter)-(((bias-deg_counter)/35)*35)))/3]
                                };
                            end
                        end
                        9'h21: begin//b
                            if((35-(bias-deg_counter)+(((bias-deg_counter)/35)*35))>=30)begin
                                led[15:9]=0; 
                            end else begin
                                led[15:9]={
                                    c_15[(34-((bias-deg_counter)-(((bias-deg_counter)/35)*35)))/3],//34-(bias-deg_counter)%35
                                    c_14[(34-((bias-deg_counter)-(((bias-deg_counter)/35)*35)))/3],
                                    c_13[(34-((bias-deg_counter)-(((bias-deg_counter)/35)*35)))/3],
                                    c_12[(34-((bias-deg_counter)-(((bias-deg_counter)/35)*35)))/3],
                                    c_11[(34-((bias-deg_counter)-(((bias-deg_counter)/35)*35)))/3],
                                    c_10[(34-((bias-deg_counter)-(((bias-deg_counter)/35)*35)))/3],
                                    c_09[(34-((bias-deg_counter)-(((bias-deg_counter)/35)*35)))/3]
                                };
                            end
                        end
                        9'h23: begin//b
                            if((35-(bias-deg_counter)+(((bias-deg_counter)/35)*35))>=30)begin
                                led[15:9]=0; 
                            end else begin
                                led[15:9]={
                                    d_15[(34-((bias-deg_counter)-(((bias-deg_counter)/35)*35)))/3],//34-(bias-deg_counter)%35
                                    d_14[(34-((bias-deg_counter)-(((bias-deg_counter)/35)*35)))/3],
                                    d_13[(34-((bias-deg_counter)-(((bias-deg_counter)/35)*35)))/3],
                                    d_12[(34-((bias-deg_counter)-(((bias-deg_counter)/35)*35)))/3],
                                    d_11[(34-((bias-deg_counter)-(((bias-deg_counter)/35)*35)))/3],
                                    d_10[(34-((bias-deg_counter)-(((bias-deg_counter)/35)*35)))/3],
                                    d_09[(34-((bias-deg_counter)-(((bias-deg_counter)/35)*35)))/3]
                                };
                            end
                        end
                        9'h24: begin//b
                            if((35-(bias-deg_counter)+(((bias-deg_counter)/35)*35))>=30)begin
                                led[15:9]=0; 
                            end else begin
                                led[15:9]={
                                    e_15[(34-((bias-deg_counter)-(((bias-deg_counter)/35)*35)))/3],//34-(bias-deg_counter)%35
                                    e_14[(34-((bias-deg_counter)-(((bias-deg_counter)/35)*35)))/3],
                                    e_13[(34-((bias-deg_counter)-(((bias-deg_counter)/35)*35)))/3],
                                    e_12[(34-((bias-deg_counter)-(((bias-deg_counter)/35)*35)))/3],
                                    e_11[(34-((bias-deg_counter)-(((bias-deg_counter)/35)*35)))/3],
                                    e_10[(34-((bias-deg_counter)-(((bias-deg_counter)/35)*35)))/3],
                                    e_09[(34-((bias-deg_counter)-(((bias-deg_counter)/35)*35)))/3]
                                };
                            end
                        end
                        9'h2b: begin//b
                            if((35-(bias-deg_counter)+(((bias-deg_counter)/35)*35))>=30)begin
                                led[15:9]=0; 
                            end else begin
                                led[15:9]={
                                    f_15[(34-((bias-deg_counter)-(((bias-deg_counter)/35)*35)))/3],//34-(bias-deg_counter)%35
                                    f_14[(34-((bias-deg_counter)-(((bias-deg_counter)/35)*35)))/3],
                                    f_13[(34-((bias-deg_counter)-(((bias-deg_counter)/35)*35)))/3],
                                    f_12[(34-((bias-deg_counter)-(((bias-deg_counter)/35)*35)))/3],
                                    f_11[(34-((bias-deg_counter)-(((bias-deg_counter)/35)*35)))/3],
                                    f_10[(34-((bias-deg_counter)-(((bias-deg_counter)/35)*35)))/3],
                                    f_09[(34-((bias-deg_counter)-(((bias-deg_counter)/35)*35)))/3]
                                };
                            end
                        end
                        9'h34: begin//b
                            if((35-(bias-deg_counter)+(((bias-deg_counter)/35)*35))>=30)begin
                                led[15:9]=0; 
                            end else begin
                                led[15:9]={
                                    g_15[(34-((bias-deg_counter)-(((bias-deg_counter)/35)*35)))/3],//34-(bias-deg_counter)%35
                                    g_14[(34-((bias-deg_counter)-(((bias-deg_counter)/35)*35)))/3],
                                    g_13[(34-((bias-deg_counter)-(((bias-deg_counter)/35)*35)))/3],
                                    g_12[(34-((bias-deg_counter)-(((bias-deg_counter)/35)*35)))/3],
                                    g_11[(34-((bias-deg_counter)-(((bias-deg_counter)/35)*35)))/3],
                                    g_10[(34-((bias-deg_counter)-(((bias-deg_counter)/35)*35)))/3],
                                    g_09[(34-((bias-deg_counter)-(((bias-deg_counter)/35)*35)))/3]
                                };
                            end
                        end
                        9'h33: begin//b
                            if((35-(bias-deg_counter)+(((bias-deg_counter)/35)*35))>=30)begin
                                led[15:9]=0; 
                            end else begin
                                led[15:9]={
                                    h_15[(34-((bias-deg_counter)-(((bias-deg_counter)/35)*35)))/3],//34-(bias-deg_counter)%35
                                    h_14[(34-((bias-deg_counter)-(((bias-deg_counter)/35)*35)))/3],
                                    h_13[(34-((bias-deg_counter)-(((bias-deg_counter)/35)*35)))/3],
                                    h_12[(34-((bias-deg_counter)-(((bias-deg_counter)/35)*35)))/3],
                                    h_11[(34-((bias-deg_counter)-(((bias-deg_counter)/35)*35)))/3],
                                    h_10[(34-((bias-deg_counter)-(((bias-deg_counter)/35)*35)))/3],
                                    h_09[(34-((bias-deg_counter)-(((bias-deg_counter)/35)*35)))/3]
                                };
                            end
                        end
                        9'h43: begin//b
                            if((35-(bias-deg_counter)+(((bias-deg_counter)/35)*35))>=30)begin
                                led[15:9]=0; 
                            end else begin
                                led[15:9]={
                                    i_15[(34-((bias-deg_counter)-(((bias-deg_counter)/35)*35)))/3],//34-(bias-deg_counter)%35
                                    i_14[(34-((bias-deg_counter)-(((bias-deg_counter)/35)*35)))/3],
                                    i_13[(34-((bias-deg_counter)-(((bias-deg_counter)/35)*35)))/3],
                                    i_12[(34-((bias-deg_counter)-(((bias-deg_counter)/35)*35)))/3],
                                    i_11[(34-((bias-deg_counter)-(((bias-deg_counter)/35)*35)))/3],
                                    i_10[(34-((bias-deg_counter)-(((bias-deg_counter)/35)*35)))/3],
                                    i_09[(34-((bias-deg_counter)-(((bias-deg_counter)/35)*35)))/3]
                                };
                            end
                        end
                        9'h3b: begin//b
                            if((35-(bias-deg_counter)+(((bias-deg_counter)/35)*35))>=30)begin
                                led[15:9]=0; 
                            end else begin
                                led[15:9]={
                                    j_15[(34-((bias-deg_counter)-(((bias-deg_counter)/35)*35)))/3],//34-(bias-deg_counter)%35
                                    j_14[(34-((bias-deg_counter)-(((bias-deg_counter)/35)*35)))/3],
                                    j_13[(34-((bias-deg_counter)-(((bias-deg_counter)/35)*35)))/3],
                                    j_12[(34-((bias-deg_counter)-(((bias-deg_counter)/35)*35)))/3],
                                    j_11[(34-((bias-deg_counter)-(((bias-deg_counter)/35)*35)))/3],
                                    j_10[(34-((bias-deg_counter)-(((bias-deg_counter)/35)*35)))/3],
                                    j_09[(34-((bias-deg_counter)-(((bias-deg_counter)/35)*35)))/3]
                                };
                            end
                        end
                        9'h42: begin//b
                            if((35-(bias-deg_counter)+(((bias-deg_counter)/35)*35))>=30)begin
                                led[15:9]=0; 
                            end else begin
                                led[15:9]={
                                    k_15[(34-((bias-deg_counter)-(((bias-deg_counter)/35)*35)))/3],//34-(bias-deg_counter)%35
                                    k_14[(34-((bias-deg_counter)-(((bias-deg_counter)/35)*35)))/3],
                                    k_13[(34-((bias-deg_counter)-(((bias-deg_counter)/35)*35)))/3],
                                    k_12[(34-((bias-deg_counter)-(((bias-deg_counter)/35)*35)))/3],
                                    k_11[(34-((bias-deg_counter)-(((bias-deg_counter)/35)*35)))/3],
                                    k_10[(34-((bias-deg_counter)-(((bias-deg_counter)/35)*35)))/3],
                                    k_09[(34-((bias-deg_counter)-(((bias-deg_counter)/35)*35)))/3]
                                };
                            end
                        end
                        9'h4b: begin//b
                            if((35-(bias-deg_counter)+(((bias-deg_counter)/35)*35))>=30)begin
                                led[15:9]=0; 
                            end else begin
                                led[15:9]={
                                    l_15[(34-((bias-deg_counter)-(((bias-deg_counter)/35)*35)))/3],//34-(bias-deg_counter)%35
                                    l_14[(34-((bias-deg_counter)-(((bias-deg_counter)/35)*35)))/3],
                                    l_13[(34-((bias-deg_counter)-(((bias-deg_counter)/35)*35)))/3],
                                    l_12[(34-((bias-deg_counter)-(((bias-deg_counter)/35)*35)))/3],
                                    l_11[(34-((bias-deg_counter)-(((bias-deg_counter)/35)*35)))/3],
                                    l_10[(34-((bias-deg_counter)-(((bias-deg_counter)/35)*35)))/3],
                                    l_09[(34-((bias-deg_counter)-(((bias-deg_counter)/35)*35)))/3]
                                };
                            end
                        end
                        9'h3a: begin//b
                            if((35-(bias-deg_counter)+(((bias-deg_counter)/35)*35))>=30)begin
                                led[15:9]=0; 
                            end else begin
                                led[15:9]={
                                    m_15[(34-((bias-deg_counter)-(((bias-deg_counter)/35)*35)))/3],//34-(bias-deg_counter)%35
                                    m_14[(34-((bias-deg_counter)-(((bias-deg_counter)/35)*35)))/3],
                                    m_13[(34-((bias-deg_counter)-(((bias-deg_counter)/35)*35)))/3],
                                    m_12[(34-((bias-deg_counter)-(((bias-deg_counter)/35)*35)))/3],
                                    m_11[(34-((bias-deg_counter)-(((bias-deg_counter)/35)*35)))/3],
                                    m_10[(34-((bias-deg_counter)-(((bias-deg_counter)/35)*35)))/3],
                                    m_09[(34-((bias-deg_counter)-(((bias-deg_counter)/35)*35)))/3]
                                };
                            end
                        end
                        9'h31: begin//b
                            if((35-(bias-deg_counter)+(((bias-deg_counter)/35)*35))>=30)begin
                                led[15:9]=0; 
                            end else begin
                                led[15:9]={
                                    n_15[(34-((bias-deg_counter)-(((bias-deg_counter)/35)*35)))/3],//34-(bias-deg_counter)%35
                                    n_14[(34-((bias-deg_counter)-(((bias-deg_counter)/35)*35)))/3],
                                    n_13[(34-((bias-deg_counter)-(((bias-deg_counter)/35)*35)))/3],
                                    n_12[(34-((bias-deg_counter)-(((bias-deg_counter)/35)*35)))/3],
                                    n_11[(34-((bias-deg_counter)-(((bias-deg_counter)/35)*35)))/3],
                                    n_10[(34-((bias-deg_counter)-(((bias-deg_counter)/35)*35)))/3],
                                    n_09[(34-((bias-deg_counter)-(((bias-deg_counter)/35)*35)))/3]
                                };
                            end
                        end
                        9'h44: begin//b
                            if((35-(bias-deg_counter)+(((bias-deg_counter)/35)*35))>=30)begin
                                led[15:9]=0; 
                            end else begin
                                led[15:9]={
                                    o_15[(34-((bias-deg_counter)-(((bias-deg_counter)/35)*35)))/3],//34-(bias-deg_counter)%35
                                    o_14[(34-((bias-deg_counter)-(((bias-deg_counter)/35)*35)))/3],
                                    o_13[(34-((bias-deg_counter)-(((bias-deg_counter)/35)*35)))/3],
                                    o_12[(34-((bias-deg_counter)-(((bias-deg_counter)/35)*35)))/3],
                                    o_11[(34-((bias-deg_counter)-(((bias-deg_counter)/35)*35)))/3],
                                    o_10[(34-((bias-deg_counter)-(((bias-deg_counter)/35)*35)))/3],
                                    o_09[(34-((bias-deg_counter)-(((bias-deg_counter)/35)*35)))/3]
                                };
                            end
                        end
                        9'h4d: begin//b
                            if((35-(bias-deg_counter)+(((bias-deg_counter)/35)*35))>=30)begin
                                led[15:9]=0; 
                            end else begin
                                led[15:9]={
                                    p_15[(34-((bias-deg_counter)-(((bias-deg_counter)/35)*35)))/3],//34-(bias-deg_counter)%35
                                    p_14[(34-((bias-deg_counter)-(((bias-deg_counter)/35)*35)))/3],
                                    p_13[(34-((bias-deg_counter)-(((bias-deg_counter)/35)*35)))/3],
                                    p_12[(34-((bias-deg_counter)-(((bias-deg_counter)/35)*35)))/3],
                                    p_11[(34-((bias-deg_counter)-(((bias-deg_counter)/35)*35)))/3],
                                    p_10[(34-((bias-deg_counter)-(((bias-deg_counter)/35)*35)))/3],
                                    p_09[(34-((bias-deg_counter)-(((bias-deg_counter)/35)*35)))/3]
                                };
                            end
                        end
                        9'h15: begin//b
                            if((35-(bias-deg_counter)+(((bias-deg_counter)/35)*35))>=30)begin
                                led[15:9]=0; 
                            end else begin
                                led[15:9]={
                                    q_15[(34-((bias-deg_counter)-(((bias-deg_counter)/35)*35)))/3],//34-(bias-deg_counter)%35
                                    q_14[(34-((bias-deg_counter)-(((bias-deg_counter)/35)*35)))/3],
                                    q_13[(34-((bias-deg_counter)-(((bias-deg_counter)/35)*35)))/3],
                                    q_12[(34-((bias-deg_counter)-(((bias-deg_counter)/35)*35)))/3],
                                    q_11[(34-((bias-deg_counter)-(((bias-deg_counter)/35)*35)))/3],
                                    q_10[(34-((bias-deg_counter)-(((bias-deg_counter)/35)*35)))/3],
                                    q_09[(34-((bias-deg_counter)-(((bias-deg_counter)/35)*35)))/3]
                                };
                            end
                        end
                        9'h4d: begin//b
                            if((35-(bias-deg_counter)+(((bias-deg_counter)/35)*35))>=30)begin
                                led[15:9]=0; 
                            end else begin
                                led[15:9]={
                                    r_15[(34-((bias-deg_counter)-(((bias-deg_counter)/35)*35)))/3],//34-(bias-deg_counter)%35
                                    r_14[(34-((bias-deg_counter)-(((bias-deg_counter)/35)*35)))/3],
                                    r_13[(34-((bias-deg_counter)-(((bias-deg_counter)/35)*35)))/3],
                                    r_12[(34-((bias-deg_counter)-(((bias-deg_counter)/35)*35)))/3],
                                    r_11[(34-((bias-deg_counter)-(((bias-deg_counter)/35)*35)))/3],
                                    r_10[(34-((bias-deg_counter)-(((bias-deg_counter)/35)*35)))/3],
                                    r_09[(34-((bias-deg_counter)-(((bias-deg_counter)/35)*35)))/3]
                                };
                            end
                        end
                        9'h1b: begin//b
                            if((35-(bias-deg_counter)+(((bias-deg_counter)/35)*35))>=30)begin
                                led[15:9]=0; 
                            end else begin
                                led[15:9]={
                                    s_15[(34-((bias-deg_counter)-(((bias-deg_counter)/35)*35)))/3],//34-(bias-deg_counter)%35
                                    s_14[(34-((bias-deg_counter)-(((bias-deg_counter)/35)*35)))/3],
                                    s_13[(34-((bias-deg_counter)-(((bias-deg_counter)/35)*35)))/3],
                                    s_12[(34-((bias-deg_counter)-(((bias-deg_counter)/35)*35)))/3],
                                    s_11[(34-((bias-deg_counter)-(((bias-deg_counter)/35)*35)))/3],
                                    s_10[(34-((bias-deg_counter)-(((bias-deg_counter)/35)*35)))/3],
                                    s_09[(34-((bias-deg_counter)-(((bias-deg_counter)/35)*35)))/3]
                                };
                            end
                        end
                        9'h2c: begin//b
                            if((35-(bias-deg_counter)+(((bias-deg_counter)/35)*35))>=30)begin
                                led[15:9]=0; 
                            end else begin
                                led[15:9]={
                                    t_15[(34-((bias-deg_counter)-(((bias-deg_counter)/35)*35)))/3],//34-(bias-deg_counter)%35
                                    t_14[(34-((bias-deg_counter)-(((bias-deg_counter)/35)*35)))/3],
                                    t_13[(34-((bias-deg_counter)-(((bias-deg_counter)/35)*35)))/3],
                                    t_12[(34-((bias-deg_counter)-(((bias-deg_counter)/35)*35)))/3],
                                    t_11[(34-((bias-deg_counter)-(((bias-deg_counter)/35)*35)))/3],
                                    t_10[(34-((bias-deg_counter)-(((bias-deg_counter)/35)*35)))/3],
                                    t_09[(34-((bias-deg_counter)-(((bias-deg_counter)/35)*35)))/3]
                                };
                            end
                        end
                        9'h3c: begin//b
                            if((35-(bias-deg_counter)+(((bias-deg_counter)/35)*35))>=30)begin
                                led[15:9]=0; 
                            end else begin
                                led[15:9]={
                                    u_15[(34-((bias-deg_counter)-(((bias-deg_counter)/35)*35)))/3],//34-(bias-deg_counter)%35
                                    u_14[(34-((bias-deg_counter)-(((bias-deg_counter)/35)*35)))/3],
                                    u_13[(34-((bias-deg_counter)-(((bias-deg_counter)/35)*35)))/3],
                                    u_12[(34-((bias-deg_counter)-(((bias-deg_counter)/35)*35)))/3],
                                    u_11[(34-((bias-deg_counter)-(((bias-deg_counter)/35)*35)))/3],
                                    u_10[(34-((bias-deg_counter)-(((bias-deg_counter)/35)*35)))/3],
                                    u_09[(34-((bias-deg_counter)-(((bias-deg_counter)/35)*35)))/3]
                                };
                            end
                        end
                        9'h2a: begin//b
                            if((35-(bias-deg_counter)+(((bias-deg_counter)/35)*35))>=30)begin
                                led[15:9]=0; 
                            end else begin
                                led[15:9]={
                                    v_15[(34-((bias-deg_counter)-(((bias-deg_counter)/35)*35)))/3],//34-(bias-deg_counter)%35
                                    v_14[(34-((bias-deg_counter)-(((bias-deg_counter)/35)*35)))/3],
                                    v_13[(34-((bias-deg_counter)-(((bias-deg_counter)/35)*35)))/3],
                                    v_12[(34-((bias-deg_counter)-(((bias-deg_counter)/35)*35)))/3],
                                    v_11[(34-((bias-deg_counter)-(((bias-deg_counter)/35)*35)))/3],
                                    v_10[(34-((bias-deg_counter)-(((bias-deg_counter)/35)*35)))/3],
                                    v_09[(34-((bias-deg_counter)-(((bias-deg_counter)/35)*35)))/3]
                                };
                            end
                        end
                        9'h1d: begin//b
                            if((35-(bias-deg_counter)+(((bias-deg_counter)/35)*35))>=30)begin
                                led[15:9]=0; 
                            end else begin
                                led[15:9]={
                                    w_15[(34-((bias-deg_counter)-(((bias-deg_counter)/35)*35)))/3],//34-(bias-deg_counter)%35
                                    w_14[(34-((bias-deg_counter)-(((bias-deg_counter)/35)*35)))/3],
                                    w_13[(34-((bias-deg_counter)-(((bias-deg_counter)/35)*35)))/3],
                                    w_12[(34-((bias-deg_counter)-(((bias-deg_counter)/35)*35)))/3],
                                    w_11[(34-((bias-deg_counter)-(((bias-deg_counter)/35)*35)))/3],
                                    w_10[(34-((bias-deg_counter)-(((bias-deg_counter)/35)*35)))/3],
                                    w_09[(34-((bias-deg_counter)-(((bias-deg_counter)/35)*35)))/3]
                                };
                            end
                        end
                        9'h22: begin//b
                            if((35-(bias-deg_counter)+(((bias-deg_counter)/35)*35))>=30)begin
                                led[15:9]=0; 
                            end else begin
                                led[15:9]={
                                    x_15[(34-((bias-deg_counter)-(((bias-deg_counter)/35)*35)))/3],//34-(bias-deg_counter)%35
                                    x_14[(34-((bias-deg_counter)-(((bias-deg_counter)/35)*35)))/3],
                                    x_13[(34-((bias-deg_counter)-(((bias-deg_counter)/35)*35)))/3],
                                    x_12[(34-((bias-deg_counter)-(((bias-deg_counter)/35)*35)))/3],
                                    x_11[(34-((bias-deg_counter)-(((bias-deg_counter)/35)*35)))/3],
                                    x_10[(34-((bias-deg_counter)-(((bias-deg_counter)/35)*35)))/3],
                                    x_09[(34-((bias-deg_counter)-(((bias-deg_counter)/35)*35)))/3]
                                };
                            end
                        end
                        9'h35: begin//b
                            if((35-(bias-deg_counter)+(((bias-deg_counter)/35)*35))>=30)begin
                                led[15:9]=0; 
                            end else begin
                                led[15:9]={
                                    y_15[(34-((bias-deg_counter)-(((bias-deg_counter)/35)*35)))/3],//34-(bias-deg_counter)%35
                                    y_14[(34-((bias-deg_counter)-(((bias-deg_counter)/35)*35)))/3],
                                    y_13[(34-((bias-deg_counter)-(((bias-deg_counter)/35)*35)))/3],
                                    y_12[(34-((bias-deg_counter)-(((bias-deg_counter)/35)*35)))/3],
                                    y_11[(34-((bias-deg_counter)-(((bias-deg_counter)/35)*35)))/3],
                                    y_10[(34-((bias-deg_counter)-(((bias-deg_counter)/35)*35)))/3],
                                    y_09[(34-((bias-deg_counter)-(((bias-deg_counter)/35)*35)))/3]
                                };
                            end
                        end
                        9'h1a: begin//b
                            if((35-(bias-deg_counter)+(((bias-deg_counter)/35)*35))>=30)begin
                                led[15:9]=0; 
                            end else begin
                                led[15:9]={
                                    z_15[(34-((bias-deg_counter)-(((bias-deg_counter)/35)*35)))/3],//34-(bias-deg_counter)%35
                                    z_14[(34-((bias-deg_counter)-(((bias-deg_counter)/35)*35)))/3],
                                    z_13[(34-((bias-deg_counter)-(((bias-deg_counter)/35)*35)))/3],
                                    z_12[(34-((bias-deg_counter)-(((bias-deg_counter)/35)*35)))/3],
                                    z_11[(34-((bias-deg_counter)-(((bias-deg_counter)/35)*35)))/3],
                                    z_10[(34-((bias-deg_counter)-(((bias-deg_counter)/35)*35)))/3],
                                    z_09[(34-((bias-deg_counter)-(((bias-deg_counter)/35)*35)))/3]
                                };
                            end
                        end
                        9'h29: begin//b
                            if((35-(bias-deg_counter)+(((bias-deg_counter)/35)*35))>=30)begin
                                led[15:9]=0; 
                            end else begin
                                led[15:9]={
                                    spa_15[(34-((bias-deg_counter)-(((bias-deg_counter)/35)*35)))/3],//34-(bias-deg_counter)%35
                                    spa_14[(34-((bias-deg_counter)-(((bias-deg_counter)/35)*35)))/3],
                                    spa_13[(34-((bias-deg_counter)-(((bias-deg_counter)/35)*35)))/3],
                                    spa_12[(34-((bias-deg_counter)-(((bias-deg_counter)/35)*35)))/3],
                                    spa_11[(34-((bias-deg_counter)-(((bias-deg_counter)/35)*35)))/3],
                                    spa_10[(34-((bias-deg_counter)-(((bias-deg_counter)/35)*35)))/3],
                                    spa_09[(34-((bias-deg_counter)-(((bias-deg_counter)/35)*35)))/3]
                                };
                            end
                        end
                        default: begin
                            led[15:9]=7'b0000111;
                        end
                    endcase
                end else begin
                    led[15:9]=7'b0; 
                end
                
            end else begin
                led[15:9]=7'b0; 
            end
            
        end else if(10'd181==deg_counter||deg_counter==359)begin
            led[15:9]={7{1'b1}};
        end else begin
            led[15:9]=0; 
        end
    end
    ///////////////////
endmodule 

module clk_divider_01(clk,rst,sec);
    input clk,rst;
    output sec;
    reg[27-1:0] tmp,nxttmp;
    reg sec,nxt_sec;
    always @(posedge clk) begin
        if(rst)begin
            sec<=1'b0;
            tmp<=1'b0;
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