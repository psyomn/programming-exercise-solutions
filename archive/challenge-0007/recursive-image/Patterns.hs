{-
  Small collections of patterns to make images with.
  @author Simon Symeonidis
-}

module Patterns(
columated
, checkers
) where

import Ppm

{- Create Checkers, which are 1x1 in width and height -}
checkers :: Int -> Int -> [[Pixel Int]]
checkers _ 0 = []
checkers x y = checkerRow x y : checkers x (y - 1)

{- We just use x, and y is used for checker effect -}
checkerRow 0 _ = []
checkerRow x y =
  case odd (x + y) of 
    True  -> makePixel 15 0 0 : checkerRow (x - 1) y
    False -> makePixel 0 15 0 : checkerRow (x - 1) y

{- Column like pattern -}
columated :: Int -> Int -> [[Pixel Int]]
columated _ 0 = []
columated x y = 
  columatedRow x : columated x (y - 1)

columatedRow :: Int -> [Pixel Int]
columatedRow 0 = []
columatedRow x = 
  case odd x of
    True  -> makePixel 15 0 0 : columatedRow (x - 1)
    False -> makePixel 0 15 0 : columatedRow (x - 1)


