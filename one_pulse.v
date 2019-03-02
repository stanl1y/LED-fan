module one_pulse(clk_22,unp,pulsed);
    input clk_22,unp;
    output pulsed;
    reg pulsed;
    reg tmp;
    always @(posedge clk_22 ) begin
        pulsed<=((!tmp)&unp);
        tmp<=unp;
    end
endmodule