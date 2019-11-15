<template>
  <div>
    <b-form-select v-model="selectedYear" :options="years"></b-form-select>
  </div>
</template>

<script>
export default {
  name: "SelectorTime",
  props: {
    years: Array,
    months: Array
  }
};
</script>

<style lang="scss" scoped>
</style>