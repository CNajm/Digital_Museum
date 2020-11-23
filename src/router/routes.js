import HomeView from '../views/Home.vue'
import NotFoundView from '../views/404.vue'
// import FlightsView from '../views/Flights.vue'
import InfoView from '../views/About.vue'
import RoomView from '../views/Room.vue'
import ArtView from '../views/Art.vue'
export default [
  {
    name: 'Home',
    path: '/',
    component: HomeView
  },
  {
    name: 'Info',
    path: '/about',
    component: InfoView
  },
  { 
    path: '/room',
    component: RoomView,
    props: true
  },
  { 
    path: '/art',
    component: ArtView,
    props: true
  },
  // {
  //   name: 'Flights',
  //   path: '/flights',
  //   component: FlightsView,
  //   meta: {
  //     title: 'Flights',
  //     requiresAuth: true,
  //   }
  // },
  {
    path: '*',
    component: NotFoundView
  }
]
