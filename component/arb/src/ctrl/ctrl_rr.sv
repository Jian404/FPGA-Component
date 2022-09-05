module ctrl_rr#(
    parameter       CHANNEL_NUM = 8     ,
    parameter       DATA_WIDTH  = 128    
)(
    input   logic                       clock       ,
    input   logic                       reset       ,

    input   logic   [CHANNEL_NUM-1:0]   i_ready     ,
    input   logic   [CHANNEL_NUM-1:0]   i_eop       ,
    output  logic   [CHANNEL_NUM-1:0]   o_sel       
);




endmodule