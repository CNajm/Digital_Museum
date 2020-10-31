import Vue from 'vue'
import App from './App.vue'
import vuetify from './plugins/vuetify';
import 'roboto-fontface/css/roboto/roboto-fontface.css'
import '@mdi/font/css/materialdesignicons.css'
import router from './router'

// Vue.config.productionTip = false
Vue.config.performance = true

new Vue({
  vuetify,
  router,
  render: h => h(App),
}).$mount('#app')

// const NotFound = { template: '<p>Page not found</p>' }
// const Home = { template: '<p>home page</p>' }
// const About = { template: '<p>about page</p>' }

// const routes = {
//   '/': App,
//   '/wire': wire
// }

// new Vue({
//   el: '#app',

//   data: {
//     currentRoute: window.location.pathname
//   },

//   computed: {
//     ViewComponent () {
//       return routes[this.currentRoute] || NotFound
//     }
//   },

//   vuetify,
//   router,
//   render (h) { return h(this.ViewComponent) }
// })