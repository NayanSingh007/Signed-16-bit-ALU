
entity notGate is
	port(I : in bit; J: out bit);
end notGate;

architecture gate of notGate is
begin
	proc2: process(I) is
	begin
		if (I = '1') then    -- J = 1 when I = 0 and 0 when I = 1
			J <= '0';
		else 
			J <= '1';
		end if;
	end process proc2;
end gate;