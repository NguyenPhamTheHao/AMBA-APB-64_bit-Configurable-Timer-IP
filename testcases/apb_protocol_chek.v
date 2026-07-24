task run_test();
    reg fail_num;
    reg [31:0] tb_prdata [7:0];
    begin
        fail_num=0;
        $display("====================================================");        $display("======Pat name: APB Protocol check============");
        //Psel not but Penable
        @(posedge sys_clk); #1; tim_psel=0; tim_pwrite=1; tim_paddr=ADDR_TCR; tim_pwdata=32'h1;
        @(posedge sys_clk); #1; tim_penable=1;
        repeat(2) @(posedge sys_clk); #1; tim_pwrite=0; tim_paddr=32'h0; tim_pwdata=32'h0; tim_penable=0;

        read_access(ADDR_TCR, tb_prdata[0]);

        //Penable not but Psel
        @(posedge sys_clk); #1; tim_psel=1; tim_pwrite=1; tim_paddr=ADDR_TCR; tim_pwdata=32'h1; tim_penable=0;
        @(posedge sys_clk); #1;
        repeat(2) @(posedge sys_clk); #1; tim_pwrite=0; tim_paddr=32'h0; tim_pwdata=32'h0; tim_penable=0; tim_psel=0;

        read_access(ADDR_TCR, tb_prdata[1]);

        //Rd_en not follow APB access
        write_access(ADDR_TCR, 32'h0000_0503);
        //Psel not but Penable
        @(posedge sys_clk); #1; tim_psel=0; tim_pwrite=0; tim_paddr=ADDR_TCR; tim_penable=0;
        @(posedge sys_clk); #1; tim_penable=1; @(posedge sys_clk) #1; tb_prdata[2]=tim_prdata;
        @(posedge sys_clk); #1; tim_paddr=32'h0; tim_penable=0;


        //Penable not but Psel
        @(posedge sys_clk); #1; tim_psel=1; tim_pwrite=0; tim_paddr=ADDR_TCR; tim_penable=0;
        @(posedge sys_clk); #1; tim_penable=0;
        @(posedge sys_clk); #1; tb_prdata[3]=tim_prdata;
        @(posedge sys_clk); #1; tim_pwrite=0; tim_paddr=32'h0; tim_pwdata=32'h0; tim_penable=0; tim_psel=0;

if((tb_prdata[0]!=32'h1) && (tb_prdata[1]!=32'h1) && (tb_prdata[2]!=32'h0000_0503) && (tb_prdata[3]!=32'h0000_05))
        begin

                $display("====================================================");
                $display("======================= PASSED======================");
                $display("====================================================");
        end
        else begin
                $display("====================================================");
                $display("======================= FAILED =====================");
                $display("====================================================");
                fail_num=1;
        end
        if(fail_num!=0) $display("Test_result FAILED ");
        else $display("Test_result PASSED ");
    end
endtask
