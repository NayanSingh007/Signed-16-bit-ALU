
entity generateGP is   -- generates the intial Gi and Pi values from input bits Ai and Bi
	port(
			X,Y : in bit;
			Gg,Pg : out bit);
end generateGP;

architecture gate of generateGP is

	component andGate is
		port(A,B : in bit; C: out bit);
	end component;
	
	component xorGate is
		port(A,B : in bit; C: out bit);
	end component;
	
begin
	
	andGate_Instance : andGate port map(A => X, B => Y, C => Gg);  -- Gi = Ai and Bi
	
	xorGate_Instance : xorGate port map(A => X,B => Y ,C => Pg);	-- Pi = Ai xor Bi
	
end gate;