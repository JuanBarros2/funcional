module ParserJSON
(
    getJSON
) where

import qualified Data.ByteString.Lazy as B

jsonFile :: FilePath
jsonFile = "data/data.json"

getJSON :: IO B.ByteString
getJSON = B.readFile jsonFile