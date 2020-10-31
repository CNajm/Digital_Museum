<template>
  <div class="home">
	<img alt="Vue logo" src="../assets/logo.png">
	<h1 v-if="routeID">{{ routeID }}</h1>
	<HelloWorld msg="Welcome to Your Vue.js App"/>
  </div>
</template>

<script>
// @ is an alias to /src
import HelloWorld from '@/components/HelloWorld.vue'

export default {
  name: 'Home',
  components: {
	HelloWorld
  },
  data () {
	return {
		routeID: this.$route.params.id != ":id" ? this.$route.params.id : false
	}
  }
}
</script>
