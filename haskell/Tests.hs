import Test.HUnit
import Types
import Utils
import ParserJSON
import Controller

testTransactionsByYearEmpty = TestCase (
    do
        t <- getTransactions
        assertEqual "Transações do ano de 2017" [] (transactionsByYear t 2016)
    )

testTransactionsByYearNotEmpty = TestCase (
    do
        t <- getTransactions
        assertEqual "Transações do ano de 2018" 1146 (length (transactionsByYear t 2018))
    )

testTotalIncomes2019Janeiro  = TestCase (
    do 
        t <- getTransactionsTest
        assertEqual "Receitas de 2019" 4407.76 (incomesYearMonth t 2019 0)
    )

testTotalIncomes2017Marco  = TestCase (
    do 
        t <- getTransactionsTest
        assertEqual "Receitas de 2017" 0 (incomesYearMonth t 2017 2)
    )

testTotalIncomes2018Marco  = TestCase (
    do 
        t <- getTransactionsTest
        assertEqual "Receitas de 2018" 2635.96 (incomesYearMonth t 2018 2)
    )

testTotalExpenses2019Janeiro  = TestCase (
    do 
        t <- getTransactionsTest
        assertEqual "Despesas de 2019" 300 (expensesYearMonth t 2019 0)
    )

testTotalExpenses2017Marco  = TestCase (
    do 
        t <- getTransactionsTest
        assertEqual "Despesas de 2017" 0 (expensesYearMonth t 2017 2)
    )

testTotalExpenses2018Marco  = TestCase (
    do 
        t <- getTransactionsTest
        assertEqual "Despesas de 2018" 50 (expensesYearMonth t 2018 2)
    )

testRemainderYearMonth2017Marco = TestCase (
    do
        t <-getTransactionsTest
        assertEqual "Sobra do mes de marco de 2017" 0 (remainderYearMonth t 2017 2)
    )

testRemainderYearMonth2018Marco = TestCase (
    do
        t <-getTransactionsTest
        assertEqual "Sobra do mes de marco de 2017" 2585.96 (remainderYearMonth t 2018 2)
    )

testBalanceYearMonth2017Marco = TestCase (
    do
        t <-getTransactionsTest
        assertEqual "Saldo Final do mes de marco de 2017" 0 (balanceYearMonth t 2017 2)
    )

testBalanceYearMonth2018Marco = TestCase (
    do
        t <-getTransactionsTest
        assertEqual "Saldo Final do mes de marco de 2017" 44090.67 (balanceYearMonth t 2018 2)
    )

testMaxBalanceYearMonth2017Marco = TestCase (
    do
        t <-getTransactionsTest
        assertEqual "Maior saldo final do mes de marco de 2017" 0 (maxBalanceYearMonth t 2017 2)
    )

testMaxBalanceYearMonth2018Marco = TestCase (
    do
        t <-getTransactionsTest
        assertEqual "Maior saldo final do mes de marco de 2018" 44090.67 (maxBalanceYearMonth t 2018 2)
    )

testMinBalanceYearMonth2017Marco = TestCase (
    do
        t <-getTransactionsTest
        assertEqual "Menor saldo final do mes de marco de 2017" 0 (maxBalanceYearMonth t 2017 2)
    )

testMinBalanceYearMonth2018Marco = TestCase (
    do
        t <-getTransactionsTest
        assertEqual "Menor saldo final do mes de marco de 2018" 44090.67 (maxBalanceYearMonth t 2018 2)
    )

testMeanIncomes2017 = TestCase (
    do
        t <-getTransactionsTest
        assertEqual "Media de receitas de 2017" 0 (meanIncomeYear t 2017)
    )

testMeanIncomes2018 = TestCase (
    do
        t <-getTransactionsTest
        assertEqual "Media de receitas de 2018" 1364.205 (meanIncomeYear t 2018)
    )

testMeanExpenses2017 = TestCase (
    do
        t <-getTransactionsTest
        assertEqual "Media de despesas de 2017" 0 (meanExpenseYear t 2017)
    )

testMeanExpenses2018 = TestCase (
    do
        t <-getTransactionsTest
        assertEqual "Media de despesas de 2018" 1155 (meanExpenseYear t 2018)
    )

testMeanRemainder2017 = TestCase (
    do
        t <-getTransactionsTest
        assertEqual "Media das sobras de 2017" 0 (meanRemainderYear t 2017)
    )

testMeanRemainder2018 = TestCase (
    do
        t <-getTransactionsTest
        assertEqual "Media das sobras de 2018" 209.20499999999993 (meanRemainderYear t 2018)
    )

testCashFlow2017Marco = TestCase (
    do
        t <-getTransactionsTest
        assertEqual "Fluxo de caixa de 2017" [] (cashFlow t 2017 2)
    )

testCashFlow2018Marco = TestCase (
    do
        t <-getTransactionsTest
        assertEqual "Fluxo de caixa de 2018" [(1, 44090.67)] (cashFlow t 2018 2)
    )
    
main = do
    runTestTT testTransactionsByYearEmpty
    runTestTT testTransactionsByYearNotEmpty
    runTestTT testTotalIncomes2019Janeiro
    runTestTT testTotalIncomes2017Marco
    runTestTT testTotalIncomes2018Marco
    runTestTT testTotalExpenses2019Janeiro
    runTestTT testTotalExpenses2017Marco
    runTestTT testTotalExpenses2018Marco
    runTestTT testRemainderYearMonth2017Marco
    runTestTT testRemainderYearMonth2018Marco
    runTestTT testBalanceYearMonth2017Marco
    runTestTT testBalanceYearMonth2018Marco
    runTestTT testMaxBalanceYearMonth2017Marco
    runTestTT testMaxBalanceYearMonth2018Marco
    runTestTT testMinBalanceYearMonth2017Marco
    runTestTT testMinBalanceYearMonth2018Marco
    runTestTT testMeanIncomes2017
    runTestTT testMeanIncomes2018
    runTestTT testMeanExpenses2017
    runTestTT testMeanExpenses2018
    runTestTT testMeanRemainder2017
    runTestTT testMeanRemainder2018
    runTestTT testCashFlow2017Marco
    runTestTT testCashFlow2018Marco