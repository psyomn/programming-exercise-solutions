with Ada.Text_IO;
with Ada.Strings;
with Ada.Strings.Fixed;
with Pirates; 

package body Pirate_Arena is

  -- Constructor
  function Create return Arena_Access is 
    Ctx_Arena : Arena_Access := new Arena;
  begin return Ctx_Arena; end Create;

  -- We heal the fighters after the match is over and the next contestant is
  -- to be added.
  procedure Heal_Fighter(Pirate : Pirates.Pirate_Access) is
  begin 
    Pirates.Set_Current_Hitpoints(Pirate,
      Pirates.Hitpoints(Pirate));
  end Heal_Fighter;

  procedure Set_Champion(This : Arena_Access; Pirate : Pirates.Pirate_Access) is
  begin This.Pirate_1 := Pirate; end Set_Champion;

  procedure Set_Challenger(This : Arena_Access; Pirate : Pirates.Pirate_Access) is 
  begin This.Pirate_2 := Pirate; end Set_Challenger;

  procedure Print_Death_Message(This : Arena_Access) is
  begin
    if Pirates.Is_Dead(This.Pirate_1) then
      Ada.Text_IO.Put_Line("The one who died was " &
        Pirates.Name(This.Pirate_1));
    else
      Ada.Text_IO.Put_Line("The one who died was " &
        Pirates.Name(This.Pirate_2));
    end if;
  end Print_Death_Message;

  -- @author psyomn
  -- @date 2014-04-18 (iso)
  procedure Step(This : Arena_Access) is 
    use Ada.Text_IO; use Ada.Strings;
    use Ada.Strings.Fixed;

    Damage : Integer := 0;
    Index            : Arena_Winner := Champion;
    Current_Attacker : Pirates.Pirate_Access; 
    Current_Defender : Pirates.Pirate_Access;
  begin 
    while (not Pirates.Is_Dead(This.Pirate_1)) and
          (not Pirates.Is_Dead(This.Pirate_2)) loop

      case Index is
      when Champion   => 
        Current_Attacker := This.Pirate_1;
        Current_Defender := This.PIrate_2;
        Index            := Challenger;
      when Challenger => 
        Current_Attacker := This.Pirate_2;
        Current_Defender := This.Pirate_1;
        Index            := Champion;
      end case;

      Damage := Pirates.Power(Current_Attacker);
      Put_Line(
        "[" & Integer'Image(Pirates.CurrentHP(Current_Attacker)) & "/" & 
        Integer'Image(Pirates.Hitpoints(Current_Attacker)) & "]" &
        Trim(Pirates.Name(Current_Attacker), Both) & " attacks for "&
        Integer'Image(Damage) & " hitpoints!");
      
      Pirates.Receive_Damage(Current_Defender, Damage);
      delay 0.4;
    end loop;

    Print_Death_Message(This);

    if not Pirates.Is_Dead(This.Pirate_1) then This.Winrar := Champion; end if;
    if not Pirates.Is_Dead(This.Pirate_2) then 
      This.Winrar := Champion; 
      This.Pirate_1 := This.Pirate_2;
      This.Pirate_2 := null;
    end if;

    Heal_Fighter(This.Pirate_1);

  end Step;
end Pirate_Arena;

