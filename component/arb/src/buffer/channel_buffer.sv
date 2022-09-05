module channel_buffer#(
    parameter       DATA_WIDTH  = 128    ,
    parameter       ADDR_WIDTH  = 9      ,
    parameter       MIN_LEN     = 1      ,
    parameter       MAX_LEN     = 100    ,
    parameter       SEOP_CHECK  = "ON"   ,
    parameter       ERROR_CHECK = "ON"   ,
    parameter       RAM_TYPE    = "BRAM"
)(
    input   logic                       clock       ,
    input   logic                       reset       ,

    output  logic                       o_busy      ,
    input   logic                       i_sop       ,
    input   logic                       i_eop       ,
    input   logic                       i_valid     ,
    input   logic   [DATA_WIDTH-1:0]    i_data      ,
    input   logic   [3:0]               i_bytes     ,
    input   logic                       i_error     ,

    output  logic                       o_sop       ,
    output  logic                       o_eop       ,
    output  logic                       o_valid     ,
    output  logic   [DATA_WIDTH-1:0]    o_data      ,
    output  logic   [3:0]               o_bytes     ,
    output  logic                       o_error     ,

    output  logic                       ctrl_ready  ,
    output  logic                       ctrl_eop    ,
    input   logic                       ctrl_sel     
);




endmodule