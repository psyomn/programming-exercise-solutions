module Ppm(
redOf, blueOf, greenOf
, makePixel
, makeImage
, makeWhiteImage
, makeBlackImage
) where

-- A pixel is a tuple of RGB
data Pixel a = Pixel a a a deriving Show

boundsCheck :: Int -> Int
boundsCheck x = case x >= 0 && x <= 255 of 
                  True -> x
                  False -> error "Pixel values range from 0 to 255"

redOf :: Pixel t -> t
redOf (Pixel x _ _) = x

blueOf :: Pixel t -> t
blueOf (Pixel _ _ x) = x

greenOf :: Pixel t -> t
greenOf (Pixel _ x _) = x

whitePixel :: Pixel Int
whitePixel = Pixel 255 255 255

blackPixel :: Pixel Int
blackPixel = Pixel 0 0 0

makePixel :: Int -> Int -> Int -> Pixel Int
makePixel r g b = Pixel (boundsCheck r) (boundsCheck g) (boundsCheck b)

--
-- Image Creation routines
--

-- Aux function, not to be used
makeRow :: Int -> Pixel t -> [Pixel t]
makeRow 0  _  = []
makeRow it px = px : makeRow (it - 1) px

makeImage :: Pixel Int -> Int -> Int -> [[Pixel Int]]
makeImage _  _    0    = []
makeImage px dimx dimy = makeRow dimx px : makeImage px dimx (dimy - 1)

makeWhiteImage :: Int -> Int -> [[Pixel Int]]
makeWhiteImage x y = makeImage whitePixel x y

makeBlackImage :: Int -> Int -> [[Pixel Int]]
makeBlackImage x y = makeImage blackPixel x y

