-- @author Simon Symeonidis 
--   Trying to make a haskell output some pretty fractal graphics
module Main(main) where

import Text.Printf

import Ppm 

checkers :: Int -> Int -> [[Pixel Int]]
checkers _ 0 = []
checkers x y = 
  checkerRow x : checkers x (y - 1)

checkerRow :: Int -> [Pixel Int]
checkerRow x = 
  case x == 0 of 
    True -> []
    False -> case odd x of
               True  -> makePixel 15 0 0 : checkerRow (x - 1)
               False -> makePixel 0 15 0 : checkerRow (x - 1)

main = do
  let image = makeWhiteImage 110 110
  let pattern = setData image (checkers 110 110)
  printf $ outputImage pattern
