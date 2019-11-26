<template>
  <b-container>
    <formatted-table :transacoes="transacoes" />

    <b-row>
      <h2>Filtragens por ano</h2>
      <b-form-select v-model="selectedYear" :options="years"></b-form-select>
    </b-row>
    <b-row>
      <b-col>
        <h5>Filtrar transações por ano.</h5>
        <formatted-table :transacoes="transacoesValidasFilteredByYear" />
      </b-col>
      <b-col>
        <h5>Calcular a média das receitas em determinado ano</h5>
        {{ mediaReceitasByYear }}
      </b-col>
      <b-col>
        <h5>Calcular a média das sobras em determinado ano</h5>
        {{ mediaReceitasByYear + mediaDespesasByYear }}
      </b-col>
      <b-col>
        <h5>Calcular a média das despesas em determinado ano</h5>
        {{ mediaDespesasByYear }}
      </b-col>
    </b-row>

    <b-row>
      <h2>Filtrar transações por ano e mês.</h2>
      <b-form-select v-model="selectedYearAndMonth.year" :options="years"></b-form-select>
      <b-form-select v-model="selectedYearAndMonth.month" :options="months"></b-form-select>
      <b-col>
        <h5>Filtrar transações por ano e mês.</h5>
        <formatted-table :transacoes="transacoesValidasFilteredByYearAndMonth" />
      </b-col>
      <b-col>
        <h5>Calcular o valor das receitas (créditos) em um determinado mês e ano.</h5>
        {{ receitasByYearAndMonth }}
      </b-col>
      <b-col>
        <h5>Calcular o valor das despesas (débitos) em um determinado mês e ano</h5>
        {{ despesasByYearAndMonth }}
      </b-col>
      <b-col>
        <h5>Calcular a sobra (receitas - despesas) de determinado mês e ano</h5>
        {{ receitasByYearAndMonth + despesasByYearAndMonth }}
      </b-col>
      <b-col>
        <h5>Calcular o saldo final em um determinado ano e mês</h5>
        {{ saldoFinal }}
      </b-col>
      <b-col>
        <h5>Calcular o saldo máximo atingido em determinado ano e mês</h5>
        {{ saldoMax }}
      </b-col>
      <b-col>
        <h5>Calcular o saldo mínimo atingido em determinado ano e mês</h5>
        {{ saldoMin }}
      </b-col>
      <b-col>
        <h5>Retornar o fluxo de caixa de determinado mês/ano. O fluxo de caixa nada mais é do que uma lista contendo pares (dia,saldoFinalDoDia).</h5>
        <formatted-table :transacoes="fluxo" />
      </b-col>
    </b-row>
  </b-container>
</template>

