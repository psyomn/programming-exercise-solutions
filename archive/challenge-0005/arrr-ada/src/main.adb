with Ada.Text_IO; 
with Pirates; --... ARRRR
with Pirate_Arena;

procedure Main is 
  
  package ATI renames Ada.Text_IO;
   
  Blackbeard : Pirates.Pirate_Access := 
    Pirates.Create("Blackbeard", 190, 10, 12);

  RedBeard   : Pirates.Pirate_Access := 
    Pirates.Create("Redbeard", 100, 10, 12);

  Neckbeard  : Pirates.Pirate_Access := 
    Pirates.Create("Neckbeard", 50, 10, 12);

  Arena : Pirate_Arena.Arena_Access := 
    Pirate_Arena.Create;
begin
  ATI.Put_Line("Current fighters");
  ATI.New_Line;
  ATI.Put_Line(Pirates.To_String(Blackbeard));
  ATI.Put_Line(Pirates.To_String(Redbeard));
  ATI.Put_Line(Pirates.To_String(Neckbeard));
  ATI.New_Line;

  -- First round
  Pirate_Arena.Set_Champion(Arena, Blackbeard);
  Pirate_Arena.Set_Challenger(Arena, Redbeard);

  Pirate_Arena.Step(Arena);
  Pirate_Arena.Set_Challenger(Arena, Neckbeard);
  Pirate_Arena.Step(Arena);
end Main; 

