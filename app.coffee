assets = require 'connect-assets'
express = require 'express'
http = require 'http'

app = express()
server = http.createServer app

publicDir = __dirname + '/public'

app.set 'views', __dirname + '/views'
app.set 'view engine', 'jade'
app.use assets()
app.use express.static publicDir

app.get '/', (req, res) ->
    url = "#{req.protocol}://#{req.get 'host'}"
    res.render 'index', urlroot: url

server.listen 5000
console.log "Express server listening on port %d", server.address().port
