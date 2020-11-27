import HomeView from '../views/Home.vue'
import NotFoundView from '../views/404.vue'
import InfoView from '../views/About.vue'
import RoomView from '../views/Room.vue'
import ArtView from '../views/Art.vue'
import GalleryView from '../views/Gallery.vue'
import CreatorsView from '../views/Creators.vue'
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
  { 
    name: 'Gallery',
    path: '/gallery',
    component: GalleryView,
  },
  { 
    name: 'Creators',
    path: '/creators',
    component: CreatorsView,
  },
  {
    path: '*',
    component: NotFoundView
  }
]
