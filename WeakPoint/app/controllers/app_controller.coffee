Controller = require 'controllers/base/controller'
TopicsCollection = require 'models/topics'
mediator = require 'chaplin/mediator'

module.exports = class AppController extends Controller

  initialize: ->
    if not mediator.topics
      mediator.topics = new TopicsCollection
      mediator.topics.fetch()

    @subscribeEvent 'selectTopic', (title) ->
      mediator.current = mediator.topics.get title

