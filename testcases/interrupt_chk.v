task run_test();
    reg fail_num;
    reg tim_int_item1;
    reg tim_int_item2;
    reg tim_int_item3;
    reg tim_int_item4;
    reg tim_int_item5;
    reg [31:0] tb_prdata [12:0];
    begin
    //Set for occuring interrupt condition
    write_access(ADDR_TIER,32'h1); // Enable interrupt pending
    write_access(ADDR_TDR0,32'hFFFF_FF00); write_access(ADDR_TDR1, 32'hFFFF_FFFF);
    write_access(ADDR_TCR, 32'h1); //Enable timer_en to start counting
    repeat(256) @(posedge sys_clk);
    read_access(ADDR_TDR0, tb_prdata[0]); read_access(ADDR_TDR1, tb_prdata[1]);
    tim_int_item1=tim_int;
    write_access(ADDR_TCR,32'h0);
    tim_int_item5=tim_int;
    //clear
    // Set int_en=1
    write_access(ADDR_TIER,32'h0); tim_int_item4=tim_int;
    write_access(ADDR_TIER,32'h1);
    write_access(ADDR_TISR,32'h0000_0001);
    read_access(ADDR_TISR,tb_prdata[6]);
    tim_int_item3=tim_int;
    repeat(2) @(posedge sys_clk); sys_rst_n=0;
    repeat(2) @(posedge sys_clk); sys_rst_n=1;
    //ITEM: SET CONDITION
    write_access(ADDR_TCMP0,32'h0000_00FF);
    write_access(ADDR_TCMP1,32'h0000_0000);
    write_access(ADDR_TCR,32'h1); //Let timer count
    repeat(256) @(posedge sys_clk);
    read_access(ADDR_TISR,tb_prdata[2]);
    tim_int_item2=tim_int;
    //ITEM CLEAR INTERRUPT
    write_access(ADDR_TISR,32'h0000_0000);
    read_access(ADDR_TISR,tb_prdata[3]);
    write_access(ADDR_TISR,32'h0000_0001);
    read_access(ADDR_TISR,tb_prdata[4]);
    repeat(2) @(posedge sys_clk); sys_rst_n=0;
    repeat(2) @(posedge sys_clk); sys_rst_n=1;

    //ITEM: MANUAL
    write_access(ADDR_TDR0,32'hFFFF_FFFF);
    write_access(ADDR_TDR1,32'hFFFF_FFFF);
    read_access(ADDR_TISR,tb_prdata[5]);

    if(    (tim_int_item1==1 && tb_prdata[0]!=32'hFFFF_FFFF && tb_prdata[1]!=32'hFFFF_FFFF) &&
           (tim_int_item2==0 && tb_prdata[2]==32'h0000_0001) &&
           (tb_prdata[3]==32'h0000_0001) &&
           (tb_prdata[4]==32'h0000_0000) &&
           (tb_prdata[5]==32'h0000_0001) &&
           (tb_prdata[6]==32'h0000_0000 && tim_int_item3==0) &&
           (tim_int_item4==0) && (tim_int_item5==1)
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
