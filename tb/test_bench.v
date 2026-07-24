module test_bench;
    //Register Addresses
    parameter ADDR_TCR   = 12'h00;
    parameter ADDR_TDR0  = 12'h04;
    parameter ADDR_TDR1  = 12'h08;
    parameter ADDR_TCMP0 = 12'h0C;
    parameter ADDR_TCMP1 = 12'h10;
    parameter ADDR_TIER  = 12'h14;
    parameter ADDR_TISR  = 12'h18;
    parameter ADDR_THCSR = 12'h1C;
    //Inputs
    reg sys_clk;
    reg sys_rst_n;
    reg dbg_mode;
    reg tim_psel;
    reg tim_penable;
    reg tim_pwrite;
    reg [31:0] tim_pwdata;
    reg [11:0] tim_paddr;
    reg [3:0] tim_pstrobe;
    //Outputs
    wire [31:0] tim_prdata;
    wire tim_int;
    wire tim_pslverr;
    wire tim_pready;

timer_top dut(
    .sys_clk     (sys_clk),
    .sys_rst_n   (sys_rst_n),
    .tim_psel    (tim_psel),
    .tim_penable (tim_penable),
    .tim_pwrite  (tim_pwrite),
    .tim_pwdata  (tim_pwdata),
    .tim_paddr   (tim_paddr),
    .tim_pstrobe (tim_pstrobe),
    .dbg_mode    (dbg_mode),
    .tim_prdata  (tim_prdata),
    .tim_int     (tim_int),
    .tim_pready  (tim_pready),
    .tim_pslverr (tim_pslverr)
    );
`include "run_test.v"
initial begin
    sys_clk=1;
    forever #5 sys_clk=~sys_clk;
end
//Reset generation
initial begin
    sys_rst_n=0;
    #70;
    sys_rst_n=1;
    tim_pstrobe=4'hF;
end
initial begin
    dbg_mode=0;
    tim_psel=0;
    tim_paddr=12'h0;
    tim_penable=0;
    tim_pwdata=32'h0;
    #100;
    run_test();
    #100;
    $finish;
end
task write_access;
    input [11:0] address;
    input [31:0] data;
    begin

        //WRITE TRANSFER
        @(posedge sys_clk); #1; tim_psel=1; tim_pwrite=1; tim_penable=0; tim_paddr=address; tim_pwdata=data; //Setup Phase
        @(posedge sys_clk); #1; tim_penable=1; //Access Phase
        repeat(2) @(posedge sys_clk); #1; tim_psel=0; tim_penable=0; tim_pwrite=0; tim_paddr=12'h0; tim_pwdata=32'h0;
//get pready; then idle
    end
endtask

task read_access;
    input [11:0] address;
    output [31:0] data;
    begin
        //READ AFTER WRITE
        @(posedge sys_clk); #1; tim_psel=1; tim_pwrite=0; tim_penable=0; tim_paddr=address; //Setupt phase
        @(posedge sys_clk); #1; tim_penable=1; //Access phase
        @(posedge sys_clk); #5; data=tim_prdata; //Get the value of prdata to check
        @(posedge sys_clk); #1; tim_psel=0; tim_penable=0; tim_paddr=12'h0;
    end
endtask

endmodule

