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
//                     module- round(Pipelined roundmodule controller)
// Dependencies    : 
// References      : 
//
//**************************************************************************************************
   
`timescale 1ns / 1ps

module round(
   clk_i,
   rst_n_i,

   enable_i,
   process_start_i,
   busy_o,

   bytes_i,
   round_key_i,

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
   input      [INOUT_WIDTH-1:0]        round_key_i;

   output reg [INOUT_WIDTH-1:0]        bytes_o;

   output                              busy_o;
   output                              bytes_valid_o;


//---------------------------------------------------------------------------------------------------------------------
// Internal wires and registers
//---------------------------------------------------------------------------------------------------------------------
   
   reg        [3:0]                    r_process_start;
   reg        [INOUT_WIDTH-1:0]        r_bytes_in [0:3];

   wire       [INOUT_WIDTH-1:0]        w_bytes_out [0:3];
   wire       [3:0]                    w_bytes_valid_out;

   reg        [2:0]                    counter;


//---------------------------------------------------------------------------------------------------------------------
// Implmentation
//---------------------------------------------------------------------------------------------------------------------


   assign bytes_valid_o = w_bytes_valid_out[0] ? 1 : (w_bytes_valid_out[1] ? 1 : (w_bytes_valid_out[2] ? 1 : ( w_bytes_valid_out[3] ? 1 : 0)));


   always@(posedge clk_i or negedge rst_n_i) begin
      if(~rst_n_i) begin
         counter     = 0;
      end
      else if(enable_i) begin
         if(process_start_i) begin
            case( counter) 
               3'd0: begin
                     r_process_start [0]   <=#1 1;
                     r_process_start [1]   <=#1 0;
                     r_process_start [2]   <=#1 0;
                     r_process_start [3]   <=#1 0;
                     r_bytes_in[0]         <=#1 bytes_i;
                     //bytes_o               <=#1 w_bytes_out [3];
                     counter               <=#1 counter + 1;
                     end

               3'd1: begin
                     r_process_start [0]   <=#1 0;
                     r_process_start [1]   <=#1 1;
                     r_process_start [2]   <=#1 0;
                     r_process_start [3]   <=#1 0;
                     r_bytes_in[1]         <=#1 bytes_i;
                     //bytes_o               <=#1 w_bytes_out [2];
                     counter               <=#1 counter + 1;
                     end

               3'd2: begin
                     r_process_start [0]   <=#1 0;
                     r_process_start [1]   <=#1 0;
                     r_process_start [2]   <=#1 1;
                     r_process_start [3]   <=#1 0;
                     r_bytes_in[2]         <=#1 bytes_i;
                     //bytes_o               <=#1 w_bytes_out [1];
                     counter               <=#1 counter + 1;
                     end

               3'd3: begin
                     r_process_start [0]   <=#1 0;
                     r_process_start [1]   <=#1 0;
                     r_process_start [2]   <=#1 0;
                     r_process_start [3]   <=#1 1;
                     r_bytes_in[3]         <=#1 bytes_i;
                     //bytes_o               <=#1 w_bytes_out [0];
                     counter               <=#1 0;
                     end
            endcase
         end
      end
   end

   always@(*) begin
      if(~rst_n_i) begin
         bytes_o = 0;
      end
      else if(enable_i) begin
         
            if(w_bytes_valid_out[0])
               bytes_o = w_bytes_out[0];
            else if(w_bytes_valid_out[1])
               bytes_o = w_bytes_out[1];
            else if(w_bytes_valid_out[2])
               bytes_o = w_bytes_out[2];
            else if(w_bytes_valid_out[3])
               bytes_o = w_bytes_out[3];
         
      end
   end





   roundModule
   roundModule_inst_1
   (
      .clk_i                  ( clk_i ),
      .rst_n_i                ( rst_n_i ),
      .enable_i               ( enable_i ),
      .process_start_i        ( r_process_start[0] ),
      .busy_o                 (  ),
      .bytes_i                ( r_bytes_in[0] ),
      .round_key_i            ( round_key_i ),
      .bytes_o                ( w_bytes_out[0] ),
      .bytes_valid_o          ( w_bytes_valid_out[0] )

   );

   roundModule
   roundModule_inst_2
   (
      .clk_i                  ( clk_i ),
      .rst_n_i                ( rst_n_i ),
      .enable_i               ( enable_i ),
      .process_start_i        ( r_process_start[1] ),
      .busy_o                 (  ),
      .bytes_i                ( r_bytes_in[1] ),
      .round_key_i            ( round_key_i ),
      .bytes_o                ( w_bytes_out[1] ),
      .bytes_valid_o          ( w_bytes_valid_out[1] )

   );

   roundModule
   roundModule_inst_3
   (
      .clk_i                  ( clk_i ),
      .rst_n_i                ( rst_n_i ),
      .enable_i               ( enable_i ),
      .process_start_i        ( r_process_start[2] ),
      .busy_o                 (  ),
      .bytes_i                ( r_bytes_in[2] ),
      .round_key_i            ( round_key_i ),
      .bytes_o                ( w_bytes_out[2] ),
      .bytes_valid_o          ( w_bytes_valid_out[2] )

   );

   roundModule
   roundModule_inst_4
   (
      .clk_i                  ( clk_i ),
      .rst_n_i                ( rst_n_i ),
      .enable_i               ( enable_i ),
      .process_start_i        ( r_process_start[3] ),
      .busy_o                 (  ),
      .bytes_i                ( r_bytes_in[3] ),
      .round_key_i            ( round_key_i ),
      .bytes_o                ( w_bytes_out[3] ),
      .bytes_valid_o          ( w_bytes_valid_out[3] )

   );
   
      
endmodule