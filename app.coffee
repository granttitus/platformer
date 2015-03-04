assets = require 'connect-assets'
express = require 'express'
http = require 'http'

app = express()
server = http.createServer app

app.set 'views', __dirname + '/views'
app.set 'view engine', 'jade'
app.use assets()
app.use express.static __dirname + '/public'

app.get '/', (req, res) ->
    res.render 'index'

server.listen 5000
console.log "Express server listening on port #{server.address().port}"
