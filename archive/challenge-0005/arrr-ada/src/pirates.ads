-- @author psyomn
-- @date 2014-04-18 (iso)
package Pirates is

  type Pirate is tagged private;
  -- Our base class

  type Pirate_Access is access Pirate;

  function create(Name : String; Hitpoints : Integer;
    Power : Integer; Defense : Integer) return Pirate_Access;
 
  function Name(This : Pirate_Access) return String; 

  function Power(This : Pirate_Access) return Integer; 
  
  function Defense(This : Pirate_Access) return Integer;

  function To_String(This : Pirate_Access) return String;

  function Is_Dead(This : Pirate_Access) return Boolean;

  function Hitpoints(This : Pirate_Access) return Integer;

  function CurrentHP(This : Pirate_Access) return Integer;

  procedure Receive_Damage(This : Pirate_Access; Damage : Integer);

  procedure Set_Current_Hitpoints(This : Pirate_Access; 
    Hitpoints : Integer);

  private
    type Pirate is tagged
      record
        Name              : String (1..50);
        Power             : Integer;
        Defense           : Integer;
        Hitpoints         : Integer;
        Current_Hitpoints : Integer;
      end record;

end Pirates;

