-- @author Simon Symeonidis 
-- Date : Mon Oct  7 23:41:29 EDT 2013
-- Convert morse to alphabetical stuff

module Main(main) where

import System.Exit
import Text.Printf
import System.IO
import Data.List.Split

type MorseTuple = (String,String)
type MorseCollection = [MorseTuple]

-- To make the code more concise, we treat ' ' as a valid relation to '/' in
-- the morse code
alphabet = [
  "A", "B", "C", "D", "E", "F", "G", "H", "I", "J", "K",
  "L", "M", "N", "O", "P", "Q", "R", "S", "T", "U", "V",
  "W", "X", "Y", "Z", "1", "2", "3", "4", "5", "6", "7",
  "8", "9", "0", " "]

-- To make the code more concise, we treat '/' as a valid input for the morse
-- code
morse = [
  ".-", "-...", "-.-.", "-..", ".", "..-.", "--.", "....", "..", ".---",
  "-.-", ".-..", "--", "-.", "---", ".--.", "--.-", ".-.", "...", "-", 
  "..-", "...-", ".--", "-..-", "-.--", "--..", ".----", "..---", "...--",
  "....-", ".....", "-....", "--...", "---..", "----.", "-----", "/"]

am_tup = makeA2M

-- make alphabet to morse
makeA2M :: [MorseTuple]
makeA2M = zip alphabet morse

fintT :: String -> [MorseTuple] -> ((a,a) -> a) -> ((a,a) -> a) -> String
fintT _ []     _   _   = "NOT FOUND"
findT m (x:xs) one two = case one x == m of 
                           True -> two x
                           _    -> findT m xs one two

-- Find letter, given morse (this is the interface function)
iFindM :: String -> String
iFindM term = findT term am_tup snd fst

iFindA :: String -> String
iFindA term = findT term am_tup fst snd

-- Placeholder
findA = []

arrToString :: [String] -> String
arrToString []     = ""
arrToString (x:xs) = x ++ arrToString xs

main :: IO ()
main = do
  x <- getLine
  let stuff    = makeA2M
  let sequence = splitOn " " x
  let output   = map iFindM sequence
  let poutput  = arrToString output
  printf poutput
  exitWith ExitSuccess

