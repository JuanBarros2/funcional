{-# LANGUAGE DeriveGeneric #-}

module (
    GregorianCalendar (..),
    Transaction (..)
) where

import Data.Aeson
import GHC.Generics

data GregorianCalendar = GregorianCalendar {
    year :: Int,
    month :: Int,
    dayOfMonth :: Int
} deriving(Eq, Show)

data Transaction = Transaction {
    date :: GregorianCalendar,
    identifierText :: String,
    value :: Double,
    description :: String,
    docNumber :: Int,
    types :: [String]
} deriving(Eq, Show, Generic)

instance FromJSON GregorianCalendar
instance ToJSON GregorianCalendar

instance FromJSON Transaction
instance ToJSON Transaction