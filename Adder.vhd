
entity Adder is
	port(
			Ai : in bit_vector(15 downto 0);
			Bi : in bit_vector(15 downto 0);
			C_in : in bit;
			sum  :  out bit_vector(15 downto 0);
			c_out : out bit);
end Adder;

architecture gate of Adder is

	
	
	component generateGP is   -- This produces the inital Gi and Pi from input bits Ai and Bi
		port(
			X,Y : in bit;
			Gg,Pg : out bit);
	end component;
	
	component grpGP is  -- This produces the group Gs and Ps of the different levels
		port(
			G1 : in bit;
			P1 : in bit;
			G2 : in bit;
			P2 : in bit;
			G : out bit;
			P : out bit);
	end component;
	
	component xorGate is       -- Xor Gate
		port(A,B : in bit; C: out bit);
	end component;
	
	
	--stage 01  Stage 1 comprises of the Gi and Pi corresponding to Ai and Bi input bits (level 0)
	signal g_1 : bit_vector(15 downto 0);   
	signal p_1 : bit_vector(15 downto 0);
	
	--stage 02 Stage 2 comprises of the group  G and P of level 1
	signal g_2 : bit_vector(15 downto 0);
	signal p_2 : bit_vector(15 downto 0);
	
	--stage 03 Stage 3 comprises of the group G and P of level 2
	signal g_3 : bit_vector(15 downto 0);
	signal p_3 : bit_vector(15 downto 0);
	
	--stage 04 Stage 4 comprises of the group G and P of level 3
	signal g_4 : bit_vector(15 downto 0);
	signal p_4 : bit_vector(15 downto 0);
	
	--stage 05 Stage 5 comprises of the group G and P of level 4
	signal g_5 : bit_vector(15 downto 0);
	signal p_5 : bit_vector(15 downto 0);
	
	--final C values this stores the values of Carry bits which are the stage 5 G values
	signal ci : bit_vector(15 downto 0);
	
begin

	stage1: -- generates Gi and Pi from input bit vector Ai and Bi
				for i in 0 to 15 generate
					generateGP1: generateGP port map (X => Ai(i), Y => Bi(i), Gg => g_1(i), Pg => p_1(i));
				end generate stage1;
	
	stage2:  -- group G and P values for stage 2
				for i in 0 to 14 generate
					grpGP2: grpGP port map (G1 => g_1(i), P1 => p_1(i), G2 => g_1(i+1), P2 => p_1(i+1), G =>g_2(i+1), P => p_2(i+1));
				end generate stage2;
	--passedvalues2 -stage2 Values that are directly passed down are g_1(0) and p_1(0)
	g_2(0) <= g_1(0);
	p_2(0) <= p_1(0);
				
	stage3:  -- group G and P values for stage 3
				for i in 0 to 13 generate
					grpGP3: grpGP port map (G1 => g_2(i), P1 => p_2(i), G2 => g_2(i+2), P2 => p_2(i+2), G =>g_3(i+2), P => p_3(i+2));
				end generate stage3;
				
	passedvalues3: --values that are directly passed down
				for i in 0 to 1 generate
					g_3(i) <= g_2(i);
					p_3(i) <= p_2(i);
				end generate passedvalues3;
				
	stage4:  -- group G and P values for stage 4
				for i in 0 to 11 generate
					grpGP4: grpGP port map (G1 => g_3(i), P1 => p_3(i), G2 => g_3(i+4), P2 => p_3(i+4), G =>g_4(i+4), P => p_4(i+4));
				end generate stage4;
	
	passedvalues4: --values that are directly passed down
				for i in 0 to 3 generate
					g_4(i) <= g_3(i);
					p_4(i) <= p_3(i);
				end generate passedvalues4;
				
				
	stage5:  -- group G and P values for stage 5
				for i in 0 to 7 generate
					grpGP5: grpGP port map (G1 => g_4(i), P1 => p_4(i), G2 => g_4(i+8), P2 => p_4(i+8), G =>g_5(i+8), P => p_5(i+8));
				end generate stage5;
				
	passedvalues5: --values that are directly passed down
				for i in 0 to 7 generate
					g_5(i) <= g_4(i);
					p_5(i) <= p_4(i);
				end generate passedvalues5;
	
	Civalues:  -- Calcultes the Ci values Ci = Gi
				for i in 0 to 15 generate
					ci(i) <= g_5(i);
				end generate Civalues;
				
	c_out <= ci(15);
	
	sumvalues:  -- calculates the sum values Si = Pi xor C(i-1)
					for j in 1 to 15 generate
						xor_instance : xorGate port map ( A => p_1(j), B => ci(j-1), C => sum(j));
					end generate sumvalues;
					
	--Value of Sum(0)
	xor_instance2 : xorGate port map ( A => p_1(0), B => c_in, C => sum(0));
	
end gate;
						
	
				
	