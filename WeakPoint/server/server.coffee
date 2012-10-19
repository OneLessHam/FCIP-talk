express = require 'express'
sysPath = require 'path'

exports.startServer = (port, path, callback) ->
  base = ''
  server = express()
  server.use (request, response, next) ->
    response.header 'Cache-Control', 'no-cache'
    next()
  server.use base, express.static path
  server.all "#{base}/*", (request, response) ->
    response.sendfile sysPath.join path, 'index.html'
  server.listen port, ->
    console.info "application started on http://localhost:#{port}/"
    callback() if callback
  server

