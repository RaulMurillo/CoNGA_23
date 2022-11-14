--------------------------------------------------------------------------------
--                       Normalizer_ZO_62_62_62_F0_uid6
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

entity Normalizer_ZO_62_62_62_F0_uid6 is
    port (X : in  std_logic_vector(61 downto 0);
          OZb : in  std_logic;
          Count : out  std_logic_vector(5 downto 0);
          R : out  std_logic_vector(61 downto 0)   );
end entity;

architecture arch of Normalizer_ZO_62_62_62_F0_uid6 is
signal level6 :  std_logic_vector(61 downto 0);
signal sozb :  std_logic;
signal count5 :  std_logic;
signal level5 :  std_logic_vector(61 downto 0);
signal count4 :  std_logic;
signal level4 :  std_logic_vector(61 downto 0);
signal count3 :  std_logic;
signal level3 :  std_logic_vector(61 downto 0);
signal count2 :  std_logic;
signal level2 :  std_logic_vector(61 downto 0);
signal count1 :  std_logic;
signal level1 :  std_logic_vector(61 downto 0);
signal count0 :  std_logic;
signal level0 :  std_logic_vector(61 downto 0);
signal sCount :  std_logic_vector(5 downto 0);
begin
   level6 <= X ;
   sozb<= OZb;
   count5<= '1' when level6(61 downto 30) = (61 downto 30=>sozb) else '0';
   level5<= level6(61 downto 0) when count5='0' else level6(29 downto 0) & (31 downto 0 => '0');

   count4<= '1' when level5(61 downto 46) = (61 downto 46=>sozb) else '0';
   level4<= level5(61 downto 0) when count4='0' else level5(45 downto 0) & (15 downto 0 => '0');

   count3<= '1' when level4(61 downto 54) = (61 downto 54=>sozb) else '0';
   level3<= level4(61 downto 0) when count3='0' else level4(53 downto 0) & (7 downto 0 => '0');

   count2<= '1' when level3(61 downto 58) = (61 downto 58=>sozb) else '0';
   level2<= level3(61 downto 0) when count2='0' else level3(57 downto 0) & (3 downto 0 => '0');

   count1<= '1' when level2(61 downto 60) = (61 downto 60=>sozb) else '0';
   level1<= level2(61 downto 0) when count1='0' else level2(59 downto 0) & (1 downto 0 => '0');

   count0<= '1' when level1(61 downto 61) = (61 downto 61=>sozb) else '0';
   level0<= level1(61 downto 0) when count0='0' else level1(60 downto 0) & (0 downto 0 => '0');

   R <= level0;
   sCount <= count5 & count4 & count3 & count2 & count1 & count0;
   Count <= sCount;
end architecture;

--------------------------------------------------------------------------------
--                       PositFastDecoder_64_2_F0_uid4
-- Version: 2022.11.14 - 133718
-- VHDL generated for Kintex7 @ 0MHz
-- This operator is part of the Infinite Virtual Library FloPoCoLib
-- All rights reserved 
-- Authors: Raul Murillo (2021-2022)
--------------------------------------------------------------------------------
-- combinatorial
-- Clock period (ns): inf
-- Target frequency (MHz): 0
-- Input signals: X
-- Output signals: Sign SF Frac NZN

library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;
library std;
use std.textio.all;
library work;

entity PositFastDecoder_64_2_F0_uid4 is
    port (X : in  std_logic_vector(63 downto 0);
          Sign : out  std_logic;
          SF : out  std_logic_vector(8 downto 0);
          Frac : out  std_logic_vector(58 downto 0);
          NZN : out  std_logic   );
end entity;

architecture arch of PositFastDecoder_64_2_F0_uid4 is
   component Normalizer_ZO_62_62_62_F0_uid6 is
      port ( X : in  std_logic_vector(61 downto 0);
             OZb : in  std_logic;
             Count : out  std_logic_vector(5 downto 0);
             R : out  std_logic_vector(61 downto 0)   );
   end component;

signal sgn :  std_logic;
signal pNZN :  std_logic;
signal rc :  std_logic;
signal regPosit :  std_logic_vector(61 downto 0);
signal regLength :  std_logic_vector(5 downto 0);
signal shiftedPosit :  std_logic_vector(61 downto 0);
signal k :  std_logic_vector(6 downto 0);
signal sgnVect :  std_logic_vector(1 downto 0);
signal exp :  std_logic_vector(1 downto 0);
signal pSF :  std_logic_vector(8 downto 0);
signal pFrac :  std_logic_vector(58 downto 0);
begin
--------------------------- Start of vhdl generation ---------------------------
--------------------------- Sign bit & special cases ---------------------------
   sgn <= X(63);
   pNZN <= '0' when (X(62 downto 0) = "000000000000000000000000000000000000000000000000000000000000000") else '1';
-------------- Count leading zeros/ones of regime & shift it out --------------
   rc <= X(62);
   regPosit <= X(61 downto 0);
   RegimeCounter: Normalizer_ZO_62_62_62_F0_uid6
      port map ( OZb => rc,
                 X => regPosit,
                 Count => regLength,
                 R => shiftedPosit);
----------------- Determine the scaling factor - regime & exp -----------------
   k <= "0" & regLength when rc /= sgn else "1" & NOT(regLength);
   sgnVect <= (others => sgn);
   exp <= shiftedPosit(60 downto 59) XOR sgnVect;
   pSF <= k & exp;
------------------------------- Extract fraction -------------------------------
   pFrac <= shiftedPosit(58 downto 0);
   Sign <= sgn;
   SF <= pSF;
   Frac <= pFrac;
   NZN <= pNZN;
---------------------------- End of vhdl generation ----------------------------
end architecture;

--------------------------------------------------------------------------------
--                            IntAdder_63_F0_uid8
-- VHDL generated for Kintex7 @ 0MHz
-- This operator is part of the Infinite Virtual Library FloPoCoLib
-- All rights reserved 
-- Authors: Bogdan Pasca, Florent de Dinechin (2008-2016)
--------------------------------------------------------------------------------
-- combinatorial
-- Clock period (ns): inf
-- Target frequency (MHz): 0
-- Input signals: X Y Cin
-- Output signals: R

library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;
library std;
use std.textio.all;
library work;

entity IntAdder_63_F0_uid8 is
    port (X : in  std_logic_vector(62 downto 0);
          Y : in  std_logic_vector(62 downto 0);
          Cin : in  std_logic;
          R : out  std_logic_vector(62 downto 0)   );
end entity;

architecture arch of IntAdder_63_F0_uid8 is
signal Rtmp :  std_logic_vector(62 downto 0);
begin
   Rtmp <= X + Y + Cin;
   R <= Rtmp;
end architecture;

--------------------------------------------------------------------------------
--                            IntAdder_63_F0_uid10
-- VHDL generated for Kintex7 @ 0MHz
-- This operator is part of the Infinite Virtual Library FloPoCoLib
-- All rights reserved 
-- Authors: Bogdan Pasca, Florent de Dinechin (2008-2016)
--------------------------------------------------------------------------------
-- combinatorial
-- Clock period (ns): inf
-- Target frequency (MHz): 0
-- Input signals: X Y Cin
-- Output signals: R

library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;
library std;
use std.textio.all;
library work;

entity IntAdder_63_F0_uid10 is
    port (X : in  std_logic_vector(62 downto 0);
          Y : in  std_logic_vector(62 downto 0);
          Cin : in  std_logic;
          R : out  std_logic_vector(62 downto 0)   );
end entity;

architecture arch of IntAdder_63_F0_uid10 is
signal Rtmp :  std_logic_vector(62 downto 0);
begin
   Rtmp <= X + Y + Cin;
   R <= Rtmp;
end architecture;

--------------------------------------------------------------------------------
--                            IntAdder_63_F0_uid12
-- VHDL generated for Kintex7 @ 0MHz
-- This operator is part of the Infinite Virtual Library FloPoCoLib
-- All rights reserved 
-- Authors: Bogdan Pasca, Florent de Dinechin (2008-2016)
--------------------------------------------------------------------------------
-- combinatorial
-- Clock period (ns): inf
-- Target frequency (MHz): 0
-- Input signals: X Y Cin
-- Output signals: R

library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;
library std;
use std.textio.all;
library work;

entity IntAdder_63_F0_uid12 is
    port (X : in  std_logic_vector(62 downto 0);
          Y : in  std_logic_vector(62 downto 0);
          Cin : in  std_logic;
          R : out  std_logic_vector(62 downto 0)   );
end entity;

architecture arch of IntAdder_63_F0_uid12 is
signal Rtmp :  std_logic_vector(62 downto 0);
begin
   Rtmp <= X + Y + Cin;
   R <= Rtmp;
end architecture;

--------------------------------------------------------------------------------
--                            IntAdder_63_F0_uid14
-- VHDL generated for Kintex7 @ 0MHz
-- This operator is part of the Infinite Virtual Library FloPoCoLib
-- All rights reserved 
-- Authors: Bogdan Pasca, Florent de Dinechin (2008-2016)
--------------------------------------------------------------------------------
-- combinatorial
-- Clock period (ns): inf
-- Target frequency (MHz): 0
-- Input signals: X Y Cin
-- Output signals: R

library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;
library std;
use std.textio.all;
library work;

entity IntAdder_63_F0_uid14 is
    port (X : in  std_logic_vector(62 downto 0);
          Y : in  std_logic_vector(62 downto 0);
          Cin : in  std_logic;
          R : out  std_logic_vector(62 downto 0)   );
end entity;

architecture arch of IntAdder_63_F0_uid14 is
signal Rtmp :  std_logic_vector(62 downto 0);
begin
   Rtmp <= X + Y + Cin;
   R <= Rtmp;
end architecture;

--------------------------------------------------------------------------------
--                            IntAdder_63_F0_uid16
-- VHDL generated for Kintex7 @ 0MHz
-- This operator is part of the Infinite Virtual Library FloPoCoLib
-- All rights reserved 
-- Authors: Bogdan Pasca, Florent de Dinechin (2008-2016)
--------------------------------------------------------------------------------
-- combinatorial
-- Clock period (ns): inf
-- Target frequency (MHz): 0
-- Input signals: X Y Cin
-- Output signals: R

library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;
library std;
use std.textio.all;
library work;

entity IntAdder_63_F0_uid16 is
    port (X : in  std_logic_vector(62 downto 0);
          Y : in  std_logic_vector(62 downto 0);
          Cin : in  std_logic;
          R : out  std_logic_vector(62 downto 0)   );
end entity;

architecture arch of IntAdder_63_F0_uid16 is
signal Rtmp :  std_logic_vector(62 downto 0);
begin
   Rtmp <= X + Y + Cin;
   R <= Rtmp;
end architecture;

--------------------------------------------------------------------------------
--                            IntAdder_63_F0_uid18
-- VHDL generated for Kintex7 @ 0MHz
-- This operator is part of the Infinite Virtual Library FloPoCoLib
-- All rights reserved 
-- Authors: Bogdan Pasca, Florent de Dinechin (2008-2016)
--------------------------------------------------------------------------------
-- combinatorial
-- Clock period (ns): inf
-- Target frequency (MHz): 0
-- Input signals: X Y Cin
-- Output signals: R

library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;
library std;
use std.textio.all;
library work;

entity IntAdder_63_F0_uid18 is
    port (X : in  std_logic_vector(62 downto 0);
          Y : in  std_logic_vector(62 downto 0);
          Cin : in  std_logic;
          R : out  std_logic_vector(62 downto 0)   );
end entity;

architecture arch of IntAdder_63_F0_uid18 is
signal Rtmp :  std_logic_vector(62 downto 0);
begin
   Rtmp <= X + Y + Cin;
   R <= Rtmp;
end architecture;

--------------------------------------------------------------------------------
--                            IntAdder_63_F0_uid20
-- VHDL generated for Kintex7 @ 0MHz
-- This operator is part of the Infinite Virtual Library FloPoCoLib
-- All rights reserved 
-- Authors: Bogdan Pasca, Florent de Dinechin (2008-2016)
--------------------------------------------------------------------------------
-- combinatorial
-- Clock period (ns): inf
-- Target frequency (MHz): 0
-- Input signals: X Y Cin
-- Output signals: R

library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;
library std;
use std.textio.all;
library work;

entity IntAdder_63_F0_uid20 is
    port (X : in  std_logic_vector(62 downto 0);
          Y : in  std_logic_vector(62 downto 0);
          Cin : in  std_logic;
          R : out  std_logic_vector(62 downto 0)   );
end entity;

architecture arch of IntAdder_63_F0_uid20 is
signal Rtmp :  std_logic_vector(62 downto 0);
begin
   Rtmp <= X + Y + Cin;
   R <= Rtmp;
end architecture;

--------------------------------------------------------------------------------
--                            IntAdder_63_F0_uid22
-- VHDL generated for Kintex7 @ 0MHz
-- This operator is part of the Infinite Virtual Library FloPoCoLib
-- All rights reserved 
-- Authors: Bogdan Pasca, Florent de Dinechin (2008-2016)
--------------------------------------------------------------------------------
-- combinatorial
-- Clock period (ns): inf
-- Target frequency (MHz): 0
-- Input signals: X Y Cin
-- Output signals: R

library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;
library std;
use std.textio.all;
library work;

entity IntAdder_63_F0_uid22 is
    port (X : in  std_logic_vector(62 downto 0);
          Y : in  std_logic_vector(62 downto 0);
          Cin : in  std_logic;
          R : out  std_logic_vector(62 downto 0)   );
end entity;

architecture arch of IntAdder_63_F0_uid22 is
signal Rtmp :  std_logic_vector(62 downto 0);
begin
   Rtmp <= X + Y + Cin;
   R <= Rtmp;
end architecture;

--------------------------------------------------------------------------------
--                            IntAdder_63_F0_uid24
-- VHDL generated for Kintex7 @ 0MHz
-- This operator is part of the Infinite Virtual Library FloPoCoLib
-- All rights reserved 
-- Authors: Bogdan Pasca, Florent de Dinechin (2008-2016)
--------------------------------------------------------------------------------
-- combinatorial
-- Clock period (ns): inf
-- Target frequency (MHz): 0
-- Input signals: X Y Cin
-- Output signals: R

library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;
library std;
use std.textio.all;
library work;

entity IntAdder_63_F0_uid24 is
    port (X : in  std_logic_vector(62 downto 0);
          Y : in  std_logic_vector(62 downto 0);
          Cin : in  std_logic;
          R : out  std_logic_vector(62 downto 0)   );
end entity;

architecture arch of IntAdder_63_F0_uid24 is
signal Rtmp :  std_logic_vector(62 downto 0);
begin
   Rtmp <= X + Y + Cin;
   R <= Rtmp;
end architecture;

--------------------------------------------------------------------------------
--                            IntAdder_63_F0_uid26
-- VHDL generated for Kintex7 @ 0MHz
-- This operator is part of the Infinite Virtual Library FloPoCoLib
-- All rights reserved 
-- Authors: Bogdan Pasca, Florent de Dinechin (2008-2016)
--------------------------------------------------------------------------------
-- combinatorial
-- Clock period (ns): inf
-- Target frequency (MHz): 0
-- Input signals: X Y Cin
-- Output signals: R

library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;
library std;
use std.textio.all;
library work;

entity IntAdder_63_F0_uid26 is
    port (X : in  std_logic_vector(62 downto 0);
          Y : in  std_logic_vector(62 downto 0);
          Cin : in  std_logic;
          R : out  std_logic_vector(62 downto 0)   );
end entity;

architecture arch of IntAdder_63_F0_uid26 is
signal Rtmp :  std_logic_vector(62 downto 0);
begin
   Rtmp <= X + Y + Cin;
   R <= Rtmp;
end architecture;

--------------------------------------------------------------------------------
--                            IntAdder_63_F0_uid28
-- VHDL generated for Kintex7 @ 0MHz
-- This operator is part of the Infinite Virtual Library FloPoCoLib
-- All rights reserved 
-- Authors: Bogdan Pasca, Florent de Dinechin (2008-2016)
--------------------------------------------------------------------------------
-- combinatorial
-- Clock period (ns): inf
-- Target frequency (MHz): 0
-- Input signals: X Y Cin
-- Output signals: R

library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;
library std;
use std.textio.all;
library work;

entity IntAdder_63_F0_uid28 is
    port (X : in  std_logic_vector(62 downto 0);
          Y : in  std_logic_vector(62 downto 0);
          Cin : in  std_logic;
          R : out  std_logic_vector(62 downto 0)   );
end entity;

architecture arch of IntAdder_63_F0_uid28 is
signal Rtmp :  std_logic_vector(62 downto 0);
begin
   Rtmp <= X + Y + Cin;
   R <= Rtmp;
end architecture;

--------------------------------------------------------------------------------
--                            IntAdder_63_F0_uid30
-- VHDL generated for Kintex7 @ 0MHz
-- This operator is part of the Infinite Virtual Library FloPoCoLib
-- All rights reserved 
-- Authors: Bogdan Pasca, Florent de Dinechin (2008-2016)
--------------------------------------------------------------------------------
-- combinatorial
-- Clock period (ns): inf
-- Target frequency (MHz): 0
-- Input signals: X Y Cin
-- Output signals: R

library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;
library std;
use std.textio.all;
library work;

entity IntAdder_63_F0_uid30 is
    port (X : in  std_logic_vector(62 downto 0);
          Y : in  std_logic_vector(62 downto 0);
          Cin : in  std_logic;
          R : out  std_logic_vector(62 downto 0)   );
end entity;

architecture arch of IntAdder_63_F0_uid30 is
signal Rtmp :  std_logic_vector(62 downto 0);
begin
   Rtmp <= X + Y + Cin;
   R <= Rtmp;
end architecture;

--------------------------------------------------------------------------------
--                            IntAdder_63_F0_uid32
-- VHDL generated for Kintex7 @ 0MHz
-- This operator is part of the Infinite Virtual Library FloPoCoLib
-- All rights reserved 
-- Authors: Bogdan Pasca, Florent de Dinechin (2008-2016)
--------------------------------------------------------------------------------
-- combinatorial
-- Clock period (ns): inf
-- Target frequency (MHz): 0
-- Input signals: X Y Cin
-- Output signals: R

library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;
library std;
use std.textio.all;
library work;

entity IntAdder_63_F0_uid32 is
    port (X : in  std_logic_vector(62 downto 0);
          Y : in  std_logic_vector(62 downto 0);
          Cin : in  std_logic;
          R : out  std_logic_vector(62 downto 0)   );
end entity;

architecture arch of IntAdder_63_F0_uid32 is
signal Rtmp :  std_logic_vector(62 downto 0);
begin
   Rtmp <= X + Y + Cin;
   R <= Rtmp;
end architecture;

--------------------------------------------------------------------------------
--                            IntAdder_63_F0_uid34
-- VHDL generated for Kintex7 @ 0MHz
-- This operator is part of the Infinite Virtual Library FloPoCoLib
-- All rights reserved 
-- Authors: Bogdan Pasca, Florent de Dinechin (2008-2016)
--------------------------------------------------------------------------------
-- combinatorial
-- Clock period (ns): inf
-- Target frequency (MHz): 0
-- Input signals: X Y Cin
-- Output signals: R

library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;
library std;
use std.textio.all;
library work;

entity IntAdder_63_F0_uid34 is
    port (X : in  std_logic_vector(62 downto 0);
          Y : in  std_logic_vector(62 downto 0);
          Cin : in  std_logic;
          R : out  std_logic_vector(62 downto 0)   );
end entity;

architecture arch of IntAdder_63_F0_uid34 is
signal Rtmp :  std_logic_vector(62 downto 0);
begin
   Rtmp <= X + Y + Cin;
   R <= Rtmp;
end architecture;

--------------------------------------------------------------------------------
--                            IntAdder_63_F0_uid36
-- VHDL generated for Kintex7 @ 0MHz
-- This operator is part of the Infinite Virtual Library FloPoCoLib
-- All rights reserved 
-- Authors: Bogdan Pasca, Florent de Dinechin (2008-2016)
--------------------------------------------------------------------------------
-- combinatorial
-- Clock period (ns): inf
-- Target frequency (MHz): 0
-- Input signals: X Y Cin
-- Output signals: R

library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;
library std;
use std.textio.all;
library work;

entity IntAdder_63_F0_uid36 is
    port (X : in  std_logic_vector(62 downto 0);
          Y : in  std_logic_vector(62 downto 0);
          Cin : in  std_logic;
          R : out  std_logic_vector(62 downto 0)   );
end entity;

architecture arch of IntAdder_63_F0_uid36 is
signal Rtmp :  std_logic_vector(62 downto 0);
begin
   Rtmp <= X + Y + Cin;
   R <= Rtmp;
end architecture;

--------------------------------------------------------------------------------
--                            IntAdder_63_F0_uid38
-- VHDL generated for Kintex7 @ 0MHz
-- This operator is part of the Infinite Virtual Library FloPoCoLib
-- All rights reserved 
-- Authors: Bogdan Pasca, Florent de Dinechin (2008-2016)
--------------------------------------------------------------------------------
-- combinatorial
-- Clock period (ns): inf
-- Target frequency (MHz): 0
-- Input signals: X Y Cin
-- Output signals: R

library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;
library std;
use std.textio.all;
library work;

entity IntAdder_63_F0_uid38 is
    port (X : in  std_logic_vector(62 downto 0);
          Y : in  std_logic_vector(62 downto 0);
          Cin : in  std_logic;
          R : out  std_logic_vector(62 downto 0)   );
end entity;

architecture arch of IntAdder_63_F0_uid38 is
signal Rtmp :  std_logic_vector(62 downto 0);
begin
   Rtmp <= X + Y + Cin;
   R <= Rtmp;
end architecture;

--------------------------------------------------------------------------------
--                            IntAdder_63_F0_uid40
-- VHDL generated for Kintex7 @ 0MHz
-- This operator is part of the Infinite Virtual Library FloPoCoLib
-- All rights reserved 
-- Authors: Bogdan Pasca, Florent de Dinechin (2008-2016)
--------------------------------------------------------------------------------
-- combinatorial
-- Clock period (ns): inf
-- Target frequency (MHz): 0
-- Input signals: X Y Cin
-- Output signals: R

library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;
library std;
use std.textio.all;
library work;

entity IntAdder_63_F0_uid40 is
    port (X : in  std_logic_vector(62 downto 0);
          Y : in  std_logic_vector(62 downto 0);
          Cin : in  std_logic;
          R : out  std_logic_vector(62 downto 0)   );
end entity;

architecture arch of IntAdder_63_F0_uid40 is
signal Rtmp :  std_logic_vector(62 downto 0);
begin
   Rtmp <= X + Y + Cin;
   R <= Rtmp;
end architecture;

--------------------------------------------------------------------------------
--                            IntAdder_63_F0_uid42
-- VHDL generated for Kintex7 @ 0MHz
-- This operator is part of the Infinite Virtual Library FloPoCoLib
-- All rights reserved 
-- Authors: Bogdan Pasca, Florent de Dinechin (2008-2016)
--------------------------------------------------------------------------------
-- combinatorial
-- Clock period (ns): inf
-- Target frequency (MHz): 0
-- Input signals: X Y Cin
-- Output signals: R

library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;
library std;
use std.textio.all;
library work;

entity IntAdder_63_F0_uid42 is
    port (X : in  std_logic_vector(62 downto 0);
          Y : in  std_logic_vector(62 downto 0);
          Cin : in  std_logic;
          R : out  std_logic_vector(62 downto 0)   );
