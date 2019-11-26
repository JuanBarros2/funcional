(function(e){function t(t){for(var n,o,i=t[0],c=t[1],l=t[2],u=0,f=[];u<i.length;u++)o=i[u],Object.prototype.hasOwnProperty.call(r,o)&&r[o]&&f.push(r[o][0]),r[o]=0;for(n in c)Object.prototype.hasOwnProperty.call(c,n)&&(e[n]=c[n]);d&&d(t);while(f.length)f.shift()();return s.push.apply(s,l||[]),a()}function a(){for(var e,t=0;t<s.length;t++){for(var a=s[t],n=!0,i=1;i<a.length;i++){var c=a[i];0!==r[c]&&(n=!1)}n&&(s.splice(t--,1),e=o(o.s=a[0]))}return e}var n={},r={app:0},s=[];function o(t){if(n[t])return n[t].exports;var a=n[t]={i:t,l:!1,exports:{}};return e[t].call(a.exports,a,a.exports,o),a.l=!0,a.exports}o.m=e,o.c=n,o.d=function(e,t,a){o.o(e,t)||Object.defineProperty(e,t,{enumerable:!0,get:a})},o.r=function(e){"undefined"!==typeof Symbol&&Symbol.toStringTag&&Object.defineProperty(e,Symbol.toStringTag,{value:"Module"}),Object.defineProperty(e,"__esModule",{value:!0})},o.t=function(e,t){if(1&t&&(e=o(e)),8&t)return e;if(4&t&&"object"===typeof e&&e&&e.__esModule)return e;var a=Object.create(null);if(o.r(a),Object.defineProperty(a,"default",{enumerable:!0,value:e}),2&t&&"string"!=typeof e)for(var n in e)o.d(a,n,function(t){return e[t]}.bind(null,n));return a},o.n=function(e){var t=e&&e.__esModule?function(){return e["default"]}:function(){return e};return o.d(t,"a",t),t},o.o=function(e,t){return Object.prototype.hasOwnProperty.call(e,t)},o.p="/";var i=window["webpackJsonp"]=window["webpackJsonp"]||[],c=i.push.bind(i);i.push=t,i=i.slice();for(var l=0;l<i.length;l++)t(i[l]);var d=c;s.push([0,"chunk-vendors"]),a()})({0:function(e,t,a){e.exports=a("56d7")},"034f":function(e,t,a){"use strict";var n=a("85ec"),r=a.n(n);r.a},"56d7":function(e,t,a){"use strict";a.r(t);a("e260"),a("e6cf"),a("cca6"),a("a79d");var n=a("2b0e"),r=function(){var e=this,t=e.$createElement,a=e._self._c||t;return a("b-container",[a("formatted-table",{attrs:{transacoes:e.transacoes}}),a("b-row",[a("h2",[e._v("Filtragens por ano")]),a("b-form-select",{attrs:{options:e.years},model:{value:e.selectedYear,callback:function(t){e.selectedYear=t},expression:"selectedYear"}})],1),a("b-row",[a("b-col",[a("h5",[e._v("Filtrar transações por ano.")]),a("formatted-table",{attrs:{transacoes:e.transacoesValidasFilteredByYear}})],1),a("b-col",[a("h5",[e._v("Calcular a média das receitas em determinado ano")]),e._v(" "+e._s(e.mediaReceitasByYear)+" ")]),a("b-col",[a("h5",[e._v("Calcular a média das sobras em determinado ano")]),e._v(" "+e._s(e.mediaReceitasByYear+e.mediaDespesasByYear)+" ")]),a("b-col",[a("h5",[e._v("Calcular a média das despesas em determinado ano")]),e._v(" "+e._s(e.mediaDespesasByYear)+" ")])],1),a("b-row",[a("h2",[e._v("Filtrar transações por ano e mês.")]),a("b-form-select",{attrs:{options:e.years},model:{value:e.selectedYearAndMonth.year,callback:function(t){e.$set(e.selectedYearAndMonth,"year",t)},expression:"selectedYearAndMonth.year"}}),a("b-form-select",{attrs:{options:e.months},model:{value:e.selectedYearAndMonth.month,callback:function(t){e.$set(e.selectedYearAndMonth,"month",t)},expression:"selectedYearAndMonth.month"}}),a("b-col",[a("h5",[e._v("Filtrar transações por ano e mês.")]),a("formatted-table",{attrs:{transacoes:e.transacoesValidasFilteredByYearAndMonth}})],1),a("b-col",[a("h5",[e._v("Calcular o valor das receitas (créditos) em um determinado mês e ano.")]),e._v(" "+e._s(e.receitasByYearAndMonth)+" ")]),a("b-col",[a("h5",[e._v("Calcular o valor das despesas (débitos) em um determinado mês e ano")]),e._v(" "+e._s(e.despesasByYearAndMonth)+" ")]),a("b-col",[a("h5",[e._v("Calcular a sobra (receitas - despesas) de determinado mês e ano")]),e._v(" "+e._s(e.receitasByYearAndMonth+e.despesasByYearAndMonth)+" ")]),a("b-col",[a("h5",[e._v("Calcular o saldo final em um determinado ano e mês")]),e._v(" "+e._s(e.saldoFinal)+" ")]),a("b-col",[a("h5",[e._v("Calcular o saldo máximo atingido em determinado ano e mês")]),e._v(" "+e._s(e.saldoMax)+" ")]),a("b-col",[a("h5",[e._v("Calcular o saldo mínimo atingido em determinado ano e mês")]),e._v(" "+e._s(e.saldoMin)+" ")]),a("b-col",[a("h5",[e._v("Retornar o fluxo de caixa de determinado mês/ano. O fluxo de caixa nada mais é do que uma lista contendo pares (dia,saldoFinalDoDia).")]),a("formatted-table",{attrs:{transacoes:e.fluxo}})],1)],1)],1)},s=[],o=(a("4de4"),a("d81d"),a("13d5"),a("d3b7"),a("6062"),a("3ca3"),a("ddb0"),a("284c")),i=(a("96cf"),function(){var e=this,t=e.$createElement,a=e._self._c||t;return e.transacoes.length?a("div",{staticClass:"hello"},[a("b-table",{attrs:{striped:"",hover:"",items:e.formattedTransacoes,"per-page":e.pagesCount,"current-page":e.currentPage}}),a("b-pagination",{attrs:{"total-rows":e.formattedTransacoes.length,"per-page":e.pagesCount},model:{value:e.currentPage,callback:function(t){e.currentPage=t},expression:"currentPage"}})],1):e._e()}),c=[],l=(a("a4d3"),a("99af"),a("4160"),a("a9e3"),a("e439"),a("dbb4"),a("b64b"),a("159b"),a("2fa7"));function d(e,t){var a=Object.keys(e);if(Object.getOwnPropertySymbols){var n=Object.getOwnPropertySymbols(e);t&&(n=n.filter((function(t){return Object.getOwnPropertyDescriptor(e,t).enumerable}))),a.push.apply(a,n)}return a}function u(e){for(var t=1;t<arguments.length;t++){var a=null!=arguments[t]?arguments[t]:{};t%2?d(a,!0).forEach((function(t){Object(l["a"])(e,t,a[t])})):Object.getOwnPropertyDescriptors?Object.defineProperties(e,Object.getOwnPropertyDescriptors(a)):d(a).forEach((function(t){Object.defineProperty(e,t,Object.getOwnPropertyDescriptor(a,t))}))}return e}var f={name:"FormattedTable",props:{transacoes:{type:Array,default:function(){return[]}},pagesCount:{type:Number,default:10}},data:function(){return{currentPage:1}},computed:{formattedTransacoes:function(){return this.transacoes.map((function(e){if("data"in e){var t=e.data,a=t.dayOfMonth,n=t.month,r=t.year;return u({},e,{data:"".concat(a,"/").concat(n,"/").concat(r)})}return e}))}}},h=f,p=a("2877"),m=Object(p["a"])(h,i,c,!1,null,"492b8864",null),y=m.exports,b={name:"app",components:{FormattedTable:y},data:function(){return{transacoes:[],selectedYear:0,selectedYearAndMonth:{year:-1,month:-1}}},mounted:function(){var e;return regeneratorRuntime.async((function(t){while(1)switch(t.prev=t.next){case 0:return t.next=2,regeneratorRuntime.awrap(fetch("http://150.165.15.10:8080/todasTransacoes",{method:"POST"}));case 2:return e=t.sent,t.next=5,regeneratorRuntime.awrap(e.json());case 5:this.transacoes=t.sent;case 6:case"end":return t.stop()}}),null,this)},computed:{months:function(){return Object(o["a"])(new Set(this.transacoes.map((function(e){return e.data.month}))))},years:function(){return Object(o["a"])(new Set(this.transacoes.map((function(e){return e.data.year}))))},transacoesValidasFilteredByYear:function(){return this.filterSpecialCases(this.filterTransacoesByYear(this.transacoes,this.selectedYear))},mediaReceitasByYear:function(){return this.calculaSomaTransacoes(this.getReceitasTransacoes(this.transacoesValidasFilteredByYear))/this.getReceitasTransacoes(this.transacoesValidasFilteredByYear).length},mediaDespesasByYear:function(){return this.calculaSomaTransacoes(this.getDespesasTransacoes(this.transacoesValidasFilteredByYear))/this.getDespesasTransacoes(this.transacoesValidasFilteredByYear).length},transacoesFilteredByYearAndMonth:function(){return this.filterTransacoesByYear(this.filterTransacoesByMonth(this.transacoes,this.selectedYearAndMonth.month),this.selectedYearAndMonth.year)},transacoesValidasFilteredByYearAndMonth:function(){return this.filterSpecialCases(this.transacoesFilteredByYearAndMonth)},receitasByYearAndMonth:function(){return this.calculaSomaTransacoes(this.getReceitasTransacoes(this.transacoesValidasFilteredByYearAndMonth))},despesasByYearAndMonth:function(){return this.calculaSomaTransacoes(this.getDespesasTransacoes(this.transacoesValidasFilteredByYearAndMonth))},isYearAndMonthSelected:function(){return this.selectedYearAndMonth.month>=0&&this.selectedYearAndMonth.year>=0},saldoInicial:function(){return this.isYearAndMonthSelected?this.transacoesFilteredByYearAndMonth.filter((function(e){return 1===e.tipos.filter((function(e){return"SALDO_CORRENTE"===e})).length}))[0].valor:0},saldoFinal:function(){return this.saldoInicial+(this.receitasByYearAndMonth+this.despesasByYearAndMonth)},saldoMax:function(){return Math.max.apply(Math,Object(o["a"])(this.transacoesValidasFilteredByYearAndMonth.map((function(e){return e.valor})).map(function(e){return function(t){return e+=t}}(this.saldoInicial))))},saldoMin:function(){return Math.min.apply(Math,Object(o["a"])(this.transacoesValidasFilteredByYearAndMonth.map((function(e){return e.valor})).map(function(e){return function(t){return e+=t}}(this.saldoInicial))))},fluxo:function(){var e=this;return this.dayOfSelectedMonth.map((function(t){return{dia:t,saldo:e.transacoesValidasFilteredByYearAndMonth.filter((function(e){return e.data.dayOfMonth<=t})).reduce((function(e,t){return e+t.valor}),e.saldoInicial)}}))},dayOfSelectedMonth:function(){return Object(o["a"])(new Set(this.transacoesValidasFilteredByYearAndMonth.map((function(e){return e.data.dayOfMonth}))))}},methods:{filterTransacoesByYear:function(e,t){return e.filter((function(e){return e.data.year===t}))},filterTransacoesByMonth:function(e,t){return e.filter((function(e){return e.data.month===t}))},filterSpecialCases:function(e){return e.filter((function(e){return 0===e.tipos.filter((function(e){return"APLICACAO"===e||"SALDO_CORRENTE"===e||"VALOR_APLICACAO"===e})).length}))},calculaSomaTransacoes:function(e){return e.map((function(e){return e.valor})).reduce((function(e,t){return e+t}),0)},getReceitasTransacoes:function(e){return e.filter((function(e){return e.valor>=0}))},getDespesasTransacoes:function(e){return e.filter((function(e){return e.valor<0}))}}},v=b,Y=(a("034f"),Object(p["a"])(v,r,s,!1,null,null,null)),g=Y.exports,M=a("5f5b");a("f9e3"),a("2dd8");n["default"].use(M["a"]),n["default"].config.productionTip=!1,new n["default"]({render:function(e){return e(g)}}).$mount("#app")},"85ec":function(e,t,a){}});
//# sourceMappingURL=app.72b31e8b.js.map