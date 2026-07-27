module APB_slave(
    input wire sys_clk,
    input wire sys_rst_n,
    input wire tim_psel,
    input wire tim_penable,
    input wire tim_pwrite,
    output reg tim_pready,
    output wire wr_en,
    output wire rd_en
    );
//INTERNAL SIGNALS DECLARATION 
wire pready_pre;

//LOGIC DESIGN 

//Logic of tim_pready after the setup phase
assign pready_pre= (~tim_psel) | tim_penable;

// 1 cycle Waits state for tim_pready
always @(posedge sys_clk or negedge sys_rst_n) begin
    if(!sys_rst_n) tim_pready<=1'b1;
    else tim_pready<=pready_pre;
end

// Output logic of wr_en & rd_en
assign wr_en= tim_psel & tim_penable & tim_pwrite & tim_pready;
assign rd_en= tim_psel & tim_penable & (~tim_pwrite) & tim_pready;

endmodule

