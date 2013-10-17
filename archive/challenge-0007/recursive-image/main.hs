-- @author Simon Symeonidis 
--   Trying to make a haskell output some pretty fractal graphics
module Main(main) where

import Text.Printf

import Ppm 
import Ppm.Patterns
import Ppm.Filters

import Fractals.Simple


main = do
  let image = makeRedImage 440 440
  printf $ outputImage image

