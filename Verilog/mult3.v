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
// Target Device   : <target device if aplicable>     eg: Xilinx SpartanÂ®-6 LX45 
// Target Platform : <target platform if aplicable>   eg: Atlysâ„¢ Spartan-6 FPGA Development Board
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
//                     module- mult3
// Dependencies    : 
// References      : 
//
//**************************************************************************************************
   
`timescale 1ns / 1ps

module mult3(
   
   bytes_o,

   bytes_i,

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
 
    
//----------------------------------------------------------------------------------------------------------------------
// I/O signals
//----------------------------------------------------------------------------------------------------------------------


   


   input  [DATA_WIDTH-1:0]         bytes_i;

   output [DATA_WIDTH-1:0]         bytes_o;




//---------------------------------------------------------------------------------------------------------------------
// Internal wires and registers
//---------------------------------------------------------------------------------------------------------------------



//---------------------------------------------------------------------------------------------------------------------
// Implmentation
//---------------------------------------------------------------------------------------------------------------------


`ifdef INITIALIZATION
   initial begin

   end
`endif

   assign bytes_o = (bytes_i << 1) ^ (bytes_i[7] ? 8'h1b : 0) ^ bytes_i;

      
endmodule