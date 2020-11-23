<template>
	<v-card>
		<v-img
			:src="src"
			class="white--text align-end"
			gradient="to bottom, rgba(0,0,0,.1), rgba(0,0,0,.5)"
			height="400px"
		>
		</v-img>

		<v-card-actions>
			<v-card-title>{{ title }}</v-card-title>
			<!-- <br />{{ theme }} -->
			<v-spacer></v-spacer>

			<v-btn icon :to="id">
				<v-icon>mdi-arrow-right</v-icon>
			</v-btn>
		</v-card-actions>
	</v-card>
</template>

<script>
export default {
	name: 'Room',
	components: {},
	props: {
		title: String,
		src: String,
		theme: String,
		rid: Number
	},
	data () {
		return {
			id: `/room?id=${this.rid}&title=${this.title}`
		}
	},
	mounted() {
		
	},
	methods: {
		a () {

		},
	}
}
</script>

<style scoped>
.text {
	color: #FFFFFF;
}
</style>
