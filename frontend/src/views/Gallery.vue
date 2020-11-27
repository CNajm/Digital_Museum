<template>
	<div>
		<img alt="logo" src="../assets/dlogo.png">
		<v-row align="center" justify="center">
			<v-col align="center">
				<v-menu
					v-model="queryMenu"
					style="top: -12px"
					offset-y
					:close-on-content-click="false"
				>
					<template v-slot:activator="{ on, attrs }">
						<v-btn
							v-bind="attrs"
							v-on="on"
						>
							<v-icon left>
								mdi-menu
							</v-icon>
							Advanced
						</v-btn>
					</template>
					
					<v-card width="400">
						<v-list>
							<v-list-item>
								<v-list-item-action class="ml-10">
									<v-switch
									v-model="displayMode"
									value="Cards"
									></v-switch>
								</v-list-item-action>
								<v-list-item-title v-text="`View set to ${displayMode == 'Cards' ? 'Cards' : 'Table' }`"></v-list-item-title>
							</v-list-item>

							<v-list-item 
								v-if="displayMode != 'Cards'"
							>
								<v-list-item-content>
									<v-form @submit.prevent="formSubmit" class="text-center" align="center" justify="center">
										<v-select
											label="Query"
											:items="Object.keys(formState.queries)"
											v-model="querySelector"
											outlined
										></v-select>

										<v-select
											v-if="currentFormState.selectCount >= 1"
											:label="currentFormState.select1.label"
											:items="currentFormState.select1.items"
											v-model="select1"
											outlined
										></v-select>

										<v-select
											v-if="currentFormState.selectCount >= 2"
											:label="currentFormState.select2.label"
											:items="currentFormState.select2.items"
											v-model="select2"
											outlined
										></v-select>

										<v-select
											v-if="currentFormState.selectCount >= 3"
											:label="currentFormState.select3.label"
											:items="currentFormState.select3.items"
											v-model="select3"
											outlined
										></v-select>

										<v-select
											v-if="currentFormState.selectCount >= 4"
											:label="currentFormState.select4.label"
											:items="currentFormState.select4.items"
											v-model="select4"
											outlined
										></v-select>
										
										<v-text-field
											v-if="conditionField.state"
											v-model="conditionField.value"
											label="Condition"
											append-icon="mdi-magnify"
											outlined

										>
										</v-text-field>

									</v-form>
								</v-list-item-content>
							</v-list-item>
						</v-list>

						<v-divider></v-divider>
						
						<v-card-actions
							v-if="displayMode != 'Cards'"
						>
							<v-btn
								class="ma-1"
								text
								icon
								color="red lighten-2"
								@click="resetTable"
							>
								<v-icon>mdi-delete</v-icon>
							</v-btn>
							<v-spacer></v-spacer>
							<v-btn
								text
								@click="queryMenu = false"
							>Cancel
							</v-btn>
							<v-btn
								color="primary"
								text
								@click="doQuery();queryMenu = false"
							>Query
							</v-btn>
						</v-card-actions>
					</v-card>
				</v-menu>
			</v-col>
		</v-row>

		<v-container fluid v-if="displayMode == 'Cards'">
			<v-row justify="center">
				<v-col
					v-for="card in arts"
					:key="card.title"
					:cols="card.flex"
				>
					<Art :aid="card.AID" :title="card.name" :src="card.url"></Art>
				</v-col>
			</v-row>
		</v-container>

	<v-container 
		v-if="displayMode != 'Cards'"
		class="tableView"
	>
		<v-data-table class="text-left"
			:headers="headers"
			:items="artsTable"
			disable-pagination
			hide-default-footer
		>
			<template v-slot:item.link="{ item }">
				<v-btn icon :to="item.link">
					<v-icon>mdi-arrow-right</v-icon>
				</v-btn>
			</template>
		</v-data-table>
	</v-container>

	</div>
</template>

<script>
const querystring = require('querystring')
const fetch = require('node-fetch')
import Art from '@/components/ArtCard.vue'

