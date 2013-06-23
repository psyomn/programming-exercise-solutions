with Ada.Text_IO;
with Ada.Command_Line;
with Ada.Strings.Unbounded;

with Ciphers;

-- @author  Simon Symeonidis
-- @license GPL v3.0
procedure AdaEncrypt is 
  package ati renames Ada.Text_IO;
  package acl renames Ada.Command_Line;
  package ubs renames Ada.Strings.Unbounded;
  Help_Text : String := "Usage: adaencrypt <decrypt|encrypt|d|e> <istream>";

  function Read_STDIN return String is
    Input : ubs.Unbounded_String;
    Char  : Character;
  begin 
    while (not ati.End_Of_File) loop
      ati.Get(Char);
      ubs.Append(Source => Input, New_Item => Char);
    end loop;
    return ubs.To_String(Input);
  end Read_STDIN;
begin

  -- Print usage if wrong number of arguments have been given
  if acl.Argument_Count /= 1 then
    ati.Put_Line(Help_Text);
    return;
  end if;

  if acl.Argument(1) = "encrypt"   or
     acl.Argument(1) = "e"         then
    declare
      Output : String := Read_STDIN;
    begin
      ati.Put_Line(Ciphers.AlphaEncrypt(Output));
    end;
  elsif acl.Argument(1) = "decrypt" or 
        acl.Argument(1) = "d"       then
    declare
      Output : String := Read_STDIN;
    begin
      ati.Put_Line(Ciphers.AlphaDecrypt(Output));
    end;
  else
    ati.Put_Line(Help_Text);
  end if;
  return;

end AdaEncrypt;
