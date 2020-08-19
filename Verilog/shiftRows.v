//********************************* DO NOT DELETE **************************************************
// Copyright (c) 2014 Intelligent Machineries International (Pvt) Ltd - (IMI) 
// All Rights Reserved.
//
// THIS FILE MAY NOT BE MODIFIED OR REDISTRIBUTED WITHOUT THE EXPRESSED WRITTEN CONSENT OF IMI.
// THIS COPYRIGHT STATEMENTS MUST NEVER BE REMOVED FROM THIS FILE.
//
// Machineries International (Pvt) Ltd.               web  : http://www.intelligentmachineries.com
// 252/4, Horana Rd., Miriswatta,                     email: info@intelligentmachineries.com
// Piliyandala, 10300, Sri Lanka
//  
//********************************* DO NOT DELETE **************************************************
// Date Last Modified: Oct 31 2014
// Date Created      : Oct 21 2014 
//
// Target Device   : <target device if aplicable>     eg: Xilinx Spartan®-6 LX45 
// Target Platform : <target platform if aplicable>   eg: Atlys™ Spartan-6 FPGA Development Board
// Target Tool     : <tool(s) used if aplicable>      eg: ISE 12.1 sp1
// Libraries used  : <library if any>                 eg: UNISIM 
// 
// Revision History: 
//  Revision   Date        Author               Description
//  --------   ----        ------               -----
//  0.1        2015/02/13  Anusha Manoj         First created 
// End Revision
//
//**************************************************************************************************
// Project/Product : AES Encryption
// Description     : Advanced Encryption System Hardware implementaton
//                     module- shiftRows
// Dependencies    : 
// References      : 
//
//**************************************************************************************************
   
`timescale 1ns / 1ps

module shiftRows(
   clk_i,
   rst_n_i,

   enable_i,
   process_start_i,
   busy_o,

   bytes_i,

   bytes_o,

   bytes_valid_o,

);

//----------------------------------------------------------------------------------------------------------------------
// Global constant and function headers
//----------------------------------------------------------------------------------------------------------------------


//----------------------------------------------------------------------------------------------------------------------
// parameter definitions
//----------------------------------------------------------------------------------------------------------------------

   parameter                           DATA_WIDTH          = 8;

//----------------------------------------------------------------------------------------------------------------------
// localparam definitions
//----------------------------------------------------------------------------------------------------------------------
 
   localparam                          INOUT_WIDTH         = DATA_WIDTH*16;
//----------------------------------------------------------------------------------------------------------------------
// I/O signals
//----------------------------------------------------------------------------------------------------------------------

   //System Control Signals
   input                               clk_i;
   input                               rst_n_i;
   
   //Module Control Signals
   input                               enable_i;
   input                               process_start_i;

   input      [INOUT_WIDTH-1:0]        bytes_i;

   output     [INOUT_WIDTH-1:0]        bytes_o;

   output reg                          busy_o;
   output reg                          bytes_valid_o;

   integer i;


//---------------------------------------------------------------------------------------------------------------------
// Internal wires and registers
//---------------------------------------------------------------------------------------------------------------------

   wire       [DATA_WIDTH-1:0]         w_byte_in [0:15];
   reg        [DATA_WIDTH-1:0]         r_byte_out [0:15];


//---------------------------------------------------------------------------------------------------------------------
// Implmentation
//---------------------------------------------------------------------------------------------------------------------


`ifdef INITIALIZATION
   initial begin
     for(i=0; i < 16; i = i+1) begin
         r_byte_out[i] = 8'd0;

     end
     bytes_valid_o  = 0;
     busy_o         = 0;

   end
`endif

   assign bytes_o = {r_byte_out[15],r_byte_out[14],r_byte_out[13],r_byte_out[12],
                     r_byte_out[11],r_byte_out[10],r_byte_out[9],r_byte_out[8],
                     r_byte_out[7],r_byte_out[6],r_byte_out[5],r_byte_out[4],
                     r_byte_out[3],r_byte_out[2],r_byte_out[1],r_byte_out[0]};

   assign {          w_byte_in[15],w_byte_in[14],w_byte_in[13],w_byte_in[12],
                     w_byte_in[11],w_byte_in[10],w_byte_in[9], w_byte_in[8],
                     w_byte_in[7], w_byte_in[6], w_byte_in[5], w_byte_in[4],
                     w_byte_in[3], w_byte_in[2], w_byte_in[1], w_byte_in[0]} = bytes_i;
  
   
 
   always @(posedge clk_i or negedge rst_n_i) begin 
      if(~rst_n_i) begin
         for(i=0; i < 16; i = i+1) begin
            r_byte_out[i]  = 8'd0;

         end
         bytes_valid_o     = 0;
         busy_o            = 0;
      end
      else if(enable_i) begin
         if(process_start_i) begin

            //first row
            for(i =0;i<4;i=i+1) begin
               r_byte_out[i*4] <=#1 w_byte_in[i*4];
            end

            // second row
            r_byte_out [1]   <=#1 w_byte_in[5];
            r_byte_out [5]   <=#1 w_byte_in[9];
            r_byte_out [9]   <=#1 w_byte_in[13];
            r_byte_out [13]  <=#1 w_byte_in[1];

            //third row
            r_byte_out [2]   <=#1 w_byte_in[10];
            r_byte_out [6]   <=#1 w_byte_in[14];
            r_byte_out [10]  <=#1 w_byte_in[2];
            r_byte_out [14]  <=#1 w_byte_in[6];

            //fourth row
            r_byte_out [3]   <=#1 w_byte_in[15];
            r_byte_out [7]   <=#1 w_byte_in[3];
            r_byte_out [11]  <=#1 w_byte_in[7];
            r_byte_out [15]  <=#1 w_byte_in[11];

            bytes_valid_o <=#1 1;
            busy_o        <=#1 1;
         end
         else begin
            bytes_valid_o <=#1 0;
            busy_o        <=#1 0;
         end
      end
    end
      
endmodule