library IEEE;
use IEEE.Std_Logic_1164.all;
use IEEE.std_logic_signed.all;

entity datapath is
port(sw_entra: in std_logic_vector(17 downto 0);
r1, e1,e2,e3,e4,e5, e6, clk1, clk50, key_entra: in std_logic;
h0, h1, h2, h3, h4, h5, h6, h7: out std_logic_vector(6 downto 0);
led_out: out std_logic_vector (17 downto 0);
end_time, end_bonus, end_round, end_FPGA: out std_logic);

end datapath;

architecture arqdata of datapath is

    signal seq_fpga: std_logic_vector(17 downto 0);
    signal seq1_out, seq2_out, seq3_out, seq4_out: std_logic_vector(17 downto 0);   
    signal round: std_logic_vector(3 downto 0);
    signal round_bcd: std_logic_vector(7 downto 0);

    component mux2_1 is port (
    	F1: in std_logic_vector(17 downto 0);
    	F2: in std_logic_vector(17 downto 0);
    	sel: in std_logic;
    	F: out std_logic_vector(17 downto 0));
    end component;
    
    component mux4_1 is port (
        F1: in std_logic_vector(17 downto 0);
        F2: in std_logic_vector(17 downto 0);
        F3: in std_logic_vector(17 downto 0);
        F4: in std_logic_vector(17 downto 0);
        SEL: in std_logic_vector(1 downto 0);
        saida: out std_logic_vector(7 downto 0)
        );
    end component; 
    
    component decodificador is port(
        G: in std_logic_vector(3 downto 0);
    	out_hex: out std_logic_vector(6 downto 0));
    end component;

    component registrador is port (
        CLK: in std_logic;
        RST: in std_logic;
        EN: in std_logic;
        D: in std_logic_vector(13 downto 0);
        Q: out std_logic_vector(13 downto 0));
    end component;
    
    component sum is port 
        (f: in std_logic_vector(17 downto 0);
        q: out std_logic_vector(5 downto 0));
    end component;
    
    component contador_crescente is port (
        data: in std_logic_vector (3 downto 0);
        reset: in std_logic;
        clock: in std_logic;
        enable: in std_logic;
        contagem: out std_logic_vector(3 downto 0);
        end_count: out std_logic);
    end component;
    
    component contador_round is port ( 
        data: in std_logic_vector(3 downto 0);
        setup: in std_logic;
        clock: in std_logic;
        enable: in std_logic;
        contagem: out std_logic_vector(3 downto 0);
        end_count: out std_logic);
    end component;
    
    component contador_bonus is port ( 
        data: in std_logic_vector(5 downto 0);
        setup_user: in std_logic_vector(3 downto 0);
        setup: in std_logic;
        clock: in std_logic;
        enable: in std_logic;
        contagem: out std_logic_vector(5 downto 0);
        end_count: out std_logic);
    end component;

    component SEQ1 is port( 
         address : in std_logic_vector(3 downto 0);
         data : out std_logic_vector(17 downto 0) );
    end component;

   component SEQ2 is port( 
         address : in std_logic_vector(3 downto 0);
         data : out std_logic_vector(17 downto 0) );
    end component;

    component SEQ3 is port( 
         address : in std_logic_vector(3 downto 0);
         data : out std_logic_vector(17 downto 0) );
    end component;

    component SEQ4 is port( 
         address : in std_logic_vector(3 downto 0);
         data : out std_logic_vector(17 downto 0) );
    end component;


    begin

    CR: contador_round port map ("0000", e1, clk50, e4, round, end_round); 
    S1: SEQ1 port map (round, seq1_out);
    S2: SEQ2 port map (round, seq2_out);   
    S3: SEQ3 port map (round, seq3_out);
    S4: SEQ4 port map (round, seq4_out);

    DEC: decodificador port map (round, round_bcd); 

    MUX4: mux4_1 port map (seq1_out, seq2_out, seq3_out, seq4_out, sw_entra(5 downto 4), seq_fpga); 
    MUX2: mux2_1 port map ("000000000000000000",seq_fpga, e2, led_out );
   
    DEC:
    REG:
    Sum:
    CC:
    CR: 
    CB:
end arqdata;




