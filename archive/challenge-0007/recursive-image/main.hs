-- @author Simon Symeonidis 
--   Trying to make a haskell output some pretty fractal graphics
module Main(main) where

import Text.Printf

import Ppm 

main = do
  let image = makeGreenImage 110 110
  printf $ outputImage image
