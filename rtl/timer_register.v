module timer_register(
    input wire sys_clk,
    input wire sys_rst_n,
    input wire wr_en,
    input wire rd_en,
    input wire [11:0] tim_paddr,
    input wire [3:0] tim_pstrobe,
    input wire [31:0] tim_pwdata,
    input wire halt_ack,
    input wire count_en,
    input wire timer_en_fall,
    output reg [31:0] tim_prdata,
    output wire tim_pslverr,
    output reg timer_en,
    output reg div_en,
    output reg [3:0] div_val,
    output reg halt_req,
    output reg int_en,
    output reg int_st
    );
//===  ADDRESS OF SYSTEM REGISTER=============
parameter ADDR_TCR   = 12'h0;
parameter ADDR_TDR0  = 12'h4;
parameter ADDR_TDR1  = 12'h8;
parameter ADDR_TCMP0 = 12'hC;
parameter ADDR_TCMP1 = 12'h10;
parameter ADDR_TIER  = 12'h14;
parameter ADDR_TISR  = 12'h18;
parameter ADDR_THCSR = 12'h1C;

//============================================
//===== INTERNAL SIGNALS DECLARATION =========
//============================================

// Signals for TCR Logic
wire TCR_sel;
wire timer_en_sel;  wire div_en_sel;  wire div_val_sel;

// Signals for TDR0/1
wire TDR0_sel;
wire TDR1_sel;
reg [31:0] TDR0_store;
reg [31:0] TDR1_store;

//Signals for TCMP0/1
wire TCMP0_sel;
wire TCMP1_sel;
reg [31:0] TCMP0_store;
reg [31:0] TCMP1_store;

//Signals for TIER
wire TIER_sel;

//Signas for TISR
wire TISR_sel;
wire int_st_clr;
wire equal_condition;

//Signals for THCSR
wire THCSR_sel;

//Signals for Prohibited Write Access & Error Response Logic
wire div_en_prohibited_change;
wire div_val_prohibited_change;
wire div_val_prohibited_val;


//=============================================
//==== LOGIC DESIGN (WRITE TRANSFER) ==========
//=============================================

//=========== TCR Logic =======================
assign TCR_sel= wr_en & (tim_paddr==ADDR_TCR);

