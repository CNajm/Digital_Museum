<template>
	<div class="home">
		<img alt="logo" src="../assets/dlogo.png">
		<h1 class="white--text">{{ title }}</h1>
		
		<v-container fluid>
			<v-row justify="center">
				<v-col
					v-for="card in arts"
					:key="card.title"
					:cols="card.flex"
				>
					<Art :aid="card.aid" :title="card.title" :src="card.src"></Art>
				</v-col>
			</v-row>
		</v-container>

	</div>
</template>

<script>
const querystring = require('querystring');
const fetch = require('node-fetch');
import Art from '@/components/ArtCard.vue'

export default {
	name: 'RoomView',
	components: {
		Art
	},
	data () {
		return {
			roomID: this.$route.query.id ? this.$route.query.id : false,
			title: this.$route.query.title ? this.$route.query.title : false,
			arts: [],
		}
	},
	mounted () {
		console.log('PARAMS',this.$route.query); 
		if (this.roomID)
			this.loadRoomContent(this.roomID)
	},
	methods: {
		async loadRoomContent(rid) {
			const query = querystring.stringify({rid: rid})
			let res = await fetch(`http://localhost:8000/GetRoomContents?${query}`)
			let art = await res.json()
			for (const i of art) {
				console.log('art', i);
				await this.arts.push({title: i.name, src: i.url, aid: i.AID, flex: 3})
			}
			console.log('ALL', this.arts);
		}
		// TODO render the art cards from the json
	}
}
</script>
