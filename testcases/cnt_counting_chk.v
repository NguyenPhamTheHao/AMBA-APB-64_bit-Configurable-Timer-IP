task run_test();
    reg fail_num;
    reg [31:0] tb_prdata [12:0];
    begin
        fail_num=0;
        $display("=================================================");
        $display("======Pat name: 10.Counting behavior==============");
    //CHECK COUNTING AT BOUNDARY OF TDR0 & CONTINUE COUNTING WHEN OVERFLOW
        write_access(ADDR_TDR0, 32'hFFFF_FF00);
        write_access(ADDR_TDR1, 32'hFFFF_FFFF);
        write_access(ADDR_TCR, 32'h1);
        repeat(251) @(posedge sys_clk);
        write_access(ADDR_THCSR,32'h1);
        read_access(ADDR_TDR0, tb_prdata[0]);
        read_access(ADDR_TDR1, tb_prdata[1]);

    repeat(2) @(posedge sys_clk); #1; sys_rst_n=0;
    repeat(2) @(posedge sys_clk); #1; sys_rst_n=1; tim_pstrobe=4'hF;


    //CHECK COUNTING AT BOUNDARY OF TDR0 & CONTINUE COUNTING WHEN OVERFLOW
        write_access(ADDR_TDR0, 32'hFFFF_FF00);
        write_access(ADDR_TCR, 32'h1);
        repeat(251) @(posedge sys_clk);
        write_access(ADDR_THCSR,32'h1);
        read_access(ADDR_TDR0, tb_prdata[2]);
        read_access(ADDR_TDR1, tb_prdata[3]);
    repeat(2) @(posedge sys_clk); #1; sys_rst_n=0;
    repeat(2) @(posedge sys_clk); #1; sys_rst_n=1; tim_pstrobe=4'hF; dbg_mode=1;


    //UPDATE TDR0/1 VALUE WHILE COUNTING
        write_access(ADDR_TCR, 32'h1); // Let the timer start counting
        repeat(251) @(posedge sys_clk);
        write_access(ADDR_THCSR,32'h1); // Stop to read the current counting status of TDR0/1
        read_access(ADDR_TDR0,tb_prdata[4]);
read_access(ADDR_TDR1,tb_prdata[5]);

    write_access(ADDR_THCSR,32'h0); // Allow to continue counting
    write_access(ADDR_TDR0, 32'hFFFF_FF00); //Update data TDR0/1 while counting
    write_access(ADDR_TDR1, 32'h0);
    repeat(251) @(posedge sys_clk);
    write_access(ADDR_THCSR,32'h1); // Stop to read the current counting status of TDR0/1
    read_access(ADDR_TDR0, tb_prdata[6]);
    read_access(ADDR_TDR1, tb_prdata[7]);


//WHEN TIMER_EN CHANGE FROM 1 TO 0, COUNTER VALUE IS RESET
    write_access(ADDR_THCSR,32'h0); // Let the timer continue counting
    repeat(30) @(posedge sys_clk);
    write_access(ADDR_TCR,32'h0); // Chgae timer_en from 1 to 0
    read_access(ADDR_TDR0,tb_prdata[8]);
    read_access(ADDR_TDR1,tb_prdata[9]);


//SET THE VALUE OF TDR0/1 WHEN TIMER_EN IS LOW
    write_access(ADDR_TDR0, 32'h0000_0010);
    write_access(ADDR_TDR1, 32'h0000_0000);
    read_access(ADDR_TDR0,tb_prdata[10]);
    read_access(ADDR_TDR1,tb_prdata[11]);

    if(
        (tb_prdata[0]>=32'h0 && tb_prdata[1]==32'h0) && // item 1
        (tb_prdata[2]>=32'h0 && tb_prdata[3]==32'h1) && // item 2
        (tb_prdata[4]!=32'h0 || tb_prdata[5]!=32'h0) && //item 3
        (tb_prdata[6]!=32'hFFFF_FF00 || tb_prdata[7]!=32'h0) && // item 3
        (tb_prdata[8]==32'h0 && tb_prdata[9]==32'h0) && // item 4
        (tb_prdata[10]==32'h0000_0010 && tb_prdata[11]==32'h0)
    )
    begin
        $display("=================================================");
        $display("==================== PASSED =====================");
        $display("=================================================");
    end
    else begin
        $display("=================================================");
        $display("==================== FAILED =====================");
        $display("=================================================");
        fail_num=1;
    end

    if(fail_num!=0) $display("Test_result FAILED ");
    else $display("Test_result PASSED ");

end
endtask
