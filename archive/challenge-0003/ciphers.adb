-- @author Simon Symeonidis 
-- Contains all the required ciphers (Easy..Hard) from the challenges in this
-- week.
package body Ciphers is

  -- @param Input
  --   is the input string provided in order to encrypt
  -- @param Key
  --   is the key we want to encrypt with (this is pretty much just an offset)
  -- @return 
  --   The encrypted string using the Ceasar Cipher.
  function AlphaEncrypt(Input  : String; 
                        Key    : Integer := 1) 
  return String is
    Result  : String(Input'Range);
    Max_Mod : Positive;
  begin
    for Index in Input'Range loop

      case Input(Index) is
      when Capital_Character_Range | Lower_Character_Range =>
        Max_Mod       := (Character'Pos(Input(Index)) + Key) mod 26;
        Result(Index) := Character'Val(65 + Max_Mod);
      when others =>
        Result(Index) := Input(Index);
      end case;

    end loop;
    return Result;
  end AlphaEncrypt;

  -- @param Input
  --   is the input string provided in order to decrypt
  -- @param Key
  --   is the key we want to decrypt with (this is pretty much just an offset)
  -- @return 
  --   The decrypted string using the Ceasar Cipher.
  function AlphaDecrypt(Input  : String; 
                        Key    : Integer := 1) 
  return String is
    Result : String(Input'Range);
  begin
    for Index in Input'Range loop
 
      case Input(Index) is
      when Capital_Character_Range | Lower_Character_Range =>
        Result(Index) := Character'Val(65 + ((Character'Pos(Input(Index)) + Key) mod 26));
      when others =>
        Result(Index) := Input(Index);
      end case;

    end loop;
    return Result;
  end AlphaDecrypt;
end Ciphers;
