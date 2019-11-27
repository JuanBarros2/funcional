import Types
import Utils
import ParserJSON
import Data.List (groupBy)

-- Filtra transações pelo ano
filterByYear :: Int -> [Transaction] -> [Transaction]
filterByYear _ [] = []
filterByYear year (x:xs)
    | year == (getYear x) = x:(filterByYear year xs) -- FILTER filter (checkYear y) (x:xs)
    | otherwise = (filterByYear year xs)

-- Filtra transações pelo mês
filterByMonth :: Int -> [Transaction] -> [Transaction]
filterByMonth _ [] = []
filterByMonth month (x:xs)
    | month == (getMonth x) = x:(filterByMonth month xs)
    | otherwise = (filterByMonth month xs)

-- Filtra transações pelo dia
filterByDay :: Int -> [Transaction] -> [Transaction]
filterByDay _ [] = []
filterByDay day (x:xs)
    | day == (getDay x) = x:(filterByDay day xs)
    | otherwise = (filterByDay day xs)

-- Retorna as transações do ano escolhido
transactionsByYear :: Int -> IO [Transaction]
transactionsByYear y = do
    transactions <- getTransactions
    return (filterByYear y transactions)

-- Retorna as transações do ano e mês escolhidos
transactionsByYearMonth :: Int -> Int -> IO [Transaction]
transactionsByYearMonth y m = do
    transactions <- transactionsByYear y
    return (filterByMonth m transactions)

-- Retorna as transações do ano, mês e dia escolhidos
transactionsByYearMonthDay :: Int -> Int -> Int -> IO [Transaction]
transactionsByYearMonthDay y m d = do
    transactions <- transactionsByYearMonth y m
    return (filterByDay d transactions)

-- Retorna as transações que são receitas
incomes :: [Transaction] -> [Transaction]
incomes [] = []
incomes (x:xs) | ((isIncomeOrExpense x) && (isIncome x)) = x:(incomes xs) -- FILTER
                 | otherwise = (incomes xs)

-- Retorna as transações que são despesas
expenses :: [Transaction] -> [Transaction]
expenses [] = []
expenses (x:xs) | ((isIncomeOrExpense x) && (not (isIncome x))) = x:(expenses xs)  -- FILTER
                 | otherwise = (expenses xs)

-- Soma o valor das transações da lista
sumValues :: [Transaction] -> Double
sumValues [] = 0
sumValues ((Transaction date idText value desc docNumber types):xs) = value + (sumValues xs)

-- Retorna o total de receitas do ano
incomesYear :: Int -> IO Double
incomesYear y = do
    transactionsByYear <- (transactionsByYear y)
    return (sumValues (incomes transactionsByYear))

-- Retorna o total de receitas do mês de um determinado ano
incomesYearMonth :: Int -> Int -> IO Double
incomesYearMonth y m = do
    transactionsByYearMonth <- (transactionsByYearMonth y m)
    return (sumValues (incomes transactionsByYearMonth))

-- Retorna o total de despesas de um ano
expensesYear :: Int -> IO Double
expensesYear y = do
    transactionsByYear <- (transactionsByYear y)
    return ((sumValues (expenses transactionsByYear)) * (-1)) -- VALOR ABSOLUTO

-- Retorna o total de despesas do mês de um determinado ano
expensesYearMonth :: Int -> Int -> IO Double
expensesYearMonth y m = do
    transactionsByYearMonth <- (transactionsByYearMonth y m)
    return ((sumValues (expenses transactionsByYearMonth)) * (-1)) -- VALOR ABSOLUTO

-- Retorna a sobra do mês de um determinado ano
remainderYearMonth :: Int -> Int -> IO Double
remainderYearMonth y m = do
    income <- (incomesYearMonth y m)
    expense <- (expensesYearMonth y m)
    return (income - expense) -- SUBTRAÇÃO

-- Retorna o saldo final de um mês de um determinado ano
balanceYearMonth :: Int -> Int -> IO Double
balanceYearMonth y m = do
        transactions <- (transactionsByYearMonth y m)
        return (sumValues (_getBalance transactions))

-- Retorna a média das receitas de um determinado ano
meanIncomeYear :: Int -> IO Double
meanIncomeYear y = do
    income <- (incomesYear y)
    transactions <- (transactionsByYear y)
    return (income / (fromIntegral (length (incomes transactions))))

-- Retorna a média das despesas de um determinado ano
meanExpenseYear :: Int -> IO Double
meanExpenseYear y = do
    expense <- (expensesYear y)
    transactions <- (transactionsByYear y)
    return (expense / (fromIntegral (length (expenses transactions))))

-- Retorna a média das sobras de um determinado ano
meanRemainderYear :: Int -> IO Double
meanRemainderYear y = do
    meanIncome <- (meanIncomeYear y)
    meanExpense <- (meanExpenseYear y)
    return (meanIncome - meanExpense)

previousTransactions :: Int -> [Transaction] -> [Transaction]
previousTransactions _ [] = []
previousTransactions d (x:xs)
    | (dayOfMonth (date x)) <= d = x:(previousTransactions d xs)
    | otherwise = []

-- Retorna o saldo de um dia, de um determinado mês e ano
balanceDay :: Int -> Int -> Int -> IO Double
balanceDay y m d = do
    transactions <- (transactionsByYearMonth y m)
    return (sumValues (_getBalance (previousTransactions d transactions)))

-- Retorna o valor da transação
-- MUDAR NOME DESSE MÉTODO
getValue :: Transaction -> IO Double
getValue (Transaction (GregorianCalendar y m d) idText value desc docNumber types) = (balanceDay y m d)

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

-- Retorna o maior saldo da lista
maxBalance :: Double -> [Transaction] -> IO Double
maxBalance value [] = do
    return value
maxBalance value (x:xs) = do
    valueTransaction <- (getValue x)
    (maxBalance (maxValue value valueTransaction) xs)

-- Retorna o menor saldo da lista
minBalance :: Double -> [Transaction] -> IO Double
minBalance value [] = do
    return value
minBalance value (x:xs) = do
    valueTransaction <- (getValue x)
    (minBalance (minValue value valueTransaction) xs)

-- Retorna o maior saldo do mês de um determinado ano
maxBalanceYearMonth :: Int -> Int -> IO Double
maxBalanceYearMonth y m = do
    transactions <- (transactionsByYearMonth y m)
    firstTransaction <- (getValue (head transactions))
    (maxBalance firstTransaction transactions)

-- Retorna o menor saldo do mês de um determinado ano
minBalanceYearMonth :: Int -> Int -> IO Double
minBalanceYearMonth y m = do
    transactions <- (transactionsByYearMonth y m)
    firstTransaction <- (getValue (head transactions))
    (minBalance firstTransaction transactions)

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

-- Adiciona os saldos diários ao fluxo de caixa
_cashFlow :: [Transaction] -> IO [(Int, Double)]
_cashFlow [] = do
    return []
_cashFlow ((Transaction (GregorianCalendar y m d) idText value desc docNumber types):xs) = do
    balance <- (balanceDay y m d)
    cashFlow <- (_cashFlow xs)
    return ((d, balance):cashFlow)

-- Retorna o fluxo diário do mês de um determinado ano
cashFlow :: Int -> Int -> IO [(Int, Double)]
cashFlow y m = do
    transactions <- (transactionsByYearMonth y m)
    cashFlow <- (_cashFlow transactions)
    return (noRepeat cashFlow)