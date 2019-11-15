<template>
  <div class="hello">
    <b-table striped hover :items="formattedTransacoes" :per-page="5" :current-page="currentPage"></b-table>
    <b-pagination v-model="currentPage" :total-rows="formattedTransacoes.length" :per-page="5"></b-pagination>
  </div>
</template>

<script>
export default {
  name: "FormattedTable",
  props: {
    transacoes: Array
  },
  data() {
    return {
      currentPage: 1
    };
  },
  computed: {
    formattedTransacoes() {
      return this.transacoes.map(transacao => {
        const { dayOfMonth, month, year, hourOfDay, minute, second } = transacao.data;
        return {
        ...transacao, data: `${dayOfMonth}/${month}/${year} - ${hourOfDay}:${minute}:${second}`,
        tipos: transacao.tipos.join(' - ')
      }});
    }
  }
};
</script>

<style scoped>
</style>