end entity;

architecture arch of IntAdder_63_F0_uid42 is
signal Rtmp :  std_logic_vector(62 downto 0);
begin
   Rtmp <= X + Y + Cin;
   R <= Rtmp;
end architecture;

--------------------------------------------------------------------------------
--                            IntAdder_63_F0_uid44
-- VHDL generated for Kintex7 @ 0MHz
-- This operator is part of the Infinite Virtual Library FloPoCoLib
-- All rights reserved 
-- Authors: Bogdan Pasca, Florent de Dinechin (2008-2016)
--------------------------------------------------------------------------------
-- combinatorial
-- Clock period (ns): inf
-- Target frequency (MHz): 0
-- Input signals: X Y Cin
-- Output signals: R

library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;
library std;
use std.textio.all;
library work;

entity IntAdder_63_F0_uid44 is
    port (X : in  std_logic_vector(62 downto 0);
          Y : in  std_logic_vector(62 downto 0);
          Cin : in  std_logic;
          R : out  std_logic_vector(62 downto 0)   );
end entity;

architecture arch of IntAdder_63_F0_uid44 is
signal Rtmp :  std_logic_vector(62 downto 0);
begin
   Rtmp <= X + Y + Cin;
   R <= Rtmp;
end architecture;

--------------------------------------------------------------------------------
--                            IntAdder_63_F0_uid46
-- VHDL generated for Kintex7 @ 0MHz
-- This operator is part of the Infinite Virtual Library FloPoCoLib
-- All rights reserved 
-- Authors: Bogdan Pasca, Florent de Dinechin (2008-2016)
--------------------------------------------------------------------------------
-- combinatorial
-- Clock period (ns): inf
-- Target frequency (MHz): 0
-- Input signals: X Y Cin
-- Output signals: R

library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;
library std;
use std.textio.all;
library work;

entity IntAdder_63_F0_uid46 is
    port (X : in  std_logic_vector(62 downto 0);
          Y : in  std_logic_vector(62 downto 0);
          Cin : in  std_logic;
          R : out  std_logic_vector(62 downto 0)   );
end entity;

architecture arch of IntAdder_63_F0_uid46 is
signal Rtmp :  std_logic_vector(62 downto 0);
begin
   Rtmp <= X + Y + Cin;
   R <= Rtmp;
end architecture;

--------------------------------------------------------------------------------
--                            IntAdder_63_F0_uid48
-- VHDL generated for Kintex7 @ 0MHz
-- This operator is part of the Infinite Virtual Library FloPoCoLib
-- All rights reserved 
-- Authors: Bogdan Pasca, Florent de Dinechin (2008-2016)
--------------------------------------------------------------------------------
-- combinatorial
-- Clock period (ns): inf
-- Target frequency (MHz): 0
-- Input signals: X Y Cin
-- Output signals: R

library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;
library std;
use std.textio.all;
library work;

entity IntAdder_63_F0_uid48 is
    port (X : in  std_logic_vector(62 downto 0);
          Y : in  std_logic_vector(62 downto 0);
          Cin : in  std_logic;
          R : out  std_logic_vector(62 downto 0)   );
end entity;

architecture arch of IntAdder_63_F0_uid48 is
signal Rtmp :  std_logic_vector(62 downto 0);
begin
   Rtmp <= X + Y + Cin;
   R <= Rtmp;
end architecture;

--------------------------------------------------------------------------------
--                            IntAdder_63_F0_uid50
-- VHDL generated for Kintex7 @ 0MHz
-- This operator is part of the Infinite Virtual Library FloPoCoLib
-- All rights reserved 
-- Authors: Bogdan Pasca, Florent de Dinechin (2008-2016)
--------------------------------------------------------------------------------
-- combinatorial
-- Clock period (ns): inf
-- Target frequency (MHz): 0
-- Input signals: X Y Cin
-- Output signals: R

library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;
library std;
use std.textio.all;
library work;

entity IntAdder_63_F0_uid50 is
    port (X : in  std_logic_vector(62 downto 0);
          Y : in  std_logic_vector(62 downto 0);
          Cin : in  std_logic;
          R : out  std_logic_vector(62 downto 0)   );
end entity;

architecture arch of IntAdder_63_F0_uid50 is
signal Rtmp :  std_logic_vector(62 downto 0);
begin
   Rtmp <= X + Y + Cin;
   R <= Rtmp;
end architecture;

--------------------------------------------------------------------------------
--                            IntAdder_63_F0_uid52
-- VHDL generated for Kintex7 @ 0MHz
-- This operator is part of the Infinite Virtual Library FloPoCoLib
-- All rights reserved 
-- Authors: Bogdan Pasca, Florent de Dinechin (2008-2016)
--------------------------------------------------------------------------------
-- combinatorial
-- Clock period (ns): inf
-- Target frequency (MHz): 0
-- Input signals: X Y Cin
-- Output signals: R

library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;
library std;
use std.textio.all;
library work;

entity IntAdder_63_F0_uid52 is
    port (X : in  std_logic_vector(62 downto 0);
          Y : in  std_logic_vector(62 downto 0);
          Cin : in  std_logic;
          R : out  std_logic_vector(62 downto 0)   );
end entity;

architecture arch of IntAdder_63_F0_uid52 is
signal Rtmp :  std_logic_vector(62 downto 0);
begin
   Rtmp <= X + Y + Cin;
   R <= Rtmp;
end architecture;

--------------------------------------------------------------------------------
--                            IntAdder_63_F0_uid54
-- VHDL generated for Kintex7 @ 0MHz
-- This operator is part of the Infinite Virtual Library FloPoCoLib
-- All rights reserved 
-- Authors: Bogdan Pasca, Florent de Dinechin (2008-2016)
--------------------------------------------------------------------------------
-- combinatorial
-- Clock period (ns): inf
-- Target frequency (MHz): 0
-- Input signals: X Y Cin
-- Output signals: R

library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;
library std;
use std.textio.all;
library work;

entity IntAdder_63_F0_uid54 is
    port (X : in  std_logic_vector(62 downto 0);
          Y : in  std_logic_vector(62 downto 0);
          Cin : in  std_logic;
          R : out  std_logic_vector(62 downto 0)   );
end entity;

architecture arch of IntAdder_63_F0_uid54 is
signal Rtmp :  std_logic_vector(62 downto 0);
begin
   Rtmp <= X + Y + Cin;
   R <= Rtmp;
end architecture;

--------------------------------------------------------------------------------
--                            IntAdder_63_F0_uid56
-- VHDL generated for Kintex7 @ 0MHz
-- This operator is part of the Infinite Virtual Library FloPoCoLib
-- All rights reserved 
-- Authors: Bogdan Pasca, Florent de Dinechin (2008-2016)
--------------------------------------------------------------------------------
-- combinatorial
-- Clock period (ns): inf
-- Target frequency (MHz): 0
-- Input signals: X Y Cin
-- Output signals: R

library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;
library std;
use std.textio.all;
library work;

entity IntAdder_63_F0_uid56 is
    port (X : in  std_logic_vector(62 downto 0);
          Y : in  std_logic_vector(62 downto 0);
          Cin : in  std_logic;
          R : out  std_logic_vector(62 downto 0)   );
end entity;

architecture arch of IntAdder_63_F0_uid56 is
signal Rtmp :  std_logic_vector(62 downto 0);
begin
   Rtmp <= X + Y + Cin;
   R <= Rtmp;
end architecture;

--------------------------------------------------------------------------------
--                            IntAdder_63_F0_uid58
-- VHDL generated for Kintex7 @ 0MHz
-- This operator is part of the Infinite Virtual Library FloPoCoLib
-- All rights reserved 
-- Authors: Bogdan Pasca, Florent de Dinechin (2008-2016)
--------------------------------------------------------------------------------
-- combinatorial
-- Clock period (ns): inf
-- Target frequency (MHz): 0
-- Input signals: X Y Cin
-- Output signals: R

library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;
library std;
use std.textio.all;
library work;

entity IntAdder_63_F0_uid58 is
    port (X : in  std_logic_vector(62 downto 0);
          Y : in  std_logic_vector(62 downto 0);
          Cin : in  std_logic;
          R : out  std_logic_vector(62 downto 0)   );
end entity;

architecture arch of IntAdder_63_F0_uid58 is
signal Rtmp :  std_logic_vector(62 downto 0);
begin
   Rtmp <= X + Y + Cin;
   R <= Rtmp;
end architecture;

--------------------------------------------------------------------------------
--                            IntAdder_63_F0_uid60
-- VHDL generated for Kintex7 @ 0MHz
-- This operator is part of the Infinite Virtual Library FloPoCoLib
-- All rights reserved 
-- Authors: Bogdan Pasca, Florent de Dinechin (2008-2016)
--------------------------------------------------------------------------------
-- combinatorial
-- Clock period (ns): inf
-- Target frequency (MHz): 0
-- Input signals: X Y Cin
-- Output signals: R

library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;
library std;
use std.textio.all;
library work;

entity IntAdder_63_F0_uid60 is
    port (X : in  std_logic_vector(62 downto 0);
          Y : in  std_logic_vector(62 downto 0);
          Cin : in  std_logic;
          R : out  std_logic_vector(62 downto 0)   );
end entity;

architecture arch of IntAdder_63_F0_uid60 is
signal Rtmp :  std_logic_vector(62 downto 0);
begin
   Rtmp <= X + Y + Cin;
   R <= Rtmp;
end architecture;

--------------------------------------------------------------------------------
--                            IntAdder_63_F0_uid62
-- VHDL generated for Kintex7 @ 0MHz
-- This operator is part of the Infinite Virtual Library FloPoCoLib
-- All rights reserved 
-- Authors: Bogdan Pasca, Florent de Dinechin (2008-2016)
--------------------------------------------------------------------------------
-- combinatorial
-- Clock period (ns): inf
-- Target frequency (MHz): 0
-- Input signals: X Y Cin
-- Output signals: R

library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;
library std;
use std.textio.all;
library work;

entity IntAdder_63_F0_uid62 is
    port (X : in  std_logic_vector(62 downto 0);
          Y : in  std_logic_vector(62 downto 0);
          Cin : in  std_logic;
          R : out  std_logic_vector(62 downto 0)   );
end entity;

architecture arch of IntAdder_63_F0_uid62 is
signal Rtmp :  std_logic_vector(62 downto 0);
begin
   Rtmp <= X + Y + Cin;
   R <= Rtmp;
end architecture;

--------------------------------------------------------------------------------
--                            IntAdder_63_F0_uid64
-- VHDL generated for Kintex7 @ 0MHz
-- This operator is part of the Infinite Virtual Library FloPoCoLib
-- All rights reserved 
-- Authors: Bogdan Pasca, Florent de Dinechin (2008-2016)
--------------------------------------------------------------------------------
-- combinatorial
-- Clock period (ns): inf
-- Target frequency (MHz): 0
-- Input signals: X Y Cin
-- Output signals: R

library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;
library std;
use std.textio.all;
library work;

entity IntAdder_63_F0_uid64 is
    port (X : in  std_logic_vector(62 downto 0);
          Y : in  std_logic_vector(62 downto 0);
          Cin : in  std_logic;
          R : out  std_logic_vector(62 downto 0)   );
end entity;

architecture arch of IntAdder_63_F0_uid64 is
signal Rtmp :  std_logic_vector(62 downto 0);
begin
   Rtmp <= X + Y + Cin;
   R <= Rtmp;
end architecture;

--------------------------------------------------------------------------------
--                            IntAdder_63_F0_uid66
-- VHDL generated for Kintex7 @ 0MHz
-- This operator is part of the Infinite Virtual Library FloPoCoLib
-- All rights reserved 
-- Authors: Bogdan Pasca, Florent de Dinechin (2008-2016)
--------------------------------------------------------------------------------
-- combinatorial
-- Clock period (ns): inf
-- Target frequency (MHz): 0
-- Input signals: X Y Cin
-- Output signals: R

library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;
library std;
use std.textio.all;
library work;

entity IntAdder_63_F0_uid66 is
    port (X : in  std_logic_vector(62 downto 0);
          Y : in  std_logic_vector(62 downto 0);
          Cin : in  std_logic;
          R : out  std_logic_vector(62 downto 0)   );
end entity;

architecture arch of IntAdder_63_F0_uid66 is
signal Rtmp :  std_logic_vector(62 downto 0);
begin
   Rtmp <= X + Y + Cin;
   R <= Rtmp;
end architecture;

--------------------------------------------------------------------------------
--                            IntAdder_63_F0_uid68
-- VHDL generated for Kintex7 @ 0MHz
-- This operator is part of the Infinite Virtual Library FloPoCoLib
-- All rights reserved 
-- Authors: Bogdan Pasca, Florent de Dinechin (2008-2016)
--------------------------------------------------------------------------------
-- combinatorial
-- Clock period (ns): inf
-- Target frequency (MHz): 0
-- Input signals: X Y Cin
-- Output signals: R

library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;
library std;
use std.textio.all;
library work;

entity IntAdder_63_F0_uid68 is
    port (X : in  std_logic_vector(62 downto 0);
          Y : in  std_logic_vector(62 downto 0);
          Cin : in  std_logic;
          R : out  std_logic_vector(62 downto 0)   );
end entity;

architecture arch of IntAdder_63_F0_uid68 is
signal Rtmp :  std_logic_vector(62 downto 0);
begin
   Rtmp <= X + Y + Cin;
   R <= Rtmp;
end architecture;

--------------------------------------------------------------------------------
--                            IntAdder_63_F0_uid70
-- VHDL generated for Kintex7 @ 0MHz
-- This operator is part of the Infinite Virtual Library FloPoCoLib
-- All rights reserved 
-- Authors: Bogdan Pasca, Florent de Dinechin (2008-2016)
--------------------------------------------------------------------------------
-- combinatorial
-- Clock period (ns): inf
-- Target frequency (MHz): 0
-- Input signals: X Y Cin
-- Output signals: R

library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;
library std;
use std.textio.all;
library work;

entity IntAdder_63_F0_uid70 is
    port (X : in  std_logic_vector(62 downto 0);
          Y : in  std_logic_vector(62 downto 0);
          Cin : in  std_logic;
          R : out  std_logic_vector(62 downto 0)   );
end entity;

architecture arch of IntAdder_63_F0_uid70 is
signal Rtmp :  std_logic_vector(62 downto 0);
begin
   Rtmp <= X + Y + Cin;
   R <= Rtmp;
end architecture;

--------------------------------------------------------------------------------
--                            IntAdder_63_F0_uid72
-- VHDL generated for Kintex7 @ 0MHz
-- This operator is part of the Infinite Virtual Library FloPoCoLib
-- All rights reserved 
-- Authors: Bogdan Pasca, Florent de Dinechin (2008-2016)
--------------------------------------------------------------------------------
-- combinatorial
-- Clock period (ns): inf
-- Target frequency (MHz): 0
-- Input signals: X Y Cin
-- Output signals: R

library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;
library std;
use std.textio.all;
library work;

entity IntAdder_63_F0_uid72 is
    port (X : in  std_logic_vector(62 downto 0);
          Y : in  std_logic_vector(62 downto 0);
          Cin : in  std_logic;
          R : out  std_logic_vector(62 downto 0)   );
end entity;

architecture arch of IntAdder_63_F0_uid72 is
signal Rtmp :  std_logic_vector(62 downto 0);
begin
   Rtmp <= X + Y + Cin;
   R <= Rtmp;
end architecture;

--------------------------------------------------------------------------------
--                            IntAdder_63_F0_uid74
-- VHDL generated for Kintex7 @ 0MHz
-- This operator is part of the Infinite Virtual Library FloPoCoLib
-- All rights reserved 
-- Authors: Bogdan Pasca, Florent de Dinechin (2008-2016)
--------------------------------------------------------------------------------
-- combinatorial
-- Clock period (ns): inf
-- Target frequency (MHz): 0
-- Input signals: X Y Cin
-- Output signals: R

library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;
library std;
use std.textio.all;
library work;

entity IntAdder_63_F0_uid74 is
    port (X : in  std_logic_vector(62 downto 0);
          Y : in  std_logic_vector(62 downto 0);
          Cin : in  std_logic;
          R : out  std_logic_vector(62 downto 0)   );
end entity;

architecture arch of IntAdder_63_F0_uid74 is
signal Rtmp :  std_logic_vector(62 downto 0);
begin
   Rtmp <= X + Y + Cin;
   R <= Rtmp;
end architecture;

--------------------------------------------------------------------------------
--                            IntAdder_63_F0_uid76
-- VHDL generated for Kintex7 @ 0MHz
-- This operator is part of the Infinite Virtual Library FloPoCoLib
-- All rights reserved 
-- Authors: Bogdan Pasca, Florent de Dinechin (2008-2016)
--------------------------------------------------------------------------------
-- combinatorial
-- Clock period (ns): inf
-- Target frequency (MHz): 0
-- Input signals: X Y Cin
-- Output signals: R

library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;
library std;
use std.textio.all;
library work;

entity IntAdder_63_F0_uid76 is
    port (X : in  std_logic_vector(62 downto 0);
          Y : in  std_logic_vector(62 downto 0);
          Cin : in  std_logic;
          R : out  std_logic_vector(62 downto 0)   );
end entity;

architecture arch of IntAdder_63_F0_uid76 is
signal Rtmp :  std_logic_vector(62 downto 0);
begin
   Rtmp <= X + Y + Cin;
   R <= Rtmp;
end architecture;

--------------------------------------------------------------------------------
--                            IntAdder_63_F0_uid78
-- VHDL generated for Kintex7 @ 0MHz
-- This operator is part of the Infinite Virtual Library FloPoCoLib
-- All rights reserved 
-- Authors: Bogdan Pasca, Florent de Dinechin (2008-2016)
--------------------------------------------------------------------------------
-- combinatorial
-- Clock period (ns): inf
-- Target frequency (MHz): 0
-- Input signals: X Y Cin
-- Output signals: R

library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;
library std;
use std.textio.all;
library work;

entity IntAdder_63_F0_uid78 is
    port (X : in  std_logic_vector(62 downto 0);
          Y : in  std_logic_vector(62 downto 0);
          Cin : in  std_logic;
          R : out  std_logic_vector(62 downto 0)   );
end entity;

architecture arch of IntAdder_63_F0_uid78 is
signal Rtmp :  std_logic_vector(62 downto 0);
begin
   Rtmp <= X + Y + Cin;
   R <= Rtmp;
end architecture;

--------------------------------------------------------------------------------
--                            IntAdder_63_F0_uid80
-- VHDL generated for Kintex7 @ 0MHz
-- This operator is part of the Infinite Virtual Library FloPoCoLib
-- All rights reserved 
-- Authors: Bogdan Pasca, Florent de Dinechin (2008-2016)
--------------------------------------------------------------------------------
-- combinatorial
-- Clock period (ns): inf
-- Target frequency (MHz): 0
-- Input signals: X Y Cin
-- Output signals: R

library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;
library std;
use std.textio.all;
library work;

entity IntAdder_63_F0_uid80 is
    port (X : in  std_logic_vector(62 downto 0);
          Y : in  std_logic_vector(62 downto 0);
          Cin : in  std_logic;
          R : out  std_logic_vector(62 downto 0)   );
end entity;

architecture arch of IntAdder_63_F0_uid80 is
signal Rtmp :  std_logic_vector(62 downto 0);
begin
   Rtmp <= X + Y + Cin;
   R <= Rtmp;
end architecture;

--------------------------------------------------------------------------------
--                            IntAdder_63_F0_uid82
-- VHDL generated for Kintex7 @ 0MHz
-- This operator is part of the Infinite Virtual Library FloPoCoLib
-- All rights reserved 
-- Authors: Bogdan Pasca, Florent de Dinechin (2008-2016)
--------------------------------------------------------------------------------
-- combinatorial
-- Clock period (ns): inf
-- Target frequency (MHz): 0
-- Input signals: X Y Cin
-- Output signals: R

library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;
library std;
use std.textio.all;
library work;

entity IntAdder_63_F0_uid82 is
    port (X : in  std_logic_vector(62 downto 0);
          Y : in  std_logic_vector(62 downto 0);
          Cin : in  std_logic;
          R : out  std_logic_vector(62 downto 0)   );
end entity;

architecture arch of IntAdder_63_F0_uid82 is
signal Rtmp :  std_logic_vector(62 downto 0);
begin
   Rtmp <= X + Y + Cin;
   R <= Rtmp;
end architecture;

--------------------------------------------------------------------------------
--                            IntAdder_63_F0_uid84
-- VHDL generated for Kintex7 @ 0MHz
-- This operator is part of the Infinite Virtual Library FloPoCoLib
-- All rights reserved 
-- Authors: Bogdan Pasca, Florent de Dinechin (2008-2016)
--------------------------------------------------------------------------------
-- combinatorial
-- Clock period (ns): inf
-- Target frequency (MHz): 0
-- Input signals: X Y Cin
-- Output signals: R

library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;
library std;
use std.textio.all;
library work;

entity IntAdder_63_F0_uid84 is
    port (X : in  std_logic_vector(62 downto 0);
          Y : in  std_logic_vector(62 downto 0);
          Cin : in  std_logic;
          R : out  std_logic_vector(62 downto 0)   );
end entity;

architecture arch of IntAdder_63_F0_uid84 is
signal Rtmp :  std_logic_vector(62 downto 0);
begin
   Rtmp <= X + Y + Cin;
   R <= Rtmp;
end architecture;

--------------------------------------------------------------------------------
--                            IntAdder_63_F0_uid86
-- VHDL generated for Kintex7 @ 0MHz
-- This operator is part of the Infinite Virtual Library FloPoCoLib
-- All rights reserved 
-- Authors: Bogdan Pasca, Florent de Dinechin (2008-2016)
--------------------------------------------------------------------------------
-- combinatorial
-- Clock period (ns): inf
-- Target frequency (MHz): 0
-- Input signals: X Y Cin
-- Output signals: R

library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;
library std;
use std.textio.all;
library work;

entity IntAdder_63_F0_uid86 is
    port (X : in  std_logic_vector(62 downto 0);
          Y : in  std_logic_vector(62 downto 0);
          Cin : in  std_logic;
          R : out  std_logic_vector(62 downto 0)   );
end entity;

architecture arch of IntAdder_63_F0_uid86 is
signal Rtmp :  std_logic_vector(62 downto 0);
begin
   Rtmp <= X + Y + Cin;
   R <= Rtmp;
end architecture;

--------------------------------------------------------------------------------
--                            IntAdder_63_F0_uid88
-- VHDL generated for Kintex7 @ 0MHz
-- This operator is part of the Infinite Virtual Library FloPoCoLib
-- All rights reserved 
-- Authors: Bogdan Pasca, Florent de Dinechin (2008-2016)
--------------------------------------------------------------------------------
-- combinatorial
-- Clock period (ns): inf
-- Target frequency (MHz): 0
-- Input signals: X Y Cin
-- Output signals: R

library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;
library std;
use std.textio.all;
library work;

entity IntAdder_63_F0_uid88 is
    port (X : in  std_logic_vector(62 downto 0);
          Y : in  std_logic_vector(62 downto 0);
          Cin : in  std_logic;
          R : out  std_logic_vector(62 downto 0)   );
end entity;

