
entity nandGate is
	port(X,Y : in bit; Z: out bit);
end nandGate;

architecture gate of nandGate is
begin
	proc: process(X,Y) is
	begin
		if (X = '1' and Y = '1') then 			-- Z  = 0 only when X = Y = '1'
			Z <= '0';
		else 
			Z <= '1';
		end if;
	end process proc;
end gate;