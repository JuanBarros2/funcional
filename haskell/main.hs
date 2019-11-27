import Types
import Utils
import ParserJSON

-- Retorna as transações do ano escolhido
transactionsByYear :: [Transaction] -> Int -> [Transaction]
transactionsByYear t y = filterByYear y t

-- Retorna as transações do ano e mês escolhidos
transactionsByYearMonth :: [Transaction] -> Int -> Int -> [Transaction]
transactionsByYearMonth t y m = (filterByMonth m (transactionsByYear t y))

-- Retorna as transações do ano, mês e dia escolhidos
transactionsByYearMonthDay :: [Transaction] -> Int -> Int -> Int -> [Transaction]
transactionsByYearMonthDay t y m d = (filterByDay d (transactionsByYearMonth t y m))

-- Retorna o total de receitas do ano
incomesYear :: [Transaction] -> Int -> Double
incomesYear t y = (sumValues (incomes (transactionsByYear t y)))

-- Retorna o total de receitas do mês de um determinado ano
incomesYearMonth :: [Transaction] -> Int -> Int -> Double
incomesYearMonth t y m = (sumValues (incomes (transactionsByYearMonth t y m)))

-- Retorna o total de despesas de um ano
expensesYear :: [Transaction] -> Int -> Double
expensesYear t y = ((sumValues (expenses (transactionsByYear t y))) * (-1))

-- Retorna o total de despesas do mês de um determinado ano
expensesYearMonth :: [Transaction] -> Int -> Int -> Double
expensesYearMonth t y m = ((sumValues (expenses (transactionsByYearMonth t y m))) * (-1))

-- Retorna a sobra do mês de um determinado ano
remainderYearMonth :: [Transaction] -> Int -> Int -> Double
remainderYearMonth t y m = ((incomesYearMonth t y m) - (expensesYearMonth t y m))

-- Retorna o saldo final de um mês de um determinado ano
balanceYearMonth :: [Transaction] -> Int -> Int -> Double
balanceYearMonth t y m = (sumValues (_getBalance (transactionsByYearMonth t y m)))

-- Retorna a média das receitas de um determinado ano
meanIncomeYear :: [Transaction] -> Int -> Double
meanIncomeYear t y = ((incomesYear t y) / (fromIntegral (length (incomes (transactionsByYear t y)))))

-- Retorna a média das despesas de um determinado ano
meanExpenseYear :: [Transaction] -> Int -> Double
meanExpenseYear t y = ((expensesYear t y) / (fromIntegral (length (expenses (transactionsByYear t y)))))

-- Retorna a média das sobras de um determinado ano
meanRemainderYear :: [Transaction] -> Int -> Double
meanRemainderYear t y = ((meanIncomeYear t y) - (meanExpenseYear t y))

-- Retorna o saldo de um dia, de um determinado mês e ano
balanceDay :: [Transaction] -> Int -> Int -> Int -> Double
balanceDay t y m d = (sumValues (_getBalance (previousTransactions d (transactionsByYearMonth t y m))))

-- Retorna o valor da transação
getValue :: [Transaction] -> Transaction -> Double
getValue t (Transaction (GregorianCalendar y m d) idText value desc docNumber types) = (balanceDay t y m d)

-- Retorna o maior saldo da lista
maxBalance :: [Transaction] -> Double -> [Transaction] -> Double
maxBalance _ value [] = value
maxBalance t value (x:xs) = (maxBalance t (maxValue value (getValue t x)) xs)

-- Retorna o menor saldo da lista
minBalance :: [Transaction] -> Double -> [Transaction] -> Double
minBalance _ value [] = value
minBalance t value (x:xs) = (minBalance t (minValue value (getValue t x)) xs)

-- Retorna o maior saldo do mês de um determinado ano
maxBalanceYearMonth :: [Transaction] -> Int -> Int -> Double
maxBalanceYearMonth t y m = (maxBalance t (getValue t (head (transactionsByYearMonth t y m))) (transactionsByYearMonth t y m))

-- Retorna o menor saldo do mês de um determinado ano
minBalanceYearMonth :: [Transaction] -> Int -> Int -> Double
minBalanceYearMonth t y m = (minBalance t (getValue t (head (transactionsByYearMonth t y m))) (transactionsByYearMonth t y m))

-- Adiciona os saldos diários ao fluxo de caixa
_cashFlow :: [Transaction] -> [Transaction] -> [(Int, Double)]
_cashFlow _ [] = []
_cashFlow t ((Transaction (GregorianCalendar y m d) idText value desc docNumber types):xs) = ((d, (balanceDay t y m d)):(_cashFlow t xs))

-- Retorna o fluxo diário do mês de um determinado ano
cashFlow :: [Transaction] -> Int -> Int -> [(Int, Double)]
cashFlow t y m = (noRepeat (_cashFlow t (transactionsByYearMonth t y m)))