architecture arch of IntAdder_63_F0_uid88 is
signal Rtmp :  std_logic_vector(62 downto 0);
begin
   Rtmp <= X + Y + Cin;
   R <= Rtmp;
end architecture;

--------------------------------------------------------------------------------
--                            IntAdder_63_F0_uid90
-- VHDL generated for Kintex7 @ 0MHz
-- This operator is part of the Infinite Virtual Library FloPoCoLib
-- All rights reserved 
-- Authors: Bogdan Pasca, Florent de Dinechin (2008-2016)
--------------------------------------------------------------------------------
-- combinatorial
-- Clock period (ns): inf
-- Target frequency (MHz): 0
-- Input signals: X Y Cin
-- Output signals: R

library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;
library std;
use std.textio.all;
library work;

entity IntAdder_63_F0_uid90 is
    port (X : in  std_logic_vector(62 downto 0);
          Y : in  std_logic_vector(62 downto 0);
          Cin : in  std_logic;
          R : out  std_logic_vector(62 downto 0)   );
end entity;

architecture arch of IntAdder_63_F0_uid90 is
signal Rtmp :  std_logic_vector(62 downto 0);
begin
   Rtmp <= X + Y + Cin;
   R <= Rtmp;
end architecture;

--------------------------------------------------------------------------------
--                            IntAdder_63_F0_uid92
-- VHDL generated for Kintex7 @ 0MHz
-- This operator is part of the Infinite Virtual Library FloPoCoLib
-- All rights reserved 
-- Authors: Bogdan Pasca, Florent de Dinechin (2008-2016)
--------------------------------------------------------------------------------
-- combinatorial
-- Clock period (ns): inf
-- Target frequency (MHz): 0
-- Input signals: X Y Cin
-- Output signals: R

library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;
library std;
use std.textio.all;
library work;

entity IntAdder_63_F0_uid92 is
    port (X : in  std_logic_vector(62 downto 0);
          Y : in  std_logic_vector(62 downto 0);
          Cin : in  std_logic;
          R : out  std_logic_vector(62 downto 0)   );
end entity;

architecture arch of IntAdder_63_F0_uid92 is
signal Rtmp :  std_logic_vector(62 downto 0);
begin
   Rtmp <= X + Y + Cin;
   R <= Rtmp;
end architecture;

--------------------------------------------------------------------------------
--                            IntAdder_63_F0_uid94
-- VHDL generated for Kintex7 @ 0MHz
-- This operator is part of the Infinite Virtual Library FloPoCoLib
-- All rights reserved 
-- Authors: Bogdan Pasca, Florent de Dinechin (2008-2016)
--------------------------------------------------------------------------------
-- combinatorial
-- Clock period (ns): inf
-- Target frequency (MHz): 0
-- Input signals: X Y Cin
-- Output signals: R

library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;
library std;
use std.textio.all;
library work;

entity IntAdder_63_F0_uid94 is
    port (X : in  std_logic_vector(62 downto 0);
          Y : in  std_logic_vector(62 downto 0);
          Cin : in  std_logic;
          R : out  std_logic_vector(62 downto 0)   );
end entity;

architecture arch of IntAdder_63_F0_uid94 is
signal Rtmp :  std_logic_vector(62 downto 0);
begin
   Rtmp <= X + Y + Cin;
   R <= Rtmp;
end architecture;

--------------------------------------------------------------------------------
--                            IntAdder_63_F0_uid96
-- VHDL generated for Kintex7 @ 0MHz
-- This operator is part of the Infinite Virtual Library FloPoCoLib
-- All rights reserved 
-- Authors: Bogdan Pasca, Florent de Dinechin (2008-2016)
--------------------------------------------------------------------------------
-- combinatorial
-- Clock period (ns): inf
-- Target frequency (MHz): 0
-- Input signals: X Y Cin
-- Output signals: R

library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;
library std;
use std.textio.all;
library work;

entity IntAdder_63_F0_uid96 is
    port (X : in  std_logic_vector(62 downto 0);
          Y : in  std_logic_vector(62 downto 0);
          Cin : in  std_logic;
          R : out  std_logic_vector(62 downto 0)   );
end entity;

architecture arch of IntAdder_63_F0_uid96 is
signal Rtmp :  std_logic_vector(62 downto 0);
begin
   Rtmp <= X + Y + Cin;
   R <= Rtmp;
end architecture;

--------------------------------------------------------------------------------
--                            IntAdder_63_F0_uid98
-- VHDL generated for Kintex7 @ 0MHz
-- This operator is part of the Infinite Virtual Library FloPoCoLib
-- All rights reserved 
-- Authors: Bogdan Pasca, Florent de Dinechin (2008-2016)
--------------------------------------------------------------------------------
-- combinatorial
-- Clock period (ns): inf
-- Target frequency (MHz): 0
-- Input signals: X Y Cin
-- Output signals: R

library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;
library std;
use std.textio.all;
library work;

entity IntAdder_63_F0_uid98 is
    port (X : in  std_logic_vector(62 downto 0);
          Y : in  std_logic_vector(62 downto 0);
          Cin : in  std_logic;
          R : out  std_logic_vector(62 downto 0)   );
end entity;

architecture arch of IntAdder_63_F0_uid98 is
signal Rtmp :  std_logic_vector(62 downto 0);
begin
   Rtmp <= X + Y + Cin;
   R <= Rtmp;
end architecture;

--------------------------------------------------------------------------------
--                           IntAdder_63_F0_uid100
-- VHDL generated for Kintex7 @ 0MHz
-- This operator is part of the Infinite Virtual Library FloPoCoLib
-- All rights reserved 
-- Authors: Bogdan Pasca, Florent de Dinechin (2008-2016)
--------------------------------------------------------------------------------
-- combinatorial
-- Clock period (ns): inf
-- Target frequency (MHz): 0
-- Input signals: X Y Cin
-- Output signals: R

library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;
library std;
use std.textio.all;
library work;

entity IntAdder_63_F0_uid100 is
    port (X : in  std_logic_vector(62 downto 0);
          Y : in  std_logic_vector(62 downto 0);
          Cin : in  std_logic;
          R : out  std_logic_vector(62 downto 0)   );
end entity;

architecture arch of IntAdder_63_F0_uid100 is
signal Rtmp :  std_logic_vector(62 downto 0);
begin
   Rtmp <= X + Y + Cin;
   R <= Rtmp;
end architecture;

--------------------------------------------------------------------------------
--                           IntAdder_63_F0_uid102
-- VHDL generated for Kintex7 @ 0MHz
-- This operator is part of the Infinite Virtual Library FloPoCoLib
-- All rights reserved 
-- Authors: Bogdan Pasca, Florent de Dinechin (2008-2016)
--------------------------------------------------------------------------------
-- combinatorial
-- Clock period (ns): inf
-- Target frequency (MHz): 0
-- Input signals: X Y Cin
-- Output signals: R

library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;
library std;
use std.textio.all;
library work;

entity IntAdder_63_F0_uid102 is
    port (X : in  std_logic_vector(62 downto 0);
          Y : in  std_logic_vector(62 downto 0);
          Cin : in  std_logic;
          R : out  std_logic_vector(62 downto 0)   );
end entity;

architecture arch of IntAdder_63_F0_uid102 is
signal Rtmp :  std_logic_vector(62 downto 0);
begin
   Rtmp <= X + Y + Cin;
   R <= Rtmp;
end architecture;

--------------------------------------------------------------------------------
--                           IntAdder_63_F0_uid104
-- VHDL generated for Kintex7 @ 0MHz
-- This operator is part of the Infinite Virtual Library FloPoCoLib
-- All rights reserved 
-- Authors: Bogdan Pasca, Florent de Dinechin (2008-2016)
--------------------------------------------------------------------------------
-- combinatorial
-- Clock period (ns): inf
-- Target frequency (MHz): 0
-- Input signals: X Y Cin
-- Output signals: R

library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;
library std;
use std.textio.all;
library work;

entity IntAdder_63_F0_uid104 is
    port (X : in  std_logic_vector(62 downto 0);
          Y : in  std_logic_vector(62 downto 0);
          Cin : in  std_logic;
          R : out  std_logic_vector(62 downto 0)   );
end entity;

architecture arch of IntAdder_63_F0_uid104 is
signal Rtmp :  std_logic_vector(62 downto 0);
begin
   Rtmp <= X + Y + Cin;
   R <= Rtmp;
end architecture;

--------------------------------------------------------------------------------
--                           IntAdder_63_F0_uid106
-- VHDL generated for Kintex7 @ 0MHz
-- This operator is part of the Infinite Virtual Library FloPoCoLib
-- All rights reserved 
-- Authors: Bogdan Pasca, Florent de Dinechin (2008-2016)
--------------------------------------------------------------------------------
-- combinatorial
-- Clock period (ns): inf
-- Target frequency (MHz): 0
-- Input signals: X Y Cin
-- Output signals: R

library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;
library std;
use std.textio.all;
library work;

entity IntAdder_63_F0_uid106 is
    port (X : in  std_logic_vector(62 downto 0);
          Y : in  std_logic_vector(62 downto 0);
          Cin : in  std_logic;
          R : out  std_logic_vector(62 downto 0)   );
end entity;

architecture arch of IntAdder_63_F0_uid106 is
signal Rtmp :  std_logic_vector(62 downto 0);
begin
   Rtmp <= X + Y + Cin;
   R <= Rtmp;
end architecture;

--------------------------------------------------------------------------------
--                           IntAdder_63_F0_uid108
-- VHDL generated for Kintex7 @ 0MHz
-- This operator is part of the Infinite Virtual Library FloPoCoLib
-- All rights reserved 
-- Authors: Bogdan Pasca, Florent de Dinechin (2008-2016)
--------------------------------------------------------------------------------
-- combinatorial
-- Clock period (ns): inf
-- Target frequency (MHz): 0
-- Input signals: X Y Cin
-- Output signals: R

library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;
library std;
use std.textio.all;
library work;

entity IntAdder_63_F0_uid108 is
    port (X : in  std_logic_vector(62 downto 0);
          Y : in  std_logic_vector(62 downto 0);
          Cin : in  std_logic;
          R : out  std_logic_vector(62 downto 0)   );
end entity;

architecture arch of IntAdder_63_F0_uid108 is
signal Rtmp :  std_logic_vector(62 downto 0);
begin
   Rtmp <= X + Y + Cin;
   R <= Rtmp;
end architecture;

--------------------------------------------------------------------------------
--                           IntAdder_63_F0_uid110
-- VHDL generated for Kintex7 @ 0MHz
-- This operator is part of the Infinite Virtual Library FloPoCoLib
-- All rights reserved 
-- Authors: Bogdan Pasca, Florent de Dinechin (2008-2016)
--------------------------------------------------------------------------------
-- combinatorial
-- Clock period (ns): inf
-- Target frequency (MHz): 0
-- Input signals: X Y Cin
-- Output signals: R

library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;
library std;
use std.textio.all;
library work;

entity IntAdder_63_F0_uid110 is
    port (X : in  std_logic_vector(62 downto 0);
          Y : in  std_logic_vector(62 downto 0);
          Cin : in  std_logic;
          R : out  std_logic_vector(62 downto 0)   );
end entity;

architecture arch of IntAdder_63_F0_uid110 is
signal Rtmp :  std_logic_vector(62 downto 0);
begin
   Rtmp <= X + Y + Cin;
   R <= Rtmp;
end architecture;

--------------------------------------------------------------------------------
--                           IntAdder_63_F0_uid112
-- VHDL generated for Kintex7 @ 0MHz
-- This operator is part of the Infinite Virtual Library FloPoCoLib
-- All rights reserved 
-- Authors: Bogdan Pasca, Florent de Dinechin (2008-2016)
--------------------------------------------------------------------------------
-- combinatorial
-- Clock period (ns): inf
-- Target frequency (MHz): 0
-- Input signals: X Y Cin
-- Output signals: R

library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;
library std;
use std.textio.all;
library work;

entity IntAdder_63_F0_uid112 is
    port (X : in  std_logic_vector(62 downto 0);
          Y : in  std_logic_vector(62 downto 0);
          Cin : in  std_logic;
          R : out  std_logic_vector(62 downto 0)   );
end entity;

architecture arch of IntAdder_63_F0_uid112 is
signal Rtmp :  std_logic_vector(62 downto 0);
begin
   Rtmp <= X + Y + Cin;
   R <= Rtmp;
end architecture;

--------------------------------------------------------------------------------
--                           IntAdder_63_F0_uid114
-- VHDL generated for Kintex7 @ 0MHz
-- This operator is part of the Infinite Virtual Library FloPoCoLib
-- All rights reserved 
-- Authors: Bogdan Pasca, Florent de Dinechin (2008-2016)
--------------------------------------------------------------------------------
-- combinatorial
-- Clock period (ns): inf
-- Target frequency (MHz): 0
-- Input signals: X Y Cin
-- Output signals: R

library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;
library std;
use std.textio.all;
library work;

entity IntAdder_63_F0_uid114 is
    port (X : in  std_logic_vector(62 downto 0);
          Y : in  std_logic_vector(62 downto 0);
          Cin : in  std_logic;
          R : out  std_logic_vector(62 downto 0)   );
end entity;

architecture arch of IntAdder_63_F0_uid114 is
signal Rtmp :  std_logic_vector(62 downto 0);
begin
   Rtmp <= X + Y + Cin;
   R <= Rtmp;
end architecture;

--------------------------------------------------------------------------------
--                           IntAdder_63_F0_uid116
-- VHDL generated for Kintex7 @ 0MHz
-- This operator is part of the Infinite Virtual Library FloPoCoLib
-- All rights reserved 
-- Authors: Bogdan Pasca, Florent de Dinechin (2008-2016)
--------------------------------------------------------------------------------
-- combinatorial
-- Clock period (ns): inf
-- Target frequency (MHz): 0
-- Input signals: X Y Cin
-- Output signals: R

library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;
library std;
use std.textio.all;
library work;

entity IntAdder_63_F0_uid116 is
    port (X : in  std_logic_vector(62 downto 0);
          Y : in  std_logic_vector(62 downto 0);
          Cin : in  std_logic;
          R : out  std_logic_vector(62 downto 0)   );
end entity;

architecture arch of IntAdder_63_F0_uid116 is
signal Rtmp :  std_logic_vector(62 downto 0);
begin
   Rtmp <= X + Y + Cin;
   R <= Rtmp;
end architecture;

--------------------------------------------------------------------------------
--                           IntAdder_63_F0_uid118
-- VHDL generated for Kintex7 @ 0MHz
-- This operator is part of the Infinite Virtual Library FloPoCoLib
-- All rights reserved 
-- Authors: Bogdan Pasca, Florent de Dinechin (2008-2016)
--------------------------------------------------------------------------------
-- combinatorial
-- Clock period (ns): inf
-- Target frequency (MHz): 0
-- Input signals: X Y Cin
-- Output signals: R

library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;
library std;
use std.textio.all;
library work;

entity IntAdder_63_F0_uid118 is
    port (X : in  std_logic_vector(62 downto 0);
          Y : in  std_logic_vector(62 downto 0);
          Cin : in  std_logic;
          R : out  std_logic_vector(62 downto 0)   );
end entity;

architecture arch of IntAdder_63_F0_uid118 is
signal Rtmp :  std_logic_vector(62 downto 0);
begin
   Rtmp <= X + Y + Cin;
   R <= Rtmp;
end architecture;

--------------------------------------------------------------------------------
--                           IntAdder_63_F0_uid120
-- VHDL generated for Kintex7 @ 0MHz
-- This operator is part of the Infinite Virtual Library FloPoCoLib
-- All rights reserved 
-- Authors: Bogdan Pasca, Florent de Dinechin (2008-2016)
--------------------------------------------------------------------------------
-- combinatorial
-- Clock period (ns): inf
-- Target frequency (MHz): 0
-- Input signals: X Y Cin
-- Output signals: R

library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;
library std;
use std.textio.all;
library work;

entity IntAdder_63_F0_uid120 is
    port (X : in  std_logic_vector(62 downto 0);
          Y : in  std_logic_vector(62 downto 0);
          Cin : in  std_logic;
          R : out  std_logic_vector(62 downto 0)   );
end entity;

architecture arch of IntAdder_63_F0_uid120 is
signal Rtmp :  std_logic_vector(62 downto 0);
begin
   Rtmp <= X + Y + Cin;
   R <= Rtmp;
end architecture;

--------------------------------------------------------------------------------
--                           IntAdder_63_F0_uid122
-- VHDL generated for Kintex7 @ 0MHz
-- This operator is part of the Infinite Virtual Library FloPoCoLib
-- All rights reserved 
-- Authors: Bogdan Pasca, Florent de Dinechin (2008-2016)
--------------------------------------------------------------------------------
-- combinatorial
-- Clock period (ns): inf
-- Target frequency (MHz): 0
-- Input signals: X Y Cin
-- Output signals: R

library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;
library std;
use std.textio.all;
library work;

entity IntAdder_63_F0_uid122 is
    port (X : in  std_logic_vector(62 downto 0);
          Y : in  std_logic_vector(62 downto 0);
          Cin : in  std_logic;
          R : out  std_logic_vector(62 downto 0)   );
end entity;

architecture arch of IntAdder_63_F0_uid122 is
signal Rtmp :  std_logic_vector(62 downto 0);
begin
   Rtmp <= X + Y + Cin;
   R <= Rtmp;
end architecture;

--------------------------------------------------------------------------------
--                           IntAdder_63_F0_uid124
-- VHDL generated for Kintex7 @ 0MHz
-- This operator is part of the Infinite Virtual Library FloPoCoLib
-- All rights reserved 
-- Authors: Bogdan Pasca, Florent de Dinechin (2008-2016)
--------------------------------------------------------------------------------
-- combinatorial
-- Clock period (ns): inf
-- Target frequency (MHz): 0
-- Input signals: X Y Cin
-- Output signals: R

library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;
library std;
use std.textio.all;
library work;

entity IntAdder_63_F0_uid124 is
    port (X : in  std_logic_vector(62 downto 0);
          Y : in  std_logic_vector(62 downto 0);
          Cin : in  std_logic;
          R : out  std_logic_vector(62 downto 0)   );
end entity;

architecture arch of IntAdder_63_F0_uid124 is
signal Rtmp :  std_logic_vector(62 downto 0);
begin
   Rtmp <= X + Y + Cin;
   R <= Rtmp;
end architecture;

--------------------------------------------------------------------------------
--                           IntAdder_63_F0_uid126
-- VHDL generated for Kintex7 @ 0MHz
-- This operator is part of the Infinite Virtual Library FloPoCoLib
-- All rights reserved 
-- Authors: Bogdan Pasca, Florent de Dinechin (2008-2016)
--------------------------------------------------------------------------------
-- combinatorial
-- Clock period (ns): inf
-- Target frequency (MHz): 0
-- Input signals: X Y Cin
-- Output signals: R

library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;
library std;
use std.textio.all;
library work;

entity IntAdder_63_F0_uid126 is
    port (X : in  std_logic_vector(62 downto 0);
          Y : in  std_logic_vector(62 downto 0);
          Cin : in  std_logic;
          R : out  std_logic_vector(62 downto 0)   );
end entity;

architecture arch of IntAdder_63_F0_uid126 is
signal Rtmp :  std_logic_vector(62 downto 0);
begin
   Rtmp <= X + Y + Cin;
   R <= Rtmp;
end architecture;

--------------------------------------------------------------------------------
--                           IntAdder_63_F0_uid128
-- VHDL generated for Kintex7 @ 0MHz
-- This operator is part of the Infinite Virtual Library FloPoCoLib
-- All rights reserved 
-- Authors: Bogdan Pasca, Florent de Dinechin (2008-2016)
--------------------------------------------------------------------------------
-- combinatorial
-- Clock period (ns): inf
-- Target frequency (MHz): 0
-- Input signals: X Y Cin
-- Output signals: R

library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;
library std;
use std.textio.all;
library work;

entity IntAdder_63_F0_uid128 is
    port (X : in  std_logic_vector(62 downto 0);
          Y : in  std_logic_vector(62 downto 0);
          Cin : in  std_logic;
          R : out  std_logic_vector(62 downto 0)   );
end entity;

architecture arch of IntAdder_63_F0_uid128 is
signal Rtmp :  std_logic_vector(62 downto 0);
begin
   Rtmp <= X + Y + Cin;
   R <= Rtmp;
end architecture;

--------------------------------------------------------------------------------
--                           IntAdder_63_F0_uid130
-- VHDL generated for Kintex7 @ 0MHz
-- This operator is part of the Infinite Virtual Library FloPoCoLib
-- All rights reserved 
-- Authors: Bogdan Pasca, Florent de Dinechin (2008-2016)
--------------------------------------------------------------------------------
-- combinatorial
-- Clock period (ns): inf
-- Target frequency (MHz): 0
-- Input signals: X Y Cin
-- Output signals: R

library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;
library std;
use std.textio.all;
library work;

entity IntAdder_63_F0_uid130 is
    port (X : in  std_logic_vector(62 downto 0);
          Y : in  std_logic_vector(62 downto 0);
          Cin : in  std_logic;
          R : out  std_logic_vector(62 downto 0)   );
end entity;

architecture arch of IntAdder_63_F0_uid130 is
signal Rtmp :  std_logic_vector(62 downto 0);
begin
   Rtmp <= X + Y + Cin;
   R <= Rtmp;
end architecture;

--------------------------------------------------------------------------------
--                  RightShifterSticky63_by_max_63_F0_uid134
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

entity RightShifterSticky63_by_max_63_F0_uid134 is
    port (X : in  std_logic_vector(62 downto 0);
          S : in  std_logic_vector(5 downto 0);
          padBit : in  std_logic;
          R : out  std_logic_vector(62 downto 0);
          Sticky : out  std_logic   );
end entity;

architecture arch of RightShifterSticky63_by_max_63_F0_uid134 is
signal ps :  std_logic_vector(5 downto 0);
signal Xpadded :  std_logic_vector(62 downto 0);
signal level6 :  std_logic_vector(62 downto 0);
signal stk5 :  std_logic;
signal level5 :  std_logic_vector(62 downto 0);
signal stk4 :  std_logic;
signal level4 :  std_logic_vector(62 downto 0);
signal stk3 :  std_logic;
signal level3 :  std_logic_vector(62 downto 0);
signal stk2 :  std_logic;
signal level2 :  std_logic_vector(62 downto 0);
signal stk1 :  std_logic;
signal level1 :  std_logic_vector(62 downto 0);
signal stk0 :  std_logic;
signal level0 :  std_logic_vector(62 downto 0);
begin
   ps<= S;
   Xpadded <= X;
   level6<= Xpadded;
   stk5 <= '1' when (level6(31 downto 0)/="00000000000000000000000000000000" and ps(5)='1')   else '0';
   level5 <=  level6 when  ps(5)='0'    else (31 downto 0 => padBit) & level6(62 downto 32);
   stk4 <= '1' when (level5(15 downto 0)/="0000000000000000" and ps(4)='1') or stk5 ='1'   else '0';
   level4 <=  level5 when  ps(4)='0'    else (15 downto 0 => padBit) & level5(62 downto 16);
   stk3 <= '1' when (level4(7 downto 0)/="00000000" and ps(3)='1') or stk4 ='1'   else '0';
   level3 <=  level4 when  ps(3)='0'    else (7 downto 0 => padBit) & level4(62 downto 8);
   stk2 <= '1' when (level3(3 downto 0)/="0000" and ps(2)='1') or stk3 ='1'   else '0';
   level2 <=  level3 when  ps(2)='0'    else (3 downto 0 => padBit) & level3(62 downto 4);
   stk1 <= '1' when (level2(1 downto 0)/="00" and ps(1)='1') or stk2 ='1'   else '0';
   level1 <=  level2 when  ps(1)='0'    else (1 downto 0 => padBit) & level2(62 downto 2);
   stk0 <= '1' when (level1(0 downto 0)/="0" and ps(0)='1') or stk1 ='1'   else '0';
   level0 <=  level1 when  ps(0)='0'    else (0 downto 0 => padBit) & level1(62 downto 1);
   R <= level0;
   Sticky <= stk0;
