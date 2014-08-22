require! <[mongodb]>
client = mongodb.MongoClient

client.connect "mongodb://localhost/test", (e, db) ->
  db.collection \test, (e, c) ->
    c.insert {
      name: "blah"
      email: "blah@blah.org"
    }, (e,d) ->
      if d => console.log d
      else => console.log e
      c.findOne {name: "blah"}, (e, d) ->
        console.log d
        if d => console.log d.name
        else => console.log "not found"
