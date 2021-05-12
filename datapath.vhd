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

    signal seq_fpga, seq1_out, seq2_out, seq3_out, seq4_out, xor_s: std_logic_vector(17 downto 0);
    signal setup: std_logic_vector (13 downto 0);
    signal mux70_out, mux71_out, mux60_out, mux61_out, mux50_out, mux51_out
    ,mux40_out, mux41_out, mux30_out, mux31_out,mux20_out, mux21_out
    ,mux10_out, mux11_out, mux00_out, mux01_out, dec6_out, dec4_out
    , dec20_out, dec21_out,dec22_out, dec10_out, dec11_out
    , dec12_out: std_logic_vector (6 downto 0);
    signal f_points, u_points: std_logic_vector (11 downto 0);
    signal concat_setup, round, time, vazio 
    
    ,dec00_out, dec01_out, dec02_out, dec03_out: std_logic_vector(3 downto 0);
    signal round_bcd: std_logic_vector(7 downto 0);
    signal sum_out, bonus: std_logic_vector(5 downto 0);
    signal or_lt, and_bonus, end_round_aux: std_logic;

    component mux is port (
    	F1: in std_logic_vector(17 downto 0);
    	F2: in std_logic_vector(17 downto 0);
    	sel: in std_logic;
    	F: out std_logic_vector(17 downto 0));
    end component;

    component mux2_1 is port (
    	F1: in std_logic_vector(6 downto 0);
    	F2: in std_logic_vector(6 downto 0);
    	sel: in std_logic;
    	F: out std_logic_vector(6 downto 0));
    end component;
    
    component mux4_1 is port (
        F1: in std_logic_vector(17 downto 0);
        F2: in std_logic_vector(17 downto 0);
        F3: in std_logic_vector(17 downto 0);
        F4: in std_logic_vector(17 downto 0);
        SEL: in std_logic_vector(1 downto 0);
        saida: out std_logic_vector(17 downto 0)
        );
    end component; 
    
    component decodificador is port(
        G: in std_logic_vector(3 downto 0);
    	out_hex: out std_logic_vector(6 downto 0));
    end component;

    component dec_bcd is port (
        G: in std_logic_vector(3 downto 0);
        out_hex: out std_logic_vector(7 downto 0)
        );
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

    or_lt <= (r1 or e4);
    and_bonus <= (e3 and not(key_entra));
    xor_s <= (seq_fpga xor sw_entra(17 downto 0));
    f_points <= "00" & round & not(bonus);
    u_points <= "00" & not(round) & bonus;

    Clevel: contador_crescente port map (setup(9 downto 6), or_lt, clk1, e2, vazio, end_FPGA );
    Ctime: contador_crescente port map ("1010",or_lt,clk1, e3, time, end_time);    
    Cround: contador_round port map ("0000", e1, clk50, e4, round, end_round); 
    S1: SEQ1 port map (round, seq1_out);
    S2: SEQ2 port map (round, seq2_out);   
    S3: SEQ3 port map (round, seq3_out);
    S4: SEQ4 port map (round, seq4_out);

    MUXrom: mux4_1 port map (seq1_out, seq2_out, seq3_out, seq4_out, setup(5 downto 4), seq_fpga);  
    Soma: sum port map (xor_s,sum_out);
    Cbonus: contador_bonus port map (sum_out, setup(13 downto 10), e1, clk50, and_bonus, bonus, end_bonus);
    REG: registrador port map (clk50, r1, e1, sw_entra(13 downto 0), setup(13 downto 0));
    DECbcd: dec_bcd port map (round, round_bcd); 
    
    concat_setup <= "00" & setup(5 downto 4);

   
    MUXled: mux port map ("000000000000000000",seq_fpga, e2, led_out );

    MUX70: mux2_1 port map ("1000111", "0101111", e5, mux70_out); 
    MUX71: mux2_1 port map ("0001110", "1000001", end_round_aux, mux71_out);
    MUX72: mux2_1 port map (mux70_out, mux71_out, e6, h7);

    DEC6: decodificador port map (setup(9 downto 6), dec6_out);
    MUX60: mux2_1 port map (dec6_out, "0100011", e5, mux60_out);
    MUX61: mux2_1 port map ("0001100", "0010010", end_round_aux, mux61_out);
    MUX62: mux2_1 port map (mux60_out, mux61_out, e6, h6);
    
    MUX50: mux2_1 port map("1100000", "1100011", e5, mux50_out);
    MUX51: mux2_1 port map("0010000", "0000110", end_round_aux, mux51_out);
    MUX52: mux2_1 port map(mux50_out, mux51_out, e6 , h5);
    
    DEC4: decodificador port map(concat_setup, dec4_out);
    MUX40: mux2_1 port map(dec4_out,"0101011",e5,mux40_out);
    MUX41: mux2_1 port map("0001000", "0101111", end_round_aux, mux41_out);
    MUX42: mux2_1 port map(mux40_out, mux41_out, e6, h4);
    
    MUX30: mux2_1 port map("0000111", "0100001", e5, mux30_out);
    MUX31: mux2_1 port map("0110111", "0110111", end_round_aux, mux31_out);
    MUX32: mux2_1 port map(mux30_out, mux31_out, e6, h3);
    
    DEC20: decodificador port map(time, dec20_out);
    DEC21: decodificador port map(f_points(11 downto 8), dec21_out);
    DEC22: decodificador port map(u_points(11 downto 8), dec22_out);
    
    



  
end arqdata;
