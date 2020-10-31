<template>
  <div id="app">
    <div id="nav">
      <router-link v-for="route in routes" :key="route.name" :to=route.path>{{route.name}} </router-link>
    </div>
    <router-view/>
  </div>
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
        drawer: null,
        routes: routes
      //     { icon: 'mdi-card-account-details-star', text: 'Profile', route: '/profile'},
      //     { icon: 'mdi-cog', text: 'Settings', route: ''}, // TODO: settings
      //     { icon: 'mdi-emoticon-poop', text: 'Shit', route: '/shit'},
      //     { icon: 'mdi-folder-music', text: 'SFX', route: '/sfx'},
      //     { icon: 'mdi-cog', text: 'Auth', route: '/auth'},
        
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

<!-- 
<template>
  <v-app>
    <v-navigation-drawer
      app
      v-model="drawer"
      clipped

      src="@/assets/nav-drawer-992-4000x2660.jpg" 
    >
    <div id="nav">
      <router-link to="/">Home</router-link> |
      <router-link to="/about">About</router-link>
    </div>
      <v-list>
        <v-list-item v-for="link in links" :key="link.text" router :to="link.route">
          <v-list-item-action>
            <v-icon>{{ link.icon }}</v-icon>
          </v-list-item-action>
          <v-list-item-content>
            <v-list-item-title>{{ link.text }}</v-list-item-title>
          </v-list-item-content>
        </v-list-item>
      </v-list>

    </v-navigation-drawer>

    <v-app-bar
      app
      clipped-left
    >
      <v-app-bar-nav-icon @click.stop="drawer = !drawer">
        <v-icon>mdi-emoticon-poop</v-icon>
      </v-app-bar-nav-icon>
      <v-toolbar-title>I Need to Name This</v-toolbar-title>
    </v-app-bar>

    <v-content>
      <v-alert 
      dismissible
      text
      dense
      type='success'>eat my ass
      </v-alert>


    <router-view></router-view>
    </v-content>

    <v-bottom-navigation
      app
      clipped
      dark
      shift
      grow
      color="red darken-1"
    >
      <v-btn router to='/profile'>
        <span>Profile</span>
        <v-icon>mdi-card-account-details-star</v-icon>
      </v-btn>

      <v-btn router to='/'>
        <span>Home</span>
        <v-icon>mdi-home</v-icon>
      </v-btn>

      <v-btn router to='/sfx'>
        <span>SFX</span>
        <v-icon>mdi-folder-music</v-icon>
      </v-btn> 
    </v-bottom-navigation>
  </v-app>
</template>

<script>

  export default {
    props: {
      source: String,
    },
    components: {
      
    },

    data () {
      return {
        drawer: null,
        links: [
          { icon: 'mdi-home', text: 'Home', route: '/'},
          { icon: 'mdi-card-account-details-star', text: 'Profile', route: '/profile'},
          { icon: 'mdi-cog', text: 'Settings', route: ''}, // TODO: settings
          { icon: 'mdi-emoticon-poop', text: 'Shit', route: '/shit'},
          { icon: 'mdi-folder-music', text: 'SFX', route: '/sfx'},
          { icon: 'mdi-cog', text: 'Auth', route: '/auth'},
        ]
      }
    },

    created () {
      this.$vuetify.theme.dark = true
    },
  }
</script>
 -->