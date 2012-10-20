express = require 'express'
sysPath = require 'path'
_ = require 'underscore'

class Bucket
  collection: {}

  respond: (request, response) ->
    if request.params[0]
      data = @collection[request.params]
    else
      data = _.keys @collection

    if data
      response.send JSON.stringify data
    else
      response.send 404, 'Sorry, not found'

exports.startServer = (port, path, callback) ->
  base = ''
  server = express()
  server.use (request, response, next) ->
    response.header 'Cache-Control', 'no-cache'
    next()
  server.use base, express.static path
  server.use express.bodyParser()

  bucket = new Bucket
  server.all "#{base}/bucket/*", (request, response) ->
    switch request.route.method
      when 'get'
        bucket.respond request, response
      when 'post'
        key = request.params[0]
        bucket.collection[key] = request.body
        console.warn 'saved ' + key

        response.send request.body

  server.all "#{base}/*", (request, response) ->
    response.sendfile sysPath.join path, 'index.html'
  server.listen port, ->
    console.info "application started on http://localhost:#{port}/"
    callback() if callback
  server

