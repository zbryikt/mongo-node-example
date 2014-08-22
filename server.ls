require! <[express mongodb body-parser]>
client = mongodb.MongoClient

dbref = {}

client.connect "mongodb://localhost/test", (e, db) ->
  db.collection \counter, (e, c) -> dbref <<< {db, c}

app = express!
app.set 'view engine', 'jade'
app.use body-parser.json!
app.use body-parser.urlencoded extended: true
router = express.Router!

router.get "/api/counter/:id", (req, res) ->
  id = req.params.id
  (e, it) <- dbref.c.findOne {counterid: id}
  if it => 
    it.value++
    dbref.c.update {counterid: id}, {$inc: {value: 1}}, ->
    return res.send("#{it.value}")
  dbref.c.insert {counterid: id, value: 1}, (e,r) ->
  res.send("1")

router.post "/api/order", (req, res) ->
  console.log req.body
  name = req.body.name
  console.log name
  res.send("OK #{name}")

router.get "/", (req, res) -> res.render 'index'
app.use \/, router
server = app.listen 9000, -> console.log "listening at port #{server.address!port}.."
