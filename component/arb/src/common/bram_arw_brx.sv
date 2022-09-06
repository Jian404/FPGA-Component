module bram_arw_brx #(
    parameter       DATA_WIDTH = 8  ,
    parameter       ADDR_WIDTH = 1  
) (
    input                       clockIn_a       ,
    input                       enIn_a          ,
    input                       wrEnIn_a        ,
    input   [ADDR_WIDTH-1:0]    addrIn_a        ,
    input   [DATA_WIDTH-1:0]    dataIn_a        ,
    output                      dataOut_a       ,

    input                       clockIn_b       ,
    input                       enIn_b          ,
    input   [ADDR_WIDTH-1:0]    addrIn_b        ,
    output                      dataOut_b       
);

localparam      MEM_SIZE        =2**ADDR_WIDTH  ;

reg     [DATA_WIDTH-1:0]    ramData[MEM_SIZE-1:0];

reg     [DATA_WIDTH-1:0]    ramDataRegOut_a     ;
reg     [DATA_WIDTH-1:0]    ramDataRegOut_b     ;

always_ff@(posedge clockIn_a)begin
    if(enIn_a)begin
        if(wrEnIn_a)begin
            ramData[addrIn_a] <= dataIn_a;
        end

        if(wrEnIn_a)begin
            ramDataRegOut_a <= dataIn_a;
        end
        else begin
            ramDataRegOut_a <= ramData[addrIn_a];
        end
    end
end

assign dataOut_a = ramDataRegOut_a;

always_ff@(posedge clockIn_b)begin
    if(enIn_b)begin
        ramDataRegOut_b <= ramData[addrIn_b];
    end 
end

assign dataOut_b = ramDataRegOut_b;
/*
initial begin
    for(int i = 0; i < MEM_SIZE; i = i + 1)begin
        ramData[i] = {DATA_WIDTH{1'b0}};
    end
end
*/
endmodule