--------------------------------------------------------------------------------
-- Company: 
-- Engineer:
--
-- Create Date:   23:01:15 07/20/2017
-- Design Name:   
-- Module Name:   C:/Users/123/Desktop/Documents/CPU_final(1)/MemManage_testbench.vhd
-- Project Name:  CPU
-- Target Device:  
-- Tool versions:  
-- Description:   
-- 
-- VHDL Test Bench Created by ISE for module: CPU_MemManage
-- 
-- Dependencies:
-- 
-- Revision:
-- Revision 0.01 - File Created
-- Additional Comments:
--
-- Notes: 
-- This testbench has been automatically generated using types std_logic and
-- std_logic_vector for the ports of the unit under test.  Xilinx recommends
-- that these types always be used for the top-level I/O of a design in order
-- to guarantee that the testbench will bind correctly to the post-implementation 
-- simulation model.
--------------------------------------------------------------------------------
LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
 
-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--USE ieee.numeric_std.ALL;
 
ENTITY MemManage_testbench IS
END MemManage_testbench;
 
ARCHITECTURE behavior OF MemManage_testbench IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT CPU_MemManage
    PORT(
         IRr : IN  std_logic;
         WRm : IN  std_logic;
         RDM : IN  std_logic;
         WRio : IN  std_logic;
         RDio : IN  std_logic;
         PCin : IN  std_logic_vector(15 downto 0);
         IRout : OUT  std_logic_vector(15 downto 0);
         data : INOUT  std_logic_vector(7 downto 0);
         ADDR_in : IN  std_logic_vector(15 downto 0);
         nMREQ : OUT  std_logic;
         nRD : OUT  std_logic;
         nWR : OUT  std_logic;
         nBHE : OUT  std_logic;
         nBLE : OUT  std_logic;
         ABus : OUT  std_logic_vector(15 downto 0);
         DBus : INOUT  std_logic_vector(15 downto 0);
         nPREQ : OUT  std_logic;
         nPRD : OUT  std_logic;
         nPWR : OUT  std_logic;
         IOW0 : OUT  std_logic_vector(7 downto 0);
         IOW1 : OUT  std_logic_vector(7 downto 0);
         IOW2 : OUT  std_logic_vector(7 downto 0);
         IOW3 : OUT  std_logic_vector(7 downto 0);
         IOR0 : IN  std_logic_vector(7 downto 0);
         IOR1 : IN  std_logic_vector(7 downto 0);
         IOR2 : IN  std_logic_vector(7 downto 0);
         IOR3 : IN  std_logic_vector(7 downto 0);
         IOAD : OUT  std_logic_vector(1 downto 0)
        );
    END COMPONENT;
    

   --Inputs
   signal IRr : std_logic := '0';
   signal WRm : std_logic := '0';
   signal RDM : std_logic := '0';
   signal WRio : std_logic := '0';
   signal RDio : std_logic := '0';
   signal PCin : std_logic_vector(15 downto 0) := (others => '0');
   signal ADDR_in : std_logic_vector(15 downto 0) := (others => '0');
   signal IOR0 : std_logic_vector(7 downto 0) := (others => '0');
   signal IOR1 : std_logic_vector(7 downto 0) := (others => '0');
   signal IOR2 : std_logic_vector(7 downto 0) := (others => '0');
   signal IOR3 : std_logic_vector(7 downto 0) := (others => '0');

	--BiDirs
   signal data : std_logic_vector(7 downto 0);
   signal DBus : std_logic_vector(15 downto 0);

 	--Outputs
   signal IRout : std_logic_vector(15 downto 0);
   signal nMREQ : std_logic;
   signal nRD : std_logic;
   signal nWR : std_logic;
   signal nBHE : std_logic;
   signal nBLE : std_logic;
   signal ABus : std_logic_vector(15 downto 0);
   signal nPREQ : std_logic;
   signal nPRD : std_logic;
   signal nPWR : std_logic;
   signal IOW0 : std_logic_vector(7 downto 0);
   signal IOW1 : std_logic_vector(7 downto 0);
   signal IOW2 : std_logic_vector(7 downto 0);
   signal IOW3 : std_logic_vector(7 downto 0);
   signal IOAD : std_logic_vector(1 downto 0);
   -- No clocks detected in port list. Replace <clock> below with 
   -- appropriate port name 
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: CPU_MemManage PORT MAP (
          IRr => IRr,
          WRm => WRm,
          RDM => RDM,
          WRio => WRio,
          RDio => RDio,
          PCin => PCin,
          IRout => IRout,
          data => data,
          ADDR_in => ADDR_in,
          nMREQ => nMREQ,
          nRD => nRD,
          nWR => nWR,
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

   IRr <= '1' after 10 ns,
			 '0' after 20 ns;
	
	WRm <= '1',
			 '0' after 30 ns,
			 '1' after 40 ns;
			 
	RDm <= '1',
			 '0' after 50 ns,
			 '1' after 60 ns;
			 
	WRio <= '1',
			  '0' after 70 ns,
			  '1' after 80 ns;
			
	RDio <= '1',
			  '0' after 90 ns,
			  '1' after 100 ns;
	
	PCin <= "0000000000000001" after 10 ns;
	
	ADDR_in <= 	"0000000000000010" after 30 ns,
					"0000000000000011" after 50 ns,
					"0000000000000000" after 70 ns,
					"0000000000000001" after 90 ns;
	
	data <= 	(others => 'Z'),
				"00010001" after 30 ns,
				(others => 'Z') after 40 ns,
				"00100010" after 70 ns,
				(others => 'Z') after 80 ns;
				
	DBus <= 	(others => 'Z'),
				"0100000010000000" after 10 ns,
				(others => 'Z') after 20 ns,
				"0110000011000000" after 50 ns,
				(others => 'Z') after 60 ns;
	
	IOR1 <= "11110000";
			
				
	
			
		
 

   

END;