export default {
	name: 'GalleryView',
	components: {
		Art
	},
	data () {
		return {
			displayMode: 'Cards',
			arts: [],
			headers: [
					{ text: 'Art Name', value: 'artname' },
					{ text: ' ', value: 'link', align: 'right' }
				],
			artsTable: [],
			queryMenu: '',
			conditionField: {value: '', state: false},
			querySelector: '',
			select1: '',
			select2: '',
			select3: '',
			select4: '',
			currentFormState: {default: true, selectCount: 0},
			formState: {
				queries: {
					Projection: {
						selectCount: 2,
						select1: { binding: 'table', label: 'Select Table', items: ['Art'], required: true},
						select2: { binding: 'column', label: 'Select Column', items: ['time_period', 'creation_date', 'type', 'style', 'medium'], required: true}
					},

					Selection: {
						selectCount: 3,
						select1: { binding: 'table', label: 'Select Table', items: ['Art'], required: true},
						select2: { binding: 'column', label: 'Select Column', items: ['time_period', 'creation_date', 'type', 'style', 'medium'], required: true},
						select3: { binding: 'operator', label: 'Select Operator', items: ['==', '!=', '>=', '<=', '>', '<'], required: true},
						conditionField: true,
					},
					Join: {
						selectCount: 3,
						select1: { binding: 'table1', label: 'Select Table 1', items: ['Art', 'Creator'], required: true },
						select2: { binding: 'table2', label: 'Select Table 2', items: ['Art', 'Creator'], required: true },
						select3: { binding: 'column', label: 'Select Column', items: ['name', 'born', 'died'], required: true},
					},
					Aggregation: {
						selectCount: 4,
						select1: { binding: 'table', label: 'Select Table', items: ['Art'], required: true },
						select2: { binding: 'column', label: 'Select column', items: ['time_period', 'creation_date', 'type', 'style', 'medium'], required: true },
						select3: { binding: 'function', label: 'Select function', items: ['count', 'avg', 'min', 'max', 'sum'], required: true},
						select4: { binding: 'groupby', label: 'Select Group By', items: ['time_period', 'creation_date', 'type', 'style', 'medium'], required: true},
					},
					NestedAggregation: {
						selectCount: 4,
						select1: { binding: 'column', label: 'Select column', items: ['time_period', 'creation_date', 'type', 'style', 'medium'], required: true },
						select2: { binding: 'function', label: 'Select function', items: ['count', 'avg', 'min', 'max', 'sum'], required: true},
						select3: { binding: 'function2', label: 'Select function 2', items: ['count', 'avg', 'min', 'max', 'sum'], required: true},
						select4: { binding: 'groupby', label: 'Select Group By', items: ['time_period', 'creation_date', 'type', 'style', 'medium'], required: true},
					},

				},
			},
		}
	},
	mounted () {
		console.log(this.defaultHeaders)
		let x = Object.keys(this.formState.queries)
		console.log('YEEEEEEEEE', x)
		console.log(this.formState.queries[x[0]])

		let v = localStorage.getItem('galleryView')
		if (v) this.displayMode = v
		this.loadGallery()
		this.defaultHeaders = JSON.parse(JSON.stringify(this.headers))
	},
	watch: {
		// remember view setting
		displayMode: (val) => {
			localStorage.setItem('galleryView', val)
		},
		querySelector: function (val) {
			// this.currentFormState = {}
			console.log('QUERY SELECTED', val)
			this.currentFormState = this.formState.queries[val]
			this.currentFormState.query = val
			if (this.currentFormState.conditionField) 
				this.conditionField.state = true
			else 
				this.conditionField.state = false
			console.log(this.currentFormState)
		}
	},
	methods: {
		async loadGallery() {
			let res = await fetch(`http://localhost:8000/GetGalleryArt`)
			let art = await res.json()
			this.arts = []
			this.artsTable = []
			for (const i of art) {
				console.log('art', i)
				i.flex = 3
				i.artPage = `/art?id=${i.AID}`
				await this.arts.push(i)
				// {title: i.name, src: i.url, aid: i.AID, flex: 3}
				await this.artsTable.push({artname: i.name, link: i.artPage})

			}
			console.log('ALL', this.arts)
		},
		formSubmit(event) {
				console.log('YEP FORM', event)
				// if (event) event.preventDefault();
				// if (event) event.stopPropagation();
		},
		doQuery() {
			console.log('running query')
			let data = {query: this.currentFormState.query}
			for (let i in this.currentFormState) {
				if (this.currentFormState[i].required) {					
					let v = eval(`this.${i}`)
					if (!v) throw Error(`Missing required ${i}`)
					data[this.currentFormState[i].binding] = v
				}
			}
			console.log(data)
			let url = `http://localhost:8000/GetQuery${data.query}`
			delete data.query
			if (this.currentFormState.conditionField)
				data.condition = this.conditionField.value
			let query = querystring.stringify(data)
			fetch(`${url}?${query}`)
				.then(res => res.json())
				.then(jsonData => {
					console.log('data', jsonData)
					this.updateArts(jsonData)
				})
		},
		updateArts(data_) {
			let isColumnAdded = false
			for (let d of data_) {
				let remove_name = Object.keys(d)
				const index = remove_name.indexOf("artname")
				remove_name.splice(index, 1)

				if (!isColumnAdded) {
					const newHeaders = Array.from(new Set(remove_name))  
					for (let h of newHeaders) {
						this.headers.splice(1, 0, { text: h, value: h })
					}
					isColumnAdded = true
				}
				for (let art in this.artsTable) {
					if (d.artname == this.artsTable[art].artname) {
						console.log('DOES THIS WORK', this.artsTable[art])

						for (const key of remove_name) {
							if (!this.artsTable[art][key])
								this.artsTable[art][key] = d[key]
						}		
					}
				}
			}
		},
		resetTable() {
			console.log('resetting table')
			this.headers = JSON.parse(JSON.stringify(this.defaultHeaders))
			this.loadGallery()
		}
	}
}

</script>

<style scoped>
.tableView {
	max-width: 40%;
}
</style>

