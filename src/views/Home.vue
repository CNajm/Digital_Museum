<template>
	<div class="home">
	<img alt="Vue logo" src="../assets/dlogo.png">
	<h1 v-if="routeID">{{ routeID }}</h1>
	<h1 class="">Featured Rooms</h1>

	<v-container fluid>
		<v-row>
			<v-col
				v-for="card in cards"
				:key="card.title"
				:cols="card.flex"
			>
				<Room :rid="card.rid" :title="card.title" :theme="card.theme" :src="card.src"></Room>
			</v-col>
		</v-row>
	</v-container>
	</div>
</template>

<script>
const querystring = require('querystring');
import Room from '@/components/RoomCard.vue'

export default {
	name: 'Home',
	components: {
		Room
	},
	data () {
		return {
			cards: []
		}
	},
	mounted () {
		this.loadRoomPreviews()
	},
	methods: {
		async loadRoomPreviews() {
			let res = await fetch(`http://localhost:8000/GetAllRooms`)
			let rooms = await res.json()
			for (const item of rooms) {
				let query = querystring.stringify({rid: item.RID})
				let res = await fetch(`http://localhost:8000/GetRoomPreview?${query}`)
				let preview = await res.json()
				await this.cards.push({title: preview.name, theme: preview.theme, src: preview.url, rid: preview.RID, flex: 4})
			}
			console.log('cards', this.cards)
		}
	}
}
</script>

<style scoped>
.text {
	color: #FFFFFF;
}
</style>
