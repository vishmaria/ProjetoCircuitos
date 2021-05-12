use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
use ieee.numeric_std.all;

entity controlador is port (
clock,reset,enter, end_fpga, end_bonus, end_time, end_round: in std_logic;
r1, e1, e2, e3, e4, e5, e6: out std_logic );
end controlador;

architecture fsmcontrolador of controlador is
    type STATES is (start, setup, play_fpga, play_user, check, result, next_round, wait1);
    signal EAtual, PEstado: STATES;
    
    

begin
    P1: process(clock)
  begin
    if clock'event and clock= '1' then
      EAtual <= PEstado;
    end if;
  end process;
    
    P2: process(Eatual,reset,enter, end_fpga, end_bonus, end_time, end_round)
    begin
        case Eatual is
            when Start =>
                        e6<='0';
                        e5<='0';
                        e4<='0';
                        e3<='0';
                        e2<='0';
                        e1<='0'; 
                        r1<='1'; --reseta tudo
                        if reset='0' then
                            PEstado<=setup;
                        elsif reset='1' then
                            PEstado<=Start;
                        end if;
                        
            when setup =>
                        e6<='0';
                        e5<='0';
                        e4<='0';
                        e3<='0';
                        e2<='0';
                        e1<='1'; --da enable no registrador do jogo
                        r1<='0';
                        if enter='0' then
                            PEstado<=play_fpga;
                        elsif enter='1' then
                            PEstado<=setup;
                        end if;
                        
            when play_fpga =>
                        e6<='0';
                        e5<='0';
                        e4<='0';
                        e3<='0';
                        e2<='1'; --ativa mux pra mostrar a sequencia do FPGA leds (17...0)
                        e1<='0';
                        r1<='0';
                        if end_fpga='1' then
                            PEstado<=play_user;
                        elsif end_fpga='0' then
                            PEstado<=play_fpga;
                        end if;
            
            when play_user =>
                        e6<='0';
                        e5<='0';
                        e4<='0';
                        e3<='1'; --ativa a contagem dos timers
                        e2<='0';
                        e1<='0';
                        r1<='0';
                        if enter='0' then
                            PEstado <= check;
                        end if;
                        if end_time='1' then
                            PEstado <= result;
                        end if;
            
            when check =>
                        e6<='0';
                        e5<='0';
                        e4<='0';
                        e3<='0';
                        e2<='0';
                        e1<='0';
                        r1<='0';
                        if ((end_round='0') and (end_bonus='0')) then
                            PEstado <= next_round;
                        end if;
                        if ((end_round='1') or (end_bonus='1')) then
                            PEstado <= result;
                        end if;
            
            when next_round =>
                        e6<='0';
                        e5<='0';
                        e4<='1'; --faz a contagem de rounds e reseta os contadores de tempo e level
                        e3<='0';
                        e2<='0';
                        e1<='0';
                        r1<='0';
                        PEstado<= wait1; 
                        
            when wait1 =>
                        e6<='0';
                        e5<='1'; --escreve round e o numero de rounds nos HEX
                        e4<='0';
                        e3<='0';
                        e2<='0';
                        e1<='0';
                        r1<='0';
                        if enter='0' then
                            PEstado<=play_fpga;
                        else
                            PEstado<=wait1;
                        end if;
            
            when result =>
                        e6<='1';
                        e5<='0';
                        e4<='0';
                        e3<='0';
                        e2<='0';
                        e1<='0';
                        r1<='0';
                        if enter='0' then
                            PEstado<=start;
                        else
                            PEstado<=result;
                        end if;
        end case;
    end process;
                            
            
end fsmcontrolador;

    
                  

