<template>
  <b-container>
    <b-row>
      <formatted-table :transacoes="transacoes" />
    </b-row>
    <b-row>
      <h2>Filtragens por ano</h2>
      <b-form-select v-model="selectedYear" :options="years"></b-form-select>
      <b-col>
        <h5>Filtrar transações por ano.</h5>
        <formatted-table :transacoes="transacoesValidasFilteredByYear" />
      </b-col>
      <b-col>
        <h5>Calcular a média das receitas em determinado ano</h5>
        {{ receitasByYear }}
      </b-col>
      <b-col>
        <h5>Calcular a média das sobras em determinado ano</h5>
        {{ receitasByYear + despesasByYear }}
      </b-col>
      <b-col>
        <h5>Calcular a média das despesas em determinado ano</h5>
        {{ despesasByYear }}
      </b-col>
    </b-row>

    <b-row>
      <h2>Filtrar transações por ano e mês.</h2>
      <b-form-select v-model="selectedYearAndMonth.year" :options="years"></b-form-select>
      <b-form-select v-model="selectedYearAndMonth.month" :options="months"></b-form-select>
      <b-col>
        <h5>Calcular o valor das receitas (créditos) em um determinado mês e ano.</h5>
        {{ despesasByYearAndMonth}}
      </b-col>
      <b-col>
        <h5>Calcular o valor das despesas (débitos) em um determinado mês e ano</h5>
        {{ receitasByYearAndMonth }}
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
    receitasByYear() {
      return this.calculaDespesas(this.transacoesValidasFilteredByYear);
    },
    despesasByYear() {
      return this.calculaDespesas(this.transacoesValidasFilteredByYear);
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
      return this.calculaReceitas(this.transacoesValidasFilteredByYearAndMonth);
    },
    despesasByYearAndMonth() {
      return this.calculaDespesas(this.transacoesValidasFilteredByYearAndMonth);
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
        this.saldoInicial -
        (this.receitasByYearAndMonth + this.despesasByYearAndMonth)
      );
    },
    saldoMax() {
      return this.transacoesValidasFilteredByYearAndMonth
        .map(transacao => transacao.valor)
        .reduce(
          (max, atual) => (max + atual > max ? max + atual : max),
          this.saldoInicial
        );
    },
    saldoMin() {
      return this.transacoesValidasFilteredByYearAndMonth
        .map(transacao => transacao.valor)
        .reduce(
          (min, atual) => (min + atual < min ? min + atual : min),
          this.saldoInicial
        );
    },
    fluxo() {
      return Object.entries(
        this.groupBy(
          this.transacoesValidasFilteredByYearAndMonth.map(d => ({
            ...d,
            dia: d.data.dayOfMonth
          })),
          "dia"
        )
      ).map(entry => ({
        data: entry[1][0].data,
        valor: entry[1].map(e => e.valor).reduce((sum, atual) => sum + atual, 0)
      }));
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
    groupBy(items, key) {
      return items.reduce(
        (result, item) => ({
          ...result,
          [item[key]]: [...(result[item[key]] || []), item]
        }),
        {}
      );
    },
    calculaReceitas(transacoes) {
      const valores = transacoes.filter(x => x.valor >= 0).map(x => x.valor);
      let result = 0;
      if (valores.length)
        // REDUCE não pode ser usado com Array vazio
        result = valores.reduce((a, b) => a + b) / this.transacoes.length;
      return result;
    },
    calculaDespesas(transacoes) {
      const valores = transacoes.filter(x => x.valor < 0).map(x => x.valor);
      let result = 0;
      if (valores.length)
        // REDUCE não pode ser usado com Array vazio
        result = valores.reduce((a, b) => a + b) / transacoes.length;
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
