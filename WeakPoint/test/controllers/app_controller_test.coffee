AppController = require 'controllers/app_controller'
mediator = require 'chaplin/mediator'

describe 'App Controller', ->

  ### this isn't working. sigh...
  jsonFragments =
    ':3333/bucket/': '[ "First" ]'

  beforeEach ->
    @server = sinon.fakeServer.create()
    for url, json in jsonFragments
      @server.respondWith 'GET', url, [
        200,
      , { 'Content-Type': 'application/json' }
      , json
      ]

  afterEach ->
    @server.restore()

  it 'should load the list of available topics from the server', ->

    @server.respond()

    controller = new AppController()
    console.warn mediator.topics
  ###
