<template>
  <div class="hello" v-if="transacoes.length">
    <b-table striped hover :items="formattedTransacoes" :per-page="5" :current-page="currentPage"></b-table>
    <b-pagination v-model="currentPage" :total-rows="formattedTransacoes.length" :per-page="5"></b-pagination>
  </div>
</template>

<script>
export default {
  name: "FormattedTable",
  props: {
    transacoes: {
      type: Array,
      default() {
        return []
      }
    }
  },
  data() {
    return {
      currentPage: 1
    };
  },
  computed: {
    formattedTransacoes() {
      return this.transacoes.map(transacao => {
        const {
          dayOfMonth,
          month,
          year
        } = transacao.data;
        return {
          ...transacao,
          data: `${dayOfMonth}/${month}/${year}`,
        };
      });
    }
  }
};
</script>

<style scoped>
</style>
