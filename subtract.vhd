
entity subtract is       -- this performs subtraction of 2 input bit vectors
	port(
			SAi : in bit_vector(15 downto 0);  -- Using A - B = (A + (B's Complement)) disregarding the end carry
			SBi : in bit_vector(15 downto 0);
			sub  :  out bit_vector(15 downto 0);
			Sc_out : out bit);
end subtract;

architecture gate of subtract is

	signal SBiCopy : bit_vector(15 downto 0);  -- making a copy of subtrahend with just 1's and 0's exchanged
	signal complement1 : bit_vector(15 downto 0);   -- signal of Value 1 to be added after changing 1's and 0's into each other to make complement
	signal SBiComplement : bit_vector(15 downto 0); -- signal stores the complement signal of subtrahend
	signal c_outTemp : bit;   
	
	component Adder is
		port(
			Ai : in bit_vector(15 downto 0);
			Bi : in bit_vector(15 downto 0);
			C_in : in bit;
			sum  :  out bit_vector(15 downto 0);
			c_out : out bit);
	end component;
	
	
begin

	complement1 <= "0000000000000001";  -- value 1

	proc1: process(SBi) is  -- this process echanges 1's with 0's and 0's with 1's 
	begin
		SBiCopy1:
				for i in 0 to 15 loop
					if (SBi(i) = '0') then
						SBiCopy(i) <= '1';
					else
						SBiCopy(i) <= '0';
					end if;
				end loop SBiCopy1;
	end process proc1;
	
	--adding SbiCopy and complement 1 to make Complement signal of subtrahend = SbiComplement 
	Adder1: Adder port map (Ai => SBiCopy, Bi => complement1, C_in => '0', sum => SBiComplement, c_out => c_outTemp); 
	
	--adding input SAi and Sbi complement to get final answer 
	Adder2: Adder port map (Ai => SAi, Bi => SBiComplement, C_in => '0', sum => sub, c_out => Sc_out);
									
	
end gate;
						
	
				
	