end architecture;

--------------------------------------------------------------------------------
--                      PositFastEncoder_64_2_F0_uid132
-- Version: 2022.11.14 - 133718
-- VHDL generated for Kintex7 @ 0MHz
-- This operator is part of the Infinite Virtual Library FloPoCoLib
-- All rights reserved 
-- Authors: Raul Murillo (2021-2022)
--------------------------------------------------------------------------------
-- combinatorial
-- Clock period (ns): inf
-- Target frequency (MHz): 0
-- Input signals: Sign SF Frac Guard Sticky NZN
-- Output signals: R

library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;
library std;
use std.textio.all;
library work;

entity PositFastEncoder_64_2_F0_uid132 is
    port (Sign : in  std_logic;
          SF : in  std_logic_vector(9 downto 0);
          Frac : in  std_logic_vector(58 downto 0);
          Guard : in  std_logic;
          Sticky : in  std_logic;
          NZN : in  std_logic;
          R : out  std_logic_vector(63 downto 0)   );
end entity;

architecture arch of PositFastEncoder_64_2_F0_uid132 is
   component RightShifterSticky63_by_max_63_F0_uid134 is
      port ( X : in  std_logic_vector(62 downto 0);
             S : in  std_logic_vector(5 downto 0);
             padBit : in  std_logic;
             R : out  std_logic_vector(62 downto 0);
             Sticky : out  std_logic   );
   end component;

