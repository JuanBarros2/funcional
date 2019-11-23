module ParserJSON (
    getJSON,
    getTransactions
) where

import qualified Data.ByteString.Lazy as B
import Data.Aeson
import Types
import Data.Maybe

jsonFile :: FilePath
jsonFile = "data/data.json"

getJSON :: IO B.ByteString
getJSON = B.readFile jsonFile

getTransactions :: IO [Transaction]
getTransactions = do
    transactions <- (decode <$> getJSON) :: IO (Maybe [Transaction])
    return (fromJust transactions)