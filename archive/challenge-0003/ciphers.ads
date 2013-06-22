package Ciphers is
  subtype Capital_Character_Range is Character range 'A'..'Z';
  subtype Lower_Character_Range   is Character range 'a'..'z';

  function AlphaEncrypt(Input  : String; 
                        Key    : Integer := 1) return String;
  function AlphaDecrypt(Input  : String;
                        Key    : Integer := 1) return String;
end Ciphers;
