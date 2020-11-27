const express = require('express')
const sqlite3 = require('better-sqlite3')
const colors = require('colors') // console colors

const app = express()
var db = false

function dbConnect() {
	db = new sqlite3('../project.db', {fileMustExist: true, verbose: console.log })
	console.log(db);
	if (!db) {		
		console.log("unable to connect");
	}
	else {
		console.log('connected to the project database.');
	}
}

function isNumeric(num){
  return !isNaN(num)
}

//
// DB Functions
// 

function fetchRooms() {
	let sql = db.prepare('SELECT * FROM Room')
	return sql.all()
}

function fetchRoomContents(roomID) {
	let sql = db.prepare('SELECT * FROM Art WHERE inroom=(?)')
	return sql.all(roomID)
}

function fetchRoomPreview(roomID) {
	let sql = db.prepare('SELECT Room.*, Art.url FROM Room INNER JOIN Art ON (Room.RID == Art.inroom) WHERE Room.RID = (?) LIMIT 1')
	return sql.get(roomID)
}

function fetchArtDetails(artID) {
	let sql = db.prepare('SELECT * FROM Art WHERE AID=(?)')
	return sql.get(artID)
}

function fetchArtAndCreatorDetails(artID) {
	let sql = db.prepare('SELECT Art.*, Creator.name as creator_name, Creator.born, Creator.died FROM Art INNER JOIN Creator ON (Art.created_by == Creator.CID) WHERE Art.AID == (?)')
	return sql.get(artID)
}

function fetchCreatorDetails() {
	let sql = db.prepare('SELECT * FROM Creator')
	return sql.all()
}

function fetchInspirationDetails() {
	let sql = db.prepare('SELECT c1.CID as masterID, student as studentID, masterName, c2.name as studentName FROM (SELECT CID, Name as masterName, student FROM Creator INNER JOIN Inspirations ON Inspirations.master == Creator.CID) c1, Creator c2 WHERE c2.CID == student')
	return sql.all()
}

function fetchAllArt() {
	let sql = db.prepare('SELECT * FROM Art')
	return sql.all()
}

function fetchMuseumDetails(museumID) {
	let sql = db.prepare('SELECT * FROM Museum WHERE MID=(?)')
	return sql.get(museumID)
}

function fetchGalleryArt() {
	let sql = db.prepare('SELECT AID, name, url FROM Art')
	return sql.all()
}

function updateArtDetails(artID, newDesc) {
	console.log(artID, newDesc);
	let sql = db.prepare('UPDATE Art SET description=? WHERE AID=?')
	const q = sql.run(newDesc, artID)
	console.log(q)
	return q.changes
}

function deleteArt (artID) {
	let sql = db.prepare('DELETE FROM Art WHERE AID=?')
	const q = sql.run(artID)
	console.log(q)
	return q.changes
}

function deleteCreator (creatorID) {
	let sql = db.prepare('DELETE FROM Creator WHERE CID=?')
	const q = sql.run(creatorID)
	console.log(q)
	return q.changes
}

// 
// User queries
// 
function fetchQuerySelection(table, column, operator, condition) {
	// Vunerable to injections but wasn't able to get dynamic table/column names working
	if (!isNumeric(condition)) condition = `'${condition}'`
	else condition = +condition
	console.log(typeof condition);
	let sql = db.prepare(`SELECT name as artname, ${column} FROM ${table} WHERE ${column} ${operator} ${condition}`)
	return sql.all()
}

function fetchQueryProjection(table, column) {
	let sql = db.prepare(`SELECT name as artname, ${column} FROM ${table}`)
	return sql.all()
}

function fetchQueryJoin(table, table2, column) {
	let sql = db.prepare(`SELECT Art.name as artname, Creator.${column} FROM Art INNER JOIN Creator ON Art.created_by == Creator.CID`)
	return sql.all()
}

function fetchQueryAggregation(table, column, func, groupby) {
	let sql = db.prepare(`SELECT name as artname, ${column}, ${func}(${column}) FROM ${table} GROUP BY ${groupby}`)
	return sql.all()
}

function fetchQueryNestedAggregation(column, func, func2, groupby) {
	let sql = db.prepare(`SELECT name as artname, ${func2}(out) FROM (SELECT *, ${func}(${column}) as out FROM Art GROUP BY ${groupby}) GROUP BY ${groupby}`)
	return sql.all()
}
// 
// --------
// 

app.use((req, res, next) => {
	res.setHeader('Access-Control-Allow-Origin', '*')
	res.setHeader('Access-Control-Allow-Credentials', true)
	res.setHeader('Access-Control-Allow-Methods', 'GET, POST, OPTIONS')
	res.setHeader('Access-Control-Allow-Headers', 'X-Requested-With,content-type')
	next()
});


