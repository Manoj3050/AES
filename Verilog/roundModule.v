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
//                     module- roundModule
// Dependencies    : 
// References      : 
//
//**************************************************************************************************
   
`timescale 1ns / 1ps

module roundModule(
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

   output     [INOUT_WIDTH-1:0]        bytes_o;

   output                              busy_o;
   output                              bytes_valid_o;


//---------------------------------------------------------------------------------------------------------------------
// Internal wires and registers
//---------------------------------------------------------------------------------------------------------------------
   wire                                w_subByte_valid;
   wire                                w_shiftRows_valid;
   wire                                w_mixColumns_valid;

   wire        [INOUT_WIDTH-1:0]       w_subByte_out;
   wire        [INOUT_WIDTH-1:0]       w_shiftRows_out;
   wire        [INOUT_WIDTH-1:0]       w_mixColumns_out;


//---------------------------------------------------------------------------------------------------------------------
// Implmentation
//---------------------------------------------------------------------------------------------------------------------


   subBytes
   subbyte_inst
   (
   
      .clk_i                  ( clk_i ),
      .rst_n_i                ( rst_n_i ),
      .enable_i               ( enable_i ),
      .process_start_i        ( process_start_i ),
      .busy_o                 (  ),
      .bytes_i                ( bytes_i ),
      .bytes_o                ( w_subByte_out ),
      .bytes_valid_o          ( w_subByte_valid )

   );

   shiftRows
   shift_rows_inst
   (
      .clk_i                  ( clk_i ),
      .rst_n_i                ( rst_n_i ),
      .enable_i               ( enable_i ),
      .process_start_i        ( w_subByte_valid ),
      .busy_o                 (  ),
      .bytes_i                ( w_subByte_out ),
      .bytes_o                ( w_shiftRows_out ),
      .bytes_valid_o          ( w_shiftRows_valid )

   );


   mixColumns
   mix_columns_inst
   (
      .clk_i                  ( clk_i ),
      .rst_n_i                ( rst_n_i ),
      .enable_i               ( enable_i ),
      .process_start_i        ( w_shiftRows_valid ),
      .busy_o                 (  ),
      .bytes_i                ( w_shiftRows_out ),
      .bytes_o                ( w_mixColumns_out ),
      .bytes_valid_o          ( w_mixColumns_valid )

   );

   

   addRoundKey
   add_r_key_inst
   (
      .clk_i                  ( clk_i ),
      .rst_n_i                ( rst_n_i ),
      .enable_i               ( enable_i ),
      .process_start_i        ( w_mixColumns_valid ),
      .busy_o                 (  ),
      .bytes_i                ( w_mixColumns_out ),
      .round_key_i            ( round_key_i ),
      .bytes_o                ( bytes_o ),
      .bytes_valid_o          ( bytes_valid_o )

   );

   
      
endmodule