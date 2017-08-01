----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    08:00:10 07/17/2017 
-- Design Name: 
-- Module Name:    CPU_ALL - Behavioral 
-- Project Name: 
-- Target Devices: 
-- Tool versions: 
-- Description: 
--
-- Dependencies: 
--
-- Revision: 
-- Revision 0.01 - File Created
-- Additional Comments: 
--
----------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity CPU_ALL is
    Port ( CLK : in  STD_LOGIC;
           RST : in  STD_LOGIC;
           nMREQ : out  STD_LOGIC;
           nRD : out  STD_LOGIC;
           nWR : out  STD_LOGIC;
           nBLE : out  STD_LOGIC;
           nBHE : out  STD_LOGIC;
           ABus : out  STD_LOGIC_VECTOR (15 downto 0);
           DBus : inout  STD_LOGIC_VECTOR (15 downto 0);
           nPREQ : out  STD_LOGIC;
           nPRD : out  STD_LOGIC;
           nPWR : out  STD_LOGIC;
           IOAD : out  STD_LOGIC_VECTOR (1 downto 0);
           IOR0 : in  STD_LOGIC_VECTOR (7 downto 0);
           IOR1 : in  STD_LOGIC_VECTOR (7 downto 0);
           IOR2 : in  STD_LOGIC_VECTOR (7 downto 0);
           IOR3 : in  STD_LOGIC_VECTOR (7 downto 0);
           IOW0 : out  STD_LOGIC_VECTOR (7 downto 0);
           IOW1 : out  STD_LOGIC_VECTOR (7 downto 0);
           IOW2 : out  STD_LOGIC_VECTOR (7 downto 0);
           IOW3 : out  STD_LOGIC_VECTOR (7 downto 0);
			  Ttest : out STD_LOGIC_VECTOR(3 downto 0);
			  IRtest : out STD_LOGIC_VECTOR(15 downto 0)
			  );
end CPU_ALL;

architecture Behavioral of CPU_ALL is
component CPU_CLK is
	PORT(	CLK : in std_logic;
			RST : in std_logic;
			T : out std_logic_vector(3 downto 0));
end component;

component CPU_fetch is
	Port ( CLK : in STD_LOGIC;
			  T0 : in  STD_LOGIC;
           RST : in  STD_LOGIC;
           PCupdate : in  STD_LOGIC;
           PCnew : in  STD_LOGIC_VECTOR (15 downto 0);
			  IRin : in STD_LOGIC_VECTOR(15 downto 0);
           IRr : out  STD_LOGIC;
           PCout : out  STD_LOGIC_VECTOR (15 downto 0);
           IRout : out  STD_LOGIC_VECTOR (15 downto 0));
end component;

component CPU_calculate is
	Port ( CLK : in STD_LOGIC;
			 RST : in STD_LOGIC;
			  T1 : in  STD_LOGIC;
			  Rupdate : in  STD_LOGIC;
			  Raddr : in  STD_LOGIC_VECTOR (2 downto 0);
			  Rnew : in  STD_LOGIC_VECTOR (7 downto 0);
			  IRin : in STD_LOGIC_VECTOR(15 downto 0);
			  JZctrl : out STD_LOGIC;
			  ALU_out : out  STD_LOGIC_VECTOR(7 downto 0);
			  ADDR_out : out  STD_LOGIC_VECTOR(15 downto 0));
end component;

component CPU_MemAccess is
	Port ( CLK : in STD_LOGIC;
			  T2 : in STD_LOGIC;
			  IRin : in  STD_LOGIC_VECTOR (4 downto 0);
           ALU_in : in  STD_LOGIC_VECTOR (7 downto 0);
           ADDR_in : in  STD_LOGIC_VECTOR (15 downto 0);
           WRm : out  STD_LOGIC;
           WRio : out  STD_LOGIC;
           RDm : out  STD_LOGIC;
           RDio : out  STD_LOGIC;
			  ADDR_out : out STD_LOGIC_VECTOR(15 downto 0);
           data : inout  STD_LOGIC_VECTOR (7 downto 0);
           Rtempout : out  STD_LOGIC_VECTOR (15 downto 0));
end component;

component CPU_WriteBack is
    Port ( T3 : in  STD_LOGIC;
			  CLK : in STD_LOGIC;
           IRin : in  STD_LOGIC_VECTOR (7 downto 0);
           Rtempin : in  STD_LOGIC_VECTOR (15 downto 0);
           JZctrl : in  STD_LOGIC;
           PCupdate : out  STD_LOGIC;
           PCnew : out  STD_LOGIC_VECTOR (15 downto 0);
           Rupdate : out  STD_LOGIC;
           Raddr : out  STD_LOGIC_VECTOR(2 downto 0);
           Rnew : out  STD_LOGIC_VECTOR (7 downto 0));
end component;

