module Ppm(
test, 
redOf, blueOf, greenOf
) where

-- A pixel is a tuple of RGB
data Pixel a = Pixel a a a

test :: Int -> Int
test x = x * 42

redOf :: Pixel t -> t
redOf (Pixel x _ _) = x

blueOf :: Pixel t -> t
blueOf (Pixel _ _ x) = x

greenOf :: Pixel t -> t
greenOf (Pixel _ x _) = x

whitePixel :: Pixel t
whitePixel = Pixel 255 255 255

blackPixel :: Pixel t
blackPixel = Pixel 0 0 0

