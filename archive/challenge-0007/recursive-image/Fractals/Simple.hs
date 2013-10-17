{- @author Simon Symeonidis -}
module Fractals.Simple (julia) where

import Data.Complex

{- The function allows setting a C of whatever value, but for the sake of 
 simplicity, we're going to use 0 -}

julia :: RealFloat a => Complex a -> Complex a
julia z = z * z + (0 :+ 0)

-- toInfinity :: (RealFloat a => Complex a -> Complex a) -> Complex a -> Bool
toInfinity f point = 2 < (euclidean $ f $ f point)

euclidean :: RealFloat a => Complex a -> a 
euclidean cmp = 
  sqrt $ (realPart cmp) ** 2 + (imagPart cmp) ** 2 

-- | Create a cartesian plane composed by xs and ys 
makePlane x1 x2 xpix y1 y2 ypix =
  [[y :+ x] | x <- (makeRange x1 x2 xpix), y <- (makeRange y1 y2 ypix)]

-- | The range that we're interested in (for example -2 -> 2). 
makeRange :: Double -> Double -> Double -> [Double]
makeRange min max dist = 
  reverse $ makeRangeBack min max (grain min max dist) dist

-- | Create a distribution of values in the given array
-- @param dist is the distribution (how many elements)
-- @param minx is the minimum x
-- @param maxx is the maximum x
makeRangeBack :: Double -> Double -> Double -> Double -> [Double]
makeRangeBack _    _    _  (-1) = []
makeRangeBack min max step curr = 
  min + step * curr : makeRangeBack min max step (curr - 1)

grain x y d = ((abs x) + (abs y)) / d

