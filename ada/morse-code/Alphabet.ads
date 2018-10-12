
package Alphabet is
    
    type Nibble is mod 2**4;
    
    type Morse is
    record
        -- little endian morse signal dot = 0, dash = 1
        Signal : Nibble;
        -- number of dots and dashes in signal (varies)
        Length : Nibble;
    end record;
    pragma Pack(Morse);
    
    type Morse_Array is array (Positive range <>) of Morse;
    
    A : constant Morse := (Signal => 2#10#,   Length => 2);
    B : constant Morse := (Signal => 2#0001#, Length => 4);
    C : constant Morse := (Signal => 2#0101#, Length => 4);
    D : constant Morse := (Signal => 2#001#,  Length => 3);
    E : constant Morse := (Signal => 2#0#,    Length => 1);
    F : constant Morse := (Signal => 2#0100#, Length => 4);
    G : constant Morse := (Signal => 2#011#,  Length => 3);
    H : constant Morse := (Signal => 2#0000#, Length => 4);
    I : constant Morse := (Signal => 2#00#,   Length => 2);
    J : constant Morse := (Signal => 2#0111#, Length => 4);
    K : constant Morse := (Signal => 2#101#,  Length => 3);
    L : constant Morse := (Signal => 2#0010#, Length => 4);
    M : constant Morse := (Signal => 2#11#,   Length => 2);
    N : constant Morse := (Signal => 2#01#,   Length => 2);
    O : constant Morse := (Signal => 2#111#,  Length => 3);
    P : constant Morse := (Signal => 2#0110#, Length => 4);
    Q : constant Morse := (Signal => 2#1011#, Length => 4);
    R : constant Morse := (Signal => 2#010#,  Length => 3);
    S : constant Morse := (Signal => 2#000#,  Length => 3);
    T : constant Morse := (Signal => 2#1#,    Length => 1);
    U : constant Morse := (Signal => 2#100#,  Length => 3);
    V : constant Morse := (Signal => 2#1000#, Length => 4);
    W : constant Morse := (Signal => 2#110#,  Length => 3);
    X : constant Morse := (Signal => 2#1001#, Length => 4);
    Y : constant Morse := (Signal => 2#1101#, Length => 4);
    Z : constant Morse := (Signal => 2#0011#, Length => 4);

    SPACE : constant Morse := (Signal => 0, Length => 0);
    
end Alphabet;
