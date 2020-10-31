<template>
  <div>
    <img alt="Vue logo" src="../assets/logo.png">
    <HelloWorld msg="NOPERS NOT FOUND"/>
  </div>
</template>

<script>
import HelloWorld from '../components/HelloWorld.vue'

export default {
  name: 'NotFound',
  components: {
    HelloWorld
  }
}
</script>

<style>
div {
  font-family: Avenir, Helvetica, Arial, sans-serif;
  -webkit-font-smoothing: antialiased;
  -moz-osx-font-smoothing: grayscale;
  text-align: center;
  color: #2c3e50;
  margin-top: 60px;
}
</style>
