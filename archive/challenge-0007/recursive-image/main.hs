-- @author Simon Symeonidis 
--   Trying to make a haskell output some pretty fractal graphics
module Main(main) where

import Text.Printf

import Ppm 

main = do
  let image = makeGreenImage 10 10
  printf $ outputImage image
