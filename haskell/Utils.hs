module Utils (
    getDay,
    getMonth,
    getYear,
    getCurrentBalance,
    isIncomeOrExpense,
    isIncome,
    isCurrentBalance,
    _getBalance,
    filterByDay,
    filterByMonth,
    filterByYear,
    expenses,
    incomes,
    sumValues,
    previousTransactions,
    maxValue,
    minValue,
    noRepeat,
    exist,
    sameDay
) where

import Types

getDay :: Transaction -> Int
getDay t = ((dayOfMonth . date) t)

getMonth :: Transaction -> Int
getMonth t = ((month . date) t)

getYear :: Transaction -> Int
getYear t = ((year . date) t)

checkYear :: Int -> Transaction -> Bool
checkYear y t = ((getYear t) == y)

checkMonth :: Int -> Transaction -> Bool
checkMonth m t = ((getMonth t) == m)

checkDay :: Int -> Transaction -> Bool
checkDay d t = ((getDay t) == d)

-- Filtra transações pelo ano
filterByYear :: Int -> [Transaction] -> [Transaction]
filterByYear y transactions = filter (checkYear y) transactions

-- Filtra transações pelo mês
filterByMonth :: Int -> [Transaction] -> [Transaction]
filterByMonth m transactions = filter (checkMonth m) transactions

-- Filtra transações pelo dia
filterByDay :: Int -> [Transaction] -> [Transaction]
filterByDay d transactions = filter (checkDay d) transactions

-- Verifica se a transação é uma receita ou despesa
isIncomeOrExpense :: Transaction -> Bool
isIncomeOrExpense t = not (elem SALDO_CORRENTE (types t) || elem APLICACAO (types t) || elem VALOR_APLICACAO (types t))

-- Verifica se a transação é uma receita
isIncome :: Transaction -> Bool
isIncome t = (isIncomeOrExpense t) && (value t) >= 0

-- Verifica se a transação é uma despesa
isExpense :: Transaction -> Bool
isExpense t = (isIncomeOrExpense t) && (value t) < 0

-- Retorna as transações que são receitas
incomes :: [Transaction] -> [Transaction]
incomes transactions = filter (isIncome) transactions

-- Retorna as transações que são despesas
expenses :: [Transaction] -> [Transaction]
expenses transactions = filter (isExpense) transactions

-- Soma o valor das transações da lista
sumValues :: [Transaction] -> Double
sumValues [] = 0
sumValues (x:xs) = (value x) + (sumValues xs)

getCurrentBalance :: [Transaction] -> [Transaction]
getCurrentBalance (x:xs)
    | elem SALDO_CORRENTE (types x) = x:(getCurrentBalance xs)
    | otherwise = (getCurrentBalance xs)

isCurrentBalance :: Transaction -> Bool
isCurrentBalance t = (elem SALDO_CORRENTE (types t))

_getBalance :: [Transaction] -> [Transaction]
_getBalance [] = []
_getBalance (x:xs)
    | ((isIncomeOrExpense x) || (isCurrentBalance x)) = x:(_getBalance xs)
    | otherwise = (_getBalance xs)

previousTransactions :: Int -> [Transaction] -> [Transaction]
previousTransactions _ [] = []
previousTransactions d (x:xs)
    | (dayOfMonth (date x)) <= d = x:(previousTransactions d xs)
    | otherwise = []

-- Retorna o maior elemento
maxValue :: Double -> Double -> Double
maxValue max value
    | max > value = max
    | otherwise = value

-- Retorna o menor elemento
minValue :: Double -> Double -> Double
minValue min value
    | min < value = min
    | otherwise = value

-- Verifica se elemento existe na lista 
exist :: (Int, Double) -> [(Int, Double)] -> Bool
exist balance [] = False
exist balance (x:xs)
    | balance == x = True
    | otherwise = (exist balance xs)

-- Retira da lista elementos repetidos
noRepeat :: [(Int, Double)] -> [(Int, Double)]
noRepeat [] = []
noRepeat (x:xs)
    | (exist x xs) = (noRepeat xs)
    | otherwise = x:(noRepeat xs)

sameDay :: Transaction -> Transaction -> Bool
sameDay t1 t2 = ((dayOfMonth . date) t1) == ((dayOfMonth . date) t2)