<script>
import FormattedTable from "@/components/FormattedTable";
export default {
  name: "app",
  components: {
    FormattedTable
  },
  data() {
    return {
      transacoes: [],
      selectedYear: 0,
      selectedYearAndMonth: {
        year: -1,
        month: -1
      }
    };
  },
  async mounted() {
    const response = await fetch("http://150.165.15.10:8080/todasTransacoes", {
      method: "POST"
    });
    this.transacoes = await response.json();
  },
  computed: {
    months() {
      return [
        ...new Set(this.transacoes.map(transacao => transacao.data.month))
      ];
    },
    years() {
      return [
        ...new Set(this.transacoes.map(transacao => transacao.data.year))
      ];
    },
    transacoesValidasFilteredByYear() {
      return this.filterSpecialCases(
        this.filterTransacoesByYear(this.transacoes, this.selectedYear)
      );
    },
    mediaReceitasByYear() {
      return (
        this.calculaSomaTransacoes(
          this.getReceitasTransacoes(this.transacoesValidasFilteredByYear)
        ) /
        this.getReceitasTransacoes(this.transacoesValidasFilteredByYear).length
      );
    },
    mediaDespesasByYear() {
      return (
        this.calculaSomaTransacoes(
          this.getDespesasTransacoes(this.transacoesValidasFilteredByYear)
        ) /
        this.getDespesasTransacoes(this.transacoesValidasFilteredByYear).length
      );
    },
    transacoesFilteredByYearAndMonth() {
      return this.filterTransacoesByYear(
        this.filterTransacoesByMonth(
          this.transacoes,
          this.selectedYearAndMonth.month
        ),
        this.selectedYearAndMonth.year
      );
    },
    transacoesValidasFilteredByYearAndMonth() {
      return this.filterSpecialCases(this.transacoesFilteredByYearAndMonth);
    },
    receitasByYearAndMonth() {
      return this.calculaSomaTransacoes(
        this.getReceitasTransacoes(this.transacoesValidasFilteredByYearAndMonth)
      );
    },
    despesasByYearAndMonth() {
      return this.calculaSomaTransacoes(
        this.getDespesasTransacoes(this.transacoesValidasFilteredByYearAndMonth)
      );
    },
    isYearAndMonthSelected() {
      return (
        this.selectedYearAndMonth.month >= 0 &&
        this.selectedYearAndMonth.year >= 0
      );
    },
    saldoInicial() {
      return this.isYearAndMonthSelected
        ? this.transacoesFilteredByYearAndMonth.filter(
            transacao =>
              transacao.tipos.filter(tipo => tipo === "SALDO_CORRENTE")
                .length === 1
          )[0].valor
        : 0;
    },
    saldoFinal() {
      return (
        this.saldoInicial +
        (this.receitasByYearAndMonth + this.despesasByYearAndMonth)
      );
    },
    saldoMax() {
      return Math.max(
        ...this.transacoesValidasFilteredByYearAndMonth
          .map(transacao => transacao.valor)
          .map((sum => value => (sum += value))(this.saldoInicial))
      );
    },
    saldoMin() {
      return Math.min(
        ...this.transacoesValidasFilteredByYearAndMonth
          .map(transacao => transacao.valor)
          .map((sum => value => (sum += value))(this.saldoInicial))
      );
    },
    fluxo() {
      return this.dayOfSelectedMonth.map(dia => ({
        dia,
        saldo: this.transacoesValidasFilteredByYearAndMonth
          .filter(transacao => transacao.data.dayOfMonth <= dia)
          .reduce(
            (total, transacao) => total + transacao.valor,
            this.saldoInicial
          )
      }));
    },
    dayOfSelectedMonth() {
      return [
        ...new Set(
          this.transacoesValidasFilteredByYearAndMonth.map(
            transacao => transacao.data.dayOfMonth
          )
        )
      ];
    }
  },
  methods: {
    filterTransacoesByYear(transacoes, year) {
      return transacoes.filter(transacao => transacao.data.year === year);
    },
    filterTransacoesByMonth(transacoes, month) {
      return transacoes.filter(transacao => transacao.data.month === month);
    },
    filterSpecialCases(transacoes) {
      return transacoes.filter(
        transacao =>
          transacao.tipos.filter(
            tipo =>
              tipo === "APLICACAO" ||
              tipo === "SALDO_CORRENTE" ||
              tipo === "VALOR_APLICACAO"
          ).length === 0
      );
    },
    calculaSomaTransacoes(transacoes) {
      return transacoes.map(x => x.valor).reduce((a, b) => a + b, 0);
    },
    getReceitasTransacoes(transacoes) {
      return transacoes.filter(x => x.valor >= 0);
    },
    getDespesasTransacoes(transacoes) {
      return transacoes.filter(x => x.valor < 0);
    }
  }
};
</script>

<style>
#app {
  font-family: "Avenir", Helvetica, Arial, sans-serif;
  -webkit-font-smoothing: antialiased;
  -moz-osx-font-smoothing: grayscale;
  text-align: center;
  color: #2c3e50;
  margin-top: 60px;
}
</style>
