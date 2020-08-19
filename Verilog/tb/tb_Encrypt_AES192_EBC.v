`timescale 1ns / 1ps

module tb_Encrypt_AES192_EBC();

   parameter DATA_WIDTH = 8;
   localparam INOUT_WIDTH = 8*16;

   reg                        clk_i;
   reg                        rst_n_i;
   reg                        enable_i;
   reg                        process_start_i;

   wire                       busy_o;
   reg   [INOUT_WIDTH-1: 0]   bytes_i;
   
   wire  [INOUT_WIDTH-1: 0]   bytes_o;
   
   wire                       bytes_valid_o;

   integer i=0,j=0;
   reg   [DATA_WIDTH-1: 0]    bytes_i_r [0:127];

   Encrypt_AES192_ECB
   inst
   (
      .clk_i               ( clk_i ),
      .rst_n_i             ( rst_n_i ),
      .enable_i            ( enable_i ),
      .process_start_i     ( process_start_i ),
      .busy_o              ( busy_o ),
      .bytes_i             ( bytes_i),
      .bytes_o             ( bytes_o ),
      .bytes_valid_o       ( bytes_valid_o )

   );

   initial begin
      clk_i = 0;
      rst_n_i = 0;
      enable_i = 0;
      process_start_i = 0;

      $readmemh("text.hex",bytes_i_r);
      #20;

      rst_n_i =1;
      @(posedge clk_i) enable_i = 1;
      
      for(i=0;i<8;i=i+1) begin
         j = i*16+15;
         @(posedge clk_i) bytes_i      <=#1 {bytes_i_r[i*16+15],bytes_i_r[i*16+14],bytes_i_r[i*16+13],bytes_i_r[i*16+12],
                                             bytes_i_r[i*16+11],bytes_i_r[i*16+10],bytes_i_r[i*16+ 9],bytes_i_r[i*16+ 8],
                                             bytes_i_r[i*16+ 7],bytes_i_r[i*16+ 6],bytes_i_r[i*16+ 5],bytes_i_r[i*16+ 4],
                                             bytes_i_r[i*16+ 3],bytes_i_r[i*16+ 2],bytes_i_r[i*16+ 1],bytes_i_r[i*16+ 0]};

                          process_start_i <=#1 1;
      end
      @(posedge clk_i) process_start_i <=#1 0;
      #800;
      $finish;

   end

   always #5 clk_i = ~clk_i;

endmodule