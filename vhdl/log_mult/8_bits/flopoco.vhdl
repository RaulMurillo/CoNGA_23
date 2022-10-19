--------------------------------------------------------------------------------
--                        Normalizer_ZO_6_6_6_F0_uid6
-- VHDL generated for Kintex7 @ 0MHz
-- This operator is part of the Infinite Virtual Library FloPoCoLib
-- All rights reserved 
-- Authors: Florent de Dinechin, (2007-2020)
--------------------------------------------------------------------------------
-- combinatorial
-- Clock period (ns): inf
-- Target frequency (MHz): 0
-- Input signals: X OZb
-- Output signals: Count R

library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;
library std;
use std.textio.all;
library work;

entity Normalizer_ZO_6_6_6_F0_uid6 is
    port (X : in  std_logic_vector(5 downto 0);
          OZb : in  std_logic;
          Count : out  std_logic_vector(2 downto 0);
          R : out  std_logic_vector(5 downto 0)   );
end entity;

architecture arch of Normalizer_ZO_6_6_6_F0_uid6 is
signal level3 :  std_logic_vector(5 downto 0);
signal sozb :  std_logic;
signal count2 :  std_logic;
signal level2 :  std_logic_vector(5 downto 0);
signal count1 :  std_logic;
signal level1 :  std_logic_vector(5 downto 0);
signal count0 :  std_logic;
signal level0 :  std_logic_vector(5 downto 0);
signal sCount :  std_logic_vector(2 downto 0);
begin
   level3 <= X ;
   sozb<= OZb;
   count2<= '1' when level3(5 downto 2) = (5 downto 2=>sozb) else '0';
   level2<= level3(5 downto 0) when count2='0' else level3(1 downto 0) & (3 downto 0 => '0');

   count1<= '1' when level2(5 downto 4) = (5 downto 4=>sozb) else '0';
   level1<= level2(5 downto 0) when count1='0' else level2(3 downto 0) & (1 downto 0 => '0');

   count0<= '1' when level1(5 downto 5) = (5 downto 5=>sozb) else '0';
   level0<= level1(5 downto 0) when count0='0' else level1(4 downto 0) & (0 downto 0 => '0');

   R <= level0;
   sCount <= count2 & count1 & count0;
   Count <= sCount;
end architecture;

--------------------------------------------------------------------------------
--                          PositDecoder_8_2_F0_uid4
-- VHDL generated for Kintex7 @ 0MHz
-- This operator is part of the Infinite Virtual Library FloPoCoLib
-- All rights reserved 
-- Authors: Raul Murillo (2021-2022)
--------------------------------------------------------------------------------
-- combinatorial
-- Clock period (ns): inf
-- Target frequency (MHz): 0
-- Input signals: X
-- Output signals: Sign SF Frac Zero Inf Abs_in

library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;
library std;
use std.textio.all;
library work;

entity PositDecoder_8_2_F0_uid4 is
    port (X : in  std_logic_vector(7 downto 0);
          Sign : out  std_logic;
          SF : out  std_logic_vector(5 downto 0);
          Frac : out  std_logic_vector(2 downto 0);
          Zero : out  std_logic;
          Inf : out  std_logic;
          Abs_in : out  std_logic_vector(6 downto 0)   );
end entity;

architecture arch of PositDecoder_8_2_F0_uid4 is
   component Normalizer_ZO_6_6_6_F0_uid6 is
      port ( X : in  std_logic_vector(5 downto 0);
             OZb : in  std_logic;
             Count : out  std_logic_vector(2 downto 0);
             R : out  std_logic_vector(5 downto 0)   );
   end component;

signal s :  std_logic;
signal remainP :  std_logic_vector(6 downto 0);
signal special :  std_logic;
signal is_zero :  std_logic;
signal is_NAR :  std_logic;
signal v_sign :  std_logic_vector(6 downto 0);
signal p_abs :  std_logic_vector(6 downto 0);
signal rc :  std_logic;
signal regPosit :  std_logic_vector(5 downto 0);
signal regLength :  std_logic_vector(2 downto 0);
signal shiftedPosit :  std_logic_vector(5 downto 0);
signal k :  std_logic_vector(3 downto 0);
signal pSF :  std_logic_vector(5 downto 0);
signal pFrac :  std_logic_vector(2 downto 0);
begin
--------------------------- Start of vhdl generation ---------------------------
--------------------------- Sign bit & special cases ---------------------------
   s <= X(7);
   remainP <= X(6 downto 0);
   special <= '1' when (remainP = "0000000") else '0';
   is_zero <= not(s) AND special;
   is_NAR<= s AND special;
