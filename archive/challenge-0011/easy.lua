-- Check to see that user provides enough information
if #arg <= 2 then
  print("Usage :")
  print("  easy.lua <day> <month> <year>")
  os.exit(0)
end

date = os.time{year=arg[3], month=arg[2], day=arg[1]}

print(os.date("%A", date))

