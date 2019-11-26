<template>
  <div class="hello" v-if="transacoes.length">
    <b-table striped hover :items="formattedTransacoes" :per-page="pagesCount" :current-page="currentPage"></b-table>
    <b-pagination v-model="currentPage" :total-rows="formattedTransacoes.length" :per-page="pagesCount"></b-pagination>
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
    },
    pagesCount: {
      type: Number,
      default: 10
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
