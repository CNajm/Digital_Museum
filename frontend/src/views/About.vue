<template>
	<div class="about text-left">
		<v-card
			class="mx-auto mt-7"
			max-width="844"
			outlined
		>
			<v-list-item three-line>
				<v-list-item-content>
					<div class="overline mb-4 pb-0">
						CPSC 2221<br />
						Project: Implementation of a Relational Database
					</div>
					<v-list-item-title class="headline mb-1">The Digital Museum</v-list-item-title>
					<v-list-item-subtitle class="mt-4 ml-1">Char Najm</v-list-item-subtitle>
				</v-list-item-content>
					<v-list-item-avatar
						size="180"
					>
					<v-img src="@/assets/dlogo.png"></v-img>
				</v-list-item-avatar>
			</v-list-item>
		</v-card>
		<v-card
			class="mx-auto mt-7 mb-7 pb-3"
			max-width="844"
			outlined
		>
			<v-list dense>
				<v-subheader class="mx-3">Frontend</v-subheader>
				<v-list-item>
					<v-list-item-icon>
						<v-icon>mdi-vuejs</v-icon>
					</v-list-item-icon>
					<v-list-item-content>
						<v-list-item-title>Vue</v-list-item-title>
					</v-list-item-content>
				</v-list-item>

				<v-list-item>
					<v-list-item-icon>
						<v-icon>mdi-vuetify</v-icon>
					</v-list-item-icon>
					<v-list-item-content>
						<v-list-item-title>Vuetify</v-list-item-title>
					</v-list-item-content>
				</v-list-item>
			</v-list>
			<v-list dense>
				<v-subheader class="mx-3">Backend</v-subheader>
				<v-list-item>
					<v-list-item-icon>
						<v-icon>mdi-nodejs</v-icon>
					</v-list-item-icon>
					<v-list-item-content>
						<v-list-item-title>Express</v-list-item-title>
					</v-list-item-content>
				</v-list-item>
			</v-list>
			<v-list dense>
				<v-subheader class="mx-3">SQL Engine</v-subheader>
				<v-list-item>
					<v-list-item-icon>
						<v-icon>mdi-database-search</v-icon>
					</v-list-item-icon>
					<v-list-item-content>
						<v-list-item-title>SQLite</v-list-item-title>
					</v-list-item-content>
				</v-list-item>
			</v-list>
			<v-list dense>
				<v-subheader class="mx-3">Repo</v-subheader>
				<v-list-item href="https://gitlab.com/cnajm/2210_digital_museum" target="_blank">
					<v-list-item-icon>
						<v-icon
						color="orange"
						>mdi-git</v-icon>
					</v-list-item-icon>
					<v-list-item-content>
						<v-list-item-title>SQLite</v-list-item-title>
					</v-list-item-content>
				</v-list-item>
			</v-list>
		</v-card>
	</div>
</template>

<script>
export default {
	name: 'Aboot'
}
</script>
