task run_test();
    reg fail_num;
    reg [31:0] tb_prdata [7:0];
    begin
        fail_num=0;
        $display("=================================================");
        $display("======Pat name: 9.Reserved register check==========");
            write_access(12'h400,32'hFFFF_FFFF);
            write_access(12'hFAC,32'hFFFF_FFFF);
            write_access(32'h4000_1FFC,32'hFFFF_FFFF);
            write_access(32'h4000_0020,32'hFFFF_FFFF);
            read_access(12'h400,  tb_prdata[0]);
            read_access(12'hFAC,  tb_prdata[1]);
            read_access(32'h4000_1FFC, tb_prdata[2]);
            read_access(32'h4000_0020, tb_prdata[3]);

        if(tb_prdata[0]==32'h0
        && tb_prdata[1]==32'h0
        && tb_prdata[2]==32'h0
        && tb_prdata[3]==32'h0
        ) begin
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
