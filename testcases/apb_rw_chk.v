task run_test();
    reg fail_num;
    reg [31:0] tb_prdata [7:0];
    reg true;
    begin
        fail_num=0;
        $display("====================================================");
        $display("======Pat name: APB rw check============");
        //Psel not but Penable
        @(posedge sys_clk); #1; tim_psel=1; tim_pwrite=1; tim_paddr=ADDR_TCR; tim_pwdata=32'h1;
        @(posedge sys_clk); #1; tim_penable=1; if(tim_pready==1) true=1; else true=0;
        repeat(2) @(posedge sys_clk); #1; tim_pwrite=0; tim_paddr=32'h0; tim_pwdata=32'h0; tim_penable=0;


        if(!true)
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
        if(fail_num!=0) $display("Test_result FAILED " );
        else $display("Test_result PASSED ");
    end
endtask