// timer_en Write Transfer
assign timer_en_sel = TCR_sel & ( (tim_pwdata==32'h0) | (tim_pstrobe[0] & !div_val_prohibited_val & !div_val_prohibited_change & !div_en_prohibited_change)); // Permit to operate Write data to timer_en
always @(posedge sys_clk or negedge sys_rst_n) begin
    if(!sys_rst_n) timer_en<=0;
    else begin
        if(timer_en_sel) timer_en<=tim_pwdata[0];
        else timer_en<=timer_en;
    end
end

//div_en Write Transfer
assign div_en_sel= TCR_sel & ( (tim_pwdata==32'h0) | ( !timer_en & tim_pstrobe[0] & !div_val_prohibited_val)); // Permit to write data to div_en
always @(posedge sys_clk or negedge sys_rst_n) begin
    if(!sys_rst_n) div_en<=1'b0;
    else begin
        if(div_en_sel) div_en<=tim_pwdata[1];
        else div_en<=div_en;
    end
end

//div_val Write Transfer
assign div_val_sel=TCR_sel & ( (tim_pwdata==32'h0) | (tim_pstrobe[1] & !timer_en & (tim_pwdata[11:8]<9)));
always @(posedge sys_clk or negedge sys_rst_n) begin
    if(!sys_rst_n) div_val<=4'h1;
    else begin
        if(div_val_sel) div_val<=tim_pwdata[11:8];
        else div_val<=div_val;
    end
end

//===== TDR0/1 Logic =====================
//TDR2
assign TDR0_sel= wr_en & (tim_paddr==ADDR_TDR0);
always @(posedge sys_clk or negedge sys_rst_n) begin
    if(!sys_rst_n) TDR0_store<=32'h0;
    else begin
            if(timer_en_fall) TDR0_store<=32'h0;
            else begin
                    if(TDR0_sel) begin
                        if(tim_pstrobe[0]) TDR0_store[7:0]<=tim_pwdata[7:0];
                        if(tim_pstrobe[1]) TDR0_store[15:8]<=tim_pwdata[15:8];
                        if(tim_pstrobe[2]) TDR0_store[23:16]<=tim_pwdata[23:16];
                        if(tim_pstrobe[3]) TDR0_store[31:24]<=tim_pwdata[31:24];
                    end
                    else begin
                            if(count_en) TDR0_store<=TDR0_store+1;
                            else TDR0_store<=TDR0_store;
                         end
                  end
          end
end

//TDR1
assign TDR1_sel= wr_en & (tim_paddr==ADDR_TDR1);
always @(posedge sys_clk or negedge sys_rst_n) begin
    if(!sys_rst_n) TDR1_store<=32'h0;
    else begin
            if(timer_en_fall) TDR1_store<=32'h0;
            else begin
                    if(TDR1_sel) begin
                        if(tim_pstrobe[0]) TDR1_store[7:0]<=tim_pwdata[7:0];
                        if(tim_pstrobe[1]) TDR1_store[15:8]<=tim_pwdata[15:8];
                        if(tim_pstrobe[2]) TDR1_store[23:16]<=tim_pwdata[23:16];
                        if(tim_pstrobe[3]) TDR1_store[31:24]<=tim_pwdata[31:24];
                    end
                    else begin
                            if(count_en && TDR0_store==32'hFFFF_FFFF) TDR1_store<=TDR1_store+1;
                            else TDR1_store<=TDR1_store;
                         end
                  end
          end
end

//====== TCMP0/1 Logic ====================
//TCMP0
assign TCMP0_sel=wr_en & (tim_paddr==ADDR_TCMP0);
always @(posedge sys_clk or negedge sys_rst_n) begin
    if(!sys_rst_n) TCMP0_store<=32'hFFFF_FFFF;
    else begin
            if(TCMP0_sel) begin
                        if(tim_pstrobe[0]) TCMP0_store[7:0]<=tim_pwdata[7:0];
                        if(tim_pstrobe[1]) TCMP0_store[15:8]<=tim_pwdata[15:8];
                        if(tim_pstrobe[2]) TCMP0_store[23:16]<=tim_pwdata[23:16];
                        if(tim_pstrobe[3]) TCMP0_store[31:24]<=tim_pwdata[31:24];
            end
            else TCMP0_store<=TCMP0_store;
          end
end
//TCMP1
assign TCMP1_sel=wr_en & (tim_paddr==ADDR_TCMP1);
always @(posedge sys_clk or negedge sys_rst_n) begin
    if(!sys_rst_n) TCMP1_store<=32'hFFFF_FFFF;
    else begin
            if(TCMP1_sel) begin
                        if(tim_pstrobe[0]) TCMP1_store[7:0]<=tim_pwdata[7:0];
                        if(tim_pstrobe[1]) TCMP1_store[15:8]<=tim_pwdata[15:8];
                        if(tim_pstrobe[2]) TCMP1_store[23:16]<=tim_pwdata[23:16];
                        if(tim_pstrobe[3]) TCMP1_store[31:24]<=tim_pwdata[31:24];
            end
            else TCMP1_store<=TCMP1_store;
          end
end

//===== TIER Logic ====================
assign TIER_sel=wr_en & (tim_paddr==ADDR_TIER) & tim_pstrobe[0];
always @(posedge sys_clk or negedge sys_rst_n) begin
    if(!sys_rst_n) int_en<=1'b0;
    else begin
            if(TIER_sel) int_en<=tim_pwdata[0];
            else int_en<=int_en;
          end
end

//===== TISR Logic ====================
assign TISR_sel=wr_en & (tim_paddr==ADDR_TISR);
assign int_st_clr= TISR_sel & tim_pstrobe[0] & tim_pwdata[0]; //Logic for detection write 1 to clear int_st
assign equal_condition= (TDR0_store==TCMP0_store) && (TDR1_store==TCMP1_store); // Trigger condition occurs
always @(posedge sys_clk or negedge sys_rst_n) begin
    if(!sys_rst_n) int_st<=1'b0;
    else begin 
            if(int_st_clr) int_st<=1'b0;
            else begin
                    if(equal_condition) int_st<=1'b1;
                    else int_st<=int_st;
                  end
          end
end

//===== THCSR Logic ====================
assign THCSR_sel= wr_en & (tim_paddr==ADDR_THCSR) & tim_pstrobe[0];
always @(posedge sys_clk or negedge sys_rst_n) begin
    if(!sys_rst_n) halt_req<=1'b0;
    else begin 
            if(THCSR_sel) halt_req<=tim_pwdata[0];
            else halt_req<=halt_req;
          end
end

//=========================================================================
//==== LOGIC FOR PROHIBITED WRITE ACCESS & ERROR RESPONSE LOGIC  ==========
//=========================================================================
assign div_en_prohibited_change=timer_en & tim_pstrobe[0] & (tim_pwdata[0]!=div_en);
assign div_val_prohibited_change=timer_en & tim_pstrobe[1] & (tim_pwdata[11:8]!=div_val);
assign div_val_prohibited_val=tim_pstrobe[1] & (tim_pwdata[11:8]>8);
assign tim_pslverr= div_en_prohibited_change | div_val_prohibited_change | div_val_prohibited_val;


//=============================================
//==== LOGIC DESIGN (READ TRANSFER) ==========
//=============================================

always @(*) begin
    if(!rd_en) tim_prdata=32'h0;
    else begin
            case(tim_paddr)
                    ADDR_TCR:    tim_prdata={20'h0, div_val, 6'h0, div_en,timer_en};
                    ADDR_TDR0:   tim_prdata=TDR0_store;
                    ADDR_TDR1:   tim_prdata=TDR1_store;
                    ADDR_TCMP0:  tim_prdata=TCMP0_store;
                    ADDR_TCMP1:  tim_prdata=TCMP1_store;
                    ADDR_TIER:   tim_prdata={31'h0, int_en};
                    ADDR_TISR:   tim_prdata={31'h0, int_st};
                    ADDR_THCSR:  tim_prdata={30'h0, halt_ack, halt_req};
                    default:     tim_prdata=32'h0;
             endcase
          end
end
endmodule


