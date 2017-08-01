----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    22:09:02 07/15/2017 
-- Design Name: 
-- Module Name:    CPU_MemManage - Behavioral 
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

entity CPU_MemManage is
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
end CPU_MemManage;

architecture Behavioral of CPU_MemManage is

signal nMREQtemp,nWRtemp,nRDtemp,nPREQtemp,nPWRtemp,nPRDtemp,nBLEtemp,nBHEtemp : std_logic;
signal dataH : std_logic_vector(7 downto 0);

begin


IOAD <= ADDR_in(1 downto 0);

ABus <= 	PCin when IRr = '1' else
			ADDR_in;

nMREQ <= nMREQtemp;
nWR <= nWRtemp;
nRD <= nRDtemp;
nBLE <= nBLEtemp;		
nBHE <= nBHEtemp;
nPREQ <= nPREQtemp;
nPWR <= nPWRtemp;
nPRD <= nPRDtemp;

--控制，读写双分离

--此处在访存模块不复原会出问题！！！！

process(IRr,WRm,RDm,WRio,RDio)
variable ctrls : std_logic_vector(4 downto 0);
begin
		ctrls(4) := IRr;
		ctrls(3) := WRm;
		ctrls(2) := RDm;
		ctrls(1) := WRio;
		ctrls(0) := RDio;
		case ctrls is
			when "11111" =>
				nMREQtemp <= '0';
				nWRtemp <= '1';
				nRDtemp <= '0';
				nBLEtemp <= '0';		
				nBHEtemp <= '0';
				nPREQtemp <= '1';
				nPWRtemp <= '1';
				nPRDtemp <= '1';
			when "00111" =>
				nMREQtemp <= '0';
				nWRtemp <= '0';
				nRDtemp <= '1';
				nBLEtemp <= '0';		
				nBHEtemp <= '1';
				nPREQtemp <= '1';
				nPWRtemp <= '1';
				nPRDtemp <= '1';
			when "01011" =>
				nMREQtemp <= '0';
				nWRtemp <= '1';
				nRDtemp <= '0';
				nBLEtemp <= '0';		
				nBHEtemp <= '1';
				nPREQtemp <= '1';
				nPWRtemp <= '1';
				nPRDtemp <= '1';
			when "01101" =>
				nMREQtemp <= '1';
				nWRtemp <= '1';
				nRDtemp <= '1';
				nBLEtemp <= '1';		
				nBHEtemp <= '1';
				nPREQtemp <= '0';
				nPWRtemp <= '0';
				nPRDtemp <= '1';
			when "01110" =>
				nMREQtemp <= '1';
				nWRtemp <= '1';
				nRDtemp <= '1';
				nBLEtemp <= '1';		
				nBHEtemp <= '1';
				nPREQtemp <= '0';
				nPWRtemp <= '1';
				nPRDtemp <= '0';
			when others =>
				nMREQtemp <= '1';
				nWRtemp <= '1';
				nRDtemp <= '1';
				nBLEtemp <= '1';		
				nBHEtemp <= '1';
				nPREQtemp <= '1';
				nPWRtemp <= '1';
				nPRDtemp <= '1';
			end case;
	end process;

	-- 所有读操作
	process(nMREQtemp,nWRtemp,nRDtemp,nPREQtemp,nPWRtemp,nPRDtemp,nBLEtemp,nBHEtemp,IOR0,IOR1,IOR2,IOR3,DBus,ADDR_in)
	begin
		if(nMREQtemp = '0' and nRDtemp = '0' and nBLEtemp = '0' and nBHEtemp = '0') then
			IRout <= DBus;
			data <= (others => 'Z');
			dataH <= (others => 'Z');
		elsif(nMREQtemp = '0' and nRDtemp = '0' and nBLEtemp = '0' and nBHEtemp = '1') then
			data <= DBus(7 downto 0);
			dataH <= DBus(15 downto 8);
			IRout <= (others => 'Z');
		elsif(nPREQtemp = '0' and nPRDtemp = '0') then
			case ADDR_in(1 downto 0) is
				when "00" => data <= IOR0;
				when "01" => data <= IOR1;
				when "10" => data <= IOR2;
				when others => data <= IOR3;
			end case;
			dataH <= (others => 'Z');
			IRout <= (others => 'Z');
		else
			data <= (others => 'Z');
			dataH <= (others => 'Z');
			IRout <= (others => 'Z');
		end if;
	
	end process;
	
	-- 所有写操作
	process(nMREQtemp,nWRtemp,nRDtemp,nPREQtemp,nPWRtemp,nPRDtemp,nBLEtemp,nBHEtemp,data,dataH,ADDR_in)
	begin
		if(nMREQtemp = '0' and nWRtemp = '0') then
			DBus(7 downto 0) <= data;
			DBus(15 downto 8) <= dataH;
			IOW0 <= (others => 'Z');
			IOW1 <= (others => 'Z');
			IOW2 <= (others => 'Z');
			IOW3 <= (others => 'Z');
		elsif(nPREQtemp = '0' and nPWRtemp = '0') then
			case ADDR_in(1 downto 0) is
				when "00" => IOW0 <= data; 				IOW1 <= (others => 'Z'); 	IOW2 <= (others => 'Z'); 	IOW3 <= (others => 'Z');
				when "01" => IOW0 <= (others => 'Z');  IOW1 <= data; 					IOW2 <= (others => 'Z'); 	IOW3 <= (others => 'Z');
				when "10" => IOW0 <= (others => 'Z');  IOW1 <= (others => 'Z'); 	IOW2 <= data; 					IOW3 <= (others => 'Z');
				when others => IOW0 <= (others => 'Z');IOW1 <= (others => 'Z'); 	IOW2 <= (others => 'Z'); 	IOW3 <= data;
			end case;
			DBus <= (others => 'Z');
		else
			DBus <= (others => 'Z');
			IOW0 <= (others => 'Z');
			IOW1 <= (others => 'Z');
			IOW2 <= (others => 'Z');
			IOW3 <= (others => 'Z');
		end if;
	end process;
end Behavioral;

