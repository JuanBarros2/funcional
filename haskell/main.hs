import Types
import ParserJSON

-- Filtra transações pelo ano
filterByYear :: Int -> [Transaction] -> [Transaction]
filterByYear _ [] = []
filterByYear year ((Transaction (GregorianCalendar y m d) idText value desc docNumber types):xs)
    | year == y = (Transaction (GregorianCalendar y m d) idText value desc docNumber types):(filterByYear year xs)
    | otherwise = (filterByYear year xs)

-- Filtra transações pelo mês
filterByMonth :: Int -> [Transaction] -> [Transaction]
filterByMonth _ [] = []
filterByMonth month ((Transaction (GregorianCalendar y m d) idText value desc docNumber types):xs)
    | month == m = (Transaction (GregorianCalendar y m d) idText value desc docNumber types):(filterByMonth month xs)
    | otherwise = (filterByMonth month xs)

-- Filtra transações pelo dia
filterByDay :: Int -> [Transaction] -> [Transaction]
filterByDay _ [] = []
filterByDay day ((Transaction (GregorianCalendar y m d) idText value desc docNumber types):xs)
    | day == d = (Transaction (GregorianCalendar y m d) idText value desc docNumber types):(filterByDay day xs)
    | otherwise = (filterByDay day xs)

-- Retorna as transações do ano escolhido
getTransactionsByYear :: Int -> IO [Transaction]
getTransactionsByYear y = do
    transactions <- getTransactions
    return (filterByYear y transactions)

-- Retorna as transações do ano e mês escolhidos
getTransactionsByYearMonth :: Int -> Int -> IO [Transaction]
getTransactionsByYearMonth y m = do
    transactions <- getTransactionsByYear y
    return (filterByMonth m transactions)

-- Retorna as transações do ano, mês e dia escolhidos
getTransactionsByYearMonthDay :: Int -> Int -> Int -> IO [Transaction]
getTransactionsByYearMonthDay y m d = do
    transactions <- getTransactionsByYearMonth y m
    return (filterByDay d transactions)

-- Verifica se a transação é uma receita ou despesa
isIncomeOrExpense :: Transaction -> Bool
isIncomeOrExpense (Transaction date idText value desc docNumber types) =
    not (elem "SALDO_CORRENTE" types || elem "APLICACAO" types || elem "value_APLICACAO" types)

-- Verifica se a transação é uma receita
isIncome :: Transaction -> Bool
isIncome (Transaction date idText value desc docNumber types) = value >= 0

-- Retorna as transações que são receitas
getIncome :: [Transaction] -> [Transaction]
getIncome [] = []
getIncome (x:xs) | ((isIncomeOrExpense x) && (isIncome x)) = x:(getIncome xs)
                 | otherwise = (getIncome xs)

-- Retorna as transações que são despesas
getExpense :: [Transaction] -> [Transaction]
getExpense [] = []
getExpense (x:xs) | ((isIncomeOrExpense x) && (not (isIncome x))) = x:(getExpense xs)
                 | otherwise = (getExpense xs)

-- Soma o valor das transações da lista
sumValues :: [Transaction] -> Double
sumValues [] = 0
sumValues ((Transaction date idText value desc docNumber types):xs) = value + (sumValues xs)

-- Retorna o total de receitas do ano
getIncomeYear :: Int -> IO Double
getIncomeYear y = do
    transactionsByYear <- (getTransactionsByYear y)
    return (sumValues (getIncome transactionsByYear))

-- Retorna o total de receitas de um mês de um determinado ano
getIncomeYearMonth :: Int -> Int -> IO Double
getIncomeYearMonth y m = do
    transactionsByYearMonth <- (getTransactionsByYearMonth y m)
    return (sumValues (getIncome transactionsByYearMonth))

-- Retorna o total de despesas de um ano
getExpenseYear :: Int -> IO Double
getExpenseYear y = do
    transactionsByYear <- (getTransactionsByYear y)
    return (sumValues (getExpense transactionsByYear))

-- Retorna o total de despesas de um mês de um determinado ano
getExpenseYearMonth :: Int -> Int -> IO Double
getExpenseYearMonth y m = do
    transactionsByYearMonth <- (getTransactionsByYearMonth y m)
    return (sumValues (getExpense transactionsByYearMonth))

-- Retorna a sobra de um mês de um determinado ano
getRemainderYearMonth :: Int -> Int -> IO Double
getRemainderYearMonth y m = do
    income <- (getIncomeYearMonth y m)
    expense <- (getExpenseYearMonth y m)
    return (income + expense)

-- Retorna o saldo final de um mês de um determinado ano
getBalanceYearMonth :: Int -> Int -> IO Double
getBalanceYearMonth y m = do
        transactions <- getTransactions
        return (sumValues transactions)

-- Retorna a média das receitas de um determinado ano
meanIncomeYear :: Int -> IO Double
meanIncomeYear y = do
    income <- (getIncomeYear y)
    return (income / 12)

-- Retorna a média das despesas de um determinado ano
meanExpenseYear :: Int -> IO Double
meanExpenseYear y = do
    expense <- (getExpenseYear y)
    return (expense / 12)

-- Retorna a média das sobras de um determinado ano
meanRemainderYear :: Int -> IO Double
meanRemainderYear y = do
    meanIncome <- (meanIncomeYear y)
    meanExpense <- (meanExpenseYear y)
    return (meanIncome + meanExpense)

-- Retorna o saldo de um dia, de um determinado mês e ano
getBalanceDay :: Int -> Int -> Int -> IO Double
getBalanceDay y m d = do
    transactions <- (getTransactionsByYearMonthDay y m d)
    return (sumValues transactions)