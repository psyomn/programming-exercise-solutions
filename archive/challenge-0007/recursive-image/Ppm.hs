--
-- A simple PPM library to output pictures. You can see the specification here:
--   netpbm.sourceforge.net/doc/ppm.html
-- @author Simon Symeonidis
-- 

module Ppm(
redOf, blueOf, greenOf
, makePixel
, makeImage
, makeWhiteImage, makeBlackImage, makeRedImage, makeBlueImage, makeGreenImage
, outputImage
) where

-- A pixel is a tuple of RGB
data Pixel a = Pixel a a a deriving Show

type PPMImage = [[Pixel Int]]

-- Header stuff
ppmMagicNumber = "P3"
maxColor = 65536
minColor = 0

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
whitePixel = Pixel 254 254 254

blackPixel :: Pixel Int
blackPixel = Pixel 0 0 0

redPixel :: Pixel Int
redPixel = Pixel 15 0 0

bluePixel :: Pixel Int
bluePixel = Pixel 0 0 15

greenPixel :: Pixel Int
greenPixel = Pixel 0 15 0

makePixel :: Int -> Int -> Int -> Pixel Int
makePixel r g b = Pixel (boundsCheck r) (boundsCheck g) (boundsCheck b)

--
-- Image Creation routines
--

-- Aux function, not to be used
makeRow :: Int -> Pixel t -> [Pixel t]
makeRow 0  _  = []
makeRow it px = px : makeRow (it - 1) px

makeImage :: Pixel Int -> Int -> Int -> PPMImage
makeImage _  _    0    = []
makeImage px dimx dimy = makeRow dimx px : makeImage px dimx (dimy - 1)

makeImageT :: Pixel Int -> Int -> Int -> PPMImage
makeImageT p x y = makeImage p x y

makeWhiteImage x y = makeImage whitePixel x y
makeBlackImage x y = makeImage blackPixel x y
makeGreenImage x y = makeImage greenPixel x y 
makeBlueImage  x y = makeImage bluePixel  x y
makeRedImage   x y = makeImage redPixel   x y

-- Pixel 0 1 2 -> "0 1 2"
pixelString :: Pixel Int -> String
pixelString pixel = 
     (show $ redOf pixel) ++ " "
  ++ (show $ greenOf pixel) ++ " "
  ++ (show $ blueOf pixel)

outputRow :: [Pixel Int] -> String
outputRow [] = ""
outputRow (x:xs) = pixelString x ++ " " ++ outputRow xs

imageString :: PPMImage -> String
imageString [] = ""
imageString (row:rows) = (outputRow row) ++ "\n" ++ imageString rows

outputImage :: PPMImage -> String
outputImage [] = ""
outputImage img = ppmMagicNumber ++ "\n10 10\n15\n" ++ (imageString img)

