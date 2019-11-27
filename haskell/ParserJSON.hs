module ParserJSON (
    getJSON,
    getJsonTest,
    getTransactions,
    getTransactionsTest
) where

import qualified Data.ByteString.Lazy as B
import Data.Aeson
import Types
import Data.Maybe

jsonFile :: FilePath
jsonFile = "data/data.json"

jsonTestFile :: FilePath
jsonTestFile = "data/dataTest.json"

getJSON :: IO B.ByteString
getJSON = B.readFile jsonFile

getJsonTest :: IO B.ByteString
getJsonTest = B.readFile jsonTestFile

getTransactions :: IO [Transaction]
getTransactions = do
    transactions <- (decode <$> getJSON) :: IO (Maybe [Transaction])
    return (fromJust transactions)

getTransactionsTest :: IO [Transaction]
getTransactionsTest = do
    transactions <- (decode <$> getJsonTest) :: IO (Maybe [Transaction])
    return (fromJust transactions)