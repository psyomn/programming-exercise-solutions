{- 
-- Small library that produce P3 ppm images.
-- @author Simon Symeonidis 
-}
module Ppm(
PPMImage
, Pixel
, redOf, blueOf, greenOf
, makePixel
, makeImage
, makeWhiteImage, makeBlackImage, makeRedImage, makeBlueImage, makeGreenImage
, outputImage
, setHeader, setWidth, setHeight, setData
) where

-- A pixel is a tuple of RGB
data Pixel a = Pixel a a a deriving Show

-- PPMImage : header, width, height, data
data PPMImage = PPMImage String Int Int [[Pixel Int]]

-- Header stuff
ppmMagicNumber = "P3"
maxColor = 65536
minColor = 0

boundsCheck :: Int -> Int
boundsCheck x = 
  case x >= minColor && x <= maxColor of 
    True  -> x
    False -> error $ "Pixel values range from 0 to 255, value: " ++ show x

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
makeImage px dimx dimy = 
  PPMImage ppmMagicNumber dimx dimy (makeImageData px dimx dimy)

makeImageData :: Pixel Int -> Int -> Int -> [[Pixel Int]]
makeImageData _  _    0    = []
makeImageData px dimx dimy = makeRow dimx px : makeImageData px dimx (dimy - 1)

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

{- Extract the data, and delegate it to some other function
   that knows how to take care of it (in this case this function
   is imageStringBackend -}
imageString :: PPMImage -> String
imageString (PPMImage _ _ _ dat) = imageStringBackend dat

imageStringBackend :: [[Pixel Int]] -> String
imageStringBackend [] = ""
imageStringBackend (row:rows) = (outputRow row) ++ "\n" ++ imageStringBackend rows

outputImage :: PPMImage -> String
outputImage img = 
  ppmMagicNumber ++ "\n" 
  ++ show (getWidth  img) ++ " " 
  ++ show (getHeight img) ++ "\n"
  ++ "15\n" ++ (imageString img)

setData :: PPMImage -> [[Pixel Int]] -> PPMImage
setData (PPMImage x y z _) new = PPMImage x y z new

setHeader :: PPMImage -> String -> PPMImage
setHeader (PPMImage _ x y z) new = PPMImage new x y z

setWidth :: PPMImage -> Int -> PPMImage
setWidth (PPMImage x y _ z) new = PPMImage x y new z

setHeight :: PPMImage -> Int -> PPMImage
setHeight (PPMImage x _ y z) new = PPMImage x new y z

getData :: PPMImage -> [[Pixel Int]]
getData (PPMImage _ _ _ d) = d

getHeader :: PPMImage -> String
getHeader (PPMImage h _ _ _) = h

getWidth :: PPMImage -> Int
getWidth (PPMImage _ w _ _) = w

getHeight :: PPMImage -> Int
getHeight (PPMImage _ _ h _) = h