signal rc :  std_logic;
signal rcVect :  std_logic_vector(6 downto 0);
signal k :  std_logic_vector(6 downto 0);
signal sgnVect :  std_logic_vector(1 downto 0);
signal exp :  std_logic_vector(1 downto 0);
signal ovf :  std_logic;
signal regValue :  std_logic_vector(5 downto 0);
signal regNeg :  std_logic;
signal padBit :  std_logic;
signal inputShifter :  std_logic_vector(62 downto 0);
signal shiftedPosit :  std_logic_vector(62 downto 0);
signal stkBit :  std_logic;
signal unroundedPosit :  std_logic_vector(62 downto 0);
signal lsb :  std_logic;
signal rnd :  std_logic;
signal stk :  std_logic;
signal round :  std_logic;
signal roundedPosit :  std_logic_vector(62 downto 0);
signal unsignedPosit :  std_logic_vector(62 downto 0);
begin
--------------------------- Start of vhdl generation ---------------------------
----------------------------- Get value of regime -----------------------------
   rc <= SF(SF'high);
   rcVect <= (others => rc);
   k <= SF(8 downto 2) XOR rcVect;
   sgnVect <= (others => Sign);
   exp <= SF(1 downto 0) XOR sgnVect;
   -- Check for regime overflow
   ovf <= '1' when (k > "0111101") else '0';
   regValue <= k(5 downto 0) when ovf = '0' else "111110";
-------------- Generate regime - shift out exponent and fraction --------------
   regNeg <= Sign XOR rc;
   padBit <= NOT(regNeg);
   inputShifter <= regNeg & exp & Frac & Guard;
   RegimeGenerator: RightShifterSticky63_by_max_63_F0_uid134
      port map ( S => regValue,
                 X => inputShifter,
                 padBit => padBit,
                 R => shiftedPosit,
                 Sticky => stkBit);
   unroundedPosit <= padBit & shiftedPosit(62 downto 1);
---------------------------- Round to nearest even ----------------------------
   lsb <= shiftedPosit(1);
   rnd <= shiftedPosit(0);
   stk <= stkBit OR Sticky;
   round <= rnd AND (lsb OR stk OR ovf);
   roundedPosit <= unroundedPosit + round;
-------------------------- Check sign & Special Cases --------------------------
   unsignedPosit <= roundedPosit when NZN = '1' else (others => '0');
   R <= Sign & unsignedPosit;
---------------------------- End of vhdl generation ----------------------------
end architecture;

--------------------------------------------------------------------------------
--                                 PositSqrt
--                          (PositSqrt_64_2_F0_uid2)
-- Version: 2022.11.14 - 133718
-- VHDL generated for Kintex7 @ 0MHz
-- This operator is part of the Infinite Virtual Library FloPoCoLib
-- All rights reserved 
-- Authors: Raul Murillo (2021-2022)
--------------------------------------------------------------------------------
-- combinatorial
-- Clock period (ns): inf
-- Target frequency (MHz): 0
-- Input signals: X
-- Output signals: R

library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;
library std;
use std.textio.all;
library work;

entity PositSqrt is
    port (X : in  std_logic_vector(63 downto 0);
          R : out  std_logic_vector(63 downto 0)   );
end entity;

architecture arch of PositSqrt is
   component PositFastDecoder_64_2_F0_uid4 is
      port ( X : in  std_logic_vector(63 downto 0);
             Sign : out  std_logic;
             SF : out  std_logic_vector(8 downto 0);
             Frac : out  std_logic_vector(58 downto 0);
             NZN : out  std_logic   );
   end component;

   component IntAdder_63_F0_uid8 is
      port ( X : in  std_logic_vector(62 downto 0);
             Y : in  std_logic_vector(62 downto 0);
             Cin : in  std_logic;
             R : out  std_logic_vector(62 downto 0)   );
   end component;

   component IntAdder_63_F0_uid10 is
      port ( X : in  std_logic_vector(62 downto 0);
             Y : in  std_logic_vector(62 downto 0);
             Cin : in  std_logic;
             R : out  std_logic_vector(62 downto 0)   );
   end component;

   component IntAdder_63_F0_uid12 is
      port ( X : in  std_logic_vector(62 downto 0);
             Y : in  std_logic_vector(62 downto 0);
             Cin : in  std_logic;
             R : out  std_logic_vector(62 downto 0)   );
   end component;

   component IntAdder_63_F0_uid14 is
      port ( X : in  std_logic_vector(62 downto 0);
             Y : in  std_logic_vector(62 downto 0);
             Cin : in  std_logic;
             R : out  std_logic_vector(62 downto 0)   );
   end component;

   component IntAdder_63_F0_uid16 is
      port ( X : in  std_logic_vector(62 downto 0);
             Y : in  std_logic_vector(62 downto 0);
             Cin : in  std_logic;
             R : out  std_logic_vector(62 downto 0)   );
   end component;

   component IntAdder_63_F0_uid18 is
      port ( X : in  std_logic_vector(62 downto 0);
             Y : in  std_logic_vector(62 downto 0);
             Cin : in  std_logic;
             R : out  std_logic_vector(62 downto 0)   );
   end component;

   component IntAdder_63_F0_uid20 is
      port ( X : in  std_logic_vector(62 downto 0);
             Y : in  std_logic_vector(62 downto 0);
             Cin : in  std_logic;
             R : out  std_logic_vector(62 downto 0)   );
   end component;

   component IntAdder_63_F0_uid22 is
      port ( X : in  std_logic_vector(62 downto 0);
             Y : in  std_logic_vector(62 downto 0);
             Cin : in  std_logic;
             R : out  std_logic_vector(62 downto 0)   );
   end component;

   component IntAdder_63_F0_uid24 is
      port ( X : in  std_logic_vector(62 downto 0);
             Y : in  std_logic_vector(62 downto 0);
             Cin : in  std_logic;
             R : out  std_logic_vector(62 downto 0)   );
   end component;

   component IntAdder_63_F0_uid26 is
      port ( X : in  std_logic_vector(62 downto 0);
             Y : in  std_logic_vector(62 downto 0);
             Cin : in  std_logic;
             R : out  std_logic_vector(62 downto 0)   );
   end component;

   component IntAdder_63_F0_uid28 is
      port ( X : in  std_logic_vector(62 downto 0);
             Y : in  std_logic_vector(62 downto 0);
             Cin : in  std_logic;
             R : out  std_logic_vector(62 downto 0)   );
   end component;

   component IntAdder_63_F0_uid30 is
      port ( X : in  std_logic_vector(62 downto 0);
             Y : in  std_logic_vector(62 downto 0);
             Cin : in  std_logic;
             R : out  std_logic_vector(62 downto 0)   );
   end component;

   component IntAdder_63_F0_uid32 is
      port ( X : in  std_logic_vector(62 downto 0);
             Y : in  std_logic_vector(62 downto 0);
             Cin : in  std_logic;
             R : out  std_logic_vector(62 downto 0)   );
   end component;

   component IntAdder_63_F0_uid34 is
      port ( X : in  std_logic_vector(62 downto 0);
             Y : in  std_logic_vector(62 downto 0);
             Cin : in  std_logic;
             R : out  std_logic_vector(62 downto 0)   );
   end component;

   component IntAdder_63_F0_uid36 is
      port ( X : in  std_logic_vector(62 downto 0);
             Y : in  std_logic_vector(62 downto 0);
             Cin : in  std_logic;
             R : out  std_logic_vector(62 downto 0)   );
   end component;

   component IntAdder_63_F0_uid38 is
      port ( X : in  std_logic_vector(62 downto 0);
             Y : in  std_logic_vector(62 downto 0);
             Cin : in  std_logic;
             R : out  std_logic_vector(62 downto 0)   );
   end component;

   component IntAdder_63_F0_uid40 is
      port ( X : in  std_logic_vector(62 downto 0);
             Y : in  std_logic_vector(62 downto 0);
             Cin : in  std_logic;
             R : out  std_logic_vector(62 downto 0)   );
   end component;

   component IntAdder_63_F0_uid42 is
      port ( X : in  std_logic_vector(62 downto 0);
             Y : in  std_logic_vector(62 downto 0);
             Cin : in  std_logic;
             R : out  std_logic_vector(62 downto 0)   );
   end component;

   component IntAdder_63_F0_uid44 is
      port ( X : in  std_logic_vector(62 downto 0);
             Y : in  std_logic_vector(62 downto 0);
             Cin : in  std_logic;
             R : out  std_logic_vector(62 downto 0)   );
   end component;

   component IntAdder_63_F0_uid46 is
      port ( X : in  std_logic_vector(62 downto 0);
             Y : in  std_logic_vector(62 downto 0);
             Cin : in  std_logic;
             R : out  std_logic_vector(62 downto 0)   );
   end component;

   component IntAdder_63_F0_uid48 is
      port ( X : in  std_logic_vector(62 downto 0);
             Y : in  std_logic_vector(62 downto 0);
             Cin : in  std_logic;
             R : out  std_logic_vector(62 downto 0)   );
   end component;

   component IntAdder_63_F0_uid50 is
      port ( X : in  std_logic_vector(62 downto 0);
             Y : in  std_logic_vector(62 downto 0);
             Cin : in  std_logic;
             R : out  std_logic_vector(62 downto 0)   );
   end component;

   component IntAdder_63_F0_uid52 is
      port ( X : in  std_logic_vector(62 downto 0);
             Y : in  std_logic_vector(62 downto 0);
             Cin : in  std_logic;
             R : out  std_logic_vector(62 downto 0)   );
   end component;

   component IntAdder_63_F0_uid54 is
      port ( X : in  std_logic_vector(62 downto 0);
             Y : in  std_logic_vector(62 downto 0);
             Cin : in  std_logic;
             R : out  std_logic_vector(62 downto 0)   );
   end component;

   component IntAdder_63_F0_uid56 is
      port ( X : in  std_logic_vector(62 downto 0);
             Y : in  std_logic_vector(62 downto 0);
             Cin : in  std_logic;
             R : out  std_logic_vector(62 downto 0)   );
   end component;

   component IntAdder_63_F0_uid58 is
      port ( X : in  std_logic_vector(62 downto 0);
             Y : in  std_logic_vector(62 downto 0);
             Cin : in  std_logic;
             R : out  std_logic_vector(62 downto 0)   );
   end component;

   component IntAdder_63_F0_uid60 is
      port ( X : in  std_logic_vector(62 downto 0);
             Y : in  std_logic_vector(62 downto 0);
             Cin : in  std_logic;
             R : out  std_logic_vector(62 downto 0)   );
   end component;

   component IntAdder_63_F0_uid62 is
      port ( X : in  std_logic_vector(62 downto 0);
             Y : in  std_logic_vector(62 downto 0);
             Cin : in  std_logic;
             R : out  std_logic_vector(62 downto 0)   );
   end component;

   component IntAdder_63_F0_uid64 is
      port ( X : in  std_logic_vector(62 downto 0);
             Y : in  std_logic_vector(62 downto 0);
             Cin : in  std_logic;
             R : out  std_logic_vector(62 downto 0)   );
   end component;

   component IntAdder_63_F0_uid66 is
      port ( X : in  std_logic_vector(62 downto 0);
             Y : in  std_logic_vector(62 downto 0);
             Cin : in  std_logic;
             R : out  std_logic_vector(62 downto 0)   );
   end component;

   component IntAdder_63_F0_uid68 is
      port ( X : in  std_logic_vector(62 downto 0);
             Y : in  std_logic_vector(62 downto 0);
             Cin : in  std_logic;
             R : out  std_logic_vector(62 downto 0)   );
   end component;

   component IntAdder_63_F0_uid70 is
      port ( X : in  std_logic_vector(62 downto 0);
             Y : in  std_logic_vector(62 downto 0);
             Cin : in  std_logic;
             R : out  std_logic_vector(62 downto 0)   );
   end component;

   component IntAdder_63_F0_uid72 is
      port ( X : in  std_logic_vector(62 downto 0);
             Y : in  std_logic_vector(62 downto 0);
             Cin : in  std_logic;
             R : out  std_logic_vector(62 downto 0)   );
   end component;

   component IntAdder_63_F0_uid74 is
      port ( X : in  std_logic_vector(62 downto 0);
             Y : in  std_logic_vector(62 downto 0);
             Cin : in  std_logic;
             R : out  std_logic_vector(62 downto 0)   );
   end component;

   component IntAdder_63_F0_uid76 is
      port ( X : in  std_logic_vector(62 downto 0);
             Y : in  std_logic_vector(62 downto 0);
             Cin : in  std_logic;
             R : out  std_logic_vector(62 downto 0)   );
   end component;

   component IntAdder_63_F0_uid78 is
      port ( X : in  std_logic_vector(62 downto 0);
             Y : in  std_logic_vector(62 downto 0);
             Cin : in  std_logic;
             R : out  std_logic_vector(62 downto 0)   );
   end component;

   component IntAdder_63_F0_uid80 is
      port ( X : in  std_logic_vector(62 downto 0);
             Y : in  std_logic_vector(62 downto 0);
             Cin : in  std_logic;
             R : out  std_logic_vector(62 downto 0)   );
   end component;

   component IntAdder_63_F0_uid82 is
      port ( X : in  std_logic_vector(62 downto 0);
             Y : in  std_logic_vector(62 downto 0);
             Cin : in  std_logic;
             R : out  std_logic_vector(62 downto 0)   );
   end component;

   component IntAdder_63_F0_uid84 is
      port ( X : in  std_logic_vector(62 downto 0);
             Y : in  std_logic_vector(62 downto 0);
             Cin : in  std_logic;
             R : out  std_logic_vector(62 downto 0)   );
   end component;

   component IntAdder_63_F0_uid86 is
      port ( X : in  std_logic_vector(62 downto 0);
             Y : in  std_logic_vector(62 downto 0);
             Cin : in  std_logic;
             R : out  std_logic_vector(62 downto 0)   );
   end component;

   component IntAdder_63_F0_uid88 is
      port ( X : in  std_logic_vector(62 downto 0);
             Y : in  std_logic_vector(62 downto 0);
             Cin : in  std_logic;
             R : out  std_logic_vector(62 downto 0)   );
   end component;

   component IntAdder_63_F0_uid90 is
      port ( X : in  std_logic_vector(62 downto 0);
             Y : in  std_logic_vector(62 downto 0);
             Cin : in  std_logic;
             R : out  std_logic_vector(62 downto 0)   );
   end component;

   component IntAdder_63_F0_uid92 is
      port ( X : in  std_logic_vector(62 downto 0);
             Y : in  std_logic_vector(62 downto 0);
             Cin : in  std_logic;
             R : out  std_logic_vector(62 downto 0)   );
   end component;

   component IntAdder_63_F0_uid94 is
      port ( X : in  std_logic_vector(62 downto 0);
             Y : in  std_logic_vector(62 downto 0);
             Cin : in  std_logic;
             R : out  std_logic_vector(62 downto 0)   );
   end component;

   component IntAdder_63_F0_uid96 is
      port ( X : in  std_logic_vector(62 downto 0);
             Y : in  std_logic_vector(62 downto 0);
             Cin : in  std_logic;
             R : out  std_logic_vector(62 downto 0)   );
   end component;

   component IntAdder_63_F0_uid98 is
      port ( X : in  std_logic_vector(62 downto 0);
             Y : in  std_logic_vector(62 downto 0);
             Cin : in  std_logic;
             R : out  std_logic_vector(62 downto 0)   );
   end component;

   component IntAdder_63_F0_uid100 is
      port ( X : in  std_logic_vector(62 downto 0);
             Y : in  std_logic_vector(62 downto 0);
             Cin : in  std_logic;
             R : out  std_logic_vector(62 downto 0)   );
   end component;

   component IntAdder_63_F0_uid102 is
      port ( X : in  std_logic_vector(62 downto 0);
             Y : in  std_logic_vector(62 downto 0);
             Cin : in  std_logic;
             R : out  std_logic_vector(62 downto 0)   );
   end component;

   component IntAdder_63_F0_uid104 is
      port ( X : in  std_logic_vector(62 downto 0);
             Y : in  std_logic_vector(62 downto 0);
             Cin : in  std_logic;
             R : out  std_logic_vector(62 downto 0)   );
   end component;

   component IntAdder_63_F0_uid106 is
      port ( X : in  std_logic_vector(62 downto 0);
             Y : in  std_logic_vector(62 downto 0);
             Cin : in  std_logic;
             R : out  std_logic_vector(62 downto 0)   );
   end component;

   component IntAdder_63_F0_uid108 is
      port ( X : in  std_logic_vector(62 downto 0);
             Y : in  std_logic_vector(62 downto 0);
             Cin : in  std_logic;
             R : out  std_logic_vector(62 downto 0)   );
   end component;

   component IntAdder_63_F0_uid110 is
      port ( X : in  std_logic_vector(62 downto 0);
             Y : in  std_logic_vector(62 downto 0);
             Cin : in  std_logic;
             R : out  std_logic_vector(62 downto 0)   );
   end component;

   component IntAdder_63_F0_uid112 is
      port ( X : in  std_logic_vector(62 downto 0);
             Y : in  std_logic_vector(62 downto 0);
             Cin : in  std_logic;
             R : out  std_logic_vector(62 downto 0)   );
   end component;

   component IntAdder_63_F0_uid114 is
      port ( X : in  std_logic_vector(62 downto 0);
             Y : in  std_logic_vector(62 downto 0);
             Cin : in  std_logic;
             R : out  std_logic_vector(62 downto 0)   );
   end component;

   component IntAdder_63_F0_uid116 is
      port ( X : in  std_logic_vector(62 downto 0);
             Y : in  std_logic_vector(62 downto 0);
             Cin : in  std_logic;
             R : out  std_logic_vector(62 downto 0)   );
   end component;

   component IntAdder_63_F0_uid118 is
      port ( X : in  std_logic_vector(62 downto 0);
             Y : in  std_logic_vector(62 downto 0);
             Cin : in  std_logic;
             R : out  std_logic_vector(62 downto 0)   );
   end component;

   component IntAdder_63_F0_uid120 is
      port ( X : in  std_logic_vector(62 downto 0);
             Y : in  std_logic_vector(62 downto 0);
             Cin : in  std_logic;
             R : out  std_logic_vector(62 downto 0)   );
   end component;

   component IntAdder_63_F0_uid122 is
      port ( X : in  std_logic_vector(62 downto 0);
             Y : in  std_logic_vector(62 downto 0);
             Cin : in  std_logic;
             R : out  std_logic_vector(62 downto 0)   );
   end component;

   component IntAdder_63_F0_uid124 is
      port ( X : in  std_logic_vector(62 downto 0);
             Y : in  std_logic_vector(62 downto 0);
             Cin : in  std_logic;
             R : out  std_logic_vector(62 downto 0)   );
   end component;

   component IntAdder_63_F0_uid126 is
      port ( X : in  std_logic_vector(62 downto 0);
             Y : in  std_logic_vector(62 downto 0);
             Cin : in  std_logic;
             R : out  std_logic_vector(62 downto 0)   );
   end component;

   component IntAdder_63_F0_uid128 is
      port ( X : in  std_logic_vector(62 downto 0);
             Y : in  std_logic_vector(62 downto 0);
             Cin : in  std_logic;
             R : out  std_logic_vector(62 downto 0)   );
   end component;

   component IntAdder_63_F0_uid130 is
      port ( X : in  std_logic_vector(62 downto 0);
             Y : in  std_logic_vector(62 downto 0);
             Cin : in  std_logic;
             R : out  std_logic_vector(62 downto 0)   );
   end component;

   component PositFastEncoder_64_2_F0_uid132 is
      port ( Sign : in  std_logic;
             SF : in  std_logic_vector(9 downto 0);
             Frac : in  std_logic_vector(58 downto 0);
             Guard : in  std_logic;
             Sticky : in  std_logic;
             NZN : in  std_logic;
             R : out  std_logic_vector(63 downto 0)   );
   end component;

signal X_sgn :  std_logic;
signal X_sf :  std_logic_vector(8 downto 0);
signal X_f :  std_logic_vector(58 downto 0);
signal X_nzn :  std_logic;
signal XY_nzn :  std_logic;
signal XY_finalSgn :  std_logic;
signal odd_exp :  std_logic;
signal X_sf_3 :  std_logic_vector(9 downto 0);
signal one_bit :  std_logic;
signal r_0 :  std_logic_vector(62 downto 0);
signal q_0 :  std_logic_vector(61 downto 0);
signal real_q_0 :  std_logic_vector(61 downto 0);
signal pow_2_0 :  std_logic_vector(62 downto 0);
signal s_0 :  std_logic;
signal q_1 :  std_logic_vector(61 downto 0);
signal real_q_1 :  std_logic_vector(61 downto 0);
signal two_r_0 :  std_logic_vector(62 downto 0);
signal two_q_0 :  std_logic_vector(62 downto 0);
signal pow_2_1 :  std_logic_vector(62 downto 0);
signal n_0 :  std_logic_vector(62 downto 0);
signal r_1 :  std_logic_vector(62 downto 0);
signal rem_z_0 :  std_logic;
signal z_1 :  std_logic;
signal s_1 :  std_logic;
signal q_2 :  std_logic_vector(61 downto 0);
signal real_q_2 :  std_logic_vector(61 downto 0);
signal two_r_1 :  std_logic_vector(62 downto 0);
signal two_q_1 :  std_logic_vector(62 downto 0);
signal pow_2_2 :  std_logic_vector(62 downto 0);
signal n_1 :  std_logic_vector(62 downto 0);
signal r_2 :  std_logic_vector(62 downto 0);
signal rem_z_1 :  std_logic;
signal z_2 :  std_logic;
signal s_2 :  std_logic;
signal q_3 :  std_logic_vector(61 downto 0);
signal real_q_3 :  std_logic_vector(61 downto 0);
signal two_r_2 :  std_logic_vector(62 downto 0);
signal two_q_2 :  std_logic_vector(62 downto 0);
signal pow_2_3 :  std_logic_vector(62 downto 0);
signal n_2 :  std_logic_vector(62 downto 0);
signal r_3 :  std_logic_vector(62 downto 0);
signal rem_z_2 :  std_logic;
signal z_3 :  std_logic;
signal s_3 :  std_logic;
signal q_4 :  std_logic_vector(61 downto 0);
signal real_q_4 :  std_logic_vector(61 downto 0);
signal two_r_3 :  std_logic_vector(62 downto 0);
signal two_q_3 :  std_logic_vector(62 downto 0);
signal pow_2_4 :  std_logic_vector(62 downto 0);
signal n_3 :  std_logic_vector(62 downto 0);
signal r_4 :  std_logic_vector(62 downto 0);
signal rem_z_3 :  std_logic;
signal z_4 :  std_logic;
signal s_4 :  std_logic;
signal q_5 :  std_logic_vector(61 downto 0);
signal real_q_5 :  std_logic_vector(61 downto 0);
signal two_r_4 :  std_logic_vector(62 downto 0);
signal two_q_4 :  std_logic_vector(62 downto 0);
signal pow_2_5 :  std_logic_vector(62 downto 0);
signal n_4 :  std_logic_vector(62 downto 0);
signal r_5 :  std_logic_vector(62 downto 0);
signal rem_z_4 :  std_logic;
signal z_5 :  std_logic;
signal s_5 :  std_logic;
signal q_6 :  std_logic_vector(61 downto 0);
signal real_q_6 :  std_logic_vector(61 downto 0);
signal two_r_5 :  std_logic_vector(62 downto 0);
signal two_q_5 :  std_logic_vector(62 downto 0);
signal pow_2_6 :  std_logic_vector(62 downto 0);
signal n_5 :  std_logic_vector(62 downto 0);
signal r_6 :  std_logic_vector(62 downto 0);
signal rem_z_5 :  std_logic;
signal z_6 :  std_logic;
signal s_6 :  std_logic;
signal q_7 :  std_logic_vector(61 downto 0);
signal real_q_7 :  std_logic_vector(61 downto 0);
signal two_r_6 :  std_logic_vector(62 downto 0);
signal two_q_6 :  std_logic_vector(62 downto 0);
signal pow_2_7 :  std_logic_vector(62 downto 0);
signal n_6 :  std_logic_vector(62 downto 0);
signal r_7 :  std_logic_vector(62 downto 0);
signal rem_z_6 :  std_logic;
signal z_7 :  std_logic;
signal s_7 :  std_logic;
signal q_8 :  std_logic_vector(61 downto 0);
signal real_q_8 :  std_logic_vector(61 downto 0);
signal two_r_7 :  std_logic_vector(62 downto 0);
signal two_q_7 :  std_logic_vector(62 downto 0);
signal pow_2_8 :  std_logic_vector(62 downto 0);
signal n_7 :  std_logic_vector(62 downto 0);
signal r_8 :  std_logic_vector(62 downto 0);
signal rem_z_7 :  std_logic;
signal z_8 :  std_logic;
signal s_8 :  std_logic;
signal q_9 :  std_logic_vector(61 downto 0);
signal real_q_9 :  std_logic_vector(61 downto 0);
signal two_r_8 :  std_logic_vector(62 downto 0);
signal two_q_8 :  std_logic_vector(62 downto 0);
signal pow_2_9 :  std_logic_vector(62 downto 0);
signal n_8 :  std_logic_vector(62 downto 0);
signal r_9 :  std_logic_vector(62 downto 0);
signal rem_z_8 :  std_logic;
signal z_9 :  std_logic;
signal s_9 :  std_logic;
signal q_10 :  std_logic_vector(61 downto 0);
signal real_q_10 :  std_logic_vector(61 downto 0);
signal two_r_9 :  std_logic_vector(62 downto 0);
signal two_q_9 :  std_logic_vector(62 downto 0);
signal pow_2_10 :  std_logic_vector(62 downto 0);
signal n_9 :  std_logic_vector(62 downto 0);
signal r_10 :  std_logic_vector(62 downto 0);
signal rem_z_9 :  std_logic;
signal z_10 :  std_logic;
signal s_10 :  std_logic;
signal q_11 :  std_logic_vector(61 downto 0);
signal real_q_11 :  std_logic_vector(61 downto 0);
signal two_r_10 :  std_logic_vector(62 downto 0);
signal two_q_10 :  std_logic_vector(62 downto 0);
signal pow_2_11 :  std_logic_vector(62 downto 0);
signal n_10 :  std_logic_vector(62 downto 0);
signal r_11 :  std_logic_vector(62 downto 0);
signal rem_z_10 :  std_logic;
signal z_11 :  std_logic;
signal s_11 :  std_logic;
signal q_12 :  std_logic_vector(61 downto 0);
signal real_q_12 :  std_logic_vector(61 downto 0);
signal two_r_11 :  std_logic_vector(62 downto 0);
signal two_q_11 :  std_logic_vector(62 downto 0);
signal pow_2_12 :  std_logic_vector(62 downto 0);
signal n_11 :  std_logic_vector(62 downto 0);
signal r_12 :  std_logic_vector(62 downto 0);
signal rem_z_11 :  std_logic;
signal z_12 :  std_logic;
signal s_12 :  std_logic;
signal q_13 :  std_logic_vector(61 downto 0);
signal real_q_13 :  std_logic_vector(61 downto 0);
signal two_r_12 :  std_logic_vector(62 downto 0);
signal two_q_12 :  std_logic_vector(62 downto 0);
signal pow_2_13 :  std_logic_vector(62 downto 0);
signal n_12 :  std_logic_vector(62 downto 0);
signal r_13 :  std_logic_vector(62 downto 0);
signal rem_z_12 :  std_logic;
signal z_13 :  std_logic;
signal s_13 :  std_logic;
signal q_14 :  std_logic_vector(61 downto 0);
signal real_q_14 :  std_logic_vector(61 downto 0);
signal two_r_13 :  std_logic_vector(62 downto 0);
signal two_q_13 :  std_logic_vector(62 downto 0);
signal pow_2_14 :  std_logic_vector(62 downto 0);
signal n_13 :  std_logic_vector(62 downto 0);
signal r_14 :  std_logic_vector(62 downto 0);
signal rem_z_13 :  std_logic;
signal z_14 :  std_logic;
signal s_14 :  std_logic;
signal q_15 :  std_logic_vector(61 downto 0);
signal real_q_15 :  std_logic_vector(61 downto 0);
signal two_r_14 :  std_logic_vector(62 downto 0);
signal two_q_14 :  std_logic_vector(62 downto 0);
signal pow_2_15 :  std_logic_vector(62 downto 0);
signal n_14 :  std_logic_vector(62 downto 0);
signal r_15 :  std_logic_vector(62 downto 0);
signal rem_z_14 :  std_logic;
signal z_15 :  std_logic;
signal s_15 :  std_logic;
signal q_16 :  std_logic_vector(61 downto 0);
signal real_q_16 :  std_logic_vector(61 downto 0);
signal two_r_15 :  std_logic_vector(62 downto 0);
signal two_q_15 :  std_logic_vector(62 downto 0);
signal pow_2_16 :  std_logic_vector(62 downto 0);
signal n_15 :  std_logic_vector(62 downto 0);
signal r_16 :  std_logic_vector(62 downto 0);
signal rem_z_15 :  std_logic;
signal z_16 :  std_logic;
signal s_16 :  std_logic;
signal q_17 :  std_logic_vector(61 downto 0);
signal real_q_17 :  std_logic_vector(61 downto 0);
signal two_r_16 :  std_logic_vector(62 downto 0);
signal two_q_16 :  std_logic_vector(62 downto 0);
signal pow_2_17 :  std_logic_vector(62 downto 0);
signal n_16 :  std_logic_vector(62 downto 0);
signal r_17 :  std_logic_vector(62 downto 0);
signal rem_z_16 :  std_logic;
signal z_17 :  std_logic;
signal s_17 :  std_logic;
signal q_18 :  std_logic_vector(61 downto 0);
signal real_q_18 :  std_logic_vector(61 downto 0);
signal two_r_17 :  std_logic_vector(62 downto 0);
signal two_q_17 :  std_logic_vector(62 downto 0);
signal pow_2_18 :  std_logic_vector(62 downto 0);
signal n_17 :  std_logic_vector(62 downto 0);
signal r_18 :  std_logic_vector(62 downto 0);
signal rem_z_17 :  std_logic;
signal z_18 :  std_logic;
signal s_18 :  std_logic;
signal q_19 :  std_logic_vector(61 downto 0);
signal real_q_19 :  std_logic_vector(61 downto 0);
signal two_r_18 :  std_logic_vector(62 downto 0);
signal two_q_18 :  std_logic_vector(62 downto 0);
signal pow_2_19 :  std_logic_vector(62 downto 0);
signal n_18 :  std_logic_vector(62 downto 0);
signal r_19 :  std_logic_vector(62 downto 0);
signal rem_z_18 :  std_logic;
signal z_19 :  std_logic;
signal s_19 :  std_logic;
signal q_20 :  std_logic_vector(61 downto 0);
signal real_q_20 :  std_logic_vector(61 downto 0);
signal two_r_19 :  std_logic_vector(62 downto 0);
signal two_q_19 :  std_logic_vector(62 downto 0);
signal pow_2_20 :  std_logic_vector(62 downto 0);
signal n_19 :  std_logic_vector(62 downto 0);
signal r_20 :  std_logic_vector(62 downto 0);
signal rem_z_19 :  std_logic;
signal z_20 :  std_logic;
signal s_20 :  std_logic;
signal q_21 :  std_logic_vector(61 downto 0);
signal real_q_21 :  std_logic_vector(61 downto 0);
signal two_r_20 :  std_logic_vector(62 downto 0);
signal two_q_20 :  std_logic_vector(62 downto 0);
signal pow_2_21 :  std_logic_vector(62 downto 0);
signal n_20 :  std_logic_vector(62 downto 0);
signal r_21 :  std_logic_vector(62 downto 0);
signal rem_z_20 :  std_logic;
signal z_21 :  std_logic;
signal s_21 :  std_logic;
signal q_22 :  std_logic_vector(61 downto 0);
signal real_q_22 :  std_logic_vector(61 downto 0);
signal two_r_21 :  std_logic_vector(62 downto 0);
signal two_q_21 :  std_logic_vector(62 downto 0);
signal pow_2_22 :  std_logic_vector(62 downto 0);
signal n_21 :  std_logic_vector(62 downto 0);
signal r_22 :  std_logic_vector(62 downto 0);
signal rem_z_21 :  std_logic;
signal z_22 :  std_logic;
signal s_22 :  std_logic;
signal q_23 :  std_logic_vector(61 downto 0);
signal real_q_23 :  std_logic_vector(61 downto 0);
signal two_r_22 :  std_logic_vector(62 downto 0);
signal two_q_22 :  std_logic_vector(62 downto 0);
signal pow_2_23 :  std_logic_vector(62 downto 0);
signal n_22 :  std_logic_vector(62 downto 0);
signal r_23 :  std_logic_vector(62 downto 0);
signal rem_z_22 :  std_logic;
signal z_23 :  std_logic;
signal s_23 :  std_logic;
signal q_24 :  std_logic_vector(61 downto 0);
signal real_q_24 :  std_logic_vector(61 downto 0);
signal two_r_23 :  std_logic_vector(62 downto 0);
signal two_q_23 :  std_logic_vector(62 downto 0);
signal pow_2_24 :  std_logic_vector(62 downto 0);
signal n_23 :  std_logic_vector(62 downto 0);
signal r_24 :  std_logic_vector(62 downto 0);
signal rem_z_23 :  std_logic;
signal z_24 :  std_logic;
signal s_24 :  std_logic;
signal q_25 :  std_logic_vector(61 downto 0);
signal real_q_25 :  std_logic_vector(61 downto 0);
signal two_r_24 :  std_logic_vector(62 downto 0);
signal two_q_24 :  std_logic_vector(62 downto 0);
signal pow_2_25 :  std_logic_vector(62 downto 0);
signal n_24 :  std_logic_vector(62 downto 0);
signal r_25 :  std_logic_vector(62 downto 0);
signal rem_z_24 :  std_logic;
signal z_25 :  std_logic;
signal s_25 :  std_logic;
signal q_26 :  std_logic_vector(61 downto 0);
signal real_q_26 :  std_logic_vector(61 downto 0);
signal two_r_25 :  std_logic_vector(62 downto 0);
signal two_q_25 :  std_logic_vector(62 downto 0);
signal pow_2_26 :  std_logic_vector(62 downto 0);
signal n_25 :  std_logic_vector(62 downto 0);
signal r_26 :  std_logic_vector(62 downto 0);
signal rem_z_25 :  std_logic;
signal z_26 :  std_logic;
signal s_26 :  std_logic;
signal q_27 :  std_logic_vector(61 downto 0);
signal real_q_27 :  std_logic_vector(61 downto 0);
signal two_r_26 :  std_logic_vector(62 downto 0);
signal two_q_26 :  std_logic_vector(62 downto 0);
signal pow_2_27 :  std_logic_vector(62 downto 0);
signal n_26 :  std_logic_vector(62 downto 0);
signal r_27 :  std_logic_vector(62 downto 0);
signal rem_z_26 :  std_logic;
signal z_27 :  std_logic;
signal s_27 :  std_logic;
signal q_28 :  std_logic_vector(61 downto 0);
signal real_q_28 :  std_logic_vector(61 downto 0);
signal two_r_27 :  std_logic_vector(62 downto 0);
signal two_q_27 :  std_logic_vector(62 downto 0);
signal pow_2_28 :  std_logic_vector(62 downto 0);
signal n_27 :  std_logic_vector(62 downto 0);
signal r_28 :  std_logic_vector(62 downto 0);
signal rem_z_27 :  std_logic;
signal z_28 :  std_logic;
signal s_28 :  std_logic;
signal q_29 :  std_logic_vector(61 downto 0);
signal real_q_29 :  std_logic_vector(61 downto 0);
signal two_r_28 :  std_logic_vector(62 downto 0);
signal two_q_28 :  std_logic_vector(62 downto 0);
signal pow_2_29 :  std_logic_vector(62 downto 0);
signal n_28 :  std_logic_vector(62 downto 0);
signal r_29 :  std_logic_vector(62 downto 0);
signal rem_z_28 :  std_logic;
signal z_29 :  std_logic;
signal s_29 :  std_logic;
signal q_30 :  std_logic_vector(61 downto 0);
signal real_q_30 :  std_logic_vector(61 downto 0);
signal two_r_29 :  std_logic_vector(62 downto 0);
signal two_q_29 :  std_logic_vector(62 downto 0);
signal pow_2_30 :  std_logic_vector(62 downto 0);
signal n_29 :  std_logic_vector(62 downto 0);
signal r_30 :  std_logic_vector(62 downto 0);
signal rem_z_29 :  std_logic;
signal z_30 :  std_logic;
signal s_30 :  std_logic;
signal q_31 :  std_logic_vector(61 downto 0);
signal real_q_31 :  std_logic_vector(61 downto 0);
signal two_r_30 :  std_logic_vector(62 downto 0);
signal two_q_30 :  std_logic_vector(62 downto 0);
signal pow_2_31 :  std_logic_vector(62 downto 0);
signal n_30 :  std_logic_vector(62 downto 0);
signal r_31 :  std_logic_vector(62 downto 0);
signal rem_z_30 :  std_logic;
signal z_31 :  std_logic;
signal s_31 :  std_logic;
signal q_32 :  std_logic_vector(61 downto 0);
signal real_q_32 :  std_logic_vector(61 downto 0);
signal two_r_31 :  std_logic_vector(62 downto 0);
signal two_q_31 :  std_logic_vector(62 downto 0);
signal pow_2_32 :  std_logic_vector(62 downto 0);
signal n_31 :  std_logic_vector(62 downto 0);
signal r_32 :  std_logic_vector(62 downto 0);
signal rem_z_31 :  std_logic;
signal z_32 :  std_logic;
signal s_32 :  std_logic;
signal q_33 :  std_logic_vector(61 downto 0);
signal real_q_33 :  std_logic_vector(61 downto 0);
signal two_r_32 :  std_logic_vector(62 downto 0);
signal two_q_32 :  std_logic_vector(62 downto 0);
signal pow_2_33 :  std_logic_vector(62 downto 0);
signal n_32 :  std_logic_vector(62 downto 0);
signal r_33 :  std_logic_vector(62 downto 0);
signal rem_z_32 :  std_logic;
signal z_33 :  std_logic;
signal s_33 :  std_logic;
signal q_34 :  std_logic_vector(61 downto 0);
signal real_q_34 :  std_logic_vector(61 downto 0);
signal two_r_33 :  std_logic_vector(62 downto 0);
signal two_q_33 :  std_logic_vector(62 downto 0);
signal pow_2_34 :  std_logic_vector(62 downto 0);
signal n_33 :  std_logic_vector(62 downto 0);
signal r_34 :  std_logic_vector(62 downto 0);
signal rem_z_33 :  std_logic;
signal z_34 :  std_logic;
signal s_34 :  std_logic;
signal q_35 :  std_logic_vector(61 downto 0);
signal real_q_35 :  std_logic_vector(61 downto 0);
signal two_r_34 :  std_logic_vector(62 downto 0);
signal two_q_34 :  std_logic_vector(62 downto 0);
signal pow_2_35 :  std_logic_vector(62 downto 0);
signal n_34 :  std_logic_vector(62 downto 0);
signal r_35 :  std_logic_vector(62 downto 0);
signal rem_z_34 :  std_logic;
signal z_35 :  std_logic;
signal s_35 :  std_logic;
signal q_36 :  std_logic_vector(61 downto 0);
signal real_q_36 :  std_logic_vector(61 downto 0);
signal two_r_35 :  std_logic_vector(62 downto 0);
signal two_q_35 :  std_logic_vector(62 downto 0);
signal pow_2_36 :  std_logic_vector(62 downto 0);
signal n_35 :  std_logic_vector(62 downto 0);
signal r_36 :  std_logic_vector(62 downto 0);
signal rem_z_35 :  std_logic;
signal z_36 :  std_logic;
signal s_36 :  std_logic;
signal q_37 :  std_logic_vector(61 downto 0);
signal real_q_37 :  std_logic_vector(61 downto 0);
signal two_r_36 :  std_logic_vector(62 downto 0);
signal two_q_36 :  std_logic_vector(62 downto 0);
signal pow_2_37 :  std_logic_vector(62 downto 0);
signal n_36 :  std_logic_vector(62 downto 0);
signal r_37 :  std_logic_vector(62 downto 0);
signal rem_z_36 :  std_logic;
signal z_37 :  std_logic;
signal s_37 :  std_logic;
signal q_38 :  std_logic_vector(61 downto 0);
signal real_q_38 :  std_logic_vector(61 downto 0);
signal two_r_37 :  std_logic_vector(62 downto 0);
signal two_q_37 :  std_logic_vector(62 downto 0);
signal pow_2_38 :  std_logic_vector(62 downto 0);
signal n_37 :  std_logic_vector(62 downto 0);
signal r_38 :  std_logic_vector(62 downto 0);
signal rem_z_37 :  std_logic;
signal z_38 :  std_logic;
signal s_38 :  std_logic;
signal q_39 :  std_logic_vector(61 downto 0);
signal real_q_39 :  std_logic_vector(61 downto 0);
signal two_r_38 :  std_logic_vector(62 downto 0);
signal two_q_38 :  std_logic_vector(62 downto 0);
signal pow_2_39 :  std_logic_vector(62 downto 0);
signal n_38 :  std_logic_vector(62 downto 0);
signal r_39 :  std_logic_vector(62 downto 0);
signal rem_z_38 :  std_logic;
signal z_39 :  std_logic;
signal s_39 :  std_logic;
signal q_40 :  std_logic_vector(61 downto 0);
signal real_q_40 :  std_logic_vector(61 downto 0);
signal two_r_39 :  std_logic_vector(62 downto 0);
signal two_q_39 :  std_logic_vector(62 downto 0);
signal pow_2_40 :  std_logic_vector(62 downto 0);
signal n_39 :  std_logic_vector(62 downto 0);
signal r_40 :  std_logic_vector(62 downto 0);
signal rem_z_39 :  std_logic;
signal z_40 :  std_logic;
signal s_40 :  std_logic;
signal q_41 :  std_logic_vector(61 downto 0);
signal real_q_41 :  std_logic_vector(61 downto 0);
signal two_r_40 :  std_logic_vector(62 downto 0);
signal two_q_40 :  std_logic_vector(62 downto 0);
signal pow_2_41 :  std_logic_vector(62 downto 0);
signal n_40 :  std_logic_vector(62 downto 0);
signal r_41 :  std_logic_vector(62 downto 0);
signal rem_z_40 :  std_logic;
signal z_41 :  std_logic;
signal s_41 :  std_logic;
signal q_42 :  std_logic_vector(61 downto 0);
signal real_q_42 :  std_logic_vector(61 downto 0);
signal two_r_41 :  std_logic_vector(62 downto 0);
signal two_q_41 :  std_logic_vector(62 downto 0);
signal pow_2_42 :  std_logic_vector(62 downto 0);
signal n_41 :  std_logic_vector(62 downto 0);
signal r_42 :  std_logic_vector(62 downto 0);
signal rem_z_41 :  std_logic;
signal z_42 :  std_logic;
signal s_42 :  std_logic;
signal q_43 :  std_logic_vector(61 downto 0);
signal real_q_43 :  std_logic_vector(61 downto 0);
signal two_r_42 :  std_logic_vector(62 downto 0);
signal two_q_42 :  std_logic_vector(62 downto 0);
signal pow_2_43 :  std_logic_vector(62 downto 0);
signal n_42 :  std_logic_vector(62 downto 0);
signal r_43 :  std_logic_vector(62 downto 0);
signal rem_z_42 :  std_logic;
signal z_43 :  std_logic;
signal s_43 :  std_logic;
signal q_44 :  std_logic_vector(61 downto 0);
signal real_q_44 :  std_logic_vector(61 downto 0);
signal two_r_43 :  std_logic_vector(62 downto 0);
signal two_q_43 :  std_logic_vector(62 downto 0);
signal pow_2_44 :  std_logic_vector(62 downto 0);
signal n_43 :  std_logic_vector(62 downto 0);
signal r_44 :  std_logic_vector(62 downto 0);
signal rem_z_43 :  std_logic;
signal z_44 :  std_logic;
signal s_44 :  std_logic;
signal q_45 :  std_logic_vector(61 downto 0);
signal real_q_45 :  std_logic_vector(61 downto 0);
signal two_r_44 :  std_logic_vector(62 downto 0);
signal two_q_44 :  std_logic_vector(62 downto 0);
signal pow_2_45 :  std_logic_vector(62 downto 0);
signal n_44 :  std_logic_vector(62 downto 0);
signal r_45 :  std_logic_vector(62 downto 0);
signal rem_z_44 :  std_logic;
signal z_45 :  std_logic;
signal s_45 :  std_logic;
signal q_46 :  std_logic_vector(61 downto 0);
signal real_q_46 :  std_logic_vector(61 downto 0);
signal two_r_45 :  std_logic_vector(62 downto 0);
signal two_q_45 :  std_logic_vector(62 downto 0);
signal pow_2_46 :  std_logic_vector(62 downto 0);
signal n_45 :  std_logic_vector(62 downto 0);
signal r_46 :  std_logic_vector(62 downto 0);
signal rem_z_45 :  std_logic;
signal z_46 :  std_logic;
signal s_46 :  std_logic;
signal q_47 :  std_logic_vector(61 downto 0);
signal real_q_47 :  std_logic_vector(61 downto 0);
signal two_r_46 :  std_logic_vector(62 downto 0);
signal two_q_46 :  std_logic_vector(62 downto 0);
signal pow_2_47 :  std_logic_vector(62 downto 0);
signal n_46 :  std_logic_vector(62 downto 0);
signal r_47 :  std_logic_vector(62 downto 0);
signal rem_z_46 :  std_logic;
signal z_47 :  std_logic;
signal s_47 :  std_logic;
signal q_48 :  std_logic_vector(61 downto 0);
signal real_q_48 :  std_logic_vector(61 downto 0);
signal two_r_47 :  std_logic_vector(62 downto 0);
signal two_q_47 :  std_logic_vector(62 downto 0);
signal pow_2_48 :  std_logic_vector(62 downto 0);
signal n_47 :  std_logic_vector(62 downto 0);
signal r_48 :  std_logic_vector(62 downto 0);
signal rem_z_47 :  std_logic;
signal z_48 :  std_logic;
signal s_48 :  std_logic;
signal q_49 :  std_logic_vector(61 downto 0);
signal real_q_49 :  std_logic_vector(61 downto 0);
signal two_r_48 :  std_logic_vector(62 downto 0);
signal two_q_48 :  std_logic_vector(62 downto 0);
signal pow_2_49 :  std_logic_vector(62 downto 0);
signal n_48 :  std_logic_vector(62 downto 0);
signal r_49 :  std_logic_vector(62 downto 0);
signal rem_z_48 :  std_logic;
signal z_49 :  std_logic;
signal s_49 :  std_logic;
signal q_50 :  std_logic_vector(61 downto 0);
signal real_q_50 :  std_logic_vector(61 downto 0);
signal two_r_49 :  std_logic_vector(62 downto 0);
signal two_q_49 :  std_logic_vector(62 downto 0);
signal pow_2_50 :  std_logic_vector(62 downto 0);
signal n_49 :  std_logic_vector(62 downto 0);
signal r_50 :  std_logic_vector(62 downto 0);
signal rem_z_49 :  std_logic;
signal z_50 :  std_logic;
signal s_50 :  std_logic;
signal q_51 :  std_logic_vector(61 downto 0);
signal real_q_51 :  std_logic_vector(61 downto 0);
signal two_r_50 :  std_logic_vector(62 downto 0);
signal two_q_50 :  std_logic_vector(62 downto 0);
signal pow_2_51 :  std_logic_vector(62 downto 0);
signal n_50 :  std_logic_vector(62 downto 0);
signal r_51 :  std_logic_vector(62 downto 0);
signal rem_z_50 :  std_logic;
signal z_51 :  std_logic;
signal s_51 :  std_logic;
signal q_52 :  std_logic_vector(61 downto 0);
signal real_q_52 :  std_logic_vector(61 downto 0);
signal two_r_51 :  std_logic_vector(62 downto 0);
signal two_q_51 :  std_logic_vector(62 downto 0);
signal pow_2_52 :  std_logic_vector(62 downto 0);
signal n_51 :  std_logic_vector(62 downto 0);
signal r_52 :  std_logic_vector(62 downto 0);
signal rem_z_51 :  std_logic;
signal z_52 :  std_logic;
signal s_52 :  std_logic;
signal q_53 :  std_logic_vector(61 downto 0);
signal real_q_53 :  std_logic_vector(61 downto 0);
signal two_r_52 :  std_logic_vector(62 downto 0);
signal two_q_52 :  std_logic_vector(62 downto 0);
signal pow_2_53 :  std_logic_vector(62 downto 0);
signal n_52 :  std_logic_vector(62 downto 0);
signal r_53 :  std_logic_vector(62 downto 0);
signal rem_z_52 :  std_logic;
signal z_53 :  std_logic;
signal s_53 :  std_logic;
signal q_54 :  std_logic_vector(61 downto 0);
signal real_q_54 :  std_logic_vector(61 downto 0);
signal two_r_53 :  std_logic_vector(62 downto 0);
signal two_q_53 :  std_logic_vector(62 downto 0);
signal pow_2_54 :  std_logic_vector(62 downto 0);
signal n_53 :  std_logic_vector(62 downto 0);
signal r_54 :  std_logic_vector(62 downto 0);
signal rem_z_53 :  std_logic;
signal z_54 :  std_logic;
signal s_54 :  std_logic;
signal q_55 :  std_logic_vector(61 downto 0);
signal real_q_55 :  std_logic_vector(61 downto 0);
signal two_r_54 :  std_logic_vector(62 downto 0);
signal two_q_54 :  std_logic_vector(62 downto 0);
signal pow_2_55 :  std_logic_vector(62 downto 0);
signal n_54 :  std_logic_vector(62 downto 0);
signal r_55 :  std_logic_vector(62 downto 0);
signal rem_z_54 :  std_logic;
signal z_55 :  std_logic;
signal s_55 :  std_logic;
signal q_56 :  std_logic_vector(61 downto 0);
signal real_q_56 :  std_logic_vector(61 downto 0);
signal two_r_55 :  std_logic_vector(62 downto 0);
signal two_q_55 :  std_logic_vector(62 downto 0);
signal pow_2_56 :  std_logic_vector(62 downto 0);
signal n_55 :  std_logic_vector(62 downto 0);
signal r_56 :  std_logic_vector(62 downto 0);
signal rem_z_55 :  std_logic;
signal z_56 :  std_logic;
signal s_56 :  std_logic;
signal q_57 :  std_logic_vector(61 downto 0);
signal real_q_57 :  std_logic_vector(61 downto 0);
signal two_r_56 :  std_logic_vector(62 downto 0);
signal two_q_56 :  std_logic_vector(62 downto 0);
signal pow_2_57 :  std_logic_vector(62 downto 0);
signal n_56 :  std_logic_vector(62 downto 0);
signal r_57 :  std_logic_vector(62 downto 0);
signal rem_z_56 :  std_logic;
signal z_57 :  std_logic;
signal s_57 :  std_logic;
signal q_58 :  std_logic_vector(61 downto 0);
signal real_q_58 :  std_logic_vector(61 downto 0);
signal two_r_57 :  std_logic_vector(62 downto 0);
signal two_q_57 :  std_logic_vector(62 downto 0);
signal pow_2_58 :  std_logic_vector(62 downto 0);
signal n_57 :  std_logic_vector(62 downto 0);
signal r_58 :  std_logic_vector(62 downto 0);
signal rem_z_57 :  std_logic;
signal z_58 :  std_logic;
signal s_58 :  std_logic;
signal q_59 :  std_logic_vector(61 downto 0);
signal real_q_59 :  std_logic_vector(61 downto 0);
signal two_r_58 :  std_logic_vector(62 downto 0);
signal two_q_58 :  std_logic_vector(62 downto 0);
signal pow_2_59 :  std_logic_vector(62 downto 0);
signal n_58 :  std_logic_vector(62 downto 0);
signal r_59 :  std_logic_vector(62 downto 0);
signal rem_z_58 :  std_logic;
signal z_59 :  std_logic;
signal s_59 :  std_logic;
signal q_60 :  std_logic_vector(61 downto 0);
signal real_q_60 :  std_logic_vector(61 downto 0);
signal two_r_59 :  std_logic_vector(62 downto 0);
signal two_q_59 :  std_logic_vector(62 downto 0);
signal pow_2_60 :  std_logic_vector(62 downto 0);
signal n_59 :  std_logic_vector(62 downto 0);
signal r_60 :  std_logic_vector(62 downto 0);
signal rem_z_59 :  std_logic;
signal z_60 :  std_logic;
signal s_60 :  std_logic;
signal q_61 :  std_logic_vector(61 downto 0);
signal real_q_61 :  std_logic_vector(61 downto 0);
signal two_r_60 :  std_logic_vector(62 downto 0);
signal two_q_60 :  std_logic_vector(62 downto 0);
signal pow_2_61 :  std_logic_vector(62 downto 0);
signal n_60 :  std_logic_vector(62 downto 0);
signal r_61 :  std_logic_vector(62 downto 0);
signal rem_z_60 :  std_logic;
signal z_61 :  std_logic;
signal s_61 :  std_logic;
signal q_62 :  std_logic_vector(61 downto 0);
signal real_q_62 :  std_logic_vector(61 downto 0);
signal two_r_61 :  std_logic_vector(62 downto 0);
signal two_q_61 :  std_logic_vector(62 downto 0);
signal pow_2_62 :  std_logic_vector(62 downto 0);
signal n_61 :  std_logic_vector(62 downto 0);
signal r_62 :  std_logic_vector(62 downto 0);
signal rem_z_61 :  std_logic;
signal z_62 :  std_logic;
signal sqrt_f :  std_logic_vector(61 downto 0);
signal XY_sf :  std_logic_vector(9 downto 0);
signal XY_frac :  std_logic_vector(58 downto 0);
signal grd :  std_logic;
signal stk :  std_logic;
begin
--------------------------- Start of vhdl generation ---------------------------
------------------------------- Decode X operand -------------------------------
   X_decoder: PositFastDecoder_64_2_F0_uid4
      port map ( X => X,
                 Frac => X_f,
                 NZN => X_nzn,
                 SF => X_sf,
                 Sign => X_sgn);
   -- Sign and Special Cases Computation
   XY_nzn <= NOT(X_sgn) AND X_nzn;
   XY_finalSgn <= X_sgn;
----------------------------- Exponent computation -----------------------------
   odd_exp <= X_sf(0);
   -- Divide exponent by 2
   X_sf_3 <= X_sf(X_sf'high) & X_sf(X_sf'high) & X_sf(8 downto 1);
----------------------------- Sqrt of the fraction -----------------------------
--------------------------- Non-Restoring algorithm ---------------------------
   one_bit <= '1';
   r_0 <= ("001" & X_f & '0') when odd_exp='1' else ("0001" & X_f);
   q_0 <= (others => '0');
   real_q_0 <= (others => '0');
   pow_2_0 <= "010000000000000000000000000000000000000000000000000000000000000";
   -- Iteration 1
   s_0 <= r_0(62);
   q_1 <= NOT(s_0) & "0000000000000000000000000000000000000000000000000000000000000";
   real_q_1 <= (s_0) & "0000000000000000000000000000000000000000000000000000000000000";
   two_r_0 <= r_0(61 downto 0) & '0';
   two_q_0 <= (others => '0');
   pow_2_1 <= '0' & pow_2_0(62 downto 1);
   n_0 <= (two_q_0 + NOT(pow_2_1)) when s_0='1' else NOT(two_q_0 + pow_2_1);
   sub_1: IntAdder_63_F0_uid8
      port map ( Cin => one_bit,
                 X => two_r_0,
                 Y => n_0,
                 R => r_1);
   rem_z_0 <= '1' when r_1 = 0 else '0';
   z_1 <= rem_z_0;
   -- Iteration 2
   s_1 <= r_1(62);
   q_2 <= q_1(61 downto 61) & NOT(s_1 OR z_1) & "000000000000000000000000000000000000000000000000000000000000";
   real_q_2 <= q_2(60 downto 60) & '1' & "000000000000000000000000000000000000000000000000000000000000" when z_1='0' else real_q_1;
   two_r_1 <= r_1(61 downto 0) & '0';
   two_q_1 <= '0' & '1' & "0000000000000000000000000000000000000000000000000000000000000";
   pow_2_2 <= '0' & pow_2_1(62 downto 1);
   n_1 <= (two_q_1 + NOT(pow_2_2)) when s_1='1' else NOT(two_q_1 + pow_2_2);
   sub_2: IntAdder_63_F0_uid10
      port map ( Cin => one_bit,
                 X => two_r_1,
                 Y => n_1,
                 R => r_2);
   rem_z_1 <= '1' when r_2 = 0 else '0';
   z_2 <= rem_z_1 OR z_1;
   -- Iteration 3
   s_2 <= r_2(62);
   q_3 <= q_2(61 downto 60) & NOT(s_2 OR z_2) & "00000000000000000000000000000000000000000000000000000000000";
   real_q_3 <= q_3(60 downto 59) & '1' & "00000000000000000000000000000000000000000000000000000000000" when z_2='0' else real_q_2;
   two_r_2 <= r_2(61 downto 0) & '0';
   two_q_2 <= '0' & q_2(60 downto 60) & '1' & "000000000000000000000000000000000000000000000000000000000000";
   pow_2_3 <= '0' & pow_2_2(62 downto 1);
   n_2 <= (two_q_2 + NOT(pow_2_3)) when s_2='1' else NOT(two_q_2 + pow_2_3);
   sub_3: IntAdder_63_F0_uid12
      port map ( Cin => one_bit,
                 X => two_r_2,
                 Y => n_2,
                 R => r_3);
   rem_z_2 <= '1' when r_3 = 0 else '0';
   z_3 <= rem_z_2 OR z_2;
   -- Iteration 4
   s_3 <= r_3(62);
   q_4 <= q_3(61 downto 59) & NOT(s_3 OR z_3) & "0000000000000000000000000000000000000000000000000000000000";
   real_q_4 <= q_4(60 downto 58) & '1' & "0000000000000000000000000000000000000000000000000000000000" when z_3='0' else real_q_3;
   two_r_3 <= r_3(61 downto 0) & '0';
   two_q_3 <= '0' & q_3(60 downto 59) & '1' & "00000000000000000000000000000000000000000000000000000000000";
   pow_2_4 <= '0' & pow_2_3(62 downto 1);
   n_3 <= (two_q_3 + NOT(pow_2_4)) when s_3='1' else NOT(two_q_3 + pow_2_4);
   sub_4: IntAdder_63_F0_uid14
      port map ( Cin => one_bit,
                 X => two_r_3,
                 Y => n_3,
                 R => r_4);
   rem_z_3 <= '1' when r_4 = 0 else '0';
   z_4 <= rem_z_3 OR z_3;
   -- Iteration 5
   s_4 <= r_4(62);
   q_5 <= q_4(61 downto 58) & NOT(s_4 OR z_4) & "000000000000000000000000000000000000000000000000000000000";
   real_q_5 <= q_5(60 downto 57) & '1' & "000000000000000000000000000000000000000000000000000000000" when z_4='0' else real_q_4;
   two_r_4 <= r_4(61 downto 0) & '0';
   two_q_4 <= '0' & q_4(60 downto 58) & '1' & "0000000000000000000000000000000000000000000000000000000000";
   pow_2_5 <= '0' & pow_2_4(62 downto 1);
   n_4 <= (two_q_4 + NOT(pow_2_5)) when s_4='1' else NOT(two_q_4 + pow_2_5);
   sub_5: IntAdder_63_F0_uid16
      port map ( Cin => one_bit,
                 X => two_r_4,
                 Y => n_4,
                 R => r_5);
   rem_z_4 <= '1' when r_5 = 0 else '0';
   z_5 <= rem_z_4 OR z_4;
   -- Iteration 6
   s_5 <= r_5(62);
   q_6 <= q_5(61 downto 57) & NOT(s_5 OR z_5) & "00000000000000000000000000000000000000000000000000000000";
   real_q_6 <= q_6(60 downto 56) & '1' & "00000000000000000000000000000000000000000000000000000000" when z_5='0' else real_q_5;
   two_r_5 <= r_5(61 downto 0) & '0';
   two_q_5 <= '0' & q_5(60 downto 57) & '1' & "000000000000000000000000000000000000000000000000000000000";
   pow_2_6 <= '0' & pow_2_5(62 downto 1);
   n_5 <= (two_q_5 + NOT(pow_2_6)) when s_5='1' else NOT(two_q_5 + pow_2_6);
   sub_6: IntAdder_63_F0_uid18
      port map ( Cin => one_bit,
                 X => two_r_5,
                 Y => n_5,
                 R => r_6);
   rem_z_5 <= '1' when r_6 = 0 else '0';
   z_6 <= rem_z_5 OR z_5;
   -- Iteration 7
   s_6 <= r_6(62);
   q_7 <= q_6(61 downto 56) & NOT(s_6 OR z_6) & "0000000000000000000000000000000000000000000000000000000";
   real_q_7 <= q_7(60 downto 55) & '1' & "0000000000000000000000000000000000000000000000000000000" when z_6='0' else real_q_6;
   two_r_6 <= r_6(61 downto 0) & '0';
   two_q_6 <= '0' & q_6(60 downto 56) & '1' & "00000000000000000000000000000000000000000000000000000000";
   pow_2_7 <= '0' & pow_2_6(62 downto 1);
   n_6 <= (two_q_6 + NOT(pow_2_7)) when s_6='1' else NOT(two_q_6 + pow_2_7);
   sub_7: IntAdder_63_F0_uid20
      port map ( Cin => one_bit,
                 X => two_r_6,
                 Y => n_6,
                 R => r_7);
   rem_z_6 <= '1' when r_7 = 0 else '0';
   z_7 <= rem_z_6 OR z_6;
   -- Iteration 8
   s_7 <= r_7(62);
   q_8 <= q_7(61 downto 55) & NOT(s_7 OR z_7) & "000000000000000000000000000000000000000000000000000000";
   real_q_8 <= q_8(60 downto 54) & '1' & "000000000000000000000000000000000000000000000000000000" when z_7='0' else real_q_7;
   two_r_7 <= r_7(61 downto 0) & '0';
   two_q_7 <= '0' & q_7(60 downto 55) & '1' & "0000000000000000000000000000000000000000000000000000000";
   pow_2_8 <= '0' & pow_2_7(62 downto 1);
   n_7 <= (two_q_7 + NOT(pow_2_8)) when s_7='1' else NOT(two_q_7 + pow_2_8);
   sub_8: IntAdder_63_F0_uid22
      port map ( Cin => one_bit,
                 X => two_r_7,
                 Y => n_7,
                 R => r_8);
   rem_z_7 <= '1' when r_8 = 0 else '0';
   z_8 <= rem_z_7 OR z_7;
   -- Iteration 9
   s_8 <= r_8(62);
   q_9 <= q_8(61 downto 54) & NOT(s_8 OR z_8) & "00000000000000000000000000000000000000000000000000000";
   real_q_9 <= q_9(60 downto 53) & '1' & "00000000000000000000000000000000000000000000000000000" when z_8='0' else real_q_8;
   two_r_8 <= r_8(61 downto 0) & '0';
   two_q_8 <= '0' & q_8(60 downto 54) & '1' & "000000000000000000000000000000000000000000000000000000";
   pow_2_9 <= '0' & pow_2_8(62 downto 1);
   n_8 <= (two_q_8 + NOT(pow_2_9)) when s_8='1' else NOT(two_q_8 + pow_2_9);
   sub_9: IntAdder_63_F0_uid24
      port map ( Cin => one_bit,
                 X => two_r_8,
                 Y => n_8,
                 R => r_9);
   rem_z_8 <= '1' when r_9 = 0 else '0';
   z_9 <= rem_z_8 OR z_8;
   -- Iteration 10
   s_9 <= r_9(62);
   q_10 <= q_9(61 downto 53) & NOT(s_9 OR z_9) & "0000000000000000000000000000000000000000000000000000";
   real_q_10 <= q_10(60 downto 52) & '1' & "0000000000000000000000000000000000000000000000000000" when z_9='0' else real_q_9;
   two_r_9 <= r_9(61 downto 0) & '0';
   two_q_9 <= '0' & q_9(60 downto 53) & '1' & "00000000000000000000000000000000000000000000000000000";
   pow_2_10 <= '0' & pow_2_9(62 downto 1);
   n_9 <= (two_q_9 + NOT(pow_2_10)) when s_9='1' else NOT(two_q_9 + pow_2_10);
   sub_10: IntAdder_63_F0_uid26
      port map ( Cin => one_bit,
                 X => two_r_9,
                 Y => n_9,
                 R => r_10);
   rem_z_9 <= '1' when r_10 = 0 else '0';
   z_10 <= rem_z_9 OR z_9;
   -- Iteration 11
   s_10 <= r_10(62);
   q_11 <= q_10(61 downto 52) & NOT(s_10 OR z_10) & "000000000000000000000000000000000000000000000000000";
   real_q_11 <= q_11(60 downto 51) & '1' & "000000000000000000000000000000000000000000000000000" when z_10='0' else real_q_10;
   two_r_10 <= r_10(61 downto 0) & '0';
   two_q_10 <= '0' & q_10(60 downto 52) & '1' & "0000000000000000000000000000000000000000000000000000";
   pow_2_11 <= '0' & pow_2_10(62 downto 1);
   n_10 <= (two_q_10 + NOT(pow_2_11)) when s_10='1' else NOT(two_q_10 + pow_2_11);
   sub_11: IntAdder_63_F0_uid28
      port map ( Cin => one_bit,
                 X => two_r_10,
                 Y => n_10,
                 R => r_11);
   rem_z_10 <= '1' when r_11 = 0 else '0';
   z_11 <= rem_z_10 OR z_10;
   -- Iteration 12
   s_11 <= r_11(62);
   q_12 <= q_11(61 downto 51) & NOT(s_11 OR z_11) & "00000000000000000000000000000000000000000000000000";
   real_q_12 <= q_12(60 downto 50) & '1' & "00000000000000000000000000000000000000000000000000" when z_11='0' else real_q_11;
   two_r_11 <= r_11(61 downto 0) & '0';
   two_q_11 <= '0' & q_11(60 downto 51) & '1' & "000000000000000000000000000000000000000000000000000";
   pow_2_12 <= '0' & pow_2_11(62 downto 1);
   n_11 <= (two_q_11 + NOT(pow_2_12)) when s_11='1' else NOT(two_q_11 + pow_2_12);
   sub_12: IntAdder_63_F0_uid30
      port map ( Cin => one_bit,
                 X => two_r_11,
                 Y => n_11,
                 R => r_12);
   rem_z_11 <= '1' when r_12 = 0 else '0';
   z_12 <= rem_z_11 OR z_11;
   -- Iteration 13
   s_12 <= r_12(62);
   q_13 <= q_12(61 downto 50) & NOT(s_12 OR z_12) & "0000000000000000000000000000000000000000000000000";
   real_q_13 <= q_13(60 downto 49) & '1' & "0000000000000000000000000000000000000000000000000" when z_12='0' else real_q_12;
   two_r_12 <= r_12(61 downto 0) & '0';
   two_q_12 <= '0' & q_12(60 downto 50) & '1' & "00000000000000000000000000000000000000000000000000";
   pow_2_13 <= '0' & pow_2_12(62 downto 1);
   n_12 <= (two_q_12 + NOT(pow_2_13)) when s_12='1' else NOT(two_q_12 + pow_2_13);
   sub_13: IntAdder_63_F0_uid32
      port map ( Cin => one_bit,
                 X => two_r_12,
                 Y => n_12,
                 R => r_13);
   rem_z_12 <= '1' when r_13 = 0 else '0';
   z_13 <= rem_z_12 OR z_12;
   -- Iteration 14
   s_13 <= r_13(62);
   q_14 <= q_13(61 downto 49) & NOT(s_13 OR z_13) & "000000000000000000000000000000000000000000000000";
   real_q_14 <= q_14(60 downto 48) & '1' & "000000000000000000000000000000000000000000000000" when z_13='0' else real_q_13;
   two_r_13 <= r_13(61 downto 0) & '0';
   two_q_13 <= '0' & q_13(60 downto 49) & '1' & "0000000000000000000000000000000000000000000000000";
   pow_2_14 <= '0' & pow_2_13(62 downto 1);
   n_13 <= (two_q_13 + NOT(pow_2_14)) when s_13='1' else NOT(two_q_13 + pow_2_14);
   sub_14: IntAdder_63_F0_uid34
      port map ( Cin => one_bit,
                 X => two_r_13,
                 Y => n_13,
                 R => r_14);
   rem_z_13 <= '1' when r_14 = 0 else '0';
   z_14 <= rem_z_13 OR z_13;
   -- Iteration 15
   s_14 <= r_14(62);
   q_15 <= q_14(61 downto 48) & NOT(s_14 OR z_14) & "00000000000000000000000000000000000000000000000";
   real_q_15 <= q_15(60 downto 47) & '1' & "00000000000000000000000000000000000000000000000" when z_14='0' else real_q_14;
   two_r_14 <= r_14(61 downto 0) & '0';
   two_q_14 <= '0' & q_14(60 downto 48) & '1' & "000000000000000000000000000000000000000000000000";
   pow_2_15 <= '0' & pow_2_14(62 downto 1);
   n_14 <= (two_q_14 + NOT(pow_2_15)) when s_14='1' else NOT(two_q_14 + pow_2_15);
   sub_15: IntAdder_63_F0_uid36
      port map ( Cin => one_bit,
                 X => two_r_14,
                 Y => n_14,
                 R => r_15);
   rem_z_14 <= '1' when r_15 = 0 else '0';
   z_15 <= rem_z_14 OR z_14;
   -- Iteration 16
   s_15 <= r_15(62);
   q_16 <= q_15(61 downto 47) & NOT(s_15 OR z_15) & "0000000000000000000000000000000000000000000000";
   real_q_16 <= q_16(60 downto 46) & '1' & "0000000000000000000000000000000000000000000000" when z_15='0' else real_q_15;
   two_r_15 <= r_15(61 downto 0) & '0';
   two_q_15 <= '0' & q_15(60 downto 47) & '1' & "00000000000000000000000000000000000000000000000";
   pow_2_16 <= '0' & pow_2_15(62 downto 1);
   n_15 <= (two_q_15 + NOT(pow_2_16)) when s_15='1' else NOT(two_q_15 + pow_2_16);
   sub_16: IntAdder_63_F0_uid38
      port map ( Cin => one_bit,
                 X => two_r_15,
                 Y => n_15,
                 R => r_16);
   rem_z_15 <= '1' when r_16 = 0 else '0';
   z_16 <= rem_z_15 OR z_15;
   -- Iteration 17
   s_16 <= r_16(62);
   q_17 <= q_16(61 downto 46) & NOT(s_16 OR z_16) & "000000000000000000000000000000000000000000000";
   real_q_17 <= q_17(60 downto 45) & '1' & "000000000000000000000000000000000000000000000" when z_16='0' else real_q_16;
   two_r_16 <= r_16(61 downto 0) & '0';
   two_q_16 <= '0' & q_16(60 downto 46) & '1' & "0000000000000000000000000000000000000000000000";
   pow_2_17 <= '0' & pow_2_16(62 downto 1);
   n_16 <= (two_q_16 + NOT(pow_2_17)) when s_16='1' else NOT(two_q_16 + pow_2_17);
   sub_17: IntAdder_63_F0_uid40
      port map ( Cin => one_bit,
                 X => two_r_16,
                 Y => n_16,
                 R => r_17);
   rem_z_16 <= '1' when r_17 = 0 else '0';
   z_17 <= rem_z_16 OR z_16;
   -- Iteration 18
   s_17 <= r_17(62);
   q_18 <= q_17(61 downto 45) & NOT(s_17 OR z_17) & "00000000000000000000000000000000000000000000";
   real_q_18 <= q_18(60 downto 44) & '1' & "00000000000000000000000000000000000000000000" when z_17='0' else real_q_17;
   two_r_17 <= r_17(61 downto 0) & '0';
   two_q_17 <= '0' & q_17(60 downto 45) & '1' & "000000000000000000000000000000000000000000000";
   pow_2_18 <= '0' & pow_2_17(62 downto 1);
   n_17 <= (two_q_17 + NOT(pow_2_18)) when s_17='1' else NOT(two_q_17 + pow_2_18);
   sub_18: IntAdder_63_F0_uid42
      port map ( Cin => one_bit,
                 X => two_r_17,
                 Y => n_17,
                 R => r_18);
   rem_z_17 <= '1' when r_18 = 0 else '0';
   z_18 <= rem_z_17 OR z_17;
   -- Iteration 19
   s_18 <= r_18(62);
   q_19 <= q_18(61 downto 44) & NOT(s_18 OR z_18) & "0000000000000000000000000000000000000000000";
   real_q_19 <= q_19(60 downto 43) & '1' & "0000000000000000000000000000000000000000000" when z_18='0' else real_q_18;
   two_r_18 <= r_18(61 downto 0) & '0';
   two_q_18 <= '0' & q_18(60 downto 44) & '1' & "00000000000000000000000000000000000000000000";
   pow_2_19 <= '0' & pow_2_18(62 downto 1);
   n_18 <= (two_q_18 + NOT(pow_2_19)) when s_18='1' else NOT(two_q_18 + pow_2_19);
   sub_19: IntAdder_63_F0_uid44
      port map ( Cin => one_bit,
                 X => two_r_18,
                 Y => n_18,
                 R => r_19);
   rem_z_18 <= '1' when r_19 = 0 else '0';
   z_19 <= rem_z_18 OR z_18;
   -- Iteration 20
   s_19 <= r_19(62);
   q_20 <= q_19(61 downto 43) & NOT(s_19 OR z_19) & "000000000000000000000000000000000000000000";
   real_q_20 <= q_20(60 downto 42) & '1' & "000000000000000000000000000000000000000000" when z_19='0' else real_q_19;
   two_r_19 <= r_19(61 downto 0) & '0';
   two_q_19 <= '0' & q_19(60 downto 43) & '1' & "0000000000000000000000000000000000000000000";
   pow_2_20 <= '0' & pow_2_19(62 downto 1);
   n_19 <= (two_q_19 + NOT(pow_2_20)) when s_19='1' else NOT(two_q_19 + pow_2_20);
   sub_20: IntAdder_63_F0_uid46
      port map ( Cin => one_bit,
                 X => two_r_19,
                 Y => n_19,
                 R => r_20);
   rem_z_19 <= '1' when r_20 = 0 else '0';
   z_20 <= rem_z_19 OR z_19;
   -- Iteration 21
   s_20 <= r_20(62);
   q_21 <= q_20(61 downto 42) & NOT(s_20 OR z_20) & "00000000000000000000000000000000000000000";
   real_q_21 <= q_21(60 downto 41) & '1' & "00000000000000000000000000000000000000000" when z_20='0' else real_q_20;
   two_r_20 <= r_20(61 downto 0) & '0';
   two_q_20 <= '0' & q_20(60 downto 42) & '1' & "000000000000000000000000000000000000000000";
   pow_2_21 <= '0' & pow_2_20(62 downto 1);
   n_20 <= (two_q_20 + NOT(pow_2_21)) when s_20='1' else NOT(two_q_20 + pow_2_21);
   sub_21: IntAdder_63_F0_uid48
      port map ( Cin => one_bit,
                 X => two_r_20,
                 Y => n_20,
                 R => r_21);
   rem_z_20 <= '1' when r_21 = 0 else '0';
   z_21 <= rem_z_20 OR z_20;
   -- Iteration 22
   s_21 <= r_21(62);
   q_22 <= q_21(61 downto 41) & NOT(s_21 OR z_21) & "0000000000000000000000000000000000000000";
   real_q_22 <= q_22(60 downto 40) & '1' & "0000000000000000000000000000000000000000" when z_21='0' else real_q_21;
   two_r_21 <= r_21(61 downto 0) & '0';
   two_q_21 <= '0' & q_21(60 downto 41) & '1' & "00000000000000000000000000000000000000000";
   pow_2_22 <= '0' & pow_2_21(62 downto 1);
   n_21 <= (two_q_21 + NOT(pow_2_22)) when s_21='1' else NOT(two_q_21 + pow_2_22);
   sub_22: IntAdder_63_F0_uid50
      port map ( Cin => one_bit,
                 X => two_r_21,
                 Y => n_21,
                 R => r_22);
   rem_z_21 <= '1' when r_22 = 0 else '0';
   z_22 <= rem_z_21 OR z_21;
   -- Iteration 23
   s_22 <= r_22(62);
   q_23 <= q_22(61 downto 40) & NOT(s_22 OR z_22) & "000000000000000000000000000000000000000";
   real_q_23 <= q_23(60 downto 39) & '1' & "000000000000000000000000000000000000000" when z_22='0' else real_q_22;
   two_r_22 <= r_22(61 downto 0) & '0';
   two_q_22 <= '0' & q_22(60 downto 40) & '1' & "0000000000000000000000000000000000000000";
   pow_2_23 <= '0' & pow_2_22(62 downto 1);
   n_22 <= (two_q_22 + NOT(pow_2_23)) when s_22='1' else NOT(two_q_22 + pow_2_23);
   sub_23: IntAdder_63_F0_uid52
      port map ( Cin => one_bit,
                 X => two_r_22,
                 Y => n_22,
                 R => r_23);
   rem_z_22 <= '1' when r_23 = 0 else '0';
   z_23 <= rem_z_22 OR z_22;
   -- Iteration 24
   s_23 <= r_23(62);
   q_24 <= q_23(61 downto 39) & NOT(s_23 OR z_23) & "00000000000000000000000000000000000000";
   real_q_24 <= q_24(60 downto 38) & '1' & "00000000000000000000000000000000000000" when z_23='0' else real_q_23;
   two_r_23 <= r_23(61 downto 0) & '0';
   two_q_23 <= '0' & q_23(60 downto 39) & '1' & "000000000000000000000000000000000000000";
   pow_2_24 <= '0' & pow_2_23(62 downto 1);
   n_23 <= (two_q_23 + NOT(pow_2_24)) when s_23='1' else NOT(two_q_23 + pow_2_24);
   sub_24: IntAdder_63_F0_uid54
      port map ( Cin => one_bit,
                 X => two_r_23,
                 Y => n_23,
                 R => r_24);
   rem_z_23 <= '1' when r_24 = 0 else '0';
   z_24 <= rem_z_23 OR z_23;
   -- Iteration 25
   s_24 <= r_24(62);
   q_25 <= q_24(61 downto 38) & NOT(s_24 OR z_24) & "0000000000000000000000000000000000000";
   real_q_25 <= q_25(60 downto 37) & '1' & "0000000000000000000000000000000000000" when z_24='0' else real_q_24;
   two_r_24 <= r_24(61 downto 0) & '0';
   two_q_24 <= '0' & q_24(60 downto 38) & '1' & "00000000000000000000000000000000000000";
   pow_2_25 <= '0' & pow_2_24(62 downto 1);
   n_24 <= (two_q_24 + NOT(pow_2_25)) when s_24='1' else NOT(two_q_24 + pow_2_25);
   sub_25: IntAdder_63_F0_uid56
      port map ( Cin => one_bit,
                 X => two_r_24,
                 Y => n_24,
                 R => r_25);
   rem_z_24 <= '1' when r_25 = 0 else '0';
   z_25 <= rem_z_24 OR z_24;
   -- Iteration 26
   s_25 <= r_25(62);
   q_26 <= q_25(61 downto 37) & NOT(s_25 OR z_25) & "000000000000000000000000000000000000";
   real_q_26 <= q_26(60 downto 36) & '1' & "000000000000000000000000000000000000" when z_25='0' else real_q_25;
   two_r_25 <= r_25(61 downto 0) & '0';
   two_q_25 <= '0' & q_25(60 downto 37) & '1' & "0000000000000000000000000000000000000";
   pow_2_26 <= '0' & pow_2_25(62 downto 1);
   n_25 <= (two_q_25 + NOT(pow_2_26)) when s_25='1' else NOT(two_q_25 + pow_2_26);
   sub_26: IntAdder_63_F0_uid58
      port map ( Cin => one_bit,
                 X => two_r_25,
                 Y => n_25,
                 R => r_26);
   rem_z_25 <= '1' when r_26 = 0 else '0';
   z_26 <= rem_z_25 OR z_25;
   -- Iteration 27
   s_26 <= r_26(62);
   q_27 <= q_26(61 downto 36) & NOT(s_26 OR z_26) & "00000000000000000000000000000000000";
   real_q_27 <= q_27(60 downto 35) & '1' & "00000000000000000000000000000000000" when z_26='0' else real_q_26;
   two_r_26 <= r_26(61 downto 0) & '0';
   two_q_26 <= '0' & q_26(60 downto 36) & '1' & "000000000000000000000000000000000000";
   pow_2_27 <= '0' & pow_2_26(62 downto 1);
   n_26 <= (two_q_26 + NOT(pow_2_27)) when s_26='1' else NOT(two_q_26 + pow_2_27);
   sub_27: IntAdder_63_F0_uid60
      port map ( Cin => one_bit,
                 X => two_r_26,
                 Y => n_26,
                 R => r_27);
   rem_z_26 <= '1' when r_27 = 0 else '0';
   z_27 <= rem_z_26 OR z_26;
   -- Iteration 28
   s_27 <= r_27(62);
   q_28 <= q_27(61 downto 35) & NOT(s_27 OR z_27) & "0000000000000000000000000000000000";
   real_q_28 <= q_28(60 downto 34) & '1' & "0000000000000000000000000000000000" when z_27='0' else real_q_27;
   two_r_27 <= r_27(61 downto 0) & '0';
   two_q_27 <= '0' & q_27(60 downto 35) & '1' & "00000000000000000000000000000000000";
   pow_2_28 <= '0' & pow_2_27(62 downto 1);
   n_27 <= (two_q_27 + NOT(pow_2_28)) when s_27='1' else NOT(two_q_27 + pow_2_28);
   sub_28: IntAdder_63_F0_uid62
      port map ( Cin => one_bit,
                 X => two_r_27,
                 Y => n_27,
                 R => r_28);
   rem_z_27 <= '1' when r_28 = 0 else '0';
   z_28 <= rem_z_27 OR z_27;
   -- Iteration 29
   s_28 <= r_28(62);
   q_29 <= q_28(61 downto 34) & NOT(s_28 OR z_28) & "000000000000000000000000000000000";
   real_q_29 <= q_29(60 downto 33) & '1' & "000000000000000000000000000000000" when z_28='0' else real_q_28;
   two_r_28 <= r_28(61 downto 0) & '0';
   two_q_28 <= '0' & q_28(60 downto 34) & '1' & "0000000000000000000000000000000000";
   pow_2_29 <= '0' & pow_2_28(62 downto 1);
   n_28 <= (two_q_28 + NOT(pow_2_29)) when s_28='1' else NOT(two_q_28 + pow_2_29);
   sub_29: IntAdder_63_F0_uid64
      port map ( Cin => one_bit,
                 X => two_r_28,
                 Y => n_28,
                 R => r_29);
   rem_z_28 <= '1' when r_29 = 0 else '0';
   z_29 <= rem_z_28 OR z_28;
   -- Iteration 30
   s_29 <= r_29(62);
   q_30 <= q_29(61 downto 33) & NOT(s_29 OR z_29) & "00000000000000000000000000000000";
   real_q_30 <= q_30(60 downto 32) & '1' & "00000000000000000000000000000000" when z_29='0' else real_q_29;
   two_r_29 <= r_29(61 downto 0) & '0';
   two_q_29 <= '0' & q_29(60 downto 33) & '1' & "000000000000000000000000000000000";
   pow_2_30 <= '0' & pow_2_29(62 downto 1);
   n_29 <= (two_q_29 + NOT(pow_2_30)) when s_29='1' else NOT(two_q_29 + pow_2_30);
   sub_30: IntAdder_63_F0_uid66
      port map ( Cin => one_bit,
                 X => two_r_29,
                 Y => n_29,
                 R => r_30);
   rem_z_29 <= '1' when r_30 = 0 else '0';
   z_30 <= rem_z_29 OR z_29;
   -- Iteration 31
   s_30 <= r_30(62);
   q_31 <= q_30(61 downto 32) & NOT(s_30 OR z_30) & "0000000000000000000000000000000";
   real_q_31 <= q_31(60 downto 31) & '1' & "0000000000000000000000000000000" when z_30='0' else real_q_30;
   two_r_30 <= r_30(61 downto 0) & '0';
   two_q_30 <= '0' & q_30(60 downto 32) & '1' & "00000000000000000000000000000000";
   pow_2_31 <= '0' & pow_2_30(62 downto 1);
   n_30 <= (two_q_30 + NOT(pow_2_31)) when s_30='1' else NOT(two_q_30 + pow_2_31);
   sub_31: IntAdder_63_F0_uid68
      port map ( Cin => one_bit,
                 X => two_r_30,
                 Y => n_30,
                 R => r_31);
   rem_z_30 <= '1' when r_31 = 0 else '0';
   z_31 <= rem_z_30 OR z_30;
   -- Iteration 32
   s_31 <= r_31(62);
   q_32 <= q_31(61 downto 31) & NOT(s_31 OR z_31) & "000000000000000000000000000000";
   real_q_32 <= q_32(60 downto 30) & '1' & "000000000000000000000000000000" when z_31='0' else real_q_31;
   two_r_31 <= r_31(61 downto 0) & '0';
   two_q_31 <= '0' & q_31(60 downto 31) & '1' & "0000000000000000000000000000000";
   pow_2_32 <= '0' & pow_2_31(62 downto 1);
   n_31 <= (two_q_31 + NOT(pow_2_32)) when s_31='1' else NOT(two_q_31 + pow_2_32);
   sub_32: IntAdder_63_F0_uid70
      port map ( Cin => one_bit,
                 X => two_r_31,
                 Y => n_31,
                 R => r_32);
   rem_z_31 <= '1' when r_32 = 0 else '0';
   z_32 <= rem_z_31 OR z_31;
   -- Iteration 33
   s_32 <= r_32(62);
   q_33 <= q_32(61 downto 30) & NOT(s_32 OR z_32) & "00000000000000000000000000000";
   real_q_33 <= q_33(60 downto 29) & '1' & "00000000000000000000000000000" when z_32='0' else real_q_32;
   two_r_32 <= r_32(61 downto 0) & '0';
   two_q_32 <= '0' & q_32(60 downto 30) & '1' & "000000000000000000000000000000";
   pow_2_33 <= '0' & pow_2_32(62 downto 1);
   n_32 <= (two_q_32 + NOT(pow_2_33)) when s_32='1' else NOT(two_q_32 + pow_2_33);
   sub_33: IntAdder_63_F0_uid72
      port map ( Cin => one_bit,
                 X => two_r_32,
                 Y => n_32,
                 R => r_33);
   rem_z_32 <= '1' when r_33 = 0 else '0';
   z_33 <= rem_z_32 OR z_32;
   -- Iteration 34
   s_33 <= r_33(62);
   q_34 <= q_33(61 downto 29) & NOT(s_33 OR z_33) & "0000000000000000000000000000";
   real_q_34 <= q_34(60 downto 28) & '1' & "0000000000000000000000000000" when z_33='0' else real_q_33;
   two_r_33 <= r_33(61 downto 0) & '0';
   two_q_33 <= '0' & q_33(60 downto 29) & '1' & "00000000000000000000000000000";
   pow_2_34 <= '0' & pow_2_33(62 downto 1);
   n_33 <= (two_q_33 + NOT(pow_2_34)) when s_33='1' else NOT(two_q_33 + pow_2_34);
   sub_34: IntAdder_63_F0_uid74
      port map ( Cin => one_bit,
                 X => two_r_33,
                 Y => n_33,
                 R => r_34);
   rem_z_33 <= '1' when r_34 = 0 else '0';
   z_34 <= rem_z_33 OR z_33;
   -- Iteration 35
   s_34 <= r_34(62);
   q_35 <= q_34(61 downto 28) & NOT(s_34 OR z_34) & "000000000000000000000000000";
   real_q_35 <= q_35(60 downto 27) & '1' & "000000000000000000000000000" when z_34='0' else real_q_34;
   two_r_34 <= r_34(61 downto 0) & '0';
   two_q_34 <= '0' & q_34(60 downto 28) & '1' & "0000000000000000000000000000";
   pow_2_35 <= '0' & pow_2_34(62 downto 1);
   n_34 <= (two_q_34 + NOT(pow_2_35)) when s_34='1' else NOT(two_q_34 + pow_2_35);
   sub_35: IntAdder_63_F0_uid76
      port map ( Cin => one_bit,
                 X => two_r_34,
                 Y => n_34,
                 R => r_35);
   rem_z_34 <= '1' when r_35 = 0 else '0';
   z_35 <= rem_z_34 OR z_34;
   -- Iteration 36
   s_35 <= r_35(62);
   q_36 <= q_35(61 downto 27) & NOT(s_35 OR z_35) & "00000000000000000000000000";
   real_q_36 <= q_36(60 downto 26) & '1' & "00000000000000000000000000" when z_35='0' else real_q_35;
   two_r_35 <= r_35(61 downto 0) & '0';
   two_q_35 <= '0' & q_35(60 downto 27) & '1' & "000000000000000000000000000";
   pow_2_36 <= '0' & pow_2_35(62 downto 1);
   n_35 <= (two_q_35 + NOT(pow_2_36)) when s_35='1' else NOT(two_q_35 + pow_2_36);
   sub_36: IntAdder_63_F0_uid78
      port map ( Cin => one_bit,
                 X => two_r_35,
                 Y => n_35,
                 R => r_36);
   rem_z_35 <= '1' when r_36 = 0 else '0';
   z_36 <= rem_z_35 OR z_35;
   -- Iteration 37
   s_36 <= r_36(62);
   q_37 <= q_36(61 downto 26) & NOT(s_36 OR z_36) & "0000000000000000000000000";
   real_q_37 <= q_37(60 downto 25) & '1' & "0000000000000000000000000" when z_36='0' else real_q_36;
   two_r_36 <= r_36(61 downto 0) & '0';
   two_q_36 <= '0' & q_36(60 downto 26) & '1' & "00000000000000000000000000";
   pow_2_37 <= '0' & pow_2_36(62 downto 1);
   n_36 <= (two_q_36 + NOT(pow_2_37)) when s_36='1' else NOT(two_q_36 + pow_2_37);
   sub_37: IntAdder_63_F0_uid80
      port map ( Cin => one_bit,
                 X => two_r_36,
                 Y => n_36,
                 R => r_37);
   rem_z_36 <= '1' when r_37 = 0 else '0';
   z_37 <= rem_z_36 OR z_36;
   -- Iteration 38
   s_37 <= r_37(62);
   q_38 <= q_37(61 downto 25) & NOT(s_37 OR z_37) & "000000000000000000000000";
   real_q_38 <= q_38(60 downto 24) & '1' & "000000000000000000000000" when z_37='0' else real_q_37;
   two_r_37 <= r_37(61 downto 0) & '0';
   two_q_37 <= '0' & q_37(60 downto 25) & '1' & "0000000000000000000000000";
   pow_2_38 <= '0' & pow_2_37(62 downto 1);
   n_37 <= (two_q_37 + NOT(pow_2_38)) when s_37='1' else NOT(two_q_37 + pow_2_38);
   sub_38: IntAdder_63_F0_uid82
      port map ( Cin => one_bit,
                 X => two_r_37,
                 Y => n_37,
                 R => r_38);
   rem_z_37 <= '1' when r_38 = 0 else '0';
   z_38 <= rem_z_37 OR z_37;
   -- Iteration 39
   s_38 <= r_38(62);
   q_39 <= q_38(61 downto 24) & NOT(s_38 OR z_38) & "00000000000000000000000";
   real_q_39 <= q_39(60 downto 23) & '1' & "00000000000000000000000" when z_38='0' else real_q_38;
   two_r_38 <= r_38(61 downto 0) & '0';
   two_q_38 <= '0' & q_38(60 downto 24) & '1' & "000000000000000000000000";
   pow_2_39 <= '0' & pow_2_38(62 downto 1);
   n_38 <= (two_q_38 + NOT(pow_2_39)) when s_38='1' else NOT(two_q_38 + pow_2_39);
   sub_39: IntAdder_63_F0_uid84
      port map ( Cin => one_bit,
                 X => two_r_38,
                 Y => n_38,
                 R => r_39);
   rem_z_38 <= '1' when r_39 = 0 else '0';
   z_39 <= rem_z_38 OR z_38;
   -- Iteration 40
   s_39 <= r_39(62);
   q_40 <= q_39(61 downto 23) & NOT(s_39 OR z_39) & "0000000000000000000000";
   real_q_40 <= q_40(60 downto 22) & '1' & "0000000000000000000000" when z_39='0' else real_q_39;
   two_r_39 <= r_39(61 downto 0) & '0';
   two_q_39 <= '0' & q_39(60 downto 23) & '1' & "00000000000000000000000";
   pow_2_40 <= '0' & pow_2_39(62 downto 1);
   n_39 <= (two_q_39 + NOT(pow_2_40)) when s_39='1' else NOT(two_q_39 + pow_2_40);
   sub_40: IntAdder_63_F0_uid86
      port map ( Cin => one_bit,
                 X => two_r_39,
                 Y => n_39,
                 R => r_40);
   rem_z_39 <= '1' when r_40 = 0 else '0';
   z_40 <= rem_z_39 OR z_39;
   -- Iteration 41
   s_40 <= r_40(62);
   q_41 <= q_40(61 downto 22) & NOT(s_40 OR z_40) & "000000000000000000000";
   real_q_41 <= q_41(60 downto 21) & '1' & "000000000000000000000" when z_40='0' else real_q_40;
   two_r_40 <= r_40(61 downto 0) & '0';
   two_q_40 <= '0' & q_40(60 downto 22) & '1' & "0000000000000000000000";
   pow_2_41 <= '0' & pow_2_40(62 downto 1);
   n_40 <= (two_q_40 + NOT(pow_2_41)) when s_40='1' else NOT(two_q_40 + pow_2_41);
   sub_41: IntAdder_63_F0_uid88
      port map ( Cin => one_bit,
                 X => two_r_40,
                 Y => n_40,
                 R => r_41);
   rem_z_40 <= '1' when r_41 = 0 else '0';
   z_41 <= rem_z_40 OR z_40;
   -- Iteration 42
   s_41 <= r_41(62);
   q_42 <= q_41(61 downto 21) & NOT(s_41 OR z_41) & "00000000000000000000";
   real_q_42 <= q_42(60 downto 20) & '1' & "00000000000000000000" when z_41='0' else real_q_41;
   two_r_41 <= r_41(61 downto 0) & '0';
   two_q_41 <= '0' & q_41(60 downto 21) & '1' & "000000000000000000000";
   pow_2_42 <= '0' & pow_2_41(62 downto 1);
   n_41 <= (two_q_41 + NOT(pow_2_42)) when s_41='1' else NOT(two_q_41 + pow_2_42);
   sub_42: IntAdder_63_F0_uid90
      port map ( Cin => one_bit,
                 X => two_r_41,
                 Y => n_41,
                 R => r_42);
   rem_z_41 <= '1' when r_42 = 0 else '0';
   z_42 <= rem_z_41 OR z_41;
   -- Iteration 43
   s_42 <= r_42(62);
   q_43 <= q_42(61 downto 20) & NOT(s_42 OR z_42) & "0000000000000000000";
   real_q_43 <= q_43(60 downto 19) & '1' & "0000000000000000000" when z_42='0' else real_q_42;
   two_r_42 <= r_42(61 downto 0) & '0';
   two_q_42 <= '0' & q_42(60 downto 20) & '1' & "00000000000000000000";
   pow_2_43 <= '0' & pow_2_42(62 downto 1);
   n_42 <= (two_q_42 + NOT(pow_2_43)) when s_42='1' else NOT(two_q_42 + pow_2_43);
   sub_43: IntAdder_63_F0_uid92
      port map ( Cin => one_bit,
                 X => two_r_42,
                 Y => n_42,
                 R => r_43);
   rem_z_42 <= '1' when r_43 = 0 else '0';
   z_43 <= rem_z_42 OR z_42;
   -- Iteration 44
   s_43 <= r_43(62);
   q_44 <= q_43(61 downto 19) & NOT(s_43 OR z_43) & "000000000000000000";
   real_q_44 <= q_44(60 downto 18) & '1' & "000000000000000000" when z_43='0' else real_q_43;
   two_r_43 <= r_43(61 downto 0) & '0';
   two_q_43 <= '0' & q_43(60 downto 19) & '1' & "0000000000000000000";
   pow_2_44 <= '0' & pow_2_43(62 downto 1);
   n_43 <= (two_q_43 + NOT(pow_2_44)) when s_43='1' else NOT(two_q_43 + pow_2_44);
   sub_44: IntAdder_63_F0_uid94
      port map ( Cin => one_bit,
                 X => two_r_43,
                 Y => n_43,
                 R => r_44);
   rem_z_43 <= '1' when r_44 = 0 else '0';
   z_44 <= rem_z_43 OR z_43;
   -- Iteration 45
   s_44 <= r_44(62);
   q_45 <= q_44(61 downto 18) & NOT(s_44 OR z_44) & "00000000000000000";
   real_q_45 <= q_45(60 downto 17) & '1' & "00000000000000000" when z_44='0' else real_q_44;
   two_r_44 <= r_44(61 downto 0) & '0';
   two_q_44 <= '0' & q_44(60 downto 18) & '1' & "000000000000000000";
   pow_2_45 <= '0' & pow_2_44(62 downto 1);
   n_44 <= (two_q_44 + NOT(pow_2_45)) when s_44='1' else NOT(two_q_44 + pow_2_45);
   sub_45: IntAdder_63_F0_uid96
      port map ( Cin => one_bit,
                 X => two_r_44,
                 Y => n_44,
                 R => r_45);
   rem_z_44 <= '1' when r_45 = 0 else '0';
   z_45 <= rem_z_44 OR z_44;
   -- Iteration 46
   s_45 <= r_45(62);
   q_46 <= q_45(61 downto 17) & NOT(s_45 OR z_45) & "0000000000000000";
   real_q_46 <= q_46(60 downto 16) & '1' & "0000000000000000" when z_45='0' else real_q_45;
   two_r_45 <= r_45(61 downto 0) & '0';
   two_q_45 <= '0' & q_45(60 downto 17) & '1' & "00000000000000000";
   pow_2_46 <= '0' & pow_2_45(62 downto 1);
   n_45 <= (two_q_45 + NOT(pow_2_46)) when s_45='1' else NOT(two_q_45 + pow_2_46);
   sub_46: IntAdder_63_F0_uid98
      port map ( Cin => one_bit,
                 X => two_r_45,
                 Y => n_45,
                 R => r_46);
   rem_z_45 <= '1' when r_46 = 0 else '0';
   z_46 <= rem_z_45 OR z_45;
   -- Iteration 47
   s_46 <= r_46(62);
   q_47 <= q_46(61 downto 16) & NOT(s_46 OR z_46) & "000000000000000";
   real_q_47 <= q_47(60 downto 15) & '1' & "000000000000000" when z_46='0' else real_q_46;
   two_r_46 <= r_46(61 downto 0) & '0';
   two_q_46 <= '0' & q_46(60 downto 16) & '1' & "0000000000000000";
   pow_2_47 <= '0' & pow_2_46(62 downto 1);
   n_46 <= (two_q_46 + NOT(pow_2_47)) when s_46='1' else NOT(two_q_46 + pow_2_47);
   sub_47: IntAdder_63_F0_uid100
      port map ( Cin => one_bit,
                 X => two_r_46,
                 Y => n_46,
                 R => r_47);
   rem_z_46 <= '1' when r_47 = 0 else '0';
   z_47 <= rem_z_46 OR z_46;
   -- Iteration 48
   s_47 <= r_47(62);
   q_48 <= q_47(61 downto 15) & NOT(s_47 OR z_47) & "00000000000000";
   real_q_48 <= q_48(60 downto 14) & '1' & "00000000000000" when z_47='0' else real_q_47;
   two_r_47 <= r_47(61 downto 0) & '0';
   two_q_47 <= '0' & q_47(60 downto 15) & '1' & "000000000000000";
   pow_2_48 <= '0' & pow_2_47(62 downto 1);
   n_47 <= (two_q_47 + NOT(pow_2_48)) when s_47='1' else NOT(two_q_47 + pow_2_48);
   sub_48: IntAdder_63_F0_uid102
      port map ( Cin => one_bit,
                 X => two_r_47,
                 Y => n_47,
                 R => r_48);
   rem_z_47 <= '1' when r_48 = 0 else '0';
   z_48 <= rem_z_47 OR z_47;
   -- Iteration 49
   s_48 <= r_48(62);
   q_49 <= q_48(61 downto 14) & NOT(s_48 OR z_48) & "0000000000000";
   real_q_49 <= q_49(60 downto 13) & '1' & "0000000000000" when z_48='0' else real_q_48;
   two_r_48 <= r_48(61 downto 0) & '0';
   two_q_48 <= '0' & q_48(60 downto 14) & '1' & "00000000000000";
   pow_2_49 <= '0' & pow_2_48(62 downto 1);
   n_48 <= (two_q_48 + NOT(pow_2_49)) when s_48='1' else NOT(two_q_48 + pow_2_49);
   sub_49: IntAdder_63_F0_uid104
      port map ( Cin => one_bit,
                 X => two_r_48,
                 Y => n_48,
                 R => r_49);
   rem_z_48 <= '1' when r_49 = 0 else '0';
   z_49 <= rem_z_48 OR z_48;
   -- Iteration 50
   s_49 <= r_49(62);
   q_50 <= q_49(61 downto 13) & NOT(s_49 OR z_49) & "000000000000";
   real_q_50 <= q_50(60 downto 12) & '1' & "000000000000" when z_49='0' else real_q_49;
   two_r_49 <= r_49(61 downto 0) & '0';
   two_q_49 <= '0' & q_49(60 downto 13) & '1' & "0000000000000";
   pow_2_50 <= '0' & pow_2_49(62 downto 1);
   n_49 <= (two_q_49 + NOT(pow_2_50)) when s_49='1' else NOT(two_q_49 + pow_2_50);
   sub_50: IntAdder_63_F0_uid106
      port map ( Cin => one_bit,
                 X => two_r_49,
                 Y => n_49,
                 R => r_50);
   rem_z_49 <= '1' when r_50 = 0 else '0';
   z_50 <= rem_z_49 OR z_49;
   -- Iteration 51
   s_50 <= r_50(62);
   q_51 <= q_50(61 downto 12) & NOT(s_50 OR z_50) & "00000000000";
   real_q_51 <= q_51(60 downto 11) & '1' & "00000000000" when z_50='0' else real_q_50;
   two_r_50 <= r_50(61 downto 0) & '0';
   two_q_50 <= '0' & q_50(60 downto 12) & '1' & "000000000000";
   pow_2_51 <= '0' & pow_2_50(62 downto 1);
   n_50 <= (two_q_50 + NOT(pow_2_51)) when s_50='1' else NOT(two_q_50 + pow_2_51);
   sub_51: IntAdder_63_F0_uid108
      port map ( Cin => one_bit,
                 X => two_r_50,
                 Y => n_50,
                 R => r_51);
   rem_z_50 <= '1' when r_51 = 0 else '0';
   z_51 <= rem_z_50 OR z_50;
   -- Iteration 52
   s_51 <= r_51(62);
   q_52 <= q_51(61 downto 11) & NOT(s_51 OR z_51) & "0000000000";
   real_q_52 <= q_52(60 downto 10) & '1' & "0000000000" when z_51='0' else real_q_51;
   two_r_51 <= r_51(61 downto 0) & '0';
   two_q_51 <= '0' & q_51(60 downto 11) & '1' & "00000000000";
   pow_2_52 <= '0' & pow_2_51(62 downto 1);
   n_51 <= (two_q_51 + NOT(pow_2_52)) when s_51='1' else NOT(two_q_51 + pow_2_52);
   sub_52: IntAdder_63_F0_uid110
      port map ( Cin => one_bit,
                 X => two_r_51,
                 Y => n_51,
                 R => r_52);
   rem_z_51 <= '1' when r_52 = 0 else '0';
   z_52 <= rem_z_51 OR z_51;
   -- Iteration 53
   s_52 <= r_52(62);
   q_53 <= q_52(61 downto 10) & NOT(s_52 OR z_52) & "000000000";
   real_q_53 <= q_53(60 downto 9) & '1' & "000000000" when z_52='0' else real_q_52;
   two_r_52 <= r_52(61 downto 0) & '0';
   two_q_52 <= '0' & q_52(60 downto 10) & '1' & "0000000000";
   pow_2_53 <= '0' & pow_2_52(62 downto 1);
   n_52 <= (two_q_52 + NOT(pow_2_53)) when s_52='1' else NOT(two_q_52 + pow_2_53);
   sub_53: IntAdder_63_F0_uid112
      port map ( Cin => one_bit,
                 X => two_r_52,
                 Y => n_52,
                 R => r_53);
   rem_z_52 <= '1' when r_53 = 0 else '0';
   z_53 <= rem_z_52 OR z_52;
   -- Iteration 54
   s_53 <= r_53(62);
   q_54 <= q_53(61 downto 9) & NOT(s_53 OR z_53) & "00000000";
   real_q_54 <= q_54(60 downto 8) & '1' & "00000000" when z_53='0' else real_q_53;
   two_r_53 <= r_53(61 downto 0) & '0';
   two_q_53 <= '0' & q_53(60 downto 9) & '1' & "000000000";
   pow_2_54 <= '0' & pow_2_53(62 downto 1);
   n_53 <= (two_q_53 + NOT(pow_2_54)) when s_53='1' else NOT(two_q_53 + pow_2_54);
   sub_54: IntAdder_63_F0_uid114
      port map ( Cin => one_bit,
                 X => two_r_53,
                 Y => n_53,
                 R => r_54);
   rem_z_53 <= '1' when r_54 = 0 else '0';
   z_54 <= rem_z_53 OR z_53;
   -- Iteration 55
   s_54 <= r_54(62);
   q_55 <= q_54(61 downto 8) & NOT(s_54 OR z_54) & "0000000";
   real_q_55 <= q_55(60 downto 7) & '1' & "0000000" when z_54='0' else real_q_54;
   two_r_54 <= r_54(61 downto 0) & '0';
   two_q_54 <= '0' & q_54(60 downto 8) & '1' & "00000000";
   pow_2_55 <= '0' & pow_2_54(62 downto 1);
   n_54 <= (two_q_54 + NOT(pow_2_55)) when s_54='1' else NOT(two_q_54 + pow_2_55);
   sub_55: IntAdder_63_F0_uid116
      port map ( Cin => one_bit,
                 X => two_r_54,
                 Y => n_54,
                 R => r_55);
   rem_z_54 <= '1' when r_55 = 0 else '0';
   z_55 <= rem_z_54 OR z_54;
   -- Iteration 56
   s_55 <= r_55(62);
   q_56 <= q_55(61 downto 7) & NOT(s_55 OR z_55) & "000000";
   real_q_56 <= q_56(60 downto 6) & '1' & "000000" when z_55='0' else real_q_55;
   two_r_55 <= r_55(61 downto 0) & '0';
   two_q_55 <= '0' & q_55(60 downto 7) & '1' & "0000000";
   pow_2_56 <= '0' & pow_2_55(62 downto 1);
   n_55 <= (two_q_55 + NOT(pow_2_56)) when s_55='1' else NOT(two_q_55 + pow_2_56);
   sub_56: IntAdder_63_F0_uid118
      port map ( Cin => one_bit,
                 X => two_r_55,
                 Y => n_55,
                 R => r_56);
   rem_z_55 <= '1' when r_56 = 0 else '0';
   z_56 <= rem_z_55 OR z_55;
   -- Iteration 57
   s_56 <= r_56(62);
   q_57 <= q_56(61 downto 6) & NOT(s_56 OR z_56) & "00000";
   real_q_57 <= q_57(60 downto 5) & '1' & "00000" when z_56='0' else real_q_56;
   two_r_56 <= r_56(61 downto 0) & '0';
   two_q_56 <= '0' & q_56(60 downto 6) & '1' & "000000";
   pow_2_57 <= '0' & pow_2_56(62 downto 1);
   n_56 <= (two_q_56 + NOT(pow_2_57)) when s_56='1' else NOT(two_q_56 + pow_2_57);
   sub_57: IntAdder_63_F0_uid120
      port map ( Cin => one_bit,
                 X => two_r_56,
                 Y => n_56,
                 R => r_57);
   rem_z_56 <= '1' when r_57 = 0 else '0';
   z_57 <= rem_z_56 OR z_56;
   -- Iteration 58
   s_57 <= r_57(62);
   q_58 <= q_57(61 downto 5) & NOT(s_57 OR z_57) & "0000";
   real_q_58 <= q_58(60 downto 4) & '1' & "0000" when z_57='0' else real_q_57;
   two_r_57 <= r_57(61 downto 0) & '0';
   two_q_57 <= '0' & q_57(60 downto 5) & '1' & "00000";
   pow_2_58 <= '0' & pow_2_57(62 downto 1);
   n_57 <= (two_q_57 + NOT(pow_2_58)) when s_57='1' else NOT(two_q_57 + pow_2_58);
   sub_58: IntAdder_63_F0_uid122
      port map ( Cin => one_bit,
                 X => two_r_57,
                 Y => n_57,
                 R => r_58);
   rem_z_57 <= '1' when r_58 = 0 else '0';
   z_58 <= rem_z_57 OR z_57;
   -- Iteration 59
   s_58 <= r_58(62);
   q_59 <= q_58(61 downto 4) & NOT(s_58 OR z_58) & "000";
   real_q_59 <= q_59(60 downto 3) & '1' & "000" when z_58='0' else real_q_58;
   two_r_58 <= r_58(61 downto 0) & '0';
   two_q_58 <= '0' & q_58(60 downto 4) & '1' & "0000";
   pow_2_59 <= '0' & pow_2_58(62 downto 1);
   n_58 <= (two_q_58 + NOT(pow_2_59)) when s_58='1' else NOT(two_q_58 + pow_2_59);
   sub_59: IntAdder_63_F0_uid124
      port map ( Cin => one_bit,
                 X => two_r_58,
                 Y => n_58,
                 R => r_59);
   rem_z_58 <= '1' when r_59 = 0 else '0';
   z_59 <= rem_z_58 OR z_58;
   -- Iteration 60
   s_59 <= r_59(62);
   q_60 <= q_59(61 downto 3) & NOT(s_59 OR z_59) & "00";
   real_q_60 <= q_60(60 downto 2) & '1' & "00" when z_59='0' else real_q_59;
   two_r_59 <= r_59(61 downto 0) & '0';
   two_q_59 <= '0' & q_59(60 downto 3) & '1' & "000";
   pow_2_60 <= '0' & pow_2_59(62 downto 1);
   n_59 <= (two_q_59 + NOT(pow_2_60)) when s_59='1' else NOT(two_q_59 + pow_2_60);
   sub_60: IntAdder_63_F0_uid126
      port map ( Cin => one_bit,
                 X => two_r_59,
                 Y => n_59,
                 R => r_60);
   rem_z_59 <= '1' when r_60 = 0 else '0';
   z_60 <= rem_z_59 OR z_59;
   -- Iteration 61
   s_60 <= r_60(62);
   q_61 <= q_60(61 downto 2) & NOT(s_60 OR z_60) & "0";
   real_q_61 <= q_61(60 downto 1) & '1' & "0" when z_60='0' else real_q_60;
   two_r_60 <= r_60(61 downto 0) & '0';
   two_q_60 <= '0' & q_60(60 downto 2) & '1' & "00";
   pow_2_61 <= '0' & pow_2_60(62 downto 1);
   n_60 <= (two_q_60 + NOT(pow_2_61)) when s_60='1' else NOT(two_q_60 + pow_2_61);
   sub_61: IntAdder_63_F0_uid128
      port map ( Cin => one_bit,
                 X => two_r_60,
                 Y => n_60,
                 R => r_61);
   rem_z_60 <= '1' when r_61 = 0 else '0';
   z_61 <= rem_z_60 OR z_60;
   -- Iteration 62
   s_61 <= r_61(62);
   q_62 <= q_61(61 downto 1) & NOT(s_61 OR z_61) & "";
   real_q_62 <= q_62(60 downto 0) & '1' & "" when z_61='0' else real_q_61;
   two_r_61 <= r_61(61 downto 0) & '0';
   two_q_61 <= '0' & q_61(60 downto 1) & '1' & "0";
   pow_2_62 <= '0' & pow_2_61(62 downto 1);
   n_61 <= (two_q_61 + NOT(pow_2_62)) when s_61='1' else NOT(two_q_61 + pow_2_62);
   sub_62: IntAdder_63_F0_uid130
      port map ( Cin => one_bit,
                 X => two_r_61,
                 Y => n_61,
                 R => r_62);
   rem_z_61 <= '1' when r_62 = 0 else '0';
   z_62 <= rem_z_61 OR z_61;
   -- Convert the quotient to the digit set {0,1}
   sqrt_f <= q_62(60 downto 0) & '1' when z_61='0' else real_q_62; -- get the double of sqrt: first bit (=0) shifted out
----------------------------- Generate final posit -----------------------------
   XY_sf <= X_sf_3;
   XY_frac <= sqrt_f(60 downto 2);
   grd <= sqrt_f(1);
   stk <= sqrt_f(0);
   PositEncoder: PositFastEncoder_64_2_F0_uid132
      port map ( Frac => XY_frac,
                 Guard => grd,
                 NZN => XY_nzn,
                 SF => XY_sf,
                 Sign => XY_finalSgn,
                 Sticky => stk,
                 R => R);
---------------------------- End of vhdl generation ----------------------------
end architecture;