function logTime(req, res, next) { // logs time and route details with colors
  let now = new Date()
  let status = res.statusCode;
  status = status == 200 ? colors.green(status) : colors.brightRed(status)
  console.log(`${colors.yellow(req.method)}:${colors.brightMagenta(req.url)} ${status}`);
  console.log('Time:'.brightRed, now.toUTCString().yellow)
  next()
}


// Routes

// default logger middleware
app.get('/*', logTime);

app.get('/connect', (req, res) => {
	let out
	db = new sqlite3.Database('../project.db', sqlite3.OPEN_READWRITE, (err) => {
	if (err) {
		console.error(err.message);
		out = "NOPE"
	}
	else {
		console.log('connected to the project database.');
		out = "YEP HELLO"
	}
	res.send(out)
	});
})

app.get('/close', (req, res) => {
	// close the database connection
	console.log('YEP closing db');
	db.close();
	res.send('CLOSED')
})

app.get('/GetAllRooms', (req, res) => {
	let rooms = fetchRooms()
	return res.status(200).send(rooms)
})

app.get('/GetRoomContents', (req, res) => {
	let rid = req.query.rid
	let rcontent = fetchRoomContents(rid)
	return res.status(200).send(rcontent)
})

app.get('/GetRoomPreview', (req, res) => {
	let rid = req.query.rid
	let preview = fetchRoomPreview(rid)
	return res.status(200).send(preview)
})

app.get('/GetArtDetails', (req, res) => {
	let aid = req.query.aid
	let details = fetchArtDetails(aid)
	return res.status(200).send(details)
})

app.get('/GetArtAndCreatorDetails', (req, res) => {
	let aid = req.query.aid
	let details = fetchArtAndCreatorDetails(aid)
	return res.status(200).send(details)
})

app.get('/GetCreatorDetails', (req, res) => {	
	let details = fetchCreatorDetails()
	return res.status(200).send(details)
})

app.get('/GetInspirationDetails', (req, res) => {	
	let details = fetchInspirationDetails()
	return res.status(200).send(details)
})

app.get('/GetAllArt', (req, res) => {
	let art = fetchAllArt()
	return res.status(200).send(art)
})

app.get('/GetMuseumDetails', (req, res) => {
	let mid = req.query.mid
	let details = fetchMuseumDetails(mid)
	return res.status(200).send(details)
})

app.get('/GetGalleryArt', (req, res) => {
	let art = fetchGalleryArt()
	return res.status(200).send(art)
})

app.post('/UpdateArtDetails', (req, res) => {
	let aid = req.query.aid
	let desc = req.query.desc
	let q = updateArtDetails(aid, desc)
	return res.sendStatus(200)
})

app.post('/DeleteArt', (req, res) => {
	let aid = req.query.aid
	let q = deleteArt(aid)
	return res.sendStatus(200)
})

app.post('/DeleteCreator', (req, res) => {
	let cid = req.query.cid
	let q = deleteCreator(cid)
	return res.sendStatus(200)
})

//
// User query routes
// 
app.get('/GetQuerySelection', (req, res) => {
	let r = req.query
	let [table, column, operator, condition] = [r.table, r.column, r.operator, r.condition]
	let selection = fetchQuerySelection(table, column, operator, condition)
	return res.status(200).send(selection)
})

app.get('/GetQueryProjection', (req, res) => {
	let r = req.query
	let [table, column] = [r.table, r.column]
	let projection = fetchQueryProjection(table, column)
	return res.status(200).send(projection)
})

app.get('/GetQueryJoin', (req, res) => {
	let r = req.query
	let [table, table2, column] = [r.table, r.table2, r.column]
	let join = fetchQueryJoin(table, table2, column)
	return res.status(200).send(join)
})

app.get('/GetQueryAggregation', (req, res) => {
	let r = req.query
	let [table, column, func, groupby] = [r.table, r.column, r.function, r.groupby]
	let aggregation = fetchQueryAggregation(table, column, func, groupby)
	return res.status(200).send(aggregation)
})

app.get('/GetQueryNestedAggregation', (req, res) => {
	let r = req.query
	let [column, func, func2, groupby] = [r.column, r.function, r.function2, r.groupby]
	let naggregation = fetchQueryNestedAggregation(column, func, func2, groupby)
	return res.status(200).send(naggregation)
})

// art route
app.get('/art', (req, res) => {
	let id = req.query.id
	if (id) {
		console.log('GET art:id', id);
	
		let sql = db.prepare('SELECT * FROM Art WHERE aid=(?)', id)
		sql.get((err, row) => {
			if (err) {
				throw err;
			}
			data = row ? row : '{"error": 404, "info": "ID not found"}'
			res.send(data)
			return
		});
	}
	else 
		res.send('{"error": 400, "info": "ID field missing"}')
})

dbConnect()
app.listen(8000, () => console.log('server running on port 8000'));
