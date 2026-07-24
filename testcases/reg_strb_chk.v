task run_test();
    reg fail_num;
    reg [31:0] tb_prdata [47:0];
    begin
        fail_num=0;
        $display("====================================================");
        $display("=====Pat name: 3. Byte access===============");
        
        //================================ TCR BYTE ACCESS==================
        tim_pstrobe=4'h1; write_access(ADDR_TCR, 32'hFFFF_FFFF); read_access(ADDR_TCR,tb_prdata[0]);
        write_access(ADDR_TCR,32'h0);

        tim_pstrobe=4'h2; write_access(ADDR_TCR, 32'hFFFF_F5FF); read_access(ADDR_TCR,tb_prdata[1]);
        write_access(ADDR_TCR,32'h0);

        tim_pstrobe=4'h4; write_access(ADDR_TCR, 32'hFFFF_FFFF); read_access(ADDR_TCR,tb_prdata[2]);
        write_access(ADDR_TCR,32'h0);

        tim_pstrobe=4'h8; write_access(ADDR_TCR, 32'hFFFF_FFFF); read_access(ADDR_TCR,tb_prdata[3]);
        write_access(ADDR_TCR,32'h0);

        tim_pstrobe=4'h3; write_access(ADDR_TCR, 32'h5555_5555); read_access(ADDR_TCR,tb_prdata[4]);
        write_access(ADDR_TCR,32'h0);

        tim_pstrobe=4'hC; write_access(ADDR_TCR, 32'hFFFF_FFFF); read_access(ADDR_TCR,tb_prdata[5]);
        write_access(ADDR_TCR,32'h0);
    
        //==================== TCMP0 Byte access =============
        tim_pstrobe=4'h1;
        write_access(ADDR_TCMP0, 32'h1111_1111);
        read_access(ADDR_TCMP0, tb_prdata[6]);

        tim_pstrobe=4'h2;
        write_access(ADDR_TCMP0, 32'h2222_2222);
        read_access(ADDR_TCMP0, tb_prdata[7]);

        tim_pstrobe=4'h4;
        write_access(ADDR_TCMP0, 32'h3333_3333);
        read_access(ADDR_TCMP0, tb_prdata[8]);

        tim_pstrobe=4'h8;
        write_access(ADDR_TCMP0, 32'h4444_4444);
        read_access(ADDR_TCMP0, tb_prdata[9]);

        tim_pstrobe=4'h3;
        write_access(ADDR_TCMP0, 32'h5555_5555);
        read_access(ADDR_TCMP0, tb_prdata[10]);

        tim_pstrobe=4'hC;
        write_access(ADDR_TCMP0, 32'h6666_6666);
        read_access(ADDR_TCMP0, tb_prdata[11]);

        //================ TCMP1 BYTE ACCESS ==============

         tim_pstrobe=4'h1;                                                                                           
          write_access(ADDR_TCMP1, 32'h1111_1111);
          read_access(ADDR_TCMP1, tb_prdata[12]);
  
          tim_pstrobe=4'h2;
          write_access(ADDR_TCMP1, 32'h2222_2222);
          read_access(ADDR_TCMP1, tb_prdata[13]);
  
          tim_pstrobe=4'h4;
          write_access(ADDR_TCMP1, 32'h3333_3333);
          read_access(ADDR_TCMP1, tb_prdata[14]);
  
          tim_pstrobe=4'h8;
          write_access(ADDR_TCMP1, 32'h4444_4444);
          read_access(ADDR_TCMP1, tb_prdata[15]);
  
          tim_pstrobe=4'h3;
          write_access(ADDR_TCMP1, 32'h5555_5555);
          read_access(ADDR_TCMP1, tb_prdata[16]);
  
          tim_pstrobe=4'hC;
          write_access(ADDR_TCMP1, 32'h6666_6666);
          read_access(ADDR_TCMP1, tb_prdata[17]);


        // ============== TDR0 BYTE ACCESS ===========
        tim_pstrobe=4'h1;
        write_access(ADDR_TDR0, 32'h1111_1111);
        read_access(ADDR_TDR0, tb_prdata[18]);

        tim_pstrobe=4'h2;
        write_access(ADDR_TDR0, 32'h2222_2222);
        read_access(ADDR_TDR0, tb_prdata[19]);

        tim_pstrobe=4'h4;
        write_access(ADDR_TDR0, 32'h3333_3333);
        read_access(ADDR_TDR0, tb_prdata[20]);

        tim_pstrobe=4'h8;
        write_access(ADDR_TDR0, 32'h4444_4444);
        read_access(ADDR_TDR0, tb_prdata[21]);

        tim_pstrobe=4'h3;
        write_access(ADDR_TDR0, 32'h5555_5555);
        read_access(ADDR_TDR0, tb_prdata[22]);

        tim_pstrobe=4'hC;
        write_access(ADDR_TDR0, 32'h6666_6666);
        read_access(ADDR_TDR0, tb_prdata[23]);


        // ===== TDR1 BYTE ACCESS ===================
        tim_pstrobe=4'h1;
        write_access(ADDR_TDR1, 32'h1111_1111);
        read_access(ADDR_TDR1, tb_prdata[24]);

        tim_pstrobe=4'h2;
        write_access(ADDR_TDR1, 32'h2222_2222);
        read_access(ADDR_TDR1, tb_prdata[25]);

        tim_pstrobe=4'h4;
        write_access(ADDR_TDR1, 32'h3333_3333);
        read_access(ADDR_TDR1, tb_prdata[26]);

        tim_pstrobe=4'h8;
        write_access(ADDR_TDR1, 32'h4444_4444);
        read_access(ADDR_TDR1, tb_prdata[27]);

        tim_pstrobe=4'h3;
        write_access(ADDR_TDR1, 32'h5555_5555);
        read_access(ADDR_TDR1, tb_prdata[28]);

        tim_pstrobe=4'hC;
        write_access(ADDR_TDR1, 32'h6666_6666);
        read_access(ADDR_TDR1, tb_prdata[29]); 

        // ====== TIER BYTE ACCESS =================
        tim_pstrobe=4'h1;
        write_access(ADDR_TIER,32'h1111_1111);
        read_access(ADDR_TIER,tb_prdata[30]);

        tim_pstrobe=4'h2;
        write_access(ADDR_TIER,32'h2222_2222);
        read_access(ADDR_TIER,tb_prdata[31]);

        tim_pstrobe=4'h4;
        write_access(ADDR_TIER,32'h3333_3333);
        read_access(ADDR_TIER,tb_prdata[32]);

        tim_pstrobe=4'h8;
        write_access(ADDR_TIER,32'h4444_4444);
        read_access(ADDR_TIER,tb_prdata[33]);

        tim_pstrobe=4'h3;
        write_access(ADDR_TIER,32'h6666_6666);
        read_access(ADDR_TIER,tb_prdata[34]);

        tim_pstrobe=4'hC;
        write_access(ADDR_TIER,32'h7777_7777);
        read_access(ADDR_TIER,tb_prdata[35]);

        // ======= TISR BYTE ACCESS ==================
        //Enable Interrupt Pending
        tim_pstrobe=4'hF;
        write_access(ADDR_TIER,32'h1);
        // Trigger condition occur
        write_access(ADDR_TDR0, 32'hFFFF_FFFF); write_access(ADDR_TDR1, 32'hFFFF_FFFF);
        //Enable Interrupt Pending
        write_access(ADDR_TDR0,32'h0);

        tim_pstrobe=4'h2;
        write_access(ADDR_TISR,32'hFFFF_FFFF);
        read_access(ADDR_TISR,tb_prdata[36]);

        tim_pstrobe=4'h4;
        write_access(ADDR_TISR,32'hFFFF_FFFF);
        read_access(ADDR_TISR,tb_prdata[37]);

        tim_pstrobe=4'h8;
        write_access(ADDR_TISR,32'hFFFF_FFFF);
        read_access(ADDR_TISR,tb_prdata[38]);

        tim_pstrobe=4'hC;
        write_access(ADDR_TISR,32'hFFFF_FFFF);
        read_access(ADDR_TISR,tb_prdata[39]);

        tim_pstrobe=4'h1;
        write_access(ADDR_TISR,32'h1);
        read_access(ADDR_TISR,tb_prdata[40]);

        tim_pstrobe=4'h3;
        write_access(ADDR_TISR,32'h1);
        read_access(ADDR_TISR,tb_prdata[41]);

        // ========= THCSR BYTE ACCESS ==============
       tim_pstrobe=4'h1;
       write_access(ADDR_THCSR,32'h1111_1111);
       read_access(ADDR_THCSR,tb_prdata[42]);

        tim_pstrobe=4'h2;
        write_access(ADDR_THCSR,32'h2222_2222);
        read_access(ADDR_THCSR,tb_prdata[43]);

        tim_pstrobe=4'h4;
        write_access(ADDR_THCSR,32'h3333_3333);
        read_access(ADDR_THCSR,tb_prdata[44]);

        tim_pstrobe=4'h8;
        write_access(ADDR_THCSR,32'h4444_4444);
        read_access(ADDR_THCSR,tb_prdata[45]);

        tim_pstrobe=4'h3;
        write_access(ADDR_THCSR,32'h6666_6666);
        read_access(ADDR_THCSR,tb_prdata[46]);

        tim_pstrobe=4'hC;
        write_access(ADDR_THCSR,32'h7777_7777);
        read_access(ADDR_THCSR,tb_prdata[47]);




        if(    (tb_prdata[0]==32'h103 )
            && (tb_prdata[1]==32'h500)
            && (tb_prdata[2]==32'h0  )
            && (tb_prdata[3]==32'h0  )
            && (tb_prdata[4]==32'h501 )
            && (tb_prdata[5]==32'h0   )
            && (tb_prdata[6]==32'hFFFF_FF11 )
            && (tb_prdata[7]==32'hFFFF_2211 )
            && (tb_prdata[8]==32'hFF33_2211 )
            && (tb_prdata[9]==32'h4433_2211 )
            && (tb_prdata[10]==32'h4433_5555 )
            && (tb_prdata[11]==32'h6666_5555 )
            && (tb_prdata[12]==32'hFFFF_FF11 )
            && (tb_prdata[13]==32'hFFFF_2211 )
            && (tb_prdata[14]==32'hFF33_2211 )
            && (tb_prdata[15]==32'h4433_2211 )
            && (tb_prdata[16]==32'h4433_5555 )
            && (tb_prdata[17]==32'h6666_5555 )
            && (tb_prdata[18]==32'h0000_0011 )
            && (tb_prdata[19]==32'h0000_2211 )
            && (tb_prdata[20]==32'h0033_2211 )
            && (tb_prdata[21]==32'h4433_2211 )
            && (tb_prdata[22]==32'h4433_5555 )
            && (tb_prdata[23]==32'h6666_5555 )
            && (tb_prdata[24]==32'h0000_0011 )
            && (tb_prdata[25]==32'h0000_2211 )
            && (tb_prdata[26]==32'h0033_2211 )
            && (tb_prdata[27]==32'h4433_2211 )
            && (tb_prdata[28]==32'h4433_5555 )
            && (tb_prdata[29]==32'h6666_5555 )
            && (tb_prdata[30]==32'h1 )
            && (tb_prdata[31]==32'h1 )
            && (tb_prdata[32]==32'h1 )
            && (tb_prdata[33]==32'h1 )
            && (tb_prdata[34]==32'h0 )
            && (tb_prdata[35]==32'h0 )
            && (tb_prdata[36]==32'h1 )
            && (tb_prdata[37]==32'h1 )
            && (tb_prdata[38]==32'h1 )
            && (tb_prdata[39]==32'h1 )
            && (tb_prdata[40]==32'h0 )
            && (tb_prdata[41]==32'h0 )
            && (tb_prdata[42]==32'h1)
            && (tb_prdata[43]==32'h1)
            && (tb_prdata[44]==32'h1)
            && (tb_prdata[45]==32'h1)
            && (tb_prdata[46]==32'h0)
            && (tb_prdata[47]==32'h0)
            )
begin
        $display("====================================================");
        $display("===================== PASSED =======================");
        $display("====================================================");
    end
    else begin
        $display("====================================================");
        $display("===================== FAILED =======================");
        $display("====================================================");

        fail_num=1;
    end
    if(fail_num!=0) $display("Test_result  FAILED ");
    else $display("Test_result PASSED ");
end
endtask
