task run_test();
    reg fail_num;
    reg [31:0] tb_prdata [7:0];
    begin
        fail_num=0;
        $display("=================================================");
        $display("======Pat name: 1. Reset value check==========");
            read_access(ADDR_TCR,  tb_prdata[0]);
            read_access(ADDR_TDR0, tb_prdata[1]);
            read_access(ADDR_TDR1, tb_prdata[2]);
            read_access(ADDR_TCMP0,tb_prdata[3]);
            read_access(ADDR_TCMP1,tb_prdata[4]);
            read_access(ADDR_TIER, tb_prdata[5]);
            read_access(ADDR_TISR, tb_prdata[6]);
            read_access(ADDR_THCSR,tb_prdata[7]);

        if(tb_prdata[0]==32'h0000_0100
        && tb_prdata[1]==32'h0
        && tb_prdata[2]==32'h0
        && tb_prdata[3]==32'hFFFF_FFFF
        && tb_prdata[4]==32'hFFFF_FFFF
        && tb_prdata[5]==32'h0
        && tb_prdata[6]==32'h0
        && tb_prdata[7]==32'h0) begin
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
