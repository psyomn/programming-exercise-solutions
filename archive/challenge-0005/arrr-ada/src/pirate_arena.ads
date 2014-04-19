with Pirates;

package Pirate_Arena is 
 
  type Arena is tagged private;

  type Arena_Access is access Arena;

  procedure Heal_Fighter(Pirate : Pirates.Pirate_Access);

  procedure Step(This : Arena_Access);

  function Create return Arena_Access;

  procedure Set_Champion(This : Arena_Access; Pirate : Pirates.Pirate_Access);

  procedure Set_Challenger(This : Arena_Access; Pirate : Pirates.Pirate_Access);

  procedure Print_Death_Message(This : Arena_Access);

  type Arena_Winner is (Challenger, Champion);

  private
    type Arena is tagged
      record
        Pirate_1 : Pirates.Pirate_Access;
        Pirate_2 : Pirates.Pirate_Access;
        Winrar   : Arena_Winner;
      end record;

end Pirate_Arena;

