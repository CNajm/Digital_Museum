<template>
	<v-card>
		<v-img
			:src="src"
			class="white--text art"
			gradient="to bottom, rgba(0,0,0,.1), rgba(0,0,0,.5)"
			height="400"
			lazy-src="https://picsum.photos/10/6"
		>
			<template v-slot:placeholder>
				<v-row
					class="fill-height ma-0"
					align="center"
					justify="center"
				>
					<v-progress-circular
						indeterminate
						color="grey lighten-5"
					></v-progress-circular>
				</v-row>
			</template>
		</v-img>

		<v-card-actions>
			<v-card-title>{{ title }}</v-card-title>
			<v-spacer></v-spacer>

			<v-btn icon :to="id">
				<v-icon>mdi-arrow-right</v-icon>
			</v-btn>
		</v-card-actions>
	</v-card>
</template>

<script>
export default {
	name: 'Art',
	props: {
		title: String,
		src: String,
		aid: Number
	},
	data () {
		return {
			id: `/art?id=${this.aid}`
		}
	},
}
</script>
