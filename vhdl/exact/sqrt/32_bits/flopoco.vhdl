--------------------------------------------------------------------------------
--                       Normalizer_ZO_30_30_30_F0_uid6
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

entity Normalizer_ZO_30_30_30_F0_uid6 is
    port (X : in  std_logic_vector(29 downto 0);
          OZb : in  std_logic;
          Count : out  std_logic_vector(4 downto 0);
          R : out  std_logic_vector(29 downto 0)   );
end entity;

architecture arch of Normalizer_ZO_30_30_30_F0_uid6 is
signal level5 :  std_logic_vector(29 downto 0);
signal sozb :  std_logic;
signal count4 :  std_logic;
signal level4 :  std_logic_vector(29 downto 0);
signal count3 :  std_logic;
signal level3 :  std_logic_vector(29 downto 0);
signal count2 :  std_logic;
signal level2 :  std_logic_vector(29 downto 0);
signal count1 :  std_logic;
signal level1 :  std_logic_vector(29 downto 0);
signal count0 :  std_logic;
signal level0 :  std_logic_vector(29 downto 0);
signal sCount :  std_logic_vector(4 downto 0);
begin
   level5 <= X ;
   sozb<= OZb;
   count4<= '1' when level5(29 downto 14) = (29 downto 14=>sozb) else '0';
   level4<= level5(29 downto 0) when count4='0' else level5(13 downto 0) & (15 downto 0 => '0');

   count3<= '1' when level4(29 downto 22) = (29 downto 22=>sozb) else '0';
   level3<= level4(29 downto 0) when count3='0' else level4(21 downto 0) & (7 downto 0 => '0');

   count2<= '1' when level3(29 downto 26) = (29 downto 26=>sozb) else '0';
   level2<= level3(29 downto 0) when count2='0' else level3(25 downto 0) & (3 downto 0 => '0');

   count1<= '1' when level2(29 downto 28) = (29 downto 28=>sozb) else '0';
   level1<= level2(29 downto 0) when count1='0' else level2(27 downto 0) & (1 downto 0 => '0');

   count0<= '1' when level1(29 downto 29) = (29 downto 29=>sozb) else '0';
   level0<= level1(29 downto 0) when count0='0' else level1(28 downto 0) & (0 downto 0 => '0');

   R <= level0;
   sCount <= count4 & count3 & count2 & count1 & count0;
   Count <= sCount;
end architecture;

--------------------------------------------------------------------------------
--                       PositFastDecoder_32_2_F0_uid4
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

entity PositFastDecoder_32_2_F0_uid4 is
    port (X : in  std_logic_vector(31 downto 0);
          Sign : out  std_logic;
          SF : out  std_logic_vector(7 downto 0);
          Frac : out  std_logic_vector(26 downto 0);
          NZN : out  std_logic   );
end entity;

architecture arch of PositFastDecoder_32_2_F0_uid4 is
   component Normalizer_ZO_30_30_30_F0_uid6 is
      port ( X : in  std_logic_vector(29 downto 0);
             OZb : in  std_logic;
             Count : out  std_logic_vector(4 downto 0);
             R : out  std_logic_vector(29 downto 0)   );
   end component;

signal sgn :  std_logic;
signal pNZN :  std_logic;
signal rc :  std_logic;
signal regPosit :  std_logic_vector(29 downto 0);
signal regLength :  std_logic_vector(4 downto 0);
signal shiftedPosit :  std_logic_vector(29 downto 0);
signal k :  std_logic_vector(5 downto 0);
signal sgnVect :  std_logic_vector(1 downto 0);
signal exp :  std_logic_vector(1 downto 0);
signal pSF :  std_logic_vector(7 downto 0);
signal pFrac :  std_logic_vector(26 downto 0);
begin
--------------------------- Start of vhdl generation ---------------------------
--------------------------- Sign bit & special cases ---------------------------
   sgn <= X(31);
   pNZN <= '0' when (X(30 downto 0) = "0000000000000000000000000000000") else '1';
-------------- Count leading zeros/ones of regime & shift it out --------------
   rc <= X(30);
   regPosit <= X(29 downto 0);
   RegimeCounter: Normalizer_ZO_30_30_30_F0_uid6
      port map ( OZb => rc,
                 X => regPosit,
                 Count => regLength,
                 R => shiftedPosit);
----------------- Determine the scaling factor - regime & exp -----------------
   k <= "0" & regLength when rc /= sgn else "1" & NOT(regLength);
   sgnVect <= (others => sgn);
   exp <= shiftedPosit(28 downto 27) XOR sgnVect;
   pSF <= k & exp;
------------------------------- Extract fraction -------------------------------
   pFrac <= shiftedPosit(26 downto 0);
   Sign <= sgn;
   SF <= pSF;
   Frac <= pFrac;
   NZN <= pNZN;
---------------------------- End of vhdl generation ----------------------------
end architecture;

--------------------------------------------------------------------------------
--                            IntAdder_31_F0_uid8
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

entity IntAdder_31_F0_uid8 is
    port (X : in  std_logic_vector(30 downto 0);
          Y : in  std_logic_vector(30 downto 0);
          Cin : in  std_logic;
          R : out  std_logic_vector(30 downto 0)   );
end entity;

architecture arch of IntAdder_31_F0_uid8 is
signal Rtmp :  std_logic_vector(30 downto 0);
begin
   Rtmp <= X + Y + Cin;
   R <= Rtmp;
end architecture;

--------------------------------------------------------------------------------
--                            IntAdder_31_F0_uid10
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

entity IntAdder_31_F0_uid10 is
    port (X : in  std_logic_vector(30 downto 0);
          Y : in  std_logic_vector(30 downto 0);
          Cin : in  std_logic;
          R : out  std_logic_vector(30 downto 0)   );
end entity;

architecture arch of IntAdder_31_F0_uid10 is
signal Rtmp :  std_logic_vector(30 downto 0);
begin
   Rtmp <= X + Y + Cin;
   R <= Rtmp;
end architecture;

--------------------------------------------------------------------------------
--                            IntAdder_31_F0_uid12
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

entity IntAdder_31_F0_uid12 is
    port (X : in  std_logic_vector(30 downto 0);
          Y : in  std_logic_vector(30 downto 0);
          Cin : in  std_logic;
          R : out  std_logic_vector(30 downto 0)   );
end entity;

architecture arch of IntAdder_31_F0_uid12 is
signal Rtmp :  std_logic_vector(30 downto 0);
begin
   Rtmp <= X + Y + Cin;
   R <= Rtmp;
end architecture;

--------------------------------------------------------------------------------
--                            IntAdder_31_F0_uid14
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

entity IntAdder_31_F0_uid14 is
    port (X : in  std_logic_vector(30 downto 0);
          Y : in  std_logic_vector(30 downto 0);
          Cin : in  std_logic;
          R : out  std_logic_vector(30 downto 0)   );
end entity;

architecture arch of IntAdder_31_F0_uid14 is
signal Rtmp :  std_logic_vector(30 downto 0);
begin
   Rtmp <= X + Y + Cin;
   R <= Rtmp;
end architecture;

--------------------------------------------------------------------------------
--                            IntAdder_31_F0_uid16
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

entity IntAdder_31_F0_uid16 is
    port (X : in  std_logic_vector(30 downto 0);
          Y : in  std_logic_vector(30 downto 0);
          Cin : in  std_logic;
          R : out  std_logic_vector(30 downto 0)   );
end entity;

architecture arch of IntAdder_31_F0_uid16 is
signal Rtmp :  std_logic_vector(30 downto 0);
begin
   Rtmp <= X + Y + Cin;
   R <= Rtmp;
end architecture;

--------------------------------------------------------------------------------
--                            IntAdder_31_F0_uid18
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

entity IntAdder_31_F0_uid18 is
    port (X : in  std_logic_vector(30 downto 0);
          Y : in  std_logic_vector(30 downto 0);
          Cin : in  std_logic;
          R : out  std_logic_vector(30 downto 0)   );
end entity;

architecture arch of IntAdder_31_F0_uid18 is
signal Rtmp :  std_logic_vector(30 downto 0);
begin
   Rtmp <= X + Y + Cin;
   R <= Rtmp;
end architecture;

--------------------------------------------------------------------------------
--                            IntAdder_31_F0_uid20
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

entity IntAdder_31_F0_uid20 is
    port (X : in  std_logic_vector(30 downto 0);
          Y : in  std_logic_vector(30 downto 0);
          Cin : in  std_logic;
          R : out  std_logic_vector(30 downto 0)   );
end entity;

architecture arch of IntAdder_31_F0_uid20 is
signal Rtmp :  std_logic_vector(30 downto 0);
begin
   Rtmp <= X + Y + Cin;
   R <= Rtmp;
end architecture;

--------------------------------------------------------------------------------
--                            IntAdder_31_F0_uid22
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

entity IntAdder_31_F0_uid22 is
    port (X : in  std_logic_vector(30 downto 0);
          Y : in  std_logic_vector(30 downto 0);
          Cin : in  std_logic;
          R : out  std_logic_vector(30 downto 0)   );
end entity;

architecture arch of IntAdder_31_F0_uid22 is
signal Rtmp :  std_logic_vector(30 downto 0);
begin
   Rtmp <= X + Y + Cin;
   R <= Rtmp;
end architecture;

--------------------------------------------------------------------------------
--                            IntAdder_31_F0_uid24
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

entity IntAdder_31_F0_uid24 is
    port (X : in  std_logic_vector(30 downto 0);
          Y : in  std_logic_vector(30 downto 0);
          Cin : in  std_logic;
          R : out  std_logic_vector(30 downto 0)   );
end entity;

architecture arch of IntAdder_31_F0_uid24 is
signal Rtmp :  std_logic_vector(30 downto 0);
begin
   Rtmp <= X + Y + Cin;
   R <= Rtmp;
end architecture;

--------------------------------------------------------------------------------
--                            IntAdder_31_F0_uid26
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

entity IntAdder_31_F0_uid26 is
    port (X : in  std_logic_vector(30 downto 0);
          Y : in  std_logic_vector(30 downto 0);
          Cin : in  std_logic;
          R : out  std_logic_vector(30 downto 0)   );
end entity;

