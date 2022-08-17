
entity orGate is
	port(X,Y : in bit; Z: out bit);
end orGate;

architecture gate of orGate is
begin
	proc: process(X,Y) is
	begin
		if (X = '0' and  Y = '0') then    -- Z = 0 only when X = Y = 0
			Z <= '0';
		else 
			Z <= '1';
		end if;
	end process proc;
end gate;