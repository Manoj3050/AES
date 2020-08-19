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
//                     module- encrypt
// Dependencies    : 
// References      : 
//
//**************************************************************************************************
   
`timescale 1ns / 1ps

module encrypt(
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
   localparam                          KEY_WIDTH           = DATA_WIDTH*16*11;
    
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
   input      [KEY_WIDTH-1:0]          round_key_i;

   output     [INOUT_WIDTH-1:0]        bytes_o;

   output                              busy_o;
   output                              bytes_valid_o;


//---------------------------------------------------------------------------------------------------------------------
// Internal wires and registers
//---------------------------------------------------------------------------------------------------------------------
   

   wire       [INOUT_WIDTH-1:0]        w_bytes_out [0:11];
   wire       [11:0]                    w_bytes_valid_out;

   wire       [INOUT_WIDTH-1:0]        w_roundKey [0:10];


//---------------------------------------------------------------------------------------------------------------------
// Implmentation
//---------------------------------------------------------------------------------------------------------------------


   assign {         w_roundKey[10],w_roundKey[9], w_roundKey[8],
                     w_roundKey[7], w_roundKey[6], w_roundKey[5], w_roundKey[4],
                     w_roundKey[3], w_roundKey[2], w_roundKey[1], w_roundKey[0]} = round_key_i;


   

   addRoundKey
   addround_key_0
   (

      .clk_i                  ( clk_i ),
      .rst_n_i                ( rst_n_i ),
      .enable_i               ( enable_i ),
      .process_start_i        ( process_start_i ),
      .busy_o                 (  ),
      .bytes_i                ( bytes_i ),
      .round_key_i            ( w_roundKey[0] ),
      .bytes_o                ( w_bytes_out[0] ),
      .bytes_valid_o          ( w_bytes_valid_out[0] )

   );



   round
   round_inst_1
   (
      .clk_i                  ( clk_i ),
      .rst_n_i                ( rst_n_i ),
      .enable_i               ( enable_i ),
      .process_start_i        ( w_bytes_valid_out[0] ),
      .busy_o                 (  ),
      .bytes_i                ( w_bytes_out[0] ),
      .round_key_i            ( w_roundKey[1] ),
      .bytes_o                ( w_bytes_out[1] ),
      .bytes_valid_o          ( w_bytes_valid_out[1] )

   );

   round
   round_inst_2
   (
      .clk_i                  ( clk_i ),
      .rst_n_i                ( rst_n_i ),
      .enable_i               ( enable_i ),
      .process_start_i        ( w_bytes_valid_out[1] ),
      .busy_o                 (  ),
      .bytes_i                ( w_bytes_out[1] ),
      .round_key_i            ( w_roundKey[2] ),
      .bytes_o                ( w_bytes_out[2] ),
      .bytes_valid_o          ( w_bytes_valid_out[2] )

   );

   round
   round_inst_3
   (
      .clk_i                  ( clk_i ),
      .rst_n_i                ( rst_n_i ),
      .enable_i               ( enable_i ),
      .process_start_i        ( w_bytes_valid_out[2] ),
      .busy_o                 (  ),
      .bytes_i                ( w_bytes_out[2] ),
      .round_key_i            ( w_roundKey[3] ),
      .bytes_o                ( w_bytes_out[3] ),
      .bytes_valid_o          ( w_bytes_valid_out[3] )

   );

   round
   round_inst_4
   (
      .clk_i                  ( clk_i ),
      .rst_n_i                ( rst_n_i ),
      .enable_i               ( enable_i ),
      .process_start_i        ( w_bytes_valid_out[3] ),
      .busy_o                 (  ),
      .bytes_i                ( w_bytes_out[3] ),
      .round_key_i            ( w_roundKey[4] ),
      .bytes_o                ( w_bytes_out[4] ),
      .bytes_valid_o          ( w_bytes_valid_out[4] )

   );

   round
   round_inst_5
   (
      .clk_i                  ( clk_i ),
      .rst_n_i                ( rst_n_i ),
      .enable_i               ( enable_i ),
      .process_start_i        ( w_bytes_valid_out[4] ),
      .busy_o                 (  ),
      .bytes_i                ( w_bytes_out[4] ),
      .round_key_i            ( w_roundKey[5] ),
      .bytes_o                ( w_bytes_out[5] ),
      .bytes_valid_o          ( w_bytes_valid_out[5] )

   );
   round
   round_inst_6
   (
      .clk_i                  ( clk_i ),
      .rst_n_i                ( rst_n_i ),
      .enable_i               ( enable_i ),
      .process_start_i        ( w_bytes_valid_out[5] ),
      .busy_o                 (  ),
      .bytes_i                ( w_bytes_out[5] ),
      .round_key_i            ( w_roundKey[6] ),
      .bytes_o                ( w_bytes_out[6] ),
      .bytes_valid_o          ( w_bytes_valid_out[6] )

   );
   round
   round_inst_7
   (
      .clk_i                  ( clk_i ),
      .rst_n_i                ( rst_n_i ),
      .enable_i               ( enable_i ),
      .process_start_i        ( w_bytes_valid_out[6] ),
      .busy_o                 (  ),
      .bytes_i                ( w_bytes_out[6] ),
      .round_key_i            ( w_roundKey[7] ),
      .bytes_o                ( w_bytes_out[7] ),
      .bytes_valid_o          ( w_bytes_valid_out[7] )

   );
   round
   round_inst_8
   (
      .clk_i                  ( clk_i ),
      .rst_n_i                ( rst_n_i ),
      .enable_i               ( enable_i ),
      .process_start_i        ( w_bytes_valid_out[7] ),
      .busy_o                 (  ),
      .bytes_i                ( w_bytes_out[7] ),
      .round_key_i            ( w_roundKey[8] ),
      .bytes_o                ( w_bytes_out[8] ),
      .bytes_valid_o          ( w_bytes_valid_out[8] )

   );
   round
   round_inst_9
   (
      .clk_i                  ( clk_i ),
      .rst_n_i                ( rst_n_i ),
      .enable_i               ( enable_i ),
      .process_start_i        ( w_bytes_valid_out[8] ),
      .busy_o                 (  ),
      .bytes_i                ( w_bytes_out[8] ),
      .round_key_i            ( w_roundKey[9] ),
      .bytes_o                ( w_bytes_out[9] ),
      .bytes_valid_o          ( w_bytes_valid_out[9] )

   );

   subBytes

   (
   
      .clk_i                  ( clk_i ),
      .rst_n_i                ( rst_n_i ),
      .enable_i               ( enable_i ),
      .process_start_i        ( w_bytes_valid_out[9] ),
      .busy_o                 (  ),
      .bytes_i                ( w_bytes_out[9] ),
      .bytes_o                ( w_bytes_out[10] ),
      .bytes_valid_o          ( w_bytes_valid_out[10] )

   );

   shiftRows
   shiftRows_10
   (
      .clk_i                  ( clk_i ),
      .rst_n_i                ( rst_n_i ),
      .enable_i               ( enable_i ),
      .process_start_i        ( w_bytes_valid_out[10] ),
      .busy_o                 (  ),
      .bytes_i                ( w_bytes_out[10] ),
      .bytes_o                ( w_bytes_out[11] ),
      .bytes_valid_o          ( w_bytes_valid_out[11] )
   );

   addRoundKey
   addRoundKey_10
   (
      .clk_i                  ( clk_i ),
      .rst_n_i                ( rst_n_i ),
      .enable_i               ( enable_i ),
      .process_start_i        ( w_bytes_valid_out[11] ),
      .busy_o                 (  ),
      .bytes_i                ( w_bytes_out[11] ),
      .round_key_i            ( w_roundKey[10] ),
      .bytes_o                ( bytes_o ),
      .bytes_valid_o          ( bytes_valid_o )

   );







   
      
endmodule