architecture arch of IntAdder_31_F0_uid26 is
signal Rtmp :  std_logic_vector(30 downto 0);
begin
   Rtmp <= X + Y + Cin;
   R <= Rtmp;
end architecture;

--------------------------------------------------------------------------------
--                            IntAdder_31_F0_uid28
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

entity IntAdder_31_F0_uid28 is
    port (X : in  std_logic_vector(30 downto 0);
          Y : in  std_logic_vector(30 downto 0);
          Cin : in  std_logic;
          R : out  std_logic_vector(30 downto 0)   );
end entity;

architecture arch of IntAdder_31_F0_uid28 is
signal Rtmp :  std_logic_vector(30 downto 0);
begin
   Rtmp <= X + Y + Cin;
   R <= Rtmp;
end architecture;

--------------------------------------------------------------------------------
--                            IntAdder_31_F0_uid30
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

entity IntAdder_31_F0_uid30 is
    port (X : in  std_logic_vector(30 downto 0);
          Y : in  std_logic_vector(30 downto 0);
          Cin : in  std_logic;
          R : out  std_logic_vector(30 downto 0)   );
end entity;

architecture arch of IntAdder_31_F0_uid30 is
signal Rtmp :  std_logic_vector(30 downto 0);
begin
   Rtmp <= X + Y + Cin;
   R <= Rtmp;
end architecture;

--------------------------------------------------------------------------------
--                            IntAdder_31_F0_uid32
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

entity IntAdder_31_F0_uid32 is
    port (X : in  std_logic_vector(30 downto 0);
          Y : in  std_logic_vector(30 downto 0);
          Cin : in  std_logic;
          R : out  std_logic_vector(30 downto 0)   );
end entity;

architecture arch of IntAdder_31_F0_uid32 is
signal Rtmp :  std_logic_vector(30 downto 0);
begin
   Rtmp <= X + Y + Cin;
   R <= Rtmp;
end architecture;

--------------------------------------------------------------------------------
--                            IntAdder_31_F0_uid34
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

entity IntAdder_31_F0_uid34 is
    port (X : in  std_logic_vector(30 downto 0);
          Y : in  std_logic_vector(30 downto 0);
          Cin : in  std_logic;
          R : out  std_logic_vector(30 downto 0)   );
end entity;

architecture arch of IntAdder_31_F0_uid34 is
signal Rtmp :  std_logic_vector(30 downto 0);
begin
   Rtmp <= X + Y + Cin;
   R <= Rtmp;
end architecture;

--------------------------------------------------------------------------------
--                            IntAdder_31_F0_uid36
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

entity IntAdder_31_F0_uid36 is
    port (X : in  std_logic_vector(30 downto 0);
          Y : in  std_logic_vector(30 downto 0);
          Cin : in  std_logic;
          R : out  std_logic_vector(30 downto 0)   );
end entity;

architecture arch of IntAdder_31_F0_uid36 is
signal Rtmp :  std_logic_vector(30 downto 0);
begin
   Rtmp <= X + Y + Cin;
   R <= Rtmp;
end architecture;

--------------------------------------------------------------------------------
--                            IntAdder_31_F0_uid38
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

entity IntAdder_31_F0_uid38 is
    port (X : in  std_logic_vector(30 downto 0);
          Y : in  std_logic_vector(30 downto 0);
          Cin : in  std_logic;
          R : out  std_logic_vector(30 downto 0)   );
end entity;

architecture arch of IntAdder_31_F0_uid38 is
signal Rtmp :  std_logic_vector(30 downto 0);
begin
   Rtmp <= X + Y + Cin;
   R <= Rtmp;
end architecture;

--------------------------------------------------------------------------------
--                            IntAdder_31_F0_uid40
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

entity IntAdder_31_F0_uid40 is
    port (X : in  std_logic_vector(30 downto 0);
          Y : in  std_logic_vector(30 downto 0);
          Cin : in  std_logic;
          R : out  std_logic_vector(30 downto 0)   );
end entity;

architecture arch of IntAdder_31_F0_uid40 is
signal Rtmp :  std_logic_vector(30 downto 0);
begin
   Rtmp <= X + Y + Cin;
   R <= Rtmp;
end architecture;

--------------------------------------------------------------------------------
--                            IntAdder_31_F0_uid42
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

entity IntAdder_31_F0_uid42 is
    port (X : in  std_logic_vector(30 downto 0);
          Y : in  std_logic_vector(30 downto 0);
          Cin : in  std_logic;
          R : out  std_logic_vector(30 downto 0)   );
end entity;

architecture arch of IntAdder_31_F0_uid42 is
signal Rtmp :  std_logic_vector(30 downto 0);
begin
   Rtmp <= X + Y + Cin;
   R <= Rtmp;
end architecture;

--------------------------------------------------------------------------------
--                            IntAdder_31_F0_uid44
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

entity IntAdder_31_F0_uid44 is
    port (X : in  std_logic_vector(30 downto 0);
          Y : in  std_logic_vector(30 downto 0);
          Cin : in  std_logic;
          R : out  std_logic_vector(30 downto 0)   );
end entity;

architecture arch of IntAdder_31_F0_uid44 is
signal Rtmp :  std_logic_vector(30 downto 0);
begin
   Rtmp <= X + Y + Cin;
   R <= Rtmp;
end architecture;

--------------------------------------------------------------------------------
--                            IntAdder_31_F0_uid46
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

entity IntAdder_31_F0_uid46 is
    port (X : in  std_logic_vector(30 downto 0);
          Y : in  std_logic_vector(30 downto 0);
          Cin : in  std_logic;
          R : out  std_logic_vector(30 downto 0)   );
end entity;

architecture arch of IntAdder_31_F0_uid46 is
signal Rtmp :  std_logic_vector(30 downto 0);
begin
   Rtmp <= X + Y + Cin;
   R <= Rtmp;
end architecture;

--------------------------------------------------------------------------------
--                            IntAdder_31_F0_uid48
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

entity IntAdder_31_F0_uid48 is
    port (X : in  std_logic_vector(30 downto 0);
          Y : in  std_logic_vector(30 downto 0);
          Cin : in  std_logic;
          R : out  std_logic_vector(30 downto 0)   );
end entity;

architecture arch of IntAdder_31_F0_uid48 is
signal Rtmp :  std_logic_vector(30 downto 0);
begin
   Rtmp <= X + Y + Cin;
   R <= Rtmp;
end architecture;

--------------------------------------------------------------------------------
--                            IntAdder_31_F0_uid50
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

entity IntAdder_31_F0_uid50 is
    port (X : in  std_logic_vector(30 downto 0);
          Y : in  std_logic_vector(30 downto 0);
          Cin : in  std_logic;
          R : out  std_logic_vector(30 downto 0)   );
end entity;

architecture arch of IntAdder_31_F0_uid50 is
signal Rtmp :  std_logic_vector(30 downto 0);
begin
   Rtmp <= X + Y + Cin;
   R <= Rtmp;
end architecture;

--------------------------------------------------------------------------------
--                            IntAdder_31_F0_uid52
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

entity IntAdder_31_F0_uid52 is
    port (X : in  std_logic_vector(30 downto 0);
          Y : in  std_logic_vector(30 downto 0);
          Cin : in  std_logic;
          R : out  std_logic_vector(30 downto 0)   );
end entity;

architecture arch of IntAdder_31_F0_uid52 is
signal Rtmp :  std_logic_vector(30 downto 0);
begin
   Rtmp <= X + Y + Cin;
   R <= Rtmp;
end architecture;

--------------------------------------------------------------------------------
--                            IntAdder_31_F0_uid54
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

entity IntAdder_31_F0_uid54 is
    port (X : in  std_logic_vector(30 downto 0);
          Y : in  std_logic_vector(30 downto 0);
          Cin : in  std_logic;
          R : out  std_logic_vector(30 downto 0)   );
end entity;

architecture arch of IntAdder_31_F0_uid54 is
signal Rtmp :  std_logic_vector(30 downto 0);
begin
   Rtmp <= X + Y + Cin;
   R <= Rtmp;
end architecture;

--------------------------------------------------------------------------------
--                            IntAdder_31_F0_uid56
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

entity IntAdder_31_F0_uid56 is
    port (X : in  std_logic_vector(30 downto 0);
          Y : in  std_logic_vector(30 downto 0);
          Cin : in  std_logic;
          R : out  std_logic_vector(30 downto 0)   );
end entity;

architecture arch of IntAdder_31_F0_uid56 is
signal Rtmp :  std_logic_vector(30 downto 0);
begin
   Rtmp <= X + Y + Cin;
   R <= Rtmp;
end architecture;

--------------------------------------------------------------------------------
--                            IntAdder_31_F0_uid58
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

entity IntAdder_31_F0_uid58 is
    port (X : in  std_logic_vector(30 downto 0);
          Y : in  std_logic_vector(30 downto 0);
          Cin : in  std_logic;
          R : out  std_logic_vector(30 downto 0)   );
end entity;

architecture arch of IntAdder_31_F0_uid58 is
signal Rtmp :  std_logic_vector(30 downto 0);
begin
   Rtmp <= X + Y + Cin;
   R <= Rtmp;
end architecture;

--------------------------------------------------------------------------------
--                            IntAdder_31_F0_uid60
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

entity IntAdder_31_F0_uid60 is
    port (X : in  std_logic_vector(30 downto 0);
          Y : in  std_logic_vector(30 downto 0);
          Cin : in  std_logic;
          R : out  std_logic_vector(30 downto 0)   );
end entity;

architecture arch of IntAdder_31_F0_uid60 is
signal Rtmp :  std_logic_vector(30 downto 0);
begin
   Rtmp <= X + Y + Cin;
   R <= Rtmp;
end architecture;

--------------------------------------------------------------------------------
--                            IntAdder_31_F0_uid62
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

entity IntAdder_31_F0_uid62 is
    port (X : in  std_logic_vector(30 downto 0);
          Y : in  std_logic_vector(30 downto 0);
          Cin : in  std_logic;
          R : out  std_logic_vector(30 downto 0)   );
end entity;

architecture arch of IntAdder_31_F0_uid62 is
signal Rtmp :  std_logic_vector(30 downto 0);
begin
   Rtmp <= X + Y + Cin;
   R <= Rtmp;
end architecture;

