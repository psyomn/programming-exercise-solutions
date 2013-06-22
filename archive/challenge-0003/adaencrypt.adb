with Ada.Text_IO;
with Ada.Command_Line;
with Ada.Strings.Unbounded;

with Ciphers;

-- @author Simon Symeonidis
procedure AdaEncrypt is 
  package acl renames Ada.Command_Line;
  Help_Text : String := "Usage: adaencrypt <decrypt|encrypt|d|e> [tokens]*";
begin

  -- Print usage if wrong number of arguments have been given
  if acl.Argument_Count < 2 then
    Ada.Text_IO.Put_Line(Help_Text);
    return;
  end if;

  if acl.Argument(1) = "encrypt"    then
    Ada.Text_IO.Put_Line("O yeah?");
  elsif acl.Argument(1) = "decrypt" then
    Ada.Text_IO.Put_Line("decrypt: ");
  else
    Ada.Text_IO.Put_Line(Help_Text);
  end if;

  return;

end AdaEncrypt;
