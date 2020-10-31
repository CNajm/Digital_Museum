import Home from '../views/Home.vue'
export default [
  {
    name: 'Home',
    path: '/',
    component: Home
  },
  {
    name: 'About',
    path: '/about',
    // route level code-splitting
    // this generates a separate chunk (about.[hash].js) for this route
    // which is lazy-loaded when the route is visited.
    component: () => import(/* webpackChunkName: "about" */ '../views/About.vue')
  },
  { name: 'Home23',
    path: '/YAP',
    component: () => import(/* webpackChunkName: "about" */ '../views/About.vue')
  },
  {
    name: 'Art',
    path: '/Art/:id',
    component: Home
  }
]