-- @author Simon Symeonidis 
--   Trying to make a haskell output some pretty fractal graphics
module Main(main) where

import Ppm 

main = do
  let image = makeWhiteImage 10 10
  print image
