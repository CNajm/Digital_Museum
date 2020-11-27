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
												class="mb-0"
											>
												<div>
													<div class="pb-1">
														<strong>{{ key }}</strong>
													</div>
													<div>{{ value }}</div>
												</div>
											</v-timeline-item>

											<v-timeline-item
												v-if="location.name"
												color="brown lighten-2"
												small
											>
												<div>
													<div class="pb-1">
														<strong>Located</strong>
													</div>
													<div>{{ location.name }}
														<v-dialog
															v-if="location.geo"
															v-model="dialog"
															max-width="700"
														>
															<template v-slot:activator="{ on }">
																<v-btn
																	v-on="on"
																	icon
																	class="ml-2 pb-1 "
																	x-small
																>
																	<v-icon style="vertical-align: middle">mdi-open-in-new</v-icon>
																</v-btn>
															</template>
															<v-card>
																<v-card-title class="headline">
																	{{ location.name }}
																</v-card-title>
																<iframe width="600" height="450" :src="location.geo" frameborder="0" style="border:0;filter: invert(00%)" allowfullscreen="" aria-hidden="false" tabindex="0"></iframe>
																<!-- invert 90% for scuffed night mode, real night mode needs an API key -->
																<v-card-actions>
																	<v-spacer></v-spacer>
																	<v-btn
																		color="green darken-1"
																		text
																		@click="dialog = false"
																	>
																		Close
																	</v-btn>
																</v-card-actions>
															</v-card>
														</v-dialog>
													</div>
												</div>
											</v-timeline-item>
										</v-timeline>
									</v-list-item-content>
								</v-list-item>
							</v-card>
						</v-col>

						<v-col cols="6" class="pt-0">
							<v-card class="pb-2" outlined>
								<v-list-item>
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
													color="cyan"
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
										{{ editingDescription ? " - Editing (click again to save)" : ''}}
										<v-btn
											class="ma-1"
											text
											icon
											:color="descriptionColor"
											@click="editingDescription = !editingDescription; updateDescription()"
										>
											<v-icon>mdi-pencil</v-icon>
										</v-btn>
									</div>
									<!-- <v-card-text class="body-1 text-left" v-html="details.description"></v-card-text> -->
									<v-textarea										
										auto-grow
										:filled="editingDescription"
										:readonly="!editingDescription"
										class="px-4"
										flat
										id="textAreaDescription"
										v-model="details.description"
									></v-textarea>
								</v-list-item-content>
							</v-list-item>
						</v-card>
					</v-col>
					<v-btn
						class="ma-1"
						text
						icon
						color="red lighten-2"
						@click="deleteArt()"
					>
						<v-icon>mdi-delete</v-icon>
					</v-btn>
				</v-col>
			</v-row>
		</v-container>
	</div>
</template>

<script>
const querystring = require('querystring')
const fetch = require('node-fetch')

export default {
	name: 'Art',
	components: { 
	},
	data () {
		return {
			artID: this.$route.query.id ? this.$route.query.id : false,
			details: null,
			artType: {},
			nodeCount: 2, // used to align the two timelines with .spacer . Default set to 2 because created and time_period always exist,
			location: {},
			dialog: false,
			descriptionColor: 'red lighten-2',
			editingDescription: false,
		}
	},
	mounted() {
		this.loadArtDetails()
	},
	methods: {
		async loadArtDetails () {
			let res = await fetch(`http://localhost:8000/GetArtAndCreatorDetails?aid=${this.artID}`)
			let art = await res.json()
			console.log(art)
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
			console.log('nodecount', this.nodeCount)

			if (this.details.located) {
				let res = await fetch(`http://localhost:8000/GetMuseumDetails?mid=${this.details.located}`)
				let museum = await res.json()
				this.location.name = `${museum.name}`
				if (museum.country)
					this.location.name += `, ${museum.country}`
				if (museum.geo)
					// Coords by location name
					this.location.geo = `https://maps.google.com/maps?q=${this.location.name}&t=&z=13&ie=UTF8&iwloc=&output=embed`
					// Coords by geo coords
					// let coords = museum.geo.split(',').map(g => g.trim())
				this.nodeCount++
			}
		},
		async updateDescription () {
			if (this.editingDescription) 
				this.descriptionColor = 'green lighten-2'
			else
				this.descriptionColor = 'red lighten-2'
			console.log(this.details.description)
			let query = querystring.stringify({aid: this.artID, desc: this.details.description})
			await fetch(`http://localhost:8000/UpdateArtDetails?${query}`, {method: 'POST'})
		},
		async deleteArt () {
			await fetch(`http://localhost:8000/DeleteArt?aid=${this.artID}`, {method: 'POST'})
			this.$router.push({ name: 'Gallery' })
		}
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
#textAreaDescription .v-input--is-disabled textarea {
	color: white !important;
}
</style>