component CPU_MemManage is 
	Port ( IRr : in  STD_LOGIC;
           WRm : in  STD_LOGIC;
           RDM : in  STD_LOGIC;
           WRio : in  STD_LOGIC;
           RDio : in  STD_LOGIC;
           PCin : in  STD_LOGIC_VECTOR (15 downto 0);
           IRout : out  STD_LOGIC_VECTOR (15 downto 0);
           data : inout  STD_LOGIC_VECTOR (7 downto 0);
			  ADDR_in : in STD_LOGIC_VECTOR(15 downto 0);
           nMREQ : out  STD_LOGIC;
           nRD : out  STD_LOGIC;
           nWR : out  STD_LOGIC;
           nBHE : out  STD_LOGIC;
           nBLE : out  STD_LOGIC;
           ABus : out  STD_LOGIC_VECTOR (15 downto 0);
           DBus : inout  STD_LOGIC_VECTOR (15 downto 0);
           nPREQ : out  STD_LOGIC;
           nPRD : out  STD_LOGIC;
           nPWR : out  STD_LOGIC;
           IOW0 : out  STD_LOGIC_VECTOR(7 downto 0);
           IOW1 : out  STD_LOGIC_VECTOR(7 downto 0);
           IOW2 : out  STD_LOGIC_VECTOR(7 downto 0);
           IOW3 : out  STD_LOGIC_VECTOR(7 downto 0);
           IOR0 : in  STD_LOGIC_VECTOR(7 downto 0);
           IOR1 : in  STD_LOGIC_VECTOR(7 downto 0);
           IOR2 : in  STD_LOGIC_VECTOR(7 downto 0);
           IOR3 : in  STD_LOGIC_VECTOR(7 downto 0);
			  IOAD : out  STD_LOGIC_VECTOR(1 downto 0));
end component;

signal T : std_logic_vector(3 downto 0);
signal IR : std_logic_vector(15 downto 0);
signal ALU : std_logic_vector(7 downto 0);
signal ADDR : std_logic_vector(15 downto 0);
signal PCupdate : std_logic;
signal PCnew : std_logic_vector(15 downto 0);
signal Rupdate : std_logic;
signal Raddr : std_logic_vector(2 downto 0);
signal Rnew : std_logic_vector(7 downto 0);
signal JZctrl : std_logic;
signal Rtemp : std_logic_vector(15 downto 0);
signal IRr : std_logic;
signal PC : std_logic_vector(15 downto 0);
signal IRmem : std_logic_vector(15 downto 0);
signal WRm : std_logic;
signal RDm : std_logic;
signal WRio : std_logic;
signal RDio : std_logic;
signal datamem : std_logic_vector(7 downto 0);
signal ADDRmem : std_logic_vector(15 downto 0);

begin

CLK_U : CPU_CLK port map(
	clk => clk,
	rst => rst,
	T => T
);

FETCH_U : CPU_fetch port map(
	clk => clk,
	T0 => T(0),
	RST => RST,
	PCupdate => PCupdate,
	PCnew => PCnew,
	IRin => IRmem,
	IRr => IRr,
	PCout => PC,
	IRout => IR
);

CALCULATE_U : CPU_calculate port map(
	CLK => CLK,
	RST => RST,
	T1 => T(1),
	Rupdate => Rupdate,
	Raddr => Raddr,
	Rnew => Rnew,
	IRin => IR,
	JZctrl => JZctrl,
	ALU_out => ALU,
	ADDR_out => ADDR
);

MEMACCESS_U : CPU_MemAccess port map(
	CLK => CLK,
	T2 => T(2),
	IRin => IR(15 downto 11),
	ALU_in => ALU,
	ADDR_in => ADDR,
	WRm => WRm,
	RDm => RDm,
	WRio => WRio,
	RDio => RDio,
	ADDR_out => ADDRmem,
	data => datamem,
	Rtempout => Rtemp
);

WRITEBACK_U : CPU_WriteBack port map(
	T3 => T(3),
   CLK => CLK,
   IRin => IR(15 downto 8),
   Rtempin => Rtemp,
   JZctrl => JZctrl,
   PCupdate => PCupdate,
   PCnew => PCnew, 
   Rupdate => Rupdate,
   Raddr => Raddr, 
   Rnew => Rnew
);

MemManage_U : CPU_MemManage port map(
	IRr => IRr,
	WRm => WRm,
	RDm => RDm,
	WRio => WRio,
	RDio => RDio,
	PCin => PC,
	IRout => IRmem,
	data => datamem,
	ADDR_in => ADDRmem,
	nMREQ => nMREQ,
	nWR => nWR,
	nRD => nRD,
	nBHE => nBHE,
	nBLE => nBLE,
	ABus => ABus,
	DBus => DBus,
	nPREQ => nPREQ,
	nPRD => nPRD,
	nPWR => nPWR,
	IOW0 => IOW0,
	IOW1 => IOW1,
	IOW2 => IOW2,
	IOW3 => IOW3,
	IOR0 => IOR0,
	IOR1 => IOR1,
	IOR2 => IOR2,
	IOR3 => IOR3,
	IOAD => IOAD
);
Ttest <= T;
IRtest <= IR;
end Behavioral;

