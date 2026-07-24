task run_test();
    reg fail_num;
    reg [31:0] tb_prdata [7:0];
    reg true;
    begin
        fail_num=0;
        $display("====================================================");
        $display("======Pat name: APB unaligned check============");
        write_access(12'h001, 32'h0000_1100);
        read_access(ADDR_TCR, tb_prdata[0]);
        write_access(12'h002, 32'h0000_1100);
        read_access(ADDR_TCR, tb_prdata[1]);
        write_access(12'h003, 32'h0000_1100);
        read_access(ADDR_TCR, tb_prdata[2]);


        if(tb_prdata[0]==32'h0000_0100 &&
        tb_prdata[1]==32'h0000_0100 &&
        tb_prdata[2]==32'h0000_0100 )

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