----------------------- Get absolute value of the Posit -----------------------
   v_sign <= (others => s);
   p_abs <= (v_sign XOR remainP) + s;
-------------- Count leading zeros/ones of regime & shift it out --------------
   rc <= p_abs(p_abs'high);
   regPosit <= p_abs(5 downto 0);
   RegimeCounter: Normalizer_ZO_6_6_6_F0_uid6
      port map ( OZb => rc,
                 X => regPosit,
                 Count => regLength,
                 R => shiftedPosit);
----------------- Determine the scaling factor - regime & exp -----------------
   k <= 
      "0" & regLength when rc = '1' else
      "1" & NOT(regLength);
   pSF <= k & shiftedPosit(4 downto 3);
------------------------------- Extract fraction -------------------------------
   pFrac <= shiftedPosit(2 downto 0);
   -- Prepare outputs
   Sign <= s;
   SF <= pSF;
   Frac <= pFrac;
   Zero <= is_zero;
   Inf <= is_NAR;
   Abs_in <= p_abs;
---------------------------- End of vhdl generation ----------------------------
end architecture;

--------------------------------------------------------------------------------
--                        Normalizer_ZO_6_6_6_F0_uid10
-- VHDL generated for Kintex7 @ 0MHz
-- This operator is part of the Infinite Virtual Library FloPoCoLib
-- All rights reserved 
-- Authors: Florent de Dinechin, (2007-2020)
--------------------------------------------------------------------------------
-- combinatorial
-- Clock period (ns): inf
-- Target frequency (MHz): 0
-- Input signals: X OZb
-- Output signals: Count R

library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;
library std;
use std.textio.all;
library work;

entity Normalizer_ZO_6_6_6_F0_uid10 is
    port (X : in  std_logic_vector(5 downto 0);
          OZb : in  std_logic;
          Count : out  std_logic_vector(2 downto 0);
          R : out  std_logic_vector(5 downto 0)   );
end entity;

architecture arch of Normalizer_ZO_6_6_6_F0_uid10 is
signal level3 :  std_logic_vector(5 downto 0);
signal sozb :  std_logic;
signal count2 :  std_logic;
signal level2 :  std_logic_vector(5 downto 0);
signal count1 :  std_logic;
signal level1 :  std_logic_vector(5 downto 0);
signal count0 :  std_logic;
signal level0 :  std_logic_vector(5 downto 0);
signal sCount :  std_logic_vector(2 downto 0);
begin
   level3 <= X ;
   sozb<= OZb;
   count2<= '1' when level3(5 downto 2) = (5 downto 2=>sozb) else '0';
   level2<= level3(5 downto 0) when count2='0' else level3(1 downto 0) & (3 downto 0 => '0');

   count1<= '1' when level2(5 downto 4) = (5 downto 4=>sozb) else '0';
   level1<= level2(5 downto 0) when count1='0' else level2(3 downto 0) & (1 downto 0 => '0');

   count0<= '1' when level1(5 downto 5) = (5 downto 5=>sozb) else '0';
   level0<= level1(5 downto 0) when count0='0' else level1(4 downto 0) & (0 downto 0 => '0');

   R <= level0;
   sCount <= count2 & count1 & count0;
   Count <= sCount;
end architecture;

--------------------------------------------------------------------------------
--                          PositDecoder_8_2_F0_uid8
-- VHDL generated for Kintex7 @ 0MHz
-- This operator is part of the Infinite Virtual Library FloPoCoLib
-- All rights reserved 
-- Authors: Raul Murillo (2021-2022)
--------------------------------------------------------------------------------
-- combinatorial
-- Clock period (ns): inf
-- Target frequency (MHz): 0
-- Input signals: X
-- Output signals: Sign SF Frac Zero Inf Abs_in

library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;
library std;
use std.textio.all;
library work;

entity PositDecoder_8_2_F0_uid8 is
    port (X : in  std_logic_vector(7 downto 0);
          Sign : out  std_logic;
          SF : out  std_logic_vector(5 downto 0);
          Frac : out  std_logic_vector(2 downto 0);
          Zero : out  std_logic;
          Inf : out  std_logic;
          Abs_in : out  std_logic_vector(6 downto 0)   );
end entity;

architecture arch of PositDecoder_8_2_F0_uid8 is
   component Normalizer_ZO_6_6_6_F0_uid10 is
      port ( X : in  std_logic_vector(5 downto 0);
             OZb : in  std_logic;
             Count : out  std_logic_vector(2 downto 0);
             R : out  std_logic_vector(5 downto 0)   );
   end component;

signal s :  std_logic;
signal remainP :  std_logic_vector(6 downto 0);
signal special :  std_logic;
signal is_zero :  std_logic;
signal is_NAR :  std_logic;
signal v_sign :  std_logic_vector(6 downto 0);
signal p_abs :  std_logic_vector(6 downto 0);
signal rc :  std_logic;
signal regPosit :  std_logic_vector(5 downto 0);
signal regLength :  std_logic_vector(2 downto 0);
signal shiftedPosit :  std_logic_vector(5 downto 0);
signal k :  std_logic_vector(3 downto 0);
signal pSF :  std_logic_vector(5 downto 0);
signal pFrac :  std_logic_vector(2 downto 0);
begin
--------------------------- Start of vhdl generation ---------------------------
--------------------------- Sign bit & special cases ---------------------------
   s <= X(7);
   remainP <= X(6 downto 0);
   special <= '1' when (remainP = "0000000") else '0';
   is_zero <= not(s) AND special;
   is_NAR<= s AND special;
----------------------- Get absolute value of the Posit -----------------------
   v_sign <= (others => s);
   p_abs <= (v_sign XOR remainP) + s;
-------------- Count leading zeros/ones of regime & shift it out --------------
   rc <= p_abs(p_abs'high);
   regPosit <= p_abs(5 downto 0);
   RegimeCounter: Normalizer_ZO_6_6_6_F0_uid10
      port map ( OZb => rc,
                 X => regPosit,
                 Count => regLength,
                 R => shiftedPosit);
----------------- Determine the scaling factor - regime & exp -----------------
   k <= 
      "0" & regLength when rc = '1' else
      "1" & NOT(regLength);
   pSF <= k & shiftedPosit(4 downto 3);
------------------------------- Extract fraction -------------------------------
   pFrac <= shiftedPosit(2 downto 0);
   -- Prepare outputs
   Sign <= s;
   SF <= pSF;
   Frac <= pFrac;
   Zero <= is_zero;
   Inf <= is_NAR;
   Abs_in <= p_abs;
---------------------------- End of vhdl generation ----------------------------
end architecture;

--------------------------------------------------------------------------------
--                   RightShifterSticky8_by_max_6_F0_uid14
-- VHDL generated for Kintex7 @ 0MHz
-- This operator is part of the Infinite Virtual Library FloPoCoLib
-- All rights reserved 
-- Authors: Bogdan Pasca (2008-2011), Florent de Dinechin (2008-2019)
--------------------------------------------------------------------------------
-- combinatorial
-- Clock period (ns): inf
-- Target frequency (MHz): 0
-- Input signals: X S padBit
-- Output signals: R Sticky

library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;
library std;
use std.textio.all;
library work;

entity RightShifterSticky8_by_max_6_F0_uid14 is
    port (X : in  std_logic_vector(7 downto 0);
          S : in  std_logic_vector(2 downto 0);
          padBit : in  std_logic;
          R : out  std_logic_vector(7 downto 0);
          Sticky : out  std_logic   );
end entity;

architecture arch of RightShifterSticky8_by_max_6_F0_uid14 is
signal ps :  std_logic_vector(2 downto 0);
signal Xpadded :  std_logic_vector(7 downto 0);
signal level3 :  std_logic_vector(7 downto 0);
signal stk2 :  std_logic;
signal level2 :  std_logic_vector(7 downto 0);
signal stk1 :  std_logic;
signal level1 :  std_logic_vector(7 downto 0);
signal stk0 :  std_logic;
signal level0 :  std_logic_vector(7 downto 0);
begin
   ps<= S;
   Xpadded <= X;
   level3<= Xpadded;
   stk2 <= '1' when (level3(3 downto 0)/="0000" and ps(2)='1')   else '0';
   level2 <=  level3 when  ps(2)='0'    else (3 downto 0 => padBit) & level3(7 downto 4);
   stk1 <= '1' when (level2(1 downto 0)/="00" and ps(1)='1') or stk2 ='1'   else '0';
   level1 <=  level2 when  ps(1)='0'    else (1 downto 0 => padBit) & level2(7 downto 2);
   stk0 <= '1' when (level1(0 downto 0)/="0" and ps(0)='1') or stk1 ='1'   else '0';
   level0 <=  level1 when  ps(0)='0'    else (0 downto 0 => padBit) & level1(7 downto 1);
   R <= level0;
   Sticky <= stk0;
end architecture;

--------------------------------------------------------------------------------
--                         PositEncoder_8_2_F0_uid12
-- VHDL generated for Kintex7 @ 0MHz
-- This operator is part of the Infinite Virtual Library FloPoCoLib
-- All rights reserved 
-- Authors: Raul Murillo (2021-2022)
--------------------------------------------------------------------------------
-- combinatorial
-- Clock period (ns): inf
-- Target frequency (MHz): 0
-- Input signals: Sign SF Frac Round Sticky Zero Inf
-- Output signals: R

library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;
library std;
use std.textio.all;
library work;

entity PositEncoder_8_2_F0_uid12 is
    port (Sign : in  std_logic;
          SF : in  std_logic_vector(6 downto 0);
          Frac : in  std_logic_vector(2 downto 0);
          Round : in  std_logic;
          Sticky : in  std_logic;
          Zero : in  std_logic;
          Inf : in  std_logic;
          R : out  std_logic_vector(7 downto 0)   );
end entity;

architecture arch of PositEncoder_8_2_F0_uid12 is
   component RightShifterSticky8_by_max_6_F0_uid14 is
      port ( X : in  std_logic_vector(7 downto 0);
             S : in  std_logic_vector(2 downto 0);
             padBit : in  std_logic;
             R : out  std_logic_vector(7 downto 0);
             Sticky : out  std_logic   );
   end component;

signal e :  std_logic_vector(1 downto 0);
signal k :  std_logic_vector(3 downto 0);
signal rc :  std_logic;
signal v_rc :  std_logic_vector(3 downto 0);
signal offset_tmp :  std_logic_vector(3 downto 0);
signal reg_ovf :  std_logic;
signal pad :  std_logic;
signal input_shifter :  std_logic_vector(7 downto 0);
signal shift_offset :  std_logic_vector(2 downto 0);
signal shifted_posit :  std_logic_vector(7 downto 0);
signal stkBit :  std_logic;
signal lsb :  std_logic;
signal rnd :  std_logic;
signal stk :  std_logic;
signal round_r :  std_logic;
signal rounded_p :  std_logic_vector(6 downto 0);
signal vSign :  std_logic_vector(6 downto 0);
signal final_p :  std_logic_vector(6 downto 0);
signal result :  std_logic_vector(7 downto 0);
begin
--------------------------- Start of vhdl generation ---------------------------
----------------------------- Get value of regime -----------------------------
   e <= SF(1 downto 0);
   k <= SF(5 downto 2);
   rc <= SF(6);
   v_rc <= (others => rc) ;
   offset_tmp <= k XOR v_rc;
   -- Check for regime overflow
   reg_ovf <= '1' when (offset_tmp >= 6) else '0';
-------------- Generate regime - shift out exponent and fraction --------------
   pad <= not rc;
   input_shifter <= pad & rc & e & Frac & Round;
   shift_offset <= "110" when reg_ovf = '1' else offset_tmp(2 downto 0);
   RegimeGenerator: RightShifterSticky8_by_max_6_F0_uid14
      port map ( S => shift_offset,
                 X => input_shifter,
                 padBit => pad,
                 R => shifted_posit,
                 Sticky => stkBit);
---------------------------- Round to nearest even ----------------------------
   lsb <= shifted_posit(1);
   rnd <= shifted_posit(0);
   stk <= stkBit OR Sticky;
   round_r <= rnd AND (lsb OR stk OR reg_ovf);
   rounded_p <= shifted_posit(7 downto 1) + round_r;
-------------------------- Check sign & Special cases --------------------------
   -- Two's complement if posit is negative
   vSign <= (others => Sign);
   final_p <= (vSign XOR rounded_p) + Sign;
   result <= (7 => Inf, others => '0')  when (Zero OR Inf) = '1' else (Sign & final_p);
   R <= result;
---------------------------- End of vhdl generation ----------------------------
end architecture;

--------------------------------------------------------------------------------
--                                PositLogMult
--                           (PositLAM_8_2_F0_uid2)
-- VHDL generated for Kintex7 @ 0MHz
-- This operator is part of the Infinite Virtual Library FloPoCoLib
-- All rights reserved 
-- Authors: Raul Murillo (2021-2022)
--------------------------------------------------------------------------------
-- combinatorial
-- Clock period (ns): inf
-- Target frequency (MHz): 0
-- Input signals: X Y
-- Output signals: R

-- Version: 2022.10.10 - 190639
library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;
library std;
use std.textio.all;
library work;

entity PositLogMult is
    port (X : in  std_logic_vector(7 downto 0);
          Y : in  std_logic_vector(7 downto 0);
          R : out  std_logic_vector(7 downto 0)   );
end entity;

architecture arch of PositLogMult is
   component PositDecoder_8_2_F0_uid4 is
      port ( X : in  std_logic_vector(7 downto 0);
             Sign : out  std_logic;
             SF : out  std_logic_vector(5 downto 0);
             Frac : out  std_logic_vector(2 downto 0);
             Zero : out  std_logic;
             Inf : out  std_logic;
             Abs_in : out  std_logic_vector(6 downto 0)   );
   end component;

   component PositDecoder_8_2_F0_uid8 is
      port ( X : in  std_logic_vector(7 downto 0);
             Sign : out  std_logic;
             SF : out  std_logic_vector(5 downto 0);
             Frac : out  std_logic_vector(2 downto 0);
             Zero : out  std_logic;
             Inf : out  std_logic;
             Abs_in : out  std_logic_vector(6 downto 0)   );
   end component;

   component PositEncoder_8_2_F0_uid12 is
      port ( Sign : in  std_logic;
             SF : in  std_logic_vector(6 downto 0);
             Frac : in  std_logic_vector(2 downto 0);
             Round : in  std_logic;
             Sticky : in  std_logic;
             Zero : in  std_logic;
             Inf : in  std_logic;
             R : out  std_logic_vector(7 downto 0)   );
   end component;

signal sign_X :  std_logic;
signal sf_X :  std_logic_vector(5 downto 0);
signal f_X :  std_logic_vector(2 downto 0);
signal z_X :  std_logic;
signal inf_X :  std_logic;
signal sign_Y :  std_logic;
signal sf_Y :  std_logic_vector(5 downto 0);
signal f_Y :  std_logic_vector(2 downto 0);
signal z_Y :  std_logic;
signal inf_Y :  std_logic;
signal op_X :  std_logic_vector(8 downto 0);
signal op_Y :  std_logic_vector(8 downto 0);
signal sign :  std_logic;
signal zero :  std_logic;
signal inf :  std_logic;
signal add_r :  std_logic_vector(9 downto 0);
signal sf :  std_logic_vector(6 downto 0);
signal frac :  std_logic_vector(2 downto 0);
signal rnd :  std_logic;
signal stk :  std_logic;
begin
--------------------------- Start of vhdl generation ---------------------------
---------------------------- Decode X & Y operands ----------------------------
   X_decoder: PositDecoder_8_2_F0_uid4
      port map ( X => X,
                 Abs_in => open,
                 Frac => f_X,
                 Inf => inf_X,
                 SF => sf_X,
                 Sign => sign_X,
                 Zero => z_X);
   Y_decoder: PositDecoder_8_2_F0_uid8
      port map ( X => Y,
                 Abs_in => open,
                 Frac => f_Y,
                 Inf => inf_Y,
                 SF => sf_Y,
                 Sign => sign_Y,
                 Zero => z_Y);
   -- Gather operands
   op_X <= sf_X & f_X;
   op_Y <= sf_Y & f_Y;
---------------------- Sign and Special cases computation ----------------------
   sign <= sign_X XOR sign_Y;
   zero <= z_X OR z_Y;
   inf <= inf_X OR inf_Y;
-------------------- Add exponents & fractions all together --------------------
   add_r <= (op_X(op_X'high) & op_X) + (op_Y(op_Y'high) & op_Y);
   sf <= add_r(9 downto 3);
   frac <= add_r(2 downto 0);
-------------------------------- Data Encoding --------------------------------
   rnd <= '0';
   stk <= '0';
   R_encoding: PositEncoder_8_2_F0_uid12
      port map ( Frac => frac,
                 Inf => inf,
                 Round => rnd,
                 SF => sf,
                 Sign => sign,
                 Sticky => stk,
                 Zero => zero,
                 R => R);
---------------------------- End of vhdl generation ----------------------------
end architecture;

