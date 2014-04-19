with Ada.Strings.Fixed;

-- @author psyomn
-- @date 2014-04-18 (iso)
package body Pirates is 

  -- @author psyomn
  -- @param Name the name of the pirate... arr
  -- @param Power the physical power used for attacking
  -- @param Defense the defense used for defending
  -- @date 2014-04-18 (iso)
  function create(Name : String; Hitpoints : Integer; Power : Integer;
    Defense : Integer) return Pirate_Access is 

    package SF renames Ada.Strings.Fixed;
    package ST renames Ada.Strings;

    Ctx_Pirate : Pirate_Access;

  begin
    Ctx_Pirate         := new Pirate;

    -- This copies the string because it's fixed.
    SF.Move( 
      Source  => Name,
      Target  => Ctx_Pirate.Name,
      Drop    => ST.Right,
      Justify => ST.Left,
      Pad     => ST.Space);

    Ctx_Pirate.Current_Hitpoints := Hitpoints;
    Ctx_Pirate.Hitpoints := Hitpoints;
    Ctx_Pirate.Power     := Power;
    Ctx_Pirate.Defense   := Defense;

    return Ctx_Pirate;
  end create;

  -- @author psyomn
  -- @param This is the current instance
  -- @date 2014-04-18 (iso)
  function Name(This : Pirate_Access) return String is 
  begin return This.Name; end Name;
  
  -- @author psyomn
  -- @param This is the current instance
  -- @date 2014-04-18 (iso)
  function Power(This : Pirate_Access) return Integer is 
  begin return This.Power; end Power;
  
  -- Get the defense of the pirate
  -- @author psyomn
  -- @param This is the current instance
  -- @date 2014-04-18 (iso)
  function Defense(This : Pirate_Access) return Integer is 
  begin return This.Defense; end Defense;

  -- Return the current HP
  -- @author psyomn
  -- @return the current HP
  -- @date 2014-04-18 (iso)
  function CurrentHP(This : Pirate_Access) return Integer is 
  begin return This.Current_Hitpoints; end CurrentHP;

  -- Return the max HP
  -- @author psyomn
  -- @return the Max HP
  -- @date 2014-04-18 (iso)
  function Hitpoints(This : Pirate_Access) return Integer is 
  begin return This.Hitpoints; end Hitpoints;

  procedure Set_Current_Hitpoints(This : Pirate_Access; Hitpoints : Integer) is begin
    This.Current_Hitpoints := Hitpoints;
  end Set_Current_Hitpoints;

  -- Stringify the pirate
  -- @author psyomn
  -- @param This
  -- @date 2014-04-18 (iso)
  function To_String(This : Pirate_Access) return String is 
    Stringified : String := 
      "Name   : " & Name(This) & ASCII.LF &
      "Power  : " & Integer'Image(Power(This)) & ASCII.LF &
      "Defense: " & Integer'Image(Defense(This)) & ASCII.LF &
      "HP     : " & Integer'Image(CurrentHP(This)) & "/" &
                    Integer'Image(Hitpoints(This)) & ASCII.LF;
  begin
    return Stringified;
  end To_String;

  -- Check to see if the pirate is dead
  -- @author psyomn
  -- @param This
  -- @date 2014-04-18 (iso)
  function Is_Dead(This : Pirate_Access) return Boolean is 
  begin return This.Current_Hitpoints <= 0;
  end Is_Dead;

  procedure Receive_Damage(This : Pirate_Access; Damage : Integer) is
    Current_HP : Integer := CurrentHP(This) - Damage;
  begin
    if Current_HP < 0 then Current_HP := 0; end if;
    Set_Current_Hitpoints(This, Current_HP);
  end Receive_Damage;

end Pirates;

