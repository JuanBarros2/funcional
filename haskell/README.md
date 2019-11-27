É necessária a instalação do module _aeson_ para o parser do JSON, que pode ser feita rodando os seguintes comandos:

```
cabal update
cabal install aeson
```

Para executar o projeto, utiliza-se o comando abaixo na raiz do projeto:

```
ghci main.hs
```

Além disso, foram feitos testes para as funções implementadas utilizando o module _HUnit_, para instalá-lo é necessário rodar o comando:

```
cabal install HUnit
```

Lista de Consultas/funções/operações implementadas:

* [x] Filtrar transações por ano.
* [x] Filtrar transações por ano e mês.
* [x] Calcular o valor das receitas (créditos) em um determinado mês e ano.
* [x] Calcular o valor das despesas (débitos) em um determinado mês e ano.
* [x] Calcular a sobra (receitas - despesas) de determinado mês e ano
* [x] Calcular o saldo final em um determinado ano e mês
* [x] Calcular o saldo máximo atingido em determinado ano e mês
* [x] Calcular o saldo mínimo atingido em determinado ano e mês
* [x] Calcular a média das receitas em determinado ano
* [x] Calcular a média das despesas em determinado ano
* [x] Calcular a média das sobras em determinado ano
* [x] Retornar o fluxo de caixa de determinado mês/ano. O fluxo de caixa nada mais é do que uma lista contendo pares (dia,saldoFinalDoDia). 