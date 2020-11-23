<template>
	<div>
		<img alt="logo" src="../assets/dlogo.png">

		<v-container class="">
			<v-row align="center">
				<v-col cols="6">
					<v-card>
						<v-img
							contain
							lazy-src="https://picsum.photos/10/6"
							
							max-height="800"
							class="art"
							:src="details.url"
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
					</v-card>
				</v-col>

				<v-col cols="6">
					<v-row>
						<v-col cols="6" class="pt-0">
							<v-card class="pb-2" outlined>
								<v-list-item three-line>
									<v-list-item-content>
										<div class="overline mb-4 pb-0 text-left">
											Art Info
										</div>
										<v-list-item-title class="headline mb-6 text-left">{{ details.name }}</v-list-item-title>

										<v-timeline
											align-top
											dense
											class="timelineEntry"
										>
											<v-timeline-item
												color="green"
												small
											>
												<div>
													<div class="pb-1">
														<strong>Created</strong>
													</div>
													<div>{{ details.creation_date }}</div>
												</div>
											</v-timeline-item>

											<v-timeline-item
												color="cyan"
												small
											>
												<div>
													<div class="pb-1">
														<strong>Time Period</strong>
													</div>
													<div>{{ details.time_period }}</div>
												</div>
											</v-timeline-item>

											<v-timeline-item
												v-for="(value, key) in artType"
												:key="value.key"
												color="blue"
												small
											>
												<div>
													<div class="pb-1">
														<strong>{{ key }}</strong>
													</div>
													<div>{{ value }}</div>
												</div>
											</v-timeline-item>
										</v-timeline>
									</v-list-item-content>
								</v-list-item>
							</v-card>
						</v-col>

						<v-col cols="6" class="pt-0">
							<v-card class="pb-2" outlined>
								<v-list-item three-line>
									<v-list-item-content>
										<div class="overline mb-4 pb-0 text-left">
											Artist Info
										</div>
										<v-list-item-title class="headline mb-6 text-left">{{ details.creator_name }}</v-list-item-title>

										<v-timeline
											align-top
											dense
											class="timelineEntry"
										>
											<v-timeline-item
												color="green"
												small
											>
												<div>
													<div class="pb-1">
														<strong>Born</strong>
													</div>
													<div>{{ details.born }}</div>
												</div>
											</v-timeline-item>

											<div v-if="details.died">
												<v-timeline-item 
												v-for="i in nodeCount-2"
												:key="i"
												hide-dot 
												class="spacer"
												>
													<div>
														<div class="pb-1"><strong>_</strong></div>
														<div>_</div>
													</div>
												</v-timeline-item>

												<v-timeline-item
													color="green"
													small
												>
													<div>
														<div class="pb-1">
															<strong>Died</strong>
														</div>
														<div>{{ details.died }}</div>
													</div>
												</v-timeline-item>
											</div>
										</v-timeline>
									</v-list-item-content>
								</v-list-item>
							</v-card>
						</v-col>
					</v-row>
					<v-col cols="12" class="px-0">
						<v-card class="pb-2" outlined>
							<v-list-item>
								<v-list-item-content>
									<div class="overline mb-4 px-4 text-left">
										Description
									</div>
									<v-card-text class="body-1 text-left" v-html="details.description"></v-card-text>
								</v-list-item-content>
							</v-list-item>
						</v-card>
					</v-col>
				</v-col>

			</v-row>
		</v-container>

	</div>
</template>

<script>
const fetch = require('node-fetch');
export default {
	name: 'Art',
	components: { 
		
	},
	data () {
		return {
			artID: this.$route.query.id ? this.$route.query.id : false,
			details: null,
			artType: {},
			nodeCount: 2 // used to align the two timelines with .spacer . Default set to 2 because created and time_period always exist
		}
	},
	mounted() {
		this.loadArtDetails()
	},
	methods: {
		async loadArtDetails () {
			console.log('art idasd', this.artID);
			let res = await fetch(`http://localhost:8000/GetArtAndCreatorDetails?aid=${this.artID}`)
			let art = await res.json()
			console.log(art);
			this.details = art
			switch (this.details.type) {
				case 'Painting':
					this.artType = {"Medium": this.details.medium, "Style": this.details.style}
					break
				case 'Sculpture':
					this.artType = {"Material": this.details.material}
					break
				case 'Literature':
					this.artType = {"Style": this.details.style}
					break
			}
			this.nodeCount += Object.keys(this.artType).length
			console.log('nodecount', this.nodeCount);
		},
	}
}
</script>

<style scoped>
.art {
	background-color: #121212;
}
.timelineEntry {
	text-align: left;
}
.spacer {
	visibility: hidden;
}
</style>
