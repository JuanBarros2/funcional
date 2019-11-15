<template>
  <b-container>
    <b-row>
      <formatted-table :transacoes="transacoes" />
    </b-row>
    <b-row>
      <h2>Filtragens por ano</h2>
      <b-form-select v-model="selectedYear" :options="years"></b-form-select>
      <b-col>
        <h3>Filtrar transações por ano.</h3>
        <formatted-table :transacoes="transacoesFilteredByYear" />
      </b-col>
      <b-col>
        <h3>Calcular a média das receitas em determinado ano</h3>
        {{ receitasByYear }}
      </b-col>
      <b-col>
        <h3>Calcular a média das sobras em determinado ano</h3>
        {{ receitasByYear + despesasByYear }}
      </b-col>
      <b-col>
        <h3>Calcular a média das despesas em determinado ano</h3>
        {{ despesasByYear }}
      </b-col>
    </b-row>

    <b-row>
      <h2>Filtrar transações por ano e mês.</h2>

      <h3>Calcular o valor das receitas (créditos) em um determinado mês e ano.</h3>
      <h3>Calcular o valor das despesas (débitos) em um determinado mês e ano</h3>
      <h3>Calcular a sobra (receitas - despesas) de determinado mês e ano</h3>
      <h3>Calcular o saldo final em um determinado ano e mês</h3>
      <h3>Calcular o saldo máximo atingido em determinado ano e mês</h3>
      <h3>Calcular o saldo mínimo atingido em determinado ano e mês</h3>
    </b-row>
    <h3>Retornar o fluxo de caixa de determinado mês/ano. O fluxo de caixa nada mais é do que uma lista contendo pares (dia,saldoFinalDoDia).</h3>
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
      selectedYear: 0
    };
  },
  async mounted() {
    const response = await fetch("http://150.165.15.10:8080/todasTransacoes", {
      method: "POST"
    });
    this.transacoes = await response.json();
  },
  computed: {
    month() {
      return [
        ...new Set(this.transacoes.map(transacao => transacao.data.month))
      ];
    },
    years() {
      return [
        ...new Set(this.transacoes.map(transacao => transacao.data.year))
      ];
    },
    transacoesFilteredByYear() {
      return this.transacoes.filter(
        transacao => transacao.data.year === this.selectedYear
      );
    },
    filterSpecialCasesByYear() {
      return this.transacoesFilteredByYear.filter(
        transacao =>
          transacao.tipos.filter(
            tipo =>
              tipo === "APLICACAO" ||
              tipo === "SALDO_CORRENTE" ||
              tipo === "VALOR_APLICACAO"
          ).length === 0
      );
    },
    receitasByYear() {
      const valores = this.filterSpecialCasesByYear
        .filter(x => x.valor >= 0)
        .map(x => x.valor);
      let result = 0;
      if (valores.length)
        result =
          valores.reduce((a, b) => a + b) /
          this.filterSpecialCasesByYear.length;
      return result;
    },
    despesasByYear() {
      const valores = this.filterSpecialCasesByYear
        .filter(x => x.valor < 0)
        .map(x => x.valor);
      let result = 0;
      if (valores.length)
        result =
          valores.reduce((a, b) => a + b) /
          this.filterSpecialCasesByYear.length;
      return result;
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
