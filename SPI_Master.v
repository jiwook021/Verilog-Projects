`timescale 1ns / 1ps

module SPI_Master
#(parameter clock_param = 10)
(
    // Port Declaration
    clk, MISO, MOSI, SCLK, CS, data_received
);
    // Port Declaration
    input clk;                          // 100MHz
    input MISO;                         // Master Input Slave Output
    output MOSI;                        // Master Output Slave Input
    output SCLK;                        // SPI Clock
    output CS;                          // Chip Select
    output reg [7:0] data_received;     // Data received from Slave
    
    
    reg [7:0] data_read_buffer;                                     // buffer for data read
    reg [15:0] data_write_buffer = 16'b0000_1011_0000_1001;         // buffer for data write
    reg [4:0] data_count = 0;                                       // clock counting 
    reg cs_value = 1;                                               // CS value
    wire [4:0] count_update;                                        // clock counting
    
    assign CS = cs_value;
    
    // Generate SPI Clock
    Clock_Divider #(clock_param) m10 (clk, SCLK);
    
    // ----------------------------------------------------------------
    // SPI Protocol
    // 1. CS' High -> Low
    // 2. write data load
    // 3. send data to slave and shift wrtie data buffer
    // 4. repeat step 16 times (send Instruction & Address)
    // 5. read data from Slave and shift read data buffer for 8 times
    // 6. load read data buffer to data_received
    // 7. CS' Low -> High
    // 8. repeat process from step 1.
    // ----------------------------------------------------------------
    
    // Data send to Slave at rising edge of SCLK
    // Data read from Slave at falling edge of SCLK
	// Fill the always block
    always @ (negedge SCLK)
    begin
        if(cs_value == 1)
        begin
            cs_value <=  ;
            data_write_buffer <=           ;
        end
        else if (data_count == )
        begin
            data_received <=   ;
            cs_value <=   ;
            data_count <=   ;
        end
        else
        begin
            data_count <= count_update;
        end
        data_write_buffer <=    ;   
    end
    
    always @ (posedge SCLK)
    begin
        data_read_buffer <= {data_read_buffer[6:0], MISO};
    end

assign count_update = data_count + 1;
assign MOSI = data_write_buffer[  ]; // <- Complete this part

endmodule
