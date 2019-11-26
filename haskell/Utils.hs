module Utils (
    getDay,
    getMonth,
    getYear,
    getCurrentBalance,
    isIncomeOrExpense,
    isIncome,
    isCurrentBalance,
    _getBalance
) where

import Types

getDay :: Transaction -> Int
getDay (Transaction (GregorianCalendar y m d) idText value desc docNumber types) = d

getMonth :: Transaction -> Int
getMonth (Transaction (GregorianCalendar y m d) idText value desc docNumber types) = m

getYear :: Transaction -> Int
getYear (Transaction (GregorianCalendar y m d) idText value desc docNumber types) = y

getCurrentBalance :: [Transaction] -> [Transaction]
getCurrentBalance ((Transaction date idText value desc docNumber types):xs)
    | elem "Saldo Corrente" types = (Transaction date idText value desc docNumber types):(getCurrentBalance xs) -- SALDO_CORRENTE
    | otherwise = (getCurrentBalance xs)

-- Verifica se a transação é uma receita ou despesa
isIncomeOrExpense :: Transaction -> Bool
isIncomeOrExpense (Transaction date idText value desc docNumber types) =
    not (elem "Saldo Corrente" types || elem "Aplicacao" types || elem "Valor aplicado" types)

-- Verifica se a transação é uma receita
isIncome :: Transaction -> Bool
isIncome (Transaction date idText value desc docNumber types) = value >= 0

isCurrentBalance :: Transaction -> Bool
isCurrentBalance (Transaction date idText value desc docNumber types) = (elem "Saldo Corrente" types)

-- MUDAR NOME DESSE MÉTODO
_getBalance :: [Transaction] -> [Transaction]
_getBalance [] = []
_getBalance (x:xs)
    | ((isIncomeOrExpense x) || (isCurrentBalance x)) = x:(_getBalance xs)
    | otherwise = (_getBalance xs)