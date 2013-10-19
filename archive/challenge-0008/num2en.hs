{- Convert numbers to English
   @author Simon Symeonidis -}

module Main(main) where 

-- Values up to 20 have unique names 

trillion = 1000000000
million  = 1000000
thousand = 1000
hundred  = 100

numtuples = [
  (1, "one"), (2, "two"), (3, "three"), (4, "four"), (5, "five"), (6, "six"),
  (7, "seven"), (8, "eight"), (9, "nine"), (10, "ten"), (11, "eleven"),
  (12, "twelve"), (13, "thirteen"), (14, "fourteen"), (15, "fifteen"), 
  (16, "sixteen"), (17, "seventeen"), (18, "eighteen"), (19, "nineteen"),
  (20, "twenty"), (30, "thirty"), (40, "forty"), (50, "fifty"), (60, "sixty"),
  (70, "seventy"), (80, "eighty"), (90, "ninety"), (100, "hundred"),
  (1000, "thousand"), (1000000, "million"), (1000000000, "trillion")]

revtuples = reverse numtuples

nextSmallest :: Int -> (Int, String)
nextSmallest num = nextSmallest' num revtuples

nextSmallest' :: Int -> [(Int, String)] -> (Int, String)
nextSmallest' _       [] = error "next smallest not found"
nextSmallest' num (t:ts) =
  case num > fst t of 
    False -> nextSmallest' num ts
    True  -> t

lookup :: Int -> (Int, String)
lookup num = lookup' num numtuples

{- backend for lookup -}
lookup' :: Int -> [(Int, String)] -> (Int, String)
lookup' _     [] = error "Did not find number value in tuple list"
lookup' v (t:ts) = 
  case v == fst t of
    True  -> t
    False -> lookup' v ts

{- Generic way of handling different ranges -}
num2Eng :: Int -> Int -> Int -> Int
num2Eng value sub acc = 
  case value - sub >= 0 of
    True  -> num2Eng (value - sub) sub (acc + 1)
    False -> acc

wholeNum2Eng :: Int -> String
wholeNum2Eng 0   = ""
wholeNum2Eng num =
  let tup   = nextSmallest num
      times = num2Eng num (fst tup) 0
      name  = snd tup
      ndiff = num - (times * (fst tup))
  in snd(Main.lookup times) ++ " " ++ name ++
     case ndiff > 0 of
       True -> wholeNum2Eng ndiff
       False -> ""

main = do
  numStr <- getLine
  let num = read numStr :: Int
  putStrLn $ wholeNum2Eng num

