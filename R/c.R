dados <- read_csv("./convertcsv.csv")

mes <- 1
ano <- 2019

filteredTransactions <- dados %>%
  filter(`data/year` == ano) %>% 
  filter(!(`tipos/0` %in% c("APLICACAO", "SALDO_CORRENTE", "VALOR_APLICACAO")))%>% 
  filter(!(`tipos/1` %in% c("APLICACAO", "SALDO_CORRENTE", "VALOR_APLICACAO")))

receitas <- filteredTransactions %>% 
  filter(valor >= 0)
summary(receitas$valor)

despesas <- filteredTransactions %>% 
  filter(valor < 0)
summary(despesas$valor)

receitasEmFevereiro <- receitas %>% 
  filter(`data/month` == mes)
sum(receitasEmFevereiro$valor)

despesasEmFevereiro <- despesas %>% 
  filter(`data/month` == mes)
sum(despesasEmFevereiro$valor)

sobra <- sum(receitasEmFevereiro$valor)[1] + sum(despesasEmFevereiro$valor)[1]

inicialSaldoMes<- dados %>% 
  filter(`data/year` == ano) %>% 
  filter(`data/month` == mes) %>% 
  filter(`tipos/0` == "SALDO_CORRENTE" | `tipos/1` == "SALDO_CORRENTE")
inicialSaldoMes <- inicialSaldoMes$valor

saldoFinal <- inicialSaldoMes + sobra

transacoes <- filteredTransactions %>% 
  filter(`data/month` == 1) %>% 
  mutate(saldoMovimentacao = inicialSaldoMes + cumsum(valor))
min <- min(transacoes$saldoMovimentacao)
max <- max(transacoes$saldoMovimentacao)

fluxo <- transacoes %>% 
  group_by(`data/dayOfMonth`) %>% 
  summarise(sum = sum(valor))
