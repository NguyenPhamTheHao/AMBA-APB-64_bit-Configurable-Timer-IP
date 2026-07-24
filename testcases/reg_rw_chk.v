task run_test();
    reg fail_num;
    reg [31:0] tb_prdata [30:0];
    begin
        fail_num=0;
        $display("=================================================");
        $display("=====Pat name: 2. TCR RW Access check============");
        
        //TCR RW Access Check
        write_access(ADDR_TCR, 32'h0000_0000);
        read_access(ADDR_TCR,  tb_prdata[0]);

        write_access(ADDR_TCR, 32'hFFFF_FFFF);
        read_access(ADDR_TCR,  tb_prdata[1]);

        write_access(ADDR_TCR, 32'h5555_5255);
        read_access(ADDR_TCR,  tb_prdata[2]);

        write_access(ADDR_TCR, 32'hAAAA_AAAA);
        read_access(ADDR_TCR,  tb_prdata[3]);

        write_access(ADDR_TCR, 32'h5AA5_A55A);
        read_access(ADDR_TCR,  tb_prdata[4]);

        repeat(2) @(posedge sys_clk); #1; sys_rst_n=0;
        repeat(2) @(posedge sys_clk); #1; sys_rst_n=1;

        //TDR0 RW Access Check
        write_access(ADDR_TDR0, 32'h0000_0000);
        read_access(ADDR_TDR0,  tb_prdata[5]);

        write_access(ADDR_TDR0, 32'hFFFF_FFFF);
        read_access(ADDR_TDR0,  tb_prdata[6]);

        write_access(ADDR_TDR0, 32'h5555_5555);
        read_access(ADDR_TDR0,  tb_prdata[7]);

        write_access(ADDR_TDR0, 32'hAAAA_AAAA);
        read_access(ADDR_TDR0,  tb_prdata[8]);

        write_access(ADDR_TDR0, 32'h5AA5_A55A);
        read_access(ADDR_TDR0,  tb_prdata[9]);

        repeat(2) @(posedge sys_clk); #1; sys_rst_n=0;
        repeat(2) @(posedge sys_clk); #1; sys_rst_n=1;

        //TDR1 RW Access Check
        write_access(ADDR_TDR1, 32'h0000_0000);
        read_access(ADDR_TDR1,  tb_prdata[10]);

        write_access(ADDR_TDR1, 32'hFFFF_FFFF);
        read_access(ADDR_TDR1,  tb_prdata[11]);

        write_access(ADDR_TDR1, 32'h5555_5555);
        read_access(ADDR_TDR1,  tb_prdata[12]);

        write_access(ADDR_TDR1, 32'hAAAA_AAAA);
        read_access(ADDR_TDR1,  tb_prdata[13]);

        write_access(ADDR_TDR1, 32'h5AA5_A55A);
        read_access(ADDR_TDR1,  tb_prdata[14]);

        repeat(2) @(posedge sys_clk); #1; sys_rst_n=0;
        repeat(2) @(posedge sys_clk); #1; sys_rst_n=1;

        //TCMP0 RW Access Check
        write_access(ADDR_TCMP0, 32'h1111_1111);
        read_access(ADDR_TCMP0,  tb_prdata[15]);

        write_access(ADDR_TCMP0, 32'hFFFF_FFFF);
        read_access(ADDR_TCMP0,  tb_prdata[16]);

        write_access(ADDR_TCMP0, 32'h5555_5555);
        read_access(ADDR_TCMP0,  tb_prdata[17]);

        write_access(ADDR_TCMP0, 32'hAAAA_AAAA);
        read_access(ADDR_TCMP0,  tb_prdata[18]);

        write_access(ADDR_TCMP0, 32'h5AA5_A55A);
        read_access(ADDR_TCMP0,  tb_prdata[19]);

        repeat(2) @(posedge sys_clk); #1; sys_rst_n=0;
        repeat(2) @(posedge sys_clk); #1; sys_rst_n=1;

        //TCMP1 RW Access Check
        write_access(ADDR_TCMP1, 32'h1111_1111);
        read_access(ADDR_TCMP1,  tb_prdata[20]);

        write_access(ADDR_TCMP1, 32'hFFFF_FFFF);
        read_access(ADDR_TCMP1,  tb_prdata[21]);

        write_access(ADDR_TCMP1, 32'h5555_5555);
        read_access(ADDR_TCMP1,  tb_prdata[22]);

        write_access(ADDR_TCMP1, 32'hAAAA_AAAA);
        read_access(ADDR_TCMP1,  tb_prdata[23]);

        write_access(ADDR_TCMP1, 32'h5AA5_A55A);
        read_access(ADDR_TCMP1,  tb_prdata[24]);

        repeat(2) @(posedge sys_clk); #1; sys_rst_n=0;
        repeat(2) @(posedge sys_clk); #1; sys_rst_n=1;

        //TIER RW Access Check
        write_access(ADDR_TIER, 32'hFFFF_FFFF);
        read_access(ADDR_TIER,  tb_prdata[25]);

        write_access(ADDR_TIER, 32'h2222_2222);
        read_access(ADDR_TIER,  tb_prdata[26]);

        repeat(2) @(posedge sys_clk); #1; sys_rst_n=0;
        repeat(2) @(posedge sys_clk); #1; sys_rst_n=1;

        //TISR RW Access Check
        write_access(ADDR_TISR, 32'hFFFF_FFFF);
        read_access(ADDR_TISR,  tb_prdata[27]);

        write_access(ADDR_TISR, 32'h2222_2222);
        read_access(ADDR_TISR,  tb_prdata[28]);

        repeat(2) @(posedge sys_clk); #1; sys_rst_n=0;
        repeat(2) @(posedge sys_clk); #1; sys_rst_n=1;

        //THCSR RW Access Check
        write_access(ADDR_THCSR, 32'hFFFF_FFFF);
        read_access(ADDR_THCSR,  tb_prdata[29]);

        write_access(ADDR_THCSR, 32'h2222_2222);
        read_access(ADDR_THCSR,  tb_prdata[30]);

        //Kết quả kiểm tra (Validation logic)
        if(tb_prdata[0]==32'h0
        && tb_prdata[1]==32'h0
        && tb_prdata[2]==32'h0000_0201
        && tb_prdata[3]==32'h0000_0201
        && tb_prdata[4]==32'h0000_0201
        && tb_prdata[5]==32'h0
        && tb_prdata[6]==32'hFFFF_FFFF
        && tb_prdata[7]==32'h5555_5555
        && tb_prdata[8]==32'hAAAA_AAAA
        && tb_prdata[9]==32'h5AA5_A55A
        && tb_prdata[10]==32'h0
        && tb_prdata[11]==32'hFFFF_FFFF
        && tb_prdata[12]==32'h5555_5555
        && tb_prdata[13]==32'hAAAA_AAAA
        && tb_prdata[14]==32'h5AA5_A55A
        && tb_prdata[15]==32'h1111_1111
        && tb_prdata[16]==32'hFFFF_FFFF
        && tb_prdata[17]==32'h5555_5555
        && tb_prdata[18]==32'hAAAA_AAAA
        && tb_prdata[19]==32'h5AA5_A55A
        && tb_prdata[20]==32'h1111_1111
        && tb_prdata[21]==32'hFFFF_FFFF
        && tb_prdata[22]==32'h5555_5555
        && tb_prdata[23]==32'hAAAA_AAAA
        && tb_prdata[24]==32'h5AA5_A55A
        && tb_prdata[25]==32'h1
        && tb_prdata[26]==32'h0
        && tb_prdata[27]==32'h0
        && tb_prdata[28]==32'h0
        && tb_prdata[29]==32'h1
        && tb_prdata[30]==32'h0)
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
