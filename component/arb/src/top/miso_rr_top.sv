module miso_rr_top #(
    parameter       CHANNEL_NUM = 8     ,
    parameter       DATA_WIDTH  = 128   ,
    parameter       ADDR_WIDTH  = 9     ,
    parameter       OUTPUT_INT  = 1     ,
    parameter       MIN_LEN     = 1     ,
    parameter       MAX_LEN     = 100   ,
    parameter       SEOP_CHECK  = "ON"  ,
    parameter       ERROR_CHECK = "ON"  ,
    parameter       RAM_TYPE    = "BRAM"
)(
    input   logic                       clock           ,
    input   logic                       reset           ,

    output  logic                       channel0_busy   ,
    input   logic                       channel0_sop    ,
    input   logic                       channel0_eop    ,
    input   logic                       channel0_valid  ,
    input   logic   [DATA_WIDTH-1:0]    channel0_data   ,
    input   logic   [3:0]               channel0_bytes  ,
    input   logic                       channel0_error  ,
);
    
endmodule