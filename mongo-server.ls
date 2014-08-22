require! <[mongodb]>

 
server = new mongodb.Server \localhost, 27017, {auto_reconnect: true, poolSize: 10}
db = new mongodb.Db("test", server, {safe: true})

db.open ->
  console.log 1
  db.collection \contact, (e, c) ->
    console.log 2
    c.insert {
      name: "blah"
      email: "blah@blah.org"
    }, (e,d) ->
      console.log 3
      if d => console.log d
      else => console.log e
    c.find {name: "blah"}, (e, d) ->
      console.log 4
      if d => console.log d.name
      else => console.log "not found"
    console.log 5
  console.log 6
console.log 7
