module counter_control(
    input wire sys_clk,
    input wire sys_rst_n,
    input wire timer_en,
    input wire div_en,
    input wire [3:0] div_val,
    input wire halt_req,
    input wire dbg_mode,
    output wire count_en,
    output wire halt_ack,
    output wire timer_en_fall
);

//===================================
//=== INTERNAL SIGNAL DECLARTION ====
//===================================

// Internal signal for generation of count_en
wire default_cnt_mode; // Counts in case of default mode
wire div_val_0_mode;   // Counts in case div_val = 0
wire control_cnt_mode; // Counts in control mode
wire count_en_pre;

//Internal signal for cycle division for counting 
reg [7:0] cycle_limit;
reg [7:0] cycle_count;
wire cycle_cnt_done;

//Internal signal for timer_en_fall logic
reg timer_en_pre;

//===================================
//=== LOGIC DESIGN ==================
//===================================


//============================================
//==== CYCLE DIVISION FOR COUNTING LOGIC =====
//Decode the divisor value set

always @(*) begin
    case(div_val) 
        4'd0: cycle_limit=8'd0;
        4'd1: cycle_limit=8'd1;
        4'd2: cycle_limit=8'd3;
        4'd3: cycle_limit=8'd7;
        4'd4: cycle_limit=8'd15;
        4'd5: cycle_limit=8'd31;
        4'd6: cycle_limit=8'd63;
        4'd7: cycle_limit=8'd127;
        4'd8: cycle_limit=8'd255;
        default: cycle_limit=8'd1;
    endcase
end

//Signal for finishing counting cycle
assign cycle_cnt_done= (cycle_count==cycle_limit) ? 1 : 0;
// Count the cycle according to divisor value set
always @(posedge sys_clk or negedge sys_rst_n) begin
    if(!sys_rst_n) cycle_count<=8'h0;
    else begin
            if(halt_ack) cycle_count<=cycle_count;
            else begin
                if(cycle_cnt_done==1 || div_en==0 || timer_en==0) cycle_count<=8'h0;
                    else cycle_count<=cycle_count+1;
                 end
         end
end
//=======================================
//=======================================


//=======================================
//==== HALT LOGIC =======================

assign halt_ack= dbg_mode & halt_req;
//=======================================
//=======================================


//=======================================
//==== COUNT_EN GENERATION LOGIC ========

assign default_cnt_mode= timer_en &(~div_en);
assign div_val_0_mode=timer_en & (div_en) & (div_val==0);
assign control_cnt_mode=timer_en & (div_en)  & cycle_cnt_done;
assign count_en_pre=default_cnt_mode | div_val_0_mode | control_cnt_mode;

// Ouput logic of count_en
assign count_en= count_en_pre & (~halt_ack);

//=======================================
//=======================================



//======================================
//===== TIMER_EN FALL LOGIC ============
always @(posedge sys_clk or negedge sys_rst_n) begin
    if(!sys_rst_n) timer_en_pre<=1'b0;
    else timer_en_pre<= timer_en;
end

//Ouput logic of timer_en_fall
assign timer_en_fall = timer_en_pre & (~timer_en);
endmodule
