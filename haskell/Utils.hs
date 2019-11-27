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
getDay t = ((dayOfMonth . date) t)

getMonth :: Transaction -> Int
getMonth (Transaction (GregorianCalendar y m d) idText value desc docNumber types) = m

getYear :: Transaction -> Int
getYear (Transaction (GregorianCalendar y m d) idText value desc docNumber types) = y

getCurrentBalance :: [Transaction] -> [Transaction]
getCurrentBalance ((Transaction date idText value desc docNumber types):xs)
    | elem SALDO_CORRENTE types = (Transaction date idText value desc docNumber types):(getCurrentBalance xs) -- SALDO_CORRENTE
    | otherwise = (getCurrentBalance xs)

-- Verifica se a transação é uma receita ou despesa
isIncomeOrExpense :: Transaction -> Bool
isIncomeOrExpense t = not (elem SALDO_CORRENTE (types t) || elem APLICACAO (types t) || elem VALOR_APLICACAO (types t))

-- Verifica se a transação é uma receita
isIncome :: Transaction -> Bool
isIncome t = (value t) >= 0

isCurrentBalance :: Transaction -> Bool
isCurrentBalance t = (elem SALDO_CORRENTE (types t))

-- MUDAR NOME DESSE MÉTODO
_getBalance :: [Transaction] -> [Transaction]
_getBalance [] = []
_getBalance (x:xs)
    | ((isIncomeOrExpense x) || (isCurrentBalance x)) = x:(_getBalance xs)
    | otherwise = (_getBalance xs)