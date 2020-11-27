<template>
	<div>
		<img alt="logo" src="../assets/dlogo.png">
		<v-row align="center" justify="center">
			<v-col align="center">
				<v-container class="tableView">
					<v-data-table class="text-left"
						:headers="headers"
						:items="creatorsTable"
						disable-pagination
						hide-default-footer
					>
						<template v-slot:item.delete="{ item }">
							<v-btn icon @click="deleteCreator(item)">
								<v-icon color="red lighten-2">mdi-delete</v-icon>
							</v-btn>
						</template>
					</v-data-table>

					<v-spacer class="py-6"></v-spacer>

					<h3 class="text-left white--text mb-4">Inspirations</h3>
					<v-data-table class="text-left"
						:headers="inspirationHeaders"
						:items="inspirationTable"
						disable-pagination
						hide-default-footer
					>
					</v-data-table>
				</v-container>
			</v-col>
		</v-row>
	</div>
</template>

<script>
export default {
	components: {},
		
	data () {
		return {
			headers: [
					{ text: 'Creator Name', value: 'name' },
					{ text: 'Born', value: 'born' },
					{ text: 'Died', value: 'died' },
					{ text: ' ', value: 'delete', align: 'right' }
				],
			creatorsTable: [],
			inspirationHeaders: [
					{ text: 'Master', value: 'master' },
					{ text: 'Student', value: 'student' }
				],
			inspirationTable: [],
		}
	},
	mounted() {
		this.loadCreatorDetails()
		this.loadInspirationDetails()
	},
	methods: {
		async loadCreatorDetails () {
			let res = await fetch(`http://localhost:8000/GetCreatorDetails`)
			let creators = await res.json()
			for (const c of creators) {
				this.creatorsTable.push({id: c.CID, name: c.name, born: c.born, died: c.died,})

			}
		},
		async loadInspirationDetails () {
			let res = await fetch(`http://localhost:8000/GetInspirationDetails`)
			let insp = await res.json()
			for (const i of insp) {
				this.inspirationTable.push({masterID: i.masterID, studentID: i.studentID, master: i.masterName, student: i.studentName})

			}
		},
		deleteCreator (c) {
			fetch(`http://localhost:8000/DeleteCreator?cid=${c.id}`, {method: 'POST'})
			const index = this.creatorsTable.indexOf(c)
			this.creatorsTable.splice(index, 1)
		}
	}
}
</script>

<style scoped>
.tableView {
	max-width: 60%;
}
</style>
