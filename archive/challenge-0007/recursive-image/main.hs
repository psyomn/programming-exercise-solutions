-- @author Simon Symeonidis 
--   Trying to make a haskell output some pretty fractal graphics
module Main(main) where

import Text.Printf

import Ppm 
import Ppm.Patterns
import Ppm.Filters

import Fractals.Simple

main = do
  let image   = makeRedImage 510 510
  let dat     = revRow $ shadow $ getData image
  let edited  = setData image dat
  printf $ outputImage edited


