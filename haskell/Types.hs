{-# LANGUAGE DeriveGeneric #-}

module Types (
    GregorianCalendar (..),
    Transaction (..)
) where

import Data.Aeson
import GHC.Generics

data GregorianCalendar = GregorianCalendar {
    year :: Int,
    month :: Int,
    dayOfMonth :: Int
} deriving(Eq, Show, Generic)

data Transaction = Transaction {
    date :: GregorianCalendar,
    identifierText :: String,
    value :: Double,
    description :: String,
    docNumber :: String,
    types :: [String]
} deriving(Eq, Show, Generic)

instance FromJSON GregorianCalendar
instance ToJSON GregorianCalendar

instance FromJSON Transaction
instance ToJSON Transaction