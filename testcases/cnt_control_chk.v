task run_test();
    reg fail_num;
    reg [31:0] tb_prdata [31:0];
    begin
    fail_num=0;
        $display("=================================================");
        $display("======Pat name: 10.Counting control==============");
    //AFTER TIMER_EN CHANGES FROM 1->0->1 THEN TIMER STARTS AGAIN
        write_access(ADDR_TCR,32'h1); //Timer start counting
        repeat(40) @(posedge sys_clk);
        read_access(ADDR_TDR0, tb_prdata[0]);
        read_access(ADDR_TDR1, tb_prdata[1]);
        write_access(ADDR_TCR, 32'h0); //Stop counting
        read_access(ADDR_TDR0, tb_prdata[2]);
        read_access(ADDR_TDR1, tb_prdata[3]);
        write_access(ADDR_TCR, 32'h0000_0203); //Set div_val and div_en then start counting again
        repeat(100) @(posedge sys_clk);
        read_access(ADDR_TDR0, tb_prdata[4]);
        read_access(ADDR_TDR1, tb_prdata[5]);

    repeat(2) @(posedge sys_clk); sys_rst_n=0;
    repeat(2) @(posedge sys_clk); sys_rst_n=1;

    //COUNTER DEFAULT MOD
    //Read the value before counting
    read_access(ADDR_TDR0,tb_prdata[7]);
    write_access(ADDR_TCR, 32'h0000_0001);
    read_access(ADDR_TDR0,tb_prdata[8]);

    repeat(2) @(posedge sys_clk); sys_rst_n=0;
    repeat(2) @(posedge sys_clk); sys_rst_n=1;

    //COUNTER CONTROL MODE DIV_VAL=1
    //Read the value before counting
    read_access(ADDR_TDR0,tb_prdata[9]);
    write_access(ADDR_TCR, 32'h0000_0103);
    repeat(4) @(posedge sys_clk);
read_access(ADDR_TDR0,tb_prdata[10]);

    repeat(2) @(posedge sys_clk); sys_rst_n=0;
    repeat(2) @(posedge sys_clk); sys_rst_n=1;
    //COUNTER CONTROL MODE DIV_VAL=2
    //Read the value before counting
    read_access(ADDR_TDR0,tb_prdata[11]);
    write_access(ADDR_TCR, 32'h0000_0203);
    repeat(12) @(posedge sys_clk);
    read_access(ADDR_TDR0,tb_prdata[12]);

    repeat(2) @(posedge sys_clk); sys_rst_n=0;
    repeat(2) @(posedge sys_clk); sys_rst_n=1;

    //COUNTER CONTROL MODE DIV_VAL=3
    //Read the value before counting
    read_access(ADDR_TDR0,tb_prdata[13]);
    write_access(ADDR_TCR, 32'h0000_0303);
    repeat(28) @(posedge sys_clk);
    read_access(ADDR_TDR0,tb_prdata[14]);

    repeat(2) @(posedge sys_clk); sys_rst_n=0;
    repeat(2) @(posedge sys_clk); sys_rst_n=1;

    //COUNTER CONTROL MODE DIV_VAL=4
    //Read the value before counting
    read_access(ADDR_TDR0,tb_prdata[15]);
    write_access(ADDR_TCR, 32'h0000_0403);
    repeat(60) @(posedge sys_clk);
    read_access(ADDR_TDR0,tb_prdata[16]);

    repeat(2) @(posedge sys_clk); sys_rst_n=0;
    repeat(2) @(posedge sys_clk); sys_rst_n=1;

    //COUNTER CONTROL MODE DIV_VAL=5
    //Read the value before counting
    read_access(ADDR_TDR0,tb_prdata[17]);
    write_access(ADDR_TCR, 32'h0000_0503);
    repeat(124) @(posedge sys_clk);
    read_access(ADDR_TDR0,tb_prdata[18]);

    repeat(2) @(posedge sys_clk); sys_rst_n=0;
    repeat(2) @(posedge sys_clk); sys_rst_n=1;

    //COUNTER CONTROL MODE DIV_VAL=6
    //Read the value before counting
    read_access(ADDR_TDR0,tb_prdata[19]);
    write_access(ADDR_TCR, 32'h0000_0603);
    repeat(252) @(posedge sys_clk);
    read_access(ADDR_TDR0,tb_prdata[20]);

    repeat(2) @(posedge sys_clk); sys_rst_n=0;
    repeat(2) @(posedge sys_clk); sys_rst_n=1;

    //COUNTER CONTROL MODE DIV_VAL=7
    //Read the value before counting
    read_access(ADDR_TDR0,tb_prdata[21]);
    write_access(ADDR_TCR, 32'h0000_0703);
    repeat(508) @(posedge sys_clk);
    read_access(ADDR_TDR0,tb_prdata[22]);

    repeat(2) @(posedge sys_clk); sys_rst_n=0;
    repeat(2) @(posedge sys_clk); sys_rst_n=1;

    //COUNTER CONTROL MODE DIV_VAL=8
    //Read the value before counting
    read_access(ADDR_TDR0,tb_prdata[23]);
    write_access(ADDR_TCR, 32'h0000_0803);
    repeat(1020) @(posedge sys_clk);
    read_access(ADDR_TDR0,tb_prdata[24]);

    repeat(2) @(posedge sys_clk); sys_rst_n=0;
    repeat(2) @(posedge sys_clk); sys_rst_n=1;

    //COUNTER CONTROL MODE DIV_VAL=0, DIV_EN=1
    //Read the value before counting
    read_access(ADDR_TDR0,tb_prdata[25]);
    write_access(ADDR_TCR, 32'h0000_0003);
    read_access(ADDR_TDR0,tb_prdata[26]);
        repeat(2) @(posedge sys_clk); sys_rst_n=0;
    repeat(2) @(posedge sys_clk); sys_rst_n=1;

    //COUNTER CONTROL MODE DIV_VAL !=0, DIV_EN=0
    read_access(ADDR_TDR0,tb_prdata[27]);
    write_access(ADDR_TCR,32'h0000_0501);
    read_access(ADDR_TDR0,tb_prdata[28]);

    //COVER FOR AFFECT OF TIMER_EN IN EXPRESSION OF INT_COUNT_NEXT
    repeat(2) @(posedge sys_clk); sys_rst_n=0;
    repeat(2) @(posedge sys_clk); sys_rst_n=1;
    read_access(ADDR_TDR0,tb_prdata[29]);
    write_access(ADDR_TCR,32'h0502);
    repeat(2) @(posedge sys_clk);
    read_access(ADDR_TDR0,tb_prdata[30]);
    tim_pstrobe=4'h0;
    write_access(ADDR_TCR,32'h503);
    repeat(255) @(posedge sys_clk);
    read_access(ADDR_TDR0,tb_prdata[31]);

    if(    (tb_prdata[0]!=32'h0 || tb_prdata[1]!=32'h0) &&
           (tb_prdata[2]==32'h0 || tb_prdata[3]!=32'h0) &&
           (tb_prdata[4]!=32'h0 || tb_prdata[5]!=32'h0) &&
           (tb_prdata[7]==32'h0 && tb_prdata[8]==32'h3) &&
           (tb_prdata[9]==32'h0 && tb_prdata[10]==32'h3) &&
           (tb_prdata[11]==32'h0 && tb_prdata[12]==32'h3) &&
           (tb_prdata[13]==32'h0 && tb_prdata[14]==32'h3) &&
           (tb_prdata[15]==32'h0 && tb_prdata[16]==32'h3) &&
           (tb_prdata[17]==32'h0 && tb_prdata[18]==32'h3) &&
           (tb_prdata[19]==32'h0 && tb_prdata[20]==32'h3) &&
           (tb_prdata[21]==32'h0 && tb_prdata[22]==32'h3) &&
           (tb_prdata[23]==32'h0 && tb_prdata[24]==32'h3) &&
           (tb_prdata[25]==32'h0 && tb_prdata[26]==32'h3) &&
           (tb_prdata[27]==32'h0 && tb_prdata[28]==32'h3) &&
           (tb_prdata[29]==32'h0 && tb_prdata[30]==32'h0)
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
