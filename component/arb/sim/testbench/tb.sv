module tst;
logic           clock_100m;
logic           reset;

logic           wrEnIn;
logic           wrDataIn;
logic           rdEnIn;
logic           rdDataOut;

always #5 clock_100m = ~clock_100m;

initial begin
    clock_100m = 'b0;
    reset      = 'b0;
    wrEnIn     = 'b0;
    wrDataIn   = 'b0;
    rdEnIn     = 'b0;
end

initial begin
    $fsdbDumpfile("tst.fsdb");
    $fsdbDumpvars;
end

initial begin
    sys_reset;
    wr_fifo(20);
    rd_fifo(20);
    #1000;
    $finish;
end

task sys_reset;
begin
    #20;
    reset = 1;
    #300;
    reset = 0;
    #30;
end
endtask

task wr_fifo;
input   [7:0]   len;
begin
    repeat(len)begin
    @(posedge clock_100m);
    wrEnIn = 1;
    wrDataIn = $random;
    end
    @(posedge clock_100m);
    wrEnIn = 0;
    wrDataIn = 0;
end
endtask

task rd_fifo;
input   [7:0]   len;
begin
    repeat(len)begin
    @(posedge clock_100m);
    rdEnIn = 1;
    end 
    @(posedge clock_100m);
    rdEnIn = 0;
end
endtask

sync_fifo#(
    .DATA_WIDTH         (8      ),
    .ADDR_WIDTH         (8      ),
    .AF_THRESHOLD       (255    ),
    .AE_THRESHOLD       (1      ),
    .RAM_TYPE           ("BRAM" )
)sync_fifo_inst(
    .clock              (clock_100m ),
    .reset              (reset      ),

    .wrEnIn             (),
    .wrDataIn           (),
    .rdEnIn             (),
    .rdDataOut          (),

    .full               (),
    .almostfull         (),
    .empty              (),
    .almostempty        (),

    .overflow           (),
    .underflow          ()
);


endmodule