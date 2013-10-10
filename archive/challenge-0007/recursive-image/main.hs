-- @author Simon Symeonidis 
--   Trying to make a haskell output some pretty fractal graphics
module Main(main) where

import Text.Printf

import Ppm 
import Patterns

main = do
  let image = makeWhiteImage 110 110
  let pattern = setData image (checkers 110 110)
  printf $ outputImage pattern
