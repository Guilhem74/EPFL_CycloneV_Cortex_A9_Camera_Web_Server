-- ------------------------------------------------------------------------- 
-- High Level Design Compiler for Intel(R) FPGAs Version 18.1 (Release Build #625)
-- Quartus Prime development tool and MATLAB/Simulink Interface
-- 
-- Legal Notice: Copyright 2018 Intel Corporation.  All rights reserved.
-- Your use of  Intel Corporation's design tools,  logic functions and other
-- software and  tools, and its AMPP partner logic functions, and any output
-- files any  of the foregoing (including  device programming  or simulation
-- files), and  any associated  documentation  or information  are expressly
-- subject  to the terms and  conditions of the  Intel FPGA Software License
-- Agreement, Intel MegaCore Function License Agreement, or other applicable
-- license agreement,  including,  without limitation,  that your use is for
-- the  sole  purpose of  programming  logic devices  manufactured by  Intel
-- and  sold by Intel  or its authorized  distributors. Please refer  to the
-- applicable agreement for further details.
-- ---------------------------------------------------------------------------

-- VHDL created from FP_Function_Div
-- VHDL created on Sat Jun 01 12:26:19 2019


library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.NUMERIC_STD.all;
use IEEE.MATH_REAL.all;
use std.TextIO.all;
use work.dspba_library_package.all;

LIBRARY altera_mf;
USE altera_mf.altera_mf_components.all;
LIBRARY altera_lnsim;
USE altera_lnsim.altera_lnsim_components.altera_syncram;
LIBRARY lpm;
USE lpm.lpm_components.all;

entity FP_Function_Div is
    port (
        a : in std_logic_vector(31 downto 0);  -- float32_m23
        b : in std_logic_vector(31 downto 0);  -- float32_m23
        en : in std_logic_vector(0 downto 0);  -- ufix1
        q : out std_logic_vector(31 downto 0);  -- float32_m23
        clk : in std_logic;
        areset : in std_logic
    );
end FP_Function_Div;

architecture normal of FP_Function_Div is

    attribute altera_attribute : string;
    attribute altera_attribute of normal : architecture is "-name AUTO_SHIFT_REGISTER_RECOGNITION OFF; -name PHYSICAL_SYNTHESIS_REGISTER_DUPLICATION ON; -name MESSAGE_DISABLE 10036; -name MESSAGE_DISABLE 10037; -name MESSAGE_DISABLE 14130; -name MESSAGE_DISABLE 14320; -name MESSAGE_DISABLE 15400; -name MESSAGE_DISABLE 14130; -name MESSAGE_DISABLE 10036; -name MESSAGE_DISABLE 12020; -name MESSAGE_DISABLE 12030; -name MESSAGE_DISABLE 12010; -name MESSAGE_DISABLE 12110; -name MESSAGE_DISABLE 14320; -name MESSAGE_DISABLE 13410; -name MESSAGE_DISABLE 113007";
    
    signal GND_q : STD_LOGIC_VECTOR (0 downto 0);
    signal VCC_q : STD_LOGIC_VECTOR (0 downto 0);
    signal cstBiasM1_uid6_fpDivTest_q : STD_LOGIC_VECTOR (7 downto 0);
    signal cstBias_uid7_fpDivTest_q : STD_LOGIC_VECTOR (7 downto 0);
    signal expX_uid9_fpDivTest_b : STD_LOGIC_VECTOR (7 downto 0);
    signal fracX_uid10_fpDivTest_b : STD_LOGIC_VECTOR (22 downto 0);
    signal signX_uid11_fpDivTest_b : STD_LOGIC_VECTOR (0 downto 0);
    signal expY_uid12_fpDivTest_b : STD_LOGIC_VECTOR (7 downto 0);
    signal fracY_uid13_fpDivTest_b : STD_LOGIC_VECTOR (22 downto 0);
    signal signY_uid14_fpDivTest_b : STD_LOGIC_VECTOR (0 downto 0);
    signal paddingY_uid15_fpDivTest_q : STD_LOGIC_VECTOR (22 downto 0);
    signal updatedY_uid16_fpDivTest_q : STD_LOGIC_VECTOR (23 downto 0);
    signal fracYZero_uid15_fpDivTest_a : STD_LOGIC_VECTOR (23 downto 0);
    signal fracYZero_uid15_fpDivTest_q : STD_LOGIC_VECTOR (0 downto 0);
    signal cstAllOWE_uid18_fpDivTest_q : STD_LOGIC_VECTOR (7 downto 0);
    signal cstAllZWE_uid20_fpDivTest_q : STD_LOGIC_VECTOR (7 downto 0);
    signal excZ_x_uid23_fpDivTest_q : STD_LOGIC_VECTOR (0 downto 0);
    signal expXIsMax_uid24_fpDivTest_q : STD_LOGIC_VECTOR (0 downto 0);
    signal fracXIsZero_uid25_fpDivTest_q : STD_LOGIC_VECTOR (0 downto 0);
    signal fracXIsNotZero_uid26_fpDivTest_q : STD_LOGIC_VECTOR (0 downto 0);
    signal excI_x_uid27_fpDivTest_q : STD_LOGIC_VECTOR (0 downto 0);
    signal excN_x_uid28_fpDivTest_q : STD_LOGIC_VECTOR (0 downto 0);
    signal invExpXIsMax_uid29_fpDivTest_q : STD_LOGIC_VECTOR (0 downto 0);
    signal InvExpXIsZero_uid30_fpDivTest_q : STD_LOGIC_VECTOR (0 downto 0);
    signal excR_x_uid31_fpDivTest_q : STD_LOGIC_VECTOR (0 downto 0);
    signal excZ_y_uid37_fpDivTest_q : STD_LOGIC_VECTOR (0 downto 0);
    signal expXIsMax_uid38_fpDivTest_q : STD_LOGIC_VECTOR (0 downto 0);
    signal fracXIsZero_uid39_fpDivTest_q : STD_LOGIC_VECTOR (0 downto 0);
    signal fracXIsNotZero_uid40_fpDivTest_q : STD_LOGIC_VECTOR (0 downto 0);
    signal excI_y_uid41_fpDivTest_q : STD_LOGIC_VECTOR (0 downto 0);
    signal excN_y_uid42_fpDivTest_q : STD_LOGIC_VECTOR (0 downto 0);
    signal invExpXIsMax_uid43_fpDivTest_q : STD_LOGIC_VECTOR (0 downto 0);
    signal InvExpXIsZero_uid44_fpDivTest_q : STD_LOGIC_VECTOR (0 downto 0);
    signal excR_y_uid45_fpDivTest_q : STD_LOGIC_VECTOR (0 downto 0);
    signal signR_uid46_fpDivTest_qi : STD_LOGIC_VECTOR (0 downto 0);
    signal signR_uid46_fpDivTest_q : STD_LOGIC_VECTOR (0 downto 0);
    signal expXmY_uid47_fpDivTest_a : STD_LOGIC_VECTOR (8 downto 0);
    signal expXmY_uid47_fpDivTest_b : STD_LOGIC_VECTOR (8 downto 0);
    signal expXmY_uid47_fpDivTest_o : STD_LOGIC_VECTOR (8 downto 0);
    signal expXmY_uid47_fpDivTest_q : STD_LOGIC_VECTOR (8 downto 0);
    signal expR_uid48_fpDivTest_a : STD_LOGIC_VECTOR (10 downto 0);
    signal expR_uid48_fpDivTest_b : STD_LOGIC_VECTOR (10 downto 0);
    signal expR_uid48_fpDivTest_o : STD_LOGIC_VECTOR (10 downto 0);
    signal expR_uid48_fpDivTest_q : STD_LOGIC_VECTOR (9 downto 0);
    signal yAddr_uid51_fpDivTest_b : STD_LOGIC_VECTOR (8 downto 0);
    signal yPE_uid52_fpDivTest_b : STD_LOGIC_VECTOR (13 downto 0);
    signal invY_uid54_fpDivTest_in : STD_LOGIC_VECTOR (31 downto 0);
    signal invY_uid54_fpDivTest_b : STD_LOGIC_VECTOR (26 downto 0);
    signal invYO_uid55_fpDivTest_in : STD_LOGIC_VECTOR (32 downto 0);
    signal invYO_uid55_fpDivTest_b : STD_LOGIC_VECTOR (0 downto 0);
    signal lOAdded_uid57_fpDivTest_q : STD_LOGIC_VECTOR (23 downto 0);
    signal z4_uid60_fpDivTest_q : STD_LOGIC_VECTOR (3 downto 0);
    signal oFracXZ4_uid61_fpDivTest_q : STD_LOGIC_VECTOR (27 downto 0);
    signal divValPreNormYPow2Exc_uid63_fpDivTest_s : STD_LOGIC_VECTOR (0 downto 0);
    signal divValPreNormYPow2Exc_uid63_fpDivTest_q : STD_LOGIC_VECTOR (27 downto 0);
    signal norm_uid64_fpDivTest_b : STD_LOGIC_VECTOR (0 downto 0);
    signal divValPreNormHigh_uid65_fpDivTest_in : STD_LOGIC_VECTOR (26 downto 0);
    signal divValPreNormHigh_uid65_fpDivTest_b : STD_LOGIC_VECTOR (24 downto 0);
    signal divValPreNormLow_uid66_fpDivTest_in : STD_LOGIC_VECTOR (25 downto 0);
    signal divValPreNormLow_uid66_fpDivTest_b : STD_LOGIC_VECTOR (24 downto 0);
    signal normFracRnd_uid67_fpDivTest_s : STD_LOGIC_VECTOR (0 downto 0);
    signal normFracRnd_uid67_fpDivTest_q : STD_LOGIC_VECTOR (24 downto 0);
    signal expFracRnd_uid68_fpDivTest_q : STD_LOGIC_VECTOR (34 downto 0);
    signal zeroPaddingInAddition_uid74_fpDivTest_q : STD_LOGIC_VECTOR (23 downto 0);
    signal expFracPostRnd_uid75_fpDivTest_q : STD_LOGIC_VECTOR (25 downto 0);
    signal expFracPostRnd_uid76_fpDivTest_a : STD_LOGIC_VECTOR (36 downto 0);
    signal expFracPostRnd_uid76_fpDivTest_b : STD_LOGIC_VECTOR (36 downto 0);
    signal expFracPostRnd_uid76_fpDivTest_o : STD_LOGIC_VECTOR (36 downto 0);
    signal expFracPostRnd_uid76_fpDivTest_q : STD_LOGIC_VECTOR (35 downto 0);
    signal fracXExt_uid77_fpDivTest_q : STD_LOGIC_VECTOR (23 downto 0);
    signal fracPostRndF_uid79_fpDivTest_in : STD_LOGIC_VECTOR (24 downto 0);
    signal fracPostRndF_uid79_fpDivTest_b : STD_LOGIC_VECTOR (23 downto 0);
    signal fracPostRndF_uid80_fpDivTest_s : STD_LOGIC_VECTOR (0 downto 0);
    signal fracPostRndF_uid80_fpDivTest_q : STD_LOGIC_VECTOR (23 downto 0);
    signal expPostRndFR_uid81_fpDivTest_in : STD_LOGIC_VECTOR (32 downto 0);
    signal expPostRndFR_uid81_fpDivTest_b : STD_LOGIC_VECTOR (7 downto 0);
    signal expPostRndF_uid82_fpDivTest_s : STD_LOGIC_VECTOR (0 downto 0);
    signal expPostRndF_uid82_fpDivTest_q : STD_LOGIC_VECTOR (7 downto 0);
    signal lOAdded_uid84_fpDivTest_q : STD_LOGIC_VECTOR (24 downto 0);
    signal lOAdded_uid87_fpDivTest_q : STD_LOGIC_VECTOR (23 downto 0);
    signal qDivProdNorm_uid90_fpDivTest_b : STD_LOGIC_VECTOR (0 downto 0);
    signal qDivProdFracHigh_uid91_fpDivTest_in : STD_LOGIC_VECTOR (47 downto 0);
    signal qDivProdFracHigh_uid91_fpDivTest_b : STD_LOGIC_VECTOR (23 downto 0);
    signal qDivProdFracLow_uid92_fpDivTest_in : STD_LOGIC_VECTOR (46 downto 0);
    signal qDivProdFracLow_uid92_fpDivTest_b : STD_LOGIC_VECTOR (23 downto 0);
    signal qDivProdFrac_uid93_fpDivTest_s : STD_LOGIC_VECTOR (0 downto 0);
    signal qDivProdFrac_uid93_fpDivTest_q : STD_LOGIC_VECTOR (23 downto 0);
    signal qDivProdExp_opA_uid94_fpDivTest_a : STD_LOGIC_VECTOR (8 downto 0);
    signal qDivProdExp_opA_uid94_fpDivTest_b : STD_LOGIC_VECTOR (8 downto 0);
    signal qDivProdExp_opA_uid94_fpDivTest_o : STD_LOGIC_VECTOR (8 downto 0);
    signal qDivProdExp_opA_uid94_fpDivTest_q : STD_LOGIC_VECTOR (8 downto 0);
    signal qDivProdExp_opBs_uid95_fpDivTest_a : STD_LOGIC_VECTOR (8 downto 0);
    signal qDivProdExp_opBs_uid95_fpDivTest_b : STD_LOGIC_VECTOR (8 downto 0);
    signal qDivProdExp_opBs_uid95_fpDivTest_o : STD_LOGIC_VECTOR (8 downto 0);
    signal qDivProdExp_opBs_uid95_fpDivTest_q : STD_LOGIC_VECTOR (8 downto 0);
    signal qDivProdExp_uid96_fpDivTest_a : STD_LOGIC_VECTOR (11 downto 0);
    signal qDivProdExp_uid96_fpDivTest_b : STD_LOGIC_VECTOR (11 downto 0);
    signal qDivProdExp_uid96_fpDivTest_o : STD_LOGIC_VECTOR (11 downto 0);
    signal qDivProdExp_uid96_fpDivTest_q : STD_LOGIC_VECTOR (10 downto 0);
    signal qDivProdFracWF_uid97_fpDivTest_b : STD_LOGIC_VECTOR (22 downto 0);
    signal qDivProdLTX_opA_uid98_fpDivTest_in : STD_LOGIC_VECTOR (7 downto 0);
    signal qDivProdLTX_opA_uid98_fpDivTest_b : STD_LOGIC_VECTOR (7 downto 0);
    signal qDivProdLTX_opA_uid99_fpDivTest_q : STD_LOGIC_VECTOR (30 downto 0);
    signal qDivProdLTX_opB_uid100_fpDivTest_q : STD_LOGIC_VECTOR (30 downto 0);
    signal qDividerProdLTX_uid101_fpDivTest_a : STD_LOGIC_VECTOR (32 downto 0);
    signal qDividerProdLTX_uid101_fpDivTest_b : STD_LOGIC_VECTOR (32 downto 0);
    signal qDividerProdLTX_uid101_fpDivTest_o : STD_LOGIC_VECTOR (32 downto 0);
    signal qDividerProdLTX_uid101_fpDivTest_c : STD_LOGIC_VECTOR (0 downto 0);
    signal betweenFPwF_uid102_fpDivTest_in : STD_LOGIC_VECTOR (0 downto 0);
    signal betweenFPwF_uid102_fpDivTest_b : STD_LOGIC_VECTOR (0 downto 0);
    signal extraUlp_uid103_fpDivTest_qi : STD_LOGIC_VECTOR (0 downto 0);
    signal extraUlp_uid103_fpDivTest_q : STD_LOGIC_VECTOR (0 downto 0);
    signal fracPostRndFT_uid104_fpDivTest_b : STD_LOGIC_VECTOR (22 downto 0);
    signal fracRPreExcExt_uid105_fpDivTest_a : STD_LOGIC_VECTOR (23 downto 0);
    signal fracRPreExcExt_uid105_fpDivTest_b : STD_LOGIC_VECTOR (23 downto 0);
    signal fracRPreExcExt_uid105_fpDivTest_o : STD_LOGIC_VECTOR (23 downto 0);
    signal fracRPreExcExt_uid105_fpDivTest_q : STD_LOGIC_VECTOR (23 downto 0);
    signal fracPostRndFPostUlp_uid106_fpDivTest_in : STD_LOGIC_VECTOR (22 downto 0);
    signal fracPostRndFPostUlp_uid106_fpDivTest_b : STD_LOGIC_VECTOR (22 downto 0);
    signal fracRPreExc_uid107_fpDivTest_s : STD_LOGIC_VECTOR (0 downto 0);
    signal fracRPreExc_uid107_fpDivTest_q : STD_LOGIC_VECTOR (22 downto 0);
    signal ovfIncRnd_uid109_fpDivTest_b : STD_LOGIC_VECTOR (0 downto 0);
    signal expFracPostRndInc_uid110_fpDivTest_a : STD_LOGIC_VECTOR (8 downto 0);
    signal expFracPostRndInc_uid110_fpDivTest_b : STD_LOGIC_VECTOR (8 downto 0);
    signal expFracPostRndInc_uid110_fpDivTest_o : STD_LOGIC_VECTOR (8 downto 0);
    signal expFracPostRndInc_uid110_fpDivTest_q : STD_LOGIC_VECTOR (8 downto 0);
    signal expFracPostRndR_uid111_fpDivTest_in : STD_LOGIC_VECTOR (7 downto 0);
    signal expFracPostRndR_uid111_fpDivTest_b : STD_LOGIC_VECTOR (7 downto 0);
    signal expRPreExc_uid112_fpDivTest_s : STD_LOGIC_VECTOR (0 downto 0);
    signal expRPreExc_uid112_fpDivTest_q : STD_LOGIC_VECTOR (7 downto 0);
    signal expRExt_uid114_fpDivTest_b : STD_LOGIC_VECTOR (10 downto 0);
    signal expUdf_uid115_fpDivTest_a : STD_LOGIC_VECTOR (12 downto 0);
    signal expUdf_uid115_fpDivTest_b : STD_LOGIC_VECTOR (12 downto 0);
    signal expUdf_uid115_fpDivTest_o : STD_LOGIC_VECTOR (12 downto 0);
    signal expUdf_uid115_fpDivTest_n : STD_LOGIC_VECTOR (0 downto 0);
    signal expOvf_uid118_fpDivTest_a : STD_LOGIC_VECTOR (12 downto 0);
    signal expOvf_uid118_fpDivTest_b : STD_LOGIC_VECTOR (12 downto 0);
    signal expOvf_uid118_fpDivTest_o : STD_LOGIC_VECTOR (12 downto 0);
    signal expOvf_uid118_fpDivTest_n : STD_LOGIC_VECTOR (0 downto 0);
    signal zeroOverReg_uid119_fpDivTest_q : STD_LOGIC_VECTOR (0 downto 0);
    signal regOverRegWithUf_uid120_fpDivTest_q : STD_LOGIC_VECTOR (0 downto 0);
    signal xRegOrZero_uid121_fpDivTest_q : STD_LOGIC_VECTOR (0 downto 0);
    signal regOrZeroOverInf_uid122_fpDivTest_q : STD_LOGIC_VECTOR (0 downto 0);
    signal excRZero_uid123_fpDivTest_q : STD_LOGIC_VECTOR (0 downto 0);
    signal excXRYZ_uid124_fpDivTest_q : STD_LOGIC_VECTOR (0 downto 0);
    signal excXRYROvf_uid125_fpDivTest_q : STD_LOGIC_VECTOR (0 downto 0);
    signal excXIYZ_uid126_fpDivTest_q : STD_LOGIC_VECTOR (0 downto 0);
    signal excXIYR_uid127_fpDivTest_q : STD_LOGIC_VECTOR (0 downto 0);
    signal excRInf_uid128_fpDivTest_q : STD_LOGIC_VECTOR (0 downto 0);
    signal excXZYZ_uid129_fpDivTest_q : STD_LOGIC_VECTOR (0 downto 0);
    signal excXIYI_uid130_fpDivTest_q : STD_LOGIC_VECTOR (0 downto 0);
    signal excRNaN_uid131_fpDivTest_q : STD_LOGIC_VECTOR (0 downto 0);
    signal concExc_uid132_fpDivTest_q : STD_LOGIC_VECTOR (2 downto 0);
    signal excREnc_uid133_fpDivTest_q : STD_LOGIC_VECTOR (1 downto 0);
    signal oneFracRPostExc2_uid134_fpDivTest_q : STD_LOGIC_VECTOR (22 downto 0);
    signal fracRPostExc_uid137_fpDivTest_s : STD_LOGIC_VECTOR (1 downto 0);
    signal fracRPostExc_uid137_fpDivTest_q : STD_LOGIC_VECTOR (22 downto 0);
    signal expRPostExc_uid141_fpDivTest_s : STD_LOGIC_VECTOR (1 downto 0);
    signal expRPostExc_uid141_fpDivTest_q : STD_LOGIC_VECTOR (7 downto 0);
    signal invExcRNaN_uid142_fpDivTest_q : STD_LOGIC_VECTOR (0 downto 0);
    signal sRPostExc_uid143_fpDivTest_qi : STD_LOGIC_VECTOR (0 downto 0);
    signal sRPostExc_uid143_fpDivTest_q : STD_LOGIC_VECTOR (0 downto 0);
    signal divR_uid144_fpDivTest_q : STD_LOGIC_VECTOR (31 downto 0);
    signal os_uid148_invTables_q : STD_LOGIC_VECTOR (31 downto 0);
    signal os_uid152_invTables_q : STD_LOGIC_VECTOR (21 downto 0);
    signal yT1_uid160_invPolyEval_b : STD_LOGIC_VECTOR (12 downto 0);
    signal lowRangeB_uid162_invPolyEval_in : STD_LOGIC_VECTOR (0 downto 0);
    signal lowRangeB_uid162_invPolyEval_b : STD_LOGIC_VECTOR (0 downto 0);
    signal highBBits_uid163_invPolyEval_b : STD_LOGIC_VECTOR (12 downto 0);
    signal s1sumAHighB_uid164_invPolyEval_a : STD_LOGIC_VECTOR (22 downto 0);
    signal s1sumAHighB_uid164_invPolyEval_b : STD_LOGIC_VECTOR (22 downto 0);
    signal s1sumAHighB_uid164_invPolyEval_o : STD_LOGIC_VECTOR (22 downto 0);
    signal s1sumAHighB_uid164_invPolyEval_q : STD_LOGIC_VECTOR (22 downto 0);
    signal s1_uid165_invPolyEval_q : STD_LOGIC_VECTOR (23 downto 0);
    signal lowRangeB_uid168_invPolyEval_in : STD_LOGIC_VECTOR (1 downto 0);
    signal lowRangeB_uid168_invPolyEval_b : STD_LOGIC_VECTOR (1 downto 0);
    signal highBBits_uid169_invPolyEval_b : STD_LOGIC_VECTOR (22 downto 0);
    signal s2sumAHighB_uid170_invPolyEval_a : STD_LOGIC_VECTOR (32 downto 0);
    signal s2sumAHighB_uid170_invPolyEval_b : STD_LOGIC_VECTOR (32 downto 0);
    signal s2sumAHighB_uid170_invPolyEval_o : STD_LOGIC_VECTOR (32 downto 0);
    signal s2sumAHighB_uid170_invPolyEval_q : STD_LOGIC_VECTOR (32 downto 0);
    signal s2_uid171_invPolyEval_q : STD_LOGIC_VECTOR (34 downto 0);
    signal osig_uid174_divValPreNorm_uid59_fpDivTest_b : STD_LOGIC_VECTOR (27 downto 0);
    signal osig_uid177_pT1_uid161_invPolyEval_b : STD_LOGIC_VECTOR (13 downto 0);
    signal osig_uid180_pT2_uid167_invPolyEval_b : STD_LOGIC_VECTOR (24 downto 0);
    signal memoryC0_uid146_invTables_lutmem_reset0 : std_logic;
    signal memoryC0_uid146_invTables_lutmem_ia : STD_LOGIC_VECTOR (19 downto 0);
    signal memoryC0_uid146_invTables_lutmem_aa : STD_LOGIC_VECTOR (8 downto 0);
    signal memoryC0_uid146_invTables_lutmem_ab : STD_LOGIC_VECTOR (8 downto 0);
    signal memoryC0_uid146_invTables_lutmem_ir : STD_LOGIC_VECTOR (19 downto 0);
    signal memoryC0_uid146_invTables_lutmem_r : STD_LOGIC_VECTOR (19 downto 0);
    signal memoryC0_uid147_invTables_lutmem_reset0 : std_logic;
    signal memoryC0_uid147_invTables_lutmem_ia : STD_LOGIC_VECTOR (11 downto 0);
    signal memoryC0_uid147_invTables_lutmem_aa : STD_LOGIC_VECTOR (8 downto 0);
    signal memoryC0_uid147_invTables_lutmem_ab : STD_LOGIC_VECTOR (8 downto 0);
    signal memoryC0_uid147_invTables_lutmem_ir : STD_LOGIC_VECTOR (11 downto 0);
    signal memoryC0_uid147_invTables_lutmem_r : STD_LOGIC_VECTOR (11 downto 0);
    signal memoryC1_uid150_invTables_lutmem_reset0 : std_logic;
    signal memoryC1_uid150_invTables_lutmem_ia : STD_LOGIC_VECTOR (19 downto 0);
    signal memoryC1_uid150_invTables_lutmem_aa : STD_LOGIC_VECTOR (8 downto 0);
    signal memoryC1_uid150_invTables_lutmem_ab : STD_LOGIC_VECTOR (8 downto 0);
    signal memoryC1_uid150_invTables_lutmem_ir : STD_LOGIC_VECTOR (19 downto 0);
    signal memoryC1_uid150_invTables_lutmem_r : STD_LOGIC_VECTOR (19 downto 0);
    signal memoryC1_uid151_invTables_lutmem_reset0 : std_logic;
    signal memoryC1_uid151_invTables_lutmem_ia : STD_LOGIC_VECTOR (1 downto 0);
    signal memoryC1_uid151_invTables_lutmem_aa : STD_LOGIC_VECTOR (8 downto 0);
    signal memoryC1_uid151_invTables_lutmem_ab : STD_LOGIC_VECTOR (8 downto 0);
    signal memoryC1_uid151_invTables_lutmem_ir : STD_LOGIC_VECTOR (1 downto 0);
    signal memoryC1_uid151_invTables_lutmem_r : STD_LOGIC_VECTOR (1 downto 0);
    signal memoryC2_uid154_invTables_lutmem_reset0 : std_logic;
    signal memoryC2_uid154_invTables_lutmem_ia : STD_LOGIC_VECTOR (12 downto 0);
    signal memoryC2_uid154_invTables_lutmem_aa : STD_LOGIC_VECTOR (8 downto 0);
    signal memoryC2_uid154_invTables_lutmem_ab : STD_LOGIC_VECTOR (8 downto 0);
    signal memoryC2_uid154_invTables_lutmem_ir : STD_LOGIC_VECTOR (12 downto 0);
    signal memoryC2_uid154_invTables_lutmem_r : STD_LOGIC_VECTOR (12 downto 0);
    signal qDivProd_uid89_fpDivTest_cma_reset : std_logic;
    type qDivProd_uid89_fpDivTest_cma_a0type is array(NATURAL range <>) of UNSIGNED(24 downto 0);
    signal qDivProd_uid89_fpDivTest_cma_a0 : qDivProd_uid89_fpDivTest_cma_a0type(0 to 0);
    attribute preserve : boolean;
    attribute preserve of qDivProd_uid89_fpDivTest_cma_a0 : signal is true;
    type qDivProd_uid89_fpDivTest_cma_c0type is array(NATURAL range <>) of UNSIGNED(23 downto 0);
    signal qDivProd_uid89_fpDivTest_cma_c0 : qDivProd_uid89_fpDivTest_cma_c0type(0 to 0);
    attribute preserve of qDivProd_uid89_fpDivTest_cma_c0 : signal is true;
    type qDivProd_uid89_fpDivTest_cma_ptype is array(NATURAL range <>) of UNSIGNED(48 downto 0);
    signal qDivProd_uid89_fpDivTest_cma_p : qDivProd_uid89_fpDivTest_cma_ptype(0 to 0);
    signal qDivProd_uid89_fpDivTest_cma_u : qDivProd_uid89_fpDivTest_cma_ptype(0 to 0);
    signal qDivProd_uid89_fpDivTest_cma_w : qDivProd_uid89_fpDivTest_cma_ptype(0 to 0);
    signal qDivProd_uid89_fpDivTest_cma_x : qDivProd_uid89_fpDivTest_cma_ptype(0 to 0);
    signal qDivProd_uid89_fpDivTest_cma_y : qDivProd_uid89_fpDivTest_cma_ptype(0 to 0);
    signal qDivProd_uid89_fpDivTest_cma_s : qDivProd_uid89_fpDivTest_cma_ptype(0 to 0);
    signal qDivProd_uid89_fpDivTest_cma_qq : STD_LOGIC_VECTOR (48 downto 0);
    signal qDivProd_uid89_fpDivTest_cma_q : STD_LOGIC_VECTOR (48 downto 0);
    signal qDivProd_uid89_fpDivTest_cma_ena0 : std_logic;
    signal qDivProd_uid89_fpDivTest_cma_ena1 : std_logic;
    signal prodXY_uid173_divValPreNorm_uid59_fpDivTest_cma_reset : std_logic;
    type prodXY_uid173_divValPreNorm_uid59_fpDivTest_cma_a0type is array(NATURAL range <>) of UNSIGNED(26 downto 0);
    signal prodXY_uid173_divValPreNorm_uid59_fpDivTest_cma_a0 : prodXY_uid173_divValPreNorm_uid59_fpDivTest_cma_a0type(0 to 0);
    attribute preserve of prodXY_uid173_divValPreNorm_uid59_fpDivTest_cma_a0 : signal is true;
    signal prodXY_uid173_divValPreNorm_uid59_fpDivTest_cma_c0 : qDivProd_uid89_fpDivTest_cma_c0type(0 to 0);
    attribute preserve of prodXY_uid173_divValPreNorm_uid59_fpDivTest_cma_c0 : signal is true;
    type prodXY_uid173_divValPreNorm_uid59_fpDivTest_cma_ptype is array(NATURAL range <>) of UNSIGNED(50 downto 0);
    signal prodXY_uid173_divValPreNorm_uid59_fpDivTest_cma_p : prodXY_uid173_divValPreNorm_uid59_fpDivTest_cma_ptype(0 to 0);
    signal prodXY_uid173_divValPreNorm_uid59_fpDivTest_cma_u : prodXY_uid173_divValPreNorm_uid59_fpDivTest_cma_ptype(0 to 0);
    signal prodXY_uid173_divValPreNorm_uid59_fpDivTest_cma_w : prodXY_uid173_divValPreNorm_uid59_fpDivTest_cma_ptype(0 to 0);
    signal prodXY_uid173_divValPreNorm_uid59_fpDivTest_cma_x : prodXY_uid173_divValPreNorm_uid59_fpDivTest_cma_ptype(0 to 0);
    signal prodXY_uid173_divValPreNorm_uid59_fpDivTest_cma_y : prodXY_uid173_divValPreNorm_uid59_fpDivTest_cma_ptype(0 to 0);
    signal prodXY_uid173_divValPreNorm_uid59_fpDivTest_cma_s : prodXY_uid173_divValPreNorm_uid59_fpDivTest_cma_ptype(0 to 0);
    signal prodXY_uid173_divValPreNorm_uid59_fpDivTest_cma_qq : STD_LOGIC_VECTOR (50 downto 0);
    signal prodXY_uid173_divValPreNorm_uid59_fpDivTest_cma_q : STD_LOGIC_VECTOR (50 downto 0);
    signal prodXY_uid173_divValPreNorm_uid59_fpDivTest_cma_ena0 : std_logic;
    signal prodXY_uid173_divValPreNorm_uid59_fpDivTest_cma_ena1 : std_logic;
    signal prodXY_uid176_pT1_uid161_invPolyEval_cma_reset : std_logic;
    type prodXY_uid176_pT1_uid161_invPolyEval_cma_a0type is array(NATURAL range <>) of UNSIGNED(12 downto 0);
    signal prodXY_uid176_pT1_uid161_invPolyEval_cma_a0 : prodXY_uid176_pT1_uid161_invPolyEval_cma_a0type(0 to 0);
    attribute preserve of prodXY_uid176_pT1_uid161_invPolyEval_cma_a0 : signal is true;
    type prodXY_uid176_pT1_uid161_invPolyEval_cma_c0type is array(NATURAL range <>) of SIGNED(12 downto 0);
    signal prodXY_uid176_pT1_uid161_invPolyEval_cma_c0 : prodXY_uid176_pT1_uid161_invPolyEval_cma_c0type(0 to 0);
    attribute preserve of prodXY_uid176_pT1_uid161_invPolyEval_cma_c0 : signal is true;
    type prodXY_uid176_pT1_uid161_invPolyEval_cma_ltype is array(NATURAL range <>) of SIGNED(13 downto 0);
    signal prodXY_uid176_pT1_uid161_invPolyEval_cma_l : prodXY_uid176_pT1_uid161_invPolyEval_cma_ltype(0 to 0);
    type prodXY_uid176_pT1_uid161_invPolyEval_cma_ptype is array(NATURAL range <>) of SIGNED(26 downto 0);
    signal prodXY_uid176_pT1_uid161_invPolyEval_cma_p : prodXY_uid176_pT1_uid161_invPolyEval_cma_ptype(0 to 0);
    signal prodXY_uid176_pT1_uid161_invPolyEval_cma_u : prodXY_uid176_pT1_uid161_invPolyEval_cma_ptype(0 to 0);
    signal prodXY_uid176_pT1_uid161_invPolyEval_cma_w : prodXY_uid176_pT1_uid161_invPolyEval_cma_ptype(0 to 0);
    signal prodXY_uid176_pT1_uid161_invPolyEval_cma_x : prodXY_uid176_pT1_uid161_invPolyEval_cma_ptype(0 to 0);
    signal prodXY_uid176_pT1_uid161_invPolyEval_cma_y : prodXY_uid176_pT1_uid161_invPolyEval_cma_ptype(0 to 0);
    signal prodXY_uid176_pT1_uid161_invPolyEval_cma_s : prodXY_uid176_pT1_uid161_invPolyEval_cma_ptype(0 to 0);
    signal prodXY_uid176_pT1_uid161_invPolyEval_cma_qq : STD_LOGIC_VECTOR (25 downto 0);
    signal prodXY_uid176_pT1_uid161_invPolyEval_cma_q : STD_LOGIC_VECTOR (25 downto 0);
    signal prodXY_uid176_pT1_uid161_invPolyEval_cma_ena0 : std_logic;
    signal prodXY_uid176_pT1_uid161_invPolyEval_cma_ena1 : std_logic;
    signal prodXY_uid179_pT2_uid167_invPolyEval_cma_reset : std_logic;
    type prodXY_uid179_pT2_uid167_invPolyEval_cma_a0type is array(NATURAL range <>) of UNSIGNED(13 downto 0);
    signal prodXY_uid179_pT2_uid167_invPolyEval_cma_a0 : prodXY_uid179_pT2_uid167_invPolyEval_cma_a0type(0 to 0);
    attribute preserve of prodXY_uid179_pT2_uid167_invPolyEval_cma_a0 : signal is true;
    type prodXY_uid179_pT2_uid167_invPolyEval_cma_c0type is array(NATURAL range <>) of SIGNED(23 downto 0);
    signal prodXY_uid179_pT2_uid167_invPolyEval_cma_c0 : prodXY_uid179_pT2_uid167_invPolyEval_cma_c0type(0 to 0);
    attribute preserve of prodXY_uid179_pT2_uid167_invPolyEval_cma_c0 : signal is true;
    type prodXY_uid179_pT2_uid167_invPolyEval_cma_ltype is array(NATURAL range <>) of SIGNED(14 downto 0);
    signal prodXY_uid179_pT2_uid167_invPolyEval_cma_l : prodXY_uid179_pT2_uid167_invPolyEval_cma_ltype(0 to 0);
    type prodXY_uid179_pT2_uid167_invPolyEval_cma_ptype is array(NATURAL range <>) of SIGNED(38 downto 0);
    signal prodXY_uid179_pT2_uid167_invPolyEval_cma_p : prodXY_uid179_pT2_uid167_invPolyEval_cma_ptype(0 to 0);
    signal prodXY_uid179_pT2_uid167_invPolyEval_cma_u : prodXY_uid179_pT2_uid167_invPolyEval_cma_ptype(0 to 0);
    signal prodXY_uid179_pT2_uid167_invPolyEval_cma_w : prodXY_uid179_pT2_uid167_invPolyEval_cma_ptype(0 to 0);
    signal prodXY_uid179_pT2_uid167_invPolyEval_cma_x : prodXY_uid179_pT2_uid167_invPolyEval_cma_ptype(0 to 0);
    signal prodXY_uid179_pT2_uid167_invPolyEval_cma_y : prodXY_uid179_pT2_uid167_invPolyEval_cma_ptype(0 to 0);
    signal prodXY_uid179_pT2_uid167_invPolyEval_cma_s : prodXY_uid179_pT2_uid167_invPolyEval_cma_ptype(0 to 0);
    signal prodXY_uid179_pT2_uid167_invPolyEval_cma_qq : STD_LOGIC_VECTOR (37 downto 0);
    signal prodXY_uid179_pT2_uid167_invPolyEval_cma_q : STD_LOGIC_VECTOR (37 downto 0);
    signal prodXY_uid179_pT2_uid167_invPolyEval_cma_ena0 : std_logic;
    signal prodXY_uid179_pT2_uid167_invPolyEval_cma_ena1 : std_logic;
    signal redist0_sRPostExc_uid143_fpDivTest_q_3_q : STD_LOGIC_VECTOR (0 downto 0);
    signal redist1_excREnc_uid133_fpDivTest_q_3_q : STD_LOGIC_VECTOR (1 downto 0);
    signal redist2_fracPostRndFT_uid104_fpDivTest_b_1_q : STD_LOGIC_VECTOR (22 downto 0);
    signal redist3_expPostRndFR_uid81_fpDivTest_b_2_q : STD_LOGIC_VECTOR (7 downto 0);
    signal redist4_expPostRndFR_uid81_fpDivTest_b_3_q : STD_LOGIC_VECTOR (7 downto 0);
    signal redist5_fracPostRndF_uid80_fpDivTest_q_2_q : STD_LOGIC_VECTOR (23 downto 0);
    signal redist6_lOAdded_uid57_fpDivTest_q_2_q : STD_LOGIC_VECTOR (23 downto 0);
    signal redist7_invYO_uid55_fpDivTest_b_2_q : STD_LOGIC_VECTOR (0 downto 0);
    signal redist8_invYO_uid55_fpDivTest_b_4_q : STD_LOGIC_VECTOR (0 downto 0);
    signal redist9_yPE_uid52_fpDivTest_b_2_q : STD_LOGIC_VECTOR (13 downto 0);
    signal redist10_yPE_uid52_fpDivTest_b_4_q : STD_LOGIC_VECTOR (13 downto 0);
    signal redist11_yAddr_uid51_fpDivTest_b_2_q : STD_LOGIC_VECTOR (8 downto 0);
    signal redist12_yAddr_uid51_fpDivTest_b_4_q : STD_LOGIC_VECTOR (8 downto 0);
    signal redist13_signR_uid46_fpDivTest_q_8_q : STD_LOGIC_VECTOR (0 downto 0);
    signal redist16_expY_uid12_fpDivTest_b_10_q : STD_LOGIC_VECTOR (7 downto 0);
    signal redist18_fracX_uid10_fpDivTest_b_8_q : STD_LOGIC_VECTOR (22 downto 0);
    signal redist19_fracX_uid10_fpDivTest_b_10_q : STD_LOGIC_VECTOR (22 downto 0);
    signal redist21_expX_uid9_fpDivTest_b_10_q : STD_LOGIC_VECTOR (7 downto 0);
    signal redist14_fracY_uid13_fpDivTest_b_8_mem_reset0 : std_logic;
    signal redist14_fracY_uid13_fpDivTest_b_8_mem_ia : STD_LOGIC_VECTOR (22 downto 0);
    signal redist14_fracY_uid13_fpDivTest_b_8_mem_aa : STD_LOGIC_VECTOR (2 downto 0);
    signal redist14_fracY_uid13_fpDivTest_b_8_mem_ab : STD_LOGIC_VECTOR (2 downto 0);
    signal redist14_fracY_uid13_fpDivTest_b_8_mem_iq : STD_LOGIC_VECTOR (22 downto 0);
    signal redist14_fracY_uid13_fpDivTest_b_8_mem_q : STD_LOGIC_VECTOR (22 downto 0);
    signal redist14_fracY_uid13_fpDivTest_b_8_rdcnt_q : STD_LOGIC_VECTOR (2 downto 0);
    signal redist14_fracY_uid13_fpDivTest_b_8_rdcnt_i : UNSIGNED (2 downto 0);
    attribute preserve of redist14_fracY_uid13_fpDivTest_b_8_rdcnt_i : signal is true;
    signal redist14_fracY_uid13_fpDivTest_b_8_rdcnt_eq : std_logic;
    attribute preserve of redist14_fracY_uid13_fpDivTest_b_8_rdcnt_eq : signal is true;
    signal redist14_fracY_uid13_fpDivTest_b_8_rdmux_s : STD_LOGIC_VECTOR (0 downto 0);
    signal redist14_fracY_uid13_fpDivTest_b_8_rdmux_q : STD_LOGIC_VECTOR (2 downto 0);
    signal redist14_fracY_uid13_fpDivTest_b_8_wraddr_q : STD_LOGIC_VECTOR (2 downto 0);
    signal redist14_fracY_uid13_fpDivTest_b_8_mem_last_q : STD_LOGIC_VECTOR (3 downto 0);
    signal redist14_fracY_uid13_fpDivTest_b_8_cmp_b : STD_LOGIC_VECTOR (3 downto 0);
    signal redist14_fracY_uid13_fpDivTest_b_8_cmp_q : STD_LOGIC_VECTOR (0 downto 0);
    signal redist14_fracY_uid13_fpDivTest_b_8_cmpReg_q : STD_LOGIC_VECTOR (0 downto 0);
    signal redist14_fracY_uid13_fpDivTest_b_8_notEnable_q : STD_LOGIC_VECTOR (0 downto 0);
    signal redist14_fracY_uid13_fpDivTest_b_8_nor_q : STD_LOGIC_VECTOR (0 downto 0);
    signal redist14_fracY_uid13_fpDivTest_b_8_sticky_ena_q : STD_LOGIC_VECTOR (0 downto 0);
    attribute dont_merge : boolean;
    attribute dont_merge of redist14_fracY_uid13_fpDivTest_b_8_sticky_ena_q : signal is true;
    signal redist14_fracY_uid13_fpDivTest_b_8_enaAnd_q : STD_LOGIC_VECTOR (0 downto 0);
    signal redist15_expY_uid12_fpDivTest_b_8_mem_reset0 : std_logic;
    signal redist15_expY_uid12_fpDivTest_b_8_mem_ia : STD_LOGIC_VECTOR (7 downto 0);
    signal redist15_expY_uid12_fpDivTest_b_8_mem_aa : STD_LOGIC_VECTOR (2 downto 0);
    signal redist15_expY_uid12_fpDivTest_b_8_mem_ab : STD_LOGIC_VECTOR (2 downto 0);
    signal redist15_expY_uid12_fpDivTest_b_8_mem_iq : STD_LOGIC_VECTOR (7 downto 0);
    signal redist15_expY_uid12_fpDivTest_b_8_mem_q : STD_LOGIC_VECTOR (7 downto 0);
    signal redist15_expY_uid12_fpDivTest_b_8_rdcnt_q : STD_LOGIC_VECTOR (2 downto 0);
    signal redist15_expY_uid12_fpDivTest_b_8_rdcnt_i : UNSIGNED (2 downto 0);
    attribute preserve of redist15_expY_uid12_fpDivTest_b_8_rdcnt_i : signal is true;
    signal redist15_expY_uid12_fpDivTest_b_8_rdcnt_eq : std_logic;
    attribute preserve of redist15_expY_uid12_fpDivTest_b_8_rdcnt_eq : signal is true;
    signal redist15_expY_uid12_fpDivTest_b_8_rdmux_s : STD_LOGIC_VECTOR (0 downto 0);
    signal redist15_expY_uid12_fpDivTest_b_8_rdmux_q : STD_LOGIC_VECTOR (2 downto 0);
    signal redist15_expY_uid12_fpDivTest_b_8_wraddr_q : STD_LOGIC_VECTOR (2 downto 0);
    signal redist15_expY_uid12_fpDivTest_b_8_mem_last_q : STD_LOGIC_VECTOR (3 downto 0);
    signal redist15_expY_uid12_fpDivTest_b_8_cmp_b : STD_LOGIC_VECTOR (3 downto 0);
    signal redist15_expY_uid12_fpDivTest_b_8_cmp_q : STD_LOGIC_VECTOR (0 downto 0);
    signal redist15_expY_uid12_fpDivTest_b_8_cmpReg_q : STD_LOGIC_VECTOR (0 downto 0);
    signal redist15_expY_uid12_fpDivTest_b_8_notEnable_q : STD_LOGIC_VECTOR (0 downto 0);
    signal redist15_expY_uid12_fpDivTest_b_8_nor_q : STD_LOGIC_VECTOR (0 downto 0);
    signal redist15_expY_uid12_fpDivTest_b_8_sticky_ena_q : STD_LOGIC_VECTOR (0 downto 0);
    attribute dont_merge of redist15_expY_uid12_fpDivTest_b_8_sticky_ena_q : signal is true;
    signal redist15_expY_uid12_fpDivTest_b_8_enaAnd_q : STD_LOGIC_VECTOR (0 downto 0);
    signal redist17_fracX_uid10_fpDivTest_b_6_mem_reset0 : std_logic;
    signal redist17_fracX_uid10_fpDivTest_b_6_mem_ia : STD_LOGIC_VECTOR (22 downto 0);
    signal redist17_fracX_uid10_fpDivTest_b_6_mem_aa : STD_LOGIC_VECTOR (2 downto 0);
    signal redist17_fracX_uid10_fpDivTest_b_6_mem_ab : STD_LOGIC_VECTOR (2 downto 0);
    signal redist17_fracX_uid10_fpDivTest_b_6_mem_iq : STD_LOGIC_VECTOR (22 downto 0);
    signal redist17_fracX_uid10_fpDivTest_b_6_mem_q : STD_LOGIC_VECTOR (22 downto 0);
    signal redist17_fracX_uid10_fpDivTest_b_6_rdcnt_q : STD_LOGIC_VECTOR (2 downto 0);
    signal redist17_fracX_uid10_fpDivTest_b_6_rdcnt_i : UNSIGNED (2 downto 0);
    attribute preserve of redist17_fracX_uid10_fpDivTest_b_6_rdcnt_i : signal is true;
    signal redist17_fracX_uid10_fpDivTest_b_6_rdcnt_eq : std_logic;
    attribute preserve of redist17_fracX_uid10_fpDivTest_b_6_rdcnt_eq : signal is true;
    signal redist17_fracX_uid10_fpDivTest_b_6_rdmux_s : STD_LOGIC_VECTOR (0 downto 0);
    signal redist17_fracX_uid10_fpDivTest_b_6_rdmux_q : STD_LOGIC_VECTOR (2 downto 0);
    signal redist17_fracX_uid10_fpDivTest_b_6_wraddr_q : STD_LOGIC_VECTOR (2 downto 0);
    signal redist17_fracX_uid10_fpDivTest_b_6_mem_last_q : STD_LOGIC_VECTOR (2 downto 0);
    signal redist17_fracX_uid10_fpDivTest_b_6_cmp_q : STD_LOGIC_VECTOR (0 downto 0);
    signal redist17_fracX_uid10_fpDivTest_b_6_cmpReg_q : STD_LOGIC_VECTOR (0 downto 0);
    signal redist17_fracX_uid10_fpDivTest_b_6_notEnable_q : STD_LOGIC_VECTOR (0 downto 0);
    signal redist17_fracX_uid10_fpDivTest_b_6_nor_q : STD_LOGIC_VECTOR (0 downto 0);
    signal redist17_fracX_uid10_fpDivTest_b_6_sticky_ena_q : STD_LOGIC_VECTOR (0 downto 0);
    attribute dont_merge of redist17_fracX_uid10_fpDivTest_b_6_sticky_ena_q : signal is true;
    signal redist17_fracX_uid10_fpDivTest_b_6_enaAnd_q : STD_LOGIC_VECTOR (0 downto 0);
    signal redist20_expX_uid9_fpDivTest_b_8_mem_reset0 : std_logic;
    signal redist20_expX_uid9_fpDivTest_b_8_mem_ia : STD_LOGIC_VECTOR (7 downto 0);
    signal redist20_expX_uid9_fpDivTest_b_8_mem_aa : STD_LOGIC_VECTOR (2 downto 0);
    signal redist20_expX_uid9_fpDivTest_b_8_mem_ab : STD_LOGIC_VECTOR (2 downto 0);
    signal redist20_expX_uid9_fpDivTest_b_8_mem_iq : STD_LOGIC_VECTOR (7 downto 0);
    signal redist20_expX_uid9_fpDivTest_b_8_mem_q : STD_LOGIC_VECTOR (7 downto 0);
    signal redist20_expX_uid9_fpDivTest_b_8_rdcnt_q : STD_LOGIC_VECTOR (2 downto 0);
    signal redist20_expX_uid9_fpDivTest_b_8_rdcnt_i : UNSIGNED (2 downto 0);
    attribute preserve of redist20_expX_uid9_fpDivTest_b_8_rdcnt_i : signal is true;
    signal redist20_expX_uid9_fpDivTest_b_8_rdcnt_eq : std_logic;
    attribute preserve of redist20_expX_uid9_fpDivTest_b_8_rdcnt_eq : signal is true;
    signal redist20_expX_uid9_fpDivTest_b_8_rdmux_s : STD_LOGIC_VECTOR (0 downto 0);
    signal redist20_expX_uid9_fpDivTest_b_8_rdmux_q : STD_LOGIC_VECTOR (2 downto 0);
    signal redist20_expX_uid9_fpDivTest_b_8_wraddr_q : STD_LOGIC_VECTOR (2 downto 0);
    signal redist20_expX_uid9_fpDivTest_b_8_mem_last_q : STD_LOGIC_VECTOR (3 downto 0);
    signal redist20_expX_uid9_fpDivTest_b_8_cmp_b : STD_LOGIC_VECTOR (3 downto 0);
    signal redist20_expX_uid9_fpDivTest_b_8_cmp_q : STD_LOGIC_VECTOR (0 downto 0);
    signal redist20_expX_uid9_fpDivTest_b_8_cmpReg_q : STD_LOGIC_VECTOR (0 downto 0);
    signal redist20_expX_uid9_fpDivTest_b_8_notEnable_q : STD_LOGIC_VECTOR (0 downto 0);
    signal redist20_expX_uid9_fpDivTest_b_8_nor_q : STD_LOGIC_VECTOR (0 downto 0);
    signal redist20_expX_uid9_fpDivTest_b_8_sticky_ena_q : STD_LOGIC_VECTOR (0 downto 0);
    attribute dont_merge of redist20_expX_uid9_fpDivTest_b_8_sticky_ena_q : signal is true;
    signal redist20_expX_uid9_fpDivTest_b_8_enaAnd_q : STD_LOGIC_VECTOR (0 downto 0);

begin


    -- redist14_fracY_uid13_fpDivTest_b_8_notEnable(LOGICAL,219)
    redist14_fracY_uid13_fpDivTest_b_8_notEnable_q <= STD_LOGIC_VECTOR(not (en));

    -- redist14_fracY_uid13_fpDivTest_b_8_nor(LOGICAL,220)
    redist14_fracY_uid13_fpDivTest_b_8_nor_q <= not (redist14_fracY_uid13_fpDivTest_b_8_notEnable_q or redist14_fracY_uid13_fpDivTest_b_8_sticky_ena_q);

    -- redist14_fracY_uid13_fpDivTest_b_8_mem_last(CONSTANT,216)
    redist14_fracY_uid13_fpDivTest_b_8_mem_last_q <= "0101";

    -- redist14_fracY_uid13_fpDivTest_b_8_cmp(LOGICAL,217)
    redist14_fracY_uid13_fpDivTest_b_8_cmp_b <= STD_LOGIC_VECTOR("0" & redist14_fracY_uid13_fpDivTest_b_8_rdmux_q);
    redist14_fracY_uid13_fpDivTest_b_8_cmp_q <= "1" WHEN redist14_fracY_uid13_fpDivTest_b_8_mem_last_q = redist14_fracY_uid13_fpDivTest_b_8_cmp_b ELSE "0";

    -- redist14_fracY_uid13_fpDivTest_b_8_cmpReg(REG,218)
    redist14_fracY_uid13_fpDivTest_b_8_cmpReg_clkproc: PROCESS (clk, areset)
    BEGIN
        IF (areset = '1') THEN
            redist14_fracY_uid13_fpDivTest_b_8_cmpReg_q <= "0";
        ELSIF (clk'EVENT AND clk = '1') THEN
            IF (en = "1") THEN
                redist14_fracY_uid13_fpDivTest_b_8_cmpReg_q <= STD_LOGIC_VECTOR(redist14_fracY_uid13_fpDivTest_b_8_cmp_q);
            END IF;
        END IF;
    END PROCESS;

    -- redist14_fracY_uid13_fpDivTest_b_8_sticky_ena(REG,221)
    redist14_fracY_uid13_fpDivTest_b_8_sticky_ena_clkproc: PROCESS (clk, areset)
    BEGIN
        IF (areset = '1') THEN
            redist14_fracY_uid13_fpDivTest_b_8_sticky_ena_q <= "0";
        ELSIF (clk'EVENT AND clk = '1') THEN
            IF (redist14_fracY_uid13_fpDivTest_b_8_nor_q = "1") THEN
                redist14_fracY_uid13_fpDivTest_b_8_sticky_ena_q <= STD_LOGIC_VECTOR(redist14_fracY_uid13_fpDivTest_b_8_cmpReg_q);
            END IF;
        END IF;
    END PROCESS;

    -- redist14_fracY_uid13_fpDivTest_b_8_enaAnd(LOGICAL,222)
    redist14_fracY_uid13_fpDivTest_b_8_enaAnd_q <= redist14_fracY_uid13_fpDivTest_b_8_sticky_ena_q and en;

    -- redist14_fracY_uid13_fpDivTest_b_8_rdcnt(COUNTER,213)
    -- low=0, high=6, step=1, init=0
    redist14_fracY_uid13_fpDivTest_b_8_rdcnt_clkproc: PROCESS (clk, areset)
    BEGIN
        IF (areset = '1') THEN
            redist14_fracY_uid13_fpDivTest_b_8_rdcnt_i <= TO_UNSIGNED(0, 3);
            redist14_fracY_uid13_fpDivTest_b_8_rdcnt_eq <= '0';
        ELSIF (clk'EVENT AND clk = '1') THEN
            IF (en = "1") THEN
                IF (redist14_fracY_uid13_fpDivTest_b_8_rdcnt_i = TO_UNSIGNED(5, 3)) THEN
                    redist14_fracY_uid13_fpDivTest_b_8_rdcnt_eq <= '1';
                ELSE
                    redist14_fracY_uid13_fpDivTest_b_8_rdcnt_eq <= '0';
                END IF;
                IF (redist14_fracY_uid13_fpDivTest_b_8_rdcnt_eq = '1') THEN
                    redist14_fracY_uid13_fpDivTest_b_8_rdcnt_i <= redist14_fracY_uid13_fpDivTest_b_8_rdcnt_i + 2;
                ELSE
                    redist14_fracY_uid13_fpDivTest_b_8_rdcnt_i <= redist14_fracY_uid13_fpDivTest_b_8_rdcnt_i + 1;
                END IF;
            END IF;
        END IF;
    END PROCESS;
    redist14_fracY_uid13_fpDivTest_b_8_rdcnt_q <= STD_LOGIC_VECTOR(STD_LOGIC_VECTOR(RESIZE(redist14_fracY_uid13_fpDivTest_b_8_rdcnt_i, 3)));

    -- redist14_fracY_uid13_fpDivTest_b_8_rdmux(MUX,214)
    redist14_fracY_uid13_fpDivTest_b_8_rdmux_s <= en;
    redist14_fracY_uid13_fpDivTest_b_8_rdmux_combproc: PROCESS (redist14_fracY_uid13_fpDivTest_b_8_rdmux_s, redist14_fracY_uid13_fpDivTest_b_8_wraddr_q, redist14_fracY_uid13_fpDivTest_b_8_rdcnt_q)
    BEGIN
        CASE (redist14_fracY_uid13_fpDivTest_b_8_rdmux_s) IS
            WHEN "0" => redist14_fracY_uid13_fpDivTest_b_8_rdmux_q <= redist14_fracY_uid13_fpDivTest_b_8_wraddr_q;
            WHEN "1" => redist14_fracY_uid13_fpDivTest_b_8_rdmux_q <= redist14_fracY_uid13_fpDivTest_b_8_rdcnt_q;
            WHEN OTHERS => redist14_fracY_uid13_fpDivTest_b_8_rdmux_q <= (others => '0');
        END CASE;
    END PROCESS;

    -- VCC(CONSTANT,1)
    VCC_q <= "1";

    -- fracY_uid13_fpDivTest(BITSELECT,12)@0
    fracY_uid13_fpDivTest_b <= b(22 downto 0);

    -- redist14_fracY_uid13_fpDivTest_b_8_wraddr(REG,215)
    redist14_fracY_uid13_fpDivTest_b_8_wraddr_clkproc: PROCESS (clk, areset)
    BEGIN
        IF (areset = '1') THEN
            redist14_fracY_uid13_fpDivTest_b_8_wraddr_q <= "110";
        ELSIF (clk'EVENT AND clk = '1') THEN
            redist14_fracY_uid13_fpDivTest_b_8_wraddr_q <= STD_LOGIC_VECTOR(redist14_fracY_uid13_fpDivTest_b_8_rdmux_q);
        END IF;
    END PROCESS;

    -- redist14_fracY_uid13_fpDivTest_b_8_mem(DUALMEM,212)
    redist14_fracY_uid13_fpDivTest_b_8_mem_ia <= STD_LOGIC_VECTOR(fracY_uid13_fpDivTest_b);
    redist14_fracY_uid13_fpDivTest_b_8_mem_aa <= redist14_fracY_uid13_fpDivTest_b_8_wraddr_q;
    redist14_fracY_uid13_fpDivTest_b_8_mem_ab <= redist14_fracY_uid13_fpDivTest_b_8_rdmux_q;
    redist14_fracY_uid13_fpDivTest_b_8_mem_reset0 <= areset;
    redist14_fracY_uid13_fpDivTest_b_8_mem_dmem : altera_syncram
    GENERIC MAP (
        ram_block_type => "MLAB",
        operation_mode => "DUAL_PORT",
        width_a => 23,
        widthad_a => 3,
        numwords_a => 7,
        width_b => 23,
        widthad_b => 3,
        numwords_b => 7,
        lpm_type => "altera_syncram",
        width_byteena_a => 1,
        address_reg_b => "CLOCK0",
        indata_reg_b => "CLOCK0",
        rdcontrol_reg_b => "CLOCK0",
        byteena_reg_b => "CLOCK0",
        outdata_reg_b => "CLOCK1",
        outdata_aclr_b => "CLEAR1",
        clock_enable_input_a => "NORMAL",
        clock_enable_input_b => "NORMAL",
        clock_enable_output_b => "NORMAL",
        read_during_write_mode_mixed_ports => "DONT_CARE",
        power_up_uninitialized => "TRUE",
        intended_device_family => "Cyclone V"
    )
    PORT MAP (
        clocken1 => redist14_fracY_uid13_fpDivTest_b_8_enaAnd_q(0),
        clocken0 => VCC_q(0),
        clock0 => clk,
        aclr1 => redist14_fracY_uid13_fpDivTest_b_8_mem_reset0,
        clock1 => clk,
        address_a => redist14_fracY_uid13_fpDivTest_b_8_mem_aa,
        data_a => redist14_fracY_uid13_fpDivTest_b_8_mem_ia,
        wren_a => en(0),
        address_b => redist14_fracY_uid13_fpDivTest_b_8_mem_ab,
        q_b => redist14_fracY_uid13_fpDivTest_b_8_mem_iq
    );
    redist14_fracY_uid13_fpDivTest_b_8_mem_q <= redist14_fracY_uid13_fpDivTest_b_8_mem_iq(22 downto 0);

    -- paddingY_uid15_fpDivTest(CONSTANT,14)
    paddingY_uid15_fpDivTest_q <= "00000000000000000000000";

    -- fracXIsZero_uid39_fpDivTest(LOGICAL,38)@8
    fracXIsZero_uid39_fpDivTest_q <= "1" WHEN paddingY_uid15_fpDivTest_q = redist14_fracY_uid13_fpDivTest_b_8_mem_q ELSE "0";

    -- cstAllOWE_uid18_fpDivTest(CONSTANT,17)
    cstAllOWE_uid18_fpDivTest_q <= "11111111";

    -- redist15_expY_uid12_fpDivTest_b_8_notEnable(LOGICAL,230)
    redist15_expY_uid12_fpDivTest_b_8_notEnable_q <= STD_LOGIC_VECTOR(not (en));

    -- redist15_expY_uid12_fpDivTest_b_8_nor(LOGICAL,231)
    redist15_expY_uid12_fpDivTest_b_8_nor_q <= not (redist15_expY_uid12_fpDivTest_b_8_notEnable_q or redist15_expY_uid12_fpDivTest_b_8_sticky_ena_q);

    -- redist15_expY_uid12_fpDivTest_b_8_mem_last(CONSTANT,227)
    redist15_expY_uid12_fpDivTest_b_8_mem_last_q <= "0101";

    -- redist15_expY_uid12_fpDivTest_b_8_cmp(LOGICAL,228)
    redist15_expY_uid12_fpDivTest_b_8_cmp_b <= STD_LOGIC_VECTOR("0" & redist15_expY_uid12_fpDivTest_b_8_rdmux_q);
    redist15_expY_uid12_fpDivTest_b_8_cmp_q <= "1" WHEN redist15_expY_uid12_fpDivTest_b_8_mem_last_q = redist15_expY_uid12_fpDivTest_b_8_cmp_b ELSE "0";

    -- redist15_expY_uid12_fpDivTest_b_8_cmpReg(REG,229)
    redist15_expY_uid12_fpDivTest_b_8_cmpReg_clkproc: PROCESS (clk, areset)
    BEGIN
        IF (areset = '1') THEN
            redist15_expY_uid12_fpDivTest_b_8_cmpReg_q <= "0";
        ELSIF (clk'EVENT AND clk = '1') THEN
            IF (en = "1") THEN
                redist15_expY_uid12_fpDivTest_b_8_cmpReg_q <= STD_LOGIC_VECTOR(redist15_expY_uid12_fpDivTest_b_8_cmp_q);
            END IF;
        END IF;
    END PROCESS;

    -- redist15_expY_uid12_fpDivTest_b_8_sticky_ena(REG,232)
    redist15_expY_uid12_fpDivTest_b_8_sticky_ena_clkproc: PROCESS (clk, areset)
    BEGIN
        IF (areset = '1') THEN
            redist15_expY_uid12_fpDivTest_b_8_sticky_ena_q <= "0";
        ELSIF (clk'EVENT AND clk = '1') THEN
            IF (redist15_expY_uid12_fpDivTest_b_8_nor_q = "1") THEN
                redist15_expY_uid12_fpDivTest_b_8_sticky_ena_q <= STD_LOGIC_VECTOR(redist15_expY_uid12_fpDivTest_b_8_cmpReg_q);
            END IF;
        END IF;
    END PROCESS;

    -- redist15_expY_uid12_fpDivTest_b_8_enaAnd(LOGICAL,233)
    redist15_expY_uid12_fpDivTest_b_8_enaAnd_q <= redist15_expY_uid12_fpDivTest_b_8_sticky_ena_q and en;

    -- redist15_expY_uid12_fpDivTest_b_8_rdcnt(COUNTER,224)
    -- low=0, high=6, step=1, init=0
    redist15_expY_uid12_fpDivTest_b_8_rdcnt_clkproc: PROCESS (clk, areset)
    BEGIN
        IF (areset = '1') THEN
            redist15_expY_uid12_fpDivTest_b_8_rdcnt_i <= TO_UNSIGNED(0, 3);
            redist15_expY_uid12_fpDivTest_b_8_rdcnt_eq <= '0';
        ELSIF (clk'EVENT AND clk = '1') THEN
            IF (en = "1") THEN
                IF (redist15_expY_uid12_fpDivTest_b_8_rdcnt_i = TO_UNSIGNED(5, 3)) THEN
                    redist15_expY_uid12_fpDivTest_b_8_rdcnt_eq <= '1';
                ELSE
                    redist15_expY_uid12_fpDivTest_b_8_rdcnt_eq <= '0';
                END IF;
                IF (redist15_expY_uid12_fpDivTest_b_8_rdcnt_eq = '1') THEN
                    redist15_expY_uid12_fpDivTest_b_8_rdcnt_i <= redist15_expY_uid12_fpDivTest_b_8_rdcnt_i + 2;
                ELSE
                    redist15_expY_uid12_fpDivTest_b_8_rdcnt_i <= redist15_expY_uid12_fpDivTest_b_8_rdcnt_i + 1;
                END IF;
            END IF;
        END IF;
    END PROCESS;
    redist15_expY_uid12_fpDivTest_b_8_rdcnt_q <= STD_LOGIC_VECTOR(STD_LOGIC_VECTOR(RESIZE(redist15_expY_uid12_fpDivTest_b_8_rdcnt_i, 3)));

    -- redist15_expY_uid12_fpDivTest_b_8_rdmux(MUX,225)
    redist15_expY_uid12_fpDivTest_b_8_rdmux_s <= en;
    redist15_expY_uid12_fpDivTest_b_8_rdmux_combproc: PROCESS (redist15_expY_uid12_fpDivTest_b_8_rdmux_s, redist15_expY_uid12_fpDivTest_b_8_wraddr_q, redist15_expY_uid12_fpDivTest_b_8_rdcnt_q)
    BEGIN
        CASE (redist15_expY_uid12_fpDivTest_b_8_rdmux_s) IS
            WHEN "0" => redist15_expY_uid12_fpDivTest_b_8_rdmux_q <= redist15_expY_uid12_fpDivTest_b_8_wraddr_q;
            WHEN "1" => redist15_expY_uid12_fpDivTest_b_8_rdmux_q <= redist15_expY_uid12_fpDivTest_b_8_rdcnt_q;
            WHEN OTHERS => redist15_expY_uid12_fpDivTest_b_8_rdmux_q <= (others => '0');
        END CASE;
    END PROCESS;

    -- expY_uid12_fpDivTest(BITSELECT,11)@0
    expY_uid12_fpDivTest_b <= b(30 downto 23);

    -- redist15_expY_uid12_fpDivTest_b_8_wraddr(REG,226)
    redist15_expY_uid12_fpDivTest_b_8_wraddr_clkproc: PROCESS (clk, areset)
    BEGIN
        IF (areset = '1') THEN
            redist15_expY_uid12_fpDivTest_b_8_wraddr_q <= "110";
        ELSIF (clk'EVENT AND clk = '1') THEN
            redist15_expY_uid12_fpDivTest_b_8_wraddr_q <= STD_LOGIC_VECTOR(redist15_expY_uid12_fpDivTest_b_8_rdmux_q);
        END IF;
    END PROCESS;

    -- redist15_expY_uid12_fpDivTest_b_8_mem(DUALMEM,223)
    redist15_expY_uid12_fpDivTest_b_8_mem_ia <= STD_LOGIC_VECTOR(expY_uid12_fpDivTest_b);
    redist15_expY_uid12_fpDivTest_b_8_mem_aa <= redist15_expY_uid12_fpDivTest_b_8_wraddr_q;
    redist15_expY_uid12_fpDivTest_b_8_mem_ab <= redist15_expY_uid12_fpDivTest_b_8_rdmux_q;
    redist15_expY_uid12_fpDivTest_b_8_mem_reset0 <= areset;
    redist15_expY_uid12_fpDivTest_b_8_mem_dmem : altera_syncram
    GENERIC MAP (
        ram_block_type => "MLAB",
        operation_mode => "DUAL_PORT",
        width_a => 8,
        widthad_a => 3,
        numwords_a => 7,
        width_b => 8,
        widthad_b => 3,
        numwords_b => 7,
        lpm_type => "altera_syncram",
        width_byteena_a => 1,
        address_reg_b => "CLOCK0",
        indata_reg_b => "CLOCK0",
        rdcontrol_reg_b => "CLOCK0",
        byteena_reg_b => "CLOCK0",
        outdata_reg_b => "CLOCK1",
        outdata_aclr_b => "CLEAR1",
        clock_enable_input_a => "NORMAL",
        clock_enable_input_b => "NORMAL",
        clock_enable_output_b => "NORMAL",
        read_during_write_mode_mixed_ports => "DONT_CARE",
        power_up_uninitialized => "TRUE",
        intended_device_family => "Cyclone V"
    )
    PORT MAP (
        clocken1 => redist15_expY_uid12_fpDivTest_b_8_enaAnd_q(0),
        clocken0 => VCC_q(0),
        clock0 => clk,
        aclr1 => redist15_expY_uid12_fpDivTest_b_8_mem_reset0,
        clock1 => clk,
        address_a => redist15_expY_uid12_fpDivTest_b_8_mem_aa,
        data_a => redist15_expY_uid12_fpDivTest_b_8_mem_ia,
        wren_a => en(0),
        address_b => redist15_expY_uid12_fpDivTest_b_8_mem_ab,
        q_b => redist15_expY_uid12_fpDivTest_b_8_mem_iq
    );
    redist15_expY_uid12_fpDivTest_b_8_mem_q <= redist15_expY_uid12_fpDivTest_b_8_mem_iq(7 downto 0);

    -- expXIsMax_uid38_fpDivTest(LOGICAL,37)@8
    expXIsMax_uid38_fpDivTest_q <= "1" WHEN redist15_expY_uid12_fpDivTest_b_8_mem_q = cstAllOWE_uid18_fpDivTest_q ELSE "0";

    -- excI_y_uid41_fpDivTest(LOGICAL,40)@8
    excI_y_uid41_fpDivTest_q <= expXIsMax_uid38_fpDivTest_q and fracXIsZero_uid39_fpDivTest_q;

    -- redist17_fracX_uid10_fpDivTest_b_6_notEnable(LOGICAL,241)
    redist17_fracX_uid10_fpDivTest_b_6_notEnable_q <= STD_LOGIC_VECTOR(not (en));

    -- redist17_fracX_uid10_fpDivTest_b_6_nor(LOGICAL,242)
    redist17_fracX_uid10_fpDivTest_b_6_nor_q <= not (redist17_fracX_uid10_fpDivTest_b_6_notEnable_q or redist17_fracX_uid10_fpDivTest_b_6_sticky_ena_q);

    -- redist17_fracX_uid10_fpDivTest_b_6_mem_last(CONSTANT,238)
    redist17_fracX_uid10_fpDivTest_b_6_mem_last_q <= "011";

    -- redist17_fracX_uid10_fpDivTest_b_6_cmp(LOGICAL,239)
    redist17_fracX_uid10_fpDivTest_b_6_cmp_q <= "1" WHEN redist17_fracX_uid10_fpDivTest_b_6_mem_last_q = redist17_fracX_uid10_fpDivTest_b_6_rdmux_q ELSE "0";

    -- redist17_fracX_uid10_fpDivTest_b_6_cmpReg(REG,240)
    redist17_fracX_uid10_fpDivTest_b_6_cmpReg_clkproc: PROCESS (clk, areset)
    BEGIN
        IF (areset = '1') THEN
            redist17_fracX_uid10_fpDivTest_b_6_cmpReg_q <= "0";
        ELSIF (clk'EVENT AND clk = '1') THEN
            IF (en = "1") THEN
                redist17_fracX_uid10_fpDivTest_b_6_cmpReg_q <= STD_LOGIC_VECTOR(redist17_fracX_uid10_fpDivTest_b_6_cmp_q);
            END IF;
        END IF;
    END PROCESS;

    -- redist17_fracX_uid10_fpDivTest_b_6_sticky_ena(REG,243)
    redist17_fracX_uid10_fpDivTest_b_6_sticky_ena_clkproc: PROCESS (clk, areset)
    BEGIN
        IF (areset = '1') THEN
            redist17_fracX_uid10_fpDivTest_b_6_sticky_ena_q <= "0";
        ELSIF (clk'EVENT AND clk = '1') THEN
            IF (redist17_fracX_uid10_fpDivTest_b_6_nor_q = "1") THEN
                redist17_fracX_uid10_fpDivTest_b_6_sticky_ena_q <= STD_LOGIC_VECTOR(redist17_fracX_uid10_fpDivTest_b_6_cmpReg_q);
            END IF;
        END IF;
    END PROCESS;

    -- redist17_fracX_uid10_fpDivTest_b_6_enaAnd(LOGICAL,244)
    redist17_fracX_uid10_fpDivTest_b_6_enaAnd_q <= redist17_fracX_uid10_fpDivTest_b_6_sticky_ena_q and en;

    -- redist17_fracX_uid10_fpDivTest_b_6_rdcnt(COUNTER,235)
    -- low=0, high=4, step=1, init=0
    redist17_fracX_uid10_fpDivTest_b_6_rdcnt_clkproc: PROCESS (clk, areset)
    BEGIN
        IF (areset = '1') THEN
            redist17_fracX_uid10_fpDivTest_b_6_rdcnt_i <= TO_UNSIGNED(0, 3);
            redist17_fracX_uid10_fpDivTest_b_6_rdcnt_eq <= '0';
        ELSIF (clk'EVENT AND clk = '1') THEN
            IF (en = "1") THEN
                IF (redist17_fracX_uid10_fpDivTest_b_6_rdcnt_i = TO_UNSIGNED(3, 3)) THEN
                    redist17_fracX_uid10_fpDivTest_b_6_rdcnt_eq <= '1';
                ELSE
                    redist17_fracX_uid10_fpDivTest_b_6_rdcnt_eq <= '0';
                END IF;
                IF (redist17_fracX_uid10_fpDivTest_b_6_rdcnt_eq = '1') THEN
                    redist17_fracX_uid10_fpDivTest_b_6_rdcnt_i <= redist17_fracX_uid10_fpDivTest_b_6_rdcnt_i + 4;
                ELSE
                    redist17_fracX_uid10_fpDivTest_b_6_rdcnt_i <= redist17_fracX_uid10_fpDivTest_b_6_rdcnt_i + 1;
                END IF;
            END IF;
        END IF;
    END PROCESS;
    redist17_fracX_uid10_fpDivTest_b_6_rdcnt_q <= STD_LOGIC_VECTOR(STD_LOGIC_VECTOR(RESIZE(redist17_fracX_uid10_fpDivTest_b_6_rdcnt_i, 3)));

    -- redist17_fracX_uid10_fpDivTest_b_6_rdmux(MUX,236)
    redist17_fracX_uid10_fpDivTest_b_6_rdmux_s <= en;
    redist17_fracX_uid10_fpDivTest_b_6_rdmux_combproc: PROCESS (redist17_fracX_uid10_fpDivTest_b_6_rdmux_s, redist17_fracX_uid10_fpDivTest_b_6_wraddr_q, redist17_fracX_uid10_fpDivTest_b_6_rdcnt_q)
    BEGIN
        CASE (redist17_fracX_uid10_fpDivTest_b_6_rdmux_s) IS
            WHEN "0" => redist17_fracX_uid10_fpDivTest_b_6_rdmux_q <= redist17_fracX_uid10_fpDivTest_b_6_wraddr_q;
            WHEN "1" => redist17_fracX_uid10_fpDivTest_b_6_rdmux_q <= redist17_fracX_uid10_fpDivTest_b_6_rdcnt_q;
            WHEN OTHERS => redist17_fracX_uid10_fpDivTest_b_6_rdmux_q <= (others => '0');
        END CASE;
    END PROCESS;

    -- fracX_uid10_fpDivTest(BITSELECT,9)@0
    fracX_uid10_fpDivTest_b <= a(22 downto 0);

    -- redist17_fracX_uid10_fpDivTest_b_6_wraddr(REG,237)
    redist17_fracX_uid10_fpDivTest_b_6_wraddr_clkproc: PROCESS (clk, areset)
    BEGIN
        IF (areset = '1') THEN
            redist17_fracX_uid10_fpDivTest_b_6_wraddr_q <= "100";
        ELSIF (clk'EVENT AND clk = '1') THEN
            redist17_fracX_uid10_fpDivTest_b_6_wraddr_q <= STD_LOGIC_VECTOR(redist17_fracX_uid10_fpDivTest_b_6_rdmux_q);
        END IF;
    END PROCESS;

    -- redist17_fracX_uid10_fpDivTest_b_6_mem(DUALMEM,234)
    redist17_fracX_uid10_fpDivTest_b_6_mem_ia <= STD_LOGIC_VECTOR(fracX_uid10_fpDivTest_b);
    redist17_fracX_uid10_fpDivTest_b_6_mem_aa <= redist17_fracX_uid10_fpDivTest_b_6_wraddr_q;
    redist17_fracX_uid10_fpDivTest_b_6_mem_ab <= redist17_fracX_uid10_fpDivTest_b_6_rdmux_q;
    redist17_fracX_uid10_fpDivTest_b_6_mem_reset0 <= areset;
    redist17_fracX_uid10_fpDivTest_b_6_mem_dmem : altera_syncram
    GENERIC MAP (
        ram_block_type => "MLAB",
        operation_mode => "DUAL_PORT",
        width_a => 23,
        widthad_a => 3,
        numwords_a => 5,
        width_b => 23,
        widthad_b => 3,
        numwords_b => 5,
        lpm_type => "altera_syncram",
        width_byteena_a => 1,
        address_reg_b => "CLOCK0",
        indata_reg_b => "CLOCK0",
        rdcontrol_reg_b => "CLOCK0",
        byteena_reg_b => "CLOCK0",
        outdata_reg_b => "CLOCK1",
        outdata_aclr_b => "CLEAR1",
        clock_enable_input_a => "NORMAL",
        clock_enable_input_b => "NORMAL",
        clock_enable_output_b => "NORMAL",
        read_during_write_mode_mixed_ports => "DONT_CARE",
        power_up_uninitialized => "TRUE",
        intended_device_family => "Cyclone V"
    )
    PORT MAP (
        clocken1 => redist17_fracX_uid10_fpDivTest_b_6_enaAnd_q(0),
        clocken0 => VCC_q(0),
        clock0 => clk,
        aclr1 => redist17_fracX_uid10_fpDivTest_b_6_mem_reset0,
        clock1 => clk,
        address_a => redist17_fracX_uid10_fpDivTest_b_6_mem_aa,
        data_a => redist17_fracX_uid10_fpDivTest_b_6_mem_ia,
        wren_a => en(0),
        address_b => redist17_fracX_uid10_fpDivTest_b_6_mem_ab,
        q_b => redist17_fracX_uid10_fpDivTest_b_6_mem_iq
    );
    redist17_fracX_uid10_fpDivTest_b_6_mem_q <= redist17_fracX_uid10_fpDivTest_b_6_mem_iq(22 downto 0);

    -- redist18_fracX_uid10_fpDivTest_b_8(DELAY,208)
    redist18_fracX_uid10_fpDivTest_b_8 : dspba_delay
    GENERIC MAP ( width => 23, depth => 2, reset_kind => "ASYNC" )
    PORT MAP ( xin => redist17_fracX_uid10_fpDivTest_b_6_mem_q, xout => redist18_fracX_uid10_fpDivTest_b_8_q, ena => en(0), clk => clk, aclr => areset );

    -- fracXIsZero_uid25_fpDivTest(LOGICAL,24)@8
    fracXIsZero_uid25_fpDivTest_q <= "1" WHEN paddingY_uid15_fpDivTest_q = redist18_fracX_uid10_fpDivTest_b_8_q ELSE "0";

    -- redist20_expX_uid9_fpDivTest_b_8_notEnable(LOGICAL,252)
    redist20_expX_uid9_fpDivTest_b_8_notEnable_q <= STD_LOGIC_VECTOR(not (en));

    -- redist20_expX_uid9_fpDivTest_b_8_nor(LOGICAL,253)
    redist20_expX_uid9_fpDivTest_b_8_nor_q <= not (redist20_expX_uid9_fpDivTest_b_8_notEnable_q or redist20_expX_uid9_fpDivTest_b_8_sticky_ena_q);

    -- redist20_expX_uid9_fpDivTest_b_8_mem_last(CONSTANT,249)
    redist20_expX_uid9_fpDivTest_b_8_mem_last_q <= "0101";

    -- redist20_expX_uid9_fpDivTest_b_8_cmp(LOGICAL,250)
    redist20_expX_uid9_fpDivTest_b_8_cmp_b <= STD_LOGIC_VECTOR("0" & redist20_expX_uid9_fpDivTest_b_8_rdmux_q);
    redist20_expX_uid9_fpDivTest_b_8_cmp_q <= "1" WHEN redist20_expX_uid9_fpDivTest_b_8_mem_last_q = redist20_expX_uid9_fpDivTest_b_8_cmp_b ELSE "0";

    -- redist20_expX_uid9_fpDivTest_b_8_cmpReg(REG,251)
    redist20_expX_uid9_fpDivTest_b_8_cmpReg_clkproc: PROCESS (clk, areset)
    BEGIN
        IF (areset = '1') THEN
            redist20_expX_uid9_fpDivTest_b_8_cmpReg_q <= "0";
        ELSIF (clk'EVENT AND clk = '1') THEN
            IF (en = "1") THEN
                redist20_expX_uid9_fpDivTest_b_8_cmpReg_q <= STD_LOGIC_VECTOR(redist20_expX_uid9_fpDivTest_b_8_cmp_q);
            END IF;
        END IF;
    END PROCESS;

    -- redist20_expX_uid9_fpDivTest_b_8_sticky_ena(REG,254)
    redist20_expX_uid9_fpDivTest_b_8_sticky_ena_clkproc: PROCESS (clk, areset)
    BEGIN
        IF (areset = '1') THEN
            redist20_expX_uid9_fpDivTest_b_8_sticky_ena_q <= "0";
        ELSIF (clk'EVENT AND clk = '1') THEN
            IF (redist20_expX_uid9_fpDivTest_b_8_nor_q = "1") THEN
                redist20_expX_uid9_fpDivTest_b_8_sticky_ena_q <= STD_LOGIC_VECTOR(redist20_expX_uid9_fpDivTest_b_8_cmpReg_q);
            END IF;
        END IF;
    END PROCESS;

    -- redist20_expX_uid9_fpDivTest_b_8_enaAnd(LOGICAL,255)
    redist20_expX_uid9_fpDivTest_b_8_enaAnd_q <= redist20_expX_uid9_fpDivTest_b_8_sticky_ena_q and en;

    -- redist20_expX_uid9_fpDivTest_b_8_rdcnt(COUNTER,246)
    -- low=0, high=6, step=1, init=0
    redist20_expX_uid9_fpDivTest_b_8_rdcnt_clkproc: PROCESS (clk, areset)
    BEGIN
        IF (areset = '1') THEN
            redist20_expX_uid9_fpDivTest_b_8_rdcnt_i <= TO_UNSIGNED(0, 3);
            redist20_expX_uid9_fpDivTest_b_8_rdcnt_eq <= '0';
        ELSIF (clk'EVENT AND clk = '1') THEN
            IF (en = "1") THEN
                IF (redist20_expX_uid9_fpDivTest_b_8_rdcnt_i = TO_UNSIGNED(5, 3)) THEN
                    redist20_expX_uid9_fpDivTest_b_8_rdcnt_eq <= '1';
                ELSE
                    redist20_expX_uid9_fpDivTest_b_8_rdcnt_eq <= '0';
                END IF;
                IF (redist20_expX_uid9_fpDivTest_b_8_rdcnt_eq = '1') THEN
                    redist20_expX_uid9_fpDivTest_b_8_rdcnt_i <= redist20_expX_uid9_fpDivTest_b_8_rdcnt_i + 2;
                ELSE
                    redist20_expX_uid9_fpDivTest_b_8_rdcnt_i <= redist20_expX_uid9_fpDivTest_b_8_rdcnt_i + 1;
                END IF;
            END IF;
        END IF;
    END PROCESS;
    redist20_expX_uid9_fpDivTest_b_8_rdcnt_q <= STD_LOGIC_VECTOR(STD_LOGIC_VECTOR(RESIZE(redist20_expX_uid9_fpDivTest_b_8_rdcnt_i, 3)));

    -- redist20_expX_uid9_fpDivTest_b_8_rdmux(MUX,247)
    redist20_expX_uid9_fpDivTest_b_8_rdmux_s <= en;
    redist20_expX_uid9_fpDivTest_b_8_rdmux_combproc: PROCESS (redist20_expX_uid9_fpDivTest_b_8_rdmux_s, redist20_expX_uid9_fpDivTest_b_8_wraddr_q, redist20_expX_uid9_fpDivTest_b_8_rdcnt_q)
    BEGIN
        CASE (redist20_expX_uid9_fpDivTest_b_8_rdmux_s) IS
            WHEN "0" => redist20_expX_uid9_fpDivTest_b_8_rdmux_q <= redist20_expX_uid9_fpDivTest_b_8_wraddr_q;
            WHEN "1" => redist20_expX_uid9_fpDivTest_b_8_rdmux_q <= redist20_expX_uid9_fpDivTest_b_8_rdcnt_q;
            WHEN OTHERS => redist20_expX_uid9_fpDivTest_b_8_rdmux_q <= (others => '0');
        END CASE;
    END PROCESS;

    -- expX_uid9_fpDivTest(BITSELECT,8)@0
    expX_uid9_fpDivTest_b <= a(30 downto 23);

    -- redist20_expX_uid9_fpDivTest_b_8_wraddr(REG,248)
    redist20_expX_uid9_fpDivTest_b_8_wraddr_clkproc: PROCESS (clk, areset)
    BEGIN
        IF (areset = '1') THEN
            redist20_expX_uid9_fpDivTest_b_8_wraddr_q <= "110";
        ELSIF (clk'EVENT AND clk = '1') THEN
            redist20_expX_uid9_fpDivTest_b_8_wraddr_q <= STD_LOGIC_VECTOR(redist20_expX_uid9_fpDivTest_b_8_rdmux_q);
        END IF;
    END PROCESS;

    -- redist20_expX_uid9_fpDivTest_b_8_mem(DUALMEM,245)
    redist20_expX_uid9_fpDivTest_b_8_mem_ia <= STD_LOGIC_VECTOR(expX_uid9_fpDivTest_b);
    redist20_expX_uid9_fpDivTest_b_8_mem_aa <= redist20_expX_uid9_fpDivTest_b_8_wraddr_q;
    redist20_expX_uid9_fpDivTest_b_8_mem_ab <= redist20_expX_uid9_fpDivTest_b_8_rdmux_q;
    redist20_expX_uid9_fpDivTest_b_8_mem_reset0 <= areset;
    redist20_expX_uid9_fpDivTest_b_8_mem_dmem : altera_syncram
    GENERIC MAP (
        ram_block_type => "MLAB",
        operation_mode => "DUAL_PORT",
        width_a => 8,
        widthad_a => 3,
        numwords_a => 7,
        width_b => 8,
        widthad_b => 3,
        numwords_b => 7,
        lpm_type => "altera_syncram",
        width_byteena_a => 1,
        address_reg_b => "CLOCK0",
        indata_reg_b => "CLOCK0",
        rdcontrol_reg_b => "CLOCK0",
        byteena_reg_b => "CLOCK0",
        outdata_reg_b => "CLOCK1",
        outdata_aclr_b => "CLEAR1",
        clock_enable_input_a => "NORMAL",
        clock_enable_input_b => "NORMAL",
        clock_enable_output_b => "NORMAL",
        read_during_write_mode_mixed_ports => "DONT_CARE",
        power_up_uninitialized => "TRUE",
        intended_device_family => "Cyclone V"
    )
    PORT MAP (
        clocken1 => redist20_expX_uid9_fpDivTest_b_8_enaAnd_q(0),
        clocken0 => VCC_q(0),
        clock0 => clk,
        aclr1 => redist20_expX_uid9_fpDivTest_b_8_mem_reset0,
        clock1 => clk,
        address_a => redist20_expX_uid9_fpDivTest_b_8_mem_aa,
        data_a => redist20_expX_uid9_fpDivTest_b_8_mem_ia,
        wren_a => en(0),
        address_b => redist20_expX_uid9_fpDivTest_b_8_mem_ab,
        q_b => redist20_expX_uid9_fpDivTest_b_8_mem_iq
    );
    redist20_expX_uid9_fpDivTest_b_8_mem_q <= redist20_expX_uid9_fpDivTest_b_8_mem_iq(7 downto 0);

    -- expXIsMax_uid24_fpDivTest(LOGICAL,23)@8
    expXIsMax_uid24_fpDivTest_q <= "1" WHEN redist20_expX_uid9_fpDivTest_b_8_mem_q = cstAllOWE_uid18_fpDivTest_q ELSE "0";

    -- excI_x_uid27_fpDivTest(LOGICAL,26)@8
    excI_x_uid27_fpDivTest_q <= expXIsMax_uid24_fpDivTest_q and fracXIsZero_uid25_fpDivTest_q;

    -- excXIYI_uid130_fpDivTest(LOGICAL,129)@8
    excXIYI_uid130_fpDivTest_q <= excI_x_uid27_fpDivTest_q and excI_y_uid41_fpDivTest_q;

    -- fracXIsNotZero_uid40_fpDivTest(LOGICAL,39)@8
    fracXIsNotZero_uid40_fpDivTest_q <= not (fracXIsZero_uid39_fpDivTest_q);

    -- excN_y_uid42_fpDivTest(LOGICAL,41)@8
    excN_y_uid42_fpDivTest_q <= expXIsMax_uid38_fpDivTest_q and fracXIsNotZero_uid40_fpDivTest_q;

    -- fracXIsNotZero_uid26_fpDivTest(LOGICAL,25)@8
    fracXIsNotZero_uid26_fpDivTest_q <= not (fracXIsZero_uid25_fpDivTest_q);

    -- excN_x_uid28_fpDivTest(LOGICAL,27)@8
    excN_x_uid28_fpDivTest_q <= expXIsMax_uid24_fpDivTest_q and fracXIsNotZero_uid26_fpDivTest_q;

    -- cstAllZWE_uid20_fpDivTest(CONSTANT,19)
    cstAllZWE_uid20_fpDivTest_q <= "00000000";

    -- excZ_y_uid37_fpDivTest(LOGICAL,36)@8
    excZ_y_uid37_fpDivTest_q <= "1" WHEN redist15_expY_uid12_fpDivTest_b_8_mem_q = cstAllZWE_uid20_fpDivTest_q ELSE "0";

    -- excZ_x_uid23_fpDivTest(LOGICAL,22)@8
    excZ_x_uid23_fpDivTest_q <= "1" WHEN redist20_expX_uid9_fpDivTest_b_8_mem_q = cstAllZWE_uid20_fpDivTest_q ELSE "0";

    -- excXZYZ_uid129_fpDivTest(LOGICAL,128)@8
    excXZYZ_uid129_fpDivTest_q <= excZ_x_uid23_fpDivTest_q and excZ_y_uid37_fpDivTest_q;

    -- excRNaN_uid131_fpDivTest(LOGICAL,130)@8
    excRNaN_uid131_fpDivTest_q <= excXZYZ_uid129_fpDivTest_q or excN_x_uid28_fpDivTest_q or excN_y_uid42_fpDivTest_q or excXIYI_uid130_fpDivTest_q;

    -- invExcRNaN_uid142_fpDivTest(LOGICAL,141)@8
    invExcRNaN_uid142_fpDivTest_q <= not (excRNaN_uid131_fpDivTest_q);

    -- signY_uid14_fpDivTest(BITSELECT,13)@0
    signY_uid14_fpDivTest_b <= STD_LOGIC_VECTOR(b(31 downto 31));

    -- signX_uid11_fpDivTest(BITSELECT,10)@0
    signX_uid11_fpDivTest_b <= STD_LOGIC_VECTOR(a(31 downto 31));

    -- signR_uid46_fpDivTest(LOGICAL,45)@0 + 1
    signR_uid46_fpDivTest_qi <= signX_uid11_fpDivTest_b xor signY_uid14_fpDivTest_b;
    signR_uid46_fpDivTest_delay : dspba_delay
    GENERIC MAP ( width => 1, depth => 1, reset_kind => "ASYNC" )
    PORT MAP ( xin => signR_uid46_fpDivTest_qi, xout => signR_uid46_fpDivTest_q, ena => en(0), clk => clk, aclr => areset );

    -- redist13_signR_uid46_fpDivTest_q_8(DELAY,203)
    redist13_signR_uid46_fpDivTest_q_8 : dspba_delay
    GENERIC MAP ( width => 1, depth => 7, reset_kind => "ASYNC" )
    PORT MAP ( xin => signR_uid46_fpDivTest_q, xout => redist13_signR_uid46_fpDivTest_q_8_q, ena => en(0), clk => clk, aclr => areset );

    -- sRPostExc_uid143_fpDivTest(LOGICAL,142)@8 + 1
    sRPostExc_uid143_fpDivTest_qi <= redist13_signR_uid46_fpDivTest_q_8_q and invExcRNaN_uid142_fpDivTest_q;
    sRPostExc_uid143_fpDivTest_delay : dspba_delay
    GENERIC MAP ( width => 1, depth => 1, reset_kind => "ASYNC" )
    PORT MAP ( xin => sRPostExc_uid143_fpDivTest_qi, xout => sRPostExc_uid143_fpDivTest_q, ena => en(0), clk => clk, aclr => areset );

    -- redist0_sRPostExc_uid143_fpDivTest_q_3(DELAY,190)
    redist0_sRPostExc_uid143_fpDivTest_q_3 : dspba_delay
    GENERIC MAP ( width => 1, depth => 2, reset_kind => "ASYNC" )
    PORT MAP ( xin => sRPostExc_uid143_fpDivTest_q, xout => redist0_sRPostExc_uid143_fpDivTest_q_3_q, ena => en(0), clk => clk, aclr => areset );

    -- GND(CONSTANT,0)
    GND_q <= "0";

    -- fracXExt_uid77_fpDivTest(BITJOIN,76)@8
    fracXExt_uid77_fpDivTest_q <= redist18_fracX_uid10_fpDivTest_b_8_q & GND_q;

    -- lOAdded_uid57_fpDivTest(BITJOIN,56)@6
    lOAdded_uid57_fpDivTest_q <= VCC_q & redist17_fracX_uid10_fpDivTest_b_6_mem_q;

    -- redist6_lOAdded_uid57_fpDivTest_q_2(DELAY,196)
    redist6_lOAdded_uid57_fpDivTest_q_2 : dspba_delay
    GENERIC MAP ( width => 24, depth => 2, reset_kind => "ASYNC" )
    PORT MAP ( xin => lOAdded_uid57_fpDivTest_q, xout => redist6_lOAdded_uid57_fpDivTest_q_2_q, ena => en(0), clk => clk, aclr => areset );

    -- z4_uid60_fpDivTest(CONSTANT,59)
    z4_uid60_fpDivTest_q <= "0000";

    -- oFracXZ4_uid61_fpDivTest(BITJOIN,60)@8
    oFracXZ4_uid61_fpDivTest_q <= redist6_lOAdded_uid57_fpDivTest_q_2_q & z4_uid60_fpDivTest_q;

    -- yAddr_uid51_fpDivTest(BITSELECT,50)@0
    yAddr_uid51_fpDivTest_b <= fracY_uid13_fpDivTest_b(22 downto 14);

    -- memoryC2_uid154_invTables_lutmem(DUALMEM,185)@0 + 2
    -- in j@20000000
    memoryC2_uid154_invTables_lutmem_aa <= yAddr_uid51_fpDivTest_b;
    memoryC2_uid154_invTables_lutmem_reset0 <= areset;
    memoryC2_uid154_invTables_lutmem_dmem : altera_syncram
    GENERIC MAP (
        ram_block_type => "M10K",
        operation_mode => "ROM",
        width_a => 13,
        widthad_a => 9,
        numwords_a => 512,
        lpm_type => "altera_syncram",
        width_byteena_a => 1,
        outdata_reg_a => "CLOCK0",
        outdata_aclr_a => "CLEAR0",
        clock_enable_input_a => "NORMAL",
        power_up_uninitialized => "FALSE",
        init_file => "FP_Function_Div_memoryC2_uid154_invTables_lutmem.hex",
        init_file_layout => "PORT_A",
        intended_device_family => "Cyclone V"
    )
    PORT MAP (
        clocken0 => en(0),
        aclr0 => memoryC2_uid154_invTables_lutmem_reset0,
        clock0 => clk,
        address_a => memoryC2_uid154_invTables_lutmem_aa,
        q_a => memoryC2_uid154_invTables_lutmem_ir
    );
    memoryC2_uid154_invTables_lutmem_r <= memoryC2_uid154_invTables_lutmem_ir(12 downto 0);

    -- yPE_uid52_fpDivTest(BITSELECT,51)@0
    yPE_uid52_fpDivTest_b <= b(13 downto 0);

    -- redist9_yPE_uid52_fpDivTest_b_2(DELAY,199)
    redist9_yPE_uid52_fpDivTest_b_2 : dspba_delay
    GENERIC MAP ( width => 14, depth => 2, reset_kind => "ASYNC" )
    PORT MAP ( xin => yPE_uid52_fpDivTest_b, xout => redist9_yPE_uid52_fpDivTest_b_2_q, ena => en(0), clk => clk, aclr => areset );

    -- yT1_uid160_invPolyEval(BITSELECT,159)@2
    yT1_uid160_invPolyEval_b <= redist9_yPE_uid52_fpDivTest_b_2_q(13 downto 1);

    -- prodXY_uid176_pT1_uid161_invPolyEval_cma(CHAINMULTADD,188)@2 + 2
    prodXY_uid176_pT1_uid161_invPolyEval_cma_reset <= areset;
    prodXY_uid176_pT1_uid161_invPolyEval_cma_ena0 <= en(0);
    prodXY_uid176_pT1_uid161_invPolyEval_cma_ena1 <= prodXY_uid176_pT1_uid161_invPolyEval_cma_ena0;
    prodXY_uid176_pT1_uid161_invPolyEval_cma_l(0) <= SIGNED(RESIZE(prodXY_uid176_pT1_uid161_invPolyEval_cma_a0(0),14));
    prodXY_uid176_pT1_uid161_invPolyEval_cma_p(0) <= prodXY_uid176_pT1_uid161_invPolyEval_cma_l(0) * prodXY_uid176_pT1_uid161_invPolyEval_cma_c0(0);
    prodXY_uid176_pT1_uid161_invPolyEval_cma_u(0) <= RESIZE(prodXY_uid176_pT1_uid161_invPolyEval_cma_p(0),27);
    prodXY_uid176_pT1_uid161_invPolyEval_cma_w(0) <= prodXY_uid176_pT1_uid161_invPolyEval_cma_u(0);
    prodXY_uid176_pT1_uid161_invPolyEval_cma_x(0) <= prodXY_uid176_pT1_uid161_invPolyEval_cma_w(0);
    prodXY_uid176_pT1_uid161_invPolyEval_cma_y(0) <= prodXY_uid176_pT1_uid161_invPolyEval_cma_x(0);
    prodXY_uid176_pT1_uid161_invPolyEval_cma_chainmultadd_input: PROCESS (clk, areset)
    BEGIN
        IF (areset = '1') THEN
            prodXY_uid176_pT1_uid161_invPolyEval_cma_a0 <= (others => (others => '0'));
            prodXY_uid176_pT1_uid161_invPolyEval_cma_c0 <= (others => (others => '0'));
        ELSIF (clk'EVENT AND clk = '1') THEN
            IF (prodXY_uid176_pT1_uid161_invPolyEval_cma_ena0 = '1') THEN
                prodXY_uid176_pT1_uid161_invPolyEval_cma_a0(0) <= RESIZE(UNSIGNED(yT1_uid160_invPolyEval_b),13);
                prodXY_uid176_pT1_uid161_invPolyEval_cma_c0(0) <= RESIZE(SIGNED(memoryC2_uid154_invTables_lutmem_r),13);
            END IF;
        END IF;
    END PROCESS;
    prodXY_uid176_pT1_uid161_invPolyEval_cma_chainmultadd_output: PROCESS (clk, areset)
    BEGIN
        IF (areset = '1') THEN
            prodXY_uid176_pT1_uid161_invPolyEval_cma_s <= (others => (others => '0'));
        ELSIF (clk'EVENT AND clk = '1') THEN
            IF (prodXY_uid176_pT1_uid161_invPolyEval_cma_ena1 = '1') THEN
                prodXY_uid176_pT1_uid161_invPolyEval_cma_s(0) <= prodXY_uid176_pT1_uid161_invPolyEval_cma_y(0);
            END IF;
        END IF;
    END PROCESS;
    prodXY_uid176_pT1_uid161_invPolyEval_cma_delay : dspba_delay
    GENERIC MAP ( width => 26, depth => 0, reset_kind => "ASYNC" )
    PORT MAP ( xin => STD_LOGIC_VECTOR(prodXY_uid176_pT1_uid161_invPolyEval_cma_s(0)(25 downto 0)), xout => prodXY_uid176_pT1_uid161_invPolyEval_cma_qq, ena => en(0), clk => clk, aclr => areset );
    prodXY_uid176_pT1_uid161_invPolyEval_cma_q <= STD_LOGIC_VECTOR(prodXY_uid176_pT1_uid161_invPolyEval_cma_qq(25 downto 0));

    -- osig_uid177_pT1_uid161_invPolyEval(BITSELECT,176)@4
    osig_uid177_pT1_uid161_invPolyEval_b <= STD_LOGIC_VECTOR(prodXY_uid176_pT1_uid161_invPolyEval_cma_q(25 downto 12));

    -- highBBits_uid163_invPolyEval(BITSELECT,162)@4
    highBBits_uid163_invPolyEval_b <= STD_LOGIC_VECTOR(osig_uid177_pT1_uid161_invPolyEval_b(13 downto 1));

    -- redist11_yAddr_uid51_fpDivTest_b_2(DELAY,201)
    redist11_yAddr_uid51_fpDivTest_b_2 : dspba_delay
    GENERIC MAP ( width => 9, depth => 2, reset_kind => "ASYNC" )
    PORT MAP ( xin => yAddr_uid51_fpDivTest_b, xout => redist11_yAddr_uid51_fpDivTest_b_2_q, ena => en(0), clk => clk, aclr => areset );

    -- memoryC1_uid151_invTables_lutmem(DUALMEM,184)@2 + 2
    -- in j@20000000
    memoryC1_uid151_invTables_lutmem_aa <= redist11_yAddr_uid51_fpDivTest_b_2_q;
    memoryC1_uid151_invTables_lutmem_reset0 <= areset;
    memoryC1_uid151_invTables_lutmem_dmem : altera_syncram
    GENERIC MAP (
        ram_block_type => "M10K",
        operation_mode => "ROM",
        width_a => 2,
        widthad_a => 9,
        numwords_a => 512,
        lpm_type => "altera_syncram",
        width_byteena_a => 1,
        outdata_reg_a => "CLOCK0",
        outdata_aclr_a => "CLEAR0",
        clock_enable_input_a => "NORMAL",
        power_up_uninitialized => "FALSE",
        init_file => "FP_Function_Div_memoryC1_uid151_invTables_lutmem.hex",
        init_file_layout => "PORT_A",
        intended_device_family => "Cyclone V"
    )
    PORT MAP (
        clocken0 => en(0),
        aclr0 => memoryC1_uid151_invTables_lutmem_reset0,
        clock0 => clk,
        address_a => memoryC1_uid151_invTables_lutmem_aa,
        q_a => memoryC1_uid151_invTables_lutmem_ir
    );
    memoryC1_uid151_invTables_lutmem_r <= memoryC1_uid151_invTables_lutmem_ir(1 downto 0);

    -- memoryC1_uid150_invTables_lutmem(DUALMEM,183)@2 + 2
    -- in j@20000000
    memoryC1_uid150_invTables_lutmem_aa <= redist11_yAddr_uid51_fpDivTest_b_2_q;
    memoryC1_uid150_invTables_lutmem_reset0 <= areset;
    memoryC1_uid150_invTables_lutmem_dmem : altera_syncram
    GENERIC MAP (
        ram_block_type => "M10K",
        operation_mode => "ROM",
        width_a => 20,
        widthad_a => 9,
        numwords_a => 512,
        lpm_type => "altera_syncram",
        width_byteena_a => 1,
        outdata_reg_a => "CLOCK0",
        outdata_aclr_a => "CLEAR0",
        clock_enable_input_a => "NORMAL",
        power_up_uninitialized => "FALSE",
        init_file => "FP_Function_Div_memoryC1_uid150_invTables_lutmem.hex",
        init_file_layout => "PORT_A",
        intended_device_family => "Cyclone V"
    )
    PORT MAP (
        clocken0 => en(0),
        aclr0 => memoryC1_uid150_invTables_lutmem_reset0,
        clock0 => clk,
        address_a => memoryC1_uid150_invTables_lutmem_aa,
        q_a => memoryC1_uid150_invTables_lutmem_ir
    );
    memoryC1_uid150_invTables_lutmem_r <= memoryC1_uid150_invTables_lutmem_ir(19 downto 0);

    -- os_uid152_invTables(BITJOIN,151)@4
    os_uid152_invTables_q <= memoryC1_uid151_invTables_lutmem_r & memoryC1_uid150_invTables_lutmem_r;

    -- s1sumAHighB_uid164_invPolyEval(ADD,163)@4
    s1sumAHighB_uid164_invPolyEval_a <= STD_LOGIC_VECTOR(STD_LOGIC_VECTOR((22 downto 22 => os_uid152_invTables_q(21)) & os_uid152_invTables_q));
    s1sumAHighB_uid164_invPolyEval_b <= STD_LOGIC_VECTOR(STD_LOGIC_VECTOR((22 downto 13 => highBBits_uid163_invPolyEval_b(12)) & highBBits_uid163_invPolyEval_b));
    s1sumAHighB_uid164_invPolyEval_o <= STD_LOGIC_VECTOR(SIGNED(s1sumAHighB_uid164_invPolyEval_a) + SIGNED(s1sumAHighB_uid164_invPolyEval_b));
    s1sumAHighB_uid164_invPolyEval_q <= s1sumAHighB_uid164_invPolyEval_o(22 downto 0);

    -- lowRangeB_uid162_invPolyEval(BITSELECT,161)@4
    lowRangeB_uid162_invPolyEval_in <= osig_uid177_pT1_uid161_invPolyEval_b(0 downto 0);
    lowRangeB_uid162_invPolyEval_b <= lowRangeB_uid162_invPolyEval_in(0 downto 0);

    -- s1_uid165_invPolyEval(BITJOIN,164)@4
    s1_uid165_invPolyEval_q <= s1sumAHighB_uid164_invPolyEval_q & lowRangeB_uid162_invPolyEval_b;

    -- redist10_yPE_uid52_fpDivTest_b_4(DELAY,200)
    redist10_yPE_uid52_fpDivTest_b_4 : dspba_delay
    GENERIC MAP ( width => 14, depth => 2, reset_kind => "ASYNC" )
    PORT MAP ( xin => redist9_yPE_uid52_fpDivTest_b_2_q, xout => redist10_yPE_uid52_fpDivTest_b_4_q, ena => en(0), clk => clk, aclr => areset );

    -- prodXY_uid179_pT2_uid167_invPolyEval_cma(CHAINMULTADD,189)@4 + 2
    prodXY_uid179_pT2_uid167_invPolyEval_cma_reset <= areset;
    prodXY_uid179_pT2_uid167_invPolyEval_cma_ena0 <= en(0);
    prodXY_uid179_pT2_uid167_invPolyEval_cma_ena1 <= prodXY_uid179_pT2_uid167_invPolyEval_cma_ena0;
    prodXY_uid179_pT2_uid167_invPolyEval_cma_l(0) <= SIGNED(RESIZE(prodXY_uid179_pT2_uid167_invPolyEval_cma_a0(0),15));
    prodXY_uid179_pT2_uid167_invPolyEval_cma_p(0) <= prodXY_uid179_pT2_uid167_invPolyEval_cma_l(0) * prodXY_uid179_pT2_uid167_invPolyEval_cma_c0(0);
    prodXY_uid179_pT2_uid167_invPolyEval_cma_u(0) <= RESIZE(prodXY_uid179_pT2_uid167_invPolyEval_cma_p(0),39);
    prodXY_uid179_pT2_uid167_invPolyEval_cma_w(0) <= prodXY_uid179_pT2_uid167_invPolyEval_cma_u(0);
    prodXY_uid179_pT2_uid167_invPolyEval_cma_x(0) <= prodXY_uid179_pT2_uid167_invPolyEval_cma_w(0);
    prodXY_uid179_pT2_uid167_invPolyEval_cma_y(0) <= prodXY_uid179_pT2_uid167_invPolyEval_cma_x(0);
    prodXY_uid179_pT2_uid167_invPolyEval_cma_chainmultadd_input: PROCESS (clk, areset)
    BEGIN
        IF (areset = '1') THEN
            prodXY_uid179_pT2_uid167_invPolyEval_cma_a0 <= (others => (others => '0'));
            prodXY_uid179_pT2_uid167_invPolyEval_cma_c0 <= (others => (others => '0'));
        ELSIF (clk'EVENT AND clk = '1') THEN
            IF (prodXY_uid179_pT2_uid167_invPolyEval_cma_ena0 = '1') THEN
                prodXY_uid179_pT2_uid167_invPolyEval_cma_a0(0) <= RESIZE(UNSIGNED(redist10_yPE_uid52_fpDivTest_b_4_q),14);
                prodXY_uid179_pT2_uid167_invPolyEval_cma_c0(0) <= RESIZE(SIGNED(s1_uid165_invPolyEval_q),24);
            END IF;
        END IF;
    END PROCESS;
    prodXY_uid179_pT2_uid167_invPolyEval_cma_chainmultadd_output: PROCESS (clk, areset)
    BEGIN
        IF (areset = '1') THEN
            prodXY_uid179_pT2_uid167_invPolyEval_cma_s <= (others => (others => '0'));
        ELSIF (clk'EVENT AND clk = '1') THEN
            IF (prodXY_uid179_pT2_uid167_invPolyEval_cma_ena1 = '1') THEN
                prodXY_uid179_pT2_uid167_invPolyEval_cma_s(0) <= prodXY_uid179_pT2_uid167_invPolyEval_cma_y(0);
            END IF;
        END IF;
    END PROCESS;
    prodXY_uid179_pT2_uid167_invPolyEval_cma_delay : dspba_delay
    GENERIC MAP ( width => 38, depth => 0, reset_kind => "ASYNC" )
    PORT MAP ( xin => STD_LOGIC_VECTOR(prodXY_uid179_pT2_uid167_invPolyEval_cma_s(0)(37 downto 0)), xout => prodXY_uid179_pT2_uid167_invPolyEval_cma_qq, ena => en(0), clk => clk, aclr => areset );
    prodXY_uid179_pT2_uid167_invPolyEval_cma_q <= STD_LOGIC_VECTOR(prodXY_uid179_pT2_uid167_invPolyEval_cma_qq(37 downto 0));

    -- osig_uid180_pT2_uid167_invPolyEval(BITSELECT,179)@6
    osig_uid180_pT2_uid167_invPolyEval_b <= STD_LOGIC_VECTOR(prodXY_uid179_pT2_uid167_invPolyEval_cma_q(37 downto 13));

    -- highBBits_uid169_invPolyEval(BITSELECT,168)@6
    highBBits_uid169_invPolyEval_b <= STD_LOGIC_VECTOR(osig_uid180_pT2_uid167_invPolyEval_b(24 downto 2));

    -- redist12_yAddr_uid51_fpDivTest_b_4(DELAY,202)
    redist12_yAddr_uid51_fpDivTest_b_4 : dspba_delay
    GENERIC MAP ( width => 9, depth => 2, reset_kind => "ASYNC" )
    PORT MAP ( xin => redist11_yAddr_uid51_fpDivTest_b_2_q, xout => redist12_yAddr_uid51_fpDivTest_b_4_q, ena => en(0), clk => clk, aclr => areset );

    -- memoryC0_uid147_invTables_lutmem(DUALMEM,182)@4 + 2
    -- in j@20000000
    memoryC0_uid147_invTables_lutmem_aa <= redist12_yAddr_uid51_fpDivTest_b_4_q;
    memoryC0_uid147_invTables_lutmem_reset0 <= areset;
    memoryC0_uid147_invTables_lutmem_dmem : altera_syncram
    GENERIC MAP (
        ram_block_type => "M10K",
        operation_mode => "ROM",
        width_a => 12,
        widthad_a => 9,
        numwords_a => 512,
        lpm_type => "altera_syncram",
        width_byteena_a => 1,
        outdata_reg_a => "CLOCK0",
        outdata_aclr_a => "CLEAR0",
        clock_enable_input_a => "NORMAL",
        power_up_uninitialized => "FALSE",
        init_file => "FP_Function_Div_memoryC0_uid147_invTables_lutmem.hex",
        init_file_layout => "PORT_A",
        intended_device_family => "Cyclone V"
    )
    PORT MAP (
        clocken0 => en(0),
        aclr0 => memoryC0_uid147_invTables_lutmem_reset0,
        clock0 => clk,
        address_a => memoryC0_uid147_invTables_lutmem_aa,
        q_a => memoryC0_uid147_invTables_lutmem_ir
    );
    memoryC0_uid147_invTables_lutmem_r <= memoryC0_uid147_invTables_lutmem_ir(11 downto 0);

    -- memoryC0_uid146_invTables_lutmem(DUALMEM,181)@4 + 2
    -- in j@20000000
    memoryC0_uid146_invTables_lutmem_aa <= redist12_yAddr_uid51_fpDivTest_b_4_q;
    memoryC0_uid146_invTables_lutmem_reset0 <= areset;
    memoryC0_uid146_invTables_lutmem_dmem : altera_syncram
    GENERIC MAP (
        ram_block_type => "M10K",
        operation_mode => "ROM",
        width_a => 20,
        widthad_a => 9,
        numwords_a => 512,
        lpm_type => "altera_syncram",
        width_byteena_a => 1,
        outdata_reg_a => "CLOCK0",
        outdata_aclr_a => "CLEAR0",
        clock_enable_input_a => "NORMAL",
        power_up_uninitialized => "FALSE",
        init_file => "FP_Function_Div_memoryC0_uid146_invTables_lutmem.hex",
        init_file_layout => "PORT_A",
        intended_device_family => "Cyclone V"
    )
    PORT MAP (
        clocken0 => en(0),
        aclr0 => memoryC0_uid146_invTables_lutmem_reset0,
        clock0 => clk,
        address_a => memoryC0_uid146_invTables_lutmem_aa,
        q_a => memoryC0_uid146_invTables_lutmem_ir
    );
    memoryC0_uid146_invTables_lutmem_r <= memoryC0_uid146_invTables_lutmem_ir(19 downto 0);

    -- os_uid148_invTables(BITJOIN,147)@6
    os_uid148_invTables_q <= memoryC0_uid147_invTables_lutmem_r & memoryC0_uid146_invTables_lutmem_r;

    -- s2sumAHighB_uid170_invPolyEval(ADD,169)@6
    s2sumAHighB_uid170_invPolyEval_a <= STD_LOGIC_VECTOR(STD_LOGIC_VECTOR((32 downto 32 => os_uid148_invTables_q(31)) & os_uid148_invTables_q));
    s2sumAHighB_uid170_invPolyEval_b <= STD_LOGIC_VECTOR(STD_LOGIC_VECTOR((32 downto 23 => highBBits_uid169_invPolyEval_b(22)) & highBBits_uid169_invPolyEval_b));
    s2sumAHighB_uid170_invPolyEval_o <= STD_LOGIC_VECTOR(SIGNED(s2sumAHighB_uid170_invPolyEval_a) + SIGNED(s2sumAHighB_uid170_invPolyEval_b));
    s2sumAHighB_uid170_invPolyEval_q <= s2sumAHighB_uid170_invPolyEval_o(32 downto 0);

    -- lowRangeB_uid168_invPolyEval(BITSELECT,167)@6
    lowRangeB_uid168_invPolyEval_in <= osig_uid180_pT2_uid167_invPolyEval_b(1 downto 0);
    lowRangeB_uid168_invPolyEval_b <= lowRangeB_uid168_invPolyEval_in(1 downto 0);

    -- s2_uid171_invPolyEval(BITJOIN,170)@6
    s2_uid171_invPolyEval_q <= s2sumAHighB_uid170_invPolyEval_q & lowRangeB_uid168_invPolyEval_b;

    -- invY_uid54_fpDivTest(BITSELECT,53)@6
    invY_uid54_fpDivTest_in <= s2_uid171_invPolyEval_q(31 downto 0);
    invY_uid54_fpDivTest_b <= invY_uid54_fpDivTest_in(31 downto 5);

    -- prodXY_uid173_divValPreNorm_uid59_fpDivTest_cma(CHAINMULTADD,187)@6 + 2
    prodXY_uid173_divValPreNorm_uid59_fpDivTest_cma_reset <= areset;
    prodXY_uid173_divValPreNorm_uid59_fpDivTest_cma_ena0 <= en(0);
    prodXY_uid173_divValPreNorm_uid59_fpDivTest_cma_ena1 <= prodXY_uid173_divValPreNorm_uid59_fpDivTest_cma_ena0;
    prodXY_uid173_divValPreNorm_uid59_fpDivTest_cma_p(0) <= prodXY_uid173_divValPreNorm_uid59_fpDivTest_cma_a0(0) * prodXY_uid173_divValPreNorm_uid59_fpDivTest_cma_c0(0);
    prodXY_uid173_divValPreNorm_uid59_fpDivTest_cma_u(0) <= RESIZE(prodXY_uid173_divValPreNorm_uid59_fpDivTest_cma_p(0),51);
    prodXY_uid173_divValPreNorm_uid59_fpDivTest_cma_w(0) <= prodXY_uid173_divValPreNorm_uid59_fpDivTest_cma_u(0);
    prodXY_uid173_divValPreNorm_uid59_fpDivTest_cma_x(0) <= prodXY_uid173_divValPreNorm_uid59_fpDivTest_cma_w(0);
    prodXY_uid173_divValPreNorm_uid59_fpDivTest_cma_y(0) <= prodXY_uid173_divValPreNorm_uid59_fpDivTest_cma_x(0);
    prodXY_uid173_divValPreNorm_uid59_fpDivTest_cma_chainmultadd_input: PROCESS (clk, areset)
    BEGIN
        IF (areset = '1') THEN
            prodXY_uid173_divValPreNorm_uid59_fpDivTest_cma_a0 <= (others => (others => '0'));
            prodXY_uid173_divValPreNorm_uid59_fpDivTest_cma_c0 <= (others => (others => '0'));
        ELSIF (clk'EVENT AND clk = '1') THEN
            IF (prodXY_uid173_divValPreNorm_uid59_fpDivTest_cma_ena0 = '1') THEN
                prodXY_uid173_divValPreNorm_uid59_fpDivTest_cma_a0(0) <= RESIZE(UNSIGNED(invY_uid54_fpDivTest_b),27);
                prodXY_uid173_divValPreNorm_uid59_fpDivTest_cma_c0(0) <= RESIZE(UNSIGNED(lOAdded_uid57_fpDivTest_q),24);
            END IF;
        END IF;
    END PROCESS;
    prodXY_uid173_divValPreNorm_uid59_fpDivTest_cma_chainmultadd_output: PROCESS (clk, areset)
    BEGIN
        IF (areset = '1') THEN
            prodXY_uid173_divValPreNorm_uid59_fpDivTest_cma_s <= (others => (others => '0'));
        ELSIF (clk'EVENT AND clk = '1') THEN
            IF (prodXY_uid173_divValPreNorm_uid59_fpDivTest_cma_ena1 = '1') THEN
                prodXY_uid173_divValPreNorm_uid59_fpDivTest_cma_s(0) <= prodXY_uid173_divValPreNorm_uid59_fpDivTest_cma_y(0);
            END IF;
        END IF;
    END PROCESS;
    prodXY_uid173_divValPreNorm_uid59_fpDivTest_cma_delay : dspba_delay
    GENERIC MAP ( width => 51, depth => 0, reset_kind => "ASYNC" )
    PORT MAP ( xin => STD_LOGIC_VECTOR(prodXY_uid173_divValPreNorm_uid59_fpDivTest_cma_s(0)(50 downto 0)), xout => prodXY_uid173_divValPreNorm_uid59_fpDivTest_cma_qq, ena => en(0), clk => clk, aclr => areset );
    prodXY_uid173_divValPreNorm_uid59_fpDivTest_cma_q <= STD_LOGIC_VECTOR(prodXY_uid173_divValPreNorm_uid59_fpDivTest_cma_qq(50 downto 0));

    -- osig_uid174_divValPreNorm_uid59_fpDivTest(BITSELECT,173)@8
    osig_uid174_divValPreNorm_uid59_fpDivTest_b <= prodXY_uid173_divValPreNorm_uid59_fpDivTest_cma_q(50 downto 23);

    -- updatedY_uid16_fpDivTest(BITJOIN,15)@8
    updatedY_uid16_fpDivTest_q <= GND_q & paddingY_uid15_fpDivTest_q;

    -- fracYZero_uid15_fpDivTest(LOGICAL,16)@8
    fracYZero_uid15_fpDivTest_a <= STD_LOGIC_VECTOR("0" & redist14_fracY_uid13_fpDivTest_b_8_mem_q);
    fracYZero_uid15_fpDivTest_q <= "1" WHEN fracYZero_uid15_fpDivTest_a = updatedY_uid16_fpDivTest_q ELSE "0";

    -- divValPreNormYPow2Exc_uid63_fpDivTest(MUX,62)@8
    divValPreNormYPow2Exc_uid63_fpDivTest_s <= fracYZero_uid15_fpDivTest_q;
    divValPreNormYPow2Exc_uid63_fpDivTest_combproc: PROCESS (divValPreNormYPow2Exc_uid63_fpDivTest_s, en, osig_uid174_divValPreNorm_uid59_fpDivTest_b, oFracXZ4_uid61_fpDivTest_q)
    BEGIN
        CASE (divValPreNormYPow2Exc_uid63_fpDivTest_s) IS
            WHEN "0" => divValPreNormYPow2Exc_uid63_fpDivTest_q <= osig_uid174_divValPreNorm_uid59_fpDivTest_b;
            WHEN "1" => divValPreNormYPow2Exc_uid63_fpDivTest_q <= oFracXZ4_uid61_fpDivTest_q;
            WHEN OTHERS => divValPreNormYPow2Exc_uid63_fpDivTest_q <= (others => '0');
        END CASE;
    END PROCESS;

    -- norm_uid64_fpDivTest(BITSELECT,63)@8
    norm_uid64_fpDivTest_b <= STD_LOGIC_VECTOR(divValPreNormYPow2Exc_uid63_fpDivTest_q(27 downto 27));

    -- zeroPaddingInAddition_uid74_fpDivTest(CONSTANT,73)
    zeroPaddingInAddition_uid74_fpDivTest_q <= "000000000000000000000000";

    -- expFracPostRnd_uid75_fpDivTest(BITJOIN,74)@8
    expFracPostRnd_uid75_fpDivTest_q <= norm_uid64_fpDivTest_b & zeroPaddingInAddition_uid74_fpDivTest_q & VCC_q;

    -- cstBiasM1_uid6_fpDivTest(CONSTANT,5)
    cstBiasM1_uid6_fpDivTest_q <= "01111110";

    -- expXmY_uid47_fpDivTest(SUB,46)@8
    expXmY_uid47_fpDivTest_a <= STD_LOGIC_VECTOR("0" & redist20_expX_uid9_fpDivTest_b_8_mem_q);
    expXmY_uid47_fpDivTest_b <= STD_LOGIC_VECTOR("0" & redist15_expY_uid12_fpDivTest_b_8_mem_q);
    expXmY_uid47_fpDivTest_o <= STD_LOGIC_VECTOR(UNSIGNED(expXmY_uid47_fpDivTest_a) - UNSIGNED(expXmY_uid47_fpDivTest_b));
    expXmY_uid47_fpDivTest_q <= expXmY_uid47_fpDivTest_o(8 downto 0);

    -- expR_uid48_fpDivTest(ADD,47)@8
    expR_uid48_fpDivTest_a <= STD_LOGIC_VECTOR(STD_LOGIC_VECTOR((10 downto 9 => expXmY_uid47_fpDivTest_q(8)) & expXmY_uid47_fpDivTest_q));
    expR_uid48_fpDivTest_b <= STD_LOGIC_VECTOR(STD_LOGIC_VECTOR("000" & cstBiasM1_uid6_fpDivTest_q));
    expR_uid48_fpDivTest_o <= STD_LOGIC_VECTOR(SIGNED(expR_uid48_fpDivTest_a) + SIGNED(expR_uid48_fpDivTest_b));
    expR_uid48_fpDivTest_q <= expR_uid48_fpDivTest_o(9 downto 0);

    -- divValPreNormHigh_uid65_fpDivTest(BITSELECT,64)@8
    divValPreNormHigh_uid65_fpDivTest_in <= divValPreNormYPow2Exc_uid63_fpDivTest_q(26 downto 0);
    divValPreNormHigh_uid65_fpDivTest_b <= divValPreNormHigh_uid65_fpDivTest_in(26 downto 2);

    -- divValPreNormLow_uid66_fpDivTest(BITSELECT,65)@8
    divValPreNormLow_uid66_fpDivTest_in <= divValPreNormYPow2Exc_uid63_fpDivTest_q(25 downto 0);
    divValPreNormLow_uid66_fpDivTest_b <= divValPreNormLow_uid66_fpDivTest_in(25 downto 1);

    -- normFracRnd_uid67_fpDivTest(MUX,66)@8
    normFracRnd_uid67_fpDivTest_s <= norm_uid64_fpDivTest_b;
    normFracRnd_uid67_fpDivTest_combproc: PROCESS (normFracRnd_uid67_fpDivTest_s, en, divValPreNormLow_uid66_fpDivTest_b, divValPreNormHigh_uid65_fpDivTest_b)
    BEGIN
        CASE (normFracRnd_uid67_fpDivTest_s) IS
            WHEN "0" => normFracRnd_uid67_fpDivTest_q <= divValPreNormLow_uid66_fpDivTest_b;
            WHEN "1" => normFracRnd_uid67_fpDivTest_q <= divValPreNormHigh_uid65_fpDivTest_b;
            WHEN OTHERS => normFracRnd_uid67_fpDivTest_q <= (others => '0');
        END CASE;
    END PROCESS;

    -- expFracRnd_uid68_fpDivTest(BITJOIN,67)@8
    expFracRnd_uid68_fpDivTest_q <= expR_uid48_fpDivTest_q & normFracRnd_uid67_fpDivTest_q;

    -- expFracPostRnd_uid76_fpDivTest(ADD,75)@8
    expFracPostRnd_uid76_fpDivTest_a <= STD_LOGIC_VECTOR(STD_LOGIC_VECTOR((36 downto 35 => expFracRnd_uid68_fpDivTest_q(34)) & expFracRnd_uid68_fpDivTest_q));
    expFracPostRnd_uid76_fpDivTest_b <= STD_LOGIC_VECTOR(STD_LOGIC_VECTOR("00000000000" & expFracPostRnd_uid75_fpDivTest_q));
    expFracPostRnd_uid76_fpDivTest_o <= STD_LOGIC_VECTOR(SIGNED(expFracPostRnd_uid76_fpDivTest_a) + SIGNED(expFracPostRnd_uid76_fpDivTest_b));
    expFracPostRnd_uid76_fpDivTest_q <= expFracPostRnd_uid76_fpDivTest_o(35 downto 0);

    -- fracPostRndF_uid79_fpDivTest(BITSELECT,78)@8
    fracPostRndF_uid79_fpDivTest_in <= expFracPostRnd_uid76_fpDivTest_q(24 downto 0);
    fracPostRndF_uid79_fpDivTest_b <= fracPostRndF_uid79_fpDivTest_in(24 downto 1);

    -- invYO_uid55_fpDivTest(BITSELECT,54)@6
    invYO_uid55_fpDivTest_in <= STD_LOGIC_VECTOR(s2_uid171_invPolyEval_q(32 downto 0));
    invYO_uid55_fpDivTest_b <= STD_LOGIC_VECTOR(invYO_uid55_fpDivTest_in(32 downto 32));

    -- redist7_invYO_uid55_fpDivTest_b_2(DELAY,197)
    redist7_invYO_uid55_fpDivTest_b_2 : dspba_delay
    GENERIC MAP ( width => 1, depth => 2, reset_kind => "ASYNC" )
    PORT MAP ( xin => invYO_uid55_fpDivTest_b, xout => redist7_invYO_uid55_fpDivTest_b_2_q, ena => en(0), clk => clk, aclr => areset );

    -- fracPostRndF_uid80_fpDivTest(MUX,79)@8
    fracPostRndF_uid80_fpDivTest_s <= redist7_invYO_uid55_fpDivTest_b_2_q;
    fracPostRndF_uid80_fpDivTest_combproc: PROCESS (fracPostRndF_uid80_fpDivTest_s, en, fracPostRndF_uid79_fpDivTest_b, fracXExt_uid77_fpDivTest_q)
    BEGIN
        CASE (fracPostRndF_uid80_fpDivTest_s) IS
            WHEN "0" => fracPostRndF_uid80_fpDivTest_q <= fracPostRndF_uid79_fpDivTest_b;
            WHEN "1" => fracPostRndF_uid80_fpDivTest_q <= fracXExt_uid77_fpDivTest_q;
            WHEN OTHERS => fracPostRndF_uid80_fpDivTest_q <= (others => '0');
        END CASE;
    END PROCESS;

    -- redist5_fracPostRndF_uid80_fpDivTest_q_2(DELAY,195)
    redist5_fracPostRndF_uid80_fpDivTest_q_2 : dspba_delay
    GENERIC MAP ( width => 24, depth => 2, reset_kind => "ASYNC" )
    PORT MAP ( xin => fracPostRndF_uid80_fpDivTest_q, xout => redist5_fracPostRndF_uid80_fpDivTest_q_2_q, ena => en(0), clk => clk, aclr => areset );

    -- fracPostRndFT_uid104_fpDivTest(BITSELECT,103)@10
    fracPostRndFT_uid104_fpDivTest_b <= redist5_fracPostRndF_uid80_fpDivTest_q_2_q(23 downto 1);

    -- redist2_fracPostRndFT_uid104_fpDivTest_b_1(DELAY,192)
    redist2_fracPostRndFT_uid104_fpDivTest_b_1 : dspba_delay
    GENERIC MAP ( width => 23, depth => 1, reset_kind => "ASYNC" )
    PORT MAP ( xin => fracPostRndFT_uid104_fpDivTest_b, xout => redist2_fracPostRndFT_uid104_fpDivTest_b_1_q, ena => en(0), clk => clk, aclr => areset );

    -- fracRPreExcExt_uid105_fpDivTest(ADD,104)@11
    fracRPreExcExt_uid105_fpDivTest_a <= STD_LOGIC_VECTOR("0" & redist2_fracPostRndFT_uid104_fpDivTest_b_1_q);
    fracRPreExcExt_uid105_fpDivTest_b <= STD_LOGIC_VECTOR("00000000000000000000000" & extraUlp_uid103_fpDivTest_q);
    fracRPreExcExt_uid105_fpDivTest_o <= STD_LOGIC_VECTOR(UNSIGNED(fracRPreExcExt_uid105_fpDivTest_a) + UNSIGNED(fracRPreExcExt_uid105_fpDivTest_b));
    fracRPreExcExt_uid105_fpDivTest_q <= fracRPreExcExt_uid105_fpDivTest_o(23 downto 0);

    -- ovfIncRnd_uid109_fpDivTest(BITSELECT,108)@11
    ovfIncRnd_uid109_fpDivTest_b <= STD_LOGIC_VECTOR(fracRPreExcExt_uid105_fpDivTest_q(23 downto 23));

    -- expFracPostRndInc_uid110_fpDivTest(ADD,109)@11
    expFracPostRndInc_uid110_fpDivTest_a <= STD_LOGIC_VECTOR("0" & redist4_expPostRndFR_uid81_fpDivTest_b_3_q);
    expFracPostRndInc_uid110_fpDivTest_b <= STD_LOGIC_VECTOR("00000000" & ovfIncRnd_uid109_fpDivTest_b);
    expFracPostRndInc_uid110_fpDivTest_o <= STD_LOGIC_VECTOR(UNSIGNED(expFracPostRndInc_uid110_fpDivTest_a) + UNSIGNED(expFracPostRndInc_uid110_fpDivTest_b));
    expFracPostRndInc_uid110_fpDivTest_q <= expFracPostRndInc_uid110_fpDivTest_o(8 downto 0);

    -- expFracPostRndR_uid111_fpDivTest(BITSELECT,110)@11
    expFracPostRndR_uid111_fpDivTest_in <= expFracPostRndInc_uid110_fpDivTest_q(7 downto 0);
    expFracPostRndR_uid111_fpDivTest_b <= expFracPostRndR_uid111_fpDivTest_in(7 downto 0);

    -- expPostRndFR_uid81_fpDivTest(BITSELECT,80)@8
    expPostRndFR_uid81_fpDivTest_in <= expFracPostRnd_uid76_fpDivTest_q(32 downto 0);
    expPostRndFR_uid81_fpDivTest_b <= expPostRndFR_uid81_fpDivTest_in(32 downto 25);

    -- redist3_expPostRndFR_uid81_fpDivTest_b_2(DELAY,193)
    redist3_expPostRndFR_uid81_fpDivTest_b_2 : dspba_delay
    GENERIC MAP ( width => 8, depth => 2, reset_kind => "ASYNC" )
    PORT MAP ( xin => expPostRndFR_uid81_fpDivTest_b, xout => redist3_expPostRndFR_uid81_fpDivTest_b_2_q, ena => en(0), clk => clk, aclr => areset );

    -- redist4_expPostRndFR_uid81_fpDivTest_b_3(DELAY,194)
    redist4_expPostRndFR_uid81_fpDivTest_b_3 : dspba_delay
    GENERIC MAP ( width => 8, depth => 1, reset_kind => "ASYNC" )
    PORT MAP ( xin => redist3_expPostRndFR_uid81_fpDivTest_b_2_q, xout => redist4_expPostRndFR_uid81_fpDivTest_b_3_q, ena => en(0), clk => clk, aclr => areset );

    -- betweenFPwF_uid102_fpDivTest(BITSELECT,101)@10
    betweenFPwF_uid102_fpDivTest_in <= STD_LOGIC_VECTOR(redist5_fracPostRndF_uid80_fpDivTest_q_2_q(0 downto 0));
    betweenFPwF_uid102_fpDivTest_b <= STD_LOGIC_VECTOR(betweenFPwF_uid102_fpDivTest_in(0 downto 0));

    -- redist21_expX_uid9_fpDivTest_b_10(DELAY,211)
    redist21_expX_uid9_fpDivTest_b_10 : dspba_delay
    GENERIC MAP ( width => 8, depth => 2, reset_kind => "ASYNC" )
    PORT MAP ( xin => redist20_expX_uid9_fpDivTest_b_8_mem_q, xout => redist21_expX_uid9_fpDivTest_b_10_q, ena => en(0), clk => clk, aclr => areset );

    -- redist19_fracX_uid10_fpDivTest_b_10(DELAY,209)
    redist19_fracX_uid10_fpDivTest_b_10 : dspba_delay
    GENERIC MAP ( width => 23, depth => 2, reset_kind => "ASYNC" )
    PORT MAP ( xin => redist18_fracX_uid10_fpDivTest_b_8_q, xout => redist19_fracX_uid10_fpDivTest_b_10_q, ena => en(0), clk => clk, aclr => areset );

    -- qDivProdLTX_opB_uid100_fpDivTest(BITJOIN,99)@10
    qDivProdLTX_opB_uid100_fpDivTest_q <= redist21_expX_uid9_fpDivTest_b_10_q & redist19_fracX_uid10_fpDivTest_b_10_q;

    -- lOAdded_uid87_fpDivTest(BITJOIN,86)@8
    lOAdded_uid87_fpDivTest_q <= VCC_q & redist14_fracY_uid13_fpDivTest_b_8_mem_q;

    -- lOAdded_uid84_fpDivTest(BITJOIN,83)@8
    lOAdded_uid84_fpDivTest_q <= VCC_q & fracPostRndF_uid80_fpDivTest_q;

    -- qDivProd_uid89_fpDivTest_cma(CHAINMULTADD,186)@8 + 2
    qDivProd_uid89_fpDivTest_cma_reset <= areset;
    qDivProd_uid89_fpDivTest_cma_ena0 <= en(0);
    qDivProd_uid89_fpDivTest_cma_ena1 <= qDivProd_uid89_fpDivTest_cma_ena0;
    qDivProd_uid89_fpDivTest_cma_p(0) <= qDivProd_uid89_fpDivTest_cma_a0(0) * qDivProd_uid89_fpDivTest_cma_c0(0);
    qDivProd_uid89_fpDivTest_cma_u(0) <= RESIZE(qDivProd_uid89_fpDivTest_cma_p(0),49);
    qDivProd_uid89_fpDivTest_cma_w(0) <= qDivProd_uid89_fpDivTest_cma_u(0);
    qDivProd_uid89_fpDivTest_cma_x(0) <= qDivProd_uid89_fpDivTest_cma_w(0);
    qDivProd_uid89_fpDivTest_cma_y(0) <= qDivProd_uid89_fpDivTest_cma_x(0);
    qDivProd_uid89_fpDivTest_cma_chainmultadd_input: PROCESS (clk, areset)
    BEGIN
        IF (areset = '1') THEN
            qDivProd_uid89_fpDivTest_cma_a0 <= (others => (others => '0'));
            qDivProd_uid89_fpDivTest_cma_c0 <= (others => (others => '0'));
        ELSIF (clk'EVENT AND clk = '1') THEN
            IF (qDivProd_uid89_fpDivTest_cma_ena0 = '1') THEN
                qDivProd_uid89_fpDivTest_cma_a0(0) <= RESIZE(UNSIGNED(lOAdded_uid84_fpDivTest_q),25);
                qDivProd_uid89_fpDivTest_cma_c0(0) <= RESIZE(UNSIGNED(lOAdded_uid87_fpDivTest_q),24);
            END IF;
        END IF;
    END PROCESS;
    qDivProd_uid89_fpDivTest_cma_chainmultadd_output: PROCESS (clk, areset)
    BEGIN
        IF (areset = '1') THEN
            qDivProd_uid89_fpDivTest_cma_s <= (others => (others => '0'));
        ELSIF (clk'EVENT AND clk = '1') THEN
            IF (qDivProd_uid89_fpDivTest_cma_ena1 = '1') THEN
                qDivProd_uid89_fpDivTest_cma_s(0) <= qDivProd_uid89_fpDivTest_cma_y(0);
            END IF;
        END IF;
    END PROCESS;
    qDivProd_uid89_fpDivTest_cma_delay : dspba_delay
    GENERIC MAP ( width => 49, depth => 0, reset_kind => "ASYNC" )
    PORT MAP ( xin => STD_LOGIC_VECTOR(qDivProd_uid89_fpDivTest_cma_s(0)(48 downto 0)), xout => qDivProd_uid89_fpDivTest_cma_qq, ena => en(0), clk => clk, aclr => areset );
    qDivProd_uid89_fpDivTest_cma_q <= STD_LOGIC_VECTOR(qDivProd_uid89_fpDivTest_cma_qq(48 downto 0));

    -- qDivProdNorm_uid90_fpDivTest(BITSELECT,89)@10
    qDivProdNorm_uid90_fpDivTest_b <= STD_LOGIC_VECTOR(qDivProd_uid89_fpDivTest_cma_q(48 downto 48));

    -- cstBias_uid7_fpDivTest(CONSTANT,6)
    cstBias_uid7_fpDivTest_q <= "01111111";

    -- qDivProdExp_opBs_uid95_fpDivTest(SUB,94)@10
    qDivProdExp_opBs_uid95_fpDivTest_a <= STD_LOGIC_VECTOR("0" & cstBias_uid7_fpDivTest_q);
    qDivProdExp_opBs_uid95_fpDivTest_b <= STD_LOGIC_VECTOR("00000000" & qDivProdNorm_uid90_fpDivTest_b);
    qDivProdExp_opBs_uid95_fpDivTest_o <= STD_LOGIC_VECTOR(UNSIGNED(qDivProdExp_opBs_uid95_fpDivTest_a) - UNSIGNED(qDivProdExp_opBs_uid95_fpDivTest_b));
    qDivProdExp_opBs_uid95_fpDivTest_q <= qDivProdExp_opBs_uid95_fpDivTest_o(8 downto 0);

    -- redist8_invYO_uid55_fpDivTest_b_4(DELAY,198)
    redist8_invYO_uid55_fpDivTest_b_4 : dspba_delay
    GENERIC MAP ( width => 1, depth => 2, reset_kind => "ASYNC" )
    PORT MAP ( xin => redist7_invYO_uid55_fpDivTest_b_2_q, xout => redist8_invYO_uid55_fpDivTest_b_4_q, ena => en(0), clk => clk, aclr => areset );

    -- expPostRndF_uid82_fpDivTest(MUX,81)@10
    expPostRndF_uid82_fpDivTest_s <= redist8_invYO_uid55_fpDivTest_b_4_q;
    expPostRndF_uid82_fpDivTest_combproc: PROCESS (expPostRndF_uid82_fpDivTest_s, en, redist3_expPostRndFR_uid81_fpDivTest_b_2_q, redist21_expX_uid9_fpDivTest_b_10_q)
    BEGIN
        CASE (expPostRndF_uid82_fpDivTest_s) IS
            WHEN "0" => expPostRndF_uid82_fpDivTest_q <= redist3_expPostRndFR_uid81_fpDivTest_b_2_q;
            WHEN "1" => expPostRndF_uid82_fpDivTest_q <= redist21_expX_uid9_fpDivTest_b_10_q;
            WHEN OTHERS => expPostRndF_uid82_fpDivTest_q <= (others => '0');
        END CASE;
    END PROCESS;

    -- redist16_expY_uid12_fpDivTest_b_10(DELAY,206)
    redist16_expY_uid12_fpDivTest_b_10 : dspba_delay
    GENERIC MAP ( width => 8, depth => 2, reset_kind => "ASYNC" )
    PORT MAP ( xin => redist15_expY_uid12_fpDivTest_b_8_mem_q, xout => redist16_expY_uid12_fpDivTest_b_10_q, ena => en(0), clk => clk, aclr => areset );

    -- qDivProdExp_opA_uid94_fpDivTest(ADD,93)@10
    qDivProdExp_opA_uid94_fpDivTest_a <= STD_LOGIC_VECTOR("0" & redist16_expY_uid12_fpDivTest_b_10_q);
    qDivProdExp_opA_uid94_fpDivTest_b <= STD_LOGIC_VECTOR("0" & expPostRndF_uid82_fpDivTest_q);
    qDivProdExp_opA_uid94_fpDivTest_o <= STD_LOGIC_VECTOR(UNSIGNED(qDivProdExp_opA_uid94_fpDivTest_a) + UNSIGNED(qDivProdExp_opA_uid94_fpDivTest_b));
    qDivProdExp_opA_uid94_fpDivTest_q <= qDivProdExp_opA_uid94_fpDivTest_o(8 downto 0);

    -- qDivProdExp_uid96_fpDivTest(SUB,95)@10
    qDivProdExp_uid96_fpDivTest_a <= STD_LOGIC_VECTOR(STD_LOGIC_VECTOR("000" & qDivProdExp_opA_uid94_fpDivTest_q));
    qDivProdExp_uid96_fpDivTest_b <= STD_LOGIC_VECTOR(STD_LOGIC_VECTOR((11 downto 9 => qDivProdExp_opBs_uid95_fpDivTest_q(8)) & qDivProdExp_opBs_uid95_fpDivTest_q));
    qDivProdExp_uid96_fpDivTest_o <= STD_LOGIC_VECTOR(SIGNED(qDivProdExp_uid96_fpDivTest_a) - SIGNED(qDivProdExp_uid96_fpDivTest_b));
    qDivProdExp_uid96_fpDivTest_q <= qDivProdExp_uid96_fpDivTest_o(10 downto 0);

    -- qDivProdLTX_opA_uid98_fpDivTest(BITSELECT,97)@10
    qDivProdLTX_opA_uid98_fpDivTest_in <= qDivProdExp_uid96_fpDivTest_q(7 downto 0);
    qDivProdLTX_opA_uid98_fpDivTest_b <= qDivProdLTX_opA_uid98_fpDivTest_in(7 downto 0);

    -- qDivProdFracHigh_uid91_fpDivTest(BITSELECT,90)@10
    qDivProdFracHigh_uid91_fpDivTest_in <= qDivProd_uid89_fpDivTest_cma_q(47 downto 0);
    qDivProdFracHigh_uid91_fpDivTest_b <= qDivProdFracHigh_uid91_fpDivTest_in(47 downto 24);

    -- qDivProdFracLow_uid92_fpDivTest(BITSELECT,91)@10
    qDivProdFracLow_uid92_fpDivTest_in <= qDivProd_uid89_fpDivTest_cma_q(46 downto 0);
    qDivProdFracLow_uid92_fpDivTest_b <= qDivProdFracLow_uid92_fpDivTest_in(46 downto 23);

    -- qDivProdFrac_uid93_fpDivTest(MUX,92)@10
    qDivProdFrac_uid93_fpDivTest_s <= qDivProdNorm_uid90_fpDivTest_b;
    qDivProdFrac_uid93_fpDivTest_combproc: PROCESS (qDivProdFrac_uid93_fpDivTest_s, en, qDivProdFracLow_uid92_fpDivTest_b, qDivProdFracHigh_uid91_fpDivTest_b)
    BEGIN
        CASE (qDivProdFrac_uid93_fpDivTest_s) IS
            WHEN "0" => qDivProdFrac_uid93_fpDivTest_q <= qDivProdFracLow_uid92_fpDivTest_b;
            WHEN "1" => qDivProdFrac_uid93_fpDivTest_q <= qDivProdFracHigh_uid91_fpDivTest_b;
            WHEN OTHERS => qDivProdFrac_uid93_fpDivTest_q <= (others => '0');
        END CASE;
    END PROCESS;

    -- qDivProdFracWF_uid97_fpDivTest(BITSELECT,96)@10
    qDivProdFracWF_uid97_fpDivTest_b <= qDivProdFrac_uid93_fpDivTest_q(23 downto 1);

    -- qDivProdLTX_opA_uid99_fpDivTest(BITJOIN,98)@10
    qDivProdLTX_opA_uid99_fpDivTest_q <= qDivProdLTX_opA_uid98_fpDivTest_b & qDivProdFracWF_uid97_fpDivTest_b;

    -- qDividerProdLTX_uid101_fpDivTest(COMPARE,100)@10
    qDividerProdLTX_uid101_fpDivTest_a <= STD_LOGIC_VECTOR("00" & qDivProdLTX_opA_uid99_fpDivTest_q);
    qDividerProdLTX_uid101_fpDivTest_b <= STD_LOGIC_VECTOR("00" & qDivProdLTX_opB_uid100_fpDivTest_q);
    qDividerProdLTX_uid101_fpDivTest_o <= STD_LOGIC_VECTOR(UNSIGNED(qDividerProdLTX_uid101_fpDivTest_a) - UNSIGNED(qDividerProdLTX_uid101_fpDivTest_b));
    qDividerProdLTX_uid101_fpDivTest_c(0) <= qDividerProdLTX_uid101_fpDivTest_o(32);

    -- extraUlp_uid103_fpDivTest(LOGICAL,102)@10 + 1
    extraUlp_uid103_fpDivTest_qi <= qDividerProdLTX_uid101_fpDivTest_c and betweenFPwF_uid102_fpDivTest_b;
    extraUlp_uid103_fpDivTest_delay : dspba_delay
    GENERIC MAP ( width => 1, depth => 1, reset_kind => "ASYNC" )
    PORT MAP ( xin => extraUlp_uid103_fpDivTest_qi, xout => extraUlp_uid103_fpDivTest_q, ena => en(0), clk => clk, aclr => areset );

    -- expRPreExc_uid112_fpDivTest(MUX,111)@11
    expRPreExc_uid112_fpDivTest_s <= extraUlp_uid103_fpDivTest_q;
    expRPreExc_uid112_fpDivTest_combproc: PROCESS (expRPreExc_uid112_fpDivTest_s, en, redist4_expPostRndFR_uid81_fpDivTest_b_3_q, expFracPostRndR_uid111_fpDivTest_b)
    BEGIN
        CASE (expRPreExc_uid112_fpDivTest_s) IS
            WHEN "0" => expRPreExc_uid112_fpDivTest_q <= redist4_expPostRndFR_uid81_fpDivTest_b_3_q;
            WHEN "1" => expRPreExc_uid112_fpDivTest_q <= expFracPostRndR_uid111_fpDivTest_b;
            WHEN OTHERS => expRPreExc_uid112_fpDivTest_q <= (others => '0');
        END CASE;
    END PROCESS;

    -- invExpXIsMax_uid43_fpDivTest(LOGICAL,42)@8
    invExpXIsMax_uid43_fpDivTest_q <= not (expXIsMax_uid38_fpDivTest_q);

    -- InvExpXIsZero_uid44_fpDivTest(LOGICAL,43)@8
    InvExpXIsZero_uid44_fpDivTest_q <= not (excZ_y_uid37_fpDivTest_q);

    -- excR_y_uid45_fpDivTest(LOGICAL,44)@8
    excR_y_uid45_fpDivTest_q <= InvExpXIsZero_uid44_fpDivTest_q and invExpXIsMax_uid43_fpDivTest_q;

    -- excXIYR_uid127_fpDivTest(LOGICAL,126)@8
    excXIYR_uid127_fpDivTest_q <= excI_x_uid27_fpDivTest_q and excR_y_uid45_fpDivTest_q;

    -- excXIYZ_uid126_fpDivTest(LOGICAL,125)@8
    excXIYZ_uid126_fpDivTest_q <= excI_x_uid27_fpDivTest_q and excZ_y_uid37_fpDivTest_q;

    -- expRExt_uid114_fpDivTest(BITSELECT,113)@8
    expRExt_uid114_fpDivTest_b <= STD_LOGIC_VECTOR(expFracPostRnd_uid76_fpDivTest_q(35 downto 25));

    -- expOvf_uid118_fpDivTest(COMPARE,117)@8
    expOvf_uid118_fpDivTest_a <= STD_LOGIC_VECTOR(STD_LOGIC_VECTOR((12 downto 11 => expRExt_uid114_fpDivTest_b(10)) & expRExt_uid114_fpDivTest_b));
    expOvf_uid118_fpDivTest_b <= STD_LOGIC_VECTOR(STD_LOGIC_VECTOR("00000" & cstAllOWE_uid18_fpDivTest_q));
    expOvf_uid118_fpDivTest_o <= STD_LOGIC_VECTOR(SIGNED(expOvf_uid118_fpDivTest_a) - SIGNED(expOvf_uid118_fpDivTest_b));
    expOvf_uid118_fpDivTest_n(0) <= not (expOvf_uid118_fpDivTest_o(12));

    -- invExpXIsMax_uid29_fpDivTest(LOGICAL,28)@8
    invExpXIsMax_uid29_fpDivTest_q <= not (expXIsMax_uid24_fpDivTest_q);

    -- InvExpXIsZero_uid30_fpDivTest(LOGICAL,29)@8
    InvExpXIsZero_uid30_fpDivTest_q <= not (excZ_x_uid23_fpDivTest_q);

    -- excR_x_uid31_fpDivTest(LOGICAL,30)@8
    excR_x_uid31_fpDivTest_q <= InvExpXIsZero_uid30_fpDivTest_q and invExpXIsMax_uid29_fpDivTest_q;

    -- excXRYROvf_uid125_fpDivTest(LOGICAL,124)@8
    excXRYROvf_uid125_fpDivTest_q <= excR_x_uid31_fpDivTest_q and excR_y_uid45_fpDivTest_q and expOvf_uid118_fpDivTest_n;

    -- excXRYZ_uid124_fpDivTest(LOGICAL,123)@8
    excXRYZ_uid124_fpDivTest_q <= excR_x_uid31_fpDivTest_q and excZ_y_uid37_fpDivTest_q;

    -- excRInf_uid128_fpDivTest(LOGICAL,127)@8
    excRInf_uid128_fpDivTest_q <= excXRYZ_uid124_fpDivTest_q or excXRYROvf_uid125_fpDivTest_q or excXIYZ_uid126_fpDivTest_q or excXIYR_uid127_fpDivTest_q;

    -- xRegOrZero_uid121_fpDivTest(LOGICAL,120)@8
    xRegOrZero_uid121_fpDivTest_q <= excR_x_uid31_fpDivTest_q or excZ_x_uid23_fpDivTest_q;

    -- regOrZeroOverInf_uid122_fpDivTest(LOGICAL,121)@8
    regOrZeroOverInf_uid122_fpDivTest_q <= xRegOrZero_uid121_fpDivTest_q and excI_y_uid41_fpDivTest_q;

    -- expUdf_uid115_fpDivTest(COMPARE,114)@8
    expUdf_uid115_fpDivTest_a <= STD_LOGIC_VECTOR(STD_LOGIC_VECTOR("000000000000" & GND_q));
    expUdf_uid115_fpDivTest_b <= STD_LOGIC_VECTOR(STD_LOGIC_VECTOR((12 downto 11 => expRExt_uid114_fpDivTest_b(10)) & expRExt_uid114_fpDivTest_b));
    expUdf_uid115_fpDivTest_o <= STD_LOGIC_VECTOR(SIGNED(expUdf_uid115_fpDivTest_a) - SIGNED(expUdf_uid115_fpDivTest_b));
    expUdf_uid115_fpDivTest_n(0) <= not (expUdf_uid115_fpDivTest_o(12));

    -- regOverRegWithUf_uid120_fpDivTest(LOGICAL,119)@8
    regOverRegWithUf_uid120_fpDivTest_q <= expUdf_uid115_fpDivTest_n and excR_x_uid31_fpDivTest_q and excR_y_uid45_fpDivTest_q;

    -- zeroOverReg_uid119_fpDivTest(LOGICAL,118)@8
    zeroOverReg_uid119_fpDivTest_q <= excZ_x_uid23_fpDivTest_q and excR_y_uid45_fpDivTest_q;

    -- excRZero_uid123_fpDivTest(LOGICAL,122)@8
    excRZero_uid123_fpDivTest_q <= zeroOverReg_uid119_fpDivTest_q or regOverRegWithUf_uid120_fpDivTest_q or regOrZeroOverInf_uid122_fpDivTest_q;

    -- concExc_uid132_fpDivTest(BITJOIN,131)@8
    concExc_uid132_fpDivTest_q <= excRNaN_uid131_fpDivTest_q & excRInf_uid128_fpDivTest_q & excRZero_uid123_fpDivTest_q;

    -- excREnc_uid133_fpDivTest(LOOKUP,132)@8 + 1
    excREnc_uid133_fpDivTest_clkproc: PROCESS (clk, areset)
    BEGIN
        IF (areset = '1') THEN
            excREnc_uid133_fpDivTest_q <= "01";
        ELSIF (clk'EVENT AND clk = '1') THEN
            IF (en = "1") THEN
                CASE (concExc_uid132_fpDivTest_q) IS
                    WHEN "000" => excREnc_uid133_fpDivTest_q <= "01";
                    WHEN "001" => excREnc_uid133_fpDivTest_q <= "00";
                    WHEN "010" => excREnc_uid133_fpDivTest_q <= "10";
                    WHEN "011" => excREnc_uid133_fpDivTest_q <= "00";
                    WHEN "100" => excREnc_uid133_fpDivTest_q <= "11";
                    WHEN "101" => excREnc_uid133_fpDivTest_q <= "00";
                    WHEN "110" => excREnc_uid133_fpDivTest_q <= "00";
                    WHEN "111" => excREnc_uid133_fpDivTest_q <= "00";
                    WHEN OTHERS => -- unreachable
                                   excREnc_uid133_fpDivTest_q <= (others => '-');
                END CASE;
            END IF;
        END IF;
    END PROCESS;

    -- redist1_excREnc_uid133_fpDivTest_q_3(DELAY,191)
    redist1_excREnc_uid133_fpDivTest_q_3 : dspba_delay
    GENERIC MAP ( width => 2, depth => 2, reset_kind => "ASYNC" )
    PORT MAP ( xin => excREnc_uid133_fpDivTest_q, xout => redist1_excREnc_uid133_fpDivTest_q_3_q, ena => en(0), clk => clk, aclr => areset );

    -- expRPostExc_uid141_fpDivTest(MUX,140)@11
    expRPostExc_uid141_fpDivTest_s <= redist1_excREnc_uid133_fpDivTest_q_3_q;
    expRPostExc_uid141_fpDivTest_combproc: PROCESS (expRPostExc_uid141_fpDivTest_s, en, cstAllZWE_uid20_fpDivTest_q, expRPreExc_uid112_fpDivTest_q, cstAllOWE_uid18_fpDivTest_q)
    BEGIN
        CASE (expRPostExc_uid141_fpDivTest_s) IS
            WHEN "00" => expRPostExc_uid141_fpDivTest_q <= cstAllZWE_uid20_fpDivTest_q;
            WHEN "01" => expRPostExc_uid141_fpDivTest_q <= expRPreExc_uid112_fpDivTest_q;
            WHEN "10" => expRPostExc_uid141_fpDivTest_q <= cstAllOWE_uid18_fpDivTest_q;
            WHEN "11" => expRPostExc_uid141_fpDivTest_q <= cstAllOWE_uid18_fpDivTest_q;
            WHEN OTHERS => expRPostExc_uid141_fpDivTest_q <= (others => '0');
        END CASE;
    END PROCESS;

    -- oneFracRPostExc2_uid134_fpDivTest(CONSTANT,133)
    oneFracRPostExc2_uid134_fpDivTest_q <= "00000000000000000000001";

    -- fracPostRndFPostUlp_uid106_fpDivTest(BITSELECT,105)@11
    fracPostRndFPostUlp_uid106_fpDivTest_in <= fracRPreExcExt_uid105_fpDivTest_q(22 downto 0);
    fracPostRndFPostUlp_uid106_fpDivTest_b <= fracPostRndFPostUlp_uid106_fpDivTest_in(22 downto 0);

    -- fracRPreExc_uid107_fpDivTest(MUX,106)@11
    fracRPreExc_uid107_fpDivTest_s <= extraUlp_uid103_fpDivTest_q;
    fracRPreExc_uid107_fpDivTest_combproc: PROCESS (fracRPreExc_uid107_fpDivTest_s, en, redist2_fracPostRndFT_uid104_fpDivTest_b_1_q, fracPostRndFPostUlp_uid106_fpDivTest_b)
    BEGIN
        CASE (fracRPreExc_uid107_fpDivTest_s) IS
            WHEN "0" => fracRPreExc_uid107_fpDivTest_q <= redist2_fracPostRndFT_uid104_fpDivTest_b_1_q;
            WHEN "1" => fracRPreExc_uid107_fpDivTest_q <= fracPostRndFPostUlp_uid106_fpDivTest_b;
            WHEN OTHERS => fracRPreExc_uid107_fpDivTest_q <= (others => '0');
        END CASE;
    END PROCESS;

    -- fracRPostExc_uid137_fpDivTest(MUX,136)@11
    fracRPostExc_uid137_fpDivTest_s <= redist1_excREnc_uid133_fpDivTest_q_3_q;
    fracRPostExc_uid137_fpDivTest_combproc: PROCESS (fracRPostExc_uid137_fpDivTest_s, en, paddingY_uid15_fpDivTest_q, fracRPreExc_uid107_fpDivTest_q, oneFracRPostExc2_uid134_fpDivTest_q)
    BEGIN
        CASE (fracRPostExc_uid137_fpDivTest_s) IS
            WHEN "00" => fracRPostExc_uid137_fpDivTest_q <= paddingY_uid15_fpDivTest_q;
            WHEN "01" => fracRPostExc_uid137_fpDivTest_q <= fracRPreExc_uid107_fpDivTest_q;
            WHEN "10" => fracRPostExc_uid137_fpDivTest_q <= paddingY_uid15_fpDivTest_q;
            WHEN "11" => fracRPostExc_uid137_fpDivTest_q <= oneFracRPostExc2_uid134_fpDivTest_q;
            WHEN OTHERS => fracRPostExc_uid137_fpDivTest_q <= (others => '0');
        END CASE;
    END PROCESS;

    -- divR_uid144_fpDivTest(BITJOIN,143)@11
    divR_uid144_fpDivTest_q <= redist0_sRPostExc_uid143_fpDivTest_q_3_q & expRPostExc_uid141_fpDivTest_q & fracRPostExc_uid137_fpDivTest_q;

    -- xOut(GPOUT,4)@11
    q <= divR_uid144_fpDivTest_q;

END normal;
