task run_test();
    reg fail_num;
    reg [31:0] tb_prdata [8:0];
    reg [8:0] err;
    reg [8:0] true; //Timing of PSLVERR AND PREADY
    begin
        fail_num=0;
        $display("====================================================");
        $display("======Pat name: APB Slave Error check============");
//WRONG DIV VAL
        //TCR
        @(posedge sys_clk); #1; tim_psel=1; tim_pwrite=1; tim_penable=0; tim_paddr=ADDR_TCR; tim_pwdata=32'h0000_0A00; //Setupt phase
        @(posedge sys_clk); #1; tim_penable=1; //Access phase
        @(posedge sys_clk); #5; err[0]=tim_pslverr; if(tim_pready==1) true[0]=1; else true[0]=0;
        @(posedge sys_clk); #1; tim_psel=0; tim_penable=0; tim_paddr=12'h0;
        read_access(ADDR_TCR,tb_prdata[0]);

        @(posedge sys_clk); #1; tim_psel=1; tim_pwrite=1; tim_penable=0; tim_paddr=ADDR_TCR; tim_pwdata=32'h0000_0A00; //Setupt phase
        @(posedge sys_clk); #1; tim_penable=1; //Access phase
        @(posedge sys_clk); #5; err[1]=tim_pslverr; if(tim_pready==1) true[1]=1; else true[1]=0;

        @(posedge sys_clk); #1; tim_psel=0; tim_penable=0; tim_paddr=12'h0;
        read_access(ADDR_TCR,tb_prdata[1]);

        @(posedge sys_clk); #1; tim_psel=1; tim_pwrite=1; tim_penable=0; tim_paddr=ADDR_TCR; tim_pwdata=32'h0000_0B00; //Setupt phase
        @(posedge sys_clk); #1; tim_penable=1; //Access phase
        @(posedge sys_clk); #5; err[2]=tim_pslverr;  if(tim_pready==1) true[2]=1; else true[2]=0;

        @(posedge sys_clk); #1; tim_psel=0; tim_penable=0; tim_paddr=12'h0;
        read_access(ADDR_TCR,tb_prdata[2]);
        @(posedge sys_clk); #1; tim_psel=1; tim_pwrite=1; tim_penable=0; tim_paddr=ADDR_TCR; tim_pwdata=32'h0000_0C00; //Setupt phase
        @(posedge sys_clk); #1; tim_penable=1; //Access phase
        @(posedge sys_clk); #5; err[3]=tim_pslverr;   if(tim_pready==1) true[3]=1; else true[3]=0;

        @(posedge sys_clk); #1; tim_psel=0; tim_penable=0; tim_paddr=12'h0;
        read_access(ADDR_TCR,tb_prdata[3]);

        @(posedge sys_clk); #1; tim_psel=1; tim_pwrite=1; tim_penable=0; tim_paddr=ADDR_TCR; tim_pwdata=32'h0000_0800; //Setupt phase
        @(posedge sys_clk); #1; tim_penable=1; //Access phase
        @(posedge sys_clk); #5; err[4]=tim_pslverr;   if(tim_pready==1) true[4]=1; else true[4]=0;

        @(posedge sys_clk); #1; tim_psel=0; tim_penable=0; tim_paddr=12'h0;
        read_access(ADDR_TCR,tb_prdata[4]);

//CHANGE VALUE OF DIV_VAL & DIV_EN WHEN TIMER_EN IS HIGH
repeat(2) @(posedge sys_clk); sys_rst_n=0;
repeat(2) @(posedge sys_clk); sys_rst_n=1;

//Write 1 to timer en
        @(posedge sys_clk); #1; tim_psel=1; tim_pwrite=1; tim_penable=0; tim_paddr=ADDR_TCR; tim_pwdata=32'h0000_0001; //Setupt phase
        @(posedge sys_clk); #1; tim_penable=1; //Access phase
        @(posedge sys_clk); #5; err[5]=tim_pslverr;   if(tim_pready==1) true[5]=1; else true[5]=0;

        @(posedge sys_clk); #1; tim_psel=0; tim_penable=0; tim_paddr=12'h0;
        read_access(ADDR_TCR,tb_prdata[5]);
//Write div_en and div_val when timer_en=1
        @(posedge sys_clk); #1; tim_psel=1; tim_pwrite=1; tim_penable=0; tim_paddr=ADDR_TCR; tim_pwdata=32'h0000_0103; //Setupt phase
        @(posedge sys_clk); #1; tim_penable=1; //Access phase
        @(posedge sys_clk); #5; err[6]=tim_pslverr;   if(tim_pready==1) true[6]=1; else true[6]=0;

        @(posedge sys_clk); #1; tim_psel=0; tim_penable=0; tim_paddr=12'h0;
        read_access(ADDR_TCR,tb_prdata[6]);
//Write div_en and div_val when timer_en=1
        @(posedge sys_clk); #1; tim_psel=1; tim_pwrite=1; tim_penable=0; tim_paddr=ADDR_TCR; tim_pwdata=32'h0000_0100; //Setupt phase
        @(posedge sys_clk); #1; tim_penable=1; //Access phase
        @(posedge sys_clk); #5; err[7]=tim_pslverr;   if(tim_pready==1) true[7]=1; else true[7]=0;

        @(posedge sys_clk); #1; tim_psel=0; tim_penable=0; tim_paddr=12'h0;
        read_access(ADDR_TCR,tb_prdata[7]);
//Write 0 to timer en and 1 to div_en
        @(posedge sys_clk); #1; tim_psel=1; tim_pwrite=1; tim_penable=0; tim_paddr=ADDR_TCR; tim_pwdata=32'h0000_0002; //Setupt phase
        @(posedge sys_clk); #1; tim_penable=1; //Access phase
        @(posedge sys_clk); #5; err[8]=tim_pslverr;   if(tim_pready==1) true[8]=1; else true[8]=0;

        @(posedge sys_clk); #1; tim_psel=0; tim_penable=0; tim_paddr=12'h0;
        read_access(ADDR_TCR,tb_prdata[8]);

        if( (tb_prdata[0]==32'h0000_0100 && err[0]==1 && true[0]==1) &&
            (tb_prdata[1]==32'h0000_0100 && err[1]==1 && true[1]==1) &&
            (tb_prdata[2]==32'h0000_0100 && err[2]==1 && true[2]==1) &&
            (tb_prdata[3]==32'h0000_0100 && err[3]==1 && true[3]==1) &&
            (tb_prdata[4]==32'h0000_0800 && err[4]==0 && true[4]==1) &&
            (tb_prdata[5]==32'h0000_0001 && err[5]==0 && true[5]==1) &&
            (tb_prdata[6]==32'h0000_0001 && err[6]==1 && true[6]==1) &&
            (tb_prdata[6]==32'h0000_0001 && err[6]==1 && true[6]==1) &&
            (tb_prdata[6]==32'h0000_0001 && err[6]==1 && true[6]==1) )

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
