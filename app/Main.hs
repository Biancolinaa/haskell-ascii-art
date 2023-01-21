module Main where

import           Codec.Picture
import           Data.List.Split
import qualified Data.Vector.Storable as V
import           Data.Word
import           System.Environment
import           System.Exit

main :: IO ()
main = do
  args <- getArgs
  case args of
    (input : output :_) -> do
      img <- readImage input
      case img of
        Left str  -> print str
        Right img -> writeFile output . convert $ img
    _ -> putStrLn "Usage: haskell-ascii-art input-image output-file" >> exitFailure

convert :: DynamicImage -> String
convert = unlines . imageToAscii . grayscale
  where
    grayscale = pixelMap pixelAvg . convertRGBA8
    -- contrast preserving for human vision RGB -> Gray is the following 0.2989 * R + 0.5870 * G + 0.1140 * B
    pixelAvg (PixelRGBA8 r g b a) = round (0.2989 * fromIntegral r + 0.5870 * fromIntegral g + 0.1140 * fromIntegral b)

imageToAscii :: Image Pixel8 -> [String]
imageToAscii img =
  chunksOf (imageWidth img)
  . V.toList
  . V.map ((asciiChars !!) . fromIntegral)
  . imageData
  . pixelMap (`div` numBin)
  $ img
  where
    numBin = fromIntegral (1 + 255 `div` length asciiChars)

-- Invert this list if background is light
asciiChars :: [Char]
asciiChars = " .:;|=%&@#"
