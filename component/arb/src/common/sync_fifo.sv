module sync_fifo#(
    parameter   DATA_WIDTH   = 8     ,
    parameter   ADDR_WIDTH   = 4     ,
    parameter   AF_THRESHOLD = 15    ,
    parameter   AE_THRESHOLD = 1     ,
    parameter   RAM_TYPE     = "BRAM"
)(
    input   logic                   clock       ,
    input   logic                   reset       ,

    input   logic                   wrEnIn      ,
    input   logic [DATA_WIDTH-1:0]  wrDataIn    ,
    input   logic                   rdEnIn      ,
    output  logic [DATA_WIDTH-1:0]  rdDataOut   ,

    output  logic                   full        ,
    output  logic                   almostfull  ,
    output  logic                   empty       ,
    output  logic                   almostempty ,

    output  logic                   overflow    ,
    output  logic                   underflow   
);

logic                       wrEn    ;
logic                       rdEn    ;
logic   [ADDR_WIDTH-1:0]    wrAddr  ;
logic   [ADDR_WIDTH-1:0]    rdAddr  ;

logic   [ADDR_WIDTH:0]      count   ;

assign wrEn = wrEnIn && !full;
assign rdEn = rdEnIn && !empty;

assign overflow = wrEnIn && full;
assign underflow = rdEnIn && empty;

always_ff@(posedge clock)begin
    if(reset)begin
        wrAddr <= 0;
    end
    else begin
        wrAddr <= wrAddr + wrEn;
    end
end

always_ff@(posedge clock)begin
    if(reset)begin
        rdAddr <= 0;
    end
    else begin
        rdAddr <= rdAddr + rdEn;
    end
end

always_ff@(posedge clock)begin
    if(reset)begin
        count <= 0;
    end
    else begin
        count <= count + wrEn - rdEn;
    end
end

assign full = count[ADDR_WIDTH]; 

always_ff@(posedge clock)begin
    if(reset)begin
        empty <= 1;
    end
    else if(wrEn && count == 0)begin
        empty <= 0;
    end
    else if(rdEn && !wrEn && count == 1)begin
        empty <= 1;
    end
end

always_ff@(posedge clock)begin
    if(reset)begin
        almostempty <= 1;
    end
    else if(wrEn && !rdEn && count == AE_THRESHOLD)begin
        almostempty <= 0;
    end
    else if(!wrEn && rdEn && count == AE_THRESHOLD+1)begin
        almostempty <= 1;
    end
end

always_ff@(posedge clock)begin
    if(reset)begin
        almostfull <= 0;
    end
    else if(wrEn && !rdEn && count == AF_THRESHOLD-1)begin
        almostfull <= 1;
    end
    else if(!wrEn && rdEn && count == AF_THRESHOLD)begin
        almostfull <= 0;
    end
end

bram_arw_brx #(
    .DATA_WIDTH         (DATA_WIDTH ),
    .ADDR_WIDTH         (ADDR_WIDTH )
)bram_arw_brx_inst(
    .clockIn_a          (clock      ),
    .enIn_a             (1'b1       ),
    .wrEnIn_a           (wrEnIn     ),
    .addrIn_a           (wrAddr     ),
    .dataIn_a           (wrDataIn   ),
    .dataOut_a          (),

    .clockIn_b          (clock      ),
    .enIn_b             (1'b1       ),
    .addrIn_b           (rdAddr     ),
    .dataOut_b          (rdDataOut  )
);
 

endmodule