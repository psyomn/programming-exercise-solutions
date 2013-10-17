{- @author Simon Symeonidis -}
{- 
  This contains some fractals that may be used in order to generate different
  information, that can then be pipped to some other image library. This is 
  here purely for math stuff. 

  @author Simon Symeonidis 
-}
module Fractals.Simple (
julia
, makePlane
, slice
, calculate
, calculateBool) where

import Data.Complex

type CxDouble = Complex Double

-- |The function allows setting a C of whatever value, but for the sake of 
--   simplicity, we're going to use 0 
julia :: CxDouble -> CxDouble
julia z = z * z + (1 :+ 1)

-- | Check if the given point, after two iterations of a fractal function will
--   be greater than the radius 2 (there was a theory somewhere that I read
--   that generally if two iterations are greater than 2, then the point will
--   go to infinity).
toInfinity :: (CxDouble -> CxDouble) -> CxDouble -> Bool
toInfinity f point = 2 < (euclidean $ f $ f point)

euclidean :: CxDouble -> Double
euclidean cmp = 
  sqrt $ (realPart cmp) ** 2 + (imagPart cmp) ** 2 

-- | Create a cartesian plane composed by xs and ys 
makePlane x1 x2 xpix y1 y2 ypix =
  [y :+ x | x <- (makeRange x1 x2 xpix), y <- (makeRange y1 y2 ypix)]

-- | The range that we're interested in (for example -2 -> 2). 
makeRange :: Double -> Double -> Double -> [Double]
makeRange min max dist = 
  reverse $ makeRangeBack min max (grain min max dist) dist

-- | Slice an array to smaller arrays of `n' size
slice :: Int -> [a] -> [[a]]
slice _  []  = []
slice n arr = take n arr : slice n (drop n arr)

-- | Create a distribution of values in the given array
--   dist is the distribution (how many elements)
--   min is the minimum
--   max is the maximum
makeRangeBack :: Double -> Double -> Double -> Double -> [Double]
makeRangeBack _    _    _  (-1) = []
makeRangeBack min max step curr = 
  min + step * curr : makeRangeBack min max step (curr - 1)

-- | Check out how much each step should be in magnitude given two cartesian
--   points, and the length of the actual picture that portrays it.
grain x y d = ((abs x) + (abs y)) / d

-- | Calculating each coordinate, and spitting out the ensuing plane
calculate :: (CxDouble -> CxDouble) -> [[CxDouble]] -> [[CxDouble]]
calculate _ []     = []
calculate f (x:xs) = map f x : calculate f xs

-- | This is to be used if we're just going to make something that displays
--   black and white. I mainly wrote and am using this in order to debug while
--   keeping fingers crossed that I undestood all the theory / articles I read
--   about fractals.
calculateBool :: (CxDouble -> CxDouble) -> [[CxDouble]] -> [[Bool]]
calculateBool _ []     = []
calculateBool f (x:xs) = map (toInfinity f) x : calculateBool f xs

