<template>
  <v-app id="app">
    <!-- <div id="nav"> -->
    <v-tabs
    v-model="tabs"
      centered
      color="grey darken-1"
    >
      <v-tab
      v-for="route in routes" 
      :key="route.name"
      :to=route.path
      >
        {{route.name}}
      </v-tab>
    </v-tabs>
    <v-main>
      <v-container>
        <router-view/>
      </v-container>
    </v-main>
  </v-app>
</template>

<style lang="scss">
#app {
  font-family: Avenir, Helvetica, Arial, sans-serif;
  -webkit-font-smoothing: antialiased;
  -moz-osx-font-smoothing: grayscale;
  text-align: center;
  color: #2c3e50;
}

#nav {
  padding: 30px;

  a {
    font-weight: bold;
    color: #2c3e50;

    &.router-link-exact-active {
      color: #42b983;
    }
  }
}
</style>

<script>
  import routes from './router/routes.js'
  export default {
    props: {},
    components: {},
    data () {
      return {
        tabs: null,
        routes: routes.filter(r => {return r.name}) // only link to routes with a name (excludes 404 catch-all route)        
      }
    },
    created () {
      this.$vuetify.theme.dark = true
    },
    mounted () {
      console.log(routes)
    }
  }
</script>
