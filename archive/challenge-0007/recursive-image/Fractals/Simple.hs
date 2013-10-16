{- @author Simon Symeonidis -}
module Fractals.Simple (julia ) where

import Data.Complex

{- The function allows setting a C of whatever value, but for the sake of 
 simplicity, we're going to use 0 -}

julia :: RealFloat a => Complex a -> Complex a
julia z = z * z + (0 :+ 0)

toInfinity f point = 2 < (euclidean $ f $ f point)

euclidean :: RealFloat a => Complex a -> a 
euclidean cmp = 
  sqrt $ (realPart cmp) ** 2 + (imagPart cmp) ** 2 

makeRange minx maxx dist = makeRangeBack minx maxx dist dist

-- Create a distribution of values in the given array
-- @param dist is the distribution (how many elements)
-- @param minx is the minimum x
-- @param maxx is the maximum x
makeRangeBack _    _    _    0    = []
makeRangeBack minx maxx dist currd = 
  minx + (grain minx maxx dist) * currd 
    : makeRangeBack minx maxx dist (currd - 1)

grain x y d = ((abs x) + (abs y)) / d