--------------------------------------------------------------------------------
--                            IntAdder_31_F0_uid64
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

entity IntAdder_31_F0_uid64 is
    port (X : in  std_logic_vector(30 downto 0);
          Y : in  std_logic_vector(30 downto 0);
          Cin : in  std_logic;
          R : out  std_logic_vector(30 downto 0)   );
end entity;

architecture arch of IntAdder_31_F0_uid64 is
signal Rtmp :  std_logic_vector(30 downto 0);
begin
   Rtmp <= X + Y + Cin;
   R <= Rtmp;
end architecture;

--------------------------------------------------------------------------------
--                            IntAdder_31_F0_uid66
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

entity IntAdder_31_F0_uid66 is
    port (X : in  std_logic_vector(30 downto 0);
          Y : in  std_logic_vector(30 downto 0);
          Cin : in  std_logic;
          R : out  std_logic_vector(30 downto 0)   );
end entity;

architecture arch of IntAdder_31_F0_uid66 is
signal Rtmp :  std_logic_vector(30 downto 0);
begin
   Rtmp <= X + Y + Cin;
   R <= Rtmp;
end architecture;

--------------------------------------------------------------------------------
--                  RightShifterSticky31_by_max_31_F0_uid70
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

entity RightShifterSticky31_by_max_31_F0_uid70 is
    port (X : in  std_logic_vector(30 downto 0);
          S : in  std_logic_vector(4 downto 0);
          padBit : in  std_logic;
          R : out  std_logic_vector(30 downto 0);
          Sticky : out  std_logic   );
end entity;

architecture arch of RightShifterSticky31_by_max_31_F0_uid70 is
signal ps :  std_logic_vector(4 downto 0);
signal Xpadded :  std_logic_vector(30 downto 0);
signal level5 :  std_logic_vector(30 downto 0);
signal stk4 :  std_logic;
signal level4 :  std_logic_vector(30 downto 0);
signal stk3 :  std_logic;
signal level3 :  std_logic_vector(30 downto 0);
signal stk2 :  std_logic;
signal level2 :  std_logic_vector(30 downto 0);
signal stk1 :  std_logic;
signal level1 :  std_logic_vector(30 downto 0);
signal stk0 :  std_logic;
signal level0 :  std_logic_vector(30 downto 0);
begin
   ps<= S;
   Xpadded <= X;
   level5<= Xpadded;
   stk4 <= '1' when (level5(15 downto 0)/="0000000000000000" and ps(4)='1')   else '0';
   level4 <=  level5 when  ps(4)='0'    else (15 downto 0 => padBit) & level5(30 downto 16);
   stk3 <= '1' when (level4(7 downto 0)/="00000000" and ps(3)='1') or stk4 ='1'   else '0';
   level3 <=  level4 when  ps(3)='0'    else (7 downto 0 => padBit) & level4(30 downto 8);
   stk2 <= '1' when (level3(3 downto 0)/="0000" and ps(2)='1') or stk3 ='1'   else '0';
   level2 <=  level3 when  ps(2)='0'    else (3 downto 0 => padBit) & level3(30 downto 4);
   stk1 <= '1' when (level2(1 downto 0)/="00" and ps(1)='1') or stk2 ='1'   else '0';
   level1 <=  level2 when  ps(1)='0'    else (1 downto 0 => padBit) & level2(30 downto 2);
   stk0 <= '1' when (level1(0 downto 0)/="0" and ps(0)='1') or stk1 ='1'   else '0';
   level0 <=  level1 when  ps(0)='0'    else (0 downto 0 => padBit) & level1(30 downto 1);
   R <= level0;
   Sticky <= stk0;
end architecture;

--------------------------------------------------------------------------------
--                       PositFastEncoder_32_2_F0_uid68
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

entity PositFastEncoder_32_2_F0_uid68 is
    port (Sign : in  std_logic;
          SF : in  std_logic_vector(8 downto 0);
          Frac : in  std_logic_vector(26 downto 0);
          Guard : in  std_logic;
          Sticky : in  std_logic;
          NZN : in  std_logic;
          R : out  std_logic_vector(31 downto 0)   );
end entity;

architecture arch of PositFastEncoder_32_2_F0_uid68 is
   component RightShifterSticky31_by_max_31_F0_uid70 is
      port ( X : in  std_logic_vector(30 downto 0);
             S : in  std_logic_vector(4 downto 0);
             padBit : in  std_logic;
             R : out  std_logic_vector(30 downto 0);
             Sticky : out  std_logic   );
   end component;

