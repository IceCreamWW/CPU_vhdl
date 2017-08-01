--------------------------------------------------------------------------------
-- Company: 
-- Engineer:
--
-- Create Date:   08:36:06 07/17/2017
-- Design Name:   
-- Module Name:   C:/Users/Lenovo/Documents/Xilinx Project/CPU/CPU_ALL_testbench.vhd
-- Project Name:  CPU
-- Target Device:  
-- Tool versions:  
-- Description:   
-- 
-- VHDL Test Bench Created by ISE for module: CPU_ALL
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
 
ENTITY CPU_ALL_testbench IS
END CPU_ALL_testbench;
 
ARCHITECTURE behavior OF CPU_ALL_testbench IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT CPU_ALL
    PORT(
         CLK : IN  std_logic;
         RST : IN  std_logic;
         nMREQ : OUT  std_logic;
         nRD : OUT  std_logic;
         nWR : OUT  std_logic;
         nBLE : OUT  std_logic;
         nBHE : OUT  std_logic;
         ABus : OUT  std_logic_vector(15 downto 0);
         DBus : INOUT  std_logic_vector(15 downto 0);
         nPREQ : OUT  std_logic;
         nPRD : OUT  std_logic;
         nPWR : OUT  std_logic;
         IOAD : OUT  std_logic_vector(1 downto 0);
         IOR0 : IN  std_logic_vector(7 downto 0);
         IOR1 : IN  std_logic_vector(7 downto 0);
         IOR2 : IN  std_logic_vector(7 downto 0);
         IOR3 : IN  std_logic_vector(7 downto 0);
         IOW0 : OUT  std_logic_vector(7 downto 0);
         IOW1 : OUT  std_logic_vector(7 downto 0);
         IOW2 : OUT  std_logic_vector(7 downto 0);
         IOW3 : OUT  std_logic_vector(7 downto 0)
        );
    END COMPONENT;
    

   --Inputs
   signal CLK : std_logic := '0';
   signal RST : std_logic := '0';
   signal IOR0 : std_logic_vector(7 downto 0) := (others => '0');
   signal IOR1 : std_logic_vector(7 downto 0) := (others => '0');
   signal IOR2 : std_logic_vector(7 downto 0) := (others => '0');
   signal IOR3 : std_logic_vector(7 downto 0) := (others => '0');

	--BiDirs
   signal DBus : std_logic_vector(15 downto 0);

 	--Outputs
   signal nMREQ : std_logic;
   signal nRD : std_logic;
   signal nWR : std_logic;
   signal nBLE : std_logic;
   signal nBHE : std_logic;
   signal ABus : std_logic_vector(15 downto 0);
   signal nPREQ : std_logic;
   signal nPRD : std_logic;
   signal nPWR : std_logic;
   signal IOAD : std_logic_vector(1 downto 0);
   signal IOW0 : std_logic_vector(7 downto 0);
   signal IOW1 : std_logic_vector(7 downto 0);
   signal IOW2 : std_logic_vector(7 downto 0);
   signal IOW3 : std_logic_vector(7 downto 0);

   -- Clock period definitions
   constant CLK_period : time := 10 ns;
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: CPU_ALL PORT MAP (
          CLK => CLK,
          RST => RST,
          nMREQ => nMREQ,
          nRD => nRD,
          nWR => nWR,
          nBLE => nBLE,
          nBHE => nBHE,
          ABus => ABus,
          DBus => DBus,
          nPREQ => nPREQ,
          nPRD => nPRD,
          nPWR => nPWR,
          IOAD => IOAD,
          IOR0 => IOR0,
          IOR1 => IOR1,
          IOR2 => IOR2,
          IOR3 => IOR3,
          IOW0 => IOW0,
          IOW1 => IOW1,
          IOW2 => IOW2,
          IOW3 => IOW3
        );

   -- Clock process definitions
   CLK_process :process
   begin
		CLK <= '0';
		wait for CLK_period/2;
		CLK <= '1';
		wait for CLK_period/2;
   end process;
 

   RST <= '1',
			 '0' after 10 ns,
			 '1' after 620 ns;
			 
--	process(nMREQ,nWR,nRD,nPREQ,nPRD,nPWR)
--	begin
--		if(nMREQ = '0' or nPREQ = '0') then
--			DBus <= "0111000011111100";
--		else
--			DBus <= (others => 'Z');
--		end if;
--	end process;
	
	
	DBus <= (others => 'Z'),
				X"0002" after 10 ns,					-- JMP 0002H
				(others => 'Z') after 20 ns,
				X"1010" after 50 ns,					--	JZ  R0,10H	
				(others => 'Z') after 60 ns,
				X"4111" after 90 ns,					-- MVI R1,11H
				(others => 'Z') after 100 ns,
				X"8100" after 130 ns,				-- OUT R1,00B
				(others => 'Z') after 140 ns,
				X"5201" after 170 ns,				-- MOV R2,R1
				(others => 'Z') after 180 ns,
				X"3102" after 210 ns, 				-- ADD R1,R2
				(others => 'Z') after 220 ns,
				X"6140" after 250 ns,				-- STA R1,40H
				(others => 'Z') after 260 ns,
				X"9303" after 290 ns,				-- IN  R3,11B
				(others => 'Z') after 300 ns,	
				X"2302" after 330 ns,				-- SUB R3,R2
				(others => 'Z') after 340 ns,
				X"6350" after 370 ns,				-- STA R3,50H
				(others => 'Z') after 380 ns,
				X"7540" after 410 ns,				-- LDA R5,40H
				(others => 'Z') after 420 ns,
				"ZZZZZZZZ00100010" after 430 ns,	-- ´«Êý¾Ý22H
				(others => 'Z') after 440 ns,
				X"1500" after 450 ns,				-- JZ  R5,00H
				(others => 'Z') after 460 ns,
				X"8502" after 490 ns,				-- OUT R5,10B
				(others => 'Z') after 500 ns,
				X"4711" after 530 ns,				-- MVI R7,11H
				(others => 'Z') after 540 ns,
				X"6560" after 570 ns,				-- STA R5,60H
				(others => 'Z') after 580 ns;
				

	IOR3 <= X"55";
END;
