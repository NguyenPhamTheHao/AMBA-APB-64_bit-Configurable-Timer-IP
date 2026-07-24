task run_test();
    reg fail_num;
    reg [31:0] tb_prdata [7:0];
    begin
        fail_num=0;
        $display("=================================================");
        $display("======Pat name: Halted check=====================");

    repeat(3) @(posedge sys_clk); dbg_mode=1;
    write_access(ADDR_TCR,32'h1); //timer start counting
    repeat(30) @(posedge sys_clk);
    write_access(ADDR_THCSR,32'h1); // Stop to debug
    read_access(ADDR_THCSR,tb_prdata[0]); // HALT ACK CHECKING
    read_access(ADDR_TDR0,tb_prdata[1]);
    repeat(30) @(posedge sys_clk); read_access(ADDR_TDR0,tb_prdata[2]); // Compare value when stop
    repeat(15) @(posedge sys_clk); write_access(ADDR_THCSR,32'h0);
    repeat(15) @(posedge sys_clk); read_access(ADDR_TDR0,tb_prdata[3]); dbg_mode=0;
    read_access(ADDR_TDR0,tb_prdata[4]);
    repeat(15) @(posedge sys_clk); read_access(ADDR_TDR0,tb_prdata[5]);
    write_access(ADDR_THCSR,32'h1);
    repeat(15) @(posedge sys_clk); read_access(ADDR_TDR0,tb_prdata[6]); read_access(ADDR_THCSR,tb_prdata[7]);
    if(    (tb_prdata[0]==32'h0000_0003) &&
           (tb_prdata[1]==tb_prdata[2]) &&
           (tb_prdata[3]!=tb_prdata[2]) &&
           (tb_prdata[4]!=tb_prdata[5]) &&
           (tb_prdata[5]!=tb_prdata[6]) &&
           (tb_prdata[7]==32'h0000_0001)
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
    if(fail_num!=0) $display("Test_result FAILED %08h   %08h  %08h  %08h    %08h   %08h  %08h  %08h",tb_prdata[0],tb_prdata[1],tb_prdata[2],tb_prdata[3],tb_prdata[4],tb_prdata[5],tb_prdata[6],tb_prdata[7]);
    else $display("Test_result PASSED ");
    end
endtask