signal rc :  std_logic;
signal rcVect :  std_logic_vector(5 downto 0);
signal k :  std_logic_vector(5 downto 0);
signal sgnVect :  std_logic_vector(1 downto 0);
signal exp :  std_logic_vector(1 downto 0);
signal ovf :  std_logic;
signal regValue :  std_logic_vector(4 downto 0);
signal regNeg :  std_logic;
signal padBit :  std_logic;
signal inputShifter :  std_logic_vector(30 downto 0);
signal shiftedPosit :  std_logic_vector(30 downto 0);
signal stkBit :  std_logic;
signal unroundedPosit :  std_logic_vector(30 downto 0);
signal lsb :  std_logic;
signal rnd :  std_logic;
signal stk :  std_logic;
signal round :  std_logic;
signal roundedPosit :  std_logic_vector(30 downto 0);
signal unsignedPosit :  std_logic_vector(30 downto 0);
begin
--------------------------- Start of vhdl generation ---------------------------
----------------------------- Get value of regime -----------------------------
   rc <= SF(SF'high);
   rcVect <= (others => rc);
   k <= SF(7 downto 2) XOR rcVect;
   sgnVect <= (others => Sign);
   exp <= SF(1 downto 0) XOR sgnVect;
   -- Check for regime overflow
   ovf <= '1' when (k > "011101") else '0';
   regValue <= k(4 downto 0) when ovf = '0' else "11110";
-------------- Generate regime - shift out exponent and fraction --------------
   regNeg <= Sign XOR rc;
   padBit <= NOT(regNeg);
   inputShifter <= regNeg & exp & Frac & Guard;
   RegimeGenerator: RightShifterSticky31_by_max_31_F0_uid70
      port map ( S => regValue,
                 X => inputShifter,
                 padBit => padBit,
                 R => shiftedPosit,
                 Sticky => stkBit);
   unroundedPosit <= padBit & shiftedPosit(30 downto 1);
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
--                          (PositSqrt_32_2_F0_uid2)
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
    port (X : in  std_logic_vector(31 downto 0);
          R : out  std_logic_vector(31 downto 0)   );
end entity;

architecture arch of PositSqrt is
   component PositFastDecoder_32_2_F0_uid4 is
      port ( X : in  std_logic_vector(31 downto 0);
             Sign : out  std_logic;
             SF : out  std_logic_vector(7 downto 0);
             Frac : out  std_logic_vector(26 downto 0);
             NZN : out  std_logic   );
   end component;

   component IntAdder_31_F0_uid8 is
      port ( X : in  std_logic_vector(30 downto 0);
             Y : in  std_logic_vector(30 downto 0);
             Cin : in  std_logic;
             R : out  std_logic_vector(30 downto 0)   );
   end component;

   component IntAdder_31_F0_uid10 is
      port ( X : in  std_logic_vector(30 downto 0);
             Y : in  std_logic_vector(30 downto 0);
             Cin : in  std_logic;
             R : out  std_logic_vector(30 downto 0)   );
   end component;

   component IntAdder_31_F0_uid12 is
      port ( X : in  std_logic_vector(30 downto 0);
             Y : in  std_logic_vector(30 downto 0);
             Cin : in  std_logic;
             R : out  std_logic_vector(30 downto 0)   );
   end component;

   component IntAdder_31_F0_uid14 is
      port ( X : in  std_logic_vector(30 downto 0);
             Y : in  std_logic_vector(30 downto 0);
             Cin : in  std_logic;
             R : out  std_logic_vector(30 downto 0)   );
   end component;

   component IntAdder_31_F0_uid16 is
      port ( X : in  std_logic_vector(30 downto 0);
             Y : in  std_logic_vector(30 downto 0);
             Cin : in  std_logic;
             R : out  std_logic_vector(30 downto 0)   );
   end component;

   component IntAdder_31_F0_uid18 is
      port ( X : in  std_logic_vector(30 downto 0);
             Y : in  std_logic_vector(30 downto 0);
             Cin : in  std_logic;
             R : out  std_logic_vector(30 downto 0)   );
   end component;

   component IntAdder_31_F0_uid20 is
      port ( X : in  std_logic_vector(30 downto 0);
             Y : in  std_logic_vector(30 downto 0);
             Cin : in  std_logic;
             R : out  std_logic_vector(30 downto 0)   );
   end component;

   component IntAdder_31_F0_uid22 is
      port ( X : in  std_logic_vector(30 downto 0);
             Y : in  std_logic_vector(30 downto 0);
             Cin : in  std_logic;
             R : out  std_logic_vector(30 downto 0)   );
   end component;

   component IntAdder_31_F0_uid24 is
      port ( X : in  std_logic_vector(30 downto 0);
             Y : in  std_logic_vector(30 downto 0);
             Cin : in  std_logic;
             R : out  std_logic_vector(30 downto 0)   );
   end component;

   component IntAdder_31_F0_uid26 is
      port ( X : in  std_logic_vector(30 downto 0);
             Y : in  std_logic_vector(30 downto 0);
             Cin : in  std_logic;
             R : out  std_logic_vector(30 downto 0)   );
   end component;

   component IntAdder_31_F0_uid28 is
      port ( X : in  std_logic_vector(30 downto 0);
             Y : in  std_logic_vector(30 downto 0);
             Cin : in  std_logic;
             R : out  std_logic_vector(30 downto 0)   );
   end component;

   component IntAdder_31_F0_uid30 is
      port ( X : in  std_logic_vector(30 downto 0);
             Y : in  std_logic_vector(30 downto 0);
             Cin : in  std_logic;
             R : out  std_logic_vector(30 downto 0)   );
   end component;

   component IntAdder_31_F0_uid32 is
      port ( X : in  std_logic_vector(30 downto 0);
             Y : in  std_logic_vector(30 downto 0);
             Cin : in  std_logic;
             R : out  std_logic_vector(30 downto 0)   );
   end component;

   component IntAdder_31_F0_uid34 is
      port ( X : in  std_logic_vector(30 downto 0);
             Y : in  std_logic_vector(30 downto 0);
             Cin : in  std_logic;
             R : out  std_logic_vector(30 downto 0)   );
   end component;

   component IntAdder_31_F0_uid36 is
      port ( X : in  std_logic_vector(30 downto 0);
             Y : in  std_logic_vector(30 downto 0);
             Cin : in  std_logic;
             R : out  std_logic_vector(30 downto 0)   );
   end component;

   component IntAdder_31_F0_uid38 is
      port ( X : in  std_logic_vector(30 downto 0);
             Y : in  std_logic_vector(30 downto 0);
             Cin : in  std_logic;
             R : out  std_logic_vector(30 downto 0)   );
   end component;

   component IntAdder_31_F0_uid40 is
      port ( X : in  std_logic_vector(30 downto 0);
             Y : in  std_logic_vector(30 downto 0);
             Cin : in  std_logic;
             R : out  std_logic_vector(30 downto 0)   );
   end component;

   component IntAdder_31_F0_uid42 is
      port ( X : in  std_logic_vector(30 downto 0);
             Y : in  std_logic_vector(30 downto 0);
             Cin : in  std_logic;
             R : out  std_logic_vector(30 downto 0)   );
   end component;

   component IntAdder_31_F0_uid44 is
      port ( X : in  std_logic_vector(30 downto 0);
             Y : in  std_logic_vector(30 downto 0);
             Cin : in  std_logic;
             R : out  std_logic_vector(30 downto 0)   );
   end component;

   component IntAdder_31_F0_uid46 is
      port ( X : in  std_logic_vector(30 downto 0);
             Y : in  std_logic_vector(30 downto 0);
             Cin : in  std_logic;
             R : out  std_logic_vector(30 downto 0)   );
   end component;

   component IntAdder_31_F0_uid48 is
      port ( X : in  std_logic_vector(30 downto 0);
             Y : in  std_logic_vector(30 downto 0);
             Cin : in  std_logic;
             R : out  std_logic_vector(30 downto 0)   );
   end component;

   component IntAdder_31_F0_uid50 is
      port ( X : in  std_logic_vector(30 downto 0);
             Y : in  std_logic_vector(30 downto 0);
             Cin : in  std_logic;
             R : out  std_logic_vector(30 downto 0)   );
   end component;

   component IntAdder_31_F0_uid52 is
      port ( X : in  std_logic_vector(30 downto 0);
             Y : in  std_logic_vector(30 downto 0);
             Cin : in  std_logic;
             R : out  std_logic_vector(30 downto 0)   );
   end component;

   component IntAdder_31_F0_uid54 is
      port ( X : in  std_logic_vector(30 downto 0);
             Y : in  std_logic_vector(30 downto 0);
             Cin : in  std_logic;
             R : out  std_logic_vector(30 downto 0)   );
   end component;

   component IntAdder_31_F0_uid56 is
      port ( X : in  std_logic_vector(30 downto 0);
             Y : in  std_logic_vector(30 downto 0);
             Cin : in  std_logic;
             R : out  std_logic_vector(30 downto 0)   );
   end component;

   component IntAdder_31_F0_uid58 is
      port ( X : in  std_logic_vector(30 downto 0);
             Y : in  std_logic_vector(30 downto 0);
             Cin : in  std_logic;
             R : out  std_logic_vector(30 downto 0)   );
   end component;

   component IntAdder_31_F0_uid60 is
      port ( X : in  std_logic_vector(30 downto 0);
             Y : in  std_logic_vector(30 downto 0);
             Cin : in  std_logic;
             R : out  std_logic_vector(30 downto 0)   );
   end component;

   component IntAdder_31_F0_uid62 is
      port ( X : in  std_logic_vector(30 downto 0);
             Y : in  std_logic_vector(30 downto 0);
             Cin : in  std_logic;
             R : out  std_logic_vector(30 downto 0)   );
   end component;

   component IntAdder_31_F0_uid64 is
      port ( X : in  std_logic_vector(30 downto 0);
             Y : in  std_logic_vector(30 downto 0);
             Cin : in  std_logic;
             R : out  std_logic_vector(30 downto 0)   );
   end component;

   component IntAdder_31_F0_uid66 is
      port ( X : in  std_logic_vector(30 downto 0);
             Y : in  std_logic_vector(30 downto 0);
             Cin : in  std_logic;
             R : out  std_logic_vector(30 downto 0)   );
   end component;

   component PositFastEncoder_32_2_F0_uid68 is
      port ( Sign : in  std_logic;
             SF : in  std_logic_vector(8 downto 0);
             Frac : in  std_logic_vector(26 downto 0);
             Guard : in  std_logic;
             Sticky : in  std_logic;
             NZN : in  std_logic;
             R : out  std_logic_vector(31 downto 0)   );
   end component;

signal X_sgn :  std_logic;
signal X_sf :  std_logic_vector(7 downto 0);
signal X_f :  std_logic_vector(26 downto 0);
signal X_nzn :  std_logic;
signal XY_nzn :  std_logic;
signal XY_finalSgn :  std_logic;
signal odd_exp :  std_logic;
signal X_sf_3 :  std_logic_vector(8 downto 0);
signal one_bit :  std_logic;
signal r_0 :  std_logic_vector(30 downto 0);
signal q_0 :  std_logic_vector(29 downto 0);
signal real_q_0 :  std_logic_vector(29 downto 0);
signal pow_2_0 :  std_logic_vector(30 downto 0);
signal s_0 :  std_logic;
signal q_1 :  std_logic_vector(29 downto 0);
signal real_q_1 :  std_logic_vector(29 downto 0);
signal two_r_0 :  std_logic_vector(30 downto 0);
signal two_q_0 :  std_logic_vector(30 downto 0);
signal pow_2_1 :  std_logic_vector(30 downto 0);
signal n_0 :  std_logic_vector(30 downto 0);
signal r_1 :  std_logic_vector(30 downto 0);
signal rem_z_0 :  std_logic;
signal z_1 :  std_logic;
signal s_1 :  std_logic;
signal q_2 :  std_logic_vector(29 downto 0);
signal real_q_2 :  std_logic_vector(29 downto 0);
signal two_r_1 :  std_logic_vector(30 downto 0);
signal two_q_1 :  std_logic_vector(30 downto 0);
signal pow_2_2 :  std_logic_vector(30 downto 0);
signal n_1 :  std_logic_vector(30 downto 0);
signal r_2 :  std_logic_vector(30 downto 0);
signal rem_z_1 :  std_logic;
signal z_2 :  std_logic;
signal s_2 :  std_logic;
signal q_3 :  std_logic_vector(29 downto 0);
signal real_q_3 :  std_logic_vector(29 downto 0);
signal two_r_2 :  std_logic_vector(30 downto 0);
signal two_q_2 :  std_logic_vector(30 downto 0);
signal pow_2_3 :  std_logic_vector(30 downto 0);
signal n_2 :  std_logic_vector(30 downto 0);
signal r_3 :  std_logic_vector(30 downto 0);
signal rem_z_2 :  std_logic;
signal z_3 :  std_logic;
signal s_3 :  std_logic;
signal q_4 :  std_logic_vector(29 downto 0);
signal real_q_4 :  std_logic_vector(29 downto 0);
signal two_r_3 :  std_logic_vector(30 downto 0);
signal two_q_3 :  std_logic_vector(30 downto 0);
signal pow_2_4 :  std_logic_vector(30 downto 0);
signal n_3 :  std_logic_vector(30 downto 0);
signal r_4 :  std_logic_vector(30 downto 0);
signal rem_z_3 :  std_logic;
signal z_4 :  std_logic;
signal s_4 :  std_logic;
signal q_5 :  std_logic_vector(29 downto 0);
signal real_q_5 :  std_logic_vector(29 downto 0);
signal two_r_4 :  std_logic_vector(30 downto 0);
signal two_q_4 :  std_logic_vector(30 downto 0);
signal pow_2_5 :  std_logic_vector(30 downto 0);
signal n_4 :  std_logic_vector(30 downto 0);
signal r_5 :  std_logic_vector(30 downto 0);
signal rem_z_4 :  std_logic;
signal z_5 :  std_logic;
signal s_5 :  std_logic;
signal q_6 :  std_logic_vector(29 downto 0);
signal real_q_6 :  std_logic_vector(29 downto 0);
signal two_r_5 :  std_logic_vector(30 downto 0);
signal two_q_5 :  std_logic_vector(30 downto 0);
signal pow_2_6 :  std_logic_vector(30 downto 0);
signal n_5 :  std_logic_vector(30 downto 0);
signal r_6 :  std_logic_vector(30 downto 0);
signal rem_z_5 :  std_logic;
signal z_6 :  std_logic;
signal s_6 :  std_logic;
signal q_7 :  std_logic_vector(29 downto 0);
signal real_q_7 :  std_logic_vector(29 downto 0);
signal two_r_6 :  std_logic_vector(30 downto 0);
signal two_q_6 :  std_logic_vector(30 downto 0);
signal pow_2_7 :  std_logic_vector(30 downto 0);
signal n_6 :  std_logic_vector(30 downto 0);
signal r_7 :  std_logic_vector(30 downto 0);
signal rem_z_6 :  std_logic;
signal z_7 :  std_logic;
signal s_7 :  std_logic;
signal q_8 :  std_logic_vector(29 downto 0);
signal real_q_8 :  std_logic_vector(29 downto 0);
signal two_r_7 :  std_logic_vector(30 downto 0);
signal two_q_7 :  std_logic_vector(30 downto 0);
signal pow_2_8 :  std_logic_vector(30 downto 0);
signal n_7 :  std_logic_vector(30 downto 0);
signal r_8 :  std_logic_vector(30 downto 0);
signal rem_z_7 :  std_logic;
signal z_8 :  std_logic;
signal s_8 :  std_logic;
signal q_9 :  std_logic_vector(29 downto 0);
signal real_q_9 :  std_logic_vector(29 downto 0);
signal two_r_8 :  std_logic_vector(30 downto 0);
signal two_q_8 :  std_logic_vector(30 downto 0);
signal pow_2_9 :  std_logic_vector(30 downto 0);
signal n_8 :  std_logic_vector(30 downto 0);
signal r_9 :  std_logic_vector(30 downto 0);
signal rem_z_8 :  std_logic;
signal z_9 :  std_logic;
signal s_9 :  std_logic;
signal q_10 :  std_logic_vector(29 downto 0);
signal real_q_10 :  std_logic_vector(29 downto 0);
signal two_r_9 :  std_logic_vector(30 downto 0);
signal two_q_9 :  std_logic_vector(30 downto 0);
signal pow_2_10 :  std_logic_vector(30 downto 0);
signal n_9 :  std_logic_vector(30 downto 0);
signal r_10 :  std_logic_vector(30 downto 0);
signal rem_z_9 :  std_logic;
signal z_10 :  std_logic;
signal s_10 :  std_logic;
signal q_11 :  std_logic_vector(29 downto 0);
signal real_q_11 :  std_logic_vector(29 downto 0);
signal two_r_10 :  std_logic_vector(30 downto 0);
signal two_q_10 :  std_logic_vector(30 downto 0);
signal pow_2_11 :  std_logic_vector(30 downto 0);
signal n_10 :  std_logic_vector(30 downto 0);
signal r_11 :  std_logic_vector(30 downto 0);
signal rem_z_10 :  std_logic;
signal z_11 :  std_logic;
signal s_11 :  std_logic;
signal q_12 :  std_logic_vector(29 downto 0);
signal real_q_12 :  std_logic_vector(29 downto 0);
signal two_r_11 :  std_logic_vector(30 downto 0);
signal two_q_11 :  std_logic_vector(30 downto 0);
signal pow_2_12 :  std_logic_vector(30 downto 0);
signal n_11 :  std_logic_vector(30 downto 0);
signal r_12 :  std_logic_vector(30 downto 0);
signal rem_z_11 :  std_logic;
signal z_12 :  std_logic;
signal s_12 :  std_logic;
signal q_13 :  std_logic_vector(29 downto 0);
signal real_q_13 :  std_logic_vector(29 downto 0);
signal two_r_12 :  std_logic_vector(30 downto 0);
signal two_q_12 :  std_logic_vector(30 downto 0);
signal pow_2_13 :  std_logic_vector(30 downto 0);
signal n_12 :  std_logic_vector(30 downto 0);
signal r_13 :  std_logic_vector(30 downto 0);
signal rem_z_12 :  std_logic;
signal z_13 :  std_logic;
signal s_13 :  std_logic;
signal q_14 :  std_logic_vector(29 downto 0);
signal real_q_14 :  std_logic_vector(29 downto 0);
signal two_r_13 :  std_logic_vector(30 downto 0);
signal two_q_13 :  std_logic_vector(30 downto 0);
signal pow_2_14 :  std_logic_vector(30 downto 0);
signal n_13 :  std_logic_vector(30 downto 0);
signal r_14 :  std_logic_vector(30 downto 0);
signal rem_z_13 :  std_logic;
signal z_14 :  std_logic;
signal s_14 :  std_logic;
signal q_15 :  std_logic_vector(29 downto 0);
signal real_q_15 :  std_logic_vector(29 downto 0);
signal two_r_14 :  std_logic_vector(30 downto 0);
signal two_q_14 :  std_logic_vector(30 downto 0);
signal pow_2_15 :  std_logic_vector(30 downto 0);
signal n_14 :  std_logic_vector(30 downto 0);
signal r_15 :  std_logic_vector(30 downto 0);
signal rem_z_14 :  std_logic;
signal z_15 :  std_logic;
signal s_15 :  std_logic;
signal q_16 :  std_logic_vector(29 downto 0);
signal real_q_16 :  std_logic_vector(29 downto 0);
signal two_r_15 :  std_logic_vector(30 downto 0);
signal two_q_15 :  std_logic_vector(30 downto 0);
signal pow_2_16 :  std_logic_vector(30 downto 0);
signal n_15 :  std_logic_vector(30 downto 0);
signal r_16 :  std_logic_vector(30 downto 0);
signal rem_z_15 :  std_logic;
signal z_16 :  std_logic;
signal s_16 :  std_logic;
signal q_17 :  std_logic_vector(29 downto 0);
signal real_q_17 :  std_logic_vector(29 downto 0);
signal two_r_16 :  std_logic_vector(30 downto 0);
signal two_q_16 :  std_logic_vector(30 downto 0);
signal pow_2_17 :  std_logic_vector(30 downto 0);
signal n_16 :  std_logic_vector(30 downto 0);
signal r_17 :  std_logic_vector(30 downto 0);
signal rem_z_16 :  std_logic;
signal z_17 :  std_logic;
signal s_17 :  std_logic;
signal q_18 :  std_logic_vector(29 downto 0);
signal real_q_18 :  std_logic_vector(29 downto 0);
signal two_r_17 :  std_logic_vector(30 downto 0);
signal two_q_17 :  std_logic_vector(30 downto 0);
signal pow_2_18 :  std_logic_vector(30 downto 0);
signal n_17 :  std_logic_vector(30 downto 0);
signal r_18 :  std_logic_vector(30 downto 0);
signal rem_z_17 :  std_logic;
signal z_18 :  std_logic;
signal s_18 :  std_logic;
signal q_19 :  std_logic_vector(29 downto 0);
signal real_q_19 :  std_logic_vector(29 downto 0);
signal two_r_18 :  std_logic_vector(30 downto 0);
signal two_q_18 :  std_logic_vector(30 downto 0);
signal pow_2_19 :  std_logic_vector(30 downto 0);
signal n_18 :  std_logic_vector(30 downto 0);
signal r_19 :  std_logic_vector(30 downto 0);
signal rem_z_18 :  std_logic;
signal z_19 :  std_logic;
signal s_19 :  std_logic;
signal q_20 :  std_logic_vector(29 downto 0);
signal real_q_20 :  std_logic_vector(29 downto 0);
signal two_r_19 :  std_logic_vector(30 downto 0);
signal two_q_19 :  std_logic_vector(30 downto 0);
signal pow_2_20 :  std_logic_vector(30 downto 0);
signal n_19 :  std_logic_vector(30 downto 0);
signal r_20 :  std_logic_vector(30 downto 0);
signal rem_z_19 :  std_logic;
signal z_20 :  std_logic;
signal s_20 :  std_logic;
signal q_21 :  std_logic_vector(29 downto 0);
signal real_q_21 :  std_logic_vector(29 downto 0);
signal two_r_20 :  std_logic_vector(30 downto 0);
signal two_q_20 :  std_logic_vector(30 downto 0);
signal pow_2_21 :  std_logic_vector(30 downto 0);
signal n_20 :  std_logic_vector(30 downto 0);
signal r_21 :  std_logic_vector(30 downto 0);
signal rem_z_20 :  std_logic;
signal z_21 :  std_logic;
signal s_21 :  std_logic;
signal q_22 :  std_logic_vector(29 downto 0);
signal real_q_22 :  std_logic_vector(29 downto 0);
signal two_r_21 :  std_logic_vector(30 downto 0);
signal two_q_21 :  std_logic_vector(30 downto 0);
signal pow_2_22 :  std_logic_vector(30 downto 0);
signal n_21 :  std_logic_vector(30 downto 0);
signal r_22 :  std_logic_vector(30 downto 0);
signal rem_z_21 :  std_logic;
signal z_22 :  std_logic;
signal s_22 :  std_logic;
signal q_23 :  std_logic_vector(29 downto 0);
signal real_q_23 :  std_logic_vector(29 downto 0);
signal two_r_22 :  std_logic_vector(30 downto 0);
signal two_q_22 :  std_logic_vector(30 downto 0);
signal pow_2_23 :  std_logic_vector(30 downto 0);
signal n_22 :  std_logic_vector(30 downto 0);
signal r_23 :  std_logic_vector(30 downto 0);
signal rem_z_22 :  std_logic;
signal z_23 :  std_logic;
signal s_23 :  std_logic;
signal q_24 :  std_logic_vector(29 downto 0);
signal real_q_24 :  std_logic_vector(29 downto 0);
signal two_r_23 :  std_logic_vector(30 downto 0);
signal two_q_23 :  std_logic_vector(30 downto 0);
signal pow_2_24 :  std_logic_vector(30 downto 0);
signal n_23 :  std_logic_vector(30 downto 0);
signal r_24 :  std_logic_vector(30 downto 0);
signal rem_z_23 :  std_logic;
signal z_24 :  std_logic;
signal s_24 :  std_logic;
signal q_25 :  std_logic_vector(29 downto 0);
signal real_q_25 :  std_logic_vector(29 downto 0);
signal two_r_24 :  std_logic_vector(30 downto 0);
signal two_q_24 :  std_logic_vector(30 downto 0);
signal pow_2_25 :  std_logic_vector(30 downto 0);
signal n_24 :  std_logic_vector(30 downto 0);
signal r_25 :  std_logic_vector(30 downto 0);
signal rem_z_24 :  std_logic;
signal z_25 :  std_logic;
signal s_25 :  std_logic;
signal q_26 :  std_logic_vector(29 downto 0);
signal real_q_26 :  std_logic_vector(29 downto 0);
signal two_r_25 :  std_logic_vector(30 downto 0);
signal two_q_25 :  std_logic_vector(30 downto 0);
signal pow_2_26 :  std_logic_vector(30 downto 0);
signal n_25 :  std_logic_vector(30 downto 0);
signal r_26 :  std_logic_vector(30 downto 0);
signal rem_z_25 :  std_logic;
signal z_26 :  std_logic;
signal s_26 :  std_logic;
signal q_27 :  std_logic_vector(29 downto 0);
signal real_q_27 :  std_logic_vector(29 downto 0);
signal two_r_26 :  std_logic_vector(30 downto 0);
signal two_q_26 :  std_logic_vector(30 downto 0);
signal pow_2_27 :  std_logic_vector(30 downto 0);
signal n_26 :  std_logic_vector(30 downto 0);
signal r_27 :  std_logic_vector(30 downto 0);
signal rem_z_26 :  std_logic;
signal z_27 :  std_logic;
signal s_27 :  std_logic;
signal q_28 :  std_logic_vector(29 downto 0);
signal real_q_28 :  std_logic_vector(29 downto 0);
signal two_r_27 :  std_logic_vector(30 downto 0);
signal two_q_27 :  std_logic_vector(30 downto 0);
signal pow_2_28 :  std_logic_vector(30 downto 0);
signal n_27 :  std_logic_vector(30 downto 0);
signal r_28 :  std_logic_vector(30 downto 0);
signal rem_z_27 :  std_logic;
signal z_28 :  std_logic;
signal s_28 :  std_logic;
signal q_29 :  std_logic_vector(29 downto 0);
signal real_q_29 :  std_logic_vector(29 downto 0);
signal two_r_28 :  std_logic_vector(30 downto 0);
signal two_q_28 :  std_logic_vector(30 downto 0);
signal pow_2_29 :  std_logic_vector(30 downto 0);
signal n_28 :  std_logic_vector(30 downto 0);
signal r_29 :  std_logic_vector(30 downto 0);
signal rem_z_28 :  std_logic;
signal z_29 :  std_logic;
signal s_29 :  std_logic;
signal q_30 :  std_logic_vector(29 downto 0);
signal real_q_30 :  std_logic_vector(29 downto 0);
signal two_r_29 :  std_logic_vector(30 downto 0);
signal two_q_29 :  std_logic_vector(30 downto 0);
signal pow_2_30 :  std_logic_vector(30 downto 0);
signal n_29 :  std_logic_vector(30 downto 0);
signal r_30 :  std_logic_vector(30 downto 0);
signal rem_z_29 :  std_logic;
signal z_30 :  std_logic;
signal sqrt_f :  std_logic_vector(29 downto 0);
signal XY_sf :  std_logic_vector(8 downto 0);
signal XY_frac :  std_logic_vector(26 downto 0);
signal grd :  std_logic;
signal stk :  std_logic;
begin
--------------------------- Start of vhdl generation ---------------------------
------------------------------- Decode X operand -------------------------------
   X_decoder: PositFastDecoder_32_2_F0_uid4
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
   X_sf_3 <= X_sf(X_sf'high) & X_sf(X_sf'high) & X_sf(7 downto 1);
----------------------------- Sqrt of the fraction -----------------------------
--------------------------- Non-Restoring algorithm ---------------------------
   one_bit <= '1';
   r_0 <= ("001" & X_f & '0') when odd_exp='1' else ("0001" & X_f);
   q_0 <= (others => '0');
   real_q_0 <= (others => '0');
   pow_2_0 <= "0100000000000000000000000000000";
   -- Iteration 1
   s_0 <= r_0(30);
   q_1 <= NOT(s_0) & "00000000000000000000000000000";
   real_q_1 <= (s_0) & "00000000000000000000000000000";
   two_r_0 <= r_0(29 downto 0) & '0';
   two_q_0 <= (others => '0');
   pow_2_1 <= '0' & pow_2_0(30 downto 1);
   n_0 <= (two_q_0 + NOT(pow_2_1)) when s_0='1' else NOT(two_q_0 + pow_2_1);
   sub_1: IntAdder_31_F0_uid8
      port map ( Cin => one_bit,
                 X => two_r_0,
                 Y => n_0,
                 R => r_1);
   rem_z_0 <= '1' when r_1 = 0 else '0';
   z_1 <= rem_z_0;
   -- Iteration 2
   s_1 <= r_1(30);
   q_2 <= q_1(29 downto 29) & NOT(s_1 OR z_1) & "0000000000000000000000000000";
   real_q_2 <= q_2(28 downto 28) & '1' & "0000000000000000000000000000" when z_1='0' else real_q_1;
   two_r_1 <= r_1(29 downto 0) & '0';
   two_q_1 <= '0' & '1' & "00000000000000000000000000000";
   pow_2_2 <= '0' & pow_2_1(30 downto 1);
   n_1 <= (two_q_1 + NOT(pow_2_2)) when s_1='1' else NOT(two_q_1 + pow_2_2);
   sub_2: IntAdder_31_F0_uid10
      port map ( Cin => one_bit,
                 X => two_r_1,
                 Y => n_1,
                 R => r_2);
   rem_z_1 <= '1' when r_2 = 0 else '0';
   z_2 <= rem_z_1 OR z_1;
   -- Iteration 3
   s_2 <= r_2(30);
   q_3 <= q_2(29 downto 28) & NOT(s_2 OR z_2) & "000000000000000000000000000";
   real_q_3 <= q_3(28 downto 27) & '1' & "000000000000000000000000000" when z_2='0' else real_q_2;
   two_r_2 <= r_2(29 downto 0) & '0';
   two_q_2 <= '0' & q_2(28 downto 28) & '1' & "0000000000000000000000000000";
   pow_2_3 <= '0' & pow_2_2(30 downto 1);
   n_2 <= (two_q_2 + NOT(pow_2_3)) when s_2='1' else NOT(two_q_2 + pow_2_3);
   sub_3: IntAdder_31_F0_uid12
      port map ( Cin => one_bit,
                 X => two_r_2,
                 Y => n_2,
                 R => r_3);
   rem_z_2 <= '1' when r_3 = 0 else '0';
   z_3 <= rem_z_2 OR z_2;
   -- Iteration 4
   s_3 <= r_3(30);
   q_4 <= q_3(29 downto 27) & NOT(s_3 OR z_3) & "00000000000000000000000000";
   real_q_4 <= q_4(28 downto 26) & '1' & "00000000000000000000000000" when z_3='0' else real_q_3;
   two_r_3 <= r_3(29 downto 0) & '0';
   two_q_3 <= '0' & q_3(28 downto 27) & '1' & "000000000000000000000000000";
   pow_2_4 <= '0' & pow_2_3(30 downto 1);
   n_3 <= (two_q_3 + NOT(pow_2_4)) when s_3='1' else NOT(two_q_3 + pow_2_4);
   sub_4: IntAdder_31_F0_uid14
      port map ( Cin => one_bit,
                 X => two_r_3,
                 Y => n_3,
                 R => r_4);
   rem_z_3 <= '1' when r_4 = 0 else '0';
   z_4 <= rem_z_3 OR z_3;
   -- Iteration 5
   s_4 <= r_4(30);
   q_5 <= q_4(29 downto 26) & NOT(s_4 OR z_4) & "0000000000000000000000000";
   real_q_5 <= q_5(28 downto 25) & '1' & "0000000000000000000000000" when z_4='0' else real_q_4;
   two_r_4 <= r_4(29 downto 0) & '0';
   two_q_4 <= '0' & q_4(28 downto 26) & '1' & "00000000000000000000000000";
   pow_2_5 <= '0' & pow_2_4(30 downto 1);
   n_4 <= (two_q_4 + NOT(pow_2_5)) when s_4='1' else NOT(two_q_4 + pow_2_5);
   sub_5: IntAdder_31_F0_uid16
      port map ( Cin => one_bit,
                 X => two_r_4,
                 Y => n_4,
                 R => r_5);
   rem_z_4 <= '1' when r_5 = 0 else '0';
   z_5 <= rem_z_4 OR z_4;
   -- Iteration 6
   s_5 <= r_5(30);
   q_6 <= q_5(29 downto 25) & NOT(s_5 OR z_5) & "000000000000000000000000";
   real_q_6 <= q_6(28 downto 24) & '1' & "000000000000000000000000" when z_5='0' else real_q_5;
   two_r_5 <= r_5(29 downto 0) & '0';
   two_q_5 <= '0' & q_5(28 downto 25) & '1' & "0000000000000000000000000";
   pow_2_6 <= '0' & pow_2_5(30 downto 1);
   n_5 <= (two_q_5 + NOT(pow_2_6)) when s_5='1' else NOT(two_q_5 + pow_2_6);
   sub_6: IntAdder_31_F0_uid18
      port map ( Cin => one_bit,
                 X => two_r_5,
                 Y => n_5,
                 R => r_6);
   rem_z_5 <= '1' when r_6 = 0 else '0';
   z_6 <= rem_z_5 OR z_5;
   -- Iteration 7
   s_6 <= r_6(30);
   q_7 <= q_6(29 downto 24) & NOT(s_6 OR z_6) & "00000000000000000000000";
   real_q_7 <= q_7(28 downto 23) & '1' & "00000000000000000000000" when z_6='0' else real_q_6;
   two_r_6 <= r_6(29 downto 0) & '0';
   two_q_6 <= '0' & q_6(28 downto 24) & '1' & "000000000000000000000000";
   pow_2_7 <= '0' & pow_2_6(30 downto 1);
   n_6 <= (two_q_6 + NOT(pow_2_7)) when s_6='1' else NOT(two_q_6 + pow_2_7);
   sub_7: IntAdder_31_F0_uid20
      port map ( Cin => one_bit,
                 X => two_r_6,
                 Y => n_6,
                 R => r_7);
   rem_z_6 <= '1' when r_7 = 0 else '0';
   z_7 <= rem_z_6 OR z_6;
   -- Iteration 8
   s_7 <= r_7(30);
   q_8 <= q_7(29 downto 23) & NOT(s_7 OR z_7) & "0000000000000000000000";
   real_q_8 <= q_8(28 downto 22) & '1' & "0000000000000000000000" when z_7='0' else real_q_7;
   two_r_7 <= r_7(29 downto 0) & '0';
   two_q_7 <= '0' & q_7(28 downto 23) & '1' & "00000000000000000000000";
   pow_2_8 <= '0' & pow_2_7(30 downto 1);
   n_7 <= (two_q_7 + NOT(pow_2_8)) when s_7='1' else NOT(two_q_7 + pow_2_8);
   sub_8: IntAdder_31_F0_uid22
      port map ( Cin => one_bit,
                 X => two_r_7,
                 Y => n_7,
                 R => r_8);
   rem_z_7 <= '1' when r_8 = 0 else '0';
   z_8 <= rem_z_7 OR z_7;
   -- Iteration 9
   s_8 <= r_8(30);
   q_9 <= q_8(29 downto 22) & NOT(s_8 OR z_8) & "000000000000000000000";
   real_q_9 <= q_9(28 downto 21) & '1' & "000000000000000000000" when z_8='0' else real_q_8;
   two_r_8 <= r_8(29 downto 0) & '0';
   two_q_8 <= '0' & q_8(28 downto 22) & '1' & "0000000000000000000000";
   pow_2_9 <= '0' & pow_2_8(30 downto 1);
   n_8 <= (two_q_8 + NOT(pow_2_9)) when s_8='1' else NOT(two_q_8 + pow_2_9);
   sub_9: IntAdder_31_F0_uid24
      port map ( Cin => one_bit,
                 X => two_r_8,
                 Y => n_8,
                 R => r_9);
   rem_z_8 <= '1' when r_9 = 0 else '0';
   z_9 <= rem_z_8 OR z_8;
   -- Iteration 10
   s_9 <= r_9(30);
   q_10 <= q_9(29 downto 21) & NOT(s_9 OR z_9) & "00000000000000000000";
   real_q_10 <= q_10(28 downto 20) & '1' & "00000000000000000000" when z_9='0' else real_q_9;
   two_r_9 <= r_9(29 downto 0) & '0';
   two_q_9 <= '0' & q_9(28 downto 21) & '1' & "000000000000000000000";
   pow_2_10 <= '0' & pow_2_9(30 downto 1);
   n_9 <= (two_q_9 + NOT(pow_2_10)) when s_9='1' else NOT(two_q_9 + pow_2_10);
   sub_10: IntAdder_31_F0_uid26
      port map ( Cin => one_bit,
                 X => two_r_9,
                 Y => n_9,
                 R => r_10);
   rem_z_9 <= '1' when r_10 = 0 else '0';
   z_10 <= rem_z_9 OR z_9;
   -- Iteration 11
   s_10 <= r_10(30);
   q_11 <= q_10(29 downto 20) & NOT(s_10 OR z_10) & "0000000000000000000";
   real_q_11 <= q_11(28 downto 19) & '1' & "0000000000000000000" when z_10='0' else real_q_10;
   two_r_10 <= r_10(29 downto 0) & '0';
   two_q_10 <= '0' & q_10(28 downto 20) & '1' & "00000000000000000000";
   pow_2_11 <= '0' & pow_2_10(30 downto 1);
   n_10 <= (two_q_10 + NOT(pow_2_11)) when s_10='1' else NOT(two_q_10 + pow_2_11);
   sub_11: IntAdder_31_F0_uid28
      port map ( Cin => one_bit,
                 X => two_r_10,
                 Y => n_10,
                 R => r_11);
   rem_z_10 <= '1' when r_11 = 0 else '0';
   z_11 <= rem_z_10 OR z_10;
   -- Iteration 12
   s_11 <= r_11(30);
   q_12 <= q_11(29 downto 19) & NOT(s_11 OR z_11) & "000000000000000000";
   real_q_12 <= q_12(28 downto 18) & '1' & "000000000000000000" when z_11='0' else real_q_11;
   two_r_11 <= r_11(29 downto 0) & '0';
   two_q_11 <= '0' & q_11(28 downto 19) & '1' & "0000000000000000000";
   pow_2_12 <= '0' & pow_2_11(30 downto 1);
   n_11 <= (two_q_11 + NOT(pow_2_12)) when s_11='1' else NOT(two_q_11 + pow_2_12);
   sub_12: IntAdder_31_F0_uid30
      port map ( Cin => one_bit,
                 X => two_r_11,
                 Y => n_11,
                 R => r_12);
   rem_z_11 <= '1' when r_12 = 0 else '0';
   z_12 <= rem_z_11 OR z_11;
   -- Iteration 13
   s_12 <= r_12(30);
   q_13 <= q_12(29 downto 18) & NOT(s_12 OR z_12) & "00000000000000000";
   real_q_13 <= q_13(28 downto 17) & '1' & "00000000000000000" when z_12='0' else real_q_12;
   two_r_12 <= r_12(29 downto 0) & '0';
   two_q_12 <= '0' & q_12(28 downto 18) & '1' & "000000000000000000";
   pow_2_13 <= '0' & pow_2_12(30 downto 1);
   n_12 <= (two_q_12 + NOT(pow_2_13)) when s_12='1' else NOT(two_q_12 + pow_2_13);
   sub_13: IntAdder_31_F0_uid32
      port map ( Cin => one_bit,
                 X => two_r_12,
                 Y => n_12,
                 R => r_13);
   rem_z_12 <= '1' when r_13 = 0 else '0';
   z_13 <= rem_z_12 OR z_12;
   -- Iteration 14
   s_13 <= r_13(30);
   q_14 <= q_13(29 downto 17) & NOT(s_13 OR z_13) & "0000000000000000";
   real_q_14 <= q_14(28 downto 16) & '1' & "0000000000000000" when z_13='0' else real_q_13;
   two_r_13 <= r_13(29 downto 0) & '0';
   two_q_13 <= '0' & q_13(28 downto 17) & '1' & "00000000000000000";
   pow_2_14 <= '0' & pow_2_13(30 downto 1);
   n_13 <= (two_q_13 + NOT(pow_2_14)) when s_13='1' else NOT(two_q_13 + pow_2_14);
   sub_14: IntAdder_31_F0_uid34
      port map ( Cin => one_bit,
                 X => two_r_13,
                 Y => n_13,
                 R => r_14);
   rem_z_13 <= '1' when r_14 = 0 else '0';
   z_14 <= rem_z_13 OR z_13;
   -- Iteration 15
   s_14 <= r_14(30);
   q_15 <= q_14(29 downto 16) & NOT(s_14 OR z_14) & "000000000000000";
   real_q_15 <= q_15(28 downto 15) & '1' & "000000000000000" when z_14='0' else real_q_14;
   two_r_14 <= r_14(29 downto 0) & '0';
   two_q_14 <= '0' & q_14(28 downto 16) & '1' & "0000000000000000";
   pow_2_15 <= '0' & pow_2_14(30 downto 1);
   n_14 <= (two_q_14 + NOT(pow_2_15)) when s_14='1' else NOT(two_q_14 + pow_2_15);
   sub_15: IntAdder_31_F0_uid36
      port map ( Cin => one_bit,
                 X => two_r_14,
                 Y => n_14,
                 R => r_15);
   rem_z_14 <= '1' when r_15 = 0 else '0';
   z_15 <= rem_z_14 OR z_14;
   -- Iteration 16
   s_15 <= r_15(30);
   q_16 <= q_15(29 downto 15) & NOT(s_15 OR z_15) & "00000000000000";
   real_q_16 <= q_16(28 downto 14) & '1' & "00000000000000" when z_15='0' else real_q_15;
   two_r_15 <= r_15(29 downto 0) & '0';
   two_q_15 <= '0' & q_15(28 downto 15) & '1' & "000000000000000";
   pow_2_16 <= '0' & pow_2_15(30 downto 1);
   n_15 <= (two_q_15 + NOT(pow_2_16)) when s_15='1' else NOT(two_q_15 + pow_2_16);
   sub_16: IntAdder_31_F0_uid38
      port map ( Cin => one_bit,
                 X => two_r_15,
                 Y => n_15,
                 R => r_16);
   rem_z_15 <= '1' when r_16 = 0 else '0';
   z_16 <= rem_z_15 OR z_15;
   -- Iteration 17
   s_16 <= r_16(30);
   q_17 <= q_16(29 downto 14) & NOT(s_16 OR z_16) & "0000000000000";
   real_q_17 <= q_17(28 downto 13) & '1' & "0000000000000" when z_16='0' else real_q_16;
   two_r_16 <= r_16(29 downto 0) & '0';
   two_q_16 <= '0' & q_16(28 downto 14) & '1' & "00000000000000";
   pow_2_17 <= '0' & pow_2_16(30 downto 1);
   n_16 <= (two_q_16 + NOT(pow_2_17)) when s_16='1' else NOT(two_q_16 + pow_2_17);
   sub_17: IntAdder_31_F0_uid40
      port map ( Cin => one_bit,
                 X => two_r_16,
                 Y => n_16,
                 R => r_17);
   rem_z_16 <= '1' when r_17 = 0 else '0';
   z_17 <= rem_z_16 OR z_16;
   -- Iteration 18
   s_17 <= r_17(30);
   q_18 <= q_17(29 downto 13) & NOT(s_17 OR z_17) & "000000000000";
   real_q_18 <= q_18(28 downto 12) & '1' & "000000000000" when z_17='0' else real_q_17;
   two_r_17 <= r_17(29 downto 0) & '0';
   two_q_17 <= '0' & q_17(28 downto 13) & '1' & "0000000000000";
   pow_2_18 <= '0' & pow_2_17(30 downto 1);
   n_17 <= (two_q_17 + NOT(pow_2_18)) when s_17='1' else NOT(two_q_17 + pow_2_18);
   sub_18: IntAdder_31_F0_uid42
      port map ( Cin => one_bit,
                 X => two_r_17,
                 Y => n_17,
                 R => r_18);
   rem_z_17 <= '1' when r_18 = 0 else '0';
   z_18 <= rem_z_17 OR z_17;
   -- Iteration 19
   s_18 <= r_18(30);
   q_19 <= q_18(29 downto 12) & NOT(s_18 OR z_18) & "00000000000";
   real_q_19 <= q_19(28 downto 11) & '1' & "00000000000" when z_18='0' else real_q_18;
   two_r_18 <= r_18(29 downto 0) & '0';
   two_q_18 <= '0' & q_18(28 downto 12) & '1' & "000000000000";
   pow_2_19 <= '0' & pow_2_18(30 downto 1);
   n_18 <= (two_q_18 + NOT(pow_2_19)) when s_18='1' else NOT(two_q_18 + pow_2_19);
   sub_19: IntAdder_31_F0_uid44
      port map ( Cin => one_bit,
                 X => two_r_18,
                 Y => n_18,
                 R => r_19);
   rem_z_18 <= '1' when r_19 = 0 else '0';
   z_19 <= rem_z_18 OR z_18;
   -- Iteration 20
   s_19 <= r_19(30);
   q_20 <= q_19(29 downto 11) & NOT(s_19 OR z_19) & "0000000000";
   real_q_20 <= q_20(28 downto 10) & '1' & "0000000000" when z_19='0' else real_q_19;
   two_r_19 <= r_19(29 downto 0) & '0';
   two_q_19 <= '0' & q_19(28 downto 11) & '1' & "00000000000";
   pow_2_20 <= '0' & pow_2_19(30 downto 1);
   n_19 <= (two_q_19 + NOT(pow_2_20)) when s_19='1' else NOT(two_q_19 + pow_2_20);
   sub_20: IntAdder_31_F0_uid46
      port map ( Cin => one_bit,
                 X => two_r_19,
                 Y => n_19,
                 R => r_20);
   rem_z_19 <= '1' when r_20 = 0 else '0';
   z_20 <= rem_z_19 OR z_19;
   -- Iteration 21
   s_20 <= r_20(30);
   q_21 <= q_20(29 downto 10) & NOT(s_20 OR z_20) & "000000000";
   real_q_21 <= q_21(28 downto 9) & '1' & "000000000" when z_20='0' else real_q_20;
   two_r_20 <= r_20(29 downto 0) & '0';
   two_q_20 <= '0' & q_20(28 downto 10) & '1' & "0000000000";
   pow_2_21 <= '0' & pow_2_20(30 downto 1);
   n_20 <= (two_q_20 + NOT(pow_2_21)) when s_20='1' else NOT(two_q_20 + pow_2_21);
   sub_21: IntAdder_31_F0_uid48
      port map ( Cin => one_bit,
                 X => two_r_20,
                 Y => n_20,
                 R => r_21);
   rem_z_20 <= '1' when r_21 = 0 else '0';
   z_21 <= rem_z_20 OR z_20;
   -- Iteration 22
   s_21 <= r_21(30);
   q_22 <= q_21(29 downto 9) & NOT(s_21 OR z_21) & "00000000";
   real_q_22 <= q_22(28 downto 8) & '1' & "00000000" when z_21='0' else real_q_21;
   two_r_21 <= r_21(29 downto 0) & '0';
   two_q_21 <= '0' & q_21(28 downto 9) & '1' & "000000000";
   pow_2_22 <= '0' & pow_2_21(30 downto 1);
   n_21 <= (two_q_21 + NOT(pow_2_22)) when s_21='1' else NOT(two_q_21 + pow_2_22);
   sub_22: IntAdder_31_F0_uid50
      port map ( Cin => one_bit,
                 X => two_r_21,
                 Y => n_21,
                 R => r_22);
   rem_z_21 <= '1' when r_22 = 0 else '0';
   z_22 <= rem_z_21 OR z_21;
   -- Iteration 23
   s_22 <= r_22(30);
   q_23 <= q_22(29 downto 8) & NOT(s_22 OR z_22) & "0000000";
   real_q_23 <= q_23(28 downto 7) & '1' & "0000000" when z_22='0' else real_q_22;
   two_r_22 <= r_22(29 downto 0) & '0';
   two_q_22 <= '0' & q_22(28 downto 8) & '1' & "00000000";
   pow_2_23 <= '0' & pow_2_22(30 downto 1);
   n_22 <= (two_q_22 + NOT(pow_2_23)) when s_22='1' else NOT(two_q_22 + pow_2_23);
   sub_23: IntAdder_31_F0_uid52
      port map ( Cin => one_bit,
                 X => two_r_22,
                 Y => n_22,
                 R => r_23);
   rem_z_22 <= '1' when r_23 = 0 else '0';
   z_23 <= rem_z_22 OR z_22;
   -- Iteration 24
   s_23 <= r_23(30);
   q_24 <= q_23(29 downto 7) & NOT(s_23 OR z_23) & "000000";
   real_q_24 <= q_24(28 downto 6) & '1' & "000000" when z_23='0' else real_q_23;
   two_r_23 <= r_23(29 downto 0) & '0';
   two_q_23 <= '0' & q_23(28 downto 7) & '1' & "0000000";
   pow_2_24 <= '0' & pow_2_23(30 downto 1);
   n_23 <= (two_q_23 + NOT(pow_2_24)) when s_23='1' else NOT(two_q_23 + pow_2_24);
   sub_24: IntAdder_31_F0_uid54
      port map ( Cin => one_bit,
                 X => two_r_23,
                 Y => n_23,
                 R => r_24);
   rem_z_23 <= '1' when r_24 = 0 else '0';
   z_24 <= rem_z_23 OR z_23;
   -- Iteration 25
   s_24 <= r_24(30);
   q_25 <= q_24(29 downto 6) & NOT(s_24 OR z_24) & "00000";
   real_q_25 <= q_25(28 downto 5) & '1' & "00000" when z_24='0' else real_q_24;
   two_r_24 <= r_24(29 downto 0) & '0';
   two_q_24 <= '0' & q_24(28 downto 6) & '1' & "000000";
   pow_2_25 <= '0' & pow_2_24(30 downto 1);
   n_24 <= (two_q_24 + NOT(pow_2_25)) when s_24='1' else NOT(two_q_24 + pow_2_25);
   sub_25: IntAdder_31_F0_uid56
      port map ( Cin => one_bit,
                 X => two_r_24,
                 Y => n_24,
                 R => r_25);
   rem_z_24 <= '1' when r_25 = 0 else '0';
   z_25 <= rem_z_24 OR z_24;
   -- Iteration 26
   s_25 <= r_25(30);
   q_26 <= q_25(29 downto 5) & NOT(s_25 OR z_25) & "0000";
   real_q_26 <= q_26(28 downto 4) & '1' & "0000" when z_25='0' else real_q_25;
   two_r_25 <= r_25(29 downto 0) & '0';
   two_q_25 <= '0' & q_25(28 downto 5) & '1' & "00000";
   pow_2_26 <= '0' & pow_2_25(30 downto 1);
   n_25 <= (two_q_25 + NOT(pow_2_26)) when s_25='1' else NOT(two_q_25 + pow_2_26);
   sub_26: IntAdder_31_F0_uid58
      port map ( Cin => one_bit,
                 X => two_r_25,
                 Y => n_25,
                 R => r_26);
   rem_z_25 <= '1' when r_26 = 0 else '0';
   z_26 <= rem_z_25 OR z_25;
   -- Iteration 27
   s_26 <= r_26(30);
   q_27 <= q_26(29 downto 4) & NOT(s_26 OR z_26) & "000";
   real_q_27 <= q_27(28 downto 3) & '1' & "000" when z_26='0' else real_q_26;
   two_r_26 <= r_26(29 downto 0) & '0';
   two_q_26 <= '0' & q_26(28 downto 4) & '1' & "0000";
   pow_2_27 <= '0' & pow_2_26(30 downto 1);
   n_26 <= (two_q_26 + NOT(pow_2_27)) when s_26='1' else NOT(two_q_26 + pow_2_27);
   sub_27: IntAdder_31_F0_uid60
      port map ( Cin => one_bit,
                 X => two_r_26,
                 Y => n_26,
                 R => r_27);
   rem_z_26 <= '1' when r_27 = 0 else '0';
   z_27 <= rem_z_26 OR z_26;
   -- Iteration 28
   s_27 <= r_27(30);
   q_28 <= q_27(29 downto 3) & NOT(s_27 OR z_27) & "00";
   real_q_28 <= q_28(28 downto 2) & '1' & "00" when z_27='0' else real_q_27;
   two_r_27 <= r_27(29 downto 0) & '0';
   two_q_27 <= '0' & q_27(28 downto 3) & '1' & "000";
   pow_2_28 <= '0' & pow_2_27(30 downto 1);
   n_27 <= (two_q_27 + NOT(pow_2_28)) when s_27='1' else NOT(two_q_27 + pow_2_28);
   sub_28: IntAdder_31_F0_uid62
      port map ( Cin => one_bit,
                 X => two_r_27,
                 Y => n_27,
                 R => r_28);
   rem_z_27 <= '1' when r_28 = 0 else '0';
   z_28 <= rem_z_27 OR z_27;
   -- Iteration 29
   s_28 <= r_28(30);
   q_29 <= q_28(29 downto 2) & NOT(s_28 OR z_28) & "0";
   real_q_29 <= q_29(28 downto 1) & '1' & "0" when z_28='0' else real_q_28;
   two_r_28 <= r_28(29 downto 0) & '0';
   two_q_28 <= '0' & q_28(28 downto 2) & '1' & "00";
   pow_2_29 <= '0' & pow_2_28(30 downto 1);
   n_28 <= (two_q_28 + NOT(pow_2_29)) when s_28='1' else NOT(two_q_28 + pow_2_29);
   sub_29: IntAdder_31_F0_uid64
      port map ( Cin => one_bit,
                 X => two_r_28,
                 Y => n_28,
                 R => r_29);
   rem_z_28 <= '1' when r_29 = 0 else '0';
   z_29 <= rem_z_28 OR z_28;
   -- Iteration 30
   s_29 <= r_29(30);
   q_30 <= q_29(29 downto 1) & NOT(s_29 OR z_29) & "";
   real_q_30 <= q_30(28 downto 0) & '1' & "" when z_29='0' else real_q_29;
   two_r_29 <= r_29(29 downto 0) & '0';
   two_q_29 <= '0' & q_29(28 downto 1) & '1' & "0";
   pow_2_30 <= '0' & pow_2_29(30 downto 1);
   n_29 <= (two_q_29 + NOT(pow_2_30)) when s_29='1' else NOT(two_q_29 + pow_2_30);
   sub_30: IntAdder_31_F0_uid66
      port map ( Cin => one_bit,
                 X => two_r_29,
                 Y => n_29,
                 R => r_30);
   rem_z_29 <= '1' when r_30 = 0 else '0';
   z_30 <= rem_z_29 OR z_29;
   -- Convert the quotient to the digit set {0,1}
   sqrt_f <= q_30(28 downto 0) & '1' when z_29='0' else real_q_30; -- get the double of sqrt: first bit (=0) shifted out
----------------------------- Generate final posit -----------------------------
   XY_sf <= X_sf_3;
   XY_frac <= sqrt_f(28 downto 2);
   grd <= sqrt_f(1);
   stk <= sqrt_f(0);
   PositEncoder: PositFastEncoder_32_2_F0_uid68
      port map ( Frac => XY_frac,
                 Guard => grd,
                 NZN => XY_nzn,
                 SF => XY_sf,
                 Sign => XY_finalSgn,
                 Sticky => stk,
                 R => R);
---------------------------- End of vhdl generation ----------------------------
end architecture;

