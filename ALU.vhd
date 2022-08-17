

entity ALU is
	port( A : in bit_vector(15 downto 0);  -- Input A
			B : in bit_vector(15 downto 0);  -- Input B
			R : out bit_vector(15 downto 0); -- Output Result
			S0,S1 : in bit;                  -- Control Bits
			Z : out bit;							-- Zero Output
			C : out bit);                    -- Carry Out
end ALU;

architecture gate of ALU is

	signal ACarry , SCarry : bit ;    -- Internal Signals Addition Carry and Subtraction Carry feeded to the Zero Output Operation
	signal A_out,S_out,N_out,X_out,M_out : bit_vector(15 downto 0);  -- Internal Signals Result of 4 main operation feeded into the multiplexer
	
	component nandOperation is						--Nand Operation
		port( NA : in bit_vector(15 downto 0);
				NB : in bit_vector(15 downto 0);
				NO : out bit_vector(15 downto 0));
	end component;
	
	component xorOperation is                 --Xor Operation
		port( XA : in bit_vector(15 downto 0);
				XB : in bit_vector(15 downto 0);
				XO : out bit_vector(15 downto 0));
	end component;
	
	component mux4to1 is 							-- Multiplexer 4 to 1
		port( Am : in bit_vector(15 downto 0);
				Sm : in bit_vector(15 downto 0);
				Nm : in bit_vector(15 downto 0);
				Xm : in bit_vector(15 downto 0);
				S0m  : in bit;
				S1m  : in bit;
				Om : out bit_vector(15 downto 0));
	end component;
	
	component Adder is								-- Addition Operation Note than if Answer is negative it is already in its 2's complement form
		port( Ai : in bit_vector(15 downto 0);
				Bi : in bit_vector(15 downto 0);
				C_in : in bit;
				sum  :  out bit_vector(15 downto 0);
				c_out : out bit);
	end component;
	
	component subtract is							-- Subtraction Operation Note than if Answer is negative it is already in its 2's complement form
		port(
			SAi : in bit_vector(15 downto 0);
			SBi : in bit_vector(15 downto 0);
			sub  :  out bit_vector(15 downto 0);
			Sc_out : out bit);
	end component;
	
	component zeroOutput is							-- ZeroOutput Operation
		port( I0 : in bit_vector(15 downto 0);
				AddC_in, SubC_in,S0z,S1z: in bit;
				Result : out bit_vector(15 downto 0);
				C_out  : out bit;
				Zero      : out bit);
	end component;
	
begin
	AddOP : Adder port map(Ai => A,Bi => B,C_in => '0', sum=> A_out,c_out => ACarry);
	
	subOP : subtract port map(SAi => A, SBi => B, sub => S_out,Sc_out => SCarry);
	
	NandOP : nandOperation port map(NA => A,NB => B,NO => N_out);
	
	XorOP : xorOperation port map(XA => A , XB => B, XO => X_out);
	
	muxOP : mux4to1 port map( Am => A_out,Sm => S_out,Nm => N_out,Xm => X_out,S0m => S0,S1m => S1,Om => M_out);
	
	zeroOP : zeroOutput port map(I0 => M_out,AddC_in => ACarry,SubC_in => SCarry,S0z => S0,S1z => S1,Result => R,C_out => C ,Zero => Z);
	
end gate;