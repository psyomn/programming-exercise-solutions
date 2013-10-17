-- @author Simon Symeonidis 
--   Trying to make a haskell output some pretty fractal graphics
module Main(main) where

import Text.Printf

import Ppm 
import Ppm
import Ppm.Patterns
import Ppm.Filters

import Fractals.Simple

maxPlaneX = 440
maxPlaneY = 440
plane     = makePlane (-2) 2 maxPlaneX (-2) 2 maxPlaneY
slplane   = slice (441) plane 
-- ^ +1 because each row has 0.0 as a point

boolPlane = calculateBool julia slplane

pixelBool b = 
  case b == True of
    True  -> (Pixel 255 255 255)
    False -> (Pixel   0   0   0)

buildImage     [] = [] 
buildImage (x:xs) = map pixelBool x : buildImage xs

main = do
  let image = makeRedImage 440 440
  let ret   = buildImage boolPlane
  let out   = setData image ret
  printf $ outputImage out

