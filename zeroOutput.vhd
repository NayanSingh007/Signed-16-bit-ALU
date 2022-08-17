


entity zeroOutput is    -- this checks if the Result and CarryOut are both zero and if they are it produces Z = 1
	port( I0 : in bit_vector(15 downto 0);  -- Takes input as output of the mux
			AddC_in, SubC_in,S0z,S1z: in bit;  	-- 2 carry_ins of Addition and Subtraction which is chosen as C_out based on Control bits S0z S1z
			Result : out bit_vector(15 downto 0); -- Result is just the output of mux
			C_out  : out bit;           --either Add_Cin or SubC_in based on control bits
			Zero      : out bit);    -- if Both Result and C_out = 0 then Z = 1
end zeroOutput;

architecture gate of zeroOutput is
	signal t : bit;        -- used to check if Result if 0 or not
	signal cValue : bit;  -- assign C_out as AddC_in or SubC_in
	
begin
	proc1: process(S0z,S1z,I0,AddC_in,SubC_in,CValue,t) is
	begin	
		if S0z = '0' and S1z = '0' then   -- if operation was addition CValue = Add_Cin
			cValue <= AddC_in;
		elsif S0z = '1' and S1z = '0' then -- if operation was subtraction CValue = Add_Cin
			cValue <= SubC_in;
		else 										-- if operation was Nand or Xor CValue = 0
			cValue <= '0';
		end if;
		
		c_out <= cValue;			-- C_out = C_value
		t <= '0';               -- initialization of t
		
		zeroOPCheck:					-- checks if result is 0
				for i in 0 to 15 loop
					if (I0(i) = '1') then
						t <= '1';		-- even if 1 bit of result is 1 t = 1 and result is non zero and loop exits there
						exit;
					end if;
				end loop zeroOPCheck;
				
		Output:								-- Result is the output of mux or input of ZeroOuptut Function
				for i in 0 to 15 loop
					Result(i) <= I0(i);
				end loop Output;
		
		if t = '0' then   -- if Result is 0 then Zero = 1
			Zero <= '1';
		else
			Zero <= '0';
		end if;
				
	end process proc1;
end gate;