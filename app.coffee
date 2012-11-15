express = require 'express'
redis = require 'redis'

app = express()
redisClient = redis.createClient()

app.use express.logger()

app.get "/", (req, res) ->
  redisClient.lrange 'ragots', 0, -1, (err, ragots) ->
    res.render "index.jade", ragots: ragots

app.post '/ragots', (req, res) ->
  redisClient.lpush 'ragots', req.params.ragot, () ->
    res.status 201
    res.end()

app.listen 3000
