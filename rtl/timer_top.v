module timer_top(
    input wire sys_clk,
    input wire sys_rst_n,
    input wire tim_psel,
    input wire tim_pwrite,
    input wire tim_penable,
    input wire [11:0] tim_paddr,
    input wire [3:0] tim_pstrobe,
    input wire [31:0] tim_pwdata,
    input wire dbg_mode,
    output wire [31:0] tim_prdata,
    output wire tim_pslverr,
    output wire tim_pready,
    output wire tim_int
    );
//INTERNAL SIGNALS DECLARATION 

wire wr_en;
wire rd_en;

wire count_en;
wire halt_ack;
wire halt_req;
wire timer_en;
wire div_en;
wire [3:0] div_val;
wire timer_en_fall;

wire int_en;
wire int_st;

//CONNECTION OF EACH BLOCK
APB_slave   u_APB_slave(
    .sys_clk    (sys_clk),
    .sys_rst_n  (sys_rst_n),
    .tim_psel   (tim_psel),
    .tim_penable (tim_penable),
    .tim_pwrite (tim_pwrite),
    .wr_en      (wr_en),
    .rd_en      (rd_en),
    .tim_pready (tim_pready)
    );
 
counter_control u_counter_control(
    .sys_clk    (sys_clk),
    .sys_rst_n  (sys_rst_n),
    .timer_en   (timer_en),
    .div_en     (div_en),
    .div_val    (div_val),
    .halt_req   (halt_req),
    .dbg_mode   (dbg_mode),
    .halt_ack   (halt_ack),
    .timer_en_fall (timer_en_fall),
    .count_en   (count_en)
    );

interrupt   u_interrupt(
    .int_en     (int_en),
    .int_st     (int_st),
    .tim_int    (tim_int)
    );

timer_register  u_timer_register(
    .sys_clk    (sys_clk),
    .sys_rst_n  (sys_rst_n),
    .wr_en      (wr_en),
    .rd_en      (rd_en),
    .tim_paddr  (tim_paddr),
    .tim_pwdata (tim_pwdata),
    .tim_pstrobe  (tim_pstrobe),
    .halt_ack   (halt_ack),
    .timer_en_fall  (timer_en_fall),
    .count_en   (count_en),
    .timer_en   (timer_en),
    .div_en     (div_en),
    .div_val    (div_val),
    .halt_req   (halt_req),
    .tim_prdata (tim_prdata),
    .tim_pslverr (tim_pslverr),
    .int_en     (int_en),
    .int_st     (int_st)
    );
endmodule
