const express = require('express')
const sqlite3 = require('sqlite3')

const app = express()

app.use((req, res, next) => {
	res.setHeader('Access-Control-Allow-Origin', '*')
	res.setHeader('Access-Control-Allow-Credentials', true)
	res.setHeader('Access-Control-Allow-Methods', 'GET, POST, OPTIONS')
	res.setHeader('Access-Control-Allow-Headers', 'X-Requested-With,content-type')
	next()
});

// Routes
app.get('/', (req, res) => {
	let db = new sqlite3.Database('../project.db', sqlite3.OPEN_READWRITE, (err) => {
	if (err) {
		console.error(err.message);
	}
	console.log('connected to the project database.');
	});

	let sql = `SELECT *
				FROM Art`;

	db.all(sql, [], (err, rows) => {
		if (err) {
			throw err;
		}
		rows.forEach((row) => {
			console.log(row.name);
			console.log(row);
		});
	});

	// close the database connection
	db.close();


	res.send("YEP HELLO")
})

app.listen(8000, () => console.log('server running on port 8000'));