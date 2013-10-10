-- @author Simon Symeonidis 
--   Trying to make a haskell output some pretty fractal graphics
module Main(main) where

import Text.Printf

import Ppm 
import Ppm.Patterns
import Ppm.Filters

main = do
  let image   = makeRedImage 110 110
  let dat     = revRow $ shadow $ getData image
  let edited  = setData image dat
  printf $ outputImage edited


