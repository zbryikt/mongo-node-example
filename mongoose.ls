require! <[mongoose]>

db = mongoose.connection
db.on \error, console.error
db.once \open, -> console.log \ok

mongoose.connect "mongodb://localhost/test"
