-- @author Simon Symeonidis 

-- Make a table with the required upside down values
upsides = {}
upsides["0"] = 0
upsides["1"] = 1
upsides["2"] = 5
upsides["3"] = 3
upsides["4"] = 4
upsides["5"] = 2
upsides["6"] = 9
upsides["7"] = 7
upsides["8"] = 8
upsides["9"] = 6

function pair_is_ud(num1, num2)
  return upsides[num1] == num2
end

function convert_to_ud(number)
  unumber = ""
  for c in number:gmatch"." do
    if c ~= nil then
      unumber = unumber .. upsides[c] 
    end
  end
  return unumber
end

if #arg ~= 1 then
  print("Usage: ")
  print("  " .. arg[0] .. " <number> ")
  os.exit(0)
end

number = arg[1]
un = convert_to_ud(number) 
print(un)

