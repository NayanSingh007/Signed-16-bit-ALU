


entity mux4to1 is               -- Takes 4 input and produces 1 output based on the control bits
	port( Am : in bit_vector(15 downto 0); --Input
			Sm : in bit_vector(15 downto 0); --Input
			Nm : in bit_vector(15 downto 0); --Input
			Xm : in bit_vector(15 downto 0); --Input
			S0m  : in bit;                   -- Control Bit
			S1m  : in bit;                   -- Control Bit
			Om : out bit_vector(15 downto 0)); --Output
end mux4to1;

architecture gate of mux4to1 is

	signal S0bar,S1bar : bit;
	signal X1,Y1,Z1,W1: bit_vector(15 downto 0);
	
	component andGate3input is
		port(A,B,C : in bit; D: out bit);				-- Uses 3 input AND Gate and 4 Input Or Gate to form the following equation
	end component;												-- Om = Ams0s1 + SmS0s + Nms0S1 + XmS0S1  <= EQUATION *
																	-- where s0  =  complement of S0
	component orGate4input is
		port(X,Y,Z,W: in bit; OrOP: out bit);
	end component;
	
	component notGate is
		port(I : in bit; J: out bit);
	end component;
	
begin

	notGate_S0 : notGate port map(I => S0m,J => S0bar);  -- produce s0 from S0
			
	notGate_S1 : notGate port map(I => S1m,J => S1bar);  -- produce s1 from S1

	lvl1:	
		FOR i IN 0 TO 15 GENERATE
	
			andGate_Ams1s0 : andGate3input port map(A => Am(i), B => S0bar, C => S1bar, D => X1(i));  --connections made according to EQUATION *
	
			andGate_Sms1S0 : andGate3input port map(A => Sm(i), B => S0m, C => S1bar, D => Y1(i));
			
			andGate_NmS1s0 : andGate3input port map(A => Nm(i), B => S0bar, C => S1m, D => Z1(i));
			
			andGate_XmS1S0 : andGate3input port map(A => Xm(i), B => S0m, C => S1m, D => W1(i));
	
			orGate_ASNX : orGate4input port map(X => X1(i), Y => Y1(i), Z => Z1(i), W => W1(i), OrOP => Om(i));
			
		end generate lvl1;
end gate;