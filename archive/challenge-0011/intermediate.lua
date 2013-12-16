-- @author Simon Symeonidis 

-- Make a table with the required upside down values
upsides = {}
upsides["1"] = 1
upsides["2"] = 5
upsides["5"] = 2
upsides["6"] = 9
upsides["8"] = 8
upsides["9"] = 6

function pair_is_ud(num1, num2)
  return upsides[num1] == num2
end

if #arg ~= 1 then
  print("Usage: ")
  print("  " .. arg[0] .. " <number> ")
  os.exit(0)
end

number = arg[